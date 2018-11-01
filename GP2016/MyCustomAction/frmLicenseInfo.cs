using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;
using Microsoft.Deployment.WindowsInstaller;


namespace MyCustomAction
{
    public partial class frmLicenseInfo : Form
    {
        public string SQLDB;
        public string PATH;
        public string SERVER;
         
        public frmLicenseInfo(string v_SQLSERVER, string v_SQLDATABASE, string v_SQLUSER, string v_SQLPASSWOR, string V_PATH  )
        {
            InitializeComponent();

            txtName.Text = "http://";
            if (v_SQLSERVER.IndexOf("\\") != -1)
                           txtName.Text +=  v_SQLSERVER.Substring(0, v_SQLSERVER.IndexOf("\\")) ;
            txtName.Text += "/ReportServer_";
            if (v_SQLSERVER.IndexOf("\\") != -1)
                txtName.Text += v_SQLSERVER.Substring(v_SQLSERVER.IndexOf("\\")+1, v_SQLSERVER.Length - (v_SQLSERVER.IndexOf("\\") + 1));

            // wwsqlad /ReportServer_DYNGPARG
            SQLDB = v_SQLDATABASE;
            SERVER = v_SQLSERVER;
            PATH = V_PATH;

           // MessageBox.Show("txtName " + txtName.Text, "Invalid info");
           // MessageBox.Show("SQL: " + SQLDB + " SERV: " + v_SQLSERVER + " PASS: " + v_SQLPASSWOR + " PA: " + V_PATH, "Invalid info");

           // MessageBox.Show("PATH " + PATH, "Invalid info");

           // MessageBox.Show("txtName " + txtName.Text, "Invalid info");

            Application.EnableVisualStyles();
            this.TopMost = true;
            


        }

        private void btnNext_Click(object sender, EventArgs e)
        {

            bool valid = false;
                   
                        
          //  if (!String.IsNullOrEmpty(txtName.Text) )
           // {
                
                
            valid = WriteConfigNewCompany();
            //}

            if (!valid)
            {
                MessageBox.Show("You license information does not appear to be valid. Please try again.", "Invalid info");
            }
            else
            {
                this.DialogResult = DialogResult.Yes;
            }

            valid = RunDeployNewCompany();

            if (!valid)
            {
                MessageBox.Show("ERROR con el deploy.", "Invalid info");
            }

        }

        private bool VerifyLicenseInfo(string registeredName, string key)
        {
            // Connect to License server or run algorithm check to 
            // verify license key.
            string content = File.ReadAllText("C:\\file1.txt");
            File.AppendAllText("D:\\file2.txt", content);

            return true;
        }

