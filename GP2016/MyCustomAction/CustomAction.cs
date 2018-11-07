using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using Microsoft.Deployment.WindowsInstaller;

namespace MyCustomAction
{
    
    public class CustomActions
    {

        //public static string v_SQLSERVER;
        [CustomAction]
        public static ActionResult ShowLicenseInfo(Session session)
        {

            string v_SQLSERVER      = session["SQLSERVER"];
            string v_SQLDATABASE    = session["SQLDATABASE"];
            string v_SQLUSER        = session["SQLUSER"];
            string v_SQLPASSWORD    = session["SQLPASSWORD"];
            string V_INST           = session["INSTALLDIR"];

            //MessageBox.Show("SQL: " + v_SQLDATABASE + " SERV: " + v_SQLSERVER + " PASS: " + v_SQLPASSWORD +  " V_INST " + V_INST, "Invalid info");

            frmLicenseInfo frmInfo = new frmLicenseInfo(v_SQLSERVER, v_SQLDATABASE, v_SQLUSER, v_SQLPASSWORD, V_INST);

            if (frmInfo.ShowDialog() == DialogResult.Cancel)
                return ActionResult.UserExit;

            return ActionResult.Success;
        }
    }
}
