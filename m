Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Feb 2005 16:12:48 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.191]:51410
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224922AbVBOQM3>; Tue, 15 Feb 2005 16:12:29 +0000
Received: from [212.227.126.205] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1D15JM-0005k0-00; Tue, 15 Feb 2005 17:12:28 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1D15JL-0001Es-00; Tue, 15 Feb 2005 17:12:27 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: [patch] cleanup and two new LCD panels
Date:	Tue, 15 Feb 2005 17:15:06 +0100
User-Agent: KMail/1.7.1
Cc:	ralf@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502151715.07181.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Changes:
 * add documentation to the macros that describe the registers 
   of the LCD controller
 * replace ad-hoc uint32 typedef with common u32
 * convert the table with LCD driver data to use new-style initialisers
 * added driver data for two more displays
 * replace the fixed-size panel_name field with a plain string

Apart from the changes to the table, this should not result in any observable 
change, it is mostly cosmetic.

A question that came up hacking this, concerning registers of devices in 
general: is there a reason not to use bitfields for those? I find it much 
clearer and more expressive when doing bit-fiddling than lots of bitwise ops.

Uli

---

Index: drivers/video/au1100fb.h
===================================================================
RCS file: /home/cvs/linux/drivers/video/au1100fb.h,v
retrieving revision 1.1
diff -u -r1.1 au1100fb.h
--- drivers/video/au1100fb.h 14 Jul 2002 21:33:34 -0000 1.1
+++ drivers/video/au1100fb.h 15 Feb 2005 15:57:28 -0000
@@ -31,22 +31,27 @@
 #define _AU1100LCD_H
 
 /********************************************************************/
-#define uint32 unsigned long
+
 typedef volatile struct
 {
- uint32 lcd_control;
- uint32 lcd_intstatus;
- uint32 lcd_intenable;
- uint32 lcd_horztiming;
- uint32 lcd_verttiming;
- uint32 lcd_clkcontrol;
- uint32 lcd_dmaaddr0;
- uint32 lcd_dmaaddr1;
- uint32 lcd_words;
- uint32 lcd_pwmdiv;
- uint32 lcd_pwmhi;
- uint32 reserved[(0x0400-0x002C)/4];
- uint32 lcd_pallettebase[256];
+ u32 lcd_control;
+ u32 lcd_intstatus;
+ u32 lcd_intenable;
+ u32 lcd_horztiming;
+ u32 lcd_verttiming;
+ u32 lcd_clkcontrol;
+ /* physical address of the framebuffer */
+ u32 lcd_dmaaddr0;
+ u32 lcd_dmaaddr1;
+ /* number of words
+    0/180 degree swivel: in the framebuffer
+   90/270 degree swivel: per line
+ minus one. */
+ u32 lcd_words;
+ u32 lcd_pwmdiv;
+ u32 lcd_pwmhi;
+ u32 reserved[(0x0400-0x002C)/4];
+ u32 lcd_pallettebase[256];
 
 } AU1100_LCD;
 
@@ -59,31 +64,45 @@
  */
 
 /* lcd_control */
+
+/* Sixten Bit Per Pixel Format */
 #define LCD_CONTROL_SBPPF  (7<<18)
 #define LCD_CONTROL_SBPPF_655 (0<<18)
 #define LCD_CONTROL_SBPPF_565 (1<<18)
 #define LCD_CONTROL_SBPPF_556 (2<<18)
 #define LCD_CONTROL_SBPPF_1555 (3<<18)
 #define LCD_CONTROL_SBPPF_5551 (4<<18)
+/* White data Polarity */
 #define LCD_CONTROL_WP   (1<<17)
+/* White Data enable */
 #define LCD_CONTROL_WD   (1<<16)
+/* Coherent */
 #define LCD_CONTROL_C   (1<<15)
+/* Swivel Mode */
 #define LCD_CONTROL_SM   (3<<13)
 #define LCD_CONTROL_SM_0  (0<<13)
 #define LCD_CONTROL_SM_90  (1<<13)
 #define LCD_CONTROL_SM_180  (2<<13)
 #define LCD_CONTROL_SM_270  (3<<13)
+/* Data Bits (0=16, 1=12) */
 #define LCD_CONTROL_DB   (1<<12)
