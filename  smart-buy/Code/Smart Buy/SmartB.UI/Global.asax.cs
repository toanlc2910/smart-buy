﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using SmartB.UI.App_Start;
using SmartB.UI.Binder;
using SmartB.UI.Models;

namespace SmartB.UI
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            AuthConfig.RegisterAuth();

            ConstantConfig.Register(Server);

            ModelBinders.Binders.Add(typeof(Cart), new CartModelBinder());

            //MarketHelper.CalculateDistance();

            BackgroundConfig.StartScheduler();
            BackgroundConfig.ScheduleParser();
            //BackgroundConfig.ScheduleDistanceService();
        }
    }
}