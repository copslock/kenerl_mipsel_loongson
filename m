Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Oct 2004 17:31:09 +0100 (BST)
Received: from 67-121-164-6.ded.pacbell.net ([IPv6:::ffff:67.121.164.6]:60921
	"EHLO mailserver.sunrisetelecom.com") by linux-mips.org with ESMTP
	id <S8224919AbUJ1Qaz>; Thu, 28 Oct 2004 17:30:55 +0100
Received: from there ([192.168.50.222]) by mailserver.sunrisetelecom.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 28 Oct 2004 09:30:39 -0700
Content-Type: text/plain;
  charset="iso-8859-1"
From: Karl Lessard <klessard@sunrisetelecom.com>
To: linux-mips@linux-mips.org
Subject: [PATCH] New AU1100 FB driver
Date: Thu, 28 Oct 2004 12:27:55 -0400
X-Mailer: KMail [version 1.3.2]
Cc: ppopov@embeddedalley.com, ralf@linux-mips.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <MAILSERVERGRj7TjW9W00000de7@mailserver.sunrisetelecom.com>
X-OriginalArrivalTime: 28 Oct 2004 16:30:39.0987 (UTC) FILETIME=[7646FC30:01C4BD0B]
Return-Path: <klessard@sunrisetelecom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: klessard@sunrisetelecom.com
Precedence: bulk
X-list: linux-mips

Hi all,

This is a new framebuffer driver for the AU1100 LCD controller that runs with
kernels 2.6. It has been largly modified, as you can see by the size of the
patch.  The FB-driver interface has changed a lot since kernels 2.4. Also,
this new driver is now more flexible on its way, and handles more display
settings (...and I've to admit I've done a bit a cleanup). Here's a brief
explanation.

First, in the old drivers, all mode-dependent settings were hardcoded in the
"panel" structure, so only one mode was possible for a panel. Now, the panel
only describe mode-independent data, has its ranges for frequency, pixel
clock and resolution. Then when a application try to set a mode, we validate
it into those ranges (check_var) and set the controller properly (set_par).
So now, you can add to the kernel args the video mode you want to use for
your fbconsole. The old "panel:" option still remains to specify which panel
your exactly using. Here's a example of argumets to boot the Pb1100 board in
8bpp mode:

video=au1100fb:panel:Sharp_LQ038Q5DR01,320x240-8

or set the s10 switch to 1, and remove the panel option:

video=au1100fb:320x240-8

Also, in 16bpp, all RGB formats supported by the controller can be used
(before it was hardcoded to 565), swivel modes and screen panning (only in
 Y). Support for STN dual-panels has also be added, but never tested.

