Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2013 15:18:37 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1202 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816841Ab3JNNPsrJiME (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Oct 2013 15:15:48 +0200
Received: from [10.9.208.55] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Oct 2013 06:15:12 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 14 Oct 2013 06:15:13 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 14 Oct 2013 06:15:13 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id D344B246DA; Mon, 14
 Oct 2013 06:15:09 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>, ralf@linux-mips.org
Subject: [PATCH 01/18] MIPS: Netlogic: Add MSI support for XLP
Date:   Mon, 14 Oct 2013 18:50:57 +0530
Message-ID: <1381756874-22616-2-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1381756874-22616-1-git-send-email-jchandra@broadcom.com>
References: <1381756874-22616-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E4531EA4FK1415122-02-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Add MSI chip and MSIX chip definitions.

For MSI, we map the link interrupt to a MSI link IRQ which will
do a second level of dispatch based on the MSI status register.

The MSI chip definitions use the MSI enable register to enable
and disable the MSI irqs.

For MSI-X, we split the 32 available MSI-X vectors across the
four PCIe links (8 each). These PIC interrupts generate an IRQ
per link which uses a second level dispatch as well.

The MSI-X chip definition uses the standard functions to enable
and disable interrupts.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/Kconfig                               |    1 +
 arch/mips/include/asm/mach-netlogic/irq.h       |    3 +-
 arch/mips/include/asm/netlogic/common.h         |    6 +
 arch/mips/include/asm/netlogic/xlp-hal/pcibus.h |   33 +-
 arch/mips/include/asm/netlogic/xlp-hal/pic.h    |    5 -
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h    |   24 +-
 arch/mips/netlogic/common/irq.c                 |   29 +-
 arch/mips/netlogic/xlp/nlm_hal.c                |   12 +-
 arch/mips/pci/Makefile                          |    1 +
 arch/mips/pci/msi-xlp.c                         |  493 +++++++++++++++++++++++
 arch/mips/pci/pci-xlp.c                         |   15 +-
 11 files changed, 585 insertions(+), 37 deletions(-)
 create mode 100644 arch/mips/pci/msi-xlp.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ca24bc5..b734a68 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -790,6 +790,7 @@ config NLM_XLP_BOARD
 	select CEVT_R4K
 	select CSRC_R4K
 	select IRQ_CPU
+	select ARCH_SUPPORTS_MSI
 	select ZONE_DMA32 if 64BIT
 	select SYNC_R4K
 	select SYS_HAS_EARLY_PRINTK
diff --git a/arch/mips/include/asm/mach-netlogic/irq.h b/arch/mips/include/asm/mach-netlogic/irq.h
index 868ed8a..c0dbd53 100644
--- a/arch/mips/include/asm/mach-netlogic/irq.h
+++ b/arch/mips/include/asm/mach-netlogic/irq.h
@@ -9,7 +9,8 @@
 #define __ASM_NETLOGIC_IRQ_H
 
 #include <asm/mach-netlogic/multi-node.h>
-#define NR_IRQS			(64 * NLM_NR_NODES)
+#define NLM_IRQS_PER_NODE	1024
+#define NR_IRQS			(NLM_IRQS_PER_NODE * NLM_NR_NODES)
 
 #define MIPS_CPU_IRQ_BASE	0
 
diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index bb68c33..e6339d0 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -112,8 +112,14 @@ struct nlm_soc_info {
 
 struct irq_data;
 uint64_t nlm_pci_irqmask(int node);
+void nlm_setup_pic_irq(int node, int picirq, int irq, int irt);
 void nlm_set_pic_extra_ack(int node, int irq,  void (*xack)(struct irq_data *));
 
+#ifdef CONFIG_PCI_MSI
+void nlm_dispatch_msi(int node, int lirq);
+void nlm_dispatch_msix(int node, int msixirq);
+#endif
+
 /*
  * The NR_IRQs is divided between nodes, each of them has a separate irq space
  */
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pcibus.h b/arch/mips/include/asm/netlogic/xlp-hal/pcibus.h
index b559cb9..0fac32b 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/pcibus.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pcibus.h
@@ -52,25 +52,42 @@
 #define PCIE_BYTE_SWAP_MEM_LIM		0x248
 #define PCIE_BYTE_SWAP_IO_BASE		0x249
 #define PCIE_BYTE_SWAP_IO_LIM		0x24A
+
+#define PCIE_BRIDGE_MSIX_ADDR_BASE	0x24F
+#define PCIE_BRIDGE_MSIX_ADDR_LIMIT	0x250
 #define PCIE_MSI_STATUS			0x25A
 #define PCIE_MSI_EN			0x25B
+#define PCIE_MSIX_STATUS		0x25D
+#define PCIE_INT_STATUS0		0x25F
+#define PCIE_INT_STATUS1		0x260
 #define PCIE_INT_EN0			0x261
+#define PCIE_INT_EN1			0x262
 
-/* PCIE_MSI_EN */
-#define PCIE_MSI_VECTOR_INT_EN		0xFFFFFFFF
-
-/* PCIE_INT_EN0 */
-#define PCIE_MSI_INT_EN			(1 << 9)
+/* other */
+#define PCIE_NLINKS			4
 
+/* MSI addresses */
+#define MSI_ADDR_BASE			0xfffee00000ULL
+#define MSI_ADDR_SZ			0x10000
+#define MSI_LINK_ADDR(n, l)		(MSI_ADDR_BASE + \
+				(PCIE_NLINKS * (n) + (l)) * MSI_ADDR_SZ)
+#define MSIX_ADDR_BASE			0xfffef00000ULL
+#define MSIX_LINK_ADDR(n, l)		(MSIX_ADDR_BASE + \
+				(PCIE_NLINKS * (n) + (l)) * MSI_ADDR_SZ)
 #ifndef __ASSEMBLY__
 
 #define nlm_read_pcie_reg(b, r)		nlm_read_reg(b, r)
 #define nlm_write_pcie_reg(b, r, v)	nlm_write_reg(b, r, v)
 #define nlm_get_pcie_base(node, inst)	\
 			nlm_pcicfg_base(XLP_IO_PCIE_OFFSET(node, inst))
