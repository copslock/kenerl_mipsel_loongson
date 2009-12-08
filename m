Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 19:18:05 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.148]:32834 "EHLO
        ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494654AbZLHSSB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 19:18:01 +0100
Received: by ey-out-1920.google.com with SMTP id 5so582357eyb.52
        for <linux-mips@linux-mips.org>; Tue, 08 Dec 2009 10:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=zQgUpPqJpn2LlFXa9INAiQgZVggFfxBzo4PFynAzw4w=;
        b=au5lFkH1VuRdDrEZXEtmmMOdau/GK2Cnbw85ZX4yjPfDlSNQA5m9gNJdNYU+wkt7xc
         FMQ3nWQyaB8dSsTUgGnCrW6oOB6XaS0mHw7XqhMzwnMCvcR3WN43M5WkC5q69dy5Kek+
         f0IjgmwsTbEROoUyv28PP1b77uSvMDwFV8YIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sbkXcd53sRgTfdy8DAet1JjYmxCDN1pCbCvfROpBTC0yThmyDjyvzYUhNOkmCsM6AI
         Xjt0QoEb3S/GtOpWmEMj5wgnBW1sp7n77WFnMA2/w2n1Lspmm4o5nXsRA75ufnuBjstE
         /F7lVS9nRgBggyhZbvLVgkz0G4lhjbJMjnrdE=
Received: by 10.216.89.84 with SMTP id b62mr249008wef.227.1260296280546;
        Tue, 08 Dec 2009 10:18:00 -0800 (PST)
Received: from localhost.localdomain (p5496D98F.dip.t-dialin.net [84.150.217.143])
        by mx.google.com with ESMTPS id m5sm16688067gve.27.2009.12.08.10.17.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 10:17:59 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH -queue] MIPS: Alchemy: get rid of common/reset.c
Date:   Tue,  8 Dec 2009 19:18:13 +0100
Message-Id: <1260296294-18904-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.3
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Implement reset/poweroff in the board code instead.  The peripheral
reset code is gone too since YAMON (which all in-tree boards use)
does the same work when it boots.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Run-tested on DB1200, compiled tested on all other boards.
Applies on top of all the other Alchemy stuff in mips-queue.


 arch/mips/alchemy/common/Makefile                |    3 +-
 arch/mips/alchemy/common/reset.c                 |  185 ----------------------
 arch/mips/alchemy/common/setup.c                 |    9 -
 arch/mips/alchemy/devboards/db1200/setup.c       |   19 ---
 arch/mips/alchemy/devboards/db1x00/board_setup.c |   49 +++++-
 arch/mips/alchemy/devboards/platform.c           |   29 ++++
 arch/mips/alchemy/mtx-1/board_setup.c            |   15 ++-
 arch/mips/alchemy/xxs1500/board_setup.c          |   15 ++-
 8 files changed, 99 insertions(+), 225 deletions(-)
 delete mode 100644 arch/mips/alchemy/common/reset.c

diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index f46b351..06c0e65 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -5,8 +5,7 @@
 # Makefile for the Alchemy Au1xx0 CPUs, generic files.
 #
 
-obj-y += prom.o time.o reset.o \
-	clocks.o platform.o power.o setup.o \
+obj-y += prom.o time.o clocks.o platform.o power.o setup.o \
 	sleeper.o dma.o dbdma.o
 
 obj-$(CONFIG_ALCHEMY_GPIOINT_AU1000) += irq.o
diff --git a/arch/mips/alchemy/common/reset.c b/arch/mips/alchemy/common/reset.c
deleted file mode 100644
index 266afd4..0000000
--- a/arch/mips/alchemy/common/reset.c
+++ /dev/null
@@ -1,185 +0,0 @@
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
-#include <linux/gpio.h>
-
-#include <asm/cacheflush.h>
-#include <asm/mach-au1x00/au1000.h>
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
-	gpio_direction_output(210, 1);
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
index 375984e..193ba16 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -29,18 +29,13 @@
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
-#include <linux/pm.h>
 
 #include <asm/mipsregs.h>
-#include <asm/reboot.h>
 #include <asm/time.h>
 
 #include <au1000.h>
 
 extern void __init board_setup(void);
-extern void au1000_restart(char *);
-extern void au1000_halt(void);
-extern void au1000_power_off(void);
 extern void set_cpuspec(void);
 
 void __init plat_mem_setup(void)
@@ -57,10 +52,6 @@ void __init plat_mem_setup(void)
 	/* this is faster than wasting cycles trying to approximate it */
 	preset_lpj = (est_freq >> 1) / HZ;
 