To allow the use of different resolutions (for panels that supports it), the
LCD clock has been set to a static 48MHz (tell me if I shouldn't do so). The
pixel clock is taken from the mode data (see fb_var), and adjust to a divider
of LCD clock, only lcd_clkcontrol is updated on a mode switch. So we don't
need to set a fixed pixel clock for a panel anymore.

For now, the driver has only been tested on a Pb1100 board with a
LQ038Q5DR01 Sharp LCD panel, in 1bpp, 2bpp, 4bpp, 8bpp, 12bpp and 16bpp
modes. Other panels should be registered later on in the same way as the
Sharp panel (see known_panels in au1100fb.h).

Things left to do:
- suspend and resume the controller device
- add other known panels

Known bugs:
- 12bpp display mode gives bad colors

Please e-mail directly for any questions, I have no access to the mailing
list from my inbox.

Thanks,
Karl Lessard <klessard@sunrisetelecom.com>


Index: arch/mips/au1000/common/platform.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/common/platform.c,v
retrieving revision 1.1
diff -u -r1.1 platform.c
--- arch/mips/au1000/common/platform.c	10 Oct 2004 17:56:25 -0000	1.1
+++ arch/mips/au1000/common/platform.c	28 Oct 2004 15:11:27 -0000
@@ -15,6 +15,9 @@

 #include <asm/mach-au1x00/au1000.h>

+/*** USB OHCI host controller ***/
+
+#ifdef CONFIG_USB_OHCI_HCD
 static struct resource au1xxx_usb_ohci_resources[] = {
 	[0] = {
 		.start		= USB_OHCI_BASE,
@@ -41,14 +44,72 @@
 	.num_resources	= ARRAY_SIZE(au1xxx_usb_ohci_resources),
 	.resource	= au1xxx_usb_ohci_resources,
 };
+#endif
+
+/*** AU1100 LCD controller ***/
+
+#ifdef CONFIG_FB_AU1100
+static struct resource au1100_lcd_resources[] = {
+	[0] = {
+		.start		= AU1100_LCD_BASE,
+		.end		= AU1100_LCD_BASE + AU1100_LCD_LEN,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= AU1100_LCD_INT,
+		.end		= AU1100_LCD_INT,
+		.flags		= IORESOURCE_IRQ,
+	}
+};
+
+/* The dmamask must be set for AU1100 LCD to work */
+static u64 au1100_lcd_dmamask = ~(u32)0;
+
+static struct platform_device au1100_lcd_device = {
+	.name		= "au1100-lcd",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1100_lcd_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+	.num_resources  = ARRAY_SIZE(au1100_lcd_resources),
+	.resource       = au1100_lcd_resources,
+};
+#endif
+
+/***/

 static struct platform_device *au1xxx_platform_devices[] __initdata = {
+#ifdef CONFIG_USB_OHCI_HCD
 	&au1xxx_usb_ohci_device,
+#endif
+#ifdef CONFIG_FB_AU1100
+	&au1100_lcd_device,
+#endif
 };

 int au1xxx_platform_init(void)
 {
-	return platform_add_devices(au1xxx_platform_devices,
ARRAY_SIZE(au1xxx_platform_devices));
+	int ret = platform_add_devices(au1xxx_platform_devices,
+				       ARRAY_SIZE(au1xxx_platform_devices));
+	if (ret < 0) {
+		printk(KERN_ERR __FILE__
+		       ": fail to register au1xxx platform devices (err: %d)\n",
+		       ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+void au1xxx_platform_exit(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(au1xxx_platform_devices); i++) {
+		platform_device_unregister(au1xxx_platform_devices[i]);
+	}
 }

 arch_initcall(au1xxx_platform_init);
+__exitcall(au1xxx_platform_exit);
Index: arch/mips/au1000/common/setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/common/setup.c,v
retrieving revision 1.20
diff -u -r1.20 setup.c
--- arch/mips/au1000/common/setup.c	11 Oct 2004 20:01:14 -0000	1.20
+++ arch/mips/au1000/common/setup.c	28 Oct 2004 15:11:28 -0000
@@ -108,11 +108,10 @@
     if ((argptr = strstr(argptr, "video=")) == NULL) {
         argptr = prom_getcmdline();
         /* default panel */
-        /*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
 #ifdef CONFIG_MIPS_HYDROGEN3
          strcat(argptr, "
video=au1100fb:panel:Hydrogen_3_NEC_panel_320x240,nohwcursor");
 #else
-        strcat(argptr, " video=au1100fb:panel:s10,nohwcursor");
+        /*strcat(argptr, " video=au1100fb:panel:Sharp_LQ038Q5DR01");*/
 #endif
     }
 #endif
Index: drivers/video/Kconfig
===================================================================
RCS file: /home/cvs/linux/drivers/video/Kconfig,v
retrieving revision 1.29
diff -u -r1.29 Kconfig
--- drivers/video/Kconfig	25 Oct 2004 20:44:39 -0000	1.29
+++ drivers/video/Kconfig	28 Oct 2004 15:11:33 -0000
@@ -909,7 +909,7 @@

 config FB_AU1100
 	bool "Au1100 LCD Driver"
-	depends on FB && EXPERIMENTAL && PCI && MIPS && MIPS_PB1100=y
+	depends on FB && MIPS && MIPS_PB1100=y

 config FB_SBUS
 	bool "SBUS and UPA framebuffers"
Index: drivers/video/Makefile
===================================================================
RCS file: /home/cvs/linux/drivers/video/Makefile,v
retrieving revision 1.84
diff -u -r1.84 Makefile
--- drivers/video/Makefile	12 Oct 2004 01:45:47 -0000	1.84
+++ drivers/video/Makefile	28 Oct 2004 15:11:33 -0000
@@ -89,7 +89,7 @@
 obj-$(CONFIG_FB_PMAGB_B)	  += pmagb-b-fb.o  cfbfillrect.o cfbcopyarea.o
cfbimgblt.o
 obj-$(CONFIG_FB_MAXINE)		  += maxinefb.o  cfbfillrect.o cfbcopyarea.o
cfbimgblt.o
 obj-$(CONFIG_FB_TX3912)		  += tx3912fb.o  cfbfillrect.o cfbcopyarea.o
cfbimgblt.o
-obj-$(CONFIG_FB_AU1100)		  += au1100fb.o fbgen.o
+obj-$(CONFIG_FB_AU1100)		  += au1100fb.o cfbfillrect.o cfbcopyarea.o
cfbimgblt.o


 # Platform or fallback drivers go here
Index: drivers/video/au1100fb.c
===================================================================
RCS file: /home/cvs/linux/drivers/video/au1100fb.c,v
retrieving revision 1.3
diff -u -r1.3 au1100fb.c
--- drivers/video/au1100fb.c	26 Oct 2004 02:23:08 -0000	1.3
+++ drivers/video/au1100fb.c	28 Oct 2004 15:11:34 -0000
@@ -9,6 +9,9 @@
  * Copyright 2002 Alchemy Semiconductor
  * Author: Alchemy Semiconductor
  *
+ * Rewritten during Linux 2.6 port
+ *  by Karl Lessard <klessard@sunrisetelecom.com>
+ *
  * Based on:
  * linux/drivers/video/skeletonfb.c -- Skeleton for a frame buffer device
  *  Created 28 Dec 1997 by Geert Uytterhoeven
@@ -39,358 +42,671 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
 #include <linux/fb.h>
 #include <linux/init.h>
-#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/ctype.h>
+#include <linux/dma-mapping.h>

-#include <asm/au1000.h>
-#include <asm/pb1100.h>
-#include "au1100fb.h"
+#include <asm/mach-au1x00/au1000.h>

-#include <video/fbcon.h>
-#include <video/fbcon-mfb.h>
-#include <video/fbcon-cfb2.h>
-#include <video/fbcon-cfb4.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-cfb16.h>
+#define DEBUG 1
+#define SIMULATOR 0
+
+#include "au1100fb.h"

 /*
  * Sanity check. If this is a new Au1100 based board, search for
  * the PB1100 ifdefs to make sure you modify the code accordingly.
  */
-#if defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1100) ||
defined(CONFIG_MIPS_HYDROGEN3)
+#if defined(CONFIG_MIPS_PB1100)
+  #include <asm/mach-pb1x00/pb1100.h>
+#elif defined(CONFIG_MIPS_DB1100)
+  #include <asm/mach-db1x00/db1x00.h>
 #else
-error Unknown Au1100 board
+  #error "Unknown Au1100 board, Au1100 FB driver not supported"
 #endif

-#define CMAPSIZE 16
+#define DRIVER_NAME "au1100fb"
+#define DRIVER_DESC "LCD controller driver for AU1100 processors"

-static int my_lcd_index; /* default is zero */
-struct known_lcd_panels *p_lcd;
-AU1100_LCD *p_lcd_reg = (AU1100_LCD *)AU1100_LCD_ADDR;
-
-struct au1100fb_info {
-	struct fb_info_gen gen;
-	unsigned long fb_virt_start;
-	unsigned long fb_size;
-	unsigned long fb_phys;
-	int mmaped;
-	int nohwcursor;
+#define to_au1100fb_device(_info) \
+	  (_info ? container_of(_info, struct au1100fb_device, fb_info) : NULL);

-	struct { unsigned red, green, blue, pad; } palette[256];
+/* Driver global data */
+struct au1100fb_drv_info
+{
+        struct au1100fb_panel  *lcd_panel;
+	char*			opt_mode;

-#if defined(FBCON_HAS_CFB16)
-	u16 fbcon_cmap16[16];
-#endif
-};
+} drv_info = { NULL, 0 };

+/* Bitfields format supported by the controller. Note that the order of
formats
+ * SHOULD be the same as in the LCD_CONTROL_SBPPF field, so we can retrieve
the
+ * right pixel format by doing rgb_bitfields[LCD_CONTROL_SBPPF_XXX >>
LCD_CONTROL_SBPPF]
+ */
+struct fb_bitfield rgb_bitfields[][4] =
+{
+  	/*     Red, 	   Green, 	 Blue, 	     Transp   */
+	{ { 10, 6, 0 }, { 5, 5, 0 }, { 0, 5, 0 }, { 0, 0, 0 } },
+	{ { 11, 5, 0 }, { 5, 6, 0 }, { 0, 5, 0 }, { 0, 0, 0 } },
+	{ { 11, 5, 0 }, { 6, 5, 0 }, { 0, 6, 0 }, { 0, 0, 0 } },
+	{ { 10, 5, 0 }, { 5, 5, 0 }, { 0, 5, 0 }, { 15, 1, 0 } },
+	{ { 11, 5, 0 }, { 6, 5, 0 }, { 1, 5, 0 }, { 0, 1, 0 } },

-struct au1100fb_par {
-        struct fb_var_screeninfo var;
-
-	int line_length;  // in bytes
-	int cmap_len;     // color-map length
+	/* The last is used to describe 12bpp format */
+	{ { 8, 4, 0 },  { 4, 4, 0 }, { 0, 4, 0 }, { 0, 0, 0 } },
 };

+/*-------------------------------------------------------------------------*
/

-static struct au1100fb_info fb_info;
-static struct au1100fb_par current_par;
-static struct display disp;
-
-int au1100fb_init(void);
-void au1100fb_setup(char *options, int *ints);
-static int au1100fb_mmap(struct fb_info *fb, struct file *file,
-		struct vm_area_struct *vma);
-static int au1100_blank(int blank_mode, struct fb_info_gen *info);
-static int au1100fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-			  u_long arg, int con, struct fb_info *info);
-
-void au1100_nocursor(struct display *p, int mode, int xx, int yy){};
-
-static struct fb_ops au1100fb_ops = {
-	owner:		THIS_MODULE,
-	fb_get_fix:	fbgen_get_fix,
-	fb_get_var:	fbgen_get_var,
-	fb_set_var:	fbgen_set_var,
-	fb_get_cmap:	fbgen_get_cmap,
-	fb_set_cmap:	fbgen_set_cmap,
-	fb_pan_display: fbgen_pan_display,
-        fb_ioctl:       au1100fb_ioctl,
-	fb_mmap:        au1100fb_mmap,
-};
+/* Helpers */

-static void au1100_detect(void)
+static void
+au1100fb_update_fbinfo(struct fb_info *fbi)
 {
-	/*
-	 *  This function should detect the current video mode settings
-	 *  and store it as the default video mode
-	 */
+	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
+
+	/* Update var-dependent FB info */
+	if (panel_is_active(fbdev->panel) || panel_is_color(fbdev->panel)) {
+		if (fbi->var.bits_per_pixel <= 8) {
+			/* palettized */
+			fbi->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+			fbi->fix.line_length = fbi->var.xres_virtual /
+							(8/fbi->var.bits_per_pixel);
+		} else {
+			/* non-palettized */
+			fbi->fix.visual = FB_VISUAL_TRUECOLOR;
+			fbi->fix.line_length = fbi->var.xres_virtual << 1; /* depth=16 */
+		}
+	} else {
+		/* mono */
+		fbi->fix.visual = FB_VISUAL_MONO10;
+		fbi->fix.line_length = fbi->var.xres_virtual / 8;
+	}
+
+	fbi->screen_size = fbi->fix.line_length * fbi->var.yres_virtual;
+}

-	/*
-	 * Yeh, well, we're not going to change any settings so we're
-	 * always stuck with the default ...
-	 */
+static int
+au1100fb_match_rgb(struct fb_var_screeninfo *var)
+{
+	size_t bf_size = sizeof(struct fb_bitfield);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rgb_bitfields); i++) {
+		if (!memcmp(&var->red, &rgb_bitfields[i][0], bf_size) &&
+		    !memcmp(&var->green, &rgb_bitfields[i][1], bf_size) &&
+		    !memcmp(&var->blue, &rgb_bitfields[i][2], bf_size) &&
+		    !memcmp(&var->transp, &rgb_bitfields[i][3], bf_size))
+			return i;
+	}

+	return -1;
 }

-static int au1100_encode_fix(struct fb_fix_screeninfo *fix,
-		const void *_par, struct fb_info_gen *_info)
+#if DEBUG
+static inline void
+au1100fb_dump_registers(struct au1100fb_regs *regs)
 {
-        struct au1100fb_info *info = (struct au1100fb_info *) _info;
-        struct au1100fb_par *par = (struct au1100fb_par *) _par;
-	struct fb_var_screeninfo *var = &par->var;
+	int active = regs->lcd_control & LCD_CONTROL_PT;
+	int color = regs->lcd_control & LCD_CONTROL_PC;
+	int format = regs->lcd_control & LCD_CONTROL_SBPPF_MASK;
+	int pixclock;
+	int refresh;
+	int bpp = 0;
+
+	switch (regs->lcd_control & LCD_CONTROL_BPP_MASK) {
+		case LCD_CONTROL_BPP_1: bpp = 1; break;
+		case LCD_CONTROL_BPP_2: bpp = 2; break;
+		case LCD_CONTROL_BPP_4: bpp = 4; break;
+		case LCD_CONTROL_BPP_8: bpp = 8; break;
+		case LCD_CONTROL_BPP_12: bpp = 12; break;
+		case LCD_CONTROL_BPP_16: bpp = 16; break;
+	}

-	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
+	pixclock = (2 * ((regs->lcd_clkcontrol & LCD_CLKCONTROL_PCD_MASK) + 1));
+	pixclock = AU1100_LCD_MAX_CLK / pixclock;

-	fix->smem_start = info->fb_phys;
-	fix->smem_len = info->fb_size;
-	fix->type = FB_TYPE_PACKED_PIXELS;
-	fix->type_aux = 0;
-        fix->visual = (var->bits_per_pixel == 8) ?
-	       	FB_VISUAL_PSEUDOCOLOR	: FB_VISUAL_TRUECOLOR;
-	fix->ywrapstep = 0;
-	fix->xpanstep = 1;
-	fix->ypanstep = 1;
-	fix->line_length = current_par.line_length;
+	refresh = ((regs->lcd_horztiming & LCD_HORZTIMING_HN2_MASK)
+				>> LCD_HORZTIMING_HN2_BIT)
+		 +((regs->lcd_horztiming & LCD_HORZTIMING_HN1_MASK)
+				>> LCD_HORZTIMING_HN1_BIT)
+		 +((regs->lcd_horztiming & LCD_HORZTIMING_HPW_MASK)
+				>> LCD_HORZTIMING_HPW_BIT)
+		 +((regs->lcd_horztiming & LCD_HORZTIMING_PPL_MASK)
+				>> LCD_HORZTIMING_PPL_BIT)
+		 + 4 /* adjust */;
+
+	refresh *= ((regs->lcd_verttiming & LCD_VERTTIMING_VN2_MASK)
+				>> LCD_VERTTIMING_VN2_BIT)
+		 +((regs->lcd_verttiming & LCD_VERTTIMING_VN1_MASK)
+				>> LCD_VERTTIMING_VN1_BIT)
+		 +((regs->lcd_verttiming & LCD_VERTTIMING_VPW_MASK)
+				>> LCD_VERTTIMING_VPW_BIT)
+		 +((regs->lcd_verttiming & LCD_VERTTIMING_LPP_MASK)
+				>> LCD_VERTTIMING_LPP_BIT)
+		 + 4 /* adjust */;
+
+	refresh = (pixclock * 1000) / refresh;
+
+	print_dbg("");
+	print_dbg("LCD controller register dump:");
+
+	print_dbg("");
+	print_dbg("     control:    0x%08x", regs->lcd_control);
+	print_dbg("     intstatus:  0x%08x", regs->lcd_intstatus);
+	print_dbg("     intenable:  0x%08x", regs->lcd_intenable);
+	print_dbg("     horztiming: 0x%08x", regs->lcd_horztiming);
+	print_dbg("     verttiming: 0x%08x", regs->lcd_verttiming);
+	print_dbg("     clkcontrol: 0x%08x", regs->lcd_clkcontrol);
+	print_dbg("     dmaaddr0:   0x%08x", regs->lcd_dmaaddr0);
+	print_dbg("     dmaaddr1:   0x%08x", regs->lcd_dmaaddr1);
+	print_dbg("     words:      0x%08x", regs->lcd_words);
+	print_dbg("     pwmdiv:     0x%08x", regs->lcd_pwmdiv);
+	print_dbg("     pwmhi:      0x%08x", regs->lcd_pwmhi);
+
+	print_dbg("");
+	print_dbg("     %s %s %s panel",
+		  active ? "TFT" : "STN",
+		  color ? "color" : "monochrome",
+		  active ? (regs->lcd_control & LCD_CONTROL_DB ? "12 pins" : "16 pins")
+		         : (color ? (regs->lcd_control & LCD_CONTROL_DP ? "dual"
+				 				      	: "single")
+			 	  : (regs->lcd_control & LCD_CONTROL_MPI ? "8 bit"
+							                 : "4 bit")
+			   )
+		 );
+	print_dbg("     %dbpp%s %dx%d display at %dHz",
+		  bpp,
+		  (bpp == 16) ? ((format == LCD_CONTROL_SBPPF_655) ? " 655" :
+				 (format == LCD_CONTROL_SBPPF_565) ? " 565" :
+				 (format == LCD_CONTROL_SBPPF_556) ? " 556" :
+				 (format == LCD_CONTROL_SBPPF_1555) ? " 1555" : " 5551"
+				)
+		 	      : "",
+		  (regs->lcd_horztiming & LCD_HORZTIMING_PPL_MASK) + 1,
+		  (regs->lcd_verttiming & LCD_VERTTIMING_LPP_MASK) + 1,
+		  refresh
+		 );
+	if (regs->lcd_control & LCD_CONTROL_SM_MASK) {
+		u32 angle = regs->lcd_control & LCD_CONTROL_SM_MASK;
+		print_dbg("     Rotated at %d degrees",
+			  (angle == LCD_CONTROL_SM_90) ? 90 :
+			  (angle == LCD_CONTROL_SM_180) ? 180 : 270
+			  );
+	}
+	print_dbg("     Pixel clock: %dkHz", pixclock);
+	print_dbg("");
+}
+#endif
+
+/*-------------------------------------------------------------------------*
/ +
+/* AU1100 framebuffer driver */
+
+/* fb_open
+ * Open a new client reference for a device
+ */
+int au1100fb_fb_open(struct fb_info *fbi, int user)
+{
+	print_dbg("fb_open %p %d", fbi, user);
 	return 0;
 }

-static void set_color_bitfields(struct fb_var_screeninfo *var)
+/* fb_release
+ * Close a client reference to a device
+ */
+int au1100fb_fb_release(struct fb_info *fbi, int user)
 {
-	switch (var->bits_per_pixel) {
-	case 8:
-		var->red.offset = 0;
-		var->red.length = 8;
-		var->green.offset = 0;
-		var->green.length = 8;
-		var->blue.offset = 0;
-		var->blue.length = 8;
-		var->transp.offset = 0;
-		var->transp.length = 0;
-		break;
-	case 16:	/* RGB 565 */
-		var->red.offset = 11;
-		var->red.length = 5;
-		var->green.offset = 5;
-		var->green.length = 6;
-		var->blue.offset = 0;
-		var->blue.length = 5;
-		var->transp.offset = 0;
-		var->transp.length = 0;
-		break;
-	}
-
-	var->red.msb_right = 0;
-	var->green.msb_right = 0;
-	var->blue.msb_right = 0;
-	var->transp.msb_right = 0;
+	print_dbg("fb_release %p %d", fbi, user);
+	return 0;
 }

-static int au1100_decode_var(const struct fb_var_screeninfo *var,
-		void *_par, struct fb_info_gen *_info)
+/* fb_check_var
+ * Validate var settings with hardware restrictions and modify it if
necessary
+ */
+int au1100fb_fb_check_var(struct fb_var_screeninfo *var, struct fb_info
 *fbi) {
+	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
+	struct au1100fb_panel *panel;
+	u32 pixclock;
+	int screen_size;

-	struct au1100fb_par *par = (struct au1100fb_par *)_par;
+	print_dbg("fb_check_var %p %p", var, fbi);

-	/*
-	 * Don't allow setting any of these yet: xres and yres don't
-	 * make sense for LCD panels.
-	 */
-	if (var->xres != p_lcd->xres ||
-	    var->yres != p_lcd->yres ||
-	    var->xres != p_lcd->xres ||
-	    var->yres != p_lcd->yres) {
+	if (!fbdev)
 		return -EINVAL;
+
+	panel = fbdev->panel;
+
+	/* Make sure that the mode respect all LCD controller and
+	 * panel restrictions. */
+	var->xres = max(var->xres, panel->min_xres);
+	var->xres = min(var->xres, min(panel->max_xres, (u32)AU1100_LCD_MAX_XRES));
+	var->yres = max(var->yres, panel->min_yres);
+	var->yres = min(var->yres, min(panel->max_yres, (u32)AU1100_LCD_MAX_YRES));
+
+	/* We only support virtual mode in Y (no pitch) */
+	var->xres_virtual = var->xres;
+	var->yres_virtual = max(var->yres_virtual, var->yres);
+
+	var->bits_per_pixel = min(var->bits_per_pixel, panel->max_bpp);
+
+	screen_size = var->xres_virtual * var->yres_virtual;
+	if (var->bits_per_pixel > 8) screen_size <<= 1;
+	else screen_size /= (8/var->bits_per_pixel);
+
+	if (fbdev->fb_len < screen_size)
+		return -EINVAL; /* Virtual screen is to big, abort */
+
+	if (var->rotate) {
+		var->rotate = min(var->rotate, (u32)270);
+		if (var->rotate % 90) {
+			int diff = var->rotate % 90;
+			var->rotate -= diff;
+		}
+		if ((var->rotate != 180) &&
+		    ((var->xres > 320) || (var->yres > 240))) {
+			var->rotate = 0; /* Resolution too high for such angle */
+		}
 	}
-	if(var->bits_per_pixel != p_lcd->bpp) {
-		return -EINVAL;
+
+	/* The max LCD clock is fixed to 48MHz (value of AUX_CLK). The pixel
+	 * clock can only be obtain by dividing this value by an even integer.
+	 * Fallback to a slower pixel clock if necessary. */
+
+	pixclock = max((u32)(PICOS2KHZ(var->pixclock) * 1000),
fbi->monspecs.dclkmin);
+	pixclock = min(pixclock, min(fbi->monspecs.dclkmax,
(u32)AU1100_LCD_MAX_CLK/2));
+
+	if (AU1100_LCD_MAX_CLK % pixclock) {
+		int diff = AU1100_LCD_MAX_CLK % pixclock;
+		pixclock -= diff;
 	}

-	memset(par, 0, sizeof(struct au1100fb_par));
-	par->var = *var;
+	var->pixclock = KHZ2PICOS(pixclock);
+
+	if (!panel_is_active(panel)) {
+		int pcd = AU1100_LCD_MAX_CLK / (PICOS2KHZ(var->pixclock) * 2) - 1;
+
+		if (!panel_is_color(panel)
+			&& (panel->control_base & LCD_CONTROL_MPI) && (pcd < 3)) {
+			/* STN 8bit mono panel support is up to 6MHz pixclock */
+			var->pixclock = KHZ2PICOS(6000);
+		} else if (!pcd) {
+			/* Other STN panel support is up to 12MHz  */
+			var->pixclock = KHZ2PICOS(12000);
+		}
+	}

-	/* FIXME */
+	/* Set bitfield accordingly */
 	switch (var->bits_per_pixel) {
-		case 8:
-			par->var.bits_per_pixel = 8;
+
+		case 1:
+		case 2:
+		case 4:
+		case 8:
+			/* Pseudo color. SHOULD be the following. */
+			var->red.offset    = 0;
+			var->red.length    = var->bits_per_pixel;
+			var->red.msb_right = 0;
+
+			var->green.offset  = 0;
+			var->green.length  = var->bits_per_pixel;
+			var->green.msb_right = 0;
+
+			var->blue.offset   = 0;
+			var->blue.length   = var->bits_per_pixel;
+			var->blue.msb_right = 0;
+
+			var->transp.offset = 0;
+			var->transp.length = 0;
+			var->transp.msb_right = 0;
+
+			break;
+
+		case 12:
+		{
+			/* 12bpp True color. Use the last RGB bitfield */
+			int idx = ARRAY_SIZE(rgb_bitfields) - 1;
+
+			var->red    = rgb_bitfields[idx][0];
+			var->green  = rgb_bitfields[idx][1];
+			var->blue   = rgb_bitfields[idx][2];
+			var->transp = rgb_bitfields[idx][3];
+
 			break;
+		}
 		case 16:
-			par->var.bits_per_pixel = 16;
+		{
+			/* 16bpp True color. Check if we support it, or force default. */
+			if (au1100fb_match_rgb(var) < 0) {
+
+				int idx = LCD_CONTROL_DEFAULT_SBPPF >> LCD_CONTROL_SBPPF_BIT;
+				var->red    = rgb_bitfields[idx][0];
+				var->green  = rgb_bitfields[idx][1];
+				var->blue   = rgb_bitfields[idx][2];
+				var->transp = rgb_bitfields[idx][3];
+			}
 			break;
+		}
+
 		default:
-			printk("color depth %d bpp not supported\n",
-					var->bits_per_pixel);
+			print_dbg("Unsupported depth %dbpp", var->bits_per_pixel);
 			return -EINVAL;
-
 	}
-	set_color_bitfields(&par->var);
-	par->cmap_len = (par->var.bits_per_pixel == 8) ? 256 : 16;
+
 	return 0;
 }

-static int au1100_encode_var(struct fb_var_screeninfo *var,
-		const void *par, struct fb_info_gen *_info)
+/* fb_set_par
+ * Set hardware with var settings. This will enable the controller with a
specific
+ * mode, normally validated with the fb_check_var method
+ */
+int au1100fb_fb_set_par(struct fb_info *fbi)
 {
+	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
+	struct au1100fb_regs *regs;
+	struct fb_var_screeninfo *var;
+	u32 words, pcd;

-	*var = ((struct au1100fb_par *)par)->var;
-	return 0;
-}
+	print_dbg("fb_set_par %p", fbi);

-static void
-au1100_get_par(void *_par, struct fb_info_gen *_info)
-{
-	*(struct au1100fb_par *)_par = current_par;
-}
+	if (!fbdev)
+		return -EINVAL;

-static void au1100_set_par(const void *par, struct fb_info_gen *info)
-{
-	/* nothing to do: we don't change any settings */
-}
+ 	var = &fbi->var;
+#if SIMULATOR
+	regs = (struct au1100fb_regs*)kmalloc(sizeof(struct au1100fb_regs),
GFP_KERNEL);
+#else
+	regs = fbdev->regs;
+#endif
+	au1100fb_update_fbinfo(fbi);

-static int au1100_getcolreg(unsigned regno, unsigned *red, unsigned *green,
-			 unsigned *blue, unsigned *transp,
-			 struct fb_info *info)
-{
+	/* Stop and reconfigure controller... */
+	au1100fb_stop_controller(fbdev, 1);
+
+	/* Determine BPP mode and format */
+	regs->lcd_control = fbdev->panel->control_base |
+			    ((var->rotate/90) << LCD_CONTROL_SM_BIT);
+
+	switch (var->bits_per_pixel) {
+		case 1:
+			regs->lcd_control |= LCD_CONTROL_BPP_1;
+			break;
+		case 2:
+			regs->lcd_control |= LCD_CONTROL_BPP_2;
+			break;
+		case 4:
+			regs->lcd_control |= LCD_CONTROL_BPP_4;
+			break;
+		case 8:
+			regs->lcd_control |= LCD_CONTROL_BPP_8;
+			break;
+		case 12:
+			regs->lcd_control |= LCD_CONTROL_BPP_12;
+			break;
+		case 16:
+			regs->lcd_control |= LCD_CONTROL_BPP_16;
+			break;
+	}
+
+	if (panel_is_active(fbdev->panel)) {

-	struct au1100fb_info* i = (struct au1100fb_info*)info;
+		if (var->bits_per_pixel == 16) {

-	if (regno > 255)
-		return 1;
-
-	*red    = i->palette[regno].red;
-	*green  = i->palette[regno].green;
-	*blue   = i->palette[regno].blue;
-	*transp = 0;
+			/* Find the right pixel format for this mode */
+			int idx = au1100fb_match_rgb(var);
+			regs->lcd_control |= (idx << LCD_CONTROL_SBPPF_BIT);
+
+		} else if (var->bits_per_pixel <= 8) {
+
+			/* For TFT pallettized mode, use 565 RGB palette entries */
+			regs->lcd_control |= LCD_CONTROL_SBPPF_565;
+		}
+	}
+
+	regs->lcd_intenable = 0;
+	regs->lcd_intstatus = 0;
+
+	regs->lcd_horztiming = LCD_HORZTIMING_HN1_N(var->left_margin) |
+			       LCD_HORZTIMING_HN2_N(var->right_margin) |
+			       LCD_HORZTIMING_HPW_N(var->hsync_len) |
+			       LCD_HORZTIMING_PPL_N(var->xres);
+
+	regs->lcd_verttiming = LCD_VERTTIMING_VN1_N(var->upper_margin) |
+			       LCD_VERTTIMING_VN2_N(var->lower_margin) |
+			       LCD_VERTTIMING_VPW_N(var->vsync_len) |
+			       LCD_VERTTIMING_LPP_N(var->yres);
+
+	/* setup clock to obtain value in var->pixclock.
+	 * Note that LCD clock is setup to AUX clock, which is by default
+	 * (and assumed at) 48MHz */
+	pcd = AU1100_LCD_MAX_CLK / (PICOS2KHZ(var->pixclock) * 2) - 1;
+	regs->lcd_clkcontrol = LCD_CLKCONTROL_PCD_N(pcd) |
fbdev->panel->clkcontrol_base;
+
+	regs->lcd_dmaaddr0 = LCD_DMA_SA_N(fbdev->fb_phys);
+
+	if (panel_is_dual(fbdev->panel)) {
+		/* Second panel display seconf half of screen if possible,
+		 * otherwise display the same as the first panel */
+		if (var->yres_virtual >= (var->yres << 1)) {
+			regs->lcd_dmaaddr1 = LCD_DMA_SA_N(fbdev->fb_phys +
+							  (fbi->fix.line_length *
+						          (var->yres_virtual >> 1)));
+		} else {
+			regs->lcd_dmaaddr1 = LCD_DMA_SA_N(fbdev->fb_phys);
+		}
+	}
+
+	words = fbi->fix.line_length / sizeof(u32);
+	if (!var->rotate || (var->rotate == 180)) {
+		words *= var->yres_virtual;
+		if (var->rotate /* 180 */) {
+			words -= (words % 8); /* should be divisable by 8 */
+		}
+	}
+	regs->lcd_words = LCD_WRD_WRDS_N(words);
+
+	regs->lcd_pwmdiv = 0;
+	regs->lcd_pwmhi = 0;
+
+#if DEBUG
+	au1100fb_dump_registers(regs);
+#endif
+#if SIMULATOR
+	kfree(regs);
+#endif
+	/* Resume controller */
+	au1100fb_start_controller(fbdev);

 	return 0;
 }

-static int au1100_setcolreg(unsigned regno, unsigned red, unsigned green,
-			 unsigned blue, unsigned transp,
-			 struct fb_info *info)
+/* fb_setcolreg
+ * Set color in LCD palette.
+ */
+int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green,
unsigned blue, unsigned transp, struct fb_info *fbi)
 {
-	struct au1100fb_info* i = (struct au1100fb_info *)info;
-	u32 rgbcol;
+	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
+	u32 *palette = fbdev->regs->lcd_pallettebase;
+	u32 value;

-	if (regno > 255)
-		return 1;
+	if (regno > (AU1100_LCD_NBR_PALETTE_ENTRIES - 1))
+		return -EINVAL;

-	i->palette[regno].red    = red;
-	i->palette[regno].green  = green;
-	i->palette[regno].blue   = blue;
-
-	switch(p_lcd->bpp) {
-#ifdef FBCON_HAS_CFB8
-	case 8:
-		red >>= 10;
-		green >>= 10;
-		blue >>= 10;
-		p_lcd_reg->lcd_pallettebase[regno] = (blue&0x1f) |
-			((green&0x3f)<<5) | ((red&0x1f)<<11);
-		break;
-#endif
-#ifdef FBCON_HAS_CFB16
-	case 16:
-		i->fbcon_cmap16[regno] =
-			((red & 0xf800) >> 0) |
-			((green & 0xfc00) >> 5) |
-			((blue & 0xf800) >> 11);
-		break;
-#endif
-	default:
-		break;
+	if (fbi->var.grayscale) {
+		/* Convert color to grayscale */
+		red = green = blue =
+			(19595 * red + 38470 * green + 7471 * blue) >> 16;
+	}
+
+	if (fbi->fix.visual == FB_VISUAL_TRUECOLOR) {
+		/* Place color in the pseudopalette */
+		if (regno > 16)
+			return -EINVAL;
+
+		palette = (u32*)fbi->pseudo_palette;
+
+		red   >>= (16 - fbi->var.red.length);
+		green >>= (16 - fbi->var.green.length);
+		blue  >>= (16 - fbi->var.blue.length);
+
+		value = (red   << fbi->var.red.offset) 	|
+			(green << fbi->var.green.offset)|
+			(blue  << fbi->var.blue.offset);
+		value &= 0xFFFF;
+
+	} else if (panel_is_active(fbdev->panel)) {
+		/* COLOR TFT PALLETTIZED (use RGB 565) */
+		value = (red & 0xF800)|((green >> 5) & 0x07E0)|((blue >> 11) & 0x001F);
+		value &= 0xFFFF;
+
+	} else if (panel_is_color(fbdev->panel)) {
+		/* COLOR STN MODE */
+		value = (((panel_swap_rgb(fbdev->panel) ? blue : red) >> 12) & 0x000F) |
+			((green >> 8) & 0x00F0) |
+			(((panel_swap_rgb(fbdev->panel) ? red : blue) >> 4) & 0x0F00);
+		value &= 0xFFF;
+	} else {
+		/* MONOCHROME MODE */
+		value = (green >> 12) & 0x000F;
+		value &= 0xF;
 	}

+	palette[regno] = value;
+
 	return 0;
 }

-
-static int  au1100_blank(int blank_mode, struct fb_info_gen *_info)
+/* fb_blank
+ * Blank the screen. Depending on the mode, the screen will be
+ * activated with the backlight color, or desactivated
+ */
+int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi)
 {
+	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
+
+	print_dbg("fb_blank %d %p", blank_mode, fbi);

 	switch (blank_mode) {
-	case VESA_NO_BLANKING:
-		/* turn on panel */
-		//printk("turn on panel\n");
+
+		case VESA_NO_BLANKING:
+			/* Turn on panel */
+			fbdev->regs->lcd_control |= LCD_CONTROL_GO;
 #ifdef CONFIG_MIPS_PB1100
-		p_lcd_reg->lcd_control |= LCD_CONTROL_GO;
-		au_writew(au_readw(PB1100_G_CONTROL) | p_lcd->mode_backlight,
-			PB1100_G_CONTROL);
+			au_writew(au_readw(PB1100_G_CONTROL)
+				  | (PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD),
+				  PB1100_G_CONTROL);
 #endif
 #ifdef CONFIG_MIPS_HYDROGEN3
-		/*  Turn controller & power supply on,  GPIO213 */
-		au_writel(0x20002000, 0xB1700008);
-		au_writel(0x00040000, 0xB1900108);
-		au_writel(0x01000100, 0xB1700008);
+			/*  Turn controller & power supply on,  GPIO213 */
+			au_writel(0x20002000, 0xB1700008);
+			au_writel(0x00040000, 0xB1900108);
+			au_writel(0x01000100, 0xB1700008);
 #endif
-		au_sync();
-		break;
+			au_sync();
+			break;

-	case VESA_VSYNC_SUSPEND:
-	case VESA_HSYNC_SUSPEND:
-	case VESA_POWERDOWN:
-		/* turn off panel */
-		//printk("turn off panel\n");
+		case VESA_VSYNC_SUSPEND:
+		case VESA_HSYNC_SUSPEND:
+		case VESA_POWERDOWN:
+			/* Turn off panel */
+			fbdev->regs->lcd_control &= ~LCD_CONTROL_GO;
 #ifdef CONFIG_MIPS_PB1100
-		au_writew(au_readw(PB1100_G_CONTROL) & ~p_lcd->mode_backlight,
-			PB1100_G_CONTROL);
-		p_lcd_reg->lcd_control &= ~LCD_CONTROL_GO;
+			au_writew(au_readw(PB1100_G_CONTROL)
+				  & ~(PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD),
+				  PB1100_G_CONTROL);
 #endif
-		au_sync();
-		break;
-	default:
-		break;
+			au_sync();
+			break;
+
+		default:
+			break;

 	}
 	return 0;
 }

-static void au1100_set_disp(const void *unused, struct display *disp,
-			 struct fb_info_gen *info)
+/* fb_pan_display
+ * Pan display in x and/or y as specified
+ */
+int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info
*fbi)
 {
-	disp->screen_base = (char *)fb_info.fb_virt_start;
+	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
+	int dy;

-	switch (disp->var.bits_per_pixel) {
-#ifdef FBCON_HAS_CFB8
-	case 8:
-		disp->dispsw = &fbcon_cfb8;
-		if (fb_info.nohwcursor)
-			fbcon_cfb8.cursor = au1100_nocursor;
-		break;
-#endif
-#ifdef FBCON_HAS_CFB16
-	case 16:
-		disp->dispsw = &fbcon_cfb16;
-		disp->dispsw_data = fb_info.fbcon_cmap16;
-		if (fb_info.nohwcursor)
-			fbcon_cfb16.cursor = au1100_nocursor;
-		break;
-#endif
-	default:
-		disp->dispsw = &fbcon_dummy;
-		disp->dispsw_data = NULL;
-		break;
+	print_dbg("fb_pan_display %p %p", var, fbi);
+
+	if (!var || !fbdev) {
+		return -EINVAL;
 	}
+
+	if (var->xoffset - fbi->var.xoffset) {
+		/* No support for X panning for now! */
+		return -EINVAL;
+	}
+
+	dy = var->yoffset - fbi->var.yoffset;
+	if (dy) {
+
+		u32 dmaaddr;
+
+		print_dbg("Panning screen of %d lines", dy);
+
+		dmaaddr = fbdev->regs->lcd_dmaaddr0;
+		dmaaddr += (fbi->fix.line_length * dy);
+
+		/* TODO: Wait for current frame to finished */
+		fbdev->regs->lcd_dmaaddr0 = LCD_DMA_SA_N(dmaaddr);
+
+		if (panel_is_dual(fbdev->panel)) {
+			dmaaddr = fbdev->regs->lcd_dmaaddr1;
+			dmaaddr += (fbi->fix.line_length * dy);
+			fbdev->regs->lcd_dmaaddr0 = LCD_DMA_SA_N(dmaaddr);
+		}
+	}
+
+	return 0;
 }

-static int
-au1100fb_mmap(struct fb_info *_fb,
-	     struct file *file,
-	     struct vm_area_struct *vma)
+/* fb_rotate
+ * Rotate the display of this angle. This doesn't seems to be used by the
core,
+ * but as our hardware supports it, so why not implementing it...
+ */
+void au1100fb_fb_rotate(struct fb_info *fbi, int angle)
 {
+	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
+
+	print_dbg("fb_rotate %p %d", fbi, angle);
+
+	if (fbdev && (angle > 0) && !(angle % 90)) {
+
+		au1100fb_stop_controller(fbdev, 1);
+
+		fbdev->regs->lcd_control &= ~(LCD_CONTROL_SM_MASK);
+		fbdev->regs->lcd_control |= ((angle/90) << LCD_CONTROL_SM_BIT);
+
+		au1100fb_start_controller(fbdev);
+	}
+}
+
+/* fb_mmap
+ * Map video memory in user space. We don't use the generic fb_mmap method
mainly
+ * to allow the use of the TLB streaming flag (CCA=6)
+ */
+int au1100fb_fb_mmap(struct fb_info *fbi, struct file *file, struct
vm_area_struct *vma)
+{
+	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
 	unsigned int len;
 	unsigned long start=0, off;
-	struct au1100fb_info *fb = (struct au1100fb_info *)_fb;

 	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT)) {
 		return -EINVAL;
 	}

-	start = fb_info.fb_phys & PAGE_MASK;
-	len = PAGE_ALIGN((start & ~PAGE_MASK) + fb_info.fb_size);
+	start = fbdev->fb_phys & PAGE_MASK;
+	len = PAGE_ALIGN((start & ~PAGE_MASK) + fbdev->fb_len);

 	off = vma->vm_pgoff << PAGE_SHIFT;

@@ -401,276 +717,413 @@
 	off += start;
 	vma->vm_pgoff = off >> PAGE_SHIFT;

-	pgprot_val(vma->vm_page_prot) &= ~_CACHE_MASK;
-	//pgprot_val(vma->vm_page_prot) |= _CACHE_CACHABLE_NONCOHERENT;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	pgprot_val(vma->vm_page_prot) |= (6 << 9); //CCA=6

-	/* This is an IO map - tell maydump to skip this VMA */
 	vma->vm_flags |= VM_IO;
-
-	if (io_remap_page_range(vma->vm_start, off,
-				vma->vm_end - vma->vm_start,
-				vma->vm_page_prot)) {
+
+	if (io_remap_page_range(vma, vma->vm_start, off,
+			        vma->vm_end - vma->vm_start,
+			        vma->vm_page_prot)) {
 		return -EAGAIN;
 	}

-	fb->mmaped = 1;
 	return 0;
 }

-int au1100_pan_display(const struct fb_var_screeninfo *var,
-		       struct fb_info_gen *info)
+static struct fb_ops au1100fb_fb_ops =
 {
-	return 0;
-}
+	.owner			= THIS_MODULE,
+	.fb_open		= au1100fb_fb_open,
+	.fb_release		= au1100fb_fb_release,
+	.fb_check_var		= au1100fb_fb_check_var,
+	.fb_set_par		= au1100fb_fb_set_par,
+	.fb_setcolreg		= au1100fb_fb_setcolreg,
+	.fb_blank		= au1100fb_fb_blank,
+	.fb_pan_display		= au1100fb_fb_pan_display,
+	.fb_fillrect		= cfb_fillrect,
+	.fb_copyarea		= cfb_copyarea,
+	.fb_imageblit		= cfb_imageblit,
+	.fb_cursor		= soft_cursor,
+	.fb_rotate		= au1100fb_fb_rotate,
+	.fb_sync		= NULL,
+	.fb_ioctl		= NULL,
+	.fb_mmap		= au1100fb_fb_mmap,
+};
+
+/*-------------------------------------------------------------------------*
/

-static int au1100fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-			  u_long arg, int con, struct fb_info *info)
+static irqreturn_t au1100fb_handle_irq(int irq, void* dev_id, struct pt_regs
*regs)
 {
-	/* nothing to do yet */
-	return -EINVAL;
+	struct au1100fb_device *fbdev =
+		(struct au1100fb_device*) dev_get_drvdata((struct device*)dev_id);
+
+	/* Nothing to do for now, just clear any pending interrupt */
+	fbdev->regs->lcd_intstatus = ~LCD_INT_SD;
+
+	return IRQ_HANDLED;
 }

-static struct fbgen_hwswitch au1100_switch = {
-	au1100_detect,
-	au1100_encode_fix,
-	au1100_decode_var,
-	au1100_encode_var,
-	au1100_get_par,
-	au1100_set_par,
-	au1100_getcolreg,
-	au1100_setcolreg,
-	au1100_pan_display,
-	au1100_blank,
-	au1100_set_disp
-};
+/*-------------------------------------------------------------------------*
/

+/* AU1100 LCD device probe helpers */

-int au1100_setmode(void)
+static int au1100fb_init_mem(struct device* dev)
 {
-	int words;
+	struct au1100fb_device *fbdev = (struct au1100fb_device*)
dev_get_drvdata(dev);
+	struct resource *regs_res;
+	unsigned long page;

-	/* FIXME Need to accomodate for swivel mode and 12bpp, <8bpp*/
-	switch (p_lcd->mode_control & LCD_CONTROL_SM)
-	{
-		case LCD_CONTROL_SM_0:
-		case LCD_CONTROL_SM_180:
-		words = (p_lcd->xres * p_lcd->yres * p_lcd->bpp) / 32;
-			break;
-		case LCD_CONTROL_SM_90:
-		case LCD_CONTROL_SM_270:
-			/* is this correct? */
-		words = (p_lcd->xres * p_lcd->bpp) / 8;
-			break;
-		default:
-			printk("mode_control reg not initialized\n");
-			return -EINVAL;
+	if (!dev || !fbdev || !fbdev->panel)
+		return -EINVAL;
+
+	/* Allocate region for our registers and map them */
+	regs_res = platform_get_resource(to_platform_device(dev), IORESOURCE_MEM,
0);
+	if (!regs_res) {
+		print_err("fail to retrieve registers resource");
+		return -EFAULT;
+	}
+
+	fbdev->regs_len = regs_res->end - regs_res->start + 1;
+	fbdev->regs_phys = regs_res->start;
+
+	if (!request_mem_region(fbdev->regs_phys, fbdev->regs_len, DRIVER_NAME)) {
+		print_err("fail to lock memory region at 0x%08x", fbdev->regs_phys);
+		return -EBUSY;
+	}
+
+	fbdev->regs = (struct au1100fb_regs*)fbdev->regs_phys; /* use chip select
 */ +
+	print_dbg("Register memory map at %p", fbdev->regs);
+	print_dbg("phys=0x%08x, size=%d", fbdev->regs_phys, fbdev->regs_len);
+
+	/* Allocate the framebuffer to the maximum screen size * nbr of video
buffers */
+	fbdev->fb_len = fbdev->panel->max_xres * fbdev->panel->max_yres *
+		  	(fbdev->panel->max_bpp >> 3) * AU1100FB_NBR_VIDEO_BUFFERS;
+
+	fbdev->fb_mem = dma_alloc_coherent(dev, PAGE_ALIGN(fbdev->fb_len),
+					&fbdev->fb_phys, GFP_KERNEL);
+	if (!fbdev->fb_mem) {
+		print_err("fail to allocate frambuffer (size: %dK))",
+			  fbdev->fb_len / 1024);
+		return -ENOMEM;
 	}

 	/*
-	 * Setup LCD controller
+	 * Set page reserved so that mmap will work. This is necessary
+	 * since we'll be remapping normal memory.
 	 */
+	for (page = (unsigned long)fbdev->fb_mem;
+	     page < PAGE_ALIGN((unsigned long)fbdev->fb_mem + fbdev->fb_len);
+	     page += PAGE_SIZE) {
+#if CONFIG_DMA_NONCOHERENT
+		SetPageReserved(virt_to_page(CAC_ADDR(page)));
+#else
+		SetPageReserved(virt_to_page(page));
+#endif
+	}
+	print_dbg("Framebuffer memory map at %p", fbdev->fb_mem);
+	print_dbg("phys=0x%08x, size=%dK", fbdev->fb_phys, fbdev->fb_len / 1024);

-	p_lcd_reg->lcd_control = p_lcd->mode_control;
-	p_lcd_reg->lcd_intstatus = 0;
-	p_lcd_reg->lcd_intenable = 0;
-	p_lcd_reg->lcd_horztiming = p_lcd->mode_horztiming;
-	p_lcd_reg->lcd_verttiming = p_lcd->mode_verttiming;
-	p_lcd_reg->lcd_clkcontrol = p_lcd->mode_clkcontrol;
-	p_lcd_reg->lcd_words = words - 1;
-	p_lcd_reg->lcd_dmaaddr0 = fb_info.fb_phys;
+	return 0;
+}

-	/* turn on panel */
-#ifdef CONFIG_MIPS_PB1100
-	au_writew(au_readw(PB1100_G_CONTROL) | p_lcd->mode_backlight,
-			PB1100_G_CONTROL);
-#endif
-#ifdef CONFIG_MIPS_HYDROGEN3
-	/*  Turn controller & power supply on,  GPIO213 */
-	au_writel(0x20002000, 0xB1700008);
-	au_writel(0x00040000, 0xB1900108);
-	au_writel(0x01000100, 0xB1700008);
-#endif
+static int au1100fb_init_fbinfo(struct device* dev)
+{
+	struct au1100fb_device *fbdev = (struct au1100fb_device*)
dev_get_drvdata(dev);
+	struct fb_info *fbi;
+
+	if (!dev || !fbdev || !drv_info.lcd_panel)
+		return -EINVAL;
+
+	fbi = &fbdev->fb_info;
+	memset(fbi, 0, sizeof(struct fb_info));
+
+	fbi->fbops = &au1100fb_fb_ops;

-	p_lcd_reg->lcd_control |= LCD_CONTROL_GO;
+	/* Copy monitor specs from panel data */
+	memcpy(&fbi->monspecs, &fbdev->panel->monspecs, sizeof(struct
 fb_monspecs)); +
+	/* We first try the user mode passed in argument. If that failed,
+	 * or if no one has been specified, we default to the first mode of the
+	 * panel list. Note that after this call, var data will be set */
+	if (!fb_find_mode(&fbi->var,
+			  fbi,
+			  drv_info.opt_mode,
+			  fbi->monspecs.modedb,
+			  fbi->monspecs.modedb_len,
+			  fbi->monspecs.modedb,
+			  fbdev->panel->max_bpp)) {
+
+		print_err("Cannot find valid mode for panel %s", fbdev->panel->name);
+		return -EFAULT;
+	}
+
+	fbi->pseudo_palette = kmalloc(sizeof(u32) * 16, GFP_KERNEL);
+	if (!fbi->pseudo_palette) {
+		return -ENOMEM;
+	}
+	memset(fbi->pseudo_palette, 0, sizeof(u32) * 16);
+
+	if (fb_alloc_cmap(&fbi->cmap, AU1100_LCD_NBR_PALETTE_ENTRIES, 0) < 0) {
+		print_err("Fail to allocate colormap (%d entries)",
+			   AU1100_LCD_NBR_PALETTE_ENTRIES);
+		kfree(fbi->pseudo_palette);
+		return -EFAULT;
+	}
+
+	strncpy(fbi->fix.id, "AU1100", sizeof(fbi->fix.id));
+	fbi->fix.smem_start = fbdev->fb_phys;
+	fbi->fix.smem_len = fbdev->fb_len;
+	fbi->fix.type = FB_TYPE_PACKED_PIXELS;
+	fbi->fix.xpanstep = 1;
+	fbi->fix.ypanstep = 1;
+	fbi->fix.mmio_start = 0;
+	fbi->fix.mmio_len = 0;
+	fbi->fix.accel = FB_ACCEL_NONE;
+
+	fbi->screen_base = fbdev->fb_mem;
+
+	au1100fb_update_fbinfo(fbi);

 	return 0;
 }

+/*-------------------------------------------------------------------------*
/

-int __init au1100fb_init(void)
+/* AU1100 LCD controller device driver */
+
+int au1100fb_drv_probe(struct device *dev)
 {
-	uint32 sys_clksrc;
-	unsigned long page;
+	struct au1100fb_device *fbdev = NULL;
+	struct resource *irq_res = NULL;
+	u32 sys_clksrc;
+	int ret;

-	/*
-	* Get the panel information/display mode and update the registry
-	*/
-	p_lcd = &panels[my_lcd_index];
-
-	switch (p_lcd->mode_control & LCD_CONTROL_SM)
-	{
-		case LCD_CONTROL_SM_0:
-		case LCD_CONTROL_SM_180:
-		p_lcd->xres =
-			(p_lcd->mode_horztiming & LCD_HORZTIMING_PPL) + 1;
-		p_lcd->yres =
-			(p_lcd->mode_verttiming & LCD_VERTTIMING_LPP) + 1;
-			break;
-		case LCD_CONTROL_SM_90:
-		case LCD_CONTROL_SM_270:
-		p_lcd->yres =
-			(p_lcd->mode_horztiming & LCD_HORZTIMING_PPL) + 1;
-		p_lcd->xres =
-			(p_lcd->mode_verttiming & LCD_VERTTIMING_LPP) + 1;
-			break;
+	if (!dev)
+		return -EINVAL;
+
+	/* Allocate new device private */
+	fbdev = kmalloc(sizeof(struct au1100fb_device), GFP_KERNEL);
+	if (!fbdev) {
+		print_err("fail to allocate device private record");
+		return -ENOMEM;
 	}

-	/*
-	 * Panel dimensions x bpp must be divisible by 32
-	 */
-	if (((p_lcd->yres * p_lcd->bpp) % 32) != 0)
-		printk("VERT %% 32\n");
-	if (((p_lcd->xres * p_lcd->bpp) % 32) != 0)
-		printk("HORZ %% 32\n");
+	memset((void*)fbdev, 0, sizeof(struct au1100fb_device));
+	fbdev->panel = drv_info.lcd_panel;
+	fbdev->irq = -1;
+
+	dev_set_drvdata(dev, (void*)fbdev);
+
+	/* Init IO and framebuffer memory */
+	ret = au1100fb_init_mem(dev);
+	if (ret < 0) {
+		goto failed;
+	}

-	/*
-	 * Allocate LCD framebuffer from system memory
-	 */
-	fb_info.fb_size = (p_lcd->xres * p_lcd->yres * p_lcd->bpp) / 8;
-
-	current_par.var.xres = p_lcd->xres;
-	current_par.var.xres_virtual = p_lcd->xres;
-	current_par.var.yres = p_lcd->yres;
-	current_par.var.yres_virtual = p_lcd->yres;
-	current_par.var.bits_per_pixel = p_lcd->bpp;
-
-	/* FIX!!! only works for 8/16 bpp */
-	current_par.line_length = p_lcd->xres * p_lcd->bpp / 8; /* in bytes */
-	fb_info.fb_virt_start = (unsigned long )
-		__get_free_pages(GFP_ATOMIC | GFP_DMA,
-				get_order(fb_info.fb_size + 0x1000));
-	if (!fb_info.fb_virt_start) {
-		printk("Unable to allocate fb memory\n");
-		return -ENOMEM;
+	/* Request the IRQ line */
+	irq_res = platform_get_resource(to_platform_device(dev), IORESOURCE_IRQ,
 0); +	if (!irq_res) {
+		print_err("fail to retrieve IRQ resource");
+		ret = -EFAULT;
+		goto failed;
 	}
-	fb_info.fb_phys = virt_to_bus((void *)fb_info.fb_virt_start);

-	/*
-	 * Set page reserved so that mmap will work. This is necessary
-	 * since we'll be remapping normal memory.
-	 */
-	for (page = fb_info.fb_virt_start;
-	     page < PAGE_ALIGN(fb_info.fb_virt_start + fb_info.fb_size);
-	     page += PAGE_SIZE) {
-		SetPageReserved(virt_to_page(page));
+	ret = request_irq(irq_res->start, au1100fb_handle_irq,
+		 	  SA_INTERRUPT, "lcd", (void*)dev);
+	if (ret < 0) {
+		print_err("fail to request interrupt line %ld (err: %d)",
+			  irq_res->start, ret);
+		goto failed;
 	}

-	memset((void *)fb_info.fb_virt_start, 0, fb_info.fb_size);
+	fbdev->irq = irq_res->start;

-	/* set freqctrl now to allow more time to stabilize */
-	/* zero-out out LCD bits */
-	sys_clksrc = au_readl(SYS_CLKSRC) & ~0x000003e0;
-	sys_clksrc |= p_lcd->mode_toyclksrc;
-	au_writel(sys_clksrc, SYS_CLKSRC);
-
-	/* FIXME add check to make sure auxpll is what is expected! */
-	au1100_setmode();
-
-	fb_info.gen.parsize = sizeof(struct au1100fb_par);
-	fb_info.gen.fbhw = &au1100_switch;
-
-	strcpy(fb_info.gen.info.modename, "Au1100 LCD");
-	fb_info.gen.info.changevar = NULL;
-	fb_info.gen.info.node = -1;
-
-	fb_info.gen.info.fbops = &au1100fb_ops;
-	fb_info.gen.info.disp = &disp;
-	fb_info.gen.info.switch_con = &fbgen_switch;
-	fb_info.gen.info.updatevar = &fbgen_update_var;
-	fb_info.gen.info.blank = &fbgen_blank;
-	fb_info.gen.info.flags = FBINFO_FLAG_DEFAULT;
-
-	/* This should give a reasonable default video mode */
-	fbgen_get_var(&disp.var, -1, &fb_info.gen.info);
-	fbgen_do_set_var(&disp.var, 1, &fb_info.gen);
-	fbgen_set_disp(-1, &fb_info.gen);
-	fbgen_install_cmap(0, &fb_info.gen);
-	if (register_framebuffer(&fb_info.gen.info) < 0)
-		return -EINVAL;
-	printk(KERN_INFO "fb%d: %s frame buffer device\n",
-			GET_FB_IDX(fb_info.gen.info.node),
-			fb_info.gen.info.modename);
+	/* Setup LCD clock to AUX (48 MHz) */
+	sys_clksrc = au_readl(SYS_CLKSRC) & ~(SYS_CS_ML_MASK | SYS_CS_DL |
SYS_CS_CL);
+	au_writel((sys_clksrc | (1 << SYS_CS_ML_BIT)), SYS_CLKSRC);
+
+	/* Init FB data */
+	ret = au1100fb_init_fbinfo(dev);
+	if (ret < 0) {
+		goto failed;
+	}
+
+	/* Register new framebuffer */
+	ret = register_framebuffer(&fbdev->fb_info);
+	if (ret < 0) {
+		print_err("cannot register new framebuffer");
+		goto failed;
+	}

 	return 0;
+
+failed:
+	if (fbdev->irq >= 0) {
+		free_irq(fbdev->irq, (void*)dev);
+	}
+	if (fbdev->regs) {
+		release_mem_region(fbdev->regs_phys, fbdev->regs_len);
+	}
+	if (fbdev->fb_mem) {
+		dma_free_noncoherent(dev, fbdev->fb_len, fbdev->fb_mem, fbdev->fb_phys);
+	}
+	if (fbdev->fb_info.cmap.len != 0) {
+		fb_dealloc_cmap(&fbdev->fb_info.cmap);
+	}
+	kfree(fbdev);
+	dev_set_drvdata(dev, NULL);
+
+	return ret;
 }

+int au1100fb_drv_remove(struct device *dev)
+{
+	struct au1100fb_device *fbdev = NULL;
+
+	if (!dev)
+		return -ENODEV;
+
+	fbdev = (struct au1100fb_device*) dev_get_drvdata(dev);
+
+	au1100fb_stop_controller(fbdev, 0);
+
+	/* Clean up all probe data */
+	unregister_framebuffer(&fbdev->fb_info);
+
+	free_irq(fbdev->irq, (void*)dev);
+	release_mem_region(fbdev->regs_phys, fbdev->regs_len);
+
+	dma_free_coherent(dev, PAGE_ALIGN(fbdev->fb_len), fbdev->fb_mem,
fbdev->fb_phys);
+
+	fb_dealloc_cmap(&fbdev->fb_info.cmap);
+	kfree(fbdev->fb_info.pseudo_palette);
+	kfree((void*)fbdev);
+
+	return 0;
+}
+
+int au1100fb_drv_suspend(struct device *dev, u32 state, u32 level)
+{
+	/* TODO */
+	return 0;
+}

-void au1100fb_cleanup(struct fb_info *info)
+int au1100fb_drv_resume(struct device *dev, u32 level)
 {
-	unregister_framebuffer(info);
+	/* TODO */
+	return 0;
 }

+static struct device_driver au1100fb_driver = {
+	.name		= "au1100-lcd",
+	.bus		= &platform_bus_type,
+
+	.probe		= au1100fb_drv_probe,
+        .remove		= au1100fb_drv_remove,
+	.suspend	= au1100fb_drv_suspend,
+        .resume		= au1100fb_drv_resume,
+};
+
+/*-------------------------------------------------------------------------*
/ +
+/* Kernel driver */

-void au1100fb_setup(char *options, int *ints)
+int au1100fb_setup(char *options)
 {
 	char* this_opt;
-	int i;
-	int num_panels = sizeof(panels)/sizeof(struct known_lcd_panels);
-
-
-	if (!options || !*options)
-		return;
+	int num_panels = ARRAY_SIZE(known_lcd_panels);
+	char* mode = NULL;
+	int panel_idx = -1;
+
+	if (num_panels <= 0) {
+		print_err("No LCD panels supported by driver!");
+		return -EFAULT;
+	}

-	for(this_opt=strtok(options, ","); this_opt;
-	    this_opt=strtok(NULL, ",")) {
-		if (!strncmp(this_opt, "panel:", 6)) {
-#if defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1100)
-			/* Read Pb1100 Switch S10 ? */
-			if (!strncmp(this_opt+6, "s10", 3))
-			{
-				int panel;
-				panel = *(volatile int *)0xAE000008; /* BCSR SWITCHES */
-				panel >>= 8;
-				panel &= 0x0F;
-				if (panel >= num_panels) panel = 0;
-				my_lcd_index = panel;
-			}
-			else
-#endif
-			/* Get the panel name, everything else if fixed */
-			for (i=0; i<num_panels; i++) {
-				if (!strncmp(this_opt+6, panels[i].panel_name,
-							strlen(this_opt))) {
-					my_lcd_index = i;
-					break;
+	if (options) {
+		while ((this_opt = strsep(&options,",")) != NULL) {
+			/* Panel option */
+			if (!strncmp(this_opt, "panel:", 6)) {
+				int i;
+				this_opt += 6;
+				for (i = 0; i < num_panels; i++) {
+					if (!strncmp(this_opt,
+					      	     known_lcd_panels[i].name,
+						     strlen(this_opt))) {
+						panel_idx = i;
+						break;
+					}
+				}
+				if (i >= num_panels) {
+ 					print_warn("Panel %s not supported!", this_opt);
 				}
 			}
+			/* Mode option (only option that start with digit) */
+			else if (isdigit(this_opt[0])) {
+				mode = kmalloc(strlen(this_opt) + 1, GFP_KERNEL);
+				strncpy(mode, this_opt, strlen(this_opt) + 1);
+			}
+			/* Unsupported option */
+			else {
+				print_warn("Unsupported option \"%s\"", this_opt);
+			}
 		}
-		else if (!strncmp(this_opt, "nohwcursor", 10)) {
-			printk("nohwcursor\n");
-			fb_info.nohwcursor = 1;
-		}
-	}
+	}

-	printk("au1100fb: Panel %d %s\n", my_lcd_index,
-		panels[my_lcd_index].panel_name);
-}
+	if (panel_idx < 0) {
+#if defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1100)
+		/* Get panel from S10 Switch (board switch) */
+		panel_idx = ((*(volatile int *)BCSR_SWITCHES_REG) &
+				BCSR_SWITCHES_ROTARY_MASK) >> BCSR_SWITCHES_ROTARY_BIT;
+		if (panel_idx >= num_panels)
+#endif
+		panel_idx = 0;
+	}

+	drv_info.lcd_panel = &known_lcd_panels[panel_idx];
+	drv_info.opt_mode = mode;

+	print_info("Panel=%s Mode=%s",
+	       drv_info.lcd_panel->name,
+	       drv_info.opt_mode ? drv_info.opt_mode : "default");

-#ifdef MODULE
-MODULE_LICENSE("GPL");
-int init_module(void)
+	return 0;
+}
+
+int __init au1100fb_init(void)
 {
-	return au1100fb_init();
+	char* options;
+	int ret;
+
+	print_info("" DRIVER_DESC "");
+
+	memset(&drv_info, 0, sizeof(drv_info));
+
+	if (fb_get_options(DRIVER_NAME, &options))
+		return -ENODEV;
+
+	/* Setup driver with options */
+	ret = au1100fb_setup(options);
+	if (ret < 0) {
+		print_err("Fail to setup driver");
+		return ret;
+	}
+
+	return driver_register(&au1100fb_driver);
 }

-void cleanup_module(void)
+void __exit au1100fb_cleanup(void)
 {
-	au1100fb_cleanup(void);
+	driver_unregister(&au1100fb_driver);
+
+	if (drv_info.opt_mode)
+		kfree(drv_info.opt_mode);
 }

-MODULE_AUTHOR("Pete Popov <ppopov@mvista.com>");
-MODULE_DESCRIPTION("Au1100 LCD framebuffer device driver");
-#endif /* MODULE */
+module_init(au1100fb_init);
+module_exit(au1100fb_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
Index: drivers/video/au1100fb.h
===================================================================
RCS file: /home/cvs/linux/drivers/video/au1100fb.h,v
retrieving revision 1.1
diff -u -r1.1 au1100fb.h
--- drivers/video/au1100fb.h	14 Jul 2002 21:33:34 -0000	1.1
+++ drivers/video/au1100fb.h	28 Oct 2004 15:11:34 -0000
@@ -30,352 +30,340 @@
 #ifndef _AU1100LCD_H
 #define _AU1100LCD_H

-/********************************************************************/
-#define uint32 unsigned long
-typedef volatile struct
-{
-	uint32	lcd_control;
-	uint32	lcd_intstatus;
-	uint32	lcd_intenable;
-	uint32	lcd_horztiming;
-	uint32	lcd_verttiming;
-	uint32	lcd_clkcontrol;
-	uint32	lcd_dmaaddr0;
-	uint32	lcd_dmaaddr1;
-	uint32	lcd_words;
-	uint32	lcd_pwmdiv;
-	uint32	lcd_pwmhi;
-	uint32	reserved[(0x0400-0x002C)/4];
-	uint32	lcd_pallettebase[256];
+#include <asm/mach-au1x00/au1000.h>

-} AU1100_LCD;
+#define print_err(f, arg...) printk(KERN_ERR DRIVER_NAME ": " f "\n", ##
 arg) +#define print_warn(f, arg...) printk(KERN_WARNING DRIVER_NAME ": " f
 "\n", ## arg)
+#define print_info(f, arg...) printk(KERN_INFO DRIVER_NAME ": " f "\n", ##
arg)

-/********************************************************************/
+#if DEBUG
+#define print_dbg(f, arg...) printk(KERN_DEBUG __FILE__ ": " f "\n", ## arg)
+#else
+#define print_dbg(f, arg...) do {} while (0)
+#endif

-#define AU1100_LCD_ADDR		0xB5000000
+#if defined(__BIG_ENDIAN)
+#define LCD_CONTROL_DEFAULT_PO LCD_CONTROL_PO_11
+#else
+#define LCD_CONTROL_DEFAULT_PO LCD_CONTROL_PO_00
+#endif
+#define LCD_CONTROL_DEFAULT_SBPPF LCD_CONTROL_SBPPF_565

-/*
- * Register bit definitions
- */
+/********************************************************************/
+
+/* LCD controller restrictions */
+#define AU1100_LCD_MAX_XRES	800
+#define AU1100_LCD_MAX_YRES	600
+#define AU1100_LCD_MAX_BPP	16
+#define AU1100_LCD_MAX_CLK	48000
+#define AU1100_LCD_NBR_PALETTE_ENTRIES 256

-/* lcd_control */
-#define LCD_CONTROL_SBPPF		(7<<18)
-#define LCD_CONTROL_SBPPF_655	(0<<18)
-#define LCD_CONTROL_SBPPF_565	(1<<18)
-#define LCD_CONTROL_SBPPF_556	(2<<18)
-#define LCD_CONTROL_SBPPF_1555	(3<<18)
-#define LCD_CONTROL_SBPPF_5551	(4<<18)
-#define LCD_CONTROL_WP			(1<<17)
-#define LCD_CONTROL_WD			(1<<16)
-#define LCD_CONTROL_C			(1<<15)
-#define LCD_CONTROL_SM			(3<<13)
-#define LCD_CONTROL_SM_0		(0<<13)
-#define LCD_CONTROL_SM_90		(1<<13)
-#define LCD_CONTROL_SM_180		(2<<13)
-#define LCD_CONTROL_SM_270		(3<<13)
-#define LCD_CONTROL_DB			(1<<12)
-#define LCD_CONTROL_CCO			(1<<11)
-#define LCD_CONTROL_DP			(1<<10)
-#define LCD_CONTROL_PO			(3<<8)
-#define LCD_CONTROL_PO_00		(0<<8)
-#define LCD_CONTROL_PO_01		(1<<8)
-#define LCD_CONTROL_PO_10		(2<<8)
-#define LCD_CONTROL_PO_11		(3<<8)
-#define LCD_CONTROL_MPI			(1<<7)
-#define LCD_CONTROL_PT			(1<<6)
-#define LCD_CONTROL_PC			(1<<5)
-#define LCD_CONTROL_BPP			(7<<1)
-#define LCD_CONTROL_BPP_1		(0<<1)
-#define LCD_CONTROL_BPP_2		(1<<1)
-#define LCD_CONTROL_BPP_4		(2<<1)
-#define LCD_CONTROL_BPP_8		(3<<1)
-#define LCD_CONTROL_BPP_12		(4<<1)
-#define LCD_CONTROL_BPP_16		(5<<1)
-#define LCD_CONTROL_GO			(1<<0)
-
-/* lcd_intstatus, lcd_intenable */
-#define LCD_INT_SD				(1<<7)
-#define LCD_INT_OF				(1<<6)
-#define LCD_INT_UF				(1<<5)
-#define LCD_INT_SA				(1<<3)
-#define LCD_INT_SS				(1<<2)
-#define LCD_INT_S1				(1<<1)
-#define LCD_INT_S0				(1<<0)
-
-/* lcd_horztiming */
-#define LCD_HORZTIMING_HN2		(255<<24)
-#define LCD_HORZTIMING_HN2_N(N)	(((N)-1)<<24)
-#define LCD_HORZTIMING_HN1		(255<<16)
-#define LCD_HORZTIMING_HN1_N(N)	(((N)-1)<<16)
-#define LCD_HORZTIMING_HPW		(63<<10)
-#define LCD_HORZTIMING_HPW_N(N)	(((N)-1)<<10)
-#define LCD_HORZTIMING_PPL		(1023<<0)
-#define LCD_HORZTIMING_PPL_N(N)	(((N)-1)<<0)
-
-/* lcd_verttiming */
-#define LCD_VERTTIMING_VN2		(255<<24)
-#define LCD_VERTTIMING_VN2_N(N)	(((N)-1)<<24)
-#define LCD_VERTTIMING_VN1		(255<<16)
-#define LCD_VERTTIMING_VN1_N(N)	(((N)-1)<<16)
-#define LCD_VERTTIMING_VPW		(63<<10)
-#define LCD_VERTTIMING_VPW_N(N)	(((N)-1)<<10)
-#define LCD_VERTTIMING_LPP		(1023<<0)
-#define LCD_VERTTIMING_LPP_N(N)	(((N)-1)<<0)
-
-/* lcd_clkcontrol */
-#define LCD_CLKCONTROL_IB		(1<<18)
-#define LCD_CLKCONTROL_IC		(1<<17)
-#define LCD_CLKCONTROL_IH		(1<<16)
-#define LCD_CLKCONTROL_IV		(1<<15)
-#define LCD_CLKCONTROL_BF		(31<<10)
-#define LCD_CLKCONTROL_BF_N(N)	(((N)-1)<<10)
-#define LCD_CLKCONTROL_PCD		(1023<<0)
-#define LCD_CLKCONTROL_PCD_N(N)	((N)<<0)
-
-/* lcd_pwmdiv */
-#define LCD_PWMDIV_EN			(1<<12)
-#define LCD_PWMDIV_PWMDIV		(2047<<0)
-#define LCD_PWMDIV_PWMDIV_N(N)	(((N)-1)<<0)
-
-/* lcd_pwmhi */
-#define LCD_PWMHI_PWMHI1		(2047<<12)
-#define LCD_PWMHI_PWMHI1_N(N)	((N)<<12)
-#define LCD_PWMHI_PWMHI0		(2047<<0)
-#define LCD_PWMHI_PWMHI0_N(N)	((N)<<0)
-
-/* lcd_pallettebase - MONOCHROME */
-#define LCD_PALLETTE_MONO_MI		(15<<0)
-#define LCD_PALLETTE_MONO_MI_N(N)	((N)<<0)
-
-/* lcd_pallettebase - COLOR */
-#define LCD_PALLETTE_COLOR_BI		(15<<8)
-#define LCD_PALLETTE_COLOR_BI_N(N)	((N)<<8)
-#define LCD_PALLETTE_COLOR_GI		(15<<4)
-#define LCD_PALLETTE_COLOR_GI_N(N)	((N)<<4)
-#define LCD_PALLETTE_COLOR_RI		(15<<0)
-#define LCD_PALLETTE_COLOR_RI_N(N)	((N)<<0)
-
-/* lcd_palletebase - COLOR TFT PALLETIZED */
-#define LCD_PALLETTE_TFT_DC			(65535<<0)
-#define LCD_PALLETTE_TFT_DC_N(N)	((N)<<0)
+/* Default number of visible screen buffer to allocate */
+#define AU1100FB_NBR_VIDEO_BUFFERS 2

 /********************************************************************/

-struct known_lcd_panels
+struct au1100fb_panel
 {
-	uint32 xres;
-	uint32 yres;
-	uint32 bpp;
-	unsigned char  panel_name[256];
-	uint32 mode_control;
-	uint32 mode_horztiming;
-	uint32 mode_verttiming;
-	uint32 mode_clkcontrol;
-	uint32 mode_pwmdiv;
-	uint32 mode_pwmhi;
-	uint32 mode_toyclksrc;
-	uint32 mode_backlight;
-
+	const char name[25];		/* Full name <vendor>_<model> */
+
+	struct 	fb_monspecs monspecs; 	/* FB monitor specs */
+
+	u32   	control_base;		/* Mode-independent control values */
+	u32	clkcontrol_base;	/* Panel pixclock preferences */
+
+	u32	min_xres;		/* Minimum horizontal resolution */
+	u32	max_xres;		/* Maximum horizontal resolution */
+	u32 	min_yres;		/* Minimum vertical resolution */
+	u32 	max_yres;		/* Maximum vertical resolution */
+	u32 	max_bpp;		/* Maximum depth supported */
 };

-#if defined(__BIG_ENDIAN)
-#define LCD_DEFAULT_PIX_FORMAT LCD_CONTROL_PO_11
-#else
-#define LCD_DEFAULT_PIX_FORMAT LCD_CONTROL_PO_00
-#endif
-
-/*
- * The fb driver assumes that AUX PLL is at 48MHz.  That can
- * cover up to 800x600 resolution; if you need higher resolution,
- * you should modify the driver as needed, not just this structure.
- */
-struct known_lcd_panels panels[] =
+struct au1100fb_regs
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
+	u32  lcd_control;
+	u32  lcd_intstatus;
+	u32  lcd_intenable;
+	u32  lcd_horztiming;
+	u32  lcd_verttiming;
+	u32  lcd_clkcontrol;
+	u32  lcd_dmaaddr0;
+	u32  lcd_dmaaddr1;
+	u32  lcd_words;
+	u32  lcd_pwmdiv;
+	u32  lcd_pwmhi;
+	u32  reserved[(0x0400-0x002C)/4];
+	u32  lcd_pallettebase[256];
+};

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
+struct au1100fb_device {

-		/* mode_pwmdiv */
-		0,
+	struct fb_info fb_info;			/* FB driver info record */

-		/* mode_pwmhi */
-		0,
+	struct au1100fb_panel 	*panel;		/* Panel connected to this device */

-		/* mode_toyclksrc */
-		((1<<7) | (1<<6) | (1<<5)),
+	int irq;				/* IRQ used */

-		/* mode_backlight */
-		6
-	},
+	struct au1100fb_regs* 	regs;		/* Registers memory map */
+	size_t       		regs_len;
+	unsigned int 		regs_phys;

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
+	unsigned char* 		fb_mem;		/* FrameBuffer memory map */
+	size_t	      		fb_len;
+	dma_addr_t    		fb_phys;
+};

-		/* mode_pwmdiv */
-		0,
+/********************************************************************/

-		/* mode_pwmhi */
-		0,
+#define LCD_CONTROL                (AU1100_LCD_BASE + 0x0)
+  #define LCD_CONTROL_SBB_BIT      21
+  #define LCD_CONTROL_SBB_MASK     (0x3 << LCD_CONTROL_SBB_BIT)
+    #define LCD_CONTROL_SBB_1        (0 << LCD_CONTROL_SBB_BIT)
+    #define LCD_CONTROL_SBB_2        (1 << LCD_CONTROL_SBB_BIT)
+    #define LCD_CONTROL_SBB_3        (2 << LCD_CONTROL_SBB_BIT)
+    #define LCD_CONTROL_SBB_4        (3 << LCD_CONTROL_SBB_BIT)
+  #define LCD_CONTROL_SBPPF_BIT    18
+  #define LCD_CONTROL_SBPPF_MASK   (0x7 << LCD_CONTROL_SBPPF_BIT)
+    #define LCD_CONTROL_SBPPF_655    (0 << LCD_CONTROL_SBPPF_BIT)
+    #define LCD_CONTROL_SBPPF_565    (1 << LCD_CONTROL_SBPPF_BIT)
+    #define LCD_CONTROL_SBPPF_556    (2 << LCD_CONTROL_SBPPF_BIT)
+    #define LCD_CONTROL_SBPPF_1555   (3 << LCD_CONTROL_SBPPF_BIT)
+    #define LCD_CONTROL_SBPPF_5551   (4 << LCD_CONTROL_SBPPF_BIT)
+  #define LCD_CONTROL_WP           (1<<17)
+  #define LCD_CONTROL_WD           (1<<16)
+  #define LCD_CONTROL_C            (1<<15)
+  #define LCD_CONTROL_SM_BIT       13
+  #define LCD_CONTROL_SM_MASK      (0x3 << LCD_CONTROL_SM_BIT)
+    #define LCD_CONTROL_SM_0         (0 << LCD_CONTROL_SM_BIT)
+    #define LCD_CONTROL_SM_90        (1 << LCD_CONTROL_SM_BIT)
+    #define LCD_CONTROL_SM_180       (2 << LCD_CONTROL_SM_BIT)
+    #define LCD_CONTROL_SM_270       (3 << LCD_CONTROL_SM_BIT)
+  #define LCD_CONTROL_DB           (1<<12)
+  #define LCD_CONTROL_CCO          (1<<11)
+  #define LCD_CONTROL_DP           (1<<10)
+  #define LCD_CONTROL_PO_BIT       8
+  #define LCD_CONTROL_PO_MASK      (0x3 << LCD_CONTROL_PO_BIT)
+    #define LCD_CONTROL_PO_00        (0 << LCD_CONTROL_PO_BIT)
+    #define LCD_CONTROL_PO_01        (1 << LCD_CONTROL_PO_BIT)
+    #define LCD_CONTROL_PO_10        (2 << LCD_CONTROL_PO_BIT)
+    #define LCD_CONTROL_PO_11        (3 << LCD_CONTROL_PO_BIT)
+  #define LCD_CONTROL_MPI          (1<<7)
+  #define LCD_CONTROL_PT           (1<<6)
+  #define LCD_CONTROL_PC           (1<<5)
+  #define LCD_CONTROL_BPP_BIT      1
+  #define LCD_CONTROL_BPP_MASK     (0x7 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_1        (0 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_2        (1 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_4        (2 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_8        (3 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_12       (4 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_16       (5 << LCD_CONTROL_BPP_BIT)
+  #define LCD_CONTROL_GO           (1<<0)
+
+#define LCD_INTSTATUS              (AU1100_LCD_BASE + 0x4)
+#define LCD_INTENABLE              (AU1100_LCD_BASE + 0x8)
+  #define LCD_INT_SD               (1<<7)
+  #define LCD_INT_OF               (1<<6)
+  #define LCD_INT_UF               (1<<5)
+  #define LCD_INT_SA               (1<<3)
+  #define LCD_INT_SS               (1<<2)
+  #define LCD_INT_S1               (1<<1)
+  #define LCD_INT_S0               (1<<0)
+
+#define LCD_HORZTIMING             (AU1100_LCD_BASE + 0xC)
+  #define LCD_HORZTIMING_HN2_BIT   24
+  #define LCD_HORZTIMING_HN2_MASK  (0xFF << LCD_HORZTIMING_HN2_BIT)
+  #define LCD_HORZTIMING_HN2_N(N)  ((((N)-1) << LCD_HORZTIMING_HN2_BIT) &
LCD_HORZTIMING_HN2_MASK)
+  #define LCD_HORZTIMING_HN1_BIT   16
+  #define LCD_HORZTIMING_HN1_MASK  (0xFF << LCD_HORZTIMING_HN1_BIT)
+  #define LCD_HORZTIMING_HN1_N(N)  ((((N)-1) << LCD_HORZTIMING_HN1_BIT) &
LCD_HORZTIMING_HN1_MASK)
+  #define LCD_HORZTIMING_HPW_BIT   10
+  #define LCD_HORZTIMING_HPW_MASK  (0x3F << LCD_HORZTIMING_HPW_BIT)
+  #define LCD_HORZTIMING_HPW_N(N)  ((((N)-1) << LCD_HORZTIMING_HPW_BIT) &
LCD_HORZTIMING_HPW_MASK)
+  #define LCD_HORZTIMING_PPL_BIT   0
+  #define LCD_HORZTIMING_PPL_MASK  (0x3FF << LCD_HORZTIMING_PPL_BIT)
+  #define LCD_HORZTIMING_PPL_N(N)  ((((N)-1) << LCD_HORZTIMING_PPL_BIT) &
LCD_HORZTIMING_PPL_MASK)
+
+#define LCD_VERTTIMING             (AU1100_LCD_BASE + 0x10)
+  #define LCD_VERTTIMING_VN2_BIT   24
+  #define LCD_VERTTIMING_VN2_MASK  (0xFF << LCD_VERTTIMING_VN2_BIT)
+  #define LCD_VERTTIMING_VN2_N(N)  ((((N)-1) << LCD_VERTTIMING_VN2_BIT) &
LCD_VERTTIMING_VN2_MASK)
+  #define LCD_VERTTIMING_VN1_BIT   16
+  #define LCD_VERTTIMING_VN1_MASK  (0xFF << LCD_VERTTIMING_VN1_BIT)
+  #define LCD_VERTTIMING_VN1_N(N)  ((((N)-1) << LCD_VERTTIMING_VN1_BIT) &
LCD_VERTTIMING_VN1_MASK)
+  #define LCD_VERTTIMING_VPW_BIT   10
+  #define LCD_VERTTIMING_VPW_MASK  (0x3F << LCD_VERTTIMING_VPW_BIT)
+  #define LCD_VERTTIMING_VPW_N(N)  ((((N)-1) << LCD_VERTTIMING_VPW_BIT) &
LCD_VERTTIMING_VPW_MASK)
+  #define LCD_VERTTIMING_LPP_BIT   0
+  #define LCD_VERTTIMING_LPP_MASK  (0x3FF << LCD_VERTTIMING_LPP_BIT)
+  #define LCD_VERTTIMING_LPP_N(N)  ((((N)-1) << LCD_VERTTIMING_LPP_BIT) &
LCD_VERTTIMING_LPP_MASK)
+
+#define LCD_CLKCONTROL             (AU1100_LCD_BASE + 0x14)
+  #define LCD_CLKCONTROL_IB        (1<<18)
+  #define LCD_CLKCONTROL_IC        (1<<17)
+  #define LCD_CLKCONTROL_IH        (1<<16)
+  #define LCD_CLKCONTROL_IV        (1<<15)
+  #define LCD_CLKCONTROL_BF_BIT    10
+  #define LCD_CLKCONTROL_BF_MASK   (0x1F << LCD_CLKCONTROL_BF_BIT)
+  #define LCD_CLKCONTROL_BF_N(N)   ((((N)-1) << LCD_CLKCONTROL_BF_BIT) &
LCD_CLKCONTROL_BF_MASK)
+  #define LCD_CLKCONTROL_PCD_BIT   0
+  #define LCD_CLKCONTROL_PCD_MASK  (0x3FF << LCD_CLKCONTROL_PCD_BIT)
+  #define LCD_CLKCONTROL_PCD_N(N)  (((N) << LCD_CLKCONTROL_PCD_BIT) &
LCD_CLKCONTROL_PCD_MASK)
+
+#define LCD_DMAADDR0               (AU1100_LCD_BASE + 0x18)
+#define LCD_DMAADDR1               (AU1100_LCD_BASE + 0x1C)
+  #define LCD_DMA_SA_BIT           5
+  #define LCD_DMA_SA_MASK          (0x7FFFFFF << LCD_DMA_SA_BIT)
+  #define LCD_DMA_SA_N(N)          ((N) & LCD_DMA_SA_MASK)
+
+#define LCD_WORDS                  (AU1100_LCD_BASE + 0x20)
+  #define LCD_WRD_WRDS_BIT         0
+  #define LCD_WRD_WRDS_MASK        (0xFFFFFFFF << LCD_WRD_WRDS_BIT)
+  #define LCD_WRD_WRDS_N(N)        ((((N)-1) << LCD_WRD_WRDS_BIT) &
LCD_WRD_WRDS_MASK)
+
+#define LCD_PWMDIV                 (AU1100_LCD_BASE + 0x24)
+  #define LCD_PWMDIV_EN            (1<<12)
+  #define LCD_PWMDIV_PWMDIV_BIT    0
+  #define LCD_PWMDIV_PWMDIV_MASK   (0xFFF << LCD_PWMDIV_PWMDIV_BIT)
+  #define LCD_PWMDIV_PWMDIV_N(N)   ((((N)-1) << LCD_PWMDIV_PWMDIV_BIT) &
LCD_PWMDIV_PWMDIV_MASK)
+
+#define LCD_PWMHI                  (AU1100_LCD_BASE + 0x28)
+  #define LCD_PWMHI_PWMHI1_BIT     12
+  #define LCD_PWMHI_PWMHI1_MASK    (0xFFF << LCD_PWMHI_PWMHI1_BIT)
+  #define LCD_PWMHI_PWMHI1_N(N)    (((N) << LCD_PWMHI_PWMHI1_BIT) &
LCD_PWMHI_PWMHI1_MASK)
+  #define LCD_PWMHI_PWMHI0_BIT     0
+  #define LCD_PWMHI_PWMHI0_MASK    (0xFFF << LCD_PWMHI_PWMHI0_BIT)
+  #define LCD_PWMHI_PWMHI0_N(N)    (((N) << LCD_PWMHI_PWMHI0_BIT) &
LCD_PWMHI_PWMHI0_MASK)
+
+#define LCD_PALLETTEBASE                (AU1100_LCD_BASE + 0x400)
+  #define LCD_PALLETTE_MONO_MI_BIT      0
+  #define LCD_PALLETTE_MONO_MI_MASK     (0xF << LCD_PALLETTE_MONO_MI_BIT)
+  #define LCD_PALLETTE_MONO_MI_N(N)     (((N)<< LCD_PALLETTE_MONO_MI_BIT) &
LCD_PALLETTE_MONO_MI_MASK)
+
+  #define LCD_PALLETTE_COLOR_RI_BIT     8
+  #define LCD_PALLETTE_COLOR_RI_MASK    (0xF << LCD_PALLETTE_COLOR_RI_BIT)
+  #define LCD_PALLETTE_COLOR_RI_N(N)    (((N)<< LCD_PALLETTE_COLOR_RI_BIT) &
LCD_PALLETTE_COLOR_RI_MASK)
+  #define LCD_PALLETTE_COLOR_GI_BIT     4
+  #define LCD_PALLETTE_COLOR_GI_MASK    (0xF << LCD_PALLETTE_COLOR_GI_BIT)
+  #define LCD_PALLETTE_COLOR_GI_N(N)    (((N)<< LCD_PALLETTE_COLOR_GI_BIT) &
LCD_PALLETTE_COLOR_GI_MASK)
+  #define LCD_PALLETTE_COLOR_BI_BIT     0
+  #define LCD_PALLETTE_COLOR_BI_MASK    (0xF << LCD_PALLETTE_COLOR_BI_BIT)
+  #define LCD_PALLETTE_COLOR_BI_N(N)    (((N)<< LCD_PALLETTE_COLOR_BI_BIT) &
LCD_PALLETTE_COLOR_BI_MASK)
+
+  #define LCD_PALLETTE_TFT_DC_BIT       0
+  #define LCD_PALLETTE_TFT_DC_MASK      (0xFFFF << LCD_PALLETTE_TFT_DC_BIT)
+  #define LCD_PALLETTE_TFT_DC_N(N)      (((N)<< LCD_PALLETTE_TFT_DC_BIT) &
LCD_PALLETTE_TFT_DC_MASK)