+/* Colour Channel Operation (0=RGB, 1=BGR) */
 #define LCD_CONTROL_CCO   (1<<11)
+/* Dual Panel */
 #define LCD_CONTROL_DP   (1<<10)
+/* Pixel Order */
 #define LCD_CONTROL_PO   (3<<8)
 #define LCD_CONTROL_PO_00  (0<<8)
 #define LCD_CONTROL_PO_01  (1<<8)
 #define LCD_CONTROL_PO_10  (2<<8)
 #define LCD_CONTROL_PO_11  (3<<8)
+/* Monochrome Panel Interface */
 #define LCD_CONTROL_MPI   (1<<7)
+/* Panel Type (0=STN passive, 1=LCD active) */
 #define LCD_CONTROL_PT   (1<<6)
+/* Panel Colour (0=monochrome, 1=coloured) */
 #define LCD_CONTROL_PC   (1<<5)
+/* Bits Per Pixel */
 #define LCD_CONTROL_BPP   (7<<1)
 #define LCD_CONTROL_BPP_1  (0<<1)
 #define LCD_CONTROL_BPP_2  (1<<1)
@@ -91,71 +110,102 @@
 #define LCD_CONTROL_BPP_8  (3<<1)
 #define LCD_CONTROL_BPP_12  (4<<1)
 #define LCD_CONTROL_BPP_16  (5<<1)
+/* GO (enable display controller)*/
 #define LCD_CONTROL_GO   (1<<0)
 
 /* lcd_intstatus, lcd_intenable */
+/* ShutDown */
 #define LCD_INT_SD    (1<<7)
+/* OverFlow */
 #define LCD_INT_OF    (1<<6)
+/* UnderFlow */
 #define LCD_INT_UF    (1<<5)
+/* Start Active */
 #define LCD_INT_SA    (1<<3)
+/* Start Sync */
 #define LCD_INT_SS    (1<<2)
+/* Start address 1 latched */
 #define LCD_INT_S1    (1<<1)
+/* Start address 0 latched */
 #define LCD_INT_S0    (1<<0)
 
 /* lcd_horztiming */
+/* Horizontal Nondisplay period 2 */
 #define LCD_HORZTIMING_HN2  (255<<24)
 #define LCD_HORZTIMING_HN2_N(N) (((N)-1)<<24)
+/* Horizontal Nondisplay period 2 */
 #define LCD_HORZTIMING_HN1  (255<<16)
 #define LCD_HORZTIMING_HN1_N(N) (((N)-1)<<16)
+/* Horizontal sync Pulse Width */
 #define LCD_HORZTIMING_HPW  (63<<10)
 #define LCD_HORZTIMING_HPW_N(N) (((N)-1)<<10)
+/* Pixels Per Line */
 #define LCD_HORZTIMING_PPL  (1023<<0)
 #define LCD_HORZTIMING_PPL_N(N) (((N)-1)<<0)
 
 /* lcd_verttiming */
+/* Vertical Nondisplay period 2 */
 #define LCD_VERTTIMING_VN2  (255<<24)
 #define LCD_VERTTIMING_VN2_N(N) (((N)-1)<<24)
+/* Vertical Nondisplay period 1 */
 #define LCD_VERTTIMING_VN1  (255<<16)
 #define LCD_VERTTIMING_VN1_N(N) (((N)-1)<<16)
+/* Vertical sync Pulse Width */
 #define LCD_VERTTIMING_VPW  (63<<10)
 #define LCD_VERTTIMING_VPW_N(N) (((N)-1)<<10)
+/* Lines Per Panel */
 #define LCD_VERTTIMING_LPP  (1023<<0)
 #define LCD_VERTTIMING_LPP_N(N) (((N)-1)<<0)
 
 /* lcd_clkcontrol */
+/* Invert Bias */
 #define LCD_CLKCONTROL_IB  (1<<18)
+/* Invert pixelClock */
 #define LCD_CLKCONTROL_IC  (1<<17)
+/* Invert Horizontal (line) clock */
 #define LCD_CLKCONTROL_IH  (1<<16)
+/* Invert Vertical (frame) clock */
 #define LCD_CLKCONTROL_IV  (1<<15)
