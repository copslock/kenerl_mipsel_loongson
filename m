Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jul 2010 03:15:30 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14058 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492388Ab0G0BOe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jul 2010 03:14:34 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c4e33120000>; Mon, 26 Jul 2010 18:14:58 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 26 Jul 2010 18:14:30 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 26 Jul 2010 18:14:30 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6R1EQjw016343;
        Mon, 26 Jul 2010 18:14:26 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6R1EQth016342;
        Mon, 26 Jul 2010 18:14:26 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Octeon: Support 256 MSI on PCIe
Date:   Mon, 26 Jul 2010 18:14:15 -0700
Message-Id: <1280193256-16294-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1280193256-16294-1-git-send-email-ddaney@caviumnetworks.com>
References: <1280193256-16294-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 27 Jul 2010 01:14:30.0682 (UTC) FILETIME=[10AC2FA0:01CB2D29]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mach-cavium-octeon/irq.h |    2 +-
 arch/mips/pci/msi-octeon.c                     |  294 ++++++++++++++----------
 2 files changed, 178 insertions(+), 118 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
index 783dae7..6ddab8a 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/irq.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
@@ -172,7 +172,7 @@
 #ifdef CONFIG_PCI_MSI
 /* 152 - 215 represent the MSI interrupts 0-63 */
 #define OCTEON_IRQ_MSI_BIT0	152
-#define OCTEON_IRQ_MSI_LAST	(OCTEON_IRQ_MSI_BIT0 + 63)
+#define OCTEON_IRQ_MSI_LAST	(OCTEON_IRQ_MSI_BIT0 + 255)
 
 #define OCTEON_IRQ_LAST		(OCTEON_IRQ_MSI_LAST + 1)
 #else
diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
index 83ceb52..7c75640 100644
--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2005-2009 Cavium Networks
+ * Copyright (C) 2005-2009, 2010 Cavium Networks
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -22,7 +22,7 @@
  * Each bit in msi_free_irq_bitmask represents a MSI interrupt that is
  * in use.
  */
-static uint64_t msi_free_irq_bitmask;
+static u64 msi_free_irq_bitmask[4];
 
 /*
  * Each bit in msi_multiple_irq_bitmask tells that the device using
@@ -30,7 +30,7 @@ static uint64_t msi_free_irq_bitmask;
  * is used so we can disable all of the MSI interrupts when a device
  * uses multiple.
  */
-static uint64_t msi_multiple_irq_bitmask;
+static u64 msi_multiple_irq_bitmask[4];
 
 /*
  * This lock controls updates to msi_free_irq_bitmask and
@@ -38,6 +38,11 @@ static uint64_t msi_multiple_irq_bitmask;
  */
 static DEFINE_SPINLOCK(msi_free_irq_bitmask_lock);
 
+/*
+ * Number of MSI IRQs used. This variable is set up in
+ * the module init time.
+ */
+static int msi_irq_size;
 
 /**
  * Called when a driver request MSI interrupts instead of the
@@ -54,12 +59,13 @@ static DEFINE_SPINLOCK(msi_free_irq_bitmask_lock);
 int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
 	struct msi_msg msg;
-	uint16_t control;
+	u16 control;
 	int configured_private_bits;
 	int request_private_bits;
-	int irq;
+	int irq = 0;
 	int irq_step;
-	uint64_t search_mask;
+	u64 search_mask;
+	int index;
 
 	/*
 	 * Read the MSI config to figure out how many IRQs this device
@@ -111,29 +117,31 @@ try_only_one:
 	 * use.
 	 */
 	spin_lock(&msi_free_irq_bitmask_lock);
