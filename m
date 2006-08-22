Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 15:01:24 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:10553 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038739AbWHVN6u (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Aug 2006 14:58:50 +0100
Received: by mo.po.2iij.net (mo32) id k7MDwmjl037063; Tue, 22 Aug 2006 22:58:48 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox33) id k7MDwks8012223
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Aug 2006 22:58:47 +0900 (JST)
Date:	Tue, 22 Aug 2006 22:57:44 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 7/12] separated Cobalt PCI codes from setup.c
Message-Id: <20060822225744.1018f8ee.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has separated Cobalt PCI codes from setup.c.
It's removed a #ifdef/#endif from Cobalt setup.c .

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/Makefile mips/arch/mips/gt64120/cobalt/Makefile
--- mips-orig/arch/mips/gt64120/cobalt/Makefile	2006-08-19 00:03:23.634606250 +0900
+++ mips/arch/mips/gt64120/cobalt/Makefile	2006-08-19 00:09:29.159255750 +0900
@@ -4,6 +4,7 @@
 
 obj-y	 := irq.o reset.o setup.o
 
+obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_EARLY_PRINTK)	+= console.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/pci.c mips/arch/mips/gt64120/cobalt/pci.c
--- mips-orig/arch/mips/gt64120/cobalt/pci.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/gt64120/cobalt/pci.c	2006-08-19 00:09:13.382269750 +0900
@@ -0,0 +1,46 @@
+/*
+ * Setup PCI controller.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1996, 1997, 2004, 05 by Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2001, 2002, 2003 by Liam Davies (ldavies@agile.tv)
+ *
+ */
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+
+#include <asm/gt64120.h>
+
+static struct resource cobalt_mem_resource = {
+	.start	= GT_DEF_PCI0_MEM0_BASE,
+	.end	= GT_DEF_PCI0_MEM0_BASE + GT_DEF_PCI0_MEM0_SIZE - 1,
+	.name	= "PCI memory",
+	.flags	= IORESOURCE_MEM
+};
+
+static struct resource cobalt_io_resource = {
+	.start	= 0x1000,
+	.end	= 0xffff,
+	.name	= "PCI I/O",
+	.flags	= IORESOURCE_IO
+};
+
+static struct pci_controller cobalt_pci_controller = {
+	.pci_ops	= &gt64120_pci_ops,
+	.mem_resource	= &cobalt_mem_resource,
+	.io_resource	= &cobalt_io_resource,
+	.io_offset	= 0 - GT_DEF_PCI0_IO_BASE,
+};
+
+static int __init cobalt_pci_init(void)
+{
+	register_pci_controller(&cobalt_pci_controller);
+
+	return 0;
+}
+
+arch_initcall(cobalt_pci_init);
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/setup.c mips/arch/mips/gt64120/cobalt/setup.c
--- mips-orig/arch/mips/gt64120/cobalt/setup.c	2006-08-19 00:14:19.661411000 +0900
+++ mips/arch/mips/gt64120/cobalt/setup.c	2006-08-19 00:16:05.352016250 +0900
@@ -50,22 +50,6 @@ void __init plat_timer_setup(struct irqa
 	setup_irq(COBALT_TIMER3_IRQ, irq);
 }
 
-extern struct pci_ops gt64120_pci_ops;
-
-static struct resource cobalt_mem_resource = {
-	.start	= GT_DEF_PCI0_MEM0_BASE,
-	.end	= GT_DEF_PCI0_MEM0_BASE + GT_DEF_PCI0_MEM0_SIZE - 1,
-	.name	= "PCI memory",
-	.flags	= IORESOURCE_MEM
-};
-
-static struct resource cobalt_io_resource = {
-	.start	= 0x1000,
-	.end	= 0xffff,
-	.name	= "PCI I/O",
-	.flags	= IORESOURCE_IO
-};
-
 static struct resource cobalt_io_resources[] = {
 	{
 		.start	= 0x00,
@@ -97,14 +81,6 @@ static struct resource cobalt_io_resourc
 
 #define COBALT_IO_RESOURCES (sizeof(cobalt_io_resources)/sizeof(struct resource))
 
-static struct pci_controller cobalt_pci_controller = {
-	.pci_ops	= &gt64120_pci_ops,
-	.mem_resource	= &cobalt_mem_resource,
-	.mem_offset	= 0,
-	.io_resource	= &cobalt_io_resource,
-	.io_offset	= 0 - GT_DEF_PCI0_IO_BASE,
-};
-
 void __init plat_mem_setup(void)
 {
 	static struct uart_port uart;
@@ -131,10 +107,6 @@ void __init plat_mem_setup(void)
 
 	printk("Cobalt board ID: %d\n", cobalt_board_id);
 
-#ifdef CONFIG_PCI
-	register_pci_controller(&cobalt_pci_controller);
-#endif
-
 #ifdef CONFIG_SERIAL_8250
 	if (cobalt_board_id > COBALT_BRD_ID_RAQ1) {
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/gt64120.h mips/include/asm-mips/gt64120.h
--- mips-orig/include/asm-mips/gt64120.h	2006-08-19 00:03:23.714571250 +0900
+++ mips/include/asm-mips/gt64120.h	2006-08-19 00:07:32.977471000 +0900
@@ -580,4 +580,6 @@ extern void gt641xx_irq_init(unsigned in
 extern void gt641xx_timer3_init(void);
 extern void gt641xx_disable_alltimers(void);
 
+extern struct pci_ops gt64120_pci_ops;
+
 #endif /* _ASM_GT64120_H */