-		/* mode_toyclksrc */
-		((1<<7) | (1<<6) | (0<<5)),
+/********************************************************************/

-		/* mode_backlight */
-		7
+/* List of default modes for a registered panel.
+ * If you want to use generic modes, set panel's modedb to NULL.
+ */
+static struct fb_videomode sharp_lq038q5dr01_modes[] =
+{
+	{
+		NULL, 0, 320, 240, KHZ2PICOS(6000), 60, 8, 17, 5, 12, 1,
+		0, FB_VMODE_NONINTERLACED, 0
 	},
+};

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
+/* List of panels known to work with the AU1100 LCD controller.
+ * To add a new panel, enter the same specifications as the
+ * Generic_TFT one, and MAKE SURE that it doesn't conflicts
+ * with the controller restrictions. Restrictions are:
+ *
+ * STN color panels: max_bpp <= 12
+ * STN mono panels: max_bpp <= 4
+ * TFT panels: max_bpp <= 16
+ * max_xres <= 800
+ * max_yres <= 600
+ */
+static struct au1100fb_panel known_lcd_panels[] =
+{
+	/*** Generic 640x480 16bpp TFT LCD ***/
+	[0] = {
+		.name = "Generic_TFT",
+		.monspecs = {
+			.modedb = NULL,
+			.modedb_len = 0,
+			.hfmin = 29000,
+			.hfmax = 30000,
+			.vfmin = 60,
+			.vfmax = 60,
+			.dclkmin = 12000,
+			.dclkmax = 12000,
+			.input = FB_DISP_RGB,
+		},
+
+		( LCD_CONTROL_C
+		| LCD_CONTROL_DEFAULT_PO
+		| LCD_CONTROL_PT
+		| LCD_CONTROL_PC ),
+
 		0,

-		/* mode_toyclksrc */
-		((1<<7) | (1<<6) | (0<<5)),
-
-		/* mode_backlight */
-		7
+		640, 640,
+		480, 480,
+		16,
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
+        /*** Pb1100 LCDA 320x240 Sharp TFT panel ***/
+	[1] = {
+		.name = "Sharp_LQ038Q5DR01",
+		.monspecs = {
+			.modedb  = sharp_lq038q5dr01_modes,
+			.modedb_len = ARRAY_SIZE(sharp_lq038q5dr01_modes),
+			.hfmin   = 12500,
+			.hfmax	 = 20000,
+			.vfmin	 = 38,
+			.vfmax   = 81,
+			.dclkmin = 4500,
+			.dclkmax = 6800,
+			.input = FB_DISP_RGB,
+		},

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
+		( LCD_CONTROL_C
+		| LCD_CONTROL_DEFAULT_PO
+		| LCD_CONTROL_PT
+		| LCD_CONTROL_PC ),

-		/* mode_pwmhi */
 		0,
-
-		/* mode_toyclksrc */
-		((1<<7) | (1<<6) | (0<<5)),
-
-		/* mode_backlight */
-		7
+
+		320, 320,
+		240, 240,
+		16,
 	},
+};

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
+/********************************************************************/

-		/* mode_clkcontrol */
-		0x00020000,
+/* Inline helpers */

-		/* mode_pwmdiv */
-		0,
+#define panel_is_dual(panel)  (panel->control_base & LCD_CONTROL_DP)
+#define panel_is_active(panel)(panel->control_base & LCD_CONTROL_PT)
+#define panel_is_color(panel) (panel->control_base & LCD_CONTROL_PC)
+#define panel_swap_rgb(panel) (panel->control_base & LCD_CONTROL_CCO)

-		/* mode_pwmhi */
-		0,
+static inline int
+au1100fb_start_controller(struct au1100fb_device *fbdev)
+{
+	return fbdev->fb_info.fbops->fb_blank(VESA_NO_BLANKING, &fbdev->fb_info);
+}

-		/* mode_toyclksrc */
-		((1<<7) | (1<<6) | (0<<5)),
+static inline int
+au1100fb_stop_controller(struct au1100fb_device *fbdev, int wait)
+{
+	int ret = fbdev->fb_info.fbops->fb_blank(VESA_POWERDOWN, &fbdev->fb_info);
+	if (wait) {
+		/* Wait for the SD bit */
+		u32 intstatus;
+		do {
+			*(volatile u32*)(&fbdev->regs->lcd_intstatus);
+			intstatus = *(volatile u32*)(&fbdev->regs->lcd_intstatus);
+
+		} while (!(intstatus & LCD_INT_SD));
+	}
+	return ret;
+}

-		/* mode_backlight */
-		7
-	},
-};
 #endif /* _AU1100LCD_H */
