Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2007 12:52:55 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:35867 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022416AbXCNMwt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Mar 2007 12:52:49 +0000
Received: by mo.po.2iij.net (mo31) id l2ECpUlr060304; Wed, 14 Mar 2007 21:51:30 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id l2ECpP5K036521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 14 Mar 2007 21:51:26 +0900 (JST)
Date:	Wed, 14 Mar 2007 21:51:26 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] merge GT64111 PCI routines and GT64120 PCI_0 routines
Message-Id: <20070314215126.72d21e96.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has merged GT64111 PCI routines and GT64120 PCI_0 routines.
GT64111 PCI is almost the same as GT64120's PCI_0.
This patch don't change GT64120 PCI routines.

This patch tested on Cobalt Qube2.

Please queue for 2.6.22.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-03-14 09:08:10.934923250 +0900
+++ mips/arch/mips/Kconfig	2007-03-13 23:21:52.920732500 +0900
@@ -165,7 +165,7 @@ config MIPS_COBALT
 	select HW_HAS_PCI
 	select I8259
 	select IRQ_CPU
-	select MIPS_GT64111
+	select PCI_GT64XXX_PCI0
 	select SYS_HAS_CPU_NEVADA
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -207,7 +207,7 @@ config MIPS_EV64120
 	depends on EXPERIMENTAL
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select MIPS_GT64120
+	select PCI_GT64XXX_PCI0
 	select SYS_HAS_CPU_R5000
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
@@ -245,7 +245,7 @@ config LASAT
 	select DMA_NONCOHERENT
 	select SYS_HAS_EARLY_PRINTK
 	select HW_HAS_PCI
-	select MIPS_GT64120
+	select PCI_GT64XXX_PCI0
 	select MIPS_NILE4
 	select R5000_CPU_SCACHE
 	select SYS_HAS_CPU_R5000
@@ -263,7 +263,7 @@ config MIPS_ATLAS
 	select HW_HAS_PCI
 	select MIPS_BOARDS_GEN
 	select MIPS_BONITO64
-	select MIPS_GT64120
+	select PCI_GT64XXX_PCI0
 	select MIPS_MSC
 	select RM7000_CPU_SCACHE
 	select SWAP_IO_SPACE
@@ -296,7 +296,7 @@ config MIPS_MALTA
 	select MIPS_BOARDS_GEN
 	select MIPS_BONITO64
 	select MIPS_CPU_SCACHE
-	select MIPS_GT64120
+	select PCI_GT64XXX_PCI0
 	select MIPS_MSC
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_MIPS32_R1
@@ -340,7 +340,7 @@ config WR_PPMC
 	select BOOT_ELF32
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select MIPS_GT64120
+	select PCI_GT64XXX_PCI0
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
@@ -398,7 +398,7 @@ config MOMENCO_OCELOT
 	select HW_HAS_PCI
 	select IRQ_CPU
 	select IRQ_CPU_RM7K
-	select MIPS_GT64120
+	select PCI_GT64XXX_PCI0
 	select RM7000_CPU_SCACHE
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_RM7000
@@ -997,10 +997,7 @@ config DDB5XXX_COMMON
 config MIPS_BOARDS_GEN
 	bool
 
-config MIPS_GT64111
-	bool
-
-config MIPS_GT64120
+config PCI_GT64XXX_PCI0
 	bool
 
 config MIPS_TX3927
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/pci.c mips/arch/mips/cobalt/pci.c
--- mips-orig/arch/mips/cobalt/pci.c	2007-03-14 09:08:10.950924250 +0900
+++ mips/arch/mips/cobalt/pci.c	2007-03-13 23:21:52.920732500 +0900
@@ -14,7 +14,7 @@
 
 #include <asm/gt64120.h>
 
