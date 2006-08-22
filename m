Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 14:58:48 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:6733 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037410AbWHVN6q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Aug 2006 14:58:46 +0100
Received: by mo.po.2iij.net (mo32) id k7MDwhih037041; Tue, 22 Aug 2006 22:58:43 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox33) id k7MDwfP0012167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Aug 2006 22:58:42 +0900 (JST)
Date:	Tue, 22 Aug 2006 22:34:06 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2/12] Cobalt use GT64120 PCI routines
Message-Id: <20060822223406.56435d84.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has moved GT64111 PCI routine to GT64120 PCI routine about Cobalt.
They are same codes.

This patch tested on Cobalt Qube2.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2006-07-31 10:19:57.438229750 +0900
+++ mips/arch/mips/Kconfig	2006-07-31 10:18:09.735498750 +0900
@@ -150,7 +150,7 @@ config MIPS_COBALT
 	select HW_HAS_PCI
 	select I8259
 	select IRQ_CPU
-	select MIPS_GT64111
+	select MIPS_GT64120
 	select SYS_HAS_CPU_NEVADA
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
@@ -961,9 +961,6 @@ config DDB5XXX_COMMON
 config MIPS_BOARDS_GEN
 	bool
 
-config MIPS_GT64111
-	bool
-
 config MIPS_GT64120
 	bool
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
--- mips-orig/arch/mips/cobalt/setup.c	2006-07-31 10:20:07.002827500 +0900
+++ mips/arch/mips/cobalt/setup.c	2006-07-31 10:18:09.735498750 +0900
@@ -64,7 +64,7 @@ void __init plat_timer_setup(struct irqa
 	GT_WRITE(GT_INTRMASK_OFS, GALILEO_INTR_T0EXP | GT_READ(GT_INTRMASK_OFS));
 }
 
-extern struct pci_ops gt64111_pci_ops;
+extern struct pci_ops gt64120_pci_ops;
 
 static struct resource cobalt_mem_resource = {
 	.start	= GT_DEF_PCI0_MEM0_BASE,
@@ -112,7 +112,7 @@ static struct resource cobalt_io_resourc
 #define COBALT_IO_RESOURCES (sizeof(cobalt_io_resources)/sizeof(struct resource))
 
 static struct pci_controller cobalt_pci_controller = {
-	.pci_ops	= &gt64111_pci_ops,
+	.pci_ops	= &gt64120_pci_ops,
 	.mem_resource	= &cobalt_mem_resource,
 	.mem_offset	= 0,
 	.io_resource	= &cobalt_io_resource,
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/Makefile mips/arch/mips/pci/Makefile
--- mips-orig/arch/mips/pci/Makefile	2006-07-31 10:18:39.113334750 +0900
+++ mips/arch/mips/pci/Makefile	2006-07-31 10:18:09.735498750 +0900
@@ -9,7 +9,6 @@ obj-y				+= pci.o
 #
 obj-$(CONFIG_ITE_BOARD_GEN)	+= ops-it8172.o
 obj-$(CONFIG_MIPS_BONITO64)	+= ops-bonito64.o
-obj-$(CONFIG_MIPS_GT64111)	+= ops-gt64111.o
 obj-$(CONFIG_MIPS_GT64120)	+= ops-gt64120.o
 obj-$(CONFIG_MIPS_GT96100)	+= ops-gt96100.o
 obj-$(CONFIG_PCI_MARVELL)	+= ops-marvell.o
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/ops-gt64111.c mips/arch/mips/pci/ops-gt64111.c
--- mips-orig/arch/mips/pci/ops-gt64111.c	2006-07-31 10:20:07.002827500 +0900
+++ mips/arch/mips/pci/ops-gt64111.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,100 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1995, 1996, 1997, 2002 by Ralf Baechle
- * Copyright (C) 2001, 2002, 2003 by Liam Davies (ldavies@agile.tv)
- */
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-
-#include <asm/pci.h>
-#include <asm/io.h>
-#include <asm/gt64120.h>
-
-#include <asm/mach-cobalt/cobalt.h>
-
-/*
- * Device 31 on the GT64111 is used to generate PCI special
- * cycles, so we shouldn't expected to find a device there ...
- */
-static inline int pci_range_ck(struct pci_bus *bus, unsigned int devfn)
-{
-	if (bus->number == 0 && PCI_SLOT(devfn) < 31)
-		return 0;
-
-	return -1;
-}
-
-static int gt64111_pci_read_config(struct pci_bus *bus, unsigned int devfn,
-	int where, int size, u32 * val)
-{
-	if (pci_range_ck(bus, devfn))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	switch (size) {
-	case 4:
-		PCI_CFG_SET(devfn, where);
-		*val = GT_READ(GT_PCI0_CFGDATA_OFS);
-		return PCIBIOS_SUCCESSFUL;
-
-	case 2:
-		PCI_CFG_SET(devfn, (where & ~0x3));
-		*val = GT_READ(GT_PCI0_CFGDATA_OFS)
-		    >> ((where & 3) * 8);
-		return PCIBIOS_SUCCESSFUL;
-
-	case 1:
-		PCI_CFG_SET(devfn, (where & ~0x3));
-		*val = GT_READ(GT_PCI0_CFGDATA_OFS)
-		    >> ((where & 3) * 8);
-		return PCIBIOS_SUCCESSFUL;
-	}
-
-	return PCIBIOS_BAD_REGISTER_NUMBER;
-}
-
-static int gt64111_pci_write_config(struct pci_bus *bus, unsigned int devfn,
-	int where, int size, u32 val)
-{
-	u32 tmp;
-
-	if (pci_range_ck(bus, devfn))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	switch (size) {
-	case 4:
-		PCI_CFG_SET(devfn, where);
-		GT_WRITE(GT_PCI0_CFGDATA_OFS, val);
-
-		return PCIBIOS_SUCCESSFUL;
-
-	case 2:
-		PCI_CFG_SET(devfn, (where & ~0x3));
-		tmp = GT_READ(GT_PCI0_CFGDATA_OFS);
-		tmp &= ~(0xffff << ((where & 0x3) * 8));
-		tmp |= (val << ((where & 0x3) * 8));
-		GT_WRITE(GT_PCI0_CFGDATA_OFS, tmp);
-
-		return PCIBIOS_SUCCESSFUL;
-
-	case 1:
-		PCI_CFG_SET(devfn, (where & ~0x3));
-		tmp = GT_READ(GT_PCI0_CFGDATA_OFS);
-		tmp &= ~(0xff << ((where & 0x3) * 8));
-		tmp |= (val << ((where & 0x3) * 8));
-		GT_WRITE(GT_PCI0_CFGDATA_OFS, tmp);
-
-		return PCIBIOS_SUCCESSFUL;
-	}
-
-	return PCIBIOS_BAD_REGISTER_NUMBER;
-}
-
-struct pci_ops gt64111_pci_ops = {
-	.read = gt64111_pci_read_config,
-	.write = gt64111_pci_write_config,
-};