Index: include/asm-mips/mach-au1x00/au1000.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/mach-au1x00/au1000.h,v
retrieving revision 1.11
diff -u -r1.11 au1000.h
--- include/asm-mips/mach-au1x00/au1000.h	23 Sep 2004 06:06:50 -0000	1.11
+++ include/asm-mips/mach-au1x00/au1000.h	28 Oct 2004 15:11:37 -0000
@@ -494,6 +494,9 @@
 #define AU1100_ETH0_BASE	  0xB0500000
 #define AU1100_MAC0_ENABLE       0xB0520000
 #define NUM_ETH_INTERFACES 1
+
+#define AU1100_LCD_BASE           0xB5000000
+#define AU1100_LCD_LEN            0x00000800
 #endif // CONFIG_SOC_AU1100

 #ifdef CONFIG_SOC_AU1550
@@ -1237,6 +1240,12 @@
   #define SYS_CS_MI2_MASK           (0x7<<SYS_CS_MI2_BIT)
   #define SYS_CS_DI2                (1<<16)
   #define SYS_CS_CI2                (1<<15)
+#ifdef CONFIG_SOC_AU1100
+  #define SYS_CS_ML_BIT             7
+  #define SYS_CS_ML_MASK            (0x7<<SYS_CS_ML_BIT)
+  #define SYS_CS_DL                 (1<<6)
+  #define SYS_CS_CL                 (1<<5)
+#else
   #define SYS_CS_MUH_BIT            12
   #define SYS_CS_MUH_MASK           (0x7<<SYS_CS_MUH_BIT)
   #define SYS_CS_DUH                (1<<11)