-extern struct pci_ops gt64111_pci_ops;
+extern struct pci_ops gt64xxx_pci0_ops;
 
 static struct resource cobalt_mem_resource = {
 	.start	= GT_DEF_PCI0_MEM0_BASE,
@@ -31,7 +31,7 @@ static struct resource cobalt_io_resourc
 };
 
 static struct pci_controller cobalt_pci_controller = {
-	.pci_ops	= &gt64111_pci_ops,
+	.pci_ops	= &gt64xxx_pci0_ops,
 	.mem_resource	= &cobalt_mem_resource,
 	.io_resource	= &cobalt_io_resource,
 	.io_offset	= 0 - GT_DEF_PCI0_IO_BASE,
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/wrppmc/pci.c mips/arch/mips/gt64120/wrppmc/pci.c
--- mips-orig/arch/mips/gt64120/wrppmc/pci.c	2007-03-14 09:08:10.962925000 +0900
+++ mips/arch/mips/gt64120/wrppmc/pci.c	2007-03-13 23:21:52.936733500 +0900
@@ -13,7 +13,7 @@
 #include <linux/kernel.h>
 #include <asm/gt64120.h>
 
-extern struct pci_ops gt64120_pci_ops;
+extern struct pci_ops gt64xxx_pci0_ops;
 
 static struct resource pci0_io_resource = {
 	.name  = "pci_0 io",
@@ -30,7 +30,7 @@ static struct resource pci0_mem_resource
 };
 
 static struct pci_controller hose_0 = {
-	.pci_ops	= &gt64120_pci_ops,
+	.pci_ops	= &gt64xxx_pci0_ops,
 	.io_resource	= &pci0_io_resource,
 	.mem_resource	= &pci0_mem_resource,
 };
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/mips-boards/generic/pci.c mips/arch/mips/mips-boards/generic/pci.c
--- mips-orig/arch/mips/mips-boards/generic/pci.c	2007-03-14 09:08:10.978926000 +0900
+++ mips/arch/mips/mips-boards/generic/pci.c	2007-03-13 23:21:52.968735500 +0900
@@ -65,7 +65,7 @@ static struct resource msc_io_resource =
 };
 
 extern struct pci_ops bonito64_pci_ops;
-extern struct pci_ops gt64120_pci_ops;
+extern struct pci_ops gt64xxx_pci0_ops;
 extern struct pci_ops msc_pci_ops;
 
 static struct pci_controller bonito64_controller = {
@@ -76,7 +76,7 @@ static struct pci_controller bonito64_co
 };
 
 static struct pci_controller gt64120_controller = {
-	.pci_ops	= &gt64120_pci_ops,
+	.pci_ops	= &gt64xxx_pci0_ops,
 	.io_resource	= &gt64120_io_resource,
 	.mem_resource	= &gt64120_mem_resource,
 };
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/Makefile mips/arch/mips/pci/Makefile
--- mips-orig/arch/mips/pci/Makefile	2007-03-14 09:08:10.990926750 +0900
+++ mips/arch/mips/pci/Makefile	2007-03-13 23:21:52.992737000 +0900
@@ -8,8 +8,7 @@ obj-y				+= pci.o pci-dac.o
 # PCI bus host bridge specific code
 #
 obj-$(CONFIG_MIPS_BONITO64)	+= ops-bonito64.o
