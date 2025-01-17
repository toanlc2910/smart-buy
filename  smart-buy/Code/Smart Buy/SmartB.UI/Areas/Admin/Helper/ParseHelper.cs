﻿using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using HtmlAgilityPack;
using SmartB.UI.Areas.Admin.Models;
using SmartB.UI.Helper;
using SmartB.UI.Infrastructure;
using SmartB.UI.Models.EntityFramework;

namespace SmartB.UI.Areas.Admin.Helper
{
    public static class ParseHelper
    {
        public static void LoadWeb(string parseLink)
        {
            // Create Firefox browser
            var web = new HtmlWeb { UserAgent = "Mozilla/5.0 (Windows NT 6.1; rv:26.0) Gecko/20100101 Firefox/26.0" };

            // Load website
            var document = web.Load(parseLink);

            // Correct links
            var src = new List<HtmlNode>(document.DocumentNode.Descendants().Where(x => x.Attributes["src"] != null));
            var link = new List<HtmlNode>(document.DocumentNode.Descendants().Where(x => x.Attributes["href"] != null));
            CorrectLink(src, parseLink, "src");
            CorrectLink(link, parseLink, "href");

            // TODO: Remove all script?
            document.DocumentNode.Descendants().Where(x => x.Name == "script").ToList().ForEach(x => x.Remove());

            string fileName = "tmp.html";
            string path = Path.Combine(ConstantManager.SavedPath, fileName);
            document.Save(path, new UTF8Encoding());
        }

        private static void CorrectLink(List<HtmlNode> nodes, string url, string attName)
        {
            Uri uri = new Uri(url);
            string host = uri.GetLeftPart(UriPartial.Authority);
            string path = uri.AbsolutePath;
            if (path.EndsWith(".aspx") || path.EndsWith(".html") || path.EndsWith(".htm"))
            {
                path = path.Substring(0, path.LastIndexOf('/'));
            }

            foreach (HtmlNode node in nodes)
            {
                if (node.Attributes[attName] != null && !node.Attributes[attName].Value.StartsWith("http"))
                {
                    string tmp = node.Attributes[attName].Value;
                    if (tmp.StartsWith("/"))
                    {
                        tmp = host + tmp;
                        node.Attributes[attName].Value = tmp;
                        continue;
                    }
                    if (path.Length > 1)
                    {
                        tmp = host + "/" + path + "/" + tmp;
                    }
                    else
                    {
                        tmp = host + "/" + tmp;
                    }
                    while (tmp.IndexOf("//") > 0)
                    {
                        tmp = tmp.Replace("//", "/");
                    }
                    tmp = tmp.Replace("http:/", "http://");
                    node.Attributes[attName].Value = tmp;
                }
            }
        }

        public static void ParseData()
        {
            ConstantManager.IsParserRunning = true;

            // Stopwatch to measure elapsed time
            var stopwatch = new Stopwatch();

            // Store parsing info
            var logInfos = new List<LogInfo>();

            // Create Firefox browser
            var web = new HtmlWeb { UserAgent = "Mozilla/5.0 (Windows NT 6.1; rv:26.0) Gecko/20100101 Firefox/26.0" };

            using (var context = new SmartBuyEntities())
            {
                var info = context.ParseInfoes.Where(x => x.IsActive);
                foreach (var parseInfo in info)
                {
                    stopwatch.Start();

                    var data = GetData(web, parseInfo);

                    stopwatch.Stop();

                    var log = new LogInfo
                                  {
                                      Link = parseInfo.ParseLink,
                                      ElapsedTime = stopwatch.Elapsed.Milliseconds,
                                      TotalItems = data.Count,
                                      ToDatabase = InsertProductToDb(data, parseInfo.MarketId.Value)
                                  };

                    logInfos.Add(log);
                    stopwatch.Reset();
                }
            }
            LogFileHelper.GenerateLogFile(logInfos);
            ConstantManager.IsParserRunning = false;
        }

        private static List<KeyValuePair<string, string>> GetData(HtmlWeb web, ParseInfo info)
        {
            var data = new List<KeyValuePair<string, string>>();

            Uri uri = new Uri(info.ParseLink);
            string host = uri.GetLeftPart(UriPartial.Authority);

            // Load website
            try
            {
                // First page
                HtmlDocument doc = web.Load(info.ParseLink);
                data = MatchData(doc, info.ProductNameXpath, info.PriceXpath);

                // Other pages
                if (info.PagingXpath != null)
                {
                    var pages = doc.DocumentNode.SelectNodes(info.PagingXpath);
                    foreach (var page in pages)
                    {
                        int pageNumber;
                        if (page == null || !Int32.TryParse(page.InnerText, out pageNumber))
                        {
                            break;
                        }

                        // Get address
                        string url = host + page.Attributes["href"].Value;

                        // Load page
                        doc = web.Load(url);

                        // Get data
                        var tmp = MatchData(doc, info.ProductNameXpath, info.PriceXpath);

                        // Add to collection
                        data.AddRange(tmp);
                    }
                }
            }
            catch (Exception)
            {
                return data;
            }
            return data;
        }

