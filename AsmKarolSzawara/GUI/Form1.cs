using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace AsmKarolSzawara
{
    
    public partial class Form1 : Form
    {
        byte[] pixelTAB;

        [DllImport("D:\\Asembler\\Projekt\\AsmKarolSzawara\\Debug\\DllC++.dll", CallingConvention = CallingConvention.Cdecl)]
        unsafe public static extern void sepiaC(Byte* image, int start, int stop, int tone, int depth);
        public Form1()
        {
            InitializeComponent();
            trackBar1.SetRange(1, 32);
            
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            
        }

        private void trackBar1_Scroll(object sender, EventArgs e)
        {
            numL.Text = trackBar1.Value.ToString();
        }

        private void wBU_Click(object sender, EventArgs e)
        {
            OpenFileDialog n1 = new OpenFileDialog();
            n1.Filter = "Image Files(*.bmp)|*.bmp";
            if (n1.ShowDialog() == DialogResult.OK)
            {
                using (FileStream file = new FileStream(n1.FileName, FileMode.Open, FileAccess.Read))
                {
                    using(Image image = Image.FromStream(stream: file, useEmbeddedColorManagement: false, validateImageData: false))
                    {

                    }
                }
                Image bmp = new Bitmap(n1.FileName);
                PI1.SizeMode = PictureBoxSizeMode.StretchImage;
                PI1.Image = bmp;  
                
            }
           
        }

        private void aT_Click(object sender, EventArgs e)
        {

        }

        private void jezykC_CheckedChanged(object sender, EventArgs e)
        {
            if (jezykC.Checked==true)
            {
                jezykASM.Checked = false;
            }
        }

        private void jezykASM_CheckedChanged(object sender, EventArgs e)
        {

            if (jezykASM.Checked == true)
            {
                jezykC.Checked = false;
            }
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click_1(object sender, EventArgs e)
        {

        }

        private void cBU_Click(object sender, EventArgs e)
        {
            int depth = 0;
            int tone = 0;
            Bitmap bitmap=new Bitmap(PI1.Image);
            if (depthCB.SelectedItem != null)
            {
                depth = int.Parse(depthCB.SelectedItem.ToString());
            }
            if (toneCB.SelectedItem != null)
            {
                tone = int.Parse(toneCB.SelectedItem.ToString());
            }
            if (SepiaConvert(bitmap, depth, tone))
            {
                PI2.SizeMode = PictureBoxSizeMode.StretchImage;
                PI2.Image = bitmap;
            }
            
        }
        private bool SepiaConvert(Bitmap bitmap,int sTone,int sDepth)
        {
            Rectangle rectangle = new Rectangle(0, 0, bitmap.Width, bitmap.Height);
            BitmapData data = bitmap.LockBits(rectangle, ImageLockMode.ReadWrite, PixelFormat.Format32bppRgb);
            int depth = Bitmap.GetPixelFormatSize(data.PixelFormat) / 8;
            pixelTAB = new byte[data.Width * data.Height * depth];
            
                Marshal.Copy(data.Scan0, pixelTAB,0 ,pixelTAB.Length);
            startDLL(sDepth, sTone);
            
            Marshal.Copy(pixelTAB, 0, data.Scan0, pixelTAB.Length);
            this.Invalidate();
            bitmap.UnlockBits(data);

            return true;
        }

        unsafe private void CFunction(object argum)
        {
            Array args = new object[5];
            args = (Array)argum;
            int start = (int)args.GetValue(0);
            int stop = (int)args.GetValue(1);
            byte[] table = (byte[])args.GetValue(2);
            int toneV = (int)args.GetValue(3);
            int depthV = (int)args.GetValue(4);
            fixed(byte* imgPTR = &table[0])
            {
                sepiaC(imgPTR, start, stop, toneV, depthV);
            }
        }

    void startDLL(int depth,int tone)
        {
           
            ThreadPool.SetMaxThreads(trackBar1.Value, trackBar1.Value);
            Array args = new object[5];
            args.SetValue(0, 0);
            //args.SetValue(pixelTAB.Length, 1);
            args.SetValue(pixelTAB, 2);
            args.SetValue(tone, 3);
            args.SetValue(depth, 4);
            Stopwatch mywatch = new Stopwatch();
            mywatch.Start();
            int io, ia;
            
            if (jezykC.Checked == true)
            {
                

                   for(int i = 32; i < pixelTAB.Length; i += 32)
                {
                    if (pixelTAB.Length < i) break;
                    args.SetValue(i, 1);
                       ThreadPool.UnsafeQueueUserWorkItem(new WaitCallback(CFunction), args);
                    
                    args.SetValue(i, 0);
                }
                   
                
                
                   
                        
                    

                   // CFunction(args);
                
             }
            if (jezykASM.Checked == true)
            {
                //funckja asm
            }
            mywatch.Stop();
            
            double ticks = mywatch.ElapsedTicks;
            double microseconds = (ticks / Stopwatch.Frequency) * 1000;
            tLabel.Text = microseconds.ToString();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void label1_Click_2(object sender, EventArgs e)
        {

        }
    }
}
