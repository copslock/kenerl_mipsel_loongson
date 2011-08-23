Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Aug 2011 10:11:07 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:4870 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491183Ab1HWIJU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Aug 2011 10:09:20 +0200
X-TM-IMSS-Message-ID: <5bb8ba2e0000ab7a@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 5bb8ba2e0000ab7a ; Tue, 23 Aug 2011 01:07:22 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 23 Aug 2011 01:02:51 -0700
Date:   Tue, 23 Aug 2011 13:36:10 +0530
From:   Ganesan Ramalingam <ganesanr@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 4/4] MIPS: Netlogic: Add basic MSI support for XLR/XLS
Message-ID: <c831d04c668b6d12d1481bdef328644bb32038f7.1314086142.git.jayachandranc@netlogicmicro.com>
References: <cover.1314086142.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1314086142.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 23 Aug 2011 08:02:51.0295 (UTC) FILETIME=[0E1B0AF0:01CC616B]
X-archive-position: 30953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ganesanr@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16623

Add basic support for MSI.

Signed-off-by: Ganesan Ramalingam <ganesanr@netlogicmicro.com>
Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/Kconfig                           |    1 +
 arch/mips/include/asm/netlogic/xlr/msidef.h |   84 +++++++++++++++++++++++++++
 arch/mips/netlogic/xlr/irq.c                |    5 ++
 arch/mips/pci/pci-xlr.c                     |   51 ++++++++++++++++-
 4 files changed, 140 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/include/asm/netlogic/xlr/msidef.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b122adc..2bb1c85 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -780,6 +780,7 @@ config NLM_XLR_BOARD
 	select CEVT_R4K
 	select CSRC_R4K
 	select IRQ_CPU
+	select ARCH_SUPPORTS_MSI
 	select ZONE_DMA if 64BIT
 	select SYNC_R4K
 	select SYS_HAS_EARLY_PRINTK
diff --git a/arch/mips/include/asm/netlogic/xlr/msidef.h b/arch/mips/include/asm/netlogic/xlr/msidef.h
new file mode 100644
index 0000000..7e39d40
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlr/msidef.h
@@ -0,0 +1,84 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
+ * license below:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef ASM_RMI_MSIDEF_H
+#define ASM_RMI_MSIDEF_H
+
+/*
+ * Constants for Intel APIC based MSI messages.
+ * Adapted for the RMI XLR using identical defines
+ */
+
+/*
+ * Shifts for MSI data
+ */
+
+#define MSI_DATA_VECTOR_SHIFT		0
+#define  MSI_DATA_VECTOR_MASK		0x000000ff
+#define	 MSI_DATA_VECTOR(v)		(((v) << MSI_DATA_VECTOR_SHIFT) & \
+						MSI_DATA_VECTOR_MASK)
+
+#define MSI_DATA_DELIVERY_MODE_SHIFT	8
+#define  MSI_DATA_DELIVERY_FIXED	(0 << MSI_DATA_DELIVERY_MODE_SHIFT)
+#define  MSI_DATA_DELIVERY_LOWPRI	(1 << MSI_DATA_DELIVERY_MODE_SHIFT)
+
+#define MSI_DATA_LEVEL_SHIFT		14
+#define	 MSI_DATA_LEVEL_DEASSERT	(0 << MSI_DATA_LEVEL_SHIFT)
+#define	 MSI_DATA_LEVEL_ASSERT		(1 << MSI_DATA_LEVEL_SHIFT)
+
+#define MSI_DATA_TRIGGER_SHIFT		15
+#define  MSI_DATA_TRIGGER_EDGE		(0 << MSI_DATA_TRIGGER_SHIFT)
+#define  MSI_DATA_TRIGGER_LEVEL		(1 << MSI_DATA_TRIGGER_SHIFT)
+
+/*
+ * Shift/mask fields for msi address
+ */
+
+#define MSI_ADDR_BASE_HI		0
+#define MSI_ADDR_BASE_LO		0xfee00000
+
+#define MSI_ADDR_DEST_MODE_SHIFT	2
+#define  MSI_ADDR_DEST_MODE_PHYSICAL	(0 << MSI_ADDR_DEST_MODE_SHIFT)
+#define	 MSI_ADDR_DEST_MODE_LOGICAL	(1 << MSI_ADDR_DEST_MODE_SHIFT)
+
+#define MSI_ADDR_REDIRECTION_SHIFT	3
+#define  MSI_ADDR_REDIRECTION_CPU	(0 << MSI_ADDR_REDIRECTION_SHIFT)
+#define  MSI_ADDR_REDIRECTION_LOWPRI	(1 << MSI_ADDR_REDIRECTION_SHIFT)
+
+#define MSI_ADDR_DEST_ID_SHIFT		12
+#define	 MSI_ADDR_DEST_ID_MASK		0x00ffff0
+#define  MSI_ADDR_DEST_ID(dest)		(((dest) << MSI_ADDR_DEST_ID_SHIFT) & \
+						 MSI_ADDR_DEST_ID_MASK)
+
+#endif /* ASM_RMI_MSIDEF_H */
diff --git a/arch/mips/netlogic/xlr/irq.c b/arch/mips/netlogic/xlr/irq.c
index 521bb73..fc822c8 100644
--- a/arch/mips/netlogic/xlr/irq.c
+++ b/arch/mips/netlogic/xlr/irq.c
@@ -38,9 +38,14 @@
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
+#include <linux/msi.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/pci.h>
 
 #include <asm/mipsregs.h>
 
