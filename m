Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2005 16:28:42 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:34533 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225298AbVCGQ2W>;
	Mon, 7 Mar 2005 16:28:22 +0000
Received: MO(mo01)id j27GSICl028734; Tue, 8 Mar 2005 01:28:18 +0900 (JST)
Received: MDO(mdo01) id j27GSHFH028992; Tue, 8 Mar 2005 01:28:18 +0900 (JST)
Received: 4UMRO01 id j27GSG8B007569; Tue, 8 Mar 2005 01:28:17 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date:	Tue, 8 Mar 2005 01:28:15 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] update PCI code for VR41xx
Message-Id: <20050308012815.0a02095e.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

This patch updates PCI code for VR41xx.
Please apply this patch to v2.6.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>


diff -urN -X dontdiff a-orig/arch/mips/pci/ops-vr41xx.c a/arch/mips/pci/ops-vr41xx.c
--- a-orig/arch/mips/pci/ops-vr41xx.c	Thu May 27 04:31:41 2004
+++ a/arch/mips/pci/ops-vr41xx.c	Mon Feb 21 01:06:15 2005
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2001-2003 MontaVista Software Inc.
  *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2004-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -29,8 +29,8 @@
 
 #include <asm/io.h>
 
-#define PCICONFDREG	KSEG1ADDR(0x0f000c14)
-#define PCICONFAREG	KSEG1ADDR(0x0f000c18)
+#define PCICONFDREG	(void __iomem *)KSEG1ADDR(0x0f000c14)
+#define PCICONFAREG	(void __iomem *)KSEG1ADDR(0x0f000c18)
 
 static inline int set_pci_configuration_address(unsigned char number,
                                                 unsigned int devfn, int where)
diff -urN -X dontdiff a-orig/arch/mips/pci/pci-vr41xx.c a/arch/mips/pci/pci-vr41xx.c
--- a-orig/arch/mips/pci/pci-vr41xx.c	Sun Jan 16 22:34:31 2005
+++ a/arch/mips/pci/pci-vr41xx.c	Mon Feb 21 01:06:15 2005
@@ -3,8 +3,8 @@
  *
  *  Copyright (C) 2001-2003 MontaVista Software Inc.
  *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
+ *  Copyright (C) 2004-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -31,12 +31,18 @@
 
 #include <asm/cpu.h>
 #include <asm/io.h>
+#include <asm/vr41xx/pci.h>
 #include <asm/vr41xx/vr41xx.h>
 
 #include "pci-vr41xx.h"
 
 extern struct pci_ops vr41xx_pci_ops;
 
