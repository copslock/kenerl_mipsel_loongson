Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2008 18:41:36 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:47043 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S23355302AbYKGSl3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Nov 2008 18:41:29 +0000
Received: (qmail 8441 invoked from network); 7 Nov 2008 19:38:34 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 7 Nov 2008 19:38:34 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 3/3] Alchemy: common reset code is evalboard code.
Date:	Fri,  7 Nov 2008 19:41:22 +0100
Message-Id: <9bf5c9c78b0e2bada64f8f337d9397efb8781ac1.1226083170.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.3
In-Reply-To: <7fe9325e464ace53dae1affdb98681f6c4c59d53.1226083170.git.mano@roarinelk.homelinux.net>
References: <cover.1226082445.git.mano@roarinelk.homelinux.net>
 <0b1dcd4090411d59e2272ca94da0fb4f5a4bbceb.1226083170.git.mano@roarinelk.homelinux.net>
 <7fe9325e464ace53dae1affdb98681f6c4c59d53.1226083170.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1226083170.git.mano@roarinelk.homelinux.net>
References: <cover.1226083170.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Move common/reset.c contents to evalboard code where it belongs.
Add reboot hook initialization to mtx-1 and xxs1500 boards.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/common/Makefile       |    2 +-
 arch/mips/alchemy/common/reset.c        |  189 ------------------------------
 arch/mips/alchemy/common/setup.c        |   39 -------
 arch/mips/alchemy/evalboards/common.c   |  191 +++++++++++++++++++++++++++++++
 arch/mips/alchemy/evalboards/db1x00.c   |    4 +
 arch/mips/alchemy/evalboards/pb1000.c   |    3 +
 arch/mips/alchemy/evalboards/pb1100.c   |    3 +
 arch/mips/alchemy/evalboards/pb1200.c   |    3 +
 arch/mips/alchemy/evalboards/pb1500.c   |    3 +
 arch/mips/alchemy/evalboards/pb1550.c   |    3 +
 arch/mips/alchemy/mtx-1/board_setup.c   |    5 +-
 arch/mips/alchemy/xxs1500/board_setup.c |    5 +-
 12 files changed, 219 insertions(+), 231 deletions(-)
 delete mode 100644 arch/mips/alchemy/common/reset.c

diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index df48fd6..028e3b9 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -5,7 +5,7 @@
 # Makefile for the Alchemy Au1xx0 CPUs, generic files.
 #
 
-obj-y += prom.o irq.o puts.o time.o reset.o \
+obj-y += prom.o irq.o puts.o time.o \
 	au1xxx_irqmap.o clocks.o platform.o power.o setup.o \
 	sleeper.o cputable.o dma.o dbdma.o gpio.o
 
