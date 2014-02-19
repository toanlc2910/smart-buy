﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SmartB.UI.Models.EntityFramework;
using System.Data.Entity;
using SmartB.UI.Models;
using SmartB.UI.UploadedExcelFiles;
using System.Web.Script.Serialization;
using SmartB.UI.Areas.Admin.Helper;
using PagedList;

namespace SmartB.UI.Controllers
{
    public class ProductController : Controller
    {
        //
        // GET: /Product/
        private SmartBuyEntities db = new SmartBuyEntities();
        public ActionResult SearchProduct(String q)
        {
            if (!String.IsNullOrEmpty(q))
            {
                var products = db.ProductAttributes.Include(x => x.Product).Where(s => s.Product.Name.Contains(q));
                return View(products);
            }

            else
            {
                return View();
            }
        }

        public ActionResult ViewCart()
        {
            return View();
        }

        public ActionResult UploadProduct()
        {
            ViewBag.countInsert = TempData["InsertMessage"] as string;
            ViewBag.countUpdate = TempData["UpdateMessage"] as string;
            return View();
        }

        [HttpPost]
        public ActionResult UploadProduct(HttpPostedFileBase excelFile, int? page)
        {
            
            if (excelFile != null)
            {
                Guid guid = Guid.NewGuid();
                string savedFileName = "~/UploadedExcelFiles/" + guid + excelFile.FileName;
                excelFile.SaveAs(Server.MapPath(savedFileName));

                ExcelHelper excelHelper = new ExcelHelper();
                List<SellProductModel> sellProductCollection = new List<SellProductModel>();
                List<SellProductModel> sellProductCorrectCollection = new List<SellProductModel>();
                List<SellProductModel> sellProductErrorCollection = new List<SellProductModel>();
                ListSellProductModel model = new ListSellProductModel();
                //Catch exception 

                string errorName = "";
                string errorMarket = "";
                string errorPrice = "";
                int errorCount = 0; 
                try
                {
                    //sellProductCollection = excelHelper.ReadData((Server.MapPath(savedFileName)), out errorName, out errorMarket, out errorPrice, out errorCount);
                    sellProductCorrectCollection = excelHelper.ReadDataCorrect((Server.MapPath(savedFileName)));
                    sellProductErrorCollection = excelHelper.ReadDataError((Server.MapPath(savedFileName)), out errorName, out errorMarket, out errorPrice, out errorCount);
                    //ViewBag.sellProductCollection = sellProductCollection;
                    ViewBag.sellProductCorrectCollection = sellProductCorrectCollection;
                    model.CorrectSellProducts = sellProductCorrectCollection;
                    model.InCorrectSellProducts = sellProductErrorCollection;
                    ViewBag.ExceptionName = errorName;
                    ViewBag.ExceptionMarket = errorMarket;
                    ViewBag.ExceptionPrice = errorPrice;
                    ViewBag.errorCount = errorCount;
                    ViewBag.InCorrectSellProductsCount = sellProductErrorCollection.Count();
                    ViewBag.CorrectSellProductsCount = sellProductCorrectCollection.Count();
                    TempData["CorrectProducts"] = sellProductCorrectCollection;
                    Session["CorrectProducts"] = sellProductCorrectCollection;
                    ViewBag.Test = "test";
                }
                catch (Exception exception)
                {
                    ViewBag.Exception = exception.Message;
                    ViewBag.ExceptionName = exception.Message;
                    ViewBag.ExceptionMarket = exception.Message;
                    ViewBag.ExceptionPrice = errorPrice;
                    ViewBag.errorCount = errorCount;
                }
                return View(model);
            }            
            return View();
        }