+/* Bias signal Frequency */
 #define LCD_CLKCONTROL_BF  (31<<10)
 #define LCD_CLKCONTROL_BF_N(N) (((N)-1)<<10)
+/* Pixel Clock Divisor */
 #define LCD_CLKCONTROL_PCD  (1023<<0)
 #define LCD_CLKCONTROL_PCD_N(N) ((N)<<0)
 
 /* lcd_pwmdiv */
+/* Enable */
 #define LCD_PWMDIV_EN   (1<<12)
+/* PWM frequency DIVider */
 #define LCD_PWMDIV_PWMDIV  (2047<<0)
 #define LCD_PWMDIV_PWMDIV_N(N) (((N)-1)<<0)
 
 /* lcd_pwmhi */
+/* PWM HIgh time for clock 1 */
 #define LCD_PWMHI_PWMHI1  (2047<<12)
 #define LCD_PWMHI_PWMHI1_N(N) ((N)<<12)
+/* PWM HIgh time for clock 0 */
 #define LCD_PWMHI_PWMHI0  (2047<<0)
 #define LCD_PWMHI_PWMHI0_N(N) ((N)<<0)
 
 /* lcd_pallettebase - MONOCHROME */
+/* Monochromatic panel Intensity */
 #define LCD_PALLETTE_MONO_MI  (15<<0)
 #define LCD_PALLETTE_MONO_MI_N(N) ((N)<<0)
 
 /* lcd_pallettebase - COLOR */
+/* Blue Intensity (if not LCD_CONTROL_CCO set) */
 #define LCD_PALLETTE_COLOR_BI  (15<<8)
 #define LCD_PALLETTE_COLOR_BI_N(N) ((N)<<8)
+/* Green Intensity */
 #define LCD_PALLETTE_COLOR_GI  (15<<4)
 #define LCD_PALLETTE_COLOR_GI_N(N) ((N)<<4)
+/* Red Intensity (if not LCD_CONTROL_CCO set) */
 #define LCD_PALLETTE_COLOR_RI  (15<<0)
 #define LCD_PALLETTE_COLOR_RI_N(N) ((N)<<0)
 
 /* lcd_palletebase - COLOR TFT PALLETIZED */
+/* Direct Color (layout defined by LCD_CONTROL_SBPPF) */
 #define LCD_PALLETTE_TFT_DC   (65535<<0)
 #define LCD_PALLETTE_TFT_DC_N(N) ((N)<<0)
 
@@ -163,219 +213,190 @@
 
 struct known_lcd_panels
 {
- uint32 xres;
- uint32 yres;
- uint32 bpp;
- unsigned char  panel_name[256];
- uint32 mode_control;
- uint32 mode_horztiming;
- uint32 mode_verttiming;
- uint32 mode_clkcontrol;
- uint32 mode_pwmdiv;
- uint32 mode_pwmhi;
- uint32 mode_toyclksrc;
- uint32 mode_backlight;
-
+ u32 xres;
+ u32 yres;
+ u32 bpp;
+ char const* panel_name;
+ u32 mode_control;
+ u32 mode_horztiming;
+ u32 mode_verttiming;
+ u32 mode_clkcontrol;
+ u32 mode_pwmdiv;
+ u32 mode_pwmhi;
+ u32 mode_toyclksrc;
+ u32 mode_backlight;
 };
 
 #if defined(__BIG_ENDIAN)
-#define LCD_DEFAULT_PIX_FORMAT LCD_CONTROL_PO_11
+#  define LCD_DEFAULT_PIX_FORMAT LCD_CONTROL_PO_11
 #else