diff --git a/arch/mips/alchemy/common/reset.c b/arch/mips/alchemy/common/reset.c
deleted file mode 100644
index d555429..0000000
--- a/arch/mips/alchemy/common/reset.c
+++ /dev/null
@@ -1,189 +0,0 @@
-/*
- *
- * BRIEF MODULE DESCRIPTION
- *	Au1xx0 reset routines.
- *
- * Copyright 2001, 2006, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <asm/cacheflush.h>
-
-#include <asm/mach-au1x00/au1000.h>
-
-extern int au_sleep(void);
-
-void au1000_restart(char *command)
-{
-	/* Set all integrated peripherals to disabled states */
-	extern void board_reset(void);
-	u32 prid = read_c0_prid();
-
-	printk(KERN_NOTICE "\n** Resetting Integrated Peripherals\n");
-
-	switch (prid & 0xFF000000) {
-	case 0x00000000: /* Au1000 */
-		au_writel(0x02, 0xb0000010); /* ac97_enable */
-		au_writel(0x08, 0xb017fffc); /* usbh_enable - early errata */
-		asm("sync");
-		au_writel(0x00, 0xb017fffc); /* usbh_enable */
-		au_writel(0x00, 0xb0200058); /* usbd_enable */
-		au_writel(0x00, 0xb0300040); /* ir_enable */
-		au_writel(0x00, 0xb4004104); /* mac dma */
-		au_writel(0x00, 0xb4004114); /* mac dma */
-		au_writel(0x00, 0xb4004124); /* mac dma */
-		au_writel(0x00, 0xb4004134); /* mac dma */
-		au_writel(0x00, 0xb0520000); /* macen0 */
-		au_writel(0x00, 0xb0520004); /* macen1 */
-		au_writel(0x00, 0xb1000008); /* i2s_enable  */
-		au_writel(0x00, 0xb1100100); /* uart0_enable */
-		au_writel(0x00, 0xb1200100); /* uart1_enable */
-		au_writel(0x00, 0xb1300100); /* uart2_enable */
-		au_writel(0x00, 0xb1400100); /* uart3_enable */
-		au_writel(0x02, 0xb1600100); /* ssi0_enable */
-		au_writel(0x02, 0xb1680100); /* ssi1_enable */
-		au_writel(0x00, 0xb1900020); /* sys_freqctrl0 */
-		au_writel(0x00, 0xb1900024); /* sys_freqctrl1 */
-		au_writel(0x00, 0xb1900028); /* sys_clksrc */
-		au_writel(0x10, 0xb1900060); /* sys_cpupll */
-		au_writel(0x00, 0xb1900064); /* sys_auxpll */
-		au_writel(0x00, 0xb1900100); /* sys_pininputen */
-		break;
-	case 0x01000000: /* Au1500 */
-		au_writel(0x02, 0xb0000010); /* ac97_enable */
-		au_writel(0x08, 0xb017fffc); /* usbh_enable - early errata */
-		asm("sync");
-		au_writel(0x00, 0xb017fffc); /* usbh_enable */
-		au_writel(0x00, 0xb0200058); /* usbd_enable */
-		au_writel(0x00, 0xb4004104); /* mac dma */
-		au_writel(0x00, 0xb4004114); /* mac dma */
-		au_writel(0x00, 0xb4004124); /* mac dma */
-		au_writel(0x00, 0xb4004134); /* mac dma */
-		au_writel(0x00, 0xb1520000); /* macen0 */
-		au_writel(0x00, 0xb1520004); /* macen1 */
-		au_writel(0x00, 0xb1100100); /* uart0_enable */
-		au_writel(0x00, 0xb1400100); /* uart3_enable */
-		au_writel(0x00, 0xb1900020); /* sys_freqctrl0 */
-		au_writel(0x00, 0xb1900024); /* sys_freqctrl1 */
-		au_writel(0x00, 0xb1900028); /* sys_clksrc */
-		au_writel(0x10, 0xb1900060); /* sys_cpupll */
-		au_writel(0x00, 0xb1900064); /* sys_auxpll */
-		au_writel(0x00, 0xb1900100); /* sys_pininputen */
-		break;
-	case 0x02000000: /* Au1100 */
-		au_writel(0x02, 0xb0000010); /* ac97_enable */
-		au_writel(0x08, 0xb017fffc); /* usbh_enable - early errata */
-		asm("sync");
-		au_writel(0x00, 0xb017fffc); /* usbh_enable */
-		au_writel(0x00, 0xb0200058); /* usbd_enable */
-		au_writel(0x00, 0xb0300040); /* ir_enable */
-		au_writel(0x00, 0xb4004104); /* mac dma */
-		au_writel(0x00, 0xb4004114); /* mac dma */
-		au_writel(0x00, 0xb4004124); /* mac dma */
-		au_writel(0x00, 0xb4004134); /* mac dma */
-		au_writel(0x00, 0xb0520000); /* macen0 */
-		au_writel(0x00, 0xb1000008); /* i2s_enable  */
-		au_writel(0x00, 0xb1100100); /* uart0_enable */
-		au_writel(0x00, 0xb1200100); /* uart1_enable */
-		au_writel(0x00, 0xb1400100); /* uart3_enable */
-		au_writel(0x02, 0xb1600100); /* ssi0_enable */
-		au_writel(0x02, 0xb1680100); /* ssi1_enable */
-		au_writel(0x00, 0xb1900020); /* sys_freqctrl0 */
-		au_writel(0x00, 0xb1900024); /* sys_freqctrl1 */
-		au_writel(0x00, 0xb1900028); /* sys_clksrc */
-		au_writel(0x10, 0xb1900060); /* sys_cpupll */
-		au_writel(0x00, 0xb1900064); /* sys_auxpll */
-		au_writel(0x00, 0xb1900100); /* sys_pininputen */
-		break;
-	case 0x03000000: /* Au1550 */
-		au_writel(0x00, 0xb1a00004); /* psc 0 */
-		au_writel(0x00, 0xb1b00004); /* psc 1 */
-		au_writel(0x00, 0xb0a00004); /* psc 2 */
-		au_writel(0x00, 0xb0b00004); /* psc 3 */
-		au_writel(0x00, 0xb017fffc); /* usbh_enable */
-		au_writel(0x00, 0xb0200058); /* usbd_enable */
-		au_writel(0x00, 0xb4004104); /* mac dma */
-		au_writel(0x00, 0xb4004114); /* mac dma */
-		au_writel(0x00, 0xb4004124); /* mac dma */
-		au_writel(0x00, 0xb4004134); /* mac dma */
-		au_writel(0x00, 0xb1520000); /* macen0 */
-		au_writel(0x00, 0xb1520004); /* macen1 */
-		au_writel(0x00, 0xb1100100); /* uart0_enable */
-		au_writel(0x00, 0xb1200100); /* uart1_enable */
-		au_writel(0x00, 0xb1400100); /* uart3_enable */
-		au_writel(0x00, 0xb1900020); /* sys_freqctrl0 */
-		au_writel(0x00, 0xb1900024); /* sys_freqctrl1 */
-		au_writel(0x00, 0xb1900028); /* sys_clksrc */
-		au_writel(0x10, 0xb1900060); /* sys_cpupll */
-		au_writel(0x00, 0xb1900064); /* sys_auxpll */
-		au_writel(0x00, 0xb1900100); /* sys_pininputen */
-		break;
-	}
-
-	set_c0_status(ST0_BEV | ST0_ERL);
-	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
-	flush_cache_all();
-	write_c0_wired(0);
-
-	/* Give board a chance to do a hardware reset */
-	board_reset();
-
-	/* Jump to the beggining in case board_reset() is empty */
-	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
-}
-
-void au1000_halt(void)
-{
-#if defined(CONFIG_MIPS_PB1550) || defined(CONFIG_MIPS_DB1550)
-	/* Power off system */
-	printk(KERN_NOTICE "\n** Powering off...\n");
-	au_writew(au_readw(0xAF00001C) | (3 << 14), 0xAF00001C);
-	au_sync();
-	while (1); /* should not get here */
-#else
-	printk(KERN_NOTICE "\n** You can safely turn off the power\n");
-#ifdef CONFIG_MIPS_MIRAGE
-	au_writel((1 << 26) | (1 << 10), GPIO2_OUTPUT);
-#endif
-#ifdef CONFIG_MIPS_DB1200
-	au_writew(au_readw(0xB980001C) | (1 << 14), 0xB980001C);
-#endif
-#ifdef CONFIG_PM
-	au_sleep();
-
-	/* Should not get here */
-	printk(KERN_ERR "Unable to put CPU in sleep mode\n");
-	while (1);
-#else
-	while (1)
-		__asm__(".set\tmips3\n\t"
-	                "wait\n\t"
-			".set\tmips0");
-#endif
-#endif /* defined(CONFIG_MIPS_PB1550) || defined(CONFIG_MIPS_DB1550) */
-}
-
-void au1000_power_off(void)
-{
-	au1000_halt();
-}
diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 1ac6b06..cfb531e 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -28,25 +28,14 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
-#include <linux/pm.h>
-
-#include <asm/mipsregs.h>
-#include <asm/reboot.h>
-#include <asm/time.h>
-
 #include <au1000.h>
