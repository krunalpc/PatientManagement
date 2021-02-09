using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PatientManagementWebAPI.Models
{
    public class Patient_Detail_View_Appointment
    {
        public int PATIENT_ID { get; set; }
        public string Name { get; set; }
        public string Gender { get; set; }
        public int Age { get; set; }
        public DateTime Appointment_Date { get; set; }
        public decimal Balance { get; set; }
        public string Payment_Status { get; set; }
        public string From_Date { get; set; }
        public string From_To { get; set; }
        public string Search_String { get; set; }

    }
}