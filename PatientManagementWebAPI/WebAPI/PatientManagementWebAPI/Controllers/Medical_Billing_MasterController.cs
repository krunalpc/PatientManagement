using PatientManagementWebAPI.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace PatientManagementWebAPI.Controllers
{
    public class Medical_Billing_MasterController : ApiController
    {
        String SQLConnString = ConfigurationManager.ConnectionStrings["PatientManagementDBRevised"].ConnectionString; 
        DataTable table = new DataTable();

        // Get Function to fetch the information from the Table throught Stored procedure
        // This would return the Medical Billing Master Table's data
        public HttpResponseMessage Get() {

            SqlConnection ProjectManagerConnection = null;
            SqlCommand cmd = null;
            DataSet myDS = new DataSet();
            SqlDataAdapter da = null;
            var Medical_Billing_MasterInfo = new Medical_Billing_Master();
            var Medical_Billing_MasterInfoList = new List<Medical_Billing_Master>();

            try
            {
                ProjectManagerConnection = new SqlConnection();
                ProjectManagerConnection.ConnectionString = SQLConnString;
                cmd = new SqlCommand("GetMedicalBillingDetails", ProjectManagerConnection);
                cmd.CommandTimeout = 180;
                cmd.CommandType = CommandType.StoredProcedure;

                da = new SqlDataAdapter(cmd);

                ProjectManagerConnection.Open();
                da.Fill(myDS);
                DataTable dt = new DataTable();

                dt = myDS.Tables[0];

                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        Medical_Billing_MasterInfo = new Medical_Billing_Master
                        {
                            MD_ID = dr["MD_ID"] != null && dr["MD_ID"] != DBNull.Value ? Convert.ToInt32(dr["MD_ID"]) : 0,
                            Medical_Billing = dr["Medical_Billing"] != null && dr["Medical_Billing"] != DBNull.Value ? dr["Medical_Billing"].ToString() : string.Empty,
                            Amount = dr["Amount"] != null && dr["Amount"] != DBNull.Value ? Convert.ToDecimal(dr["Amount"]) : 0,
                            Max_Discount = dr["Max_Discount"] != null && dr["Max_Discount"] != DBNull.Value ? Convert.ToInt32(dr["Max_Discount"]) : 0,
                            Discount_Unit = dr["Discount_Unit"] != null && dr["Discount_Unit"] != DBNull.Value ? dr["Discount_Unit"].ToString() : string.Empty,
                            Modality = dr["Modality"] != null && dr["Modality"] != DBNull.Value ? dr["Modality"].ToString() : string.Empty,
                        };
                        Medical_Billing_MasterInfoList.Add(Medical_Billing_MasterInfo);
                    }
                }
                dt.Clear();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Received an error while getting infomration from 'GetMedicalBillingDetails'. ", ex.Message);
            }
            finally {
                if (cmd != null && cmd.Connection != null && cmd.Connection.State == ConnectionState.Open)
                {
                    cmd.Connection.Close();
                }
                if (ProjectManagerConnection != null && ProjectManagerConnection.State == ConnectionState.Open)
                {
                    ProjectManagerConnection.Close();
                }
            }

            return Request.CreateResponse(HttpStatusCode.OK, Medical_Billing_MasterInfoList);

        }

    }
}
