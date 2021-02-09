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
    public class Patient_Detail_MasterController : ApiController
    {
        String SQLConnString = ConfigurationManager.ConnectionStrings["PatientManagementDBRevised"].ConnectionString;
        DataTable table = new DataTable();

        // Get Function to fetch the information from the Table throught Stored procedure
        // This will return data for the View Appointment screen

        public HttpResponseMessage Get()
        {
            SqlConnection ProjectManagerConnection = null;
            SqlCommand cmd = null;
            DataSet myDS = new DataSet();
            SqlDataAdapter da = null;
            var Patient_Detail_MasterInfo = new Patient_Detail_View_Appointment();
            var Patient_Detail_MasterInfoList = new List<Patient_Detail_View_Appointment>();

            try
            {
                ProjectManagerConnection = new SqlConnection();
                ProjectManagerConnection.ConnectionString = SQLConnString;
                cmd = new SqlCommand("GetPatientViewAppointment", ProjectManagerConnection);
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
                        Patient_Detail_MasterInfo = new Patient_Detail_View_Appointment
                        {

                            PATIENT_ID = dr["PATIENT_ID"] != null && dr["PATIENT_ID"] != DBNull.Value ? Convert.ToInt32(dr["PATIENT_ID"]) : 0,
                            Name = dr["name"] != null && dr["name"] != DBNull.Value ? dr["name"].ToString() : string.Empty,
                            Gender = dr["gender"] != null && dr["gender"] != DBNull.Value ? dr["gender"].ToString() : string.Empty,
                            Age = dr["age"] != null && dr["age"] != DBNull.Value ? Convert.ToInt32(dr["age"]) : 0,
                            Appointment_Date = Convert.ToDateTime(dr["appointment_date"]),
                            Balance = dr["balance"] != null && dr["balance"] != DBNull.Value ? Convert.ToDecimal(dr["balance"]) : 0,
                            Payment_Status = dr["payment_status"] != null && dr["payment_status"] != DBNull.Value ? dr["payment_status"].ToString() : string.Empty,
                        };
                        Patient_Detail_MasterInfoList.Add(Patient_Detail_MasterInfo);
                    }
                }
                dt.Clear();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Received an error while getting infomration from 'GetPatientViewAppointment'. ", ex.Message);
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

            return Request.CreateResponse(HttpStatusCode.OK, Patient_Detail_MasterInfoList);

        }

        // Get Function to fetch the information from the Table throught Stored procedure
        // This will Save the Patient Infomration from the Add Patient Screen
        public String Post(Patient_Detail_Master PatientDetails)
        {
            SqlConnection ProjectManagerConnection = null;
            SqlCommand cmd = null;
            var result = "";    
        
            try
            {
                ProjectManagerConnection = new SqlConnection();
                ProjectManagerConnection.ConnectionString = SQLConnString;
                cmd = new SqlCommand("[dbo].[InsertPatient_Detail_Master]", ProjectManagerConnection);
                cmd.CommandTimeout = 180;
                cmd.CommandType = CommandType.StoredProcedure;
        
                SqlParameter p1 = cmd.Parameters.AddWithValue("@Salutation", PatientDetails.Salutation);
                p1.SqlDbType = SqlDbType.VarChar;
        
                SqlParameter p2 = cmd.Parameters.AddWithValue("@Name", PatientDetails.Name);
                p2.SqlDbType = SqlDbType.VarChar;
        
                SqlParameter p3 = cmd.Parameters.AddWithValue("@Gender", PatientDetails.Gender);
                p3.SqlDbType = SqlDbType.VarChar;
        
                SqlParameter p4 = cmd.Parameters.AddWithValue("@DOB", PatientDetails.DOB);
                p4.SqlDbType = SqlDbType.DateTime;
        
                SqlParameter p5 = cmd.Parameters.AddWithValue("@Age", PatientDetails.Age);
                p5.SqlDbType = SqlDbType.Int;
        
                SqlParameter p6 = cmd.Parameters.AddWithValue("@Age_Type", PatientDetails.Age_Type);
                p6.SqlDbType = SqlDbType.VarChar;
        
                SqlParameter p7 = cmd.Parameters.AddWithValue("@Phone_Number", PatientDetails.Phone_Number);
                p7.SqlDbType = SqlDbType.VarChar;
        
                SqlParameter p8 = cmd.Parameters.AddWithValue("@Address", PatientDetails.Address);
                p8.SqlDbType = SqlDbType.VarChar;
        
                SqlParameter p9 = cmd.Parameters.AddWithValue("@Billing_Details", PatientDetails.Billing_Details);
                p9.SqlDbType = SqlDbType.VarChar;
        
                SqlParameter p10 = cmd.Parameters.AddWithValue("@Appointment_Date", PatientDetails.Appointment_Date);
                p10.SqlDbType = SqlDbType.DateTime;
        
                SqlParameter p11 = cmd.Parameters.AddWithValue("@Address_2", PatientDetails.Address_2);
                p11.SqlDbType = SqlDbType.VarChar;
        
                SqlParameter p12 = cmd.Parameters.AddWithValue("@City", PatientDetails.City);
                p12.SqlDbType = SqlDbType.VarChar;
        
                SqlParameter p13 = cmd.Parameters.AddWithValue("@State", PatientDetails.State);
                p13.SqlDbType = SqlDbType.VarChar;
        
                SqlParameter p14 = cmd.Parameters.AddWithValue("@Postal", PatientDetails.Postal);
                p14.SqlDbType = SqlDbType.VarChar;
        
                SqlParameter p15 = cmd.Parameters.AddWithValue("@Country", PatientDetails.Country);
                p15.SqlDbType = SqlDbType.VarChar;

                SqlParameter p16 = cmd.Parameters.AddWithValue("@scan_dtls", PatientDetails.scan_dtls);
                p16.SqlDbType = SqlDbType.Xml;

                var p17 = new SqlParameter()
                {
                    ParameterName = "@Status",
                    SqlDbType = SqlDbType.Int,
                    Size = 2000,
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(p17);
        
                foreach (SqlParameter parameter in cmd.Parameters) 
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