        private static List<KeyValuePair<string, string>> MatchData(HtmlDocument doc, string nameXpath, string priceXpath)
        {
            var data = new List<KeyValuePair<string, string>>();
            int miss = 0;
            var i = 1;
            while (true)
            {
                // Replace XPath
                string namei = nameXpath.Replace("[i]", ")[" + i + "]");
                namei = "(" + namei;
                string pricei = priceXpath.Replace("[i]", ")[" + i + "]");
                pricei = "(" + pricei;

                // Get pair of data
                var name = doc.DocumentNode.SelectSingleNode(namei);
                var price = doc.DocumentNode.SelectSingleNode(pricei);

                // Got it?
                if (name != null && price != null)
                {
                    miss = 0;

                    // Has data?
                    if (name.InnerText != "" && price.InnerText != "")
                    {
                        var pair = new KeyValuePair<string, string>(name.InnerText, price.InnerText);
                        data.Add(pair);
                    }
                }

                // Get all?
                if (name == null && price == null)
                {
                    miss++;
                }
                if (miss > 1)
                {
                    break;
                }
                i++;
            }
            return data;
        }

        private static int ConvertPrice(string price)
        {
            string result = "";
            int count = 0;
            foreach (char c in price)
            {
                if (Char.IsDigit(c))
                {
                    result += c;
                    count++;
                }
                if (!Char.IsDigit(c) && count > 1 && !Char.IsWhiteSpace(c) && c != '.')
                {
                    break;
                }
            }
            double tmp = Double.Parse(result);
            tmp = Math.Round(tmp/1000);
            return (int) tmp;
        }

        private static int InsertProductToDb(IEnumerable<KeyValuePair<string, string>> data, int marketId)
        {
            int success = 0;
            var helper = new PriceHelper();

            using (var context = new SmartBuyEntities())
            {
                foreach (var pair in data)
                {
                    // Convert price to integer
                    int price = ConvertPrice(pair.Value);

                    // Check product existent
                    var goodMatch = new List<int>();
                    var averageMatch = new List<int>();
                    int pId = -1;
                    bool wholeMatch = false;
                    foreach (var dictionary in context.Dictionaries)
                    {
                        if (pair.Key == dictionary.Name)
                        {
                            wholeMatch = true;
                            pId = dictionary.ProductId.Value;
                            break;
                        }
                        double match = CompareStringHelper.CompareString(pair.Key, dictionary.Name);
                        
                        if (match > 0.9)
                        {
                            // Good match
                            goodMatch.Add(dictionary.ProductId.Value);
                        } 
                        else if (match > 0.7)
                        {
                            // Average match
                            averageMatch.Add(dictionary.ProductId.Value);
                        }
                    }

                    if (!wholeMatch)
                    {
                        if (goodMatch.Count == 1)
                        {
                            // Match well with only 1 product, take it
                            pId = goodMatch[0];
                        }
                        else if (goodMatch.Count > 1)
                        {
                            // Match well with more than 1 product, admin decide
                            ExportTrainingFile(goodMatch, pair.Key);
                            continue;
                        }
                        else if (averageMatch.Count > 0 && pId == -1)
                        {
                            // Only average match, admin decide
                            ExportTrainingFile(averageMatch, pair.Key);
                            continue;
                        }
                    }

                    // Already existed?
                    if (pId != -1)
                    {
                        // Insert new price
                        var sell = new SellProduct
                                       {
                                           MarketId = marketId,
                                           ProductId = pId,
                                           SellPrice = price,
                                           LastUpdatedTime = DateTime.Now
                                       };
                        context.SellProducts.Add(sell);
                        try
                        {
                            context.SaveChanges();
                            helper.CalculatePriceRange(pId);
                            success++;
                        }
                        catch (DbUpdateException)
                        {
                            // Do nothing
                        }
                    }
                    else
                    {
                        // Add new product to database
                        var newProduct = new Product {Name = pair.Key, IsActive = true};

                        // Create new attribute
                        var attribute = new ProductAttribute
                        {
                            MinPrice = price,
                            MaxPrice = price,
                            LastUpdatedTime = DateTime.Now
                        };
                        newProduct.ProductAttributes.Add(attribute);

                        // Add product selling information
                        var sell = new SellProduct
                                       {
                                           MarketId = marketId,
                                           SellPrice = price,
                                           LastUpdatedTime = DateTime.Now
                                       };
                        newProduct.SellProducts.Add(sell);

                        context.Products.Add(newProduct);

                        try
                        {
                            context.SaveChanges();
                            success++;

                            // Add to dictionary
                            var dictionary = new Dictionary
                                                 {
                                                     Name = newProduct.Name,
                                                     ProductId = newProduct.Id
                                                 };
                            context.Dictionaries.Add(dictionary);
                            context.SaveChanges();
                        }
                        catch (DbUpdateException)
                        {
                            // Do nothing
                        }
                    }
                }
            }
            return success;
        }

        private static void ExportTrainingFile(List<int> match, string name)
        {
            List<string> data = ReadDataFromFile();
            string path = ConstantManager.TrainingFilePath;
            string content = "";

            using (var context = new SmartBuyEntities())
            {
                foreach (int id in match)
                {
                    var product = context.Products.FirstOrDefault(x => x.Id == id);
                    if (product != null)
                    {
                        content += product.Name + ";";
                    }
                }
            }

            content += name;

            bool isExisted = false;
            foreach (var item in data)
            {
                if (item == content)
                {
                    isExisted = true;
                    break;
                }
            }

            if (!isExisted)
            {
                using (StreamWriter writer = File.AppendText(path))
                {
                    writer.WriteLine(content);
                }
            }
        }

        private static List<string> ReadDataFromFile()
        {
            string path = ConstantManager.TrainingFilePath;
            var result = new List<string>();
            string line;

            var reader = new StreamReader(path);
            while ((line = reader.ReadLine()) != null)
            {
                result.Add(line);
            }
            reader.Close();
            return result;
        }
    }
}