+#include <asm/netlogic/xlr/msidef.h>
 #include <asm/netlogic/xlr/iomap.h>
 #include <asm/netlogic/xlr/pic.h>
 #include <asm/netlogic/xlr/xlr.h>
diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
index 38fece16..87404d0 100644
--- a/arch/mips/pci/pci-xlr.c
+++ b/arch/mips/pci/pci-xlr.c
@@ -36,12 +36,16 @@
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/msi.h>
 #include <linux/mm.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
 #include <linux/console.h>
 
 #include <asm/io.h>
 
 #include <asm/netlogic/interrupt.h>
+#include <asm/netlogic/xlr/msidef.h>
 #include <asm/netlogic/xlr/iomap.h>
 #include <asm/netlogic/xlr/pic.h>
 #include <asm/netlogic/xlr/xlr.h>
@@ -150,7 +154,7 @@ struct pci_controller nlm_pci_controller = {
 	.io_offset      = 0x00000000UL,
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+static int get_irq_vector(const struct pci_dev *dev)
 {
 	if (!nlm_chip_is_xls())
 		return	PIC_PCIX_IRQ;	/* for XLR just one IRQ*/
@@ -182,6 +186,51 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return 0;
 }
 
+#ifdef CONFIG_PCI_MSI
+void destroy_irq(unsigned int irq)
+{
+	    /* nothing to do yet */
+}
+
+void arch_teardown_msi_irq(unsigned int irq)
+{
+	destroy_irq(irq);
+}
+
+int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
+{
+	struct msi_msg msg;
+	int irq, ret;
+
+	irq = get_irq_vector(dev);
+	if (irq <= 0)
+		return 1;
+
+	msg.address_hi = MSI_ADDR_BASE_HI;
+	msg.address_lo = MSI_ADDR_BASE_LO   |
+		MSI_ADDR_DEST_MODE_PHYSICAL |
+		MSI_ADDR_REDIRECTION_CPU;
+
+	msg.data = MSI_DATA_TRIGGER_EDGE |
+		MSI_DATA_LEVEL_ASSERT    |
+		MSI_DATA_DELIVERY_FIXED;
+
+	ret = irq_set_msi_desc(irq, desc);
+	if (ret < 0) {
+		destroy_irq(irq);
+		return ret;
+	}
+
+	write_msi_msg(irq, &msg);
+	return 0;
+}
+#endif
+
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return get_irq_vector(dev);
+}
+
 /* Do platform specific device initialization at pci_enable_device() time */
 int pcibios_plat_dev_init(struct pci_dev *dev)
 {
-- 
1.7.4.1


-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
jchandra@freebsd.org                               (The FreeBSD Project)