+static void __iomem *pciu_base;
+
+#define pciu_read(offset)		readl(pciu_base + (offset))
+#define pciu_write(offset, value)	writel((value), pciu_base + (offset))
+
 static struct pci_master_address_conversion pci_master_memory1 = {
 	.bus_base_address	= PCI_MASTER_MEM1_BUS_BASE_ADDRESS,
 	.address_mask		= PCI_MASTER_MEM1_ADDRESS_MASK,
@@ -113,6 +119,13 @@
 
 	setup = &vr41xx_pci_controller_unit_setup;
 
+	if (request_mem_region(PCIU_BASE, PCIU_SIZE, "PCIU") == NULL)
+		return -EBUSY;
+
+	pciu_base = ioremap(PCIU_BASE, PCIU_SIZE);
+	if (pciu_base == NULL)
+		return -EBUSY;
+
 	/* Disable PCI interrupt */
 	vr41xx_disable_pciint();
 
@@ -129,14 +142,14 @@
 		pci_clock_max = PCI_CLOCK_MAX;
 	vtclock = vr41xx_get_vtclock_frequency();
 	if (vtclock < pci_clock_max)
-		writel(EQUAL_VTCLOCK, PCICLKSELREG);
+		pciu_write(PCICLKSELREG, EQUAL_VTCLOCK);
 	else if ((vtclock / 2) < pci_clock_max)
-		writel(HALF_VTCLOCK, PCICLKSELREG);
+		pciu_write(PCICLKSELREG, HALF_VTCLOCK);
 	else if (current_cpu_data.processor_id >= PRID_VR4131_REV2_1 &&
 	         (vtclock / 3) < pci_clock_max)
-		writel(ONE_THIRD_VTCLOCK, PCICLKSELREG);
+		pciu_write(PCICLKSELREG, ONE_THIRD_VTCLOCK);
 	else if ((vtclock / 4) < pci_clock_max)
-		writel(QUARTER_VTCLOCK, PCICLKSELREG);
+		pciu_write(PCICLKSELREG, QUARTER_VTCLOCK);
 	else {
 		printk(KERN_ERR "PCI Clock is over 33MHz.\n");
 		return -EINVAL;
@@ -151,11 +164,11 @@
 		      MASTER_MSK(master->address_mask) |
 		      WINEN |
 		      PCIA(master->pci_base_address);
-		writel(val, PCIMMAW1REG);
+		pciu_write(PCIMMAW1REG, val);
 	} else {
-		val = readl(PCIMMAW1REG);
+		val = pciu_read(PCIMMAW1REG);
 		val &= ~WINEN;
-		writel(val, PCIMMAW1REG);
+		pciu_write(PCIMMAW1REG, val);
 	}
 
 	if (setup->master_memory2 != NULL) {
@@ -164,11 +177,11 @@
 		      MASTER_MSK(master->address_mask) |
 		      WINEN |
 		      PCIA(master->pci_base_address);
-		writel(val, PCIMMAW2REG);
+		pciu_write(PCIMMAW2REG, val);
 	} else {
-		val = readl(PCIMMAW2REG);
+		val = pciu_read(PCIMMAW2REG);
 		val &= ~WINEN;
-		writel(val, PCIMMAW2REG);
+		pciu_write(PCIMMAW2REG, val);
 	}
 
 	if (setup->target_memory1 != NULL) {
@@ -176,11 +189,11 @@
 		val = TARGET_MSK(target->address_mask) |
 		      WINEN |
 		      ITA(target->bus_base_address);
-		writel(val, PCITAW1REG);
+		pciu_write(PCITAW1REG, val);
 	} else {
-		val = readl(PCITAW1REG);
+		val = pciu_read(PCITAW1REG);
 		val &= ~WINEN;
-		writel(val, PCITAW1REG);
+		pciu_write(PCITAW1REG, val);
 	}
 
 	if (setup->target_memory2 != NULL) {
@@ -188,11 +201,11 @@
 		val = TARGET_MSK(target->address_mask) |
 		      WINEN |
 		      ITA(target->bus_base_address);
-		writel(val, PCITAW2REG);
+		pciu_write(PCITAW2REG, val);
 	} else {
-		val = readl(PCITAW2REG);
+		val = pciu_read(PCITAW2REG);
 		val &= ~WINEN;
-		writel(val, PCITAW2REG);
+		pciu_write(PCITAW2REG, val);
 	}
 
 	if (setup->master_io != NULL) {
@@ -201,50 +214,50 @@
 		      MASTER_MSK(master->address_mask) |
 		      WINEN |
 		      PCIIA(master->pci_base_address);
-		writel(val, PCIMIOAWREG);
+		pciu_write(PCIMIOAWREG, val);
 	} else {
-		val = readl(PCIMIOAWREG);
+		val = pciu_read(PCIMIOAWREG);
 		val &= ~WINEN;
-		writel(val, PCIMIOAWREG);
+		pciu_write(PCIMIOAWREG, val);
 	}
 
 	if (setup->exclusive_access == CANNOT_LOCK_FROM_DEVICE)
-		writel(UNLOCK, PCIEXACCREG);
+		pciu_write(PCIEXACCREG, UNLOCK);
 	else
-		writel(0, PCIEXACCREG);
+		pciu_write(PCIEXACCREG, 0);
 
 	if (current_cpu_data.cputype == CPU_VR4122)
-		writel(TRDYV(setup->wait_time_limit_from_irdy_to_trdy), PCITRDYVREG);
+		pciu_write(PCITRDYVREG, TRDYV(setup->wait_time_limit_from_irdy_to_trdy));
 
-	writel(MLTIM(setup->master_latency_timer), LATTIMEREG);
+	pciu_write(LATTIMEREG, MLTIM(setup->master_latency_timer));
 
 	if (setup->mailbox != NULL) {
 		mailbox = setup->mailbox;
 		val = MBADD(mailbox->base_address) | TYPE_32BITSPACE |
 		      MSI_MEMORY | PREF_APPROVAL;
-		writel(val, MAILBAREG);
+		pciu_write(MAILBAREG, val);
 	}
 
 	if (setup->target_window1) {
 		window = setup->target_window1;
 		val = PMBA(window->base_address) | TYPE_32BITSPACE |
 		      MSI_MEMORY | PREF_APPROVAL;
-		writel(val, PCIMBA1REG);
+		pciu_write(PCIMBA1REG, val);
 	}
 
 	if (setup->target_window2) {
 		window = setup->target_window2;
 		val = PMBA(window->base_address) | TYPE_32BITSPACE |
 		      MSI_MEMORY | PREF_APPROVAL;
-		writel(val, PCIMBA2REG);
+		pciu_write(PCIMBA2REG, val);
 	}
 
-	val = readl(RETVALREG);
+	val = pciu_read(RETVALREG);
 	val &= ~RTYVAL_MASK;
 	val |= RTYVAL(setup->retry_limit);
-	writel(val, RETVALREG);
+	pciu_write(RETVALREG, val);
 
-	val = readl(PCIAPCNTREG);
+	val = pciu_read(PCIAPCNTREG);
 	val &= ~(TKYGNT | PAPC);
 
 	switch (setup->arbiter_priority_control) {
@@ -262,15 +275,16 @@
 	if (setup->take_away_gnt_mode == PCI_TAKE_AWAY_GNT_ENABLE)
 		val |= TKYGNT_ENABLE;
 
-	writel(val, PCIAPCNTREG);
+	pciu_write(PCIAPCNTREG, val);
 
-	writel(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
-	       PCI_COMMAND_PARITY | PCI_COMMAND_SERR, COMMANDREG);
+	pciu_write(COMMANDREG, PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
+	                       PCI_COMMAND_MASTER | PCI_COMMAND_PARITY |
+			       PCI_COMMAND_SERR);
 
 	/* Clear bus error */
-	readl(BUSERRADREG);
+	pciu_read(BUSERRADREG);
 
-	writel(BLOODY_CONFIG_DONE, PCIENREG);
+	pciu_write(PCIENREG, PCIU_CONFIG_DONE);
 
 	if (setup->mem_resource != NULL)
 		vr41xx_pci_controller.mem_resource = setup->mem_resource;
@@ -288,4 +302,4 @@
 	return 0;
 }
 
-early_initcall(vr41xx_pciu_init);
+arch_initcall(vr41xx_pciu_init);
diff -urN -X dontdiff a-orig/arch/mips/pci/pci-vr41xx.h a/arch/mips/pci/pci-vr41xx.h
--- a-orig/arch/mips/pci/pci-vr41xx.h	Sun Jan 16 22:34:31 2005
+++ a/arch/mips/pci/pci-vr41xx.h	Mon Feb 21 01:06:15 2005
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2002  MontaVista Software Inc.
  *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2004-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -22,11 +22,14 @@
 #ifndef __PCI_VR41XX_H
 #define __PCI_VR41XX_H
 
-#define PCIMMAW1REG		KSEG1ADDR(0x0f000c00)
-#define PCIMMAW2REG		KSEG1ADDR(0x0f000c04)
-#define PCITAW1REG		KSEG1ADDR(0x0f000c08)
-#define PCITAW2REG		KSEG1ADDR(0x0f000c0c)
-#define PCIMIOAWREG		KSEG1ADDR(0x0f000c10)
+#define PCIU_BASE		0x0f000c00UL
+#define PCIU_SIZE		0x200UL
+
+#define PCIMMAW1REG		0x00
+#define PCIMMAW2REG		0x04
+#define PCITAW1REG		0x08
+#define PCITAW2REG		0x0c
+#define PCIMIOAWREG		0x10
  #define IBA(addr)		((addr) & 0xff000000U)
  #define MASTER_MSK(mask)	(((mask) >> 11) & 0x000fe000U)
  #define PCIA(addr)		(((addr) >> 24) & 0x000000ffU)
@@ -34,13 +37,13 @@
  #define ITA(addr)		(((addr) >> 24) & 0x000000ffU)
  #define PCIIA(addr)		(((addr) >> 24) & 0x000000ffU)
  #define WINEN			0x1000U
-#define PCICONFDREG		KSEG1ADDR(0x0f000c14)
-#define PCICONFAREG		KSEG1ADDR(0x0f000c18)
-#define PCIMAILREG		KSEG1ADDR(0x0f000c1c)
-#define BUSERRADREG		KSEG1ADDR(0x0f000c24)
+#define PCICONFDREG		0x14
+#define PCICONFAREG		0x18
+#define PCIMAILREG		0x1c
+#define BUSERRADREG		0x24
  #define EA(reg)		((reg) &0xfffffffc)
 
-#define INTCNTSTAREG		KSEG1ADDR(0x0f000c28)
+#define INTCNTSTAREG		0x28
  #define MABTCLR		0x80000000U
  #define TRDYCLR		0x40000000U
  #define PARCLR			0x20000000U
@@ -67,34 +70,34 @@
  #define MABORT			0x00000002U
  #define TABORT			0x00000001U
 
-#define PCIEXACCREG		KSEG1ADDR(0x0f000c2c)
+#define PCIEXACCREG		0x2c
  #define UNLOCK			0x2U
  #define EAREQ			0x1U
-#define PCIRECONTREG		KSEG1ADDR(0x0f000c30)
+#define PCIRECONTREG		0x30
  #define RTRYCNT(reg)		((reg) & 0x000000ffU)
-#define PCIENREG		KSEG1ADDR(0x0f000c34)
- #define BLOODY_CONFIG_DONE	0x4U
-#define PCICLKSELREG		KSEG1ADDR(0x0f000c38)
+#define PCIENREG		0x34
+ #define PCIU_CONFIG_DONE	0x4U
+#define PCICLKSELREG		0x38
  #define EQUAL_VTCLOCK		0x2U
  #define HALF_VTCLOCK		0x0U
  #define ONE_THIRD_VTCLOCK	0x3U
  #define QUARTER_VTCLOCK	0x1U
-#define PCITRDYVREG		KSEG1ADDR(0x0f000c3c)
+#define PCITRDYVREG		0x3c
  #define TRDYV(val)		((uint32_t)(val) & 0xffU)
-#define PCICLKRUNREG		KSEG1ADDR(0x0f000c60)
+#define PCICLKRUNREG		0x60
 
-#define VENDORIDREG		KSEG1ADDR(0x0f000d00)
-#define DEVICEIDREG		KSEG1ADDR(0x0f000d00)
-#define COMMANDREG		KSEG1ADDR(0x0f000d04)
-#define STATUSREG		KSEG1ADDR(0x0f000d04)
-#define REVIDREG		KSEG1ADDR(0x0f000d08)
-#define CLASSREG		KSEG1ADDR(0x0f000d08)
-#define CACHELSREG		KSEG1ADDR(0x0f000d0c)
-#define LATTIMEREG		KSEG1ADDR(0x0f000d0c)
+#define VENDORIDREG		0x100
+#define DEVICEIDREG		0x100
+#define COMMANDREG		0x104
+#define STATUSREG		0x104
+#define REVIDREG		0x108
+#define CLASSREG		0x108
+#define CACHELSREG		0x10c
+#define LATTIMEREG		0x10c
  #define MLTIM(val)		(((uint32_t)(val) << 7) & 0xff00U)
-#define MAILBAREG		KSEG1ADDR(0x0f000d10)
-#define PCIMBA1REG		KSEG1ADDR(0x0f000d14)
-#define PCIMBA2REG		KSEG1ADDR(0x0f000d18)
+#define MAILBAREG		0x110
+#define PCIMBA1REG		0x114
+#define PCIMBA2REG		0x118
  #define MBADD(base)		((base) & 0xfffff800U)
  #define PMBA(base)		((base) & 0xffe00000U)
  #define PREF			0x8U
@@ -104,10 +107,10 @@
  #define TYPE_32BITSPACE	0x0U
  #define MSI			0x1U
  #define MSI_MEMORY		0x0U
-#define INTLINEREG		KSEG1ADDR(0x0f000d3c)
-#define INTPINREG		KSEG1ADDR(0x0f000d3c)
-#define RETVALREG		KSEG1ADDR(0x0f000d40)
-#define PCIAPCNTREG		KSEG1ADDR(0x0f000d40)
+#define INTLINEREG		0x13c
+#define INTPINREG		0x13c
+#define RETVALREG		0x140
+#define PCIAPCNTREG		0x140
  #define TKYGNT			0x04000000U
  #define TKYGNT_ENABLE		0x04000000U
  #define TKYGNT_DISABLE		0x00000000U
diff -urN -X dontdiff a-orig/include/asm-mips/vr41xx/pci.h a/include/asm-mips/vr41xx/pci.h
--- a-orig/include/asm-mips/vr41xx/pci.h	Thu Jan  1 09:00:00 1970
+++ a/include/asm-mips/vr41xx/pci.h	Mon Feb 21 01:06:15 2005
@@ -0,0 +1,90 @@
+/*
+ *  Include file for NEC VR4100 series PCI Control Unit.
+ *
+ *  Copyright (C) 2004-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __NEC_VR41XX_PCI_H
+#define __NEC_VR41XX_PCI_H
+
+#define PCI_MASTER_ADDRESS_MASK	0x7fffffffU
+
+struct pci_master_address_conversion {
+	uint32_t bus_base_address;
+	uint32_t address_mask;
+	uint32_t pci_base_address;
+};
+
+struct pci_target_address_conversion {
+	uint32_t address_mask;
+	uint32_t bus_base_address;
+};
+
+typedef enum {
+	CANNOT_LOCK_FROM_DEVICE,
+	CAN_LOCK_FROM_DEVICE,
+} pci_exclusive_access_t;
+
+struct pci_mailbox_address {
+	uint32_t base_address;
+};
+
+struct pci_target_address_window {
+	uint32_t base_address;
+};
+
+typedef enum {
+	PCI_ARBITRATION_MODE_FAIR,
+	PCI_ARBITRATION_MODE_ALTERNATE_0,
+	PCI_ARBITRATION_MODE_ALTERNATE_B,
+} pci_arbiter_priority_control_t;
+
+typedef enum {
+	PCI_TAKE_AWAY_GNT_DISABLE,
+	PCI_TAKE_AWAY_GNT_ENABLE,
+} pci_take_away_gnt_mode_t;
+
+struct pci_controller_unit_setup {
+	struct pci_master_address_conversion *master_memory1;
+	struct pci_master_address_conversion *master_memory2;
+
+	struct pci_target_address_conversion *target_memory1;
+	struct pci_target_address_conversion *target_memory2;
+
+	struct pci_master_address_conversion *master_io;
+
+	pci_exclusive_access_t exclusive_access;
+
+	uint32_t pci_clock_max;
+	uint8_t wait_time_limit_from_irdy_to_trdy;	/* Only VR4122 is supported */
+
+	struct pci_mailbox_address *mailbox;
+	struct pci_target_address_window *target_window1;
+	struct pci_target_address_window *target_window2;
+
+	uint8_t master_latency_timer;
+	uint8_t retry_limit;
+
+	pci_arbiter_priority_control_t arbiter_priority_control;
+	pci_take_away_gnt_mode_t take_away_gnt_mode;
+
+	struct resource *mem_resource;
+	struct resource *io_resource;
+};
+
+extern void vr41xx_pciu_setup(struct pci_controller_unit_setup *setup);
+
+#endif /* __NEC_VR41XX_PCI_H */
diff -urN -X dontdiff a-orig/include/asm-mips/vr41xx/vr41xx.h a/include/asm-mips/vr41xx/vr41xx.h
--- a-orig/include/asm-mips/vr41xx/vr41xx.h	Thu May 27 08:14:44 2004
+++ a/include/asm-mips/vr41xx/vr41xx.h	Mon Feb 21 01:06:15 2005
@@ -274,74 +274,4 @@
  */
 extern void vr41xx_dsiu_init(void);
 
