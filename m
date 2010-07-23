Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2010 19:46:23 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9764 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492570Ab0GWRoG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jul 2010 19:44:06 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c49d5000000>; Fri, 23 Jul 2010 10:44:32 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:44:04 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:44:04 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6NHhxRG024129;
        Fri, 23 Jul 2010 10:43:59 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6NHhx33024128;
        Fri, 23 Jul 2010 10:43:59 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 5/5] MIPS: Octeon: Make MSI use handle_simple_irq().
Date:   Fri, 23 Jul 2010 10:43:49 -0700
Message-Id: <1279907029-24071-6-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279907029-24071-1-git-send-email-ddaney@caviumnetworks.com>
References: <1279907029-24071-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 23 Jul 2010 17:44:04.0706 (UTC) FILETIME=[A4B24420:01CB2A8E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The use of handle_percpu_irq() is not really what we want for MSI, use
handle_simple_irq() instead.  This is probably the prototypical case
for using handle_simple_irq(), because all the MSIs are dispatched from
the root interrupt service routine.

Also since the base IRQ is not shared, don't pass IRQF_SHARED.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/pci/msi-octeon.c |   61 +++++++++++---------------------------------
 1 files changed, 15 insertions(+), 46 deletions(-)

diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
index 5ce1a6a..83ceb52 100644
--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -228,22 +228,20 @@ static irqreturn_t octeon_msi_interrupt(int cpl, void *dev_id)
 	irq = fls64(msi_bits);
 	if (irq) {
 		irq += OCTEON_IRQ_MSI_BIT0 - 1;
+		if (octeon_has_feature(OCTEON_FEATURE_PCIE)) {
+			/* These chips have PCIe */
+			cvmx_write_csr(CVMX_PEXP_NPEI_MSI_RCV0,
+				       1ull << (irq - OCTEON_IRQ_MSI_BIT0));
+		} else {
+			/* These chips have PCI */
+			cvmx_write_csr(CVMX_NPI_NPI_MSI_RCV,
+				       1ull << (irq - OCTEON_IRQ_MSI_BIT0));
+		}
 		if (irq_desc[irq].action) {
 			do_IRQ(irq);
 			return IRQ_HANDLED;
 		} else {
 			pr_err("Spurious MSI interrupt %d\n", irq);
-			if (octeon_has_feature(OCTEON_FEATURE_PCIE)) {
-				/* These chips have PCIe */
-				cvmx_write_csr(CVMX_PEXP_NPEI_MSI_RCV0,
-					       1ull << (irq -
-							OCTEON_IRQ_MSI_BIT0));
-			} else {
-				/* These chips have PCI */
-				cvmx_write_csr(CVMX_NPI_NPI_MSI_RCV,
-					       1ull << (irq -
-							OCTEON_IRQ_MSI_BIT0));
-			}
 		}
 	}
 	return IRQ_NONE;
@@ -251,27 +249,6 @@ static irqreturn_t octeon_msi_interrupt(int cpl, void *dev_id)
 
 static DEFINE_RAW_SPINLOCK(octeon_irq_msi_lock);
 
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
 static void octeon_irq_msi_enable(unsigned int irq)
 {
 	if (!octeon_has_feature(OCTEON_FEATURE_PCIE)) {
@@ -326,8 +303,6 @@ static struct irq_chip octeon_irq_chip_msi = {
 	.name = "MSI",
 	.enable = octeon_irq_msi_enable,
 	.disable = octeon_irq_msi_disable,
-	.ack = octeon_irq_msi_ack,
-	.eoi = octeon_irq_msi_eoi,
 };
 
 /*
@@ -338,34 +313,28 @@ static int __init octeon_msi_initialize(void)
 	int irq;
 
 	for (irq = OCTEON_IRQ_MSI_BIT0; irq <= OCTEON_IRQ_MSI_LAST; irq++) {
-		set_irq_chip_and_handler(irq, &octeon_irq_chip_msi,
-					 handle_percpu_irq);
+		set_irq_chip_and_handler(irq, &octeon_irq_chip_msi, handle_simple_irq);
 	}
 
 	if (octeon_has_feature(OCTEON_FEATURE_PCIE)) {
 		if (request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt,
-				IRQF_SHARED,
-				"MSI[0:63]", octeon_msi_interrupt))
+				0, "MSI[0:63]", octeon_msi_interrupt))
 			panic("request_irq(OCTEON_IRQ_PCI_MSI0) failed");
 	} else if (octeon_is_pci_host()) {
 		if (request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt,
-				IRQF_SHARED,
-				"MSI[0:15]", octeon_msi_interrupt))
+				0, "MSI[0:15]", octeon_msi_interrupt))
 			panic("request_irq(OCTEON_IRQ_PCI_MSI0) failed");
 
 		if (request_irq(OCTEON_IRQ_PCI_MSI1, octeon_msi_interrupt,
-				IRQF_SHARED,
-				"MSI[16:31]", octeon_msi_interrupt))
+				0, "MSI[16:31]", octeon_msi_interrupt))
 			panic("request_irq(OCTEON_IRQ_PCI_MSI1) failed");
 
 		if (request_irq(OCTEON_IRQ_PCI_MSI2, octeon_msi_interrupt,
-				IRQF_SHARED,
-				"MSI[32:47]", octeon_msi_interrupt))
+				0, "MSI[32:47]", octeon_msi_interrupt))
 			panic("request_irq(OCTEON_IRQ_PCI_MSI2) failed");
 
 		if (request_irq(OCTEON_IRQ_PCI_MSI3, octeon_msi_interrupt,
-				IRQF_SHARED,
-				"MSI[48:63]", octeon_msi_interrupt))
+				0, "MSI[48:63]", octeon_msi_interrupt))
 			panic("request_irq(OCTEON_IRQ_PCI_MSI3) failed");
 
 	}
-- 
1.7.1.1
