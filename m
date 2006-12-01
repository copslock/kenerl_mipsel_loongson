Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 13:22:34 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:11808 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28573732AbWLANVQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 13:21:16 +0000
Received: by mo.po.2iij.net (mo31) id kB1DLEu9030758; Fri, 1 Dec 2006 22:21:14 +0900 (JST)
Received: from localhost.localdomain (133.25.30.125.dy.iij4u.or.jp [125.30.25.133])
	by mbox.po.2iij.net (mbox32) id kB1DL9pe027845
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 1 Dec 2006 22:21:09 +0900 (JST)
Date:	Fri, 1 Dec 2006 22:19:10 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 4/5] MIPS: update reset operations for cobalt
Message-Id: <20061201221910.56cde68c.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061201221746.1f45d98c.yoichi_yuasa@tripeaks.co.jp>
References: <20061201221242.261f57b0.yoichi_yuasa@tripeaks.co.jp>
	<20061201221601.3aa34024.yoichi_yuasa@tripeaks.co.jp>
	<20061201221746.1f45d98c.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated reset operations for cobalt.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/reset.c mips/arch/mips/cobalt/reset.c
--- mips-orig/arch/mips/cobalt/reset.c	2006-10-12 10:28:55.612126500 +0900
+++ mips/arch/mips/cobalt/reset.c	2006-10-12 10:32:39.698131000 +0900
@@ -8,17 +8,33 @@
  * Copyright (C) 1995, 1996, 1997 by Ralf Baechle
  * Copyright (C) 2001 by Liam Davies (ldavies@agile.tv)
  */
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <asm/cacheflush.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/pm.h>
+
 #include <asm/io.h>
-#include <asm/processor.h>
 #include <asm/reboot.h>
-#include <asm/system.h>
-#include <asm/mipsregs.h>
-#include <asm/mach-cobalt/cobalt.h>
 
-void cobalt_machine_halt(void)
+#define COBALT_LED_PORT		(void __iomem *)CKSEG1ADDR(0x1c000000)
+# define COBALT_LED_BAR_LEFT	(1 << 0)	/* Qube */
+# define COBALT_LED_BAR_RIGHT	(1 << 1)	/* Qube */
+# define COBALT_LED_WEB		(1 << 2)	/* RaQ */
+# define COBALT_LED_POWER_OFF	(1 << 3)	/* RaQ */
+# define COBALT_LED_RESET	0x0f
+
+#define COBALT_KEY_PORT							\
+	((~readl((void __iomem *)CKSEG1ADDR(0x1d000000)) >> 24) &	\
+	COBALT_KEY_MASK)
+# define COBALT_KEY_CLEAR	(1 << 1)
+# define COBALT_KEY_LEFT	(1 << 2)
+# define COBALT_KEY_UP		(1 << 3)
+# define COBALT_KEY_DOWN	(1 << 4)
+# define COBALT_KEY_RIGHT	(1 << 5)
+# define COBALT_KEY_ENTER	(1 << 6)
+# define COBALT_KEY_SELECT	(1 << 7)
+# define COBALT_KEY_MASK	0xfe
+
+static void cobalt_machine_halt(void)
 {
 	int state, last, diff;
 	unsigned long mark;
@@ -34,22 +50,23 @@ void cobalt_machine_halt(void)
 	for (state = 0;;) {
 
 		state ^= COBALT_LED_POWER_OFF;
-		COBALT_LED_PORT = state;
+		writeb(state, COBALT_LED_PORT);
 
 		diff = COBALT_KEY_PORT ^ last;
 		last ^= diff;
 
-		if((diff & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)) && !(~last & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)))
-			COBALT_LED_PORT = COBALT_LED_RESET;
+		if((diff & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)) &&
+		   !(~last & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)))
+			writeb(COBALT_LED_RESET, COBALT_LED_PORT);
 
 		for (mark = jiffies; jiffies - mark < HZ;)
 			;
 	}
 }
 
-void cobalt_machine_restart(char *command)
+static void cobalt_machine_restart(char *command)
 {
-	COBALT_LED_PORT = COBALT_LED_RESET;
+	writeb(COBALT_LED_RESET, COBALT_LED_PORT);
 
 	/* we should never get here */
 	cobalt_machine_halt();
@@ -58,8 +75,19 @@ void cobalt_machine_restart(char *comman
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
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
--- mips-orig/arch/mips/cobalt/setup.c	2006-10-12 10:32:51.726882750 +0900
+++ mips/arch/mips/cobalt/setup.c	2006-10-12 10:34:09.171722750 +0900
@@ -12,7 +12,6 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/pm.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 
@@ -21,14 +20,10 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/processor.h>
-#include <asm/reboot.h>
 #include <asm/gt64120.h>
 
 #include <asm/mach-cobalt/cobalt.h>
 
-extern void cobalt_machine_restart(char *command);
-extern void cobalt_machine_halt(void);
-extern void cobalt_machine_power_off(void);
 extern void cobalt_early_console(void);
 
 int cobalt_board_id;
@@ -82,10 +77,6 @@ void __init plat_mem_setup(void)
 	unsigned int devfn = PCI_DEVFN(COBALT_PCICONF_VIA, 0);
 	int i;
 
-	_machine_restart = cobalt_machine_restart;
-	_machine_halt = cobalt_machine_halt;
-	pm_power_off = cobalt_machine_power_off;
-
 	set_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
 
 	ioport_resource.end = 0xffff;
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-cobalt/cobalt.h mips/include/asm-mips/mach-cobalt/cobalt.h
--- mips-orig/include/asm-mips/mach-cobalt/cobalt.h	2006-10-12 10:32:50.006775250 +0900
+++ mips/include/asm-mips/mach-cobalt/cobalt.h	2006-10-12 10:32:39.698131000 +0900
@@ -71,23 +71,6 @@
 	GT_WRITE(GT_PCI0_CFGADDR_OFS, (0x80000000 | (PCI_SLOT (devfn) << 11) |		\
 		(PCI_FUNC (devfn) << 8) | (where)))
 
-#define COBALT_LED_PORT		(*(volatile unsigned char *) CKSEG1ADDR(0x1c000000))
-# define COBALT_LED_BAR_LEFT	(1 << 0)	/* Qube */
-# define COBALT_LED_BAR_RIGHT	(1 << 1)	/* Qube */
-# define COBALT_LED_WEB		(1 << 2)	/* RaQ */
-# define COBALT_LED_POWER_OFF	(1 << 3)	/* RaQ */
-# define COBALT_LED_RESET	0x0f
-
-#define COBALT_KEY_PORT		((~*(volatile unsigned int *) CKSEG1ADDR(0x1d000000) >> 24) & COBALT_KEY_MASK)
-# define COBALT_KEY_CLEAR	(1 << 1)
-# define COBALT_KEY_LEFT	(1 << 2)
-# define COBALT_KEY_UP		(1 << 3)
-# define COBALT_KEY_DOWN	(1 << 4)
-# define COBALT_KEY_RIGHT	(1 << 5)
-# define COBALT_KEY_ENTER	(1 << 6)
-# define COBALT_KEY_SELECT	(1 << 7)
-# define COBALT_KEY_MASK	0xfe
-
 #define COBALT_UART		((volatile unsigned char *) CKSEG1ADDR(0x1c800000))
 
 #endif /* __ASM_COBALT_H */