-#define nlm_get_pcie_regbase(node, inst)	\
-			(nlm_get_pcie_base(node, inst) + XLP_IO_PCI_HDRSZ)
 
-int xlp_pcie_link_irt(int link);
+#ifdef CONFIG_PCI_MSI
+void xlp_init_node_msi_irqs(int node, int link);
+#else
+static inline void xlp_init_node_msi_irqs(int node, int link) {}
+#endif
+
+struct pci_dev *xlp_get_pcie_link(const struct pci_dev *dev);
+
 #endif
 #endif /* __NLM_HAL_PCIBUS_H__ */
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pic.h b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
index 105389b..3fcbe74 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/pic.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
@@ -193,14 +193,9 @@
 #define PIC_IRT_PCIE_LINK_INDEX(num)	((num) + PIC_IRT_PCIE_LINK_0_INDEX)
 
 #define PIC_CLOCK_TIMER			7
-#define PIC_IRQ_BASE			8
 
 #if !defined(LOCORE) && !defined(__ASSEMBLY__)
 
-#define PIC_IRT_FIRST_IRQ		(PIC_IRQ_BASE)
-#define PIC_IRT_LAST_IRQ		63
-#define PIC_IRQ_IS_IRT(irq)		((irq) >= PIC_IRT_FIRST_IRQ)
-
 /*
  *   Misc
  */
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index 17daffb2..3ab1290 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -37,10 +37,9 @@
 
 #define PIC_UART_0_IRQ			17
 #define PIC_UART_1_IRQ			18
-#define PIC_PCIE_LINK_0_IRQ		19
-#define PIC_PCIE_LINK_1_IRQ		20
-#define PIC_PCIE_LINK_2_IRQ		21
-#define PIC_PCIE_LINK_3_IRQ		22
+
+#define PIC_PCIE_LINK_LEGACY_IRQ_BASE	19
+#define PIC_PCIE_LINK_LEGACY_IRQ(i)	(19 + (i))
 
 #define PIC_EHCI_0_IRQ			23
 #define PIC_EHCI_1_IRQ			24
@@ -58,6 +57,23 @@
 #define PIC_I2C_2_IRQ			32
 #define PIC_I2C_3_IRQ			33
 
