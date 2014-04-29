Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2014 16:37:45 +0200 (CEST)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:5264 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854769AbaD2OcWytlhY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Apr 2014 16:32:22 +0200
X-IronPort-AV: E=Sophos;i="4.97,951,1389772800"; 
   d="scan'208";a="26655046"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw3-out.broadcom.com with ESMTP; 29 Apr 2014 07:52:16 -0700
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Tue, 29 Apr 2014 07:32:07 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.3.174.1; Tue, 29 Apr 2014 07:32:08 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 8413D51E7F;    Tue, 29 Apr 2014 07:32:06 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Ganesan Ramalingam <ganesanr@broadcom.com>, <ralf@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 15/17] MIPS: Add MSI support for XLP9XX
Date:   Tue, 29 Apr 2014 20:07:54 +0530
Message-ID: <f53d4713cc3224ee83953831d77c963a267199c1.1398780013.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1398780013.git.jchandra@broadcom.com>
References: <cover.1398780013.git.jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39984
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

From: Ganesan Ramalingam <ganesanr@broadcom.com>

In XLP9XX, the interrupt routing table for MSI-X has been moved to the
PCIe controller's config space from PIC. There are also 32 MSI-X
interrupts available per link on XLP9XX.

Update XLP MSI/MSI-X code to handle this.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/pcibus.h |   14 ++
 arch/mips/include/asm/netlogic/xlp-hal/pic.h    |    4 +
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h    |    5 +-
 arch/mips/pci/msi-xlp.c                         |  178 +++++++++++++++++------
 4 files changed, 151 insertions(+), 50 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pcibus.h b/arch/mips/include/asm/netlogic/xlp-hal/pcibus.h
index d4deb87..91540f4 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/pcibus.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pcibus.h
@@ -69,6 +69,20 @@
 #define PCIE_9XX_BYTE_SWAP_IO_BASE	0x25e
 #define PCIE_9XX_BYTE_SWAP_IO_LIM	0x25f
 
+#define PCIE_9XX_BRIDGE_MSIX_ADDR_BASE	0x264
+#define PCIE_9XX_BRIDGE_MSIX_ADDR_LIMIT	0x265
+#define PCIE_9XX_MSI_STATUS		0x283
+#define PCIE_9XX_MSI_EN			0x284
+/* 128 MSIX vectors available in 9xx */
+#define PCIE_9XX_MSIX_STATUS0		0x286
+#define PCIE_9XX_MSIX_STATUSX(n)	(n + 0x286)
+#define PCIE_9XX_MSIX_VEC		0x296
+#define PCIE_9XX_MSIX_VECX(n)		(n + 0x296)
+#define PCIE_9XX_INT_STATUS0		0x397
+#define PCIE_9XX_INT_STATUS1		0x398
+#define PCIE_9XX_INT_EN0		0x399
+#define PCIE_9XX_INT_EN1		0x39a
+
 /* other */
 #define PCIE_NLINKS			4
 
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pic.h b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
index f10bf3b..41cefe9 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/pic.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
@@ -199,6 +199,10 @@
 #define PIC_IRT_PCIE_LINK_3_INDEX	81
 #define PIC_IRT_PCIE_LINK_INDEX(num)	((num) + PIC_IRT_PCIE_LINK_0_INDEX)
 
+#define PIC_9XX_IRT_PCIE_LINK_0_INDEX	191
+#define PIC_9XX_IRT_PCIE_LINK_INDEX(num) \
+				((num) + PIC_9XX_IRT_PCIE_LINK_0_INDEX)
+
 #define PIC_CLOCK_TIMER			7
 
 #if !defined(LOCORE) && !defined(__ASSEMBLY__)
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index 8f8afe0..c0b2a80 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -70,8 +70,9 @@
 #define PIC_PCIE_MSIX_IRQ_BASE		48	/* 48 - 51 MSI-X IRQ */
 #define PIC_PCIE_MSIX_IRQ(i)		(48 + (i))
 
-#define NLM_MSIX_VEC_BASE		96	/* 96 - 127 - MSIX mapped */
-#define NLM_MSI_VEC_BASE		128	/* 128 -255 - MSI mapped */
+/* XLP9xx and XLP8xx has 128 and 32 MSIX vectors respectively */
+#define NLM_MSIX_VEC_BASE		96	/* 96 - 223 - MSIX mapped */
+#define NLM_MSI_VEC_BASE		224	/* 224 -351 - MSI mapped */
 
 #define NLM_PIC_INDIRECT_VEC_BASE	512
 #define NLM_GPIO_VEC_BASE		768
