using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PatientManagementWebAPI.Models
{
    public class Medical_Billing_Master
    {
        public int MD_ID { get; set; }
        public string Medical_Billing { get; set; }
        public decimal Amount { get; set; }
        public int Max_Discount { get; set; }
        public string Discount_Unit { get; set; }
        public string Modality { get; set; }
    }
}