-#define LCD_DEFAULT_PIX_FORMAT LCD_CONTROL_PO_00
+#  define LCD_DEFAULT_PIX_FORMAT LCD_CONTROL_PO_00
 #endif
 
 /*
  * The fb driver assumes that AUX PLL is at 48MHz.  That can
  * cover up to 800x600 resolution; if you need higher resolution,
  * you should modify the driver as needed, not just this structure.
+ *
+ * TODO:
+ * - decode the magic numbers below using the macros above
+ * - provide/include and use macros for mode_toyclksrc
  */
 struct known_lcd_panels panels[] =
 {
-	{ /* 0: Pb1100 LCDA: Sharp 320x240 TFT panel */
-		320, /* xres */
-		240, /* yres */
-		16,  /* bpp  */
-		
-		"Sharp_320x240_16",
-		/* mode_control */
-		( LCD_CONTROL_SBPPF_565
-		/*LCD_CONTROL_WP*/
-		/*LCD_CONTROL_WD*/
-		| LCD_CONTROL_C
-		| LCD_CONTROL_SM_0
-		/*LCD_CONTROL_DB*/
-		/*LCD_CONTROL_CCO*/
-		/*LCD_CONTROL_DP*/
-		| LCD_DEFAULT_PIX_FORMAT
-		/*LCD_CONTROL_MPI*/
-		| LCD_CONTROL_PT
-		| LCD_CONTROL_PC
-		| LCD_CONTROL_BPP_16 ),
-
-		/* mode_horztiming */
-		( LCD_HORZTIMING_HN2_N(8)
-		| LCD_HORZTIMING_HN1_N(60)
-		| LCD_HORZTIMING_HPW_N(12)
-		| LCD_HORZTIMING_PPL_N(320) ),
-
-		/* mode_verttiming */
-		( LCD_VERTTIMING_VN2_N(5)
-		| LCD_VERTTIMING_VN1_N(17)
-		| LCD_VERTTIMING_VPW_N(1)
-		| LCD_VERTTIMING_LPP_N(240) ),
-
-		/* mode_clkcontrol */
-		( 0
-		/*LCD_CLKCONTROL_IB*/
-		/*LCD_CLKCONTROL_IC*/
-		/*LCD_CLKCONTROL_IH*/
-		/*LCD_CLKCONTROL_IV*/
-		| LCD_CLKCONTROL_PCD_N(1) ),
-
-		/* mode_pwmdiv */
-		0,
-
-		/* mode_pwmhi */
-		0,
-
-		/* mode_toyclksrc */
-		((1<<7) | (1<<6) | (1<<5)),
-
-		/* mode_backlight */
-		6
+	{ /* Pb1100 LCDA: Sharp 320x240 TFT panel */
+		.xres = 320,
+		.yres = 240,
+		.bpp = 16,
+		.panel_name = "Sharp_320x240_16",
+		.mode_control =
+			( LCD_CONTROL_SBPPF_565
+			| LCD_CONTROL_C
+			| LCD_CONTROL_SM_0
+			| LCD_DEFAULT_PIX_FORMAT
+			| LCD_CONTROL_PT
+			| LCD_CONTROL_PC
+			| LCD_CONTROL_BPP_16 ),
+		.mode_horztiming =
+			( LCD_HORZTIMING_HN2_N(8)
+			| LCD_HORZTIMING_HN1_N(60)
+			| LCD_HORZTIMING_HPW_N(12)
+			| LCD_HORZTIMING_PPL_N(320) ),
+		.mode_verttiming =
+			( LCD_VERTTIMING_VN2_N(5)
+			| LCD_VERTTIMING_VN1_N(17)
+			| LCD_VERTTIMING_VPW_N(1)
+			| LCD_VERTTIMING_LPP_N(240) ),
+		.mode_clkcontrol = LCD_CLKCONTROL_PCD_N(1),
+		.mode_pwmdiv = 0,
+		.mode_pwmhi = 0,
+		.mode_toyclksrc =
+			((1<<7) | (1<<6) | (1<<5)),
+		.mode_backlight = 6
 	},
 
-	{ /* 1: Pb1100 LCDC 640x480 TFT panel */
-		640, /* xres */
-		480, /* yres */
-		16,  /* bpp  */
-
-		"Generic_640x480_16",
-
-		/* mode_control */
-		0x004806a | LCD_DEFAULT_PIX_FORMAT,
-
-		/* mode_horztiming */
-		0x3434d67f,
-
-		/* mode_verttiming */
-		0x0e0e39df,
-
-		/* mode_clkcontrol */
-		( 0
-		/*LCD_CLKCONTROL_IB*/
-		/*LCD_CLKCONTROL_IC*/
-		/*LCD_CLKCONTROL_IH*/
-		/*LCD_CLKCONTROL_IV*/
-		| LCD_CLKCONTROL_PCD_N(1) ),
-
-		/* mode_pwmdiv */
-		0,
-
-		/* mode_pwmhi */
-		0,
-
-		/* mode_toyclksrc */
-		((1<<7) | (1<<6) | (0<<5)),
-
-		/* mode_backlight */
-		7
+	{ /* Hitachi SP14Q005 (and possibly others) */
+		.xres = 320,
+		.yres = 240,
+		.bpp = 4,
+		.panel_name = "Hitachi_SP14Qxxx",
+		.mode_control =
+			( LCD_CONTROL_C
+			| LCD_DEFAULT_PIX_FORMAT
+			| LCD_CONTROL_BPP_4 ),
+		.mode_horztiming =
+			( LCD_HORZTIMING_HN2_N(1)
+			| LCD_HORZTIMING_HN1_N(1)
+			| LCD_HORZTIMING_HPW_N(1)
+			| LCD_HORZTIMING_PPL_N(320) ),
+		.mode_verttiming =
+			( LCD_VERTTIMING_VN2_N(1)
+			| LCD_VERTTIMING_VN1_N(1)
+			| LCD_VERTTIMING_VPW_N(1)
+			| LCD_VERTTIMING_LPP_N(240) ),
+		.mode_clkcontrol = LCD_CLKCONTROL_PCD_N(4),
+		.mode_pwmdiv = 0,
+		.mode_pwmhi = 0,
+		.mode_toyclksrc =
+			((1<<27) | (1<<26) | (1<<25) | (1<<7) | (1<<6) | (1<<5)),
+		.mode_backlight = 6
 	},
 
-	{ /* 2: Pb1100 LCDB 640x480 PrimeView TFT panel */
-		640, /* xres */
-		480, /* yres */
-		16,  /* bpp  */
-
-		"PrimeView_640x480_16",
-
-		/* mode_control */
-		0x0004886a | LCD_DEFAULT_PIX_FORMAT,
-
-		/* mode_horztiming */
-		0x0e4bfe7f,
-
-		/* mode_verttiming */
-		0x210805df,
-
-		/* mode_clkcontrol */
-		0x00038001,
-
-		/* mode_pwmdiv */
-		0,
-
-		/* mode_pwmhi */
-		0,
-
-		/* mode_toyclksrc */
-		((1<<7) | (1<<6) | (0<<5)),
-
-		/* mode_backlight */
-		7
+	{ /* Pb1100 LCDC 640x480 TFT panel */
+		.xres = 640,
+		.yres = 480,
+		.bpp = 16,
+		.panel_name = "Generic_640x480_16",
+		.mode_control = 0x004806a | LCD_DEFAULT_PIX_FORMAT,
+		.mode_horztiming = 0x3434d67f,
+		.mode_verttiming = 0x0e0e39df,
+		.mode_clkcontrol = LCD_CLKCONTROL_PCD_N(1),
+		.mode_pwmdiv = 0,
+		.mode_pwmhi = 0,
+		.mode_toyclksrc =
+			((1<<7) | (1<<6) | (0<<5)),
+		.mode_backlight = 7
 	},
 
-	{ /* 3: Pb1100 800x600x16bpp NEON CRT */
-		800, /* xres */
-		600, /* yres */
-		16,  /* bpp */
-
-		"NEON_800x600_16",
-
-		/* mode_control */
-		0x0004886A | LCD_DEFAULT_PIX_FORMAT,
-
-		/* mode_horztiming */
-		0x005AFF1F,
-
-		/* mode_verttiming */
-		0x16000E57,
-
-		/* mode_clkcontrol */
-		0x00020000,
-
-		/* mode_pwmdiv */
-		0,
-
-		/* mode_pwmhi */
-		0,
-
-		/* mode_toyclksrc */
-		((1<<7) | (1<<6) | (0<<5)),
-
-		/* mode_backlight */
-		7
+	{ /* Pb1100 LCDB 640x480 PrimeView TFT panel */
+		.xres = 640,
+		.yres = 480,
+		.bpp = 16,
+		.panel_name = "PrimeView_640x480_16",
+		.mode_control = 0x0004886a | LCD_DEFAULT_PIX_FORMAT,
+		.mode_horztiming = 0x0e4bfe7f,
+		.mode_verttiming = 0x210805df,
+		.mode_clkcontrol = 0x00038001,
+		.mode_pwmdiv = 0,
+		.mode_pwmhi = 0,
+		.mode_toyclksrc =
+			((1<<7) | (1<<6) | (0<<5)),
+		.mode_backlight = 7
 	},
 
-	{ /* 4: Pb1100 640x480x16bpp NEON CRT */
-		640, /* xres */
-		480, /* yres */
-		16,  /* bpp */
-
-		"NEON_640x480_16",
-
-		/* mode_control */
-		0x0004886A | LCD_DEFAULT_PIX_FORMAT,
-
-		/* mode_horztiming */
-		0x0052E27F,
-
-		/* mode_verttiming */
-		0x18000DDF,
-
-		/* mode_clkcontrol */
-		0x00020000,
-
-		/* mode_pwmdiv */
-		0,
-
-		/* mode_pwmhi */
-		0,
-
-  /* mode_toyclksrc */
-  ((1<<7) | (1<<6) | (0<<5)),
+ { /* Pb1100 800x600x16bpp NEON CRT */
+  .xres = 800,
+  .yres = 600,
+  .bpp = 16,
+  .panel_name = "NEON_800x600_16",
+  .mode_control = 0x0004886A | LCD_DEFAULT_PIX_FORMAT,
+  .mode_horztiming = 0x005AFF1F,
+  .mode_verttiming = 0x16000E57,
+  .mode_clkcontrol = 0x00020000,
+  .mode_pwmdiv = 0,
+  .mode_pwmhi = 0,
+  .mode_toyclksrc =
+   ((1<<7) | (1<<6) | (0<<5)),
+  .mode_backlight = 7
+ },
 
-  /* mode_backlight */
-  7
+ { /* Pb1100 640x480x16bpp NEON CRT */
+  .xres = 640,
+  .yres = 480,
+  .bpp = 16,
+  .panel_name = "NEON_640x480_16",
+  .mode_control = 0x0004886A | LCD_DEFAULT_PIX_FORMAT,
+  .mode_horztiming = 0x0052E27F,
+  .mode_verttiming = 0x18000DDF,
+  .mode_clkcontrol = 0x00020000,
+  .mode_pwmdiv = 0,
+  .mode_pwmhi = 0,
+  .mode_toyclksrc =
+   ((1<<7) | (1<<6) | (0<<5)),
+  .mode_backlight = 7
  },
+
+ { /* Prime View PD104SL5
+      800x600 16BPP color LCD */
+  .xres = 800,
+  .yres = 640,
+  .bpp = 16,
+  .panel_name = "PrimeView_PD104SL5",
+  .mode_control =
+   ( LCD_CONTROL_SBPPF_565
+   | LCD_CONTROL_C
+   | LCD_CONTROL_SM_0
+   | LCD_DEFAULT_PIX_FORMAT
+   | LCD_CONTROL_CCO
+   | LCD_CONTROL_PT
+   | LCD_CONTROL_PC
+   | LCD_CONTROL_BPP_16 ),
+  .mode_horztiming =
+   ( LCD_HORZTIMING_HN2_N(30)
+   | LCD_HORZTIMING_HN1_N(30)
+   | LCD_HORZTIMING_HPW_N(60)
+   | LCD_HORZTIMING_PPL_N(800) ),
+  .mode_verttiming =
+   ( LCD_VERTTIMING_VN2_N(1)
+   | LCD_VERTTIMING_VN1_N(1)
+   | LCD_VERTTIMING_VPW_N(2)
+   | LCD_VERTTIMING_LPP_N(600) ),
+  .mode_clkcontrol =
+   ( LCD_CLKCONTROL_IH
+   | LCD_CLKCONTROL_IV
+   | LCD_CLKCONTROL_PCD_N(1)),
+  .mode_toyclksrc = ((1<<27) | (0<<26) | (1<<25) | (1<<7) | (1<<6) | (0<<5)),
+  .mode_backlight = 7
+ }
 };
 #endif /* _AU1100LCD_H */