        private bool WriteConfigNewCompany()
        {
            // Connect to License server or run algorithm check to 
            // verify license key.
            string line;
            int counter = 0;
            Boolean ExisteCompania;
            //string configtags;
            //string companytags;

            System.IO.StreamReader file = new System.IO.StreamReader(@PATH + "\\GP Factura Digital v33\\ParametrosCfdi.xml");
            System.IO.StreamWriter fileWrite = new StreamWriter(@PATH + "\\GP Factura Digital v33\\ParametrosCfdi_NEW.xml");
            ExisteCompania = false;

            while ((line = file.ReadLine()) != null)
            {

                if (line.Contains("<servidor>"))
                {
                    fileWrite.WriteLine("<servidor>" + SERVER + "</servidor>");

                }
                else if (line.Contains("<compannia bd=" + "\"" + SQLDB + "\">"))
                {
                   ExisteCompania = true;
                   fileWrite.WriteLine(line);
                }
                else if (line.Contains("</listaParametros>") && !ExisteCompania)
                {
                    fileWrite.WriteLine("\t<compannia bd=" + "\"" + SQLDB + "\">");
                    fileWrite.WriteLine("\t\t<URLArchivoXSD>na</URLArchivoXSD>");
                    fileWrite.WriteLine("\t\t<URLArchivoPagosXSD>na</URLArchivoPagosXSD>");
                    fileWrite.WriteLine("\t\t<URLArchivoXSLT>na</URLArchivoXSLT>");
                    fileWrite.WriteLine("\t\t<URLConsulta>na</URLConsulta>");

                    fileWrite.WriteLine("\t\t<PAC>");
                    fileWrite.WriteLine("\t\t\t<urlWebService>na</urlWebService>");
                    fileWrite.WriteLine("\t\t</PAC>");

                    fileWrite.WriteLine("\t\t<reporteador>SSRS</reporteador>");

                    fileWrite.WriteLine("\t\t<reporteExtensiones>");
                    fileWrite.WriteLine("\t\t\t<PrefijoFacturaExporta>FV E</PrefijoFacturaExporta >");
                    fileWrite.WriteLine("\t\t\t<FacturaExporta>Gral_exp</FacturaExporta>");
                    fileWrite.WriteLine("\t\t\t<Factura>Gral</Factura>");
                    fileWrite.WriteLine("\t\t\t<Cobro>.rdl</Cobro>");
                    fileWrite.WriteLine("\t\t\t<Traslado>.rdl</Traslado>");
                    fileWrite.WriteLine("\t\t</reporteExtensiones>");

                    fileWrite.WriteLine("\t\t<rutaReporteCrystal tipo=\"default\">");
                    fileWrite.WriteLine("\t\t\t<Ruta>na</Ruta>");
                    //Margenes
                    fileWrite.WriteLine("\t\t\t<Margenes>");
                    fileWrite.WriteLine("\t\t\t\t<bottomMargin>0</bottomMargin>");
                    fileWrite.WriteLine("\t\t\t\t<topMargin>0</topMargin>");
                    fileWrite.WriteLine("\t\t\t\t<leftMargin>0</leftMargin>");
                    fileWrite.WriteLine("\t\t\t\t<rightMargin>0</rightMargin>");
                    fileWrite.WriteLine("\t\t\t</Margenes>");

                    fileWrite.WriteLine("\t\t\t<Parametro>");
                    fileWrite.WriteLine("\t\t\t\t<Nombre>Desde Numero</Nombre>");
                    fileWrite.WriteLine("\t\t\t\t<Tipo>string</Tipo>");
                    fileWrite.WriteLine("\t\t\t</Parametro>");
                    fileWrite.WriteLine("\t\t\t<Parametro>");
                    fileWrite.WriteLine("\t\t\t\t<Nombre>Hasta Numero</Nombre>");
                    fileWrite.WriteLine("\t\t\t\t<Tipo>string</Tipo>");
                    fileWrite.WriteLine("\t\t\t</Parametro>");
                    fileWrite.WriteLine("\t\t\t<Parametro>");
                    fileWrite.WriteLine("\t\t\t\t<Nombre>sTabla</Nombre>");
                    fileWrite.WriteLine("\t\t\t\t<Tipo>string</Tipo>");
                    fileWrite.WriteLine("\t\t\t</Parametro>");
                    fileWrite.WriteLine("\t\t\t<Parametro>");
                    fileWrite.WriteLine("\t\t\t\t<Nombre>Comprobante</Nombre>");
                    fileWrite.WriteLine("\t\t\t\t<Tipo>int</Tipo>");
                    fileWrite.WriteLine("\t\t\t</Parametro>");
                    fileWrite.WriteLine("\t\t\t<imprime>0</imprime>");
                    fileWrite.WriteLine("\t\t\t<nombreImpresora>na</nombreImpresora>");
                    fileWrite.WriteLine("\t\t</rutaReporteCrystal>");


                    fileWrite.WriteLine("\t\t<ReporteSSRS tipo = \"default\">");
                    fileWrite.WriteLine("\t\t\t<Ruta>/" + SQLDB + "/FACTURA/FE_Factura_</Ruta>");
                    fileWrite.WriteLine("\t\t\t<SSRSServer>" + txtName.Text + "</SSRSServer>");
                    // fileWrite.WriteLine("\t\t\t<SSRSServer> http://" +  Servidor.Substring(1,Servidor. + "/ReportServer_" + Servidor.Substring(1,4) + "</SSRSServer>");
                    fileWrite.WriteLine("\t\t\t<Parametro>");
                    fileWrite.WriteLine("\t\t\t\t<Nombre>TIPO_FACTURA</Nombre>");
                    fileWrite.WriteLine("\t\t\t\t<Tipo>integer</Tipo>");
                    fileWrite.WriteLine("\t\t\t</Parametro>");
                    fileWrite.WriteLine("\t\t\t<Parametro>");
                    fileWrite.WriteLine("\t\t\t\t<Nombre>NRO_FACTURA</Nombre>");
                    fileWrite.WriteLine("\t\t\t\t<Tipo>string</Tipo>");
                    fileWrite.WriteLine("\t\t\t</Parametro>");
                    fileWrite.WriteLine("\t\t\t<Parametro>");
                    fileWrite.WriteLine("\t\t\t\t<Nombre>BASE</Nombre>");
                    fileWrite.WriteLine("\t\t\t\t<Tipo>string</Tipo>");
                    fileWrite.WriteLine("\t\t\t</Parametro>");
                    fileWrite.WriteLine("\t\t</ReporteSSRS>");

                    fileWrite.WriteLine("\t\t<emite>0</emite>");
                    fileWrite.WriteLine("\t\t<anula>0</anula>");
                    fileWrite.WriteLine("\t\t<imprime>1</imprime>");
                    fileWrite.WriteLine("\t\t<publica>0</publica>");
                    fileWrite.WriteLine("\t\t<envia>1</envia>");
                    fileWrite.WriteLine("\t\t<zip>0</zip>");

                    fileWrite.WriteLine("\t\t<emailSetup>");
                    fileWrite.WriteLine("\t\t\t<smtp>smtp.gmail.com</smtp>");
                    fileWrite.WriteLine("\t\t\t<puerto>587</puerto>");
                    fileWrite.WriteLine("\t\t\t<cuenta>na</cuenta>");
                    fileWrite.WriteLine("\t\t\t<usuario>na</usuario>");
                    fileWrite.WriteLine("\t\t\t<clave/>");
                    fileWrite.WriteLine("\t\t\t<ssl>true</ssl>");
                    fileWrite.WriteLine("\t\t\t<replyto>na</replyto>");
                    fileWrite.WriteLine("\t\t\t<carta>FACTURA_ELECTRONICA</carta>");
                    fileWrite.WriteLine("\t\t\t<adjuntoEmite>na</adjuntoEmite>");
                    fileWrite.WriteLine("\t\t\t<adjuntoImprime>pdf</adjuntoImprime>");
                    fileWrite.WriteLine("\t\t</emailSetup>");

                    fileWrite.WriteLine("\t</compannia>");

                    fileWrite.WriteLine(line);

                }
                else
                { 
                        fileWrite.WriteLine(line);
                }

                counter++;
            }

            fileWrite.Close();
            file.Close();
            File.Move(@PATH + "\\GP Factura Digital v33\\ParametrosCfdi.xml", @PATH + "\\GP Factura Digital v33\\ParametrosCfdi_" + Convert.ToDateTime(DateTime.Now).ToString("yyyymmdd") + " .xml");
            File.Move(@PATH + "\\GP Factura Digital v33\\ParametrosCfdi_NEW.xml", @PATH + "\\GP Factura Digital v33\\ParametrosCfdi.xml");
            File.Delete(@PATH + "\\GP Factura Digital v33\\ParametrosCfdi_NEW.xml");

            if(System.IO.File.Exists(@PATH + "\\Data\\ParametrosCfdi.xml"))
            {
                File.Delete(@PATH + "\\Data\\ParametrosCfdi.xml");
            }
            File.Copy(@PATH + "\\GP Factura Digital v33\\ParametrosCfdi.xml", @PATH + "\\Data\\ParametrosCfdi.xml");

            /*companytags = "\t < compannia bd = " + "\"" + SQLDB + "\">\n";
            companytags = companytags + "\t\t<URLArchivoXSD>na</URLArchivoXSD>\n";
            companytags = companytags + "\t\t<URLArchivoPagosXSD>na</URLArchivoPagosXSD>\n";
            companytags = companytags + "\t\t<URLArchivoXSLT>na</URLArchivoXSLT>\n";
            companytags = companytags + "\t\t<URLConsulta>na</URLConsulta>\n";

            companytags = companytags + "\t\t<PAC>\n";
            companytags = companytags + "\t\t\t<urlWebService>na</urlWebService>\n";
            companytags = companytags + "\t\t</PAC>\n";

            companytags = companytags + "\t\t<reporteador>SSRS</reporteador>\n";

            companytags = companytags + "\t\t<reporteExtensiones>\n";
            companytags = companytags + "\t\t\t<PrefijoFacturaExporta>FV E</PrefijoFacturaExporta >\n";
            companytags = companytags + "\t\t\t<FacturaExporta>_exp.rdl</FacturaExporta>\n";
            companytags = companytags + "\t\t\t<Factura>Gral</Factura>\n";
            companytags = companytags + "\t\t\t<Cobro>.rdl</Cobro>\n";
            companytags = companytags + "\t\t\t<Traslado>.rdl</Traslado>\n";
            companytags = companytags + "\t\t</reporteExtensiones>\n";

            companytags = companytags + "\t\t<rutaReporteCrystal tipo=\"default\">\n";
            companytags = companytags + "\t\t\t<Ruta>na</Ruta>\n";
            //Margenes
            companytags = companytags + "\t\t\t<Margenes>\n";
            companytags = companytags + "\t\t\t\t<bottomMargin>0</bottomMargin>\n";
            companytags = companytags + "\t\t\t\t<topMargin>0</topMargin>\n";
            companytags = companytags + "\t\t\t\t<leftMargin>0</leftMargin>\n";
            companytags = companytags + "\t\t\t\t<rightMargin>0</rightMargin>\n";
            companytags = companytags + "\t\t\t</Margenes>\n";

            companytags = companytags + "\t\t\t<Parametro>\n";
            companytags = companytags + "\t\t\t\t<Nombre>Desde Numero</Nombre>\n";
            companytags = companytags + "\t\t\t\t<Tipo>string</Tipo>\n";
            companytags = companytags + "\t\t\t</Parametro>\n";
            companytags = companytags + "\t\t\t<Parametro>\n";
            companytags = companytags + "\t\t\t\t<Nombre>Hasta Numero</Nombre>\n";
            companytags = companytags + "\t\t\t\t<Tipo>string</Tipo>\n";
            companytags = companytags + "\t\t\t</Parametro>\n";
            companytags = companytags + "\t\t\t<Parametro>\n";
            companytags = companytags + "\t\t\t\t<Nombre>sTabla</Nombre>\n";
            companytags = companytags + "\t\t\t\t<Tipo>string</Tipo>\n";
            companytags = companytags + "\t\t\t</Parametro>\n";
            companytags = companytags + "\t\t\t<Parametro>\n";
            companytags = companytags + "\t\t\t\t<Nombre>Comprobante</Nombre>\n";
            companytags = companytags + "\t\t\t\t<Tipo>int</Tipo>\n";
            companytags = companytags + "\t\t\t</Parametro>\n";
            companytags = companytags + "\t\t\t<imprime>0</imprime>\n";
            companytags = companytags + "\t\t\t<nombreImpresora>na</nombreImpresora>\n";
            companytags = companytags + "\t\t</rutaReporteCrystal>\n";


            companytags = companytags + "\t\t<ReporteSSRS tipo = \"default\">\n";
            companytags = companytags + "\t\t\t<Ruta>/" + SQLDB + "/FACTURA/FE_Factura_</Ruta>\n";
            companytags = companytags + "\t\t\t<SSRSServer>"+ txtName.Text +"</SSRSServer>\n";
           // companytags = companytags + "\t\t\t<SSRSServer> http://" +  Servidor.Substring(1,Servidor. + "/ReportServer_" + Servidor.Substring(1,4) + "</SSRSServer>\n";
            companytags = companytags + "\t\t\t<Parametro>\n";
            companytags = companytags + "\t\t\t\t<Nombre>TIPO_FACTURA</Nombre>\n";
            companytags = companytags + "\t\t\t\t<Tipo>integer</Tipo>\n";
            companytags = companytags + "\t\t\t</Parametro>\n";
            companytags = companytags + "\t\t\t<Parametro>\n";
            companytags = companytags + "\t\t\t\t<Nombre>NRO_FACTURA</Nombre>\n";
            companytags = companytags + "\t\t\t\t<Tipo>string</Tipo>\n";
            companytags = companytags + "\t\t\t</Parametro>\n";
            companytags = companytags + "\t\t\t<Parametro>\n";
            companytags = companytags + "\t\t\t\t<Nombre>BASE</Nombre>\n";
            companytags = companytags + "\t\t\t\t<Tipo>string</Tipo>\n";
            companytags = companytags + "\t\t\t</Parametro>\n";
            companytags = companytags + "\t\t</ReporteSSRS>\n";

            companytags = companytags + "\t\t<emite>0</emite>\n";
            companytags = companytags + "\t\t<anula>0</anula>\n";
            companytags = companytags + "\t\t<imprime>1</imprime>\n";
            companytags = companytags + "\t\t<publica>0</publica>\n";
            companytags = companytags + "\t\t<envia>1</envia>\n";
            companytags = companytags + "\t\t<zip>0</zip>\n";
            
            companytags = companytags + "\t\t<emailSetup>\n";
            companytags = companytags + "\t\t\t<smtp>smtp.gmail.com</smtp>\n";
            companytags = companytags + "\t\t\t<puerto>587</puerto>\n";
            companytags = companytags + "\t\t\t<cuenta>na</cuenta>\n";
            companytags = companytags + "\t\t\t<usuario>na</usuario>\n";
            companytags = companytags + "\t\t\t<clave/>\n";
            companytags = companytags + "\t\t\t<ssl>true</ssl>\n";
            companytags = companytags + "\t\t\t<replyto>na</replyto>\n";
            companytags = companytags + "\t\t\t<carta>FACTURA_ELECTRONICA</carta>\n";
            companytags = companytags + "\t\t\t<adjuntoEmite>na</adjuntoEmite>\n";
            companytags = companytags + "\t\t\t<adjuntoImprime>pdf</adjuntoImprime>\n";
            companytags = companytags + "\t\t</emailSetup>\n";

            companytags = companytags + "\t</compannia>\n";*/

            //File.AppendAllText(@PATH + "\\GP Factura Digital v33\\ParametrosCfdi.xml", companytags);
            // File.WriteAllTexFile.AppendAllText(t(@"C:\Instalador\Parametros_cpia.txt", companytags);
            //File.WriteAllText(@PATH+"\\Parametros_cpia.txt", companytags);

            // string content = File.ReadAllText(@PATH+ "\\GP Factura Digital v33\\ParametrosCfdi.xml");

            return true;
        }

