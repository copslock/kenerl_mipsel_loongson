Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 23:05:39 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:56511 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20025306AbZCaWFd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Mar 2009 23:05:33 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49d293910002>; Tue, 31 Mar 2009 18:05:05 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 31 Mar 2009 15:04:45 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 31 Mar 2009 15:04:44 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n2VM4em2002610;
	Tue, 31 Mar 2009 15:04:40 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n2VM4d8a002609;
	Tue, 31 Mar 2009 15:04:39 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-ide@vger.kernel.org, jgarzik@redhat.com
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] libata: Remove some redundant casts from pata_octeon_cf.c
Date:	Tue, 31 Mar 2009 15:04:39 -0700
Message-Id: <1238537079-2584-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 31 Mar 2009 22:04:44.0860 (UTC) FILETIME=[B3161FC0:01C9B24C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

Please consider for 2.6.30.

 drivers/ata/pata_octeon_cf.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 0fe4ef3..0e71be1 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -503,7 +503,7 @@ static void octeon_cf_dma_setup(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	struct octeon_cf_port *cf_port;
 
-	cf_port = (struct octeon_cf_port *)ap->private_data;
+	cf_port = ap->private_data;
 	DPRINTK("ENTER\n");
 	/* issue r/w command */
 	qc->cursg = qc->sg;
@@ -596,7 +596,7 @@ static unsigned int octeon_cf_dma_finished(struct ata_port *ap,
 	if (ap->hsm_task_state != HSM_ST_LAST)
 		return 0;
 
-	cf_port = (struct octeon_cf_port *)ap->private_data;
+	cf_port = ap->private_data;
 
 	dma_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_DMA_CFGX(ocd->dma_engine));
 	if (dma_cfg.s.size != 0xfffff) {
@@ -657,7 +657,7 @@ static irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
 			continue;
 
 		ocd = ap->dev->platform_data;
-		cf_port = (struct octeon_cf_port *)ap->private_data;
+		cf_port = ap->private_data;
 		dma_int.u64 =
 			cvmx_read_csr(CVMX_MIO_BOOT_DMA_INTX(ocd->dma_engine));
 		dma_cfg.u64 =
-- 
1.6.0.6
