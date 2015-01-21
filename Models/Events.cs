using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Christoc.Modules.TwelvePubs.Models
{
    public class Events
    {
        public int EventID { get; set; }
        public string Name { get; set; }
        public DateTime Date { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public string City { get; set; }
        public string Latitude { get; set; }
        public string Longitude { get; set; }
        public string Organiser { get; set; }
    }
}