        private bool RunDeployNewCompany()
        {
            // Connect to License server or run algorithm check to 
            // verify license key.
            
            string command="";
            //string configtags;
            //string companytags;

            command = "rs.exe -i \"" + PATH + "Instalador Compañia\\deploy_report_FE.rss\" " +
                        " -s " + txtName.Text + 
                        " -v Servidor=\"" + SERVER + "\"" +
                        " -v Base=\"" + SQLDB + "\"" +
                        " -v ReportName=\"FE_Factura_Gral.rdl\"" +
                        " -v ReportFolder=\"FACTURA\""  +
                        " -v filePath=\"" + PATH + "GP Factura Digital v33\\Reporte FE\"" +
                        " -e Mgmt2010" 
                         ;

            //MessageBox.Show(command, "Invalid info");

            File.WriteAllText(@"C:\Instalador\Comando.txt", command);

            ExecuteCommand(command);

            command = "rs.exe -i \"" + PATH + "Instalador Compañia\\deploy_report_FE.rss\" " +
                       " -s " + txtName.Text +
                       " -v Servidor=\"" + SERVER + "\"" + 
                       " -v Base=\"" + SQLDB + "\"" +
                       " -v ReportName=\"FE_Factura_Gral_Exp.rdl\"" +
                       " -v ReportFolder=\"FACTURA\"" +
                       " -v filePath=\"" + PATH + "GP Factura Digital v33\\Reporte FE\"" +
                       " -e Mgmt2010"
                        ;

            //MessageBox.Show(command, "Invalid info");

            File.WriteAllText(@"C:\Instalador\Comando1.txt", command);

            ExecuteCommand(command);
            
            return true;
        }