-	_machine_restart = au1000_restart;
-	_machine_halt = au1000_halt;
-	pm_power_off = au1000_power_off;
-
 	board_setup();  /* board specific setup */
 
 	if (au1xxx_cpu_needs_config_od())
diff --git a/arch/mips/alchemy/devboards/db1200/setup.c b/arch/mips/alchemy/devboards/db1200/setup.c
index a3458c0..379536e 100644
--- a/arch/mips/alchemy/devboards/db1200/setup.c
+++ b/arch/mips/alchemy/devboards/db1200/setup.c
@@ -9,30 +9,15 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/pm.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/bcsr.h>
 #include <asm/mach-db1x00/db1200.h>
-#include <asm/processor.h>
-#include <asm/reboot.h>
 
 const char *get_system_type(void)
 {
 	return "Alchemy Db1200";
 }
 
-static void board_power_off(void)
-{
-	bcsr_write(BCSR_RESETS, 0);
-	bcsr_write(BCSR_SYSTEM, BCSR_SYSTEM_PWROFF | BCSR_SYSTEM_RESET);
-}
-
-void board_reset(void)
-{
-	bcsr_write(BCSR_RESETS, 0);
-	bcsr_write(BCSR_SYSTEM, 0);
-}
-
 void __init board_setup(void)
 {
 	unsigned long freq0, clksrc, div, pfc;
@@ -73,10 +58,6 @@ void __init board_setup(void)
 	clksrc = SYS_CS_MUX_FQ0 << SYS_CS_ME0_BIT;
 	__raw_writel(clksrc, (void __iomem *)SYS_CLKSRC);
 	wmb();
-
-	pm_power_off = board_power_off;
-	_machine_halt = board_power_off;
-	_machine_restart = (void(*)(char *))board_reset;
 }
 
 /* use the hexleds to count the number of times the cpu has entered
diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index 7aee14d..99ace3c 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -30,10 +30,12 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/pm.h>
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/db1x00.h>
 #include <asm/mach-db1x00/bcsr.h>
+#include <asm/reboot.h>
 
 #include <prom.h>
 
@@ -50,6 +52,18 @@ char irq_tab_alchemy[][5] __initdata = {
 	[12] = { -1, AU1500_PCI_INTA, 0xff, 0xff, 0xff }, /* IDSEL 12 - SN1741   */
 	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, AU1500_PCI_INTC, AU1500_PCI_INTD }, /* IDSEL 13 - PCI slot */
 };
+
+static void bosporus_power_off(void)
+{
+	printk(KERN_INFO "It's now safe to turn off power\n");
+	while (1)
+		asm volatile (".set mips3 ; wait ; .set mips0");
+}
+
+const char *get_system_type(void)
+{
+	return "Alchemy Bosporus Gateway Reference";
+}
 #endif
 
 #ifdef CONFIG_MIPS_MIRAGE
@@ -58,6 +72,16 @@ char irq_tab_alchemy[][5] __initdata = {
 	[12] = { -1, 0xff, 0xff, AU1500_PCI_INTC, 0xff }, /* IDSEL 12 - PNX1300 */
 	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff }, /* IDSEL 13 - miniPCI */
 };
+
+static void mirage_power_off(void)
+{
+	alchemy_gpio_direction_output(210, 1);
+}
+
+const char *get_system_type(void)
+{
+	return "Alchemy Mirage";
+}
 #endif
 
 #ifdef CONFIG_MIPS_DB1550
@@ -68,19 +92,19 @@ char irq_tab_alchemy[][5] __initdata = {
 };
 #endif
 
-const char *get_system_type(void)
+#if defined(CONFIG_MIPS_BOSPORUS) || defined(CONFIG_MIPS_MIRAGE)
+static void mips_softreset(void)
 {
-#ifdef CONFIG_MIPS_BOSPORUS
-	return "Alchemy Bosporus Gateway Reference";
-#else
-	return "Alchemy Db1x00";
-#endif
+	asm volatile ("jr\t%0" : : "r"(0xbfc00000));
 }
 
-void board_reset(void)
+#else
+
+const char *get_system_type(void)
 {
-	bcsr_write(BCSR_SYSTEM, 0);
+	return "Alchemy Db1x00";
 }
+#endif
 
 void __init board_setup(void)
 {
@@ -179,8 +203,17 @@ void __init board_setup(void)
 	 * be part of the audio driver.
 	 */
 	alchemy_gpio_direction_output(209, 1);
+
+	pm_power_off = mirage_power_off;
+	_machine_halt = mirage_power_off;
+	_machine_restart = (void(*)(char *))mips_softreset;
 #endif
 
+#ifdef CONFIG_MIPS_BOSPORUS
+	pm_power_off = bosporus_power_off;
+	_machine_halt = bosporus_power_off;
+	_machine_restart = (void(*)(char *))mips_softreset;
+#endif
 	au_sync();
 }
 
