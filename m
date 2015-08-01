Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Aug 2015 14:03:58 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:21695 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010778AbbHAMDlSDW9t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Aug 2015 14:03:41 +0200
X-IronPort-AV: E=Sophos;i="5.15,591,1432623600"; 
   d="scan'208";a="71459046"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw1-out.broadcom.com with ESMTP; 01 Aug 2015 06:19:16 -0700
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.235.1; Sat, 1 Aug 2015 05:03:34 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.235.1; Sat, 1 Aug 2015 05:03:33 -0700
Received: from netl-snoppy.ban.broadcom.com (unknown [10.132.128.129])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id E1E9140FE6;  Sat,  1 Aug
 2015 05:01:17 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Kamlakant Patel <kamlakant.patel@broadcom.com>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 1/4] MIPS: Netlogic: Use chip_data for irq_chip methods
Date:   Sat, 1 Aug 2015 17:44:20 +0530
Message-ID: <1438431263-12427-2-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1438431263-12427-1-git-send-email-jchandra@broadcom.com>
References: <1438431263-12427-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48522
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

From: Kamlakant Patel <kamlakant.patel@broadcom.com>

Update mips/netlogic/common/irq.c and mips/pci/msi-xlp.c to use chip_data
to store interrupt controller data pointer. It uses handler_data now,
and that causes errors when an API (like the GPIO subsystem) tries to
use the handler data.

Signed-off-by: Kamlakant Patel <kamlakant.patel@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/common/irq.c | 12 ++++++------
 arch/mips/pci/msi-xlp.c         | 20 ++++++++++----------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index 5f5d18b..3660dc6 100644
