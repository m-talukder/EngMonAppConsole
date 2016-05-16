using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace EngMonAppConsole.Class
{
    public class DBConnection
    {
        public Host Host
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }
   
        public static SqlConnection GetConnection()
        {
            string connString;
            connString = @"Data Source=mohsin-sqlserver.no-ip.org;Initial Catalog=EngMonAppRepos;User ID=sa;Password=Sdwlassg13522554;"; 		 		
            return new SqlConnection(connString);
        }

      //Start method DataEntry
        /// <summary>
        /// 
        /// </summary>
        /// <param name="query"></param>
        /// <returns></returns>
       
        public static int DataEntry(string query)
        {
            SqlConnection myConnection = Class.DBConnection.GetConnection();
            SqlCommand myCommand = new SqlCommand(query, myConnection);
            try
            {

                myConnection.Open();
                myCommand.ExecuteNonQuery();
                return 1;
                



            }
            catch (SqlException ex)
            {

                return ex.Number;
            }
            finally
            {
                myConnection.Close();
            }
            
        }

        public static SqlDataReader readData(string query)
        {
            SqlConnection myConnection = Class.DBConnection.GetConnection();
            SqlCommand myCommand = new SqlCommand(query, myConnection);
            SqlDataReader reader;

            try
            {
                myConnection.Open();
                reader = myCommand.ExecuteReader();
                return reader;
                
            }
            catch (SqlException ex)
            {
                return null;
            }
            finally
            {
                //myConnection.Close();
            }
           // return null; ;
        }
        //public static List<Class.TestQuestion> ReadTestQuestion(int catagory, int quesType, string query)
        //{
        //    Random randomNum = new Random();
        //    int itemToRemove = 0;

        //    List<Class.TestQuestion> testQuestions = new List<Class.TestQuestion>();

        //    SqlConnection myConnection = Class.DBConnection.GetConnection();
        //    SqlCommand myCommand = new SqlCommand(query, myConnection);
           
        //    try
        //    {
        //        myConnection.Open();
        //        SqlDataReader reader = myCommand.ExecuteReader();
        //        while (reader.Read())
        //        {
        //            testQuestions.Add(new Class.TestQuestion(reader["Question_Text"].ToString(), reader["Answer_1"].ToString(),
        //                                reader["Answer_2"].ToString(), reader["Answer_3"].ToString(), reader["Answer_4"].ToString(),
        //                                reader["Correct_Answer"].ToString(), catagory, quesType));

        //        }//end reading record from Question Table
        //        //now remove question randomly from list until 10 question left
        //        while (testQuestions.Count > 10)
        //        {
                    
        //            itemToRemove = randomNum.Next(0, testQuestions.Count);//generate a rand number from 0 to list size,
        //            testQuestions.RemoveAt(itemToRemove);
        //        }
        //        return testQuestions;



                
        //    }
        //    catch(SqlException ex)
        //    {
        //        testQuestions.Add(new TestQuestion(ex.Number));//add the error number in list 
        //                                                        //using 1 argument constructor of TestQuestion class
        //        return testQuestions;//return list which holding error number
                
        //    }



        //}
    }
}
 