diff --git a/arch/mips/pci/msi-xlp.c b/arch/mips/pci/msi-xlp.c
index afd8405..d00be82 100644
--- a/arch/mips/pci/msi-xlp.c
+++ b/arch/mips/pci/msi-xlp.c
@@ -56,8 +56,8 @@
 #include <asm/netlogic/xlp-hal/bridge.h>
 
 #define XLP_MSIVEC_PER_LINK	32
-#define XLP_MSIXVEC_TOTAL	32
-#define XLP_MSIXVEC_PER_LINK	8
+#define XLP_MSIXVEC_TOTAL	(cpu_is_xlp9xx() ? 128 : 32)
+#define XLP_MSIXVEC_PER_LINK	(cpu_is_xlp9xx() ? 32 : 8)
 
 /* 128 MSI irqs per node, mapped starting at NLM_MSI_VEC_BASE */
 static inline int nlm_link_msiirq(int link, int msivec)
@@ -65,35 +65,44 @@ static inline int nlm_link_msiirq(int link, int msivec)
 	return NLM_MSI_VEC_BASE + link * XLP_MSIVEC_PER_LINK + msivec;
 }
 
+/* get the link MSI vector from irq number */
 static inline int nlm_irq_msivec(int irq)
 {
-	return irq % XLP_MSIVEC_PER_LINK;
+	return (irq - NLM_MSI_VEC_BASE) % XLP_MSIVEC_PER_LINK;
 }
 
+/* get the link from the irq number */
 static inline int nlm_irq_msilink(int irq)
 {
-	return (irq % (XLP_MSIVEC_PER_LINK * PCIE_NLINKS)) /
-						XLP_MSIVEC_PER_LINK;
+	int total_msivec = XLP_MSIVEC_PER_LINK * PCIE_NLINKS;
+
+	return ((irq - NLM_MSI_VEC_BASE) % total_msivec) /
+		XLP_MSIVEC_PER_LINK;
 }
 
 /*
- * Only 32 MSI-X vectors are possible because there are only 32 PIC
- * interrupts for MSI. We split them statically and use 8 MSI-X vectors
- * per link - this keeps the allocation and lookup simple.
+ * For XLP 8xx/4xx/3xx/2xx, only 32 MSI-X vectors are possible because
+ * there are only 32 PIC interrupts for MSI. We split them statically
+ * and use 8 MSI-X vectors per link - this keeps the allocation and
+ * lookup simple.
+ * On XLP 9xx, there are 32 vectors per link, and the interrupts are
+ * not routed thru PIC, so we can use all 128 MSI-X vectors.
  */
 static inline int nlm_link_msixirq(int link, int bit)
 {
 	return NLM_MSIX_VEC_BASE + link * XLP_MSIXVEC_PER_LINK + bit;
 }
 
+/* get the link MSI vector from irq number */
 static inline int nlm_irq_msixvec(int irq)
 {
-	return irq % XLP_MSIXVEC_TOTAL;  /* works when given xirq */
+	return (irq - NLM_MSIX_VEC_BASE) % XLP_MSIXVEC_TOTAL;
 }
 
-static inline int nlm_irq_msixlink(int irq)
+/* get the link from MSIX vec */
+static inline int nlm_irq_msixlink(int msixvec)
 {
-	return nlm_irq_msixvec(irq) / XLP_MSIXVEC_PER_LINK;
+	return msixvec / XLP_MSIXVEC_PER_LINK;
 }
 
 /*
@@ -129,7 +138,11 @@ static void xlp_msi_enable(struct irq_data *d)
 	vec = nlm_irq_msivec(d->irq);
 	spin_lock_irqsave(&md->msi_lock, flags);
 	md->msi_enabled_mask |= 1u << vec;
-	nlm_write_reg(md->lnkbase, PCIE_MSI_EN, md->msi_enabled_mask);
+	if (cpu_is_xlp9xx())
+		nlm_write_reg(md->lnkbase, PCIE_9XX_MSI_EN,
+				md->msi_enabled_mask);
+	else
+		nlm_write_reg(md->lnkbase, PCIE_MSI_EN, md->msi_enabled_mask);
 	spin_unlock_irqrestore(&md->msi_lock, flags);
 }
 
@@ -142,7 +155,11 @@ static void xlp_msi_disable(struct irq_data *d)
 	vec = nlm_irq_msivec(d->irq);
 	spin_lock_irqsave(&md->msi_lock, flags);
 	md->msi_enabled_mask &= ~(1u << vec);
-	nlm_write_reg(md->lnkbase, PCIE_MSI_EN, md->msi_enabled_mask);
+	if (cpu_is_xlp9xx())
+		nlm_write_reg(md->lnkbase, PCIE_9XX_MSI_EN,
+				md->msi_enabled_mask);
+	else
+		nlm_write_reg(md->lnkbase, PCIE_MSI_EN, md->msi_enabled_mask);
 	spin_unlock_irqrestore(&md->msi_lock, flags);
 }
 
@@ -156,11 +173,18 @@ static void xlp_msi_mask_ack(struct irq_data *d)
 	xlp_msi_disable(d);
 
 	/* Ack MSI on bridge */
