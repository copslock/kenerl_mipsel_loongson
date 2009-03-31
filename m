Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 17:15:49 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:7372 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023836AbZCaQPl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2009 17:15:41 +0100
Received: from localhost.localdomain (p6205-ipad211funabasi.chiba.ocn.ne.jp [58.91.162.205])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2B80DA9E6; Wed,  1 Apr 2009 01:15:34 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	Grant Grundler <grundler@google.com>
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tx4939ide: remove wmb()
Date:	Wed,  1 Apr 2009 01:15:36 +0900
Message-Id: <1238516136-15852-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* define CHECK_DMA_MASK
* remove use of wmb()

Suggested-by: Grant Grundler <grundler@google.com>
Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch is against linux-next 20090331.

 drivers/ide/tx4939ide.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
index cc269c0..48186ae 100644
--- a/drivers/ide/tx4939ide.c
+++ b/drivers/ide/tx4939ide.c
@@ -327,15 +327,15 @@ static int tx4939ide_dma_end(ide_drive_t *drive)
 	/* read and clear the INTR & ERROR bits */
 	dma_stat = tx4939ide_clear_dma_status(base);
 
-	wmb();
+#define CHECK_DMA_MASK (ATA_DMA_ACTIVE | ATA_DMA_ERR | ATA_DMA_INTR)
 
 	/* verify good DMA status */
-	if ((dma_stat & (ATA_DMA_INTR | ATA_DMA_ERR | ATA_DMA_ACTIVE)) == 0 &&
+	if ((dma_stat & CHECK_DMA_MASK) == 0 &&
 	    (ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST)) ==
 	    (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST))
 		/* INT_IDE lost... bug? */
 		return 0;
-	return ((dma_stat & (ATA_DMA_INTR | ATA_DMA_ERR | ATA_DMA_ACTIVE)) !=
+	return ((dma_stat & CHECK_DMA_MASK) !=
 		ATA_DMA_INTR) ? 0x10 | dma_stat : 0;
 }
 
-- 
1.5.6.3