@@ -1245,6 +1254,7 @@
   #define SYS_CS_MUD_MASK           (0x7<<SYS_CS_MUD_BIT)
   #define SYS_CS_DUD                (1<<6)
   #define SYS_CS_CUD                (1<<5)
+#endif
   #define SYS_CS_MIR_BIT            2
   #define SYS_CS_MIR_MASK           (0x7<<SYS_CS_MIR_BIT)
   #define SYS_CS_DIR                (1<<1)
Index: include/asm-mips/mach-db1x00/db1x00.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/mach-db1x00/db1x00.h,v
retrieving revision 1.6
diff -u -r1.6 db1x00.h
--- include/asm-mips/mach-db1x00/db1x00.h	20 Oct 2004 05:57:16 -0000	1.6
+++ include/asm-mips/mach-db1x00/db1x00.h	28 Oct 2004 15:11:37 -0000
@@ -76,7 +76,9 @@
 #define BCSR_STATUS_SWAPBOOT		0x2000
 #define BCSR_STATUS_FLASHDEN		0xC000

-#define BCSR_SWITCHES_DIP		0x00FF
+#define BCSR_SWITCHES_REG  		BCSR_KSEG1_ADDR + 0x8
+#define BCSR_SWITCHES_DIP_BIT   	0
+#define BCSR_SWITCHES_DIP_MASK  	0x00FF
 #define BCSR_SWITCHES_DIP_1		0x0080
 #define BCSR_SWITCHES_DIP_2		0x0040
 #define BCSR_SWITCHES_DIP_3		0x0020
