Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 13:21:12 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:18500 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28573702AbWLANVH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 13:21:07 +0000
Received: by mo.po.2iij.net (mo31) id kB1DL5YY030730; Fri, 1 Dec 2006 22:21:05 +0900 (JST)
Received: from localhost.localdomain (133.25.30.125.dy.iij4u.or.jp [125.30.25.133])
	by mbox.po.2iij.net (mbox32) id kB1DL2aR027760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 1 Dec 2006 22:21:03 +0900 (JST)
Date:	Fri, 1 Dec 2006 22:17:46 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 3/5] MIPS: separate cobalt PCI codes from setup.c
Message-Id: <20061201221746.1f45d98c.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061201221601.3aa34024.yoichi_yuasa@tripeaks.co.jp>
References: <20061201221242.261f57b0.yoichi_yuasa@tripeaks.co.jp>
	<20061201221601.3aa34024.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has separated cobalt PCI codes from setup.c .
It's removed #ifdef CONFIG_PCI/#endif from cobalt setup.c .

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/Makefile mips/arch/mips/cobalt/Makefile
--- mips-orig/arch/mips/cobalt/Makefile	2006-10-12 10:19:25.000465500 +0900
+++ mips/arch/mips/cobalt/Makefile	2006-10-12 10:19:58.502559250 +0900
@@ -4,6 +4,7 @@
 
 obj-y	 := irq.o reset.o setup.o
 
+obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_EARLY_PRINTK)	+= console.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/pci.c mips/arch/mips/cobalt/pci.c
--- mips-orig/arch/mips/cobalt/pci.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/cobalt/pci.c	2006-10-12 10:19:58.502559250 +0900
@@ -0,0 +1,47 @@
+/*
+ * Register PCI controller.
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
+#include <linux/pci.h>
+
+#include <asm/gt64120.h>
+
+extern struct pci_ops gt64111_pci_ops;
+
+static struct resource cobalt_mem_resource = {
+	.start	= GT_DEF_PCI0_MEM0_BASE,
+	.end	= GT_DEF_PCI0_MEM0_BASE + GT_DEF_PCI0_MEM0_SIZE - 1,
+	.name	= "PCI memory",
+	.flags	= IORESOURCE_MEM,
+};
+
+static struct resource cobalt_io_resource = {
+	.start	= 0x1000,
+	.end	= 0xffff,
+	.name	= "PCI I/O",
+	.flags	= IORESOURCE_IO,
+};
+
+static struct pci_controller cobalt_pci_controller = {
+	.pci_ops	= &gt64111_pci_ops,
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
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
--- mips-orig/arch/mips/cobalt/setup.c	2006-10-12 10:20:53.049968250 +0900
+++ mips/arch/mips/cobalt/setup.c	2006-10-12 10:22:31.464118750 +0900
@@ -63,22 +63,6 @@ void __init plat_timer_setup(struct irqa
 	GT_WRITE(GT_INTRMASK_OFS, GT_INTR_T0EXP_MSK | GT_READ(GT_INTRMASK_OFS));
 }
 
-extern struct pci_ops gt64111_pci_ops;
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
 /*
  * Cobalt doesn't have PS/2 keyboard/mouse interfaces,
  * keyboard conntroller is never used.
@@ -92,14 +76,6 @@ static struct resource cobalt_reserved_r
 	},
 };
 
-static struct pci_controller cobalt_pci_controller = {
-	.pci_ops	= &gt64111_pci_ops,
-	.mem_resource	= &cobalt_mem_resource,
-	.mem_offset	= 0,
-	.io_resource	= &cobalt_io_resource,
-	.io_offset	= 0 - GT_DEF_PCI0_IO_BASE,
-};
-
 void __init plat_mem_setup(void)
 {
 	static struct uart_port uart;
@@ -126,10 +102,6 @@ void __init plat_mem_setup(void)
 
 	printk("Cobalt board ID: %d\n", cobalt_board_id);
 
-#ifdef CONFIG_PCI
-	register_pci_controller(&cobalt_pci_controller);
-#endif
-
 	if (cobalt_board_id > COBALT_BRD_ID_RAQ1) {
 #ifdef CONFIG_EARLY_PRINTK
 		cobalt_early_console();
