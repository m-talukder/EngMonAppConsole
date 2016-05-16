using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
/******************************************************************************************
 * Maintenance history- most recent top
 * 
 * 05/09/2013------Mohammed Talukder ------First created
 *                                        
 ******************************************************************************************/
namespace EngMonAppConsole
{
    public  static class EngMonDataExtension
    {

        public static IEnumerable<dynamic> GetUsers(this ReposEntities context,
                                                           Func<ConsoleUser, bool> predicate)
        {
            return context.ConsoleUsers
                          .Where(predicate)
                          .Select(x => new
                          {
                              //Id=x.uID
                              userId = x.uID,
                              uName=x.UserName,
                              Email=x.Email,  
                          }).AsEnumerable();
        }

        //get login history

        public static IEnumerable<dynamic> GEtLoginHostory(this ReposEntities context, Func<LoginRecord, bool> predicate)
        {
            return context.LoginRecords
                          .Where(predicate)
                          .Select(x => new
                              {
                                  LoginTime = x.acessTime
                              }).AsEnumerable();
        } 
    }
}