@@ -85,7 +87,8 @@
 #define BCSR_SWITCHES_DIP_6		0x0004
 #define BCSR_SWITCHES_DIP_7		0x0002
 #define BCSR_SWITCHES_DIP_8		0x0001
-#define BCSR_SWITCHES_ROTARY		0x0F00
+#define BCSR_SWITCHES_ROTARY_BIT 	7
+#define BCSR_SWITCHES_ROTARY_MASK 	0x0F00

 #define BCSR_RESETS_PHY0		0x0001
 #define BCSR_RESETS_PHY1		0x0002
Index: include/asm-mips/mach-pb1x00/pb1100.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/mach-pb1x00/pb1100.h,v
retrieving revision 1.1
diff -u -r1.1 pb1100.h
--- include/asm-mips/mach-pb1x00/pb1100.h	13 Jan 2004 08:09:22 -0000	1.1
+++ include/asm-mips/mach-pb1x00/pb1100.h	28 Oct 2004 15:11:37 -0000
@@ -45,6 +45,21 @@
   #define PB1100_RS232_DSR        (1<<1)
   #define PB1100_RS232_RI         (1<<0)

+#define BCSR_SWITCHES_REG     0xAE000008
+  #define BCSR_SWITCHES_DIP_BIT   0
+  #define BCSR_SWITCHES_DIP_MASK  (0xFF<<BCSR_SWITCHES_DIP_BIT)
+  #define BCSR_SWITCHES_DIP_1	  (1<<7)
+  #define BCSR_SWITCHES_DIP_2	  (1<<6)
+  #define BCSR_SWITCHES_DIP_3	  (1<<5)
+  #define BCSR_SWITCHES_DIP_4	  (1<<4)
+  #define BCSR_SWITCHES_DIP_5	  (1<<3)
+  #define BCSR_SWITCHES_DIP_6	  (1<<2)
+  #define BCSR_SWITCHES_DIP_7     (1<<1)
+  #define BCSR_SWITCHES_DIP_8     (1<<0)
+  #define BCSR_SWITCHES_ROTARY_BIT 8
+  #define BCSR_SWITCHES_ROTARY_MASK (0xF<<BCSR_SWITCHES_ROTARY_BIT)
+  #define BCSR_SWITCHES_DOC_LOCK  (1<<15)
+
 #define PB1100_IRDA_RS232     0xAE00000C
   #define PB1100_IRDA_FULL       (0<<14) /* full power */
   #define PB1100_IRDA_SHUTDOWN   (1<<14)
@@ -63,6 +78,11 @@
   #define PC_DRV_EN               (1<<4)

 #define PB1100_G_CONTROL      0xAE000014 /* graphics control */
+  #define PB1100_G_CONTROL_RST	  (1<<7)
+  #define PB1100_G_CONTROL_BE 	  (1<<5)
+  #define PB1100_G_CONTROL_SM_PASS (1<<4)
+  #define PB1100_G_CONTROL_BL	  (1<<2)
+  #define PB1100_G_CONTROL_VDD	  (1<<1)

 #define PB1100_RST_VDDI       0xAE00001C
   #define PB1100_SOFT_RESET      (1<<15) /* clear to reset the board */