-/*
- * PCI Control Unit
- */
-#define PCI_MASTER_ADDRESS_MASK	0x7fffffffU
-
-struct pci_master_address_conversion {
-	uint32_t bus_base_address;
-	uint32_t address_mask;
-	uint32_t pci_base_address;
-};
-
-struct pci_target_address_conversion {
-	uint32_t address_mask;
-	uint32_t bus_base_address;
-};
-
-typedef enum {
-	CANNOT_LOCK_FROM_DEVICE,
-	CAN_LOCK_FROM_DEVICE,
-} pci_exclusive_access_t;
-
-struct pci_mailbox_address {
-	uint32_t base_address;
-};
-
-struct pci_target_address_window {
-	uint32_t base_address;
-};
-
-typedef enum {
-	PCI_ARBITRATION_MODE_FAIR,
-	PCI_ARBITRATION_MODE_ALTERNATE_0,
-	PCI_ARBITRATION_MODE_ALTERNATE_B,
-} pci_arbiter_priority_control_t;
-
-typedef enum {
-	PCI_TAKE_AWAY_GNT_DISABLE,
-	PCI_TAKE_AWAY_GNT_ENABLE,
-} pci_take_away_gnt_mode_t;
-
-struct pci_controller_unit_setup {
-	struct pci_master_address_conversion *master_memory1;
-	struct pci_master_address_conversion *master_memory2;
-
-	struct pci_target_address_conversion *target_memory1;
-	struct pci_target_address_conversion *target_memory2;
-
-	struct pci_master_address_conversion *master_io;
-
-	pci_exclusive_access_t exclusive_access;
-
-	uint32_t pci_clock_max;
-	uint8_t wait_time_limit_from_irdy_to_trdy;	/* Only VR4122 is supported */
-
-	struct pci_mailbox_address *mailbox;
-	struct pci_target_address_window *target_window1;
-	struct pci_target_address_window *target_window2;
-
-	uint8_t master_latency_timer;
-	uint8_t retry_limit;
-
-	pci_arbiter_priority_control_t arbiter_priority_control;
-	pci_take_away_gnt_mode_t take_away_gnt_mode;
-
-	struct resource *mem_resource;
-	struct resource *io_resource;
-};
-
-extern void vr41xx_pciu_setup(struct pci_controller_unit_setup *setup);
-
 #endif /* __NEC_VR41XX_H */
