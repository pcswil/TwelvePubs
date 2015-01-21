using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Web.Api;

namespace Christoc.Modules.TwelvePubs.Models
{
     public class RouteMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("TwelvePubs", "default", "{controller}/{action}", new[] { "Christoc.Modules.TwelvePubs.Models" });
        }
    }
}