-#include <prom.h>
 
 extern void __init board_setup(void);
-extern void au1000_restart(char *);
-extern void au1000_halt(void);
-extern void au1000_power_off(void);
 extern void set_cpuspec(void);
 
 void __init plat_mem_setup(void)
 {
 	struct	cpu_spec *sp;
-	char *argptr;
 	unsigned long prid, cpufreq, bclk;
 
 	set_cpuspec();
@@ -79,34 +68,6 @@ void __init plat_mem_setup(void)
 		/* Clear to obtain best system bus performance */
 		clear_c0_config(1 << 19); /* Clear Config[OD] */
 
-	argptr = prom_getcmdline();
-
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-	argptr = strstr(argptr, "console=");
-	if (argptr == NULL) {
-		argptr = prom_getcmdline();
-		strcat(argptr, " console=ttyS0,115200");
-	}
-#endif
-
-#ifdef CONFIG_FB_AU1100
-	argptr = strstr(argptr, "video=");
-	if (argptr == NULL) {
-		argptr = prom_getcmdline();
-		/* default panel */
-		/*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
-	}
-#endif
-
-#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
-	/* au1000 does not support vra, au1500 and au1100 do */
-	strcat(argptr, " au1000_audio=vra");
-	argptr = prom_getcmdline();
-#endif
-	_machine_restart = au1000_restart;
-	_machine_halt = au1000_halt;
-	pm_power_off = au1000_power_off;
-
 	/* IO/MEM resources. */
 	set_io_port_base(0);
 	ioport_resource.start = IOPORT_RESOURCE_START;
diff --git a/arch/mips/alchemy/evalboards/common.c b/arch/mips/alchemy/evalboards/common.c
index d112fcf..7c78d54 100644
--- a/arch/mips/alchemy/evalboards/common.c
+++ b/arch/mips/alchemy/evalboards/common.c
@@ -29,10 +29,15 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/pm.h>		/* pm_power_off */
 #include <asm/bootinfo.h>
+#include <asm/cacheflush.h>
 #include <asm/mach-au1x00/au1000.h>
+#include <asm/reboot.h>
 #include <prom.h>
 
+extern int au_sleep(void);
+
 #if defined(CONFIG_MIPS_PB1000) || defined(CONFIG_MIPS_DB1000) || \
     defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1100) || \
     defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_DB1500) || \
