using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Net;
using System.Net.Http;
using System.Web.Http;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Users;
using DotNetNuke.Web.Api;
using DotNetNuke.Security;

namespace Christoc.Modules.TwelvePubs.Models
{
    public class TwelvePubsEventController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage HelloWorld()
        {
            return Request.CreateResponse(HttpStatusCode.OK, "Hello World.");
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetEvents()
        {
            try
            {
                var events = new EventsController().GetEvents().ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, events);

            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetEvent(int EventID)
        {
            try
            {
                var eventID = new EventController().GetEvent(EventID).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, eventID);

            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class EventToCreateDTO
        {
            public string ETC_Name { get; set; }
            public DateTime ETC_Date { get; set; }
            public DateTime ETC_StartTime { get; set; }
            public DateTime ETC_EndTime { get; set; }
            public string ETC_City { get; set; }
            public float ETC_Latitude { get; set; }
            public float ETC_Longitude { get; set; }
            public string ETC_Organiser { get; set; }
        }
        [DnnModuleAuthorize(AccessLevel = SecurityAccessLevel.View)]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage AddEvent(EventToCreateDTO DTO)
        {
            try
            {
                var events = new Events()
                {
                    Name = DTO.ETC_Name,
                    Date = DTO.ETC_Date,
                    StartTime = DTO.ETC_StartTime,
                    EndTime = DTO.ETC_EndTime,
                    City = DTO.ETC_City,
                    Latitude = DTO.ETC_Latitude,
                    Longitude = DTO.ETC_Latitude,
                    Organiser = DTO.ETC_Organiser
                };
                EventController ec = new EventController();
                ec.AddEvent(events);
                return Request.CreateResponse(HttpStatusCode.OK);

            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);

            }
        }
    }

}