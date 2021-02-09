using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PatientManagementWebAPI.Models
{
    public class Patient_Detail_Master
    {
        public int PATIENT_ID { get; set; }
        public string Salutation { get; set; }
        public string Name { get; set; }
        public string Gender { get; set; }
        public DateTime DOB { get; set; }
        public int Age { get; set; }
        public string Age_Type { get; set; }
        public string Phone_Number { get; set; }
        public string Address { get; set; }
        public string Billing_Details { get; set; }
        public DateTime Appointment_Date { get; set; }
        public string Address_2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Postal { get; set; }
        public string Country { get; set; }
        public XmlSiteMapProvider scan_dtls { get; set; }
    }
}