@@ -60,3 +65,189 @@ void __init prom_init(void)
 		strict_strtol(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
+
+static void evalboard_restart(char *command)
+{
+	/* Set all integrated peripherals to disabled states */
+	extern void board_reset(void);
+	u32 prid = read_c0_prid();
+
+	printk(KERN_NOTICE "\n** Resetting Integrated Peripherals\n");
+
+	switch (prid & 0xFF000000) {
+	case 0x00000000: /* Au1000 */
+		au_writel(0x02, 0xb0000010); /* ac97_enable */
+		au_writel(0x08, 0xb017fffc); /* usbh_enable - early errata */
+		asm("sync");
+		au_writel(0x00, 0xb017fffc); /* usbh_enable */
+		au_writel(0x00, 0xb0200058); /* usbd_enable */
+		au_writel(0x00, 0xb0300040); /* ir_enable */
+		au_writel(0x00, 0xb4004104); /* mac dma */
+		au_writel(0x00, 0xb4004114); /* mac dma */
+		au_writel(0x00, 0xb4004124); /* mac dma */
+		au_writel(0x00, 0xb4004134); /* mac dma */
+		au_writel(0x00, 0xb0520000); /* macen0 */
+		au_writel(0x00, 0xb0520004); /* macen1 */
+		au_writel(0x00, 0xb1000008); /* i2s_enable  */
+		au_writel(0x00, 0xb1100100); /* uart0_enable */
+		au_writel(0x00, 0xb1200100); /* uart1_enable */
+		au_writel(0x00, 0xb1300100); /* uart2_enable */
+		au_writel(0x00, 0xb1400100); /* uart3_enable */
+		au_writel(0x02, 0xb1600100); /* ssi0_enable */
+		au_writel(0x02, 0xb1680100); /* ssi1_enable */
+		au_writel(0x00, 0xb1900020); /* sys_freqctrl0 */
+		au_writel(0x00, 0xb1900024); /* sys_freqctrl1 */
+		au_writel(0x00, 0xb1900028); /* sys_clksrc */
+		au_writel(0x10, 0xb1900060); /* sys_cpupll */
+		au_writel(0x00, 0xb1900064); /* sys_auxpll */
+		au_writel(0x00, 0xb1900100); /* sys_pininputen */
+		break;
+	case 0x01000000: /* Au1500 */
+		au_writel(0x02, 0xb0000010); /* ac97_enable */
+		au_writel(0x08, 0xb017fffc); /* usbh_enable - early errata */
+		asm("sync");
+		au_writel(0x00, 0xb017fffc); /* usbh_enable */
+		au_writel(0x00, 0xb0200058); /* usbd_enable */
+		au_writel(0x00, 0xb4004104); /* mac dma */
+		au_writel(0x00, 0xb4004114); /* mac dma */
+		au_writel(0x00, 0xb4004124); /* mac dma */
+		au_writel(0x00, 0xb4004134); /* mac dma */
+		au_writel(0x00, 0xb1520000); /* macen0 */
+		au_writel(0x00, 0xb1520004); /* macen1 */
+		au_writel(0x00, 0xb1100100); /* uart0_enable */
+		au_writel(0x00, 0xb1400100); /* uart3_enable */
+		au_writel(0x00, 0xb1900020); /* sys_freqctrl0 */
+		au_writel(0x00, 0xb1900024); /* sys_freqctrl1 */
+		au_writel(0x00, 0xb1900028); /* sys_clksrc */
+		au_writel(0x10, 0xb1900060); /* sys_cpupll */
+		au_writel(0x00, 0xb1900064); /* sys_auxpll */
+		au_writel(0x00, 0xb1900100); /* sys_pininputen */
+		break;
+	case 0x02000000: /* Au1100 */
+		au_writel(0x02, 0xb0000010); /* ac97_enable */
+		au_writel(0x08, 0xb017fffc); /* usbh_enable - early errata */
+		asm("sync");
+		au_writel(0x00, 0xb017fffc); /* usbh_enable */
+		au_writel(0x00, 0xb0200058); /* usbd_enable */
+		au_writel(0x00, 0xb0300040); /* ir_enable */
+		au_writel(0x00, 0xb4004104); /* mac dma */
+		au_writel(0x00, 0xb4004114); /* mac dma */
+		au_writel(0x00, 0xb4004124); /* mac dma */
+		au_writel(0x00, 0xb4004134); /* mac dma */
+		au_writel(0x00, 0xb0520000); /* macen0 */
+		au_writel(0x00, 0xb1000008); /* i2s_enable  */
+		au_writel(0x00, 0xb1100100); /* uart0_enable */
+		au_writel(0x00, 0xb1200100); /* uart1_enable */
+		au_writel(0x00, 0xb1400100); /* uart3_enable */
+		au_writel(0x02, 0xb1600100); /* ssi0_enable */
+		au_writel(0x02, 0xb1680100); /* ssi1_enable */
+		au_writel(0x00, 0xb1900020); /* sys_freqctrl0 */
+		au_writel(0x00, 0xb1900024); /* sys_freqctrl1 */
+		au_writel(0x00, 0xb1900028); /* sys_clksrc */
+		au_writel(0x10, 0xb1900060); /* sys_cpupll */
+		au_writel(0x00, 0xb1900064); /* sys_auxpll */
+		au_writel(0x00, 0xb1900100); /* sys_pininputen */
+		break;
+	case 0x03000000: /* Au1550 */
+		au_writel(0x00, 0xb1a00004); /* psc 0 */
+		au_writel(0x00, 0xb1b00004); /* psc 1 */
+		au_writel(0x00, 0xb0a00004); /* psc 2 */
+		au_writel(0x00, 0xb0b00004); /* psc 3 */
+		au_writel(0x00, 0xb017fffc); /* usbh_enable */
+		au_writel(0x00, 0xb0200058); /* usbd_enable */
+		au_writel(0x00, 0xb4004104); /* mac dma */
+		au_writel(0x00, 0xb4004114); /* mac dma */
+		au_writel(0x00, 0xb4004124); /* mac dma */
+		au_writel(0x00, 0xb4004134); /* mac dma */
+		au_writel(0x00, 0xb1520000); /* macen0 */
+		au_writel(0x00, 0xb1520004); /* macen1 */
+		au_writel(0x00, 0xb1100100); /* uart0_enable */
+		au_writel(0x00, 0xb1200100); /* uart1_enable */
+		au_writel(0x00, 0xb1400100); /* uart3_enable */
+		au_writel(0x00, 0xb1900020); /* sys_freqctrl0 */
+		au_writel(0x00, 0xb1900024); /* sys_freqctrl1 */
+		au_writel(0x00, 0xb1900028); /* sys_clksrc */
+		au_writel(0x10, 0xb1900060); /* sys_cpupll */
+		au_writel(0x00, 0xb1900064); /* sys_auxpll */
+		au_writel(0x00, 0xb1900100); /* sys_pininputen */
+		break;
+	}
+
+	set_c0_status(ST0_BEV | ST0_ERL);
+	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
+	flush_cache_all();
+	write_c0_wired(0);
+
+	/* Give board a chance to do a hardware reset */
+	board_reset();
+
+	/* Jump to the beggining in case board_reset() is empty */
+	__asm__ __volatile__("jr\t%0" : : "r"(0xbfc00000));
+}
+
+static void evalboard_halt(void)
+{
+#if defined(CONFIG_MIPS_PB1550) || defined(CONFIG_MIPS_DB1550)
+	/* Power off system */
+	printk(KERN_NOTICE "\n** Powering off...\n");
+	au_writew(au_readw(0xAF00001C) | (3 << 14), 0xAF00001C);
+	au_sync();
+	while (1)
+		; /* should not get here */
+#else
+	printk(KERN_NOTICE "\n** You can safely turn off the power\n");
+#ifdef CONFIG_MIPS_MIRAGE
+	au_writel((1 << 26) | (1 << 10), GPIO2_OUTPUT);
+#endif
+#ifdef CONFIG_MIPS_DB1200
+	au_writew(au_readw(0xB980001C) | (1 << 14), 0xB980001C);
+#endif
+#ifdef CONFIG_PM
+	au_sleep();
+
+	/* Should not get here */
+	printk(KERN_ERR "Unable to put CPU in sleep mode\n");
+	while (1)
+		;
+#else
+	while (1)
+		__asm__(".set\tmips3\n\t"
+			"wait\n\t"
+			".set\tmips0");
+#endif
+#endif /* defined(CONFIG_MIPS_PB1550) || defined(CONFIG_MIPS_DB1550) */
+}
+
+void __init evalboard_common_init(void)
+{
+	char *argptr;
+
+	argptr = prom_getcmdline();
+
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	argptr = strstr(argptr, "console=");
+	if (argptr == NULL) {
+		argptr = prom_getcmdline();
+		strcat(argptr, " console=ttyS0,115200");
+	}
+#endif
+
+#ifdef CONFIG_FB_AU1100
+	argptr = strstr(argptr, "video=");
+	if (argptr == NULL) {
+		argptr = prom_getcmdline();
+		/* default panel */
+		/*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
+	}
+#endif
+
+#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
+	/* au1000 does not support vra, au1500 and au1100 do */
+	strcat(argptr, " au1000_audio=vra");
+	argptr = prom_getcmdline();
+#endif
+
+	_machine_restart = evalboard_restart;
+	_machine_halt = evalboard_halt;
+	pm_power_off = evalboard_halt;
+}
diff --git a/arch/mips/alchemy/evalboards/db1x00.c b/arch/mips/alchemy/evalboards/db1x00.c
index 868ad3e..997c8a3 100644
--- a/arch/mips/alchemy/evalboards/db1x00.c
+++ b/arch/mips/alchemy/evalboards/db1x00.c
@@ -36,6 +36,8 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/db1x00.h>
 
+#include "common.h"
+
 #ifdef CONFIG_MIPS_DB1500
 char irq_tab_alchemy[][5] __initdata = {
 	[12] = { -1, INTA, INTX, INTX, INTX }, /* IDSEL 12 - HPT371   */
@@ -114,6 +116,8 @@ void __init board_setup(void)
 
 	pin_func = 0;
 
+	evalboard_common_init();
+
 	/* Not valid for Au1550 */
 #if defined(CONFIG_IRDA) && \
    (defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1100))
diff --git a/arch/mips/alchemy/evalboards/pb1000.c b/arch/mips/alchemy/evalboards/pb1000.c
index e795eaf..96354bf 100644
--- a/arch/mips/alchemy/evalboards/pb1000.c
+++ b/arch/mips/alchemy/evalboards/pb1000.c
@@ -28,6 +28,7 @@
 #include <linux/kernel.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1000.h>
+#include "common.h"
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
 	{ AU1000_GPIO_15, INTC_INT_LOW_LEVEL, 0 },
@@ -52,6 +53,8 @@ void __init board_setup(void)
 
 	sys_freqctrl = sys_clksrc = 0;
 
+	evalboard_common_init();
+
 	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
 	au_writel(8, SYS_AUXPLL);
 	au_writel(0, SYS_PINSTATERD);
diff --git a/arch/mips/alchemy/evalboards/pb1100.c b/arch/mips/alchemy/evalboards/pb1100.c
index dbd9605..3177deb 100644
--- a/arch/mips/alchemy/evalboards/pb1100.c
+++ b/arch/mips/alchemy/evalboards/pb1100.c
@@ -28,6 +28,7 @@
 #include <linux/kernel.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1100.h>
+#include "common.h"
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
 	{ AU1000_GPIO_9,  INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card Fully_Inserted# */
@@ -54,6 +55,8 @@ void __init board_setup(void)
 {
 	volatile void __iomem *base = (volatile void __iomem *)0xac000000UL;
 
+	evalboard_common_init();
+
 	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
 	au_writel(8, SYS_AUXPLL);
 	au_writel(0, SYS_PININPUTEN);
diff --git a/arch/mips/alchemy/evalboards/pb1200.c b/arch/mips/alchemy/evalboards/pb1200.c
index 4a24874..1ed54b5 100644
--- a/arch/mips/alchemy/evalboards/pb1200.c
+++ b/arch/mips/alchemy/evalboards/pb1200.c
@@ -39,6 +39,7 @@
 #endif
 
 #include <prom.h>
+#include "common.h"
 
 extern void (*board_init_irq)(void);
 
@@ -184,6 +185,8 @@ void __init board_setup(void)
 	strcat(argptr, " video=au1200fb:panel:bs");
 #endif
 
+	evalboard_common_init();
+
 #if 0
 	{
 		u32 pin_func;
diff --git a/arch/mips/alchemy/evalboards/pb1500.c b/arch/mips/alchemy/evalboards/pb1500.c
index 72c5222..0187bc5 100644
--- a/arch/mips/alchemy/evalboards/pb1500.c
+++ b/arch/mips/alchemy/evalboards/pb1500.c
@@ -28,6 +28,7 @@
 #include <linux/kernel.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1500.h>
+#include "common.h"
 
 char irq_tab_alchemy[][5] __initdata = {
 	[12] = { -1, INTA, INTX, INTX, INTX },   /* IDSEL 12 - HPT370	*/
@@ -61,6 +62,8 @@ void __init board_setup(void)
 	u32 pin_func;
 	u32 sys_freqctrl, sys_clksrc;
 
+	evalboard_common_init();
+
 	sys_clksrc = sys_freqctrl = pin_func = 0;
 	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
 	au_writel(8, SYS_AUXPLL);
diff --git a/arch/mips/alchemy/evalboards/pb1550.c b/arch/mips/alchemy/evalboards/pb1550.c
index 15bcf6b..f475791 100644
--- a/arch/mips/alchemy/evalboards/pb1550.c
+++ b/arch/mips/alchemy/evalboards/pb1550.c
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1550.h>
+#include "common.h"
 
 char irq_tab_alchemy[][5] __initdata = {
 	[12] = { -1, INTB, INTC, INTD, INTA }, /* IDSEL 12 - PCI slot 2 (left)  */
@@ -60,6 +61,8 @@ void __init board_setup(void)
 {
 	u32 pin_func;
 
+	evalboard_common_init();
+
 	/*
 	 * Enable PSC1 SYNC for AC'97.  Normaly done in audio driver,
 	 * but it is board specific code, so put it here.
diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
index 2e26465..4712ce4 100644
--- a/arch/mips/alchemy/mtx-1/board_setup.c
+++ b/arch/mips/alchemy/mtx-1/board_setup.c
@@ -33,6 +33,7 @@
 #include <linux/kernel.h>
 #include <asm/bootinfo.h>
 #include <asm/mach-au1x00/au1000.h>
+#include <asm/reboot.h>
 #include <prom.h>
 
 extern int (*board_pci_idsel)(unsigned int devsel, int assert);
@@ -84,7 +85,7 @@ void __init prom_init(void)
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
 
-void board_reset(void)
+void board_reset(char *c)
 {
 	/* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
 	au_writel(0x00000000, 0xAE00001C);
@@ -122,6 +123,8 @@ void __init board_setup(void)
 
 	board_pci_idsel = mtx1_pci_idsel;
 
+	_machine_restart = board_reset;
+
 	printk(KERN_INFO "4G Systems MTX-1 Board\n");
 }
 
diff --git a/arch/mips/alchemy/xxs1500/board_setup.c b/arch/mips/alchemy/xxs1500/board_setup.c
index 813668f..effb538 100644
--- a/arch/mips/alchemy/xxs1500/board_setup.c
+++ b/arch/mips/alchemy/xxs1500/board_setup.c
@@ -29,6 +29,7 @@
 #include <linux/kernel.h>
 #include <asm/bootinfo.h>
 #include <asm/mach-au1x00/au1000.h>
+#include <asm/reboot.h>
 #include <prom.h>
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
@@ -74,7 +75,7 @@ void __init prom_init(void)
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
 
-void board_reset(void)
+void board_reset(char *c)
 {
 	/* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
 	au_writel(0x00000000, 0xAE00001C);
@@ -122,4 +123,6 @@ void __init board_setup(void)
 	au_writel(0xf, Au1500_PCI_CFG);
 #endif
 #endif
+
+	_machine_restart = board_reset;
 }
-- 
1.6.0.3
