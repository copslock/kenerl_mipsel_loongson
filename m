Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 12:23:24 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:2763 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010442AbbAGLV1o9pY7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 12:21:27 +0100
X-IronPort-AV: E=Sophos;i="5.07,714,1413270000"; 
   d="scan'208";a="54466608"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw1-out.broadcom.com with ESMTP; 07 Jan 2015 05:25:22 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 7 Jan 2015 03:21:26 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Wed, 7 Jan 2015 03:21:41 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 E13F540FE8;    Wed,  7 Jan 2015 03:20:38 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 07/17] MIPS: MSI: Update MSI handling for XLP
Date:   Wed, 7 Jan 2015 16:58:28 +0530
Message-ID: <1420630118-17198-8-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
References: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44991
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

The per-cpu interrupt ACK using EIRR has to be done just once after
all the bits in the status register are processed.

PIC ack has to be done once in case of MSI, and for every interrupt
in case of MSI-X

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/pci/msi-xlp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/mips/pci/msi-xlp.c b/arch/mips/pci/msi-xlp.c
index 6a40f24..3407495 100644
--- a/arch/mips/pci/msi-xlp.c
+++ b/arch/mips/pci/msi-xlp.c
@@ -178,13 +178,6 @@ static void xlp_msi_mask_ack(struct irq_data *d)
 	else
 		nlm_write_reg(md->lnkbase, PCIE_MSI_STATUS, 1u << vec);
 
-	/* Ack at eirr and PIC */
-	ack_c0_eirr(PIC_PCIE_LINK_MSI_IRQ(link));
-	if (cpu_is_xlp9xx())
-		nlm_pic_ack(md->node->picbase,
-				PIC_9XX_IRT_PCIE_LINK_INDEX(link));
-	else
-		nlm_pic_ack(md->node->picbase, PIC_IRT_PCIE_LINK_INDEX(link));
 }
 
 static struct irq_chip xlp_msi_chip = {
@@ -230,8 +223,6 @@ static void xlp_msix_mask_ack(struct irq_data *d)
 	}
 	nlm_write_reg(md->lnkbase, status_reg, 1u << bit);
 
-	/* Ack at eirr and PIC */
-	ack_c0_eirr(PIC_PCIE_MSIX_IRQ(link));
 	if (!cpu_is_xlp9xx())
 		nlm_pic_ack(md->node->picbase,
 				PIC_IRT_PCIE_MSIX_INDEX(msixvec));
@@ -541,6 +532,14 @@ void nlm_dispatch_msi(int node, int lirq)
 		do_IRQ(irqbase + i);
 		status &= status - 1;
 	}
+
+	/* Ack at eirr and PIC */
+	ack_c0_eirr(PIC_PCIE_LINK_MSI_IRQ(link));
+	if (cpu_is_xlp9xx())
+		nlm_pic_ack(md->node->picbase,
+				PIC_9XX_IRT_PCIE_LINK_INDEX(link));
+	else
+		nlm_pic_ack(md->node->picbase, PIC_IRT_PCIE_LINK_INDEX(link));
 }
 
 void nlm_dispatch_msix(int node, int lirq)
@@ -567,4 +566,6 @@ void nlm_dispatch_msix(int node, int lirq)
 		do_IRQ(irqbase + i);
 		status &= status - 1;
 	}
+	/* Ack at eirr and PIC */
+	ack_c0_eirr(PIC_PCIE_MSIX_IRQ(link));
 }
-- 
1.9.1