diff --git a/arch/mips/alchemy/devboards/platform.c b/arch/mips/alchemy/devboards/platform.c
index 7f2bcee..febf4e0 100644
--- a/arch/mips/alchemy/devboards/platform.c
+++ b/arch/mips/alchemy/devboards/platform.c
@@ -8,6 +8,35 @@
 #include <linux/mtd/physmap.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
+
+#include <asm/reboot.h>
+#include <asm/mach-db1x00/bcsr.h>
+
+static void db1x_power_off(void)
+{
+	bcsr_write(BCSR_RESETS, 0);
+	bcsr_write(BCSR_SYSTEM, BCSR_SYSTEM_PWROFF | BCSR_SYSTEM_RESET);
+}
+
+static void db1x_reset(char *c)
+{
+	bcsr_write(BCSR_RESETS, 0);
+	bcsr_write(BCSR_SYSTEM, 0);
+}
+
+static int __init db1x_poweroff_setup(void)
+{
+	if (!pm_power_off)
+		pm_power_off = db1x_power_off;
+	if (!_machine_halt)
+		_machine_halt = db1x_power_off;
+	if (!_machine_restart)
+		_machine_restart = db1x_reset;
+
+	return 0;
+}
+late_initcall(db1x_poweroff_setup);
 
 /* register a pcmcia socket */
 int __init db1x_register_pcmcia_socket(unsigned long pseudo_attr_start,
diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
index 13577ee..e2838c6 100644
--- a/arch/mips/alchemy/mtx-1/board_setup.c
+++ b/arch/mips/alchemy/mtx-1/board_setup.c
@@ -31,7 +31,9 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/pm.h>
 
+#include <asm/reboot.h>
 #include <asm/mach-au1x00/au1000.h>
 
 #include <prom.h>
@@ -50,12 +52,19 @@ char irq_tab_alchemy[][5] __initdata = {
 extern int (*board_pci_idsel)(unsigned int devsel, int assert);
 int mtx1_pci_idsel(unsigned int devsel, int assert);
 
-void board_reset(void)
+static void mtx1_reset(char *c)
 {
 	/* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
 	au_writel(0x00000000, 0xAE00001C);
 }
 
+static void mtx1_power_off(void)
+{
+	printk(KERN_ALERT "It's now safe to remove power\n");
+	while (1)
+		asm volatile (".set mips3 ; wait ; .set mips1");
+}
+
 void __init board_setup(void)
 {
 #ifdef CONFIG_SERIAL_8250_CONSOLE
@@ -98,6 +107,10 @@ void __init board_setup(void)
 	alchemy_gpio_direction_output(211, 1);	/* green on */
 	alchemy_gpio_direction_output(212, 0);	/* red off */
 
+	pm_power_off = mtx1_power_off;
+	_machine_halt = mtx1_power_off;
+	_machine_restart = mtx1_reset;
+
 	printk(KERN_INFO "4G Systems MTX-1 Board\n");
 }
 
diff --git a/arch/mips/alchemy/xxs1500/board_setup.c b/arch/mips/alchemy/xxs1500/board_setup.c
index 21bef8d..7956afa 100644
--- a/arch/mips/alchemy/xxs1500/board_setup.c
+++ b/arch/mips/alchemy/xxs1500/board_setup.c
@@ -27,17 +27,26 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/pm.h>
 
+#include <asm/reboot.h>
 #include <asm/mach-au1x00/au1000.h>
 
 #include <prom.h>
 
-void board_reset(void)
+static void xxs1500_reset(char *c)
 {
 	/* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
 	au_writel(0x00000000, 0xAE00001C);
 }
 
+static void xxs1500_power_off(void)
+{
+	printk(KERN_ALERT "It's now safe to remove power\n");
+	while (1)
+		asm volatile (".set mips3 ; wait ; .set mips1");
+}
+
 void __init board_setup(void)
 {
 	u32 pin_func;
@@ -52,6 +61,10 @@ void __init board_setup(void)
 	}
 #endif
 
+	pm_power_off = xxs1500_power_off;
+	_machine_halt = xxs1500_power_off;
+	_machine_restart = xxs1500_reset;
+
 	alchemy_gpio1_input_enable();
 	alchemy_gpio2_enable();
 
-- 
1.6.5.3