+#define PIC_PCIE_LINK_MSI_IRQ_BASE	44	/* 44 - 47 MSI IRQ */
+#define PIC_PCIE_LINK_MSI_IRQ(i)	(44 + (i))
+
+/* MSI-X with second link-level dispatch */
+#define PIC_PCIE_MSIX_IRQ_BASE		48	/* 48 - 51 MSI-X IRQ */
+#define PIC_PCIE_MSIX_IRQ(i)		(48 + (i))
+
+#define NLM_MSIX_VEC_BASE		96	/* 96 - 127 - MSIX mapped */
+#define NLM_MSI_VEC_BASE		128	/* 128 -255 - MSI mapped */
+
+#define NLM_PIC_INDIRECT_VEC_BASE	512
+#define NLM_GPIO_VEC_BASE		768
+
+#define PIC_IRQ_BASE			8
+#define PIC_IRT_FIRST_IRQ		PIC_IRQ_BASE
+#define PIC_IRT_LAST_IRQ		63
+
 #ifndef __ASSEMBLY__
 
 /* SMP support functions */
diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index 1c7e3a1..3800bf6 100644
--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -180,6 +180,7 @@ static void __init nlm_init_percpu_irqs(void)
 #endif
 }
 
+
 void nlm_setup_pic_irq(int node, int picirq, int irq, int irt)
 {
 	struct nlm_pic_irq *pic_data;
@@ -207,24 +208,24 @@ void nlm_set_pic_extra_ack(int node, int irq, void (*xack)(struct irq_data *))
 
 static void nlm_init_node_irqs(int node)
 {
-	int i, irt;
-	uint64_t irqmask;
 	struct nlm_soc_info *nodep;
+	int i, irt;
 
 	pr_info("Init IRQ for node %d\n", node);
 	nodep = nlm_get_node(node);
-	irqmask = PERCPU_IRQ_MASK;
+	nodep->irqmask = PERCPU_IRQ_MASK;
 	for (i = PIC_IRT_FIRST_IRQ; i <= PIC_IRT_LAST_IRQ; i++) {
 		irt = nlm_irq_to_irt(i);
-		if (irt == -1)
+		if (irt == -1)		/* unused irq */
 			continue;
-		nlm_setup_pic_irq(node, i, i, irt);
-		/* set interrupts to first cpu in node */
+		nodep->irqmask |= 1ull << i;
+		if (irt == -2)		/* not a direct PIC irq */
+			continue;
+
 		nlm_pic_init_irt(nodep->picbase, irt, i,
 					node * NLM_CPUS_PER_NODE, 0);
-		irqmask |= (1ull << i);
+		nlm_setup_pic_irq(node, i, i, irt);
 	}
-	nodep->irqmask = irqmask;
 }
 
 void nlm_smp_irq_init(int hwcpuid)
@@ -256,6 +257,18 @@ asmlinkage void plat_irq_dispatch(void)
 		return;
 	}
 
+#if defined(CONFIG_PCI_MSI) && defined(CONFIG_CPU_XLP)
+	/* PCI interrupts need a second level dispatch for MSI bits */
+	if (i >= PIC_PCIE_LINK_MSI_IRQ(0) && i <= PIC_PCIE_LINK_MSI_IRQ(3)) {
+		nlm_dispatch_msi(node, i);
+		return;
+	}
+	if (i >= PIC_PCIE_MSIX_IRQ(0) && i <= PIC_PCIE_MSIX_IRQ(3)) {
+		nlm_dispatch_msix(node, i);
+		return;
+	}
+
+#endif
 	/* top level irq handling */
 	do_IRQ(nlm_irq_to_xirq(node, i));
 }
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 56c50ba..5693021 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -135,9 +135,17 @@ int nlm_irq_to_irt(int irq)
 		case PIC_I2C_3_IRQ:
 			irt = irt + 3; break;
 		}
-	} else if (irq >= PIC_PCIE_LINK_0_IRQ && irq <= PIC_PCIE_LINK_3_IRQ) {
+	} else if (irq >= PIC_PCIE_LINK_LEGACY_IRQ(0) &&
+			irq <= PIC_PCIE_LINK_LEGACY_IRQ(3)) {
 		/* HW bug, PCI IRT entries are bad on early silicon, fix */
-		irt = PIC_IRT_PCIE_LINK_INDEX(irq - PIC_PCIE_LINK_0_IRQ);
+		irt = PIC_IRT_PCIE_LINK_INDEX(irq -
+					PIC_PCIE_LINK_LEGACY_IRQ_BASE);
+	} else if (irq >= PIC_PCIE_LINK_MSI_IRQ(0) &&
+			irq <= PIC_PCIE_LINK_MSI_IRQ(3)) {
+		irt = -2;
+	} else if (irq >= PIC_PCIE_MSIX_IRQ(0) &&
+			irq <= PIC_PCIE_MSIX_IRQ(3)) {
+		irt = -2;
 	} else {
 		irt = -1;
 	}
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 719e455..137f2a6 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -60,4 +60,5 @@ obj-$(CONFIG_CPU_XLP)		+= pci-xlp.o
 
 ifdef CONFIG_PCI_MSI
 obj-$(CONFIG_CAVIUM_OCTEON_SOC) += msi-octeon.o