        [HttpPost]
        public ActionResult SaveProducts(ListSellProductModel model)
        {
            model.CorrectSellProducts = (List<SellProductModel>)Session["CorrectProducts"];
            var errors = ModelState.Values.Where(x => x.Errors.Count > 0);
                //Trạng thái khi lưu xuống db
                int countUpdate = 0;
                int countInsert = 0;
                foreach (var product in model.CorrectSellProducts)
                {
                    SmartBuyEntities db = new SmartBuyEntities();

                    //Trùng data
                    var productNameFirst = product.Name.Split(';').First(); // Cắt chuỗi 
                    var dupMarket = db.Markets.Where(m => m.Name.Equals(product.MarketName)).FirstOrDefault();
                    var dupProduct = db.Products.Where(p => p.Name.Equals(productNameFirst)).FirstOrDefault();
                    
                    if (dupMarket != null & dupProduct != null)
                    {
                        var sellProduct = db.SellProducts.Where(s => s.ProductId == dupProduct.Id && s.MarketId == dupMarket.Id).FirstOrDefault();
                        // Check sellProduct có trùng không??
                        if (sellProduct == null)
                        {
                            var sellProduct1 = new SmartB.UI.Models.EntityFramework.SellProduct //add SellProduct
                            {
                                Market = dupMarket,
                                Product = dupProduct,
                                SellPrice = product.Price,
                                LastUpdatedTime = DateTime.Now
                            };
                            var addedSellProduct = db.SellProducts.Add(sellProduct1);
                           
                            countInsert++;
                            db.SaveChanges(); // Save to database
                        }
                        else
                        {
                            if (sellProduct.SellPrice != product.Price)
                            {
                                sellProduct.SellPrice = product.Price;
                                countUpdate++;
                            }
                            else
                            {
                                sellProduct.SellPrice = product.Price;
                            }                            
                        }
                        // Cập nhật giá Min, Max
                        var dupProductAtt = db.ProductAttributes.Where(p => p.ProductId.Equals(dupProduct.Id)).FirstOrDefault();
                        if (product.Price < dupProductAtt.MinPrice)
                        {
                            dupProductAtt.MinPrice = product.Price;
                        }
                        else if (product.Price > dupProductAtt.MaxPrice)
                        {
                            dupProductAtt.MaxPrice = product.Price;
                        } 
                        db.SaveChanges(); // Save to database
                    }
                    else if (dupMarket != null & dupProduct == null) // Trùng Market
                    {
                        var newProduct = new SmartB.UI.Models.EntityFramework.Product // add Product
                        {
                            Name = productNameFirst,
                            IsActive = true,
                        };
                        var addedProduct = db.Products.Add(newProduct);
                        //add new product Attribute                       
                            var productAttribute = new SmartB.UI.Models.EntityFramework.ProductAttribute
                            {
                                ProductId = product.Id,
                                MinPrice = product.Price,
                                MaxPrice = product.Price,
                                LastUpdatedTime = DateTime.Now,
                            };
                            var addedProductAtt = db.ProductAttributes.Add(productAttribute);
                        
                        var sellProduct = new SmartB.UI.Models.EntityFramework.SellProduct //add SellProduct
                        {
                            Market = dupMarket,
                            Product = newProduct,
                            SellPrice = product.Price,
                            LastUpdatedTime = DateTime.Now
                        };
                        var addedSellProduct = db.SellProducts.Add(sellProduct);
                        countInsert++;
                        db.SaveChanges(); // Save to database
                    }
                    else if (dupMarket == null & dupProduct != null) // Trùng Tên sản phẩm
                    {
                        var dupProductAtt = db.ProductAttributes.Where(p => p.ProductId.Equals(dupProduct.Id)).FirstOrDefault();
                        if (product.Price < dupProductAtt.MinPrice)
                        {
                            dupProductAtt.MinPrice = product.Price;
                        } else if (product.Price > dupProductAtt.MaxPrice)
                        {
                            dupProductAtt.MaxPrice = product.Price;
                        }   
                        var market = new Market
                        {
                            Name = product.MarketName,
                            IsActive = true,
                        };
                        var newMarket = db.Markets.Add(market); //add market

                        var sellProduct = new SmartB.UI.Models.EntityFramework.SellProduct
                        {
                            Market = newMarket,
                            Product = dupProduct,
                            SellPrice = product.Price,
                            LastUpdatedTime = DateTime.Now
                        };
                        var addedSellProduct = db.SellProducts.Add(sellProduct); // Add SellProduct
                        countInsert++;
                        db.SaveChanges(); // Save to database
                    }
                    else  //Insert sellProduct mới
                    { 
                        var market = new Market
                        {
                            Name = product.MarketName,
                            IsActive = true,
                        };
                        var newMarket = db.Markets.Add(market); //add market

                        var newProduct = new SmartB.UI.Models.EntityFramework.Product
                        {
                            Name = productNameFirst,
                            IsActive = true,
                        };
                        var addedProduct = db.Products.Add(newProduct); // add product

                        var sellProduct = new SmartB.UI.Models.EntityFramework.SellProduct
                        {
                            Market = newMarket,
                            Product = addedProduct,
                            SellPrice = product.Price,
                            LastUpdatedTime = DateTime.Now
                        };
                        var addedSellProduct = db.SellProducts.Add(sellProduct); // add sellProduct  
                        //add product Attribute
                        var dupProductAtt = db.ProductAttributes.Where(p => p.ProductId.Equals(sellProduct.ProductId)).FirstOrDefault();
                        if (dupProductAtt == null) //không trùng productAtt thì thêm mới
                        {
                            var productAttribute = new SmartB.UI.Models.EntityFramework.ProductAttribute
                            {
                                ProductId = product.Id,
                                MinPrice = product.Price,
                                MaxPrice = product.Price,
                                LastUpdatedTime = DateTime.Now,
                            };
                            var addedProductAtt = db.ProductAttributes.Add(productAttribute);
                        }
                        else
                        {
                            if (product.Price < dupProductAtt.MinPrice)
                            {
                                dupProductAtt.MinPrice = product.Price;
                            }
                            else if (product.Price > dupProductAtt.MaxPrice)
                            {
                                dupProductAtt.MaxPrice = product.Price;
                            }
                            db.SaveChanges(); // Save to database
                        }
                        countInsert++;
                        db.SaveChanges(); // Save to database
                    }
                }
                
                TempData["UpdateMessage"] = "Có " + countUpdate + " sản phẩm được cập nhật giá.";
                TempData["InsertMessage"] = "Có " + countInsert + " sản phẩm được lưu mới.";
            return RedirectToAction("UploadProduct");
        }