-	nlm_write_reg(md->lnkbase, PCIE_MSI_STATUS, 1u << vec);
+	if (cpu_is_xlp9xx())
+		nlm_write_reg(md->lnkbase, PCIE_9XX_MSI_STATUS, 1u << vec);
+	else
+		nlm_write_reg(md->lnkbase, PCIE_MSI_STATUS, 1u << vec);
 
 	/* Ack at eirr and PIC */
 	ack_c0_eirr(PIC_PCIE_LINK_MSI_IRQ(link));
-	nlm_pic_ack(md->node->picbase, PIC_IRT_PCIE_LINK_INDEX(link));
+	if (cpu_is_xlp9xx())
+		nlm_pic_ack(md->node->picbase,
+				PIC_9XX_IRT_PCIE_LINK_INDEX(link));
+	else
+		nlm_pic_ack(md->node->picbase, PIC_IRT_PCIE_LINK_INDEX(link));
 }
 
 static struct irq_chip xlp_msi_chip = {
@@ -172,30 +196,45 @@ static struct irq_chip xlp_msi_chip = {
 };
 
 /*
- * The MSI-X interrupt handling is different from MSI, there are 32
- * MSI-X interrupts generated by the PIC and each of these correspond
- * to a MSI-X vector (0-31) that can be assigned.
+ * XLP8XX/4XX/3XX/2XX:
+ * The MSI-X interrupt handling is different from MSI, there are 32 MSI-X
+ * interrupts generated by the PIC and each of these correspond to a MSI-X
+ * vector (0-31) that can be assigned.
+ *
+ * We divide the MSI-X vectors to 8 per link and do a per-link allocation
  *
- * We divide the MSI-X vectors to 8 per link and do a per-link
- * allocation
+ * XLP9XX:
+ * 32 MSI-X vectors are available per link, and the interrupts are not routed
+ * thru the PIC. PIC ack not needed.
  *
  * Enable and disable done using standard MSI functions.
  */
 static void xlp_msix_mask_ack(struct irq_data *d)
 {
-	struct xlp_msi_data *md = irq_data_get_irq_handler_data(d);
+	struct xlp_msi_data *md;
 	int link, msixvec;
+	uint32_t status_reg, bit;
 
 	msixvec = nlm_irq_msixvec(d->irq);
-	link = nlm_irq_msixlink(d->irq);
+	link = nlm_irq_msixlink(msixvec);
 	mask_msi_irq(d);
+	md = irq_data_get_irq_handler_data(d);
 
 	/* Ack MSI on bridge */
-	nlm_write_reg(md->lnkbase, PCIE_MSIX_STATUS, 1u << msixvec);
+	if (cpu_is_xlp9xx()) {
+		status_reg = PCIE_9XX_MSIX_STATUSX(link);
+		bit = msixvec % XLP_MSIXVEC_PER_LINK;
+	} else {
+		status_reg = PCIE_MSIX_STATUS;
+		bit = msixvec;
+	}
+	nlm_write_reg(md->lnkbase, status_reg, 1u << bit);
 
 	/* Ack at eirr and PIC */
 	ack_c0_eirr(PIC_PCIE_MSIX_IRQ(link));
-	nlm_pic_ack(md->node->picbase, PIC_IRT_PCIE_MSIX_INDEX(msixvec));
+	if (!cpu_is_xlp9xx())
+		nlm_pic_ack(md->node->picbase,
+				PIC_IRT_PCIE_MSIX_INDEX(msixvec));
 }
 
 static struct irq_chip xlp_msix_chip = {
@@ -225,10 +264,18 @@ static void xlp_config_link_msi(uint64_t lnkbase, int lirq, uint64_t msiaddr)
 {
 	u32 val;
 
-	val = nlm_read_reg(lnkbase, PCIE_INT_EN0);
-	if ((val & 0x200) == 0) {
-		val |= 0x200;		/* MSI Interrupt enable */
-		nlm_write_reg(lnkbase, PCIE_INT_EN0, val);
+	if (cpu_is_xlp9xx()) {
+		val = nlm_read_reg(lnkbase, PCIE_9XX_INT_EN0);
+		if ((val & 0x200) == 0) {
+			val |= 0x200;		/* MSI Interrupt enable */
+			nlm_write_reg(lnkbase, PCIE_9XX_INT_EN0, val);
+		}
+	} else {
+		val = nlm_read_reg(lnkbase, PCIE_INT_EN0);
+		if ((val & 0x200) == 0) {
+			val |= 0x200;
+			nlm_write_reg(lnkbase, PCIE_INT_EN0, val);
+		}
 	}
 
 	val = nlm_read_reg(lnkbase, 0x1);	/* CMD */
@@ -275,9 +322,12 @@ static int xlp_setup_msi(uint64_t lnkbase, int node, int link,
 
 	spin_lock_irqsave(&md->msi_lock, flags);
 	if (md->msi_alloc_mask == 0) {
-		/* switch the link IRQ to MSI range */
 		xlp_config_link_msi(lnkbase, lirq, msiaddr);
-		irt = PIC_IRT_PCIE_LINK_INDEX(link);
+		/* switch the link IRQ to MSI range */
+		if (cpu_is_xlp9xx())
+			irt = PIC_9XX_IRT_PCIE_LINK_INDEX(link);
+		else
+			irt = PIC_IRT_PCIE_LINK_INDEX(link);
 		nlm_setup_pic_irq(node, lirq, lirq, irt);
 		nlm_pic_init_irt(nlm_get_node(node)->picbase, irt, lirq,
 				 node * nlm_threads_per_node(), 1 /*en */);
@@ -319,10 +369,19 @@ static void xlp_config_link_msix(uint64_t lnkbase, int lirq, uint64_t msixaddr)
 		val |= 0x80000000U;
 		nlm_write_reg(lnkbase, 0x2C, val);
 	}
-	val = nlm_read_reg(lnkbase, PCIE_INT_EN0);
-	if ((val & 0x200) == 0) {
-		val |= 0x200;		/* MSI Interrupt enable */
-		nlm_write_reg(lnkbase, PCIE_INT_EN0, val);
+
+	if (cpu_is_xlp9xx()) {
+		val = nlm_read_reg(lnkbase, PCIE_9XX_INT_EN0);
+		if ((val & 0x200) == 0) {
+			val |= 0x200;		/* MSI Interrupt enable */
+			nlm_write_reg(lnkbase, PCIE_9XX_INT_EN0, val);
+		}
+	} else {
+		val = nlm_read_reg(lnkbase, PCIE_INT_EN0);
+		if ((val & 0x200) == 0) {
+			val |= 0x200;		/* MSI Interrupt enable */
+			nlm_write_reg(lnkbase, PCIE_INT_EN0, val);
+		}
 	}
 
 	val = nlm_read_reg(lnkbase, 0x1);	/* CMD */
@@ -337,10 +396,19 @@ static void xlp_config_link_msix(uint64_t lnkbase, int lirq, uint64_t msixaddr)
 	val |= (1 << 8) | lirq;
 	nlm_write_pci_reg(lnkbase, 0xf, val);
 
-	/* MSI-X addresses */
-	nlm_write_reg(lnkbase, PCIE_BRIDGE_MSIX_ADDR_BASE, msixaddr >> 8);
-	nlm_write_reg(lnkbase, PCIE_BRIDGE_MSIX_ADDR_LIMIT,
-					(msixaddr + MSI_ADDR_SZ) >> 8);
+	if (cpu_is_xlp9xx()) {
+		/* MSI-X addresses */
+		nlm_write_reg(lnkbase, PCIE_9XX_BRIDGE_MSIX_ADDR_BASE,
+				msixaddr >> 8);
+		nlm_write_reg(lnkbase, PCIE_9XX_BRIDGE_MSIX_ADDR_LIMIT,
+				(msixaddr + MSI_ADDR_SZ) >> 8);
+	} else {
+		/* MSI-X addresses */
+		nlm_write_reg(lnkbase, PCIE_BRIDGE_MSIX_ADDR_BASE,
+				msixaddr >> 8);
+		nlm_write_reg(lnkbase, PCIE_BRIDGE_MSIX_ADDR_LIMIT,
+				(msixaddr + MSI_ADDR_SZ) >> 8);
+	}
 }
 
 /*
@@ -377,6 +445,7 @@ static int xlp_setup_msix(uint64_t lnkbase, int node, int link,
 
 	xirq += t;
 	msixvec = nlm_irq_msixvec(xirq);
+
 	msg.address_hi = msixaddr >> 32;
 	msg.address_lo = msixaddr & 0xffffffff;
 	msg.data = 0xc00 | msixvec;
@@ -417,7 +486,7 @@ void __init xlp_init_node_msi_irqs(int node, int link)
 {
 	struct nlm_soc_info *nodep;
 	struct xlp_msi_data *md;
-	int irq, i, irt, msixvec;
+	int irq, i, irt, msixvec, val;
 
 	pr_info("[%d %d] Init node PCI IRT\n", node, link);
 	nodep = nlm_get_node(node);
@@ -438,19 +507,28 @@ void __init xlp_init_node_msi_irqs(int node, int link)
 		irq_set_handler_data(i, md);
 	}
 
-	for (i = 0; i < XLP_MSIXVEC_PER_LINK; i++) {
-		/* Initialize MSI-X irts to generate one interrupt per link */
-		msixvec = link * XLP_MSIXVEC_PER_LINK + i;
-		irt = PIC_IRT_PCIE_MSIX_INDEX(msixvec);
-		nlm_pic_init_irt(nodep->picbase, irt, PIC_PCIE_MSIX_IRQ(link),
-			node * nlm_threads_per_node(), 1 /* enable */);
+	for (i = 0; i < XLP_MSIXVEC_PER_LINK ; i++) {
+		if (cpu_is_xlp9xx()) {
+			val = ((node * nlm_threads_per_node()) << 7 |
+				PIC_PCIE_MSIX_IRQ(link) << 1 | 0 << 0);
+			nlm_write_pcie_reg(md->lnkbase, PCIE_9XX_MSIX_VECX(i +
+					(link * XLP_MSIXVEC_PER_LINK)), val);
+		} else {
+			/* Initialize MSI-X irts to generate one interrupt
+			 * per link
+			 */
+			msixvec = link * XLP_MSIXVEC_PER_LINK + i;
+			irt = PIC_IRT_PCIE_MSIX_INDEX(msixvec);
+			nlm_pic_init_irt(nodep->picbase, irt,
+					PIC_PCIE_MSIX_IRQ(link),
+					node * nlm_threads_per_node(), 1);
+		}
 
 		/* Initialize MSI-X extended irq space for the link  */
 		irq = nlm_irq_to_xirq(node, nlm_link_msixirq(link, i));
 		irq_set_chip_and_handler(irq, &xlp_msix_chip, handle_level_irq);
 		irq_set_handler_data(irq, md);
 	}
-
 }
 
 void nlm_dispatch_msi(int node, int lirq)
@@ -480,10 +558,14 @@ void nlm_dispatch_msix(int node, int lirq)
 	link = lirq - PIC_PCIE_MSIX_IRQ_BASE;
 	irqbase = nlm_irq_to_xirq(node, nlm_link_msixirq(link, 0));
 	md = irq_get_handler_data(irqbase);
-	status = nlm_read_reg(md->lnkbase, PCIE_MSIX_STATUS);
+	if (cpu_is_xlp9xx())
+		status = nlm_read_reg(md->lnkbase, PCIE_9XX_MSIX_STATUSX(link));
+	else
+		status = nlm_read_reg(md->lnkbase, PCIE_MSIX_STATUS);
 
 	/* narrow it down to the MSI-x vectors for our link */
-	status = (status >> (link * XLP_MSIXVEC_PER_LINK)) &
+	if (!cpu_is_xlp9xx())
+		status = (status >> (link * XLP_MSIXVEC_PER_LINK)) &
 			((1 << XLP_MSIXVEC_PER_LINK) - 1);
 
 	while (status) {
-- 
1.7.9.5
