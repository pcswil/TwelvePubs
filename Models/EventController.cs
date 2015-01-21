using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;

namespace Christoc.Modules.TwelvePubs.Models
{
    public class EventController
    {
        public IList<Events> GetEvent(int EventID)
        {
            return CBO.FillCollection<Events>(DataProvider.Instance().ExecuteReader("TwelvePubs_GetEvent", EventID));
        }

        public void AddEvent(Events events)
        {
            events.EventID = DataProvider.Instance().ExecuteScalar<int>("TwelvePubs_AddEvent",events.Name,events.Date,events.StartTime,events.EndTime,events.City,events.Latitude,events.Longitude,events.Organiser);
        }


    }
}