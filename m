Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2010 19:44:12 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9760 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492039Ab0GWRoD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jul 2010 19:44:03 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c49d4fc0001>; Fri, 23 Jul 2010 10:44:28 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:44:01 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:44:01 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6NHhuPx024113;
        Fri, 23 Jul 2010 10:43:56 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6NHhuIb024112;
        Fri, 23 Jul 2010 10:43:56 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/5] MIPS: Octeon: Move MSI code out of octeon-irq.c.
Date:   Fri, 23 Jul 2010 10:43:45 -0700
Message-Id: <1279907029-24071-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279907029-24071-1-git-send-email-ddaney@caviumnetworks.com>
References: <1279907029-24071-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 23 Jul 2010 17:44:01.0097 (UTC) FILETIME=[A28B9390:01CB2A8E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Put all the MSI code in one place (msi-octeon.c).  This simplifies
octeon-irq.c and gets rid of some ugly #ifdefs

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |   93 ----------------------------------
 arch/mips/pci/msi-octeon.c           |   90 ++++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 95 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index c424cd1..f4b901a 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -10,8 +10,6 @@
 #include <linux/smp.h>
 
 #include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-pexp-defs.h>
-#include <asm/octeon/cvmx-npi-defs.h>
 
 static DEFINE_RAW_SPINLOCK(octeon_irq_ciu0_lock);
 static DEFINE_RAW_SPINLOCK(octeon_irq_ciu1_lock);
@@ -528,90 +526,6 @@ static struct irq_chip octeon_irq_chip_ciu1 = {
 #endif
 };
 
-#ifdef CONFIG_PCI_MSI
-
-static DEFINE_RAW_SPINLOCK(octeon_irq_msi_lock);
-
-static void octeon_irq_msi_ack(unsigned int irq)
-{
-	if (!octeon_has_feature(OCTEON_FEATURE_PCIE)) {
-		/* These chips have PCI */
-		cvmx_write_csr(CVMX_NPI_NPI_MSI_RCV,
-			       1ull << (irq - OCTEON_IRQ_MSI_BIT0));
-	} else {
-		/*
-		 * These chips have PCIe. Thankfully the ACK doesn't
-		 * need any locking.
-		 */
-		cvmx_write_csr(CVMX_PEXP_NPEI_MSI_RCV0,
-			       1ull << (irq - OCTEON_IRQ_MSI_BIT0));
-	}
-}
-
-static void octeon_irq_msi_eoi(unsigned int irq)
-{
-	/* Nothing needed */
-}
-
-static void octeon_irq_msi_enable(unsigned int irq)
-{
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
-}
-
-static void octeon_irq_msi_disable(unsigned int irq)
-{
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
-}
-
-static struct irq_chip octeon_irq_chip_msi = {
-	.name = "MSI",
-	.enable = octeon_irq_msi_enable,
-	.disable = octeon_irq_msi_disable,
-	.ack = octeon_irq_msi_ack,
-	.eoi = octeon_irq_msi_eoi,
-};
-#endif
-
 void __init arch_init_irq(void)
 {
 	int irq;
@@ -672,13 +586,6 @@ void __init arch_init_irq(void)
 		set_irq_chip_and_handler(irq, chip1, handle_percpu_irq);
 	}
 
-#ifdef CONFIG_PCI_MSI
-	/* 152 - 215 PCI/PCIe MSI interrupts */
-	for (irq = OCTEON_IRQ_MSI_BIT0; irq <= OCTEON_IRQ_MSI_BIT63; irq++) {
-		set_irq_chip_and_handler(irq, &octeon_irq_chip_msi,
-					 handle_percpu_irq);
-	}
-#endif
 	set_c0_status(0x300 << 2);
 }
 
diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
index 03742e6..1e31526 100644
--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -249,12 +249,99 @@ static irqreturn_t octeon_msi_interrupt(int cpl, void *dev_id)
 	return IRQ_NONE;
 }
 