+obj-$(CONFIG_CPU_XLP)		+= msi-xlp.o
 endif
diff --git a/arch/mips/pci/msi-xlp.c b/arch/mips/pci/msi-xlp.c
new file mode 100644
index 0000000..9daa977
--- /dev/null
+++ b/arch/mips/pci/msi-xlp.c
@@ -0,0 +1,493 @@
+/*
+ * Copyright (c) 2003-2012 Broadcom Corporation
+ * All Rights Reserved
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the Broadcom
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
+ * THIS SOFTWARE IS PROVIDED BY BROADCOM ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL BROADCOM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/msi.h>
+#include <linux/mm.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/console.h>
+
+#include <asm/io.h>
+
+#include <asm/netlogic/interrupt.h>
+#include <asm/netlogic/haldefs.h>
+#include <asm/netlogic/common.h>
+#include <asm/netlogic/mips-extns.h>
+
+#include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/pic.h>
+#include <asm/netlogic/xlp-hal/pcibus.h>
+#include <asm/netlogic/xlp-hal/bridge.h>
+
+#define XLP_MSIVEC_PER_LINK	32
+#define XLP_MSIXVEC_TOTAL	32
+#define XLP_MSIXVEC_PER_LINK	8
+
+/* 128 MSI irqs per node, mapped starting at NLM_MSI_VEC_BASE */
+static inline int nlm_link_msiirq(int link, int msivec)
+{
+	return NLM_MSI_VEC_BASE + link * XLP_MSIVEC_PER_LINK + msivec;
+}
+
+static inline int nlm_irq_msivec(int irq)
+{
+	return irq % XLP_MSIVEC_PER_LINK;
+}
+
+static inline int nlm_irq_msilink(int irq)
+{
+	return (irq % (XLP_MSIVEC_PER_LINK * PCIE_NLINKS)) /
+						XLP_MSIVEC_PER_LINK;
+}
+
+/*
+ * Only 32 MSI-X vectors are possible because there are only 32 PIC
+ * interrupts for MSI. We split them statically and use 8 MSI-X vectors
+ * per link - this keeps the allocation and lookup simple.
+ */
+static inline int nlm_link_msixirq(int link, int bit)
+{
+	return NLM_MSIX_VEC_BASE + link * XLP_MSIXVEC_PER_LINK + bit;
+}
+
+static inline int nlm_irq_msixvec(int irq)
+{
+	return irq % XLP_MSIXVEC_TOTAL;  /* works when given xirq */
+}
+
+static inline int nlm_irq_msixlink(int irq)
+{
+	return nlm_irq_msixvec(irq) / XLP_MSIXVEC_PER_LINK;
+}
+
+/*
+ * Per link MSI and MSI-X information, set as IRQ handler data for
+ * MSI and MSI-X interrupts.
+ */
+struct xlp_msi_data {
+	struct nlm_soc_info *node;
+	uint64_t	lnkbase;
+	uint32_t	msi_enabled_mask;
+	uint32_t	msi_alloc_mask;
+	uint32_t	msix_alloc_mask;
+	spinlock_t	msi_lock;
+};
+
+/*
+ * MSI Chip definitions
+ *
+ * On XLP, there is a PIC interrupt associated with each PCIe link on the
+ * chip (which appears as a PCI bridge to us). This gives us 32 MSI irqa
+ * per link and 128 overall.
+ *
+ * When a device connected to the link raises a MSI interrupt, we get a
+ * link interrupt and we then have to look at PCIE_MSI_STATUS register at
+ * the bridge to map it to the IRQ
+ */
+static void xlp_msi_enable(struct irq_data *d)
+{
+	struct xlp_msi_data *md = irq_data_get_irq_handler_data(d);
+	unsigned long flags;
+	int vec;
+
+	vec = nlm_irq_msivec(d->irq);
+	spin_lock_irqsave(&md->msi_lock, flags);
+	md->msi_enabled_mask |= 1u << vec;
+	nlm_write_reg(md->lnkbase, PCIE_MSI_EN, md->msi_enabled_mask);
+	spin_unlock_irqrestore(&md->msi_lock, flags);
+}
+
+static void xlp_msi_disable(struct irq_data *d)
+{
+	struct xlp_msi_data *md = irq_data_get_irq_handler_data(d);
+	unsigned long flags;
+	int vec;
+
+	vec = nlm_irq_msivec(d->irq);
+	spin_lock_irqsave(&md->msi_lock, flags);
+	md->msi_enabled_mask &= ~(1u << vec);
+	nlm_write_reg(md->lnkbase, PCIE_MSI_EN, md->msi_enabled_mask);
+	spin_unlock_irqrestore(&md->msi_lock, flags);
+}
+
+static void xlp_msi_mask_ack(struct irq_data *d)
+{
+	struct xlp_msi_data *md = irq_data_get_irq_handler_data(d);
+	int link, vec;
+
+	link = nlm_irq_msilink(d->irq);
+	vec = nlm_irq_msivec(d->irq);
+	xlp_msi_disable(d);
+
+	/* Ack MSI on bridge */
+	nlm_write_reg(md->lnkbase, PCIE_MSI_STATUS, 1u << vec);
+
+	/* Ack at eirr and PIC */
+	ack_c0_eirr(PIC_PCIE_LINK_MSI_IRQ(link));
+	nlm_pic_ack(md->node->picbase, PIC_IRT_PCIE_LINK_INDEX(link));
+}
+
+static struct irq_chip xlp_msi_chip = {
+	.name		= "XLP-MSI",
+	.irq_enable	= xlp_msi_enable,
+	.irq_disable	= xlp_msi_disable,
+	.irq_mask_ack	= xlp_msi_mask_ack,
+	.irq_unmask	= xlp_msi_enable,
+};
+
+/*
+ * The MSI-X interrupt handling is different from MSI, there are 32
+ * MSI-X interrupts generated by the PIC and each of these correspond
+ * to a MSI-X vector (0-31) that can be assigned.
+ *
+ * We divide the MSI-X vectors to 8 per link and do a per-link
+ * allocation
+ *
+ * Enable and disable done using standard MSI functions.
+ */
+static void xlp_msix_mask_ack(struct irq_data *d)
+{
+	struct xlp_msi_data *md = irq_data_get_irq_handler_data(d);
+	int link, msixvec;
+
+	msixvec = nlm_irq_msixvec(d->irq);
+	link = nlm_irq_msixlink(d->irq);
+
+	/* Ack MSI on bridge */
+	nlm_write_reg(md->lnkbase, PCIE_MSIX_STATUS, 1u << msixvec);
+
+	/* Ack at eirr and PIC */
+	ack_c0_eirr(PIC_PCIE_MSIX_IRQ(link));
+	nlm_pic_ack(md->node->picbase, PIC_IRT_PCIE_MSIX_INDEX(msixvec));
+}
+
+static struct irq_chip xlp_msix_chip = {
+	.name		= "XLP-MSIX",
+	.irq_enable	= unmask_msi_irq,
+	.irq_disable	= mask_msi_irq,
+	.irq_mask_ack	= xlp_msix_mask_ack,
+	.irq_unmask	= unmask_msi_irq,
+};
+
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
+/*
+ * Setup a PCIe link for MSI.  By default, the links are in
+ * legacy interrupt mode.  We will switch them to MSI mode
+ * at the first MSI request.
+ */
+static void xlp_config_link_msi(uint64_t lnkbase, int lirq, uint64_t msiaddr)
+{
+	u32 val;
+
+	val = nlm_read_reg(lnkbase, PCIE_INT_EN0);
+	if ((val & 0x200) == 0) {
+		val |= 0x200;		/* MSI Interrupt enable */
+		nlm_write_reg(lnkbase, PCIE_INT_EN0, val);
+	}
+
+	val = nlm_read_reg(lnkbase, 0x1);	/* CMD */
+	if ((val & 0x0400) == 0) {
+		val |= 0x0400;
+		nlm_write_reg(lnkbase, 0x1, val);
+	}
+
+	/* Update IRQ in the PCI irq reg */
+	val = nlm_read_pci_reg(lnkbase, 0xf);
+	val &= ~0x1fu;
+	val |= (1 << 8) | lirq;
+	nlm_write_pci_reg(lnkbase, 0xf, val);
+
+	/* MSI addr */
+	nlm_write_reg(lnkbase, PCIE_BRIDGE_MSI_ADDRH, msiaddr >> 32);
+	nlm_write_reg(lnkbase, PCIE_BRIDGE_MSI_ADDRL, msiaddr & 0xffffffff);
+
+	/* MSI cap for bridge */
+	val = nlm_read_reg(lnkbase, PCIE_BRIDGE_MSI_CAP);
+	if ((val & (1 << 16)) == 0) {
+		val |= 0xb << 16;		/* mmc32, msi enable */
+		nlm_write_reg(lnkbase, PCIE_BRIDGE_MSI_CAP, val);
+	}
+}
+
+/*
+ * Allocate a MSI vector on a link
+ */
+static int xlp_setup_msi(uint64_t lnkbase, int node, int link,
+	struct msi_desc *desc)
+{
+	struct xlp_msi_data *md;
+	struct msi_msg msg;
+	unsigned long flags;
+	int msivec, irt, lirq, xirq, ret;
+	uint64_t msiaddr;
+
+	/* Get MSI data for the link */
+	lirq = PIC_PCIE_LINK_MSI_IRQ(link);
+	xirq = nlm_irq_to_xirq(node, nlm_link_msiirq(link, 0));
+	md = irq_get_handler_data(xirq);
+	msiaddr = MSI_LINK_ADDR(node, link);
+
+	spin_lock_irqsave(&md->msi_lock, flags);
+	if (md->msi_alloc_mask == 0) {
+		/* switch the link IRQ to MSI range */
+		xlp_config_link_msi(lnkbase, lirq, msiaddr);
+		irt = PIC_IRT_PCIE_LINK_INDEX(link);
+		nlm_setup_pic_irq(node, lirq, lirq, irt);
+		nlm_pic_init_irt(nlm_get_node(node)->picbase, irt, lirq,
+				 node * NLM_CPUS_PER_NODE, 1 /*en */);
+	}
+
+	/* allocate a MSI vec, and tell the bridge about it */
+	msivec = fls(md->msi_alloc_mask);
+	if (msivec == XLP_MSIVEC_PER_LINK) {
+		spin_unlock_irqrestore(&md->msi_lock, flags);
+		return -ENOMEM;
+	}
+	md->msi_alloc_mask |= (1u << msivec);
+	spin_unlock_irqrestore(&md->msi_lock, flags);
+
+	msg.address_hi = msiaddr >> 32;
+	msg.address_lo = msiaddr & 0xffffffff;
+	msg.data = 0xc00 | msivec;
+
+	xirq = xirq + msivec;		/* msi mapped to global irq space */
+	ret = irq_set_msi_desc(xirq, desc);
+	if (ret < 0) {
+		destroy_irq(xirq);
+		return ret;
+	}
+
+	write_msi_msg(xirq, &msg);
+	return 0;
+}
+
+/*
+ * Switch a link to MSI-X mode
+ */
+static void xlp_config_link_msix(uint64_t lnkbase, int lirq, uint64_t msixaddr)
+{
+	u32 val;
+
+	val = nlm_read_reg(lnkbase, 0x2C);
+	if ((val & 0x80000000U) == 0) {
+		val |= 0x80000000U;
+		nlm_write_reg(lnkbase, 0x2C, val);
+	}
+	val = nlm_read_reg(lnkbase, PCIE_INT_EN0);
+	if ((val & 0x200) == 0) {
+		val |= 0x200;		/* MSI Interrupt enable */
+		nlm_write_reg(lnkbase, PCIE_INT_EN0, val);
+	}
+
+	val = nlm_read_reg(lnkbase, 0x1);	/* CMD */
+	if ((val & 0x0400) == 0) {
+		val |= 0x0400;
+		nlm_write_reg(lnkbase, 0x1, val);
+	}
+
+	/* Update IRQ in the PCI irq reg */
+	val = nlm_read_pci_reg(lnkbase, 0xf);
+	val &= ~0x1fu;
+	val |= (1 << 8) | lirq;
+	nlm_write_pci_reg(lnkbase, 0xf, val);
+
+	/* MSI-X addresses */
+	nlm_write_reg(lnkbase, PCIE_BRIDGE_MSIX_ADDR_BASE, msixaddr >> 8);
+	nlm_write_reg(lnkbase, PCIE_BRIDGE_MSIX_ADDR_LIMIT,
+					(msixaddr + MSI_ADDR_SZ) >> 8);
+}
+
+/*
+ *  Allocate a MSI-X vector
+ */
+static int xlp_setup_msix(uint64_t lnkbase, int node, int link,
+	struct msi_desc *desc)
+{
+	struct xlp_msi_data *md;
+	struct msi_msg msg;
+	unsigned long flags;
+	int t, msixvec, lirq, xirq, ret;
+	uint64_t msixaddr;
+
+	/* Get MSI data for the link */
+	lirq = PIC_PCIE_MSIX_IRQ(link);
+	xirq = nlm_irq_to_xirq(node, nlm_link_msixirq(link, 0));
+	md = irq_get_handler_data(xirq);
+	msixaddr = MSIX_LINK_ADDR(node, link);
+
+	spin_lock_irqsave(&md->msi_lock, flags);
+	/* switch the PCIe link to MSI-X mode at the first alloc */
+	if (md->msix_alloc_mask == 0)
+		xlp_config_link_msix(lnkbase, lirq, msixaddr);
+
+	/* allocate a MSI-X vec, and tell the bridge about it */
+	t = fls(md->msix_alloc_mask);
+	if (t == XLP_MSIXVEC_PER_LINK) {
+		spin_unlock_irqrestore(&md->msi_lock, flags);
+		return -ENOMEM;
+	}
+	md->msix_alloc_mask |= (1u << t);
+	spin_unlock_irqrestore(&md->msi_lock, flags);
+
+	xirq += t;
+	msixvec = nlm_irq_msixvec(xirq);
+	msg.address_hi = msixaddr >> 32;
+	msg.address_lo = msixaddr & 0xffffffff;
+	msg.data = 0xc00 | msixvec;
+
+	ret = irq_set_msi_desc(xirq, desc);
+	if (ret < 0) {
+		destroy_irq(xirq);
+		return ret;
+	}
+
+	write_msi_msg(xirq, &msg);
+	return 0;
+}
+
+int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
+{
+	struct pci_dev *lnkdev;
+	uint64_t lnkbase;
+	int node, link, slot;
+
+	lnkdev = xlp_get_pcie_link(dev);
+	if (lnkdev == NULL) {
+		dev_err(&dev->dev, "Could not find bridge\n");
+		return 1;
+	}
+	slot = PCI_SLOT(lnkdev->devfn);
+	link = PCI_FUNC(lnkdev->devfn);
+	node = slot / 8;
+	lnkbase = nlm_get_pcie_base(node, link);
+
+	if (desc->msi_attrib.is_msix)
+		return xlp_setup_msix(lnkbase, node, link, desc);
+	else
+		return xlp_setup_msi(lnkbase, node, link, desc);
+}
+
+void __init xlp_init_node_msi_irqs(int node, int link)
+{
+	struct nlm_soc_info *nodep;
+	struct xlp_msi_data *md;
+	int irq, i, irt, msixvec;
+
+	pr_info("[%d %d] Init node PCI IRT\n", node, link);
+	nodep = nlm_get_node(node);
+
+	/* Alloc an MSI block for the link */
+	md = kzalloc(sizeof(*md), GFP_KERNEL);
+	spin_lock_init(&md->msi_lock);
+	md->msi_enabled_mask = 0;
+	md->msi_alloc_mask = 0;
+	md->msix_alloc_mask = 0;
+	md->node = nodep;
+	md->lnkbase = nlm_get_pcie_base(node, link);
+
+	/* extended space for MSI interrupts */
+	irq = nlm_irq_to_xirq(node, nlm_link_msiirq(link, 0));
+	for (i = irq; i < irq + XLP_MSIVEC_PER_LINK; i++) {
+		irq_set_chip_and_handler(i, &xlp_msi_chip, handle_level_irq);
+		irq_set_handler_data(i, md);
+	}
+
+	for (i = 0; i < XLP_MSIXVEC_PER_LINK; i++) {
+		/* Initialize MSI-X irts to generate one interrupt per link */
+		msixvec = link * XLP_MSIXVEC_PER_LINK + i;
+		irt = PIC_IRT_PCIE_MSIX_INDEX(msixvec);
+		nlm_pic_init_irt(nodep->picbase, irt, PIC_PCIE_MSIX_IRQ(link),
+			node * NLM_CPUS_PER_NODE, 1 /* enable */);
+
+		/* Initialize MSI-X extended irq space for the link  */
+		irq = nlm_irq_to_xirq(node, nlm_link_msixirq(link, i));
+		irq_set_chip_and_handler(irq, &xlp_msix_chip, handle_level_irq);
+		irq_set_handler_data(irq, md);
+	}
+
+}
+
+void nlm_dispatch_msi(int node, int lirq)
+{
+	struct xlp_msi_data *md;
+	int link, i, irqbase;
+	u32 status;
+
+	link = lirq - PIC_PCIE_LINK_MSI_IRQ_BASE;
+	irqbase = nlm_irq_to_xirq(node, nlm_link_msiirq(link, 0));
+	md = irq_get_handler_data(irqbase);
+	status = nlm_read_reg(md->lnkbase, PCIE_MSI_STATUS) &
+						md->msi_enabled_mask;
+	while (status) {
+		i = __ffs(status);
+		do_IRQ(irqbase + i);
+		status &= status - 1;
+	}
+}
+
+void nlm_dispatch_msix(int node, int lirq)
+{
+	struct xlp_msi_data *md;
+	int link, i, irqbase;
+	u32 status;
+
+	link = lirq - PIC_PCIE_MSIX_IRQ_BASE;
+	irqbase = nlm_irq_to_xirq(node, nlm_link_msixirq(link, 0));
+	md = irq_get_handler_data(irqbase);
+	status = nlm_read_reg(md->lnkbase, PCIE_MSIX_STATUS);
+
+	/* narrow it down to the MSI-x vectors for our link */
+	status = (status >> (link * XLP_MSIXVEC_PER_LINK)) &
+			((1 << XLP_MSIXVEC_PER_LINK) - 1);
+
+	while (status) {
+		i = __ffs(status);
+		do_IRQ(irqbase + i);
+		status &= status - 1;
+	}
+}
diff --git a/arch/mips/pci/pci-xlp.c b/arch/mips/pci/pci-xlp.c
index 653d2db..222d804 100644
--- a/arch/mips/pci/pci-xlp.c
+++ b/arch/mips/pci/pci-xlp.c
@@ -47,6 +47,7 @@
 #include <asm/netlogic/interrupt.h>
 #include <asm/netlogic/haldefs.h>
 #include <asm/netlogic/common.h>
