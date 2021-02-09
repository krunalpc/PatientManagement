using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PatientManagementWebAPI.Models
{
    public class Patient_Billing_Details
    {
        public int PATIENT_ID { get; set; }
        public string name { get; set; }
        public int age { get; set; }
        public string gender { get; set; }
        public DateTime appointment_date { get; set; }
        public decimal total_amount { get; set; }
        public decimal total_discount { get; set; }
        public decimal paid_amount { get; set; }
        public decimal balance { get; set; }
        public int TX_ID { get; set; }
        public DateTime payment_date { get; set; }
        public decimal Paid_Amount_child { get; set; }
        public string mode_of_payment { get; set; }
        public string CCTXN_ID { get; set; }
        public string PBT_ID { get; set; }

    }
}