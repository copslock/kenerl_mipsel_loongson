Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2008 14:33:08 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:57583 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S24207579AbYLYOcp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2008 14:32:45 +0000
Received: from localhost.localdomain (p5019-ipad204funabasi.chiba.ocn.ne.jp [222.146.92.19])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 641A7A4DC; Thu, 25 Dec 2008 23:32:39 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-ide@vger.kernel.org
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org,
	stable <stable@kernel.org>
Subject: [PATCH] tx493[89]ide: Fix length for __ide_flush_dcache_range
Date:	Thu, 25 Dec 2008 23:32:38 +0900
Message-Id: <1230215558-9197-2-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This fixes data corruption on PIO mode.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: stable <stable@kernel.org>
---
 drivers/ide/tx4938ide.c |    4 ++--
 drivers/ide/tx4939ide.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
index 9120063..13b63e7 100644
--- a/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -181,7 +181,7 @@ static void tx4938ide_input_data_swap(ide_drive_t *drive, struct request *rq,
 
 	while (count--)
 		*ptr++ = cpu_to_le16(__raw_readw((void __iomem *)port));
-	__ide_flush_dcache_range((unsigned long)buf, count * 2);
+	__ide_flush_dcache_range((unsigned long)buf, roundup(len, 2));
 }
 
 static void tx4938ide_output_data_swap(ide_drive_t *drive, struct request *rq,
@@ -195,7 +195,7 @@ static void tx4938ide_output_data_swap(ide_drive_t *drive, struct request *rq,
 		__raw_writew(le16_to_cpu(*ptr), (void __iomem *)port);
 		ptr++;
 	}
-	__ide_flush_dcache_range((unsigned long)buf, count * 2);
+	__ide_flush_dcache_range((unsigned long)buf, roundup(len, 2));
 }
 
 static const struct ide_tp_ops tx4938ide_tp_ops = {
diff --git a/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
index 30d0d25..97cd9e0 100644
--- a/drivers/ide/tx4939ide.c
+++ b/drivers/ide/tx4939ide.c
@@ -564,7 +564,7 @@ static void tx4939ide_input_data_swap(ide_drive_t *drive, struct request *rq,
 
 	while (count--)
 		*ptr++ = cpu_to_le16(__raw_readw((void __iomem *)port));
-	__ide_flush_dcache_range((unsigned long)buf, count * 2);
+	__ide_flush_dcache_range((unsigned long)buf, roundup(len, 2));
 }
 
 static void tx4939ide_output_data_swap(ide_drive_t *drive, struct request *rq,
@@ -578,7 +578,7 @@ static void tx4939ide_output_data_swap(ide_drive_t *drive, struct request *rq,
 		__raw_writew(le16_to_cpu(*ptr), (void __iomem *)port);
 		ptr++;
 	}
-	__ide_flush_dcache_range((unsigned long)buf, count * 2);
+	__ide_flush_dcache_range((unsigned long)buf, roundup(len, 2));
 }
 
 static const struct ide_tp_ops tx4939ide_tp_ops = {
-- 
1.5.6.3
