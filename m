Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2008 06:25:20 +0100 (BST)
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:43405
	"EHLO QMTA03.westchester.pa.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S20024170AbYGaFZK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2008 06:25:10 +0100
Received: from OMTA07.westchester.pa.mail.comcast.net ([76.96.62.59])
	by QMTA03.westchester.pa.mail.comcast.net with comcast
	id wUZL1Z0021GhbT853VR2g9; Thu, 31 Jul 2008 05:25:02 +0000
Received: from [192.168.1.4] ([69.140.18.238])
	by OMTA07.westchester.pa.mail.comcast.net with comcast
	id wVR11Z00C58Be2l3TVR1Vw; Thu, 31 Jul 2008 05:25:02 +0000
X-Authority-Analysis: v=1.0 c=1 a=j7nJG0ugkPwA:10 a=7-cKWoymOU4A:10
 a=10jn3E0NSORXkwKcy4MA:9 a=PUnWp0qQ72MKtbs1G5oA:7
 a=AU4aRa9FYyUxVg3QQEEJk2v01icA:4 a=XF7b4UCPwd8A:10 a=8KiABytSXjkYwnAjiT0A:9
 a=8GNGKvNLSUR3pu61-28A:7 a=rMxG9E9XhzfVo1qgeivhFiNXoekA:4 a=1DbiqZag68YA:10
 a=NfA2RSpTaHsA:10
Message-ID: <48914CAD.3030005@gentoo.org>
Date:	Thu, 31 Jul 2008 01:25:01 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH/RFC]: SGI Octane (IP30) Patches, Part three, Early Console
Content-Type: multipart/mixed;
 boundary="------------060406080202020109060800"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060406080202020109060800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The third patch is one that should never go into mainline, as it's the early 
console patch for the Impact graphics boards, and it's pretty hackish.  But 
extremely useful for debugging, and I dare say, one of the best early consoles 
you can get.

It's posted in case anyone takes a stab at things, and needs to debug something. 
  Best method is to only patch it in when needed, and then reverse it out when 
the problem is solved.

Plus, posting patches to the internet helps in case a drive crashes and you lose 
everything!

Cheers!,


--Kumba

-- 
Unofficial Gentoo/MIPS Hermit & Kernel Monkey

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic

--------------060406080202020109060800
Content-Type: text/plain;
 name="misc-2.6.26-ip30-octane-impactsr-early-console.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="misc-2.6.26-ip30-octane-impactsr-early-console.patch"

diff -Naurp linux-2.6.26.orig/arch/mips/kernel/setup.c linux-2.6.26/arch/mips/kernel/setup.c
--- linux-2.6.26.orig/arch/mips/kernel/setup.c	2008-07-25 03:14:40.000000000 -0400
+++ linux-2.6.26/arch/mips/kernel/setup.c	2008-07-31 00:47:58.000000000 -0400
@@ -555,6 +555,7 @@ static void __init resource_init(void)
 	}
 }
 
