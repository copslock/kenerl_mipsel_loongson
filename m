Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2010 01:57:51 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11042 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492986Ab0AGA5r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2010 01:57:47 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b45317d0000>; Wed, 06 Jan 2010 16:57:35 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 6 Jan 2010 16:57:22 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 6 Jan 2010 16:57:22 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o070vISR009484;
        Wed, 6 Jan 2010 16:57:18 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o070vGFC009482;
        Wed, 6 Jan 2010 16:57:16 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/3] MIPS: Octeon: Fix EIO handling.
Date:   Wed,  6 Jan 2010 16:57:14 -0800
Message-Id: <1262825836-9457-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4B4530F3.1070701@caviumnetworks.com>
References: <4B4530F3.1070701@caviumnetworks.com>
X-OriginalArrivalTime: 07 Jan 2010 00:57:22.0558 (UTC) FILETIME=[5ED529E0:01CA8F34]
X-archive-position: 25523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 4572

If an interrupt handler disables interrupts, the EOI function will
just reenable them.  This will put us in an endless loop when the
upcoming Ethernet driver patches are applied.

Only reenable the interrupt on EOI if it is not IRQ_DISABLED.  This
requires that the EIO function be separate from the ENABLE function.
We also rename the ACK functions to correspond with their function.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |   40 ++++++++++++++++++++++++++++-----
 1 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 6f2acf0..1460d08 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -193,7 +193,7 @@ static void octeon_irq_ciu0_enable_v2(unsigned int irq)
  * Disable the irq on the current core for chips that have the EN*_W1{S,C}
  * registers.
  */
-static void octeon_irq_ciu0_disable_v2(unsigned int irq)
+static void octeon_irq_ciu0_ack_v2(unsigned int irq)
 {
 	int index = cvmx_get_core_num() * 2;
 	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
@@ -202,6 +202,20 @@ static void octeon_irq_ciu0_disable_v2(unsigned int irq)
 }
 
 /*
+ * Enable the irq on the current core for chips that have the EN*_W1{S,C}
+ * registers.
+ */
+static void octeon_irq_ciu0_eoi_v2(unsigned int irq)
+{
+	struct irq_desc *desc = irq_desc + irq;
+	int index = cvmx_get_core_num() * 2;
+	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
+
+	if ((desc->status & IRQ_DISABLED) == 0)
+		cvmx_write_csr(CVMX_CIU_INTX_EN0_W1S(index), mask);
+}
+
+/*
  * Disable the irq on the all cores for chips that have the EN*_W1{S,C}
  * registers.
  */
@@ -272,8 +286,8 @@ static struct irq_chip octeon_irq_chip_ciu0_v2 = {
 	.name = "CIU0",
 	.enable = octeon_irq_ciu0_enable_v2,
 	.disable = octeon_irq_ciu0_disable_all_v2,
-	.ack = octeon_irq_ciu0_disable_v2,
-	.eoi = octeon_irq_ciu0_enable_v2,
+	.ack = octeon_irq_ciu0_ack_v2,
+	.eoi = octeon_irq_ciu0_eoi_v2,
 #ifdef CONFIG_SMP
 	.set_affinity = octeon_irq_ciu0_set_affinity_v2,
 #endif
@@ -374,7 +388,7 @@ static void octeon_irq_ciu1_enable_v2(unsigned int irq)
  * Disable the irq on the current core for chips that have the EN*_W1{S,C}
  * registers.
  */
-static void octeon_irq_ciu1_disable_v2(unsigned int irq)
+static void octeon_irq_ciu1_ack_v2(unsigned int irq)
 {
 	int index = cvmx_get_core_num() * 2 + 1;
 	u64 mask = 1ull << (irq - OCTEON_IRQ_WDOG0);
@@ -383,6 +397,20 @@ static void octeon_irq_ciu1_disable_v2(unsigned int irq)
 }
 
 /*
+ * Enable the irq on the current core for chips that have the EN*_W1{S,C}
+ * registers.
+ */
+static void octeon_irq_ciu1_eoi_v2(unsigned int irq)
+{
+	struct irq_desc *desc = irq_desc + irq;
+	int index = cvmx_get_core_num() * 2 + 1;
+	u64 mask = 1ull << (irq - OCTEON_IRQ_WDOG0);
+
+	if ((desc->status & IRQ_DISABLED) == 0)
+		cvmx_write_csr(CVMX_CIU_INTX_EN1_W1S(index), mask);
+}
+
+/*
  * Disable the irq on the all cores for chips that have the EN*_W1{S,C}
  * registers.
  */
@@ -455,8 +483,8 @@ static struct irq_chip octeon_irq_chip_ciu1_v2 = {
 	.name = "CIU0",
 	.enable = octeon_irq_ciu1_enable_v2,
 	.disable = octeon_irq_ciu1_disable_all_v2,
-	.ack = octeon_irq_ciu1_disable_v2,
-	.eoi = octeon_irq_ciu1_enable_v2,
+	.ack = octeon_irq_ciu1_ack_v2,
+	.eoi = octeon_irq_ciu1_eoi_v2,
 #ifdef CONFIG_SMP
 	.set_affinity = octeon_irq_ciu1_set_affinity_v2,
 #endif
-- 
1.6.0.6
