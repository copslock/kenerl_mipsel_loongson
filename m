Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 15:00:57 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:39998 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038736AbWHVN6t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Aug 2006 14:58:49 +0100
Received: by mo.po.2iij.net (mo32) id k7MDwlSm037059; Tue, 22 Aug 2006 22:58:47 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox33) id k7MDwja0012216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Aug 2006 22:58:46 +0900 (JST)
Date:	Tue, 22 Aug 2006 22:57:27 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 6/12] updated reset oprations for Cobalt
Message-Id: <20060822225727.0291dd69.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated reset operations for Cobalt.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/reset.c mips/arch/mips/gt64120/cobalt/reset.c
--- mips-orig/arch/mips/gt64120/cobalt/reset.c	2006-08-19 00:03:23.634606250 +0900
+++ mips/arch/mips/gt64120/cobalt/reset.c	2006-08-18 23:51:45.647500500 +0900
@@ -8,17 +8,15 @@
  * Copyright (C) 1995, 1996, 1997 by Ralf Baechle
  * Copyright (C) 2001 by Liam Davies (ldavies@agile.tv)
  */
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <asm/cacheflush.h>
-#include <asm/io.h>
-#include <asm/processor.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/pm.h>
+
 #include <asm/reboot.h>
-#include <asm/system.h>
-#include <asm/mipsregs.h>
-#include <asm/mach-cobalt/cobalt.h>
 
-void cobalt_machine_halt(void)
+#include <cobalt.h>
+
+static void cobalt_machine_halt(void)
 {
 	int state, last, diff;
 	unsigned long mark;
@@ -39,7 +37,8 @@ void cobalt_machine_halt(void)
 		diff = COBALT_KEY_PORT ^ last;
 		last ^= diff;
 
-		if((diff & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)) && !(~last & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)))
+		if((diff & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)) &&
+		   !(~last & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)))
 			COBALT_LED_PORT = COBALT_LED_RESET;
 
 		for (mark = jiffies; jiffies - mark < HZ;)
@@ -47,7 +46,7 @@ void cobalt_machine_halt(void)
 	}
 }
 
-void cobalt_machine_restart(char *command)
+static void cobalt_machine_restart(char *command)
 {
 	COBALT_LED_PORT = COBALT_LED_RESET;
 
@@ -58,8 +57,19 @@ void cobalt_machine_restart(char *comman
 /*
  * This triggers the luser mode device driver for the power switch ;-)
  */
-void cobalt_machine_power_off(void)
+static void cobalt_machine_power_off(void)
 {
 	printk("You can switch the machine off now.\n");
 	cobalt_machine_halt();
 }
+
+static int __init cobalt_reset_init(void)
+{
+	_machine_restart = cobalt_machine_restart;
+	_machine_halt = cobalt_machine_halt;
+	pm_power_off = cobalt_machine_power_off;
+
+	return 0;
+}
+
+arch_initcall(cobalt_reset_init);
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/setup.c mips/arch/mips/gt64120/cobalt/setup.c
--- mips-orig/arch/mips/gt64120/cobalt/setup.c	2006-08-19 00:03:23.710573000 +0900
+++ mips/arch/mips/gt64120/cobalt/setup.c	2006-08-19 00:01:35.813798500 +0900
@@ -12,7 +12,6 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/pm.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 
@@ -21,15 +20,11 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/processor.h>
-#include <asm/reboot.h>
 #include <asm/gt64120.h>
 #include <asm/serial.h>
 
 #include <cobalt.h>
 
-extern void cobalt_machine_restart(char *command);
-extern void cobalt_machine_halt(void);
-extern void cobalt_machine_power_off(void);
 extern void cobalt_early_console(void);
 
 int cobalt_board_id;
@@ -116,10 +111,6 @@ void __init plat_mem_setup(void)
 	unsigned int devfn = PCI_DEVFN(COBALT_PCICONF_VIA, 0);
 	int i;
 
-	_machine_restart = cobalt_machine_restart;
-	_machine_halt = cobalt_machine_halt;
-	pm_power_off = cobalt_machine_power_off;
-
 	gt641xx_disable_alltimers();
 	board_time_init = gt641xx_timer3_init;
 