+#include <asm/netlogic/mips-extns.h>
 
 #include <asm/netlogic/xlp-hal/iomap.h>
 #include <asm/netlogic/xlp-hal/pic.h>
@@ -162,7 +163,7 @@ struct pci_controller nlm_pci_controller = {
 	.io_offset	= 0x00000000UL,
 };
 
-static struct pci_dev *xlp_get_pcie_link(const struct pci_dev *dev)
+struct pci_dev *xlp_get_pcie_link(const struct pci_dev *dev)
 {
 	struct pci_bus *bus, *p;
 
@@ -174,11 +175,6 @@ static struct pci_dev *xlp_get_pcie_link(const struct pci_dev *dev)
 	return p ? bus->self : NULL;
 }
 
-static inline int nlm_pci_link_to_irq(int link)
-{
-	return PIC_PCIE_LINK_0_IRQ + link;
-}
-
 int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct pci_dev *lnkdev;
@@ -193,7 +189,7 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 		return 0;
 	lnkfunc = PCI_FUNC(lnkdev->devfn);
 	lnkslot = PCI_SLOT(lnkdev->devfn);
-	return nlm_irq_to_xirq(lnkslot / 8, nlm_pci_link_to_irq(lnkfunc));
+	return nlm_irq_to_xirq(lnkslot / 8, PIC_PCIE_LINK_LEGACY_IRQ(lnkfunc));
 }
 
 /* Do platform specific device initialization at pci_enable_device() time */
@@ -257,16 +253,17 @@ static int __init pcibios_init(void)
 		if (!nodep->coremask)
 			continue;	/* node does not exist */
 
-		for (link = 0; link < 4; link++) {
+		for (link = 0; link < PCIE_NLINKS; link++) {
 			pciebase = nlm_get_pcie_base(n, link);
 			if (nlm_read_pci_reg(pciebase, 0) == 0xffffffff)
 				continue;
 			xlp_config_pci_bswap(n, link);
+			xlp_init_node_msi_irqs(n, link);
 
 			/* put in intpin and irq - u-boot does not */
 			reg = nlm_read_pci_reg(pciebase, 0xf);
 			reg &= ~0x1fu;
-			reg |= (1 << 8) | nlm_pci_link_to_irq(link);
+			reg |= (1 << 8) | PIC_PCIE_LINK_LEGACY_IRQ(link);
 			nlm_write_pci_reg(pciebase, 0xf, reg);
 			pr_info("XLP PCIe: Link %d-%d initialized.\n", n, link);
 		}
-- 
1.7.9.5
