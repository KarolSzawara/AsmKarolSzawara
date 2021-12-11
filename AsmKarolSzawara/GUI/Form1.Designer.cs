
namespace AsmKarolSzawara
{
    partial class Form1
    {
        /// <summary>
        /// Wymagana zmienna projektanta.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Wyczyść wszystkie używane zasoby.
        /// </summary>
        /// <param name="disposing">prawda, jeżeli zarządzane zasoby powinny zostać zlikwidowane; Fałsz w przeciwnym wypadku.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Kod generowany przez Projektanta formularzy systemu Windows

        /// <summary>
        /// Metoda wymagana do obsługi projektanta — nie należy modyfikować
        /// jej zawartości w edytorze kodu.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.jezykC = new System.Windows.Forms.CheckBox();
            this.jezykASM = new System.Windows.Forms.CheckBox();
            this.trackBar1 = new System.Windows.Forms.TrackBar();
            this.PI1 = new System.Windows.Forms.PictureBox();
            this.PI2 = new System.Windows.Forms.PictureBox();
            this.bT = new System.Windows.Forms.Label();
            this.aT = new System.Windows.Forms.Label();
            this.tT = new System.Windows.Forms.Label();
            this.numL = new System.Windows.Forms.Label();
            this.wBU = new System.Windows.Forms.Button();
            this.cBU = new System.Windows.Forms.Button();
            this.toneCB = new System.Windows.Forms.ComboBox();
            this.depthCB = new System.Windows.Forms.ComboBox();
            this.STlabel = new System.Windows.Forms.Label();
            this.SDlabel = new System.Windows.Forms.Label();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.timer2 = new System.Windows.Forms.Timer(this.components);
            this.label1 = new System.Windows.Forms.Label();
            this.tLabel = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.trackBar1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.PI1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.PI2)).BeginInit();
            this.SuspendLayout();
            // 
            // jezykC
            // 
            this.jezykC.AutoSize = true;
            this.jezykC.Location = new System.Drawing.Point(666, 372);
            this.jezykC.Name = "jezykC";
            this.jezykC.Size = new System.Drawing.Size(33, 17);
            this.jezykC.TabIndex = 0;
            this.jezykC.Text = "C";
            this.jezykC.UseVisualStyleBackColor = true;
            this.jezykC.CheckedChanged += new System.EventHandler(this.jezykC_CheckedChanged);
            // 
            // jezykASM
            // 
            this.jezykASM.AutoSize = true;
            this.jezykASM.Location = new System.Drawing.Point(666, 405);
            this.jezykASM.Name = "jezykASM";
            this.jezykASM.Size = new System.Drawing.Size(49, 17);
            this.jezykASM.TabIndex = 1;
            this.jezykASM.Text = "ASM";
            this.jezykASM.UseVisualStyleBackColor = true;
            this.jezykASM.CheckedChanged += new System.EventHandler(this.jezykASM_CheckedChanged);
            // 
            // trackBar1
            // 
            this.trackBar1.Location = new System.Drawing.Point(146, 384);
            this.trackBar1.Maximum = 32;
            this.trackBar1.Minimum = 1;
            this.trackBar1.Name = "trackBar1";
            this.trackBar1.Size = new System.Drawing.Size(473, 45);
            this.trackBar1.TabIndex = 2;
            this.trackBar1.Value = 1;
            this.trackBar1.Scroll += new System.EventHandler(this.trackBar1_Scroll);
            // 
            // PI1
            // 
            this.PI1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.PI1.Location = new System.Drawing.Point(81, 59);
            this.PI1.Name = "PI1";
            this.PI1.Size = new System.Drawing.Size(256, 256);
            this.PI1.TabIndex = 3;
            this.PI1.TabStop = false;
            // 
            // PI2
            // 
            this.PI2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.PI2.Location = new System.Drawing.Point(386, 59);
            this.PI2.Name = "PI2";
            this.PI2.Size = new System.Drawing.Size(256, 256);
            this.PI2.TabIndex = 4;
            this.PI2.TabStop = false;
            // 
            // bT
            // 
            this.bT.AutoSize = true;
            this.bT.Font = new System.Drawing.Font("Microsoft Sans Serif", 22.25F);
            this.bT.Location = new System.Drawing.Point(164, 9);
            this.bT.Name = "bT";
            this.bT.Size = new System.Drawing.Size(102, 36);
            this.bT.TabIndex = 5;
            this.bT.Text = "Before";
            // 
            // aT
            // 
            this.aT.AutoSize = true;
            this.aT.Font = new System.Drawing.Font("Microsoft Sans Serif", 22.25F);
            this.aT.Location = new System.Drawing.Point(461, 9);
            this.aT.Name = "aT";
            this.aT.Size = new System.Drawing.Size(78, 36);
            this.aT.TabIndex = 6;
            this.aT.Text = "After";
            this.aT.Click += new System.EventHandler(this.aT_Click);
            // 
            // tT
            // 
            this.tT.AutoSize = true;
            this.tT.Font = new System.Drawing.Font("Microsoft Sans Serif", 22.25F);
            this.tT.Location = new System.Drawing.Point(330, 432);
            this.tT.Name = "tT";
            this.tT.Size = new System.Drawing.Size(109, 36);
            this.tT.TabIndex = 7;
            this.tT.Text = "Thread";
            // 
            // numL
            // 
            this.numL.AutoSize = true;
            this.numL.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.25F);
            this.numL.Location = new System.Drawing.Point(625, 384);
            this.numL.Name = "numL";
            this.numL.Size = new System.Drawing.Size(16, 17);
            this.numL.TabIndex = 8;
            this.numL.Text = "1";
            // 
            // wBU
            // 
            this.wBU.Location = new System.Drawing.Point(129, 341);
            this.wBU.Name = "wBU";
            this.wBU.Size = new System.Drawing.Size(137, 36);
            this.wBU.TabIndex = 9;
            this.wBU.Text = "Open File";
            this.wBU.UseVisualStyleBackColor = true;
            this.wBU.Click += new System.EventHandler(this.wBU_Click);
            // 
            // cBU
            // 
            this.cBU.Location = new System.Drawing.Point(442, 342);
            this.cBU.Name = "cBU";
            this.cBU.Size = new System.Drawing.Size(137, 36);
            this.cBU.TabIndex = 10;
            this.cBU.Text = "Convert";
            this.cBU.UseVisualStyleBackColor = true;
            this.cBU.Click += new System.EventHandler(this.cBU_Click);
            // 
            // toneCB
            // 
            this.toneCB.FormattingEnabled = true;
            this.toneCB.Items.AddRange(new object[] {
            "0",
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12",
            "13",
            "14",
            "15",
            "16",
            "17",
            "18",
            "19",
            "20",
            "21",
            "22",
            "23",
            "24",
            "25",
            "26",
            "27",
            "28",
            "29",
            "30",
            "31",
            "32",
            "33",
            "34",
            "35",
            "36",
            "37",
            "38",
            "39",
            "40",
            "41",
            "42",
            "43",
            "44",
            "45",
            "46",
            "47",
            "48",
            "49",
            "50"});
            this.toneCB.Location = new System.Drawing.Point(18, 332);
            this.toneCB.Name = "toneCB";
            this.toneCB.Size = new System.Drawing.Size(105, 21);
            this.toneCB.TabIndex = 11;
            // 
            // depthCB
            // 
            this.depthCB.FormattingEnabled = true;
            this.depthCB.Items.AddRange(new object[] {
            "0",
            "10",
            "20",
            "30",
            "40",
            "50",
            "60",
            "70",
            "80",
            "90",
            "100",
            "110",
            "120"});
            this.depthCB.Location = new System.Drawing.Point(18, 380);
            this.depthCB.Name = "depthCB";
            this.depthCB.Size = new System.Drawing.Size(105, 21);
            this.depthCB.TabIndex = 12;
            // 
            // STlabel
            // 
            this.STlabel.AutoSize = true;
            this.STlabel.Location = new System.Drawing.Point(27, 315);
            this.STlabel.Name = "STlabel";
            this.STlabel.Size = new System.Drawing.Size(59, 13);
            this.STlabel.TabIndex = 13;
            this.STlabel.Text = "SepiaTone";
            this.STlabel.Click += new System.EventHandler(this.label1_Click);
            // 
            // SDlabel
            // 
            this.SDlabel.AutoSize = true;
            this.SDlabel.Location = new System.Drawing.Point(30, 361);
            this.SDlabel.Name = "SDlabel";
            this.SDlabel.Size = new System.Drawing.Size(63, 13);
            this.SDlabel.TabIndex = 14;
            this.SDlabel.Text = "SepiaDepth";
            this.SDlabel.Click += new System.EventHandler(this.label1_Click_1);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.label1.Location = new System.Drawing.Point(663, 256);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(97, 18);
            this.label1.TabIndex = 15;
            this.label1.Text = "Convert Time";
            this.label1.Click += new System.EventHandler(this.label1_Click_2);
            // 
            // tLabel
            // 
            this.tLabel.AutoSize = true;
            this.tLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.tLabel.Location = new System.Drawing.Point(700, 285);
            this.tLabel.Name = "tLabel";
            this.tLabel.Size = new System.Drawing.Size(15, 16);
            this.tLabel.TabIndex = 16;
            this.tLabel.Text = "0";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(818, 472);
            this.Controls.Add(this.tLabel);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.SDlabel);
            this.Controls.Add(this.STlabel);
            this.Controls.Add(this.depthCB);
            this.Controls.Add(this.toneCB);
            this.Controls.Add(this.cBU);
            this.Controls.Add(this.wBU);
            this.Controls.Add(this.numL);
            this.Controls.Add(this.tT);
            this.Controls.Add(this.aT);
            this.Controls.Add(this.bT);
            this.Controls.Add(this.PI2);
            this.Controls.Add(this.PI1);
            this.Controls.Add(this.trackBar1);
            this.Controls.Add(this.jezykASM);
            this.Controls.Add(this.jezykC);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.trackBar1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.PI1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.PI2)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.CheckBox jezykC;
        private System.Windows.Forms.CheckBox jezykASM;
        private System.Windows.Forms.TrackBar trackBar1;
        private System.Windows.Forms.PictureBox PI1;
        private System.Windows.Forms.PictureBox PI2;
        private System.Windows.Forms.Label bT;
        private System.Windows.Forms.Label aT;
        private System.Windows.Forms.Label tT;
        private System.Windows.Forms.Label numL;
        private System.Windows.Forms.Button wBU;
        private System.Windows.Forms.Button cBU;
        private System.Windows.Forms.ComboBox toneCB;
        private System.Windows.Forms.ComboBox depthCB;
        private System.Windows.Forms.Label STlabel;
        private System.Windows.Forms.Label SDlabel;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.Timer timer2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label tLabel;
    }
}

