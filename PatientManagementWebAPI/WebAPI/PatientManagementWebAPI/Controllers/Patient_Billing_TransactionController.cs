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
    public class Patient_Billing_TransactionController : ApiController
    {
        String SQLConnString = ConfigurationManager.ConnectionStrings["PatientManagementDBRevised"].ConnectionString;
        DataTable table = new DataTable();

        // Get Function to fetch the information from the Table throught Stored procedure
        // This will get the records for the Patient Billing Screen
        //This Get SP would provide the record on page load
        public HttpResponseMessage Get()
        {
            SqlConnection ProjectManagerConnection = null;
            SqlCommand cmd = null;
            DataSet myDS = new DataSet();
            SqlDataAdapter da = null;
            var Patient_Billing_TransactionInfo = new Patient_Billing_Details();
            var Modality_Slot_DetailsInfoList = new List<Patient_Billing_Details>();

            try
            {
                ProjectManagerConnection = new SqlConnection();
                ProjectManagerConnection.ConnectionString = SQLConnString;
                var paramsArr = new SqlParameter[1];
                cmd = new SqlCommand("GetPatientBillingDetails", ProjectManagerConnection);
                cmd.CommandTimeout = 180;
                cmd.CommandType = CommandType.StoredProcedure;
                paramsArr[0] = new SqlParameter("@patient_id", SqlDbType.Int) { Value = 16 };

                cmd.Parameters.AddRange(paramsArr);
                da = new SqlDataAdapter(cmd);

                ProjectManagerConnection.Open();
                da.Fill(myDS);
                DataTable dt = new DataTable();

                dt = myDS.Tables[0];

                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        Patient_Billing_TransactionInfo = new Patient_Billing_Details
                        {

                            PATIENT_ID = dr["PATIENT_ID"] != null && dr["PATIENT_ID"] != DBNull.Value ? Convert.ToInt32(dr["PATIENT_ID"]) : 0,
                            name = dr["name"] != null && dr["name"] != DBNull.Value ? dr["name"].ToString() : string.Empty,
                            age = dr["age"] != null && dr["age"] != DBNull.Value ? Convert.ToInt32(dr["age"]) : 0,
                            gender = dr["gender"] != null && dr["gender"] != DBNull.Value ? dr["gender"].ToString() : string.Empty,
                            appointment_date = Convert.ToDateTime(dr["appointment_date"]),
                            total_amount = dr["total_amount"] != null && dr["total_amount"] != DBNull.Value ? Convert.ToDecimal(dr["total_amount"]) : 0,
                            total_discount = dr["total_discount"] != null && dr["total_discount"] != DBNull.Value ? Convert.ToDecimal(dr["total_discount"]) : 0,
                            paid_amount = dr["b_paid_amount"] != null && dr["b_paid_amount"] != DBNull.Value ? Convert.ToDecimal(dr["b_paid_amount"]) : 0,
                            balance = dr["balance"] != null && dr["balance"] != DBNull.Value ? Convert.ToDecimal(dr["balance"]) : 0,
                            TX_ID = dr["TX_ID"] != null && dr["TX_ID"] != DBNull.Value ? Convert.ToInt32(dr["TX_ID"]) : 0,
                            payment_date = Convert.ToDateTime(dr["payment_date"]),
                            Paid_Amount_child = dr["paid_amount"] != null && dr["paid_amount"] != DBNull.Value ? Convert.ToInt32(dr["paid_amount"]) : 0,
                            mode_of_payment = dr["mode_of_payment"] != null && dr["mode_of_payment"] != DBNull.Value ? dr["mode_of_payment"].ToString() : string.Empty,

                        };

                        Modality_Slot_DetailsInfoList.Add(Patient_Billing_TransactionInfo);
                    }
                }
                dt.Clear();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Received an error while getting infomration from 'GetPatientBillingDetails'. ", ex.Message);
            }
            finally
            {
                if (cmd != null && cmd.Connection != null && cmd.Connection.State == ConnectionState.Open)
                {
                    cmd.Connection.Close();
                }
                if (ProjectManagerConnection != null && ProjectManagerConnection.State == ConnectionState.Open)
                {
                    ProjectManagerConnection.Close();
                }
            }

            return Request.CreateResponse(HttpStatusCode.OK, Modality_Slot_DetailsInfoList);

        }

        // Get Function to fetch the information from the Table throught Stored procedure
        // This will update the Patient Billing Screen
        public string Put(Patient_Billing_Details PatientBilling) {

            SqlConnection ProjectManagerConnection = null;
            SqlCommand cmd = null;
            DataSet myDS = new DataSet();
            SqlDataAdapter da = null;
            var Patient_Billing_TransactionInfo = new Patient_Billing_Details();
            var Modality_Slot_DetailsInfoList = new List<Patient_Billing_Details>();
            var result = "";

            try
            {
                ProjectManagerConnection = new SqlConnection();
                ProjectManagerConnection.ConnectionString = SQLConnString;
                cmd = new SqlCommand("[dbo].[InsertPatient_Detail_Master]", ProjectManagerConnection);
                cmd.CommandTimeout = 180;
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter p1 = cmd.Parameters.AddWithValue("@PBT_ID", PatientBilling.PBT_ID);
                p1.SqlDbType = SqlDbType.VarChar;

                SqlParameter p2 = cmd.Parameters.AddWithValue("@Paid_Amount", PatientBilling.paid_amount);
                p2.SqlDbType = SqlDbType.VarChar;

                SqlParameter p3 = cmd.Parameters.AddWithValue("@Mode_Of_Payment", PatientBilling.mode_of_payment);
                p3.SqlDbType = SqlDbType.VarChar;

                SqlParameter p4 = cmd.Parameters.AddWithValue("@CCTXN_ID", PatientBilling.CCTXN_ID);
                p4.SqlDbType = SqlDbType.VarChar;

                var p5 = new SqlParameter()
                {
                    ParameterName = "@Status",
                    SqlDbType = SqlDbType.Int,
                    Size = 2000,
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(p5);

                foreach (SqlParameter parameter in cmd.Parameters) //get rid of null values
                {
                    if (parameter.Value == null)
                    {
                        parameter.Value = DBNull.Value;
                    }
                }

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                ProjectManagerConnection.Close();
                result = "Success";
                return result;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Received an error while saving infomration to 'InsertPatient_Detail_Master'. ", ex.Message);
            }
            return result;

        }
    }
}
