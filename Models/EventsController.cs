using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;

namespace Christoc.Modules.TwelvePubs.Models
{
    public class EventsController
    {
        public IList<Events> GetEvents()
        {
            return CBO.FillCollection<Events>(DataProvider.Instance().ExecuteReader("TwelvePubs_GetEvents"));
        }

        
    }
}