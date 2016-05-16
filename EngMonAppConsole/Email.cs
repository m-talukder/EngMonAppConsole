using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace EngMonAppConsole
{
    public class Email
    {
        public static void SendEmail(string recipient, string recipientName, string body, string subject)
        {
            var fromAddress = new MailAddress("mohsinbdsyd@gmail.com", "ETL Monitoring Console");
            var toAddress = new MailAddress(recipient, recipientName);
            const string fromPassword = "Sdwlassg13522%%$";

            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
            };
            using (var mailMessage = new MailMessage(fromAddress, toAddress)
            {
                Subject = subject,
                IsBodyHtml = true,
                Body =body

            })
            {
                smtp.Send(mailMessage);
            }
        }
    }
}