--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -87,7 +87,7 @@ struct nlm_pic_irq {
 static void xlp_pic_enable(struct irq_data *d)
 {
 	unsigned long flags;
-	struct nlm_pic_irq *pd = irq_data_get_irq_handler_data(d);
+	struct nlm_pic_irq *pd = irq_data_get_irq_chip_data(d);
 
 	BUG_ON(!pd);
 	spin_lock_irqsave(&pd->node->piclock, flags);
@@ -97,7 +97,7 @@ static void xlp_pic_enable(struct irq_data *d)
 
 static void xlp_pic_disable(struct irq_data *d)
 {
-	struct nlm_pic_irq *pd = irq_data_get_irq_handler_data(d);
+	struct nlm_pic_irq *pd = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 
 	BUG_ON(!pd);
@@ -108,7 +108,7 @@ static void xlp_pic_disable(struct irq_data *d)
 
 static void xlp_pic_mask_ack(struct irq_data *d)
 {
-	struct nlm_pic_irq *pd = irq_data_get_irq_handler_data(d);
+	struct nlm_pic_irq *pd = irq_data_get_irq_chip_data(d);
 
 	clear_c0_eimr(pd->picirq);
 	ack_c0_eirr(pd->picirq);
@@ -116,7 +116,7 @@ static void xlp_pic_mask_ack(struct irq_data *d)
 
 static void xlp_pic_unmask(struct irq_data *d)
 {
-	struct nlm_pic_irq *pd = irq_data_get_irq_handler_data(d);
+	struct nlm_pic_irq *pd = irq_data_get_irq_chip_data(d);
 
 	BUG_ON(!pd);
 
@@ -193,7 +193,7 @@ void nlm_setup_pic_irq(int node, int picirq, int irq, int irt)
 	pic_data->picirq = picirq;
 	pic_data->node = nlm_get_node(node);
 	irq_set_chip_and_handler(xirq, &xlp_pic, handle_level_irq);
-	irq_set_handler_data(xirq, pic_data);
+	irq_set_chip_data(xirq, pic_data);
 }
 
 void nlm_set_pic_extra_ack(int node, int irq, void (*xack)(struct irq_data *))
@@ -202,7 +202,7 @@ void nlm_set_pic_extra_ack(int node, int irq, void (*xack)(struct irq_data *))
 	int xirq;
 
 	xirq = nlm_irq_to_xirq(node, irq);
-	pic_data = irq_get_handler_data(xirq);
+	pic_data = irq_get_chip_data(xirq);
 	if (WARN_ON(!pic_data))
 		return;
 	pic_data->extra_ack = xack;
diff --git a/arch/mips/pci/msi-xlp.c b/arch/mips/pci/msi-xlp.c
index 3407495..bb14335 100644
--- a/arch/mips/pci/msi-xlp.c
+++ b/arch/mips/pci/msi-xlp.c
@@ -131,7 +131,7 @@ struct xlp_msi_data {
  */
 static void xlp_msi_enable(struct irq_data *d)
 {
-	struct xlp_msi_data *md = irq_data_get_irq_handler_data(d);
+	struct xlp_msi_data *md = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 	int vec;
 
@@ -148,7 +148,7 @@ static void xlp_msi_enable(struct irq_data *d)
 
 static void xlp_msi_disable(struct irq_data *d)
 {
-	struct xlp_msi_data *md = irq_data_get_irq_handler_data(d);
+	struct xlp_msi_data *md = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 	int vec;
 
@@ -165,7 +165,7 @@ static void xlp_msi_disable(struct irq_data *d)
 
 static void xlp_msi_mask_ack(struct irq_data *d)
 {
-	struct xlp_msi_data *md = irq_data_get_irq_handler_data(d);
+	struct xlp_msi_data *md = irq_data_get_irq_chip_data(d);
 	int link, vec;
 
 	link = nlm_irq_msilink(d->irq);
@@ -211,7 +211,7 @@ static void xlp_msix_mask_ack(struct irq_data *d)
 	msixvec = nlm_irq_msixvec(d->irq);
 	link = nlm_irq_msixlink(msixvec);
 	pci_msi_mask_irq(d);
-	md = irq_data_get_irq_handler_data(d);
+	md = irq_data_get_irq_chip_data(d);
 
 	/* Ack MSI on bridge */
 	if (cpu_is_xlp9xx()) {
@@ -302,7 +302,7 @@ static int xlp_setup_msi(uint64_t lnkbase, int node, int link,
 	/* Get MSI data for the link */
 	lirq = PIC_PCIE_LINK_MSI_IRQ(link);
 	xirq = nlm_irq_to_xirq(node, nlm_link_msiirq(link, 0));
-	md = irq_get_handler_data(xirq);
+	md = irq_get_chip_data(xirq);
 	msiaddr = MSI_LINK_ADDR(node, link);
 
 	spin_lock_irqsave(&md->msi_lock, flags);
@@ -409,7 +409,7 @@ static int xlp_setup_msix(uint64_t lnkbase, int node, int link,
 	/* Get MSI data for the link */
 	lirq = PIC_PCIE_MSIX_IRQ(link);
 	xirq = nlm_irq_to_xirq(node, nlm_link_msixirq(link, 0));
-	md = irq_get_handler_data(xirq);
+	md = irq_get_chip_data(xirq);
 	msixaddr = MSIX_LINK_ADDR(node, link);
 
 	spin_lock_irqsave(&md->msi_lock, flags);
@@ -485,7 +485,7 @@ void __init xlp_init_node_msi_irqs(int node, int link)
 	irq = nlm_irq_to_xirq(node, nlm_link_msiirq(link, 0));
 	for (i = irq; i < irq + XLP_MSIVEC_PER_LINK; i++) {
 		irq_set_chip_and_handler(i, &xlp_msi_chip, handle_level_irq);
-		irq_set_handler_data(i, md);
+		irq_set_chip_data(i, md);
 	}
 
 	for (i = 0; i < XLP_MSIXVEC_PER_LINK ; i++) {
@@ -508,7 +508,7 @@ void __init xlp_init_node_msi_irqs(int node, int link)
 		/* Initialize MSI-X extended irq space for the link  */
 		irq = nlm_irq_to_xirq(node, nlm_link_msixirq(link, i));
 		irq_set_chip_and_handler(irq, &xlp_msix_chip, handle_level_irq);
-		irq_set_handler_data(irq, md);
+		irq_set_chip_data(irq, md);
 	}
 }
 
@@ -520,7 +520,7 @@ void nlm_dispatch_msi(int node, int lirq)
 
 	link = lirq - PIC_PCIE_LINK_MSI_IRQ_BASE;
 	irqbase = nlm_irq_to_xirq(node, nlm_link_msiirq(link, 0));
-	md = irq_get_handler_data(irqbase);
+	md = irq_get_chip_data(irqbase);
 	if (cpu_is_xlp9xx())
 		status = nlm_read_reg(md->lnkbase, PCIE_9XX_MSI_STATUS) &
 						md->msi_enabled_mask;
@@ -550,7 +550,7 @@ void nlm_dispatch_msix(int node, int lirq)
 
 	link = lirq - PIC_PCIE_MSIX_IRQ_BASE;
 	irqbase = nlm_irq_to_xirq(node, nlm_link_msixirq(link, 0));
-	md = irq_get_handler_data(irqbase);
+	md = irq_get_chip_data(irqbase);
 	if (cpu_is_xlp9xx())
 		status = nlm_read_reg(md->lnkbase, PCIE_9XX_MSIX_STATUSX(link));
 	else
-- 
1.9.1