+void impactsr_earlyinit(void);
 void __init setup_arch(char **cmdline_p)
 {
 	cpu_probe();
@@ -570,6 +571,7 @@ void __init setup_arch(char **cmdline_p)
 	cpu_report();
 	check_bugs_early();
 
+        impactsr_earlyinit();
 #if defined(CONFIG_VT)
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
diff -Naurp linux-2.6.26.orig/drivers/video/Kconfig linux-2.6.26/drivers/video/Kconfig
--- linux-2.6.26.orig/drivers/video/Kconfig	2008-07-25 03:14:40.000000000 -0400
+++ linux-2.6.26/drivers/video/Kconfig	2008-07-31 00:47:58.000000000 -0400
@@ -19,6 +19,15 @@ config VIDEO_OUTPUT_CONTROL
 	  This framework adds support for low-level control of the video 
 	  output switch.
 
+config FB_IMPACTSR_EARLY
+	tristate "SGI Octane ImpactSR Early Console Support"
+	depends on SGI_IP30
+	---help---
+	  SGI Octane ImpactSR (SI/SSI/MXI/SE/SSE/MXE) Early Console support.
+
+	  Exetremely basic grahics console useful for debugging early kernel
+	  output on SGI Octane systems.  Not useful for day-to-day use.
+
 menuconfig FB
 	tristate "Support for frame buffer devices"
 	---help---
diff -Naurp linux-2.6.26.orig/drivers/video/Makefile linux-2.6.26/drivers/video/Makefile
--- linux-2.6.26.orig/drivers/video/Makefile	2008-07-25 03:15:47.000000000 -0400
+++ linux-2.6.26/drivers/video/Makefile	2008-07-31 00:48:21.000000000 -0400
@@ -118,6 +118,7 @@ obj-$(CONFIG_FB_XILINX)           += xil
 obj-$(CONFIG_FB_OMAP)             += omap/
 obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
 obj-$(CONFIG_FB_IMPACTSR)         += impactsr.o
+obj-$(CONFIG_FB_IMPACTSR_EARLY)   += impactsr_early.o
 obj-$(CONFIG_FB_ODYSSEY)          += odyssey.o
 
 # Platform or fallback drivers go here
diff -Naurp linux-2.6.26.orig/drivers/video/impactsr_early.c linux-2.6.26/drivers/video/impactsr_early.c
--- linux-2.6.26.orig/drivers/video/impactsr_early.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/drivers/video/impactsr_early.c	2008-07-31 00:47:58.000000000 -0400
@@ -0,0 +1,185 @@
+/*
+ * linux/drivers/video/impactsr.c -- SGI Octane MardiGras (IMPACTSR) graphics
+ *
+ *  Copyright (c) 2004 by Stanislaw Skowronek
+ *
+ *  Based on linux/drivers/video/skeletonfb.c
+ *
+ *  This driver, as most of the IP30 (SGI Octane) port, is a result of massive
+ *  amounts of reverse engineering and trial-and-error. If anyone is interested
+ *  in helping with it, please contact me: <skylark@linux-mips.org>.
+ *
+ *  The basic functions of this driver are filling and blitting rectangles.
+ *  To achieve the latter, two DMA operations are used on Impact. It is unclear
+ *  to me, why is it so, but even Xsgi (the IRIX X11 server) does it this way.
+ *  It seems that fb->fb operations are not operational on these cards.
+ *
+ *  For this purpose, a kernel DMA pool is allocated (pool number 0). This pool
+ *  is (by default) 64kB in size. An ioctl could be used to set the value at
+ *  run-time. Applications can use this pool, however proper locking has to be
+ *  guaranteed. Kernel should be locked out from this pool by an ioctl.
+ *
+ *  The IMPACTSR is quite well worked-out currently, except for the Geometry
+ *  Engines (GE11). Any information about use of those devices would be very
+ *  useful. It would enable a Linux OpenGL driver, as most of OpenGL calls are
+ *  supported directly by the hardware. So far, I can't initialize the GE11.
+ *  Verification of microcode crashes the graphics.
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/module.h>
+#include <linux/font.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-ip30/xtalk.h>
+#include <video/impactsr.h>
+
+
+    /*
+     *  Private early console
+     */
+
+#define MMIO_FIXED	0x900000001c000000
+
+static void impactsr_earlyrect(int x, int y, int w, int h, unsigned c)
+{
+	while (IMPACTSR_FIFOSTATUS(MMIO_FIXED) & 0xff);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_PP1FILLMODE(0x6300, IMPACTSR_LO_COPY);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_FILLMODE(0);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_PACKEDCOLOR(c);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_BLOCKXYSTARTI(x, y);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_BLOCKXYENDI(x + w - 1, y + h - 1);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_IR_ALIAS(0x18);
+}
+static void impactsr_paintchar(int x, int y, unsigned char *b, unsigned c, unsigned a)
+{
+	int v;
+	while (IMPACTSR_FIFOSTATUS(MMIO_FIXED) & 0xff);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_PP1FILLMODE(0x6300, IMPACTSR_LO_COPY);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_FILLMODE(0x400018);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_PACKEDCOLOR(c);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_BKGRD_RG(a & 0xffff);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_BKGRD_BA((a&0xff0000) >> 16);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_BLOCKXYSTARTI(x, y);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_BLOCKXYENDI(x + 7, y + 15);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_IR_ALIAS(0x18);
+	for (v = 0; v < 16; v++)
+		IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_CHAR((*(b++)) << 24);
+}
+static void impactsr_earlyhwinit(void)
+{
+	IMPACTSR_CFIFO_HW(MMIO_FIXED) = 0x47;
+	IMPACTSR_CFIFO_LW(MMIO_FIXED) = 0x14;
+	IMPACTSR_CFIFO_DELAY(MMIO_FIXED) = 0x64;
+	IMPACTSR_DFIFO_HW(MMIO_FIXED) = 0x40;
+	IMPACTSR_DFIFO_LW(MMIO_FIXED) = 0x10;
+	IMPACTSR_DFIFO_DELAY(MMIO_FIXED) = 0;
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_COLORMASKLSBSA(0xffffff);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_COLORMASKLSBSB(0xffffff);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_COLORMASKMSBS(0);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_XFRMASKLO(0xffffff);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_XFRMASKHI(0xffffff);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_DRBPOINTERS(0xc8240);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_CONFIG(0xcac);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_XYWIN(0, 0x3ff);
+	IMPACTSR_XMAP_PP1SELECT(MMIO_FIXED) = 0x01;
+	IMPACTSR_XMAP_INDEX(MMIO_FIXED) = 0x00;
+	IMPACTSR_XMAP_MAIN_MODE(MMIO_FIXED) = 0x07a4;
+	IMPACTSR_VC3_INDEXDATA(MMIO_FIXED) = 0x1d000100;
+}
+
+static int posx = -1, posy;
+static spinlock_t earlylock = SPIN_LOCK_UNLOCKED;
+
+void impactsr_earlychar(unsigned char c, unsigned f)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&earlylock, flags);
+	if (posx == -1)
+		goto out;
+
+	if (c == '\n') {
+		posy += 16;
+		if (posy >= 1024)
+			posy = 0;
+		posx = 0;
+		goto out;
+	}
+
+	if (posx == 0) {
+		impactsr_earlyrect(0, posy, 1280, 16, 0x000000);
+		if (posy + 16 < 1024)
+			impactsr_earlyrect(0, posy + 16, 1280, 2, 0x0000ff);
+	}
+
+	impactsr_paintchar(posx, posy, (unsigned char *)font_vga_8x16.data + (c << 4),
+			   f, 0);
+	posx += 8;
+
+	if (posx >= 1280) {
+		posx = 0;
+		posy++;
+		if (posy >= 1024)
+			posy = 0;
+	}
+out:
+	spin_unlock_irqrestore(&earlylock, flags);
+}
+void impactsr_earlystring(char *s, unsigned f)
+{
+	while (*s)
+		impactsr_earlychar(*(s++), f);
+}
+void impactsr_earlyinit(void)
+{
+	impactsr_earlyhwinit();
+	impactsr_earlyrect(0, 0, 1280, 1024, 0);
+	posx = 0;
+	posy = 0;
+	impactsr_earlystring("ImpactSR early console ready.\n",0xffffff);
+}
+
+
+static struct device_driver impactsr_driver = {
+	.name = "impactsr_early",
+	.bus = &platform_bus_type,
+};
+
+static struct platform_device impactsr_device = {
+	.name = "impactsr_early",
+};
+
+int __init impactsr_init(void)
+{
+	int ret = driver_register(&impactsr_driver);
+	if (!ret) {
+		ret = platform_device_register(&impactsr_device);
+		if (ret)
+			driver_unregister(&impactsr_driver);
+	}
+	return ret;
+}
+
+void __exit impactsr_exit(void)
+{
+	 driver_unregister(&impactsr_driver);
+}
+
+MODULE_AUTHOR("Stanislaw Skowronek <skylark@linux-mips.org>");
+MODULE_DESCRIPTION("SGI Octane (IP30) ImpactSR / HQ4 Video Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("R28");
+
+module_init(impactsr_init);
+module_exit(impactsr_exit);
+
+MODULE_LICENSE("GPL");
+
+#include <../drivers/video/console/font_8x16.c>
diff -Naurp linux-2.6.26.orig/kernel/printk.c linux-2.6.26/kernel/printk.c
--- linux-2.6.26.orig/kernel/printk.c	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/kernel/printk.c	2008-07-31 00:47:58.000000000 -0400
@@ -529,8 +529,10 @@ static void call_console_drivers(unsigne
 	_call_console_drivers(start_print, end, msg_level);
 }
 
+extern void impactsr_earlychar(unsigned char c, unsigned f);
 static void emit_log_char(char c)
 {
+        impactsr_earlychar(c, 0xa0a0a0);
 	LOG_BUF(log_end) = c;
 	log_end++;
 	if (log_end - log_start > log_buf_len)

--------------060406080202020109060800--