+static DEFINE_RAW_SPINLOCK(octeon_irq_msi_lock);
+
+static void octeon_irq_msi_ack(unsigned int irq)
+{
+	if (!octeon_has_feature(OCTEON_FEATURE_PCIE)) {
+		/* These chips have PCI */
+		cvmx_write_csr(CVMX_NPI_NPI_MSI_RCV,
+			       1ull << (irq - OCTEON_IRQ_MSI_BIT0));
+	} else {
+		/*
+		 * These chips have PCIe. Thankfully the ACK doesn't
+		 * need any locking.
+		 */
+		cvmx_write_csr(CVMX_PEXP_NPEI_MSI_RCV0,
+			       1ull << (irq - OCTEON_IRQ_MSI_BIT0));
+	}
+}
+
+static void octeon_irq_msi_eoi(unsigned int irq)
+{
+	/* Nothing needed */
+}
+
+static void octeon_irq_msi_enable(unsigned int irq)
+{
+	if (!octeon_has_feature(OCTEON_FEATURE_PCIE)) {
+		/*
+		 * Octeon PCI doesn't have the ability to mask/unmask
+		 * MSI interrupts individually.  Instead of
+		 * masking/unmasking them in groups of 16, we simple
+		 * assume MSI devices are well behaved.  MSI
+		 * interrupts are always enable and the ACK is assumed
+		 * to be enough.
+		 */
+	} else {
+		/* These chips have PCIe.  Note that we only support
+		 * the first 64 MSI interrupts.  Unfortunately all the
+		 * MSI enables are in the same register.  We use
+		 * MSI0's lock to control access to them all.
+		 */
+		uint64_t en;
+		unsigned long flags;
+		raw_spin_lock_irqsave(&octeon_irq_msi_lock, flags);
+		en = cvmx_read_csr(CVMX_PEXP_NPEI_MSI_ENB0);
+		en |= 1ull << (irq - OCTEON_IRQ_MSI_BIT0);
+		cvmx_write_csr(CVMX_PEXP_NPEI_MSI_ENB0, en);
+		cvmx_read_csr(CVMX_PEXP_NPEI_MSI_ENB0);
+		raw_spin_unlock_irqrestore(&octeon_irq_msi_lock, flags);
+	}
+}
+
+static void octeon_irq_msi_disable(unsigned int irq)
+{
+	if (!octeon_has_feature(OCTEON_FEATURE_PCIE)) {
+		/* See comment in enable */
+	} else {
+		/*
+		 * These chips have PCIe.  Note that we only support
+		 * the first 64 MSI interrupts.  Unfortunately all the
+		 * MSI enables are in the same register.  We use
+		 * MSI0's lock to control access to them all.
+		 */
+		uint64_t en;
+		unsigned long flags;
+		raw_spin_lock_irqsave(&octeon_irq_msi_lock, flags);
+		en = cvmx_read_csr(CVMX_PEXP_NPEI_MSI_ENB0);
+		en &= ~(1ull << (irq - OCTEON_IRQ_MSI_BIT0));
+		cvmx_write_csr(CVMX_PEXP_NPEI_MSI_ENB0, en);
+		cvmx_read_csr(CVMX_PEXP_NPEI_MSI_ENB0);
+		raw_spin_unlock_irqrestore(&octeon_irq_msi_lock, flags);
+	}
+}
+
+static struct irq_chip octeon_irq_chip_msi = {
+	.name = "MSI",
+	.enable = octeon_irq_msi_enable,
+	.disable = octeon_irq_msi_disable,
+	.ack = octeon_irq_msi_ack,
+	.eoi = octeon_irq_msi_eoi,
+};
 
 /*
  * Initializes the MSI interrupt handling code
  */
-int octeon_msi_initialize(void)
+static int __init octeon_msi_initialize(void)
 {
+	int irq;
+
+	for (irq = OCTEON_IRQ_MSI_BIT0; irq <= OCTEON_IRQ_MSI_BIT63; irq++) {
+		set_irq_chip_and_handler(irq, &octeon_irq_chip_msi,
+					 handle_percpu_irq);
+	}
+
 	if (octeon_has_feature(OCTEON_FEATURE_PCIE)) {
 		if (request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt,
 				IRQF_SHARED,
@@ -284,5 +371,4 @@ int octeon_msi_initialize(void)
 	}
 	return 0;
 }
-
 subsys_initcall(octeon_msi_initialize);
-- 
1.7.1.1