        [HttpGet, ActionName("SaveCart")]
        public JsonResult SaveCart(String listCartHistory)
        {
            var check = false;
            JavaScriptSerializer ser = new JavaScriptSerializer();
            List<CartHistory> dataList = ser.Deserialize<List<CartHistory>>(listCartHistory);
            try
            {
                for (int i = 0; i < dataList.Count; i++)
                {
                    var username = dataList[i].Username;
                    var pid = dataList[i].ProductId;
                    var now = DateTime.Now.Date;
                    var dupHistory = db.Histories.Where(his => his.Username == username &&
                        his.ProductId == pid && his.BuyTime == now).FirstOrDefault();
                    if (dupHistory == null)
                    {
                        var h = new History();
                        h.Username = username;
                        h.ProductId = pid;
                        h.BuyTime = now;

                        db.Histories.Add(h);
                    }
                }
                db.SaveChanges();
                check = true;
                return Json(check, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return Json(check, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult SaveProductError(string ProductId, string ProductName, string ProductMarketName, int ProductPrice)
        {
            List<string> error = new List<string>();
            if (ProductName.Length < 5 || ProductName.Length > 100)
            {
                error.Add("Tên sản phẩm phải từ 5 đến 100 ký tự"); 
            }
            if (ProductMarketName.Length < 5 || ProductMarketName.Length > 20)
            {
                error.Add("Tên chợ phải từ 5 đến 20 ký tự");
            }
            if (ProductPrice < 1 || ProductPrice > 10000)
            {
                error.Add("Giá phải từ 1 đến 10000");
            }
            var correctProducts = (List<SellProductModel>)Session["CorrectProducts"];
           
            if (correctProducts.Any(x => x.Name == ProductName && x.MarketName == ProductMarketName)) {
                error.Add("Sản phẩm đã có.");
            }

            if (error.Count == 0) {
                //var correctProducts = (List<SellProductModel>)TempData["CorrectProducts"];
                

                SellProductModel model = new SellProductModel();
                model.Name = ProductName;
                model.MarketName = ProductMarketName;
                model.Price = ProductPrice;

                correctProducts.Add(model);
                Session["CorrectProducts"] = correctProducts;
            }
                
            return Json(error);
        }

        //private static List<string> WordLetterPair(string str) 
        //{
        //    var allPairs = new List<string>();
        //    string[] words = str.Split(';');
        //    words.FirstOrDefault();
        //    return allPairs;
        //} 
    }
}