-obj-$(CONFIG_MIPS_GT64111)	+= ops-gt64111.o
-obj-$(CONFIG_MIPS_GT64120)	+= ops-gt64120.o
+obj-$(CONFIG_PCI_GT64XXX_PCI0)	+= ops-gt64xxx_pci0.o
 obj-$(CONFIG_PCI_MARVELL)	+= ops-marvell.o
 obj-$(CONFIG_MIPS_MSC)		+= ops-msc.o
 obj-$(CONFIG_MIPS_NILE4)	+= ops-nile4.o
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/ops-gt64111.c mips/arch/mips/pci/ops-gt64111.c
--- mips-orig/arch/mips/pci/ops-gt64111.c	2007-03-14 09:08:10.998927250 +0900
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
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/ops-gt64120.c mips/arch/mips/pci/ops-gt64120.c
--- mips-orig/arch/mips/pci/ops-gt64120.c	2007-03-14 09:08:11.026929000 +0900
+++ mips/arch/mips/pci/ops-gt64120.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,152 +0,0 @@
-/*
- * Copyright (C) 1999, 2000, 2004  MIPS Technologies, Inc.
- *	All rights reserved.
- *	Authors: Carsten Langgaard <carstenl@mips.com>
- *		 Maciej W. Rozycki <macro@mips.com>
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- */
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-
-#include <asm/gt64120.h>
-
-#define PCI_ACCESS_READ  0
-#define PCI_ACCESS_WRITE 1
-
-/*
- *  PCI configuration cycle AD bus definition
- */
-/* Type 0 */
-#define PCI_CFG_TYPE0_REG_SHF           0
-#define PCI_CFG_TYPE0_FUNC_SHF          8
-
-/* Type 1 */
-#define PCI_CFG_TYPE1_REG_SHF           0
-#define PCI_CFG_TYPE1_FUNC_SHF          8
-#define PCI_CFG_TYPE1_DEV_SHF           11
-#define PCI_CFG_TYPE1_BUS_SHF           16
-
-static int gt64120_pcibios_config_access(unsigned char access_type,
-	struct pci_bus *bus, unsigned int devfn, int where, u32 * data)
-{
-	unsigned char busnum = bus->number;
-	u32 intr;
-
-	if ((busnum == 0) && (devfn >= PCI_DEVFN(31, 0)))
-		return -1;	/* Because of a bug in the galileo (for slot 31). */
-
-	/* Clear cause register bits */
-	GT_WRITE(GT_INTRCAUSE_OFS, ~(GT_INTRCAUSE_MASABORT0_BIT |
-	                             GT_INTRCAUSE_TARABORT0_BIT));
-
-	/* Setup address */
-	GT_WRITE(GT_PCI0_CFGADDR_OFS,
-		 (busnum << GT_PCI0_CFGADDR_BUSNUM_SHF) |
-		 (devfn << GT_PCI0_CFGADDR_FUNCTNUM_SHF) |
-		 ((where / 4) << GT_PCI0_CFGADDR_REGNUM_SHF) |
-		 GT_PCI0_CFGADDR_CONFIGEN_BIT);
-
-	if (access_type == PCI_ACCESS_WRITE) {
-		if (busnum == 0 && PCI_SLOT(devfn) == 0) {
-			/*
-			 * The Galileo system controller is acting
-			 * differently than other devices.
-			 */
-			GT_WRITE(GT_PCI0_CFGDATA_OFS, *data);
-		} else
-			__GT_WRITE(GT_PCI0_CFGDATA_OFS, *data);
-	} else {
-		if (busnum == 0 && PCI_SLOT(devfn) == 0) {
-			/*
-			 * The Galileo system controller is acting
-			 * differently than other devices.
-			 */
-			*data = GT_READ(GT_PCI0_CFGDATA_OFS);
-		} else
-			*data = __GT_READ(GT_PCI0_CFGDATA_OFS);
-	}
-
-	/* Check for master or target abort */
-	intr = GT_READ(GT_INTRCAUSE_OFS);
-
-	if (intr & (GT_INTRCAUSE_MASABORT0_BIT | GT_INTRCAUSE_TARABORT0_BIT)) {
-		/* Error occurred */
-
-		/* Clear bits */
-		GT_WRITE(GT_INTRCAUSE_OFS, ~(GT_INTRCAUSE_MASABORT0_BIT |
-		                             GT_INTRCAUSE_TARABORT0_BIT));
-
-		return -1;
-	}
-
-	return 0;
-}
-
-
-/*
- * We can't address 8 and 16 bit words directly.  Instead we have to
- * read/write a 32bit word and mask/modify the data we actually want.
- */
-static int gt64120_pcibios_read(struct pci_bus *bus, unsigned int devfn,
-                                int where, int size, u32 * val)
-{
-	u32 data = 0;
-
-	if (gt64120_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where,
-				          &data))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	if (size == 1)
-		*val = (data >> ((where & 3) << 3)) & 0xff;
-	else if (size == 2)
-		*val = (data >> ((where & 3) << 3)) & 0xffff;
-	else
-		*val = data;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int gt64120_pcibios_write(struct pci_bus *bus, unsigned int devfn,
-			      int where, int size, u32 val)
-{
-	u32 data = 0;
-
-	if (size == 4)
-		data = val;
-	else {
-		if (gt64120_pcibios_config_access(PCI_ACCESS_READ, bus, devfn,
-		                                  where, &data))
-			return PCIBIOS_DEVICE_NOT_FOUND;
-
-		if (size == 1)
-			data = (data & ~(0xff << ((where & 3) << 3))) |
-				(val << ((where & 3) << 3));
-		else if (size == 2)
-			data = (data & ~(0xffff << ((where & 3) << 3))) |
-				(val << ((where & 3) << 3));
-	}
-
-	if (gt64120_pcibios_config_access(PCI_ACCESS_WRITE, bus, devfn, where,
-				       &data))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-struct pci_ops gt64120_pci_ops = {
-	.read = gt64120_pcibios_read,
-	.write = gt64120_pcibios_write
-};
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/ops-gt64xxx_pci0.c mips/arch/mips/pci/ops-gt64xxx_pci0.c
--- mips-orig/arch/mips/pci/ops-gt64xxx_pci0.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/pci/ops-gt64xxx_pci0.c	2007-03-13 23:21:53.048740500 +0900
@@ -0,0 +1,152 @@
+/*
+ * Copyright (C) 1999, 2000, 2004  MIPS Technologies, Inc.
+ *	All rights reserved.
+ *	Authors: Carsten Langgaard <carstenl@mips.com>
+ *		 Maciej W. Rozycki <macro@mips.com>
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ */
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+
+#include <asm/gt64120.h>
+
+#define PCI_ACCESS_READ  0
+#define PCI_ACCESS_WRITE 1
+
+/*
+ *  PCI configuration cycle AD bus definition
+ */
+/* Type 0 */
+#define PCI_CFG_TYPE0_REG_SHF           0
+#define PCI_CFG_TYPE0_FUNC_SHF          8
+
+/* Type 1 */
+#define PCI_CFG_TYPE1_REG_SHF           0
+#define PCI_CFG_TYPE1_FUNC_SHF          8
+#define PCI_CFG_TYPE1_DEV_SHF           11
+#define PCI_CFG_TYPE1_BUS_SHF           16
+
+static int gt64xxx_pci0_pcibios_config_access(unsigned char access_type,
+		struct pci_bus *bus, unsigned int devfn, int where, u32 * data)
+{
+	unsigned char busnum = bus->number;
+	u32 intr;
+
+	if ((busnum == 0) && (devfn >= PCI_DEVFN(31, 0)))
+		return -1;	/* Because of a bug in the galileo (for slot 31). */
+
+	/* Clear cause register bits */
+	GT_WRITE(GT_INTRCAUSE_OFS, ~(GT_INTRCAUSE_MASABORT0_BIT |
+	                             GT_INTRCAUSE_TARABORT0_BIT));
+
+	/* Setup address */
+	GT_WRITE(GT_PCI0_CFGADDR_OFS,
+		 (busnum << GT_PCI0_CFGADDR_BUSNUM_SHF) |
+		 (devfn << GT_PCI0_CFGADDR_FUNCTNUM_SHF) |
+		 ((where / 4) << GT_PCI0_CFGADDR_REGNUM_SHF) |
+		 GT_PCI0_CFGADDR_CONFIGEN_BIT);
+
+	if (access_type == PCI_ACCESS_WRITE) {
+		if (busnum == 0 && PCI_SLOT(devfn) == 0) {
+			/*
+			 * The Galileo system controller is acting
+			 * differently than other devices.
+			 */
+			GT_WRITE(GT_PCI0_CFGDATA_OFS, *data);
+		} else
+			__GT_WRITE(GT_PCI0_CFGDATA_OFS, *data);
+	} else {
+		if (busnum == 0 && PCI_SLOT(devfn) == 0) {
+			/*
+			 * The Galileo system controller is acting
+			 * differently than other devices.
+			 */
+			*data = GT_READ(GT_PCI0_CFGDATA_OFS);
+		} else
+			*data = __GT_READ(GT_PCI0_CFGDATA_OFS);
+	}
+
+	/* Check for master or target abort */
+	intr = GT_READ(GT_INTRCAUSE_OFS);
+
+	if (intr & (GT_INTRCAUSE_MASABORT0_BIT | GT_INTRCAUSE_TARABORT0_BIT)) {
+		/* Error occurred */
+
+		/* Clear bits */
+		GT_WRITE(GT_INTRCAUSE_OFS, ~(GT_INTRCAUSE_MASABORT0_BIT |
+		                             GT_INTRCAUSE_TARABORT0_BIT));
+
+		return -1;
+	}
+
+	return 0;
+}
+
+
+/*
+ * We can't address 8 and 16 bit words directly.  Instead we have to
+ * read/write a 32bit word and mask/modify the data we actually want.
+ */
+static int gt64xxx_pci0_pcibios_read(struct pci_bus *bus, unsigned int devfn,
+		int where, int size, u32 * val)
+{
+	u32 data = 0;
+
+	if (gt64xxx_pci0_pcibios_config_access(PCI_ACCESS_READ, bus, devfn,
+	                                       where, &data))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (size == 1)
+		*val = (data >> ((where & 3) << 3)) & 0xff;
+	else if (size == 2)
+		*val = (data >> ((where & 3) << 3)) & 0xffff;
+	else
+		*val = data;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int gt64xxx_pci0_pcibios_write(struct pci_bus *bus, unsigned int devfn,
+		int where, int size, u32 val)
+{
+	u32 data = 0;
+
+	if (size == 4)
+		data = val;
+	else {
+		if (gt64xxx_pci0_pcibios_config_access(PCI_ACCESS_READ, bus,
+		                                       devfn, where, &data))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		if (size == 1)
+			data = (data & ~(0xff << ((where & 3) << 3))) |
+				(val << ((where & 3) << 3));
+		else if (size == 2)
+			data = (data & ~(0xffff << ((where & 3) << 3))) |
+				(val << ((where & 3) << 3));
+	}
+
+	if (gt64xxx_pci0_pcibios_config_access(PCI_ACCESS_WRITE, bus, devfn,
+	                                       where, &data))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+struct pci_ops gt64xxx_pci0_ops = {
+	.read	= gt64xxx_pci0_pcibios_read,
+	.write	= gt64xxx_pci0_pcibios_write
+};
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/pci-lasat.c mips/arch/mips/pci/pci-lasat.c
--- mips-orig/arch/mips/pci/pci-lasat.c	2007-03-14 09:08:11.046930250 +0900
+++ mips/arch/mips/pci/pci-lasat.c	2007-03-13 23:21:53.048740500 +0900
@@ -12,7 +12,7 @@
 #include <asm/bootinfo.h>
 
 extern struct pci_ops nile4_pci_ops;
-extern struct pci_ops gt64120_pci_ops;
+extern struct pci_ops gt64xxx_pci0_ops;
 static struct resource lasat_pci_mem_resource = {
 	.name	= "LASAT PCI MEM",
 	.start	= 0x18000000,
@@ -38,7 +38,7 @@ static int __init lasat_pci_setup(void)
 
 	switch (mips_machtype) {
 	case MACH_LASAT_100:
-                lasat_pci_controller.pci_ops = &gt64120_pci_ops;
+                lasat_pci_controller.pci_ops = &gt64xxx_pci0_ops;
                 break;
 	case MACH_LASAT_200:
                 lasat_pci_controller.pci_ops = &nile4_pci_ops;
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/pci-ocelot.c mips/arch/mips/pci/pci-ocelot.c
--- mips-orig/arch/mips/pci/pci-ocelot.c	2007-03-14 09:08:11.066931500 +0900
+++ mips/arch/mips/pci/pci-ocelot.c	2007-03-13 23:21:53.052740750 +0900
@@ -81,7 +81,7 @@ static struct resource ocelot_io_resourc
 };
 
 static struct pci_controller ocelot_pci_controller = {
-	.pci_ops	= gt64120_pci_ops;
+	.pci_ops	= gt64xxx_pci0_ops;
 	.mem_resource	= &ocelot_mem_resource;
 	.io_resource	= &ocelot_io_resource;
 };