        static void ExecuteCommand(string _Command)
        {
            //Indicamos que deseamos inicializar el proceso cmd.exe junto a un comando de arranque. 
            //(/C, le indicamos al proceso cmd que deseamos que cuando termine la tarea asignada se cierre el proceso).
            //Para mas informacion consulte la ayuda de la consola con cmd.exe /? 
            System.Diagnostics.ProcessStartInfo procStartInfo = new System.Diagnostics.ProcessStartInfo("cmd", "/c " + _Command);
            // Indicamos que la salida del proceso se redireccione en un Stream
            procStartInfo.RedirectStandardOutput = true;
            procStartInfo.UseShellExecute = false;
            //Indica que el proceso no despliegue una pantalla negra (El proceso se ejecuta en background)
            procStartInfo.CreateNoWindow = false;
            //Inicializa el proceso
            System.Diagnostics.Process proc = new System.Diagnostics.Process();
            proc.StartInfo = procStartInfo;
            proc.Start();
            //Consigue la salida de la Consola(Stream) y devuelve una cadena de texto
            string result = proc.StandardOutput.ReadToEnd();
            //Muestra en pantalla la salida del Comando
            Console.WriteLine(result);
            File.AppendAllText(@"C:\Instalador\resultados", result);
        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
           
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void frmLicenseInfo_Load(object sender, EventArgs e)
        {

        }

        private void txtName_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