-	for (irq = 0; irq < 64; irq += irq_step) {
-		if ((msi_free_irq_bitmask & (search_mask << irq)) == 0) {
-			msi_free_irq_bitmask |= search_mask << irq;
-			msi_multiple_irq_bitmask |= (search_mask >> 1) << irq;
-			break;
+	for (index = 0; index < msi_irq_size/64; index++) {
+		for (irq = 0; irq < 64; irq += irq_step) {
+			if ((msi_free_irq_bitmask[index] & (search_mask << irq)) == 0) {
+				msi_free_irq_bitmask[index] |= search_mask << irq;
+				msi_multiple_irq_bitmask[index] |= (search_mask >> 1) << irq;
+				goto msi_irq_allocated;
+			}
 		}
 	}
+msi_irq_allocated:
 	spin_unlock(&msi_free_irq_bitmask_lock);
 
 	/* Make sure the search for available interrupts didn't fail */
 	if (irq >= 64) {
 		if (request_private_bits) {
-			pr_err("arch_setup_msi_irq: Unable to find %d free "
-			       "interrupts, trying just one",
+			pr_err("arch_setup_msi_irq: Unable to find %d free interrupts, trying just one",
 			       1 << request_private_bits);
 			request_private_bits = 0;
 			goto try_only_one;
 		} else
-			panic("arch_setup_msi_irq: Unable to find a free MSI "
-			      "interrupt");
+			panic("arch_setup_msi_irq: Unable to find a free MSI interrupt");
 	}
 
 	/* MSI interrupts start at logical IRQ OCTEON_IRQ_MSI_BIT0 */
+	irq += index*64;
 	irq += OCTEON_IRQ_MSI_BIT0;
 
 	switch (octeon_dma_bar_type) {
@@ -179,12 +187,18 @@ try_only_one:
 void arch_teardown_msi_irq(unsigned int irq)
 {
 	int number_irqs;
-	uint64_t bitmask;
+	u64 bitmask;
+	int index = 0;
+	int irq0;
 
-	if ((irq < OCTEON_IRQ_MSI_BIT0) || (irq > OCTEON_IRQ_MSI_LAST))
+	if ((irq < OCTEON_IRQ_MSI_BIT0)
+		|| (irq > msi_irq_size + OCTEON_IRQ_MSI_BIT0))
 		panic("arch_teardown_msi_irq: Attempted to teardown illegal "
 		      "MSI interrupt (%d)", irq);
+
 	irq -= OCTEON_IRQ_MSI_BIT0;
+	index = irq / 64;
+	irq0 = irq % 64;
 
 	/*
 	 * Count the number of IRQs we need to free by looking at the
@@ -192,151 +206,197 @@ void arch_teardown_msi_irq(unsigned int irq)
 	 * IRQ is also owned by this device.
 	 */
 	number_irqs = 0;
-	while ((irq+number_irqs < 64) &&
-	       (msi_multiple_irq_bitmask & (1ull << (irq + number_irqs))))
+	while ((irq0 + number_irqs < 64) &&
+	       (msi_multiple_irq_bitmask[index]
+		& (1ull << (irq0 + number_irqs))))
 		number_irqs++;
 	number_irqs++;
 	/* Mask with one bit for each IRQ */
 	bitmask = (1 << number_irqs) - 1;
 	/* Shift the mask to the correct bit location */
-	bitmask <<= irq;
-	if ((msi_free_irq_bitmask & bitmask) != bitmask)
+	bitmask <<= irq0;
+	if ((msi_free_irq_bitmask[index] & bitmask) != bitmask)
 		panic("arch_teardown_msi_irq: Attempted to teardown MSI "
 		      "interrupt (%d) not in use", irq);
 
 	/* Checks are done, update the in use bitmask */
 	spin_lock(&msi_free_irq_bitmask_lock);
-	msi_free_irq_bitmask &= ~bitmask;
-	msi_multiple_irq_bitmask &= ~bitmask;
+	msi_free_irq_bitmask[index] &= ~bitmask;
+	msi_multiple_irq_bitmask[index] &= ~bitmask;
 	spin_unlock(&msi_free_irq_bitmask_lock);
 }
 
+static DEFINE_RAW_SPINLOCK(octeon_irq_msi_lock);
 
-/*
- * Called by the interrupt handling code when an MSI interrupt
- * occurs.
- */
-static irqreturn_t octeon_msi_interrupt(int cpl, void *dev_id)
+static u64 msi_rcv_reg[4];
+static u64 mis_ena_reg[4];
+
+static void octeon_irq_msi_enable_pcie(unsigned int irq)
 {
-	uint64_t msi_bits;
-	int irq;
+	u64 en;
+	unsigned long flags;
+	int msi_number = irq - OCTEON_IRQ_MSI_BIT0;
+	int irq_index = msi_number >> 6;
+	int irq_bit = msi_number & 0x3f;
+
+	raw_spin_lock_irqsave(&octeon_irq_msi_lock, flags);
+	en = cvmx_read_csr(mis_ena_reg[irq_index]);
+	en |= 1ull << irq_bit;
+	cvmx_write_csr(mis_ena_reg[irq_index], en);
+	cvmx_read_csr(mis_ena_reg[irq_index]);
+	raw_spin_unlock_irqrestore(&octeon_irq_msi_lock, flags);
+}
 
-	if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_PCIE)
-		msi_bits = cvmx_read_csr(CVMX_PEXP_NPEI_MSI_RCV0);
-	else
-		msi_bits = cvmx_read_csr(CVMX_NPI_NPI_MSI_RCV);
-	irq = fls64(msi_bits);
-	if (irq) {
-		irq += OCTEON_IRQ_MSI_BIT0 - 1;
-		if (octeon_has_feature(OCTEON_FEATURE_PCIE)) {
-			/* These chips have PCIe */
-			cvmx_write_csr(CVMX_PEXP_NPEI_MSI_RCV0,
-				       1ull << (irq - OCTEON_IRQ_MSI_BIT0));
-		} else {
-			/* These chips have PCI */
-			cvmx_write_csr(CVMX_NPI_NPI_MSI_RCV,
-				       1ull << (irq - OCTEON_IRQ_MSI_BIT0));
-		}
-		if (irq_desc[irq].action) {
-			do_IRQ(irq);
-			return IRQ_HANDLED;
-		} else {
-			pr_err("Spurious MSI interrupt %d\n", irq);
-		}
-	}
-	return IRQ_NONE;
+static void octeon_irq_msi_disable_pcie(unsigned int irq)
+{
+	u64 en;
+	unsigned long flags;
+	int msi_number = irq - OCTEON_IRQ_MSI_BIT0;
+	int irq_index = msi_number >> 6;
+	int irq_bit = msi_number & 0x3f;
+
+	raw_spin_lock_irqsave(&octeon_irq_msi_lock, flags);
+	en = cvmx_read_csr(mis_ena_reg[irq_index]);
+	en &= ~(1ull << irq_bit);
+	cvmx_write_csr(mis_ena_reg[irq_index], en);
+	cvmx_read_csr(mis_ena_reg[irq_index]);
+	raw_spin_unlock_irqrestore(&octeon_irq_msi_lock, flags);
 }
 
-static DEFINE_RAW_SPINLOCK(octeon_irq_msi_lock);
+static struct irq_chip octeon_irq_chip_msi_pcie = {
+	.name = "MSI",
+	.enable = octeon_irq_msi_enable_pcie,
+	.disable = octeon_irq_msi_disable_pcie,
+};
 
-static void octeon_irq_msi_enable(unsigned int irq)
+static void octeon_irq_msi_enable_pci(unsigned int irq)
 {
-	if (!octeon_has_feature(OCTEON_FEATURE_PCIE)) {
-		/*
-		 * Octeon PCI doesn't have the ability to mask/unmask
-		 * MSI interrupts individually.  Instead of
-		 * masking/unmasking them in groups of 16, we simple
-		 * assume MSI devices are well behaved.  MSI
-		 * interrupts are always enable and the ACK is assumed
-		 * to be enough.
-		 */
-	} else {
-		/* These chips have PCIe.  Note that we only support
-		 * the first 64 MSI interrupts.  Unfortunately all the
-		 * MSI enables are in the same register.  We use
-		 * MSI0's lock to control access to them all.
-		 */
-		uint64_t en;
-		unsigned long flags;
-		raw_spin_lock_irqsave(&octeon_irq_msi_lock, flags);
-		en = cvmx_read_csr(CVMX_PEXP_NPEI_MSI_ENB0);
-		en |= 1ull << (irq - OCTEON_IRQ_MSI_BIT0);
-		cvmx_write_csr(CVMX_PEXP_NPEI_MSI_ENB0, en);
-		cvmx_read_csr(CVMX_PEXP_NPEI_MSI_ENB0);
-		raw_spin_unlock_irqrestore(&octeon_irq_msi_lock, flags);
-	}
+	/*
+	 * Octeon PCI doesn't have the ability to mask/unmask MSI
+	 * interrupts individually. Instead of masking/unmasking them
+	 * in groups of 16, we simple assume MSI devices are well
+	 * behaved. MSI interrupts are always enable and the ACK is
+	 * assumed to be enough
+	 */
 }
 
-static void octeon_irq_msi_disable(unsigned int irq)
+static void octeon_irq_msi_disable_pci(unsigned int irq)
 {
-	if (!octeon_has_feature(OCTEON_FEATURE_PCIE)) {
-		/* See comment in enable */
-	} else {
-		/*
-		 * These chips have PCIe.  Note that we only support
-		 * the first 64 MSI interrupts.  Unfortunately all the
-		 * MSI enables are in the same register.  We use
-		 * MSI0's lock to control access to them all.
-		 */
-		uint64_t en;
-		unsigned long flags;
-		raw_spin_lock_irqsave(&octeon_irq_msi_lock, flags);
-		en = cvmx_read_csr(CVMX_PEXP_NPEI_MSI_ENB0);
-		en &= ~(1ull << (irq - OCTEON_IRQ_MSI_BIT0));
-		cvmx_write_csr(CVMX_PEXP_NPEI_MSI_ENB0, en);
-		cvmx_read_csr(CVMX_PEXP_NPEI_MSI_ENB0);
-		raw_spin_unlock_irqrestore(&octeon_irq_msi_lock, flags);
-	}
+	/* See comment in enable */
 }
 
-static struct irq_chip octeon_irq_chip_msi = {
+static struct irq_chip octeon_irq_chip_msi_pci = {
 	.name = "MSI",
-	.enable = octeon_irq_msi_enable,
-	.disable = octeon_irq_msi_disable,
+	.enable = octeon_irq_msi_enable_pci,
+	.disable = octeon_irq_msi_disable_pci,
 };
 
 /*
- * Initializes the MSI interrupt handling code
+ * Called by the interrupt handling code when an MSI interrupt
+ * occurs.
  */
-static int __init octeon_msi_initialize(void)
+static irqreturn_t __octeon_msi_do_interrupt(int index, u64 msi_bits)
 {
 	int irq;
+	int bit;
 
-	for (irq = OCTEON_IRQ_MSI_BIT0; irq <= OCTEON_IRQ_MSI_LAST; irq++) {
-		set_irq_chip_and_handler(irq, &octeon_irq_chip_msi, handle_simple_irq);
+	bit = fls64(msi_bits);
+	if (bit) {
+		bit--;
+		/* Acknowledge it first. */
+		cvmx_write_csr(msi_rcv_reg[index], 1ull << bit);
+
+		irq = bit + OCTEON_IRQ_MSI_BIT0 + 64 * index;
+		do_IRQ(irq);
+		return IRQ_HANDLED;
 	}
+	return IRQ_NONE;
+}
+
+#define OCTEON_MSI_INT_HANDLER_X(x)					\
+static irqreturn_t octeon_msi_interrupt##x(int cpl, void *dev_id)	\
+{									\
+	u64 msi_bits = cvmx_read_csr(msi_rcv_reg[(x)]);			\
+	return __octeon_msi_do_interrupt((x), msi_bits);		\
+}
+
+/*
+ * Create octeon_msi_interrupt{0-3} function body
+ */
+OCTEON_MSI_INT_HANDLER_X(0);
+OCTEON_MSI_INT_HANDLER_X(1);
+OCTEON_MSI_INT_HANDLER_X(2);
+OCTEON_MSI_INT_HANDLER_X(3);
+
+/*
+ * Initializes the MSI interrupt handling code
+ */
+int __init octeon_msi_initialize(void)
+{
+	int irq;
+	struct irq_chip *msi;
+
+	if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_PCIE) {
+		msi_rcv_reg[0] = CVMX_PEXP_NPEI_MSI_RCV0;
+		msi_rcv_reg[1] = CVMX_PEXP_NPEI_MSI_RCV1;
+		msi_rcv_reg[2] = CVMX_PEXP_NPEI_MSI_RCV2;
+		msi_rcv_reg[3] = CVMX_PEXP_NPEI_MSI_RCV3;
+		mis_ena_reg[0] = CVMX_PEXP_NPEI_MSI_ENB0;
+		mis_ena_reg[1] = CVMX_PEXP_NPEI_MSI_ENB1;
+		mis_ena_reg[2] = CVMX_PEXP_NPEI_MSI_ENB2;
+		mis_ena_reg[3] = CVMX_PEXP_NPEI_MSI_ENB3;
+		msi = &octeon_irq_chip_msi_pcie;
+	} else {
+		msi_rcv_reg[0] = CVMX_NPI_NPI_MSI_RCV;
+#define INVALID_GENERATE_ADE 0x8700000000000000ULL;
+		msi_rcv_reg[1] = INVALID_GENERATE_ADE;
+		msi_rcv_reg[2] = INVALID_GENERATE_ADE;
+		msi_rcv_reg[3] = INVALID_GENERATE_ADE;
+		mis_ena_reg[0] = INVALID_GENERATE_ADE;
+		mis_ena_reg[1] = INVALID_GENERATE_ADE;
+		mis_ena_reg[2] = INVALID_GENERATE_ADE;
+		mis_ena_reg[3] = INVALID_GENERATE_ADE;
+		msi = &octeon_irq_chip_msi_pci;
+	}
+
+	for (irq = OCTEON_IRQ_MSI_BIT0; irq <= OCTEON_IRQ_MSI_LAST; irq++)
+		set_irq_chip_and_handler(irq, msi, handle_simple_irq);
 
 	if (octeon_has_feature(OCTEON_FEATURE_PCIE)) {
-		if (request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt,
-				0, "MSI[0:63]", octeon_msi_interrupt))
+		if (request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt0,
+				0, "MSI[0:63]", octeon_msi_interrupt0))
 			panic("request_irq(OCTEON_IRQ_PCI_MSI0) failed");
+
+		if (request_irq(OCTEON_IRQ_PCI_MSI1, octeon_msi_interrupt1,
+				0, "MSI[64:127]", octeon_msi_interrupt1))
+			panic("request_irq(OCTEON_IRQ_PCI_MSI1) failed");
+
+		if (request_irq(OCTEON_IRQ_PCI_MSI2, octeon_msi_interrupt2,
+				0, "MSI[127:191]", octeon_msi_interrupt2))
+			panic("request_irq(OCTEON_IRQ_PCI_MSI2) failed");
+
+		if (request_irq(OCTEON_IRQ_PCI_MSI3, octeon_msi_interrupt3,
+				0, "MSI[192:255]", octeon_msi_interrupt3))
+			panic("request_irq(OCTEON_IRQ_PCI_MSI3) failed");
+
+		msi_irq_size = 256;
 	} else if (octeon_is_pci_host()) {
-		if (request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt,
-				0, "MSI[0:15]", octeon_msi_interrupt))
+		if (request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt0,
+				0, "MSI[0:15]", octeon_msi_interrupt0))
 			panic("request_irq(OCTEON_IRQ_PCI_MSI0) failed");
 
-		if (request_irq(OCTEON_IRQ_PCI_MSI1, octeon_msi_interrupt,
-				0, "MSI[16:31]", octeon_msi_interrupt))
+		if (request_irq(OCTEON_IRQ_PCI_MSI1, octeon_msi_interrupt0,
+				0, "MSI[16:31]", octeon_msi_interrupt0))
 			panic("request_irq(OCTEON_IRQ_PCI_MSI1) failed");
 
-		if (request_irq(OCTEON_IRQ_PCI_MSI2, octeon_msi_interrupt,
-				0, "MSI[32:47]", octeon_msi_interrupt))
+		if (request_irq(OCTEON_IRQ_PCI_MSI2, octeon_msi_interrupt0,
+				0, "MSI[32:47]", octeon_msi_interrupt0))
 			panic("request_irq(OCTEON_IRQ_PCI_MSI2) failed");
 
-		if (request_irq(OCTEON_IRQ_PCI_MSI3, octeon_msi_interrupt,
-				0, "MSI[48:63]", octeon_msi_interrupt))
+		if (request_irq(OCTEON_IRQ_PCI_MSI3, octeon_msi_interrupt0,
+				0, "MSI[48:63]", octeon_msi_interrupt0))
 			panic("request_irq(OCTEON_IRQ_PCI_MSI3) failed");
-
+		msi_irq_size = 64;
 	}
 	return 0;
 }
-- 
1.7.1.1
