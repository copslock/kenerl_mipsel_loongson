Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2008 01:44:30 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:25936 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207521AbYLIBng (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Dec 2008 01:43:36 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B493dcd300004>; Mon, 08 Dec 2008 20:43:12 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Dec 2008 17:40:03 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Dec 2008 17:40:03 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mB91dxt3020392;
	Mon, 8 Dec 2008 17:40:00 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mB91dxPU020391;
	Mon, 8 Dec 2008 17:39:59 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-ide@vger.kernel.org
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/3] libata: Add two more columns to the ata_timing table.
Date:	Mon,  8 Dec 2008 17:39:56 -0800
Message-Id: <1228786798-20369-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <493DCBEA.9090007@caviumnetworks.com>
References: <493DCBEA.9090007@caviumnetworks.com>
X-OriginalArrivalTime: 09 Dec 2008 01:40:03.0632 (UTC) FILETIME=[0E988B00:01C9599F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The forthcoming OCTEON SOC Compact Flash driver needs a few more
timing values than were available in the ata_timing table.  I add new
columns for write_hold and dmack_hold times.  The values were obtained
from the Compact Flash specification Rev 4.1.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/ata/libata-core.c |   74 +++++++++++++++++++++++---------------------
 include/linux/libata.h    |   12 +++++--
 2 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5e2eb74..b156d83 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2953,33 +2953,33 @@ int sata_set_spd(struct ata_link *link)
  */
 
 static const struct ata_timing ata_timing[] = {
-/*	{ XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 960,   0 }, */
-	{ XFER_PIO_0,     70, 290, 240, 600, 165, 150, 600,   0 },
-	{ XFER_PIO_1,     50, 290,  93, 383, 125, 100, 383,   0 },
-	{ XFER_PIO_2,     30, 290,  40, 330, 100,  90, 240,   0 },
-	{ XFER_PIO_3,     30,  80,  70, 180,  80,  70, 180,   0 },
-	{ XFER_PIO_4,     25,  70,  25, 120,  70,  25, 120,   0 },
-	{ XFER_PIO_5,     15,  65,  25, 100,  65,  25, 100,   0 },
-	{ XFER_PIO_6,     10,  55,  20,  80,  55,  20,  80,   0 },
-
-	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 960,   0 },
-	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 480,   0 },
-	{ XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 240,   0 },
-
-	{ XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 480,   0 },
-	{ XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 150,   0 },
-	{ XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 120,   0 },
-	{ XFER_MW_DMA_3,  25,   0,   0,   0,  65,  25, 100,   0 },
-	{ XFER_MW_DMA_4,  25,   0,   0,   0,  55,  20,  80,   0 },
-
-/*	{ XFER_UDMA_SLOW,  0,   0,   0,   0,   0,   0,   0, 150 }, */
-	{ XFER_UDMA_0,     0,   0,   0,   0,   0,   0,   0, 120 },
-	{ XFER_UDMA_1,     0,   0,   0,   0,   0,   0,   0,  80 },
-	{ XFER_UDMA_2,     0,   0,   0,   0,   0,   0,   0,  60 },
-	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0,   0,  45 },
-	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0,   0,  30 },
-	{ XFER_UDMA_5,     0,   0,   0,   0,   0,   0,   0,  20 },
-	{ XFER_UDMA_6,     0,   0,   0,   0,   0,   0,   0,  15 },
+/*	{ XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 30, 0, 960,   0 }, */
+	{ XFER_PIO_0,     70, 290, 240, 600, 165, 150, 30, 0, 600,   0 },
+	{ XFER_PIO_1,     50, 290,  93, 383, 125, 100, 20, 0, 383,   0 },
+	{ XFER_PIO_2,     30, 290,  40, 330, 100,  90, 15, 0, 240,   0 },
+	{ XFER_PIO_3,     30,  80,  70, 180,  80,  70, 10, 0, 180,   0 },
+	{ XFER_PIO_4,     25,  70,  25, 120,  70,  25, 10, 0, 120,   0 },
+	{ XFER_PIO_5,     15,  65,  25, 100,  65,  25,  5, 0, 100,   0 },
+	{ XFER_PIO_6,     10,  55,  20,  80,  55,  20,  5, 0,  80,   0 },
+
+	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 30, 20, 960,   0 },
+	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 30, 20, 480,   0 },
+	{ XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 15, 20, 240,   0 },
+
+	{ XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 20, 20, 480,   0 },
+	{ XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 15, 5,  150,   0 },
+	{ XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 10, 5,  120,   0 },
+	{ XFER_MW_DMA_3,  25,   0,   0,   0,  65,  25,  5, 5,  100,   0 },
+	{ XFER_MW_DMA_4,  25,   0,   0,   0,  55,  20,  5, 5,   80,   0 },
+
+/*	{ XFER_UDMA_SLOW,  0,   0,   0,   0,   0,   0,  0, 0,    0, 150 }, */
+	{ XFER_UDMA_0,     0,   0,   0,   0,   0,   0,  0, 0,    0, 120 },
+	{ XFER_UDMA_1,     0,   0,   0,   0,   0,   0,  0, 0,    0,  80 },
+	{ XFER_UDMA_2,     0,   0,   0,   0,   0,   0,  0, 0,    0,  60 },
+	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0,  0, 0,    0,  45 },
+	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0,  0, 0,    0,  30 },
+	{ XFER_UDMA_5,     0,   0,   0,   0,   0,   0,  0, 0,    0,  20 },
+	{ XFER_UDMA_6,     0,   0,   0,   0,   0,   0,  0, 0,    0,  15 },
 
 	{ 0xFF }
 };
@@ -2989,14 +2989,16 @@ static const struct ata_timing ata_timing[] = {
 
 static void ata_timing_quantize(const struct ata_timing *t, struct ata_timing *q, int T, int UT)
 {
-	q->setup   = EZ(t->setup   * 1000,  T);
-	q->act8b   = EZ(t->act8b   * 1000,  T);
-	q->rec8b   = EZ(t->rec8b   * 1000,  T);
-	q->cyc8b   = EZ(t->cyc8b   * 1000,  T);
-	q->active  = EZ(t->active  * 1000,  T);
-	q->recover = EZ(t->recover * 1000,  T);
-	q->cycle   = EZ(t->cycle   * 1000,  T);
-	q->udma    = EZ(t->udma    * 1000, UT);
+	q->setup	= EZ(t->setup      * 1000,  T);
+	q->act8b	= EZ(t->act8b      * 1000,  T);
+	q->rec8b	= EZ(t->rec8b      * 1000,  T);
+	q->cyc8b	= EZ(t->cyc8b      * 1000,  T);
+	q->active	= EZ(t->active     * 1000,  T);
+	q->recover	= EZ(t->recover    * 1000,  T);
+	q->write_hold	= EZ(t->write_hold * 1000,  T);
+	q->dmack_hold	= EZ(t->dmack_hold * 1000,  T);
+	q->cycle	= EZ(t->cycle      * 1000,  T);
+	q->udma		= EZ(t->udma       * 1000, UT);
 }
 
 void ata_timing_merge(const struct ata_timing *a, const struct ata_timing *b,
@@ -3008,6 +3010,8 @@ void ata_timing_merge(const struct ata_timing *a, const struct ata_timing *b,
 	if (what & ATA_TIMING_CYC8B  ) m->cyc8b   = max(a->cyc8b,   b->cyc8b);
 	if (what & ATA_TIMING_ACTIVE ) m->active  = max(a->active,  b->active);
 	if (what & ATA_TIMING_RECOVER) m->recover = max(a->recover, b->recover);
+	if (what & ATA_TIMING_WRITE_HOLD) m->write_hold = max(a->write_hold, b->write_hold);
+	if (what & ATA_TIMING_DMACK_HOLD) m->dmack_hold = max(a->dmack_hold, b->dmack_hold);
 	if (what & ATA_TIMING_CYCLE  ) m->cycle   = max(a->cycle,   b->cycle);
 	if (what & ATA_TIMING_UDMA   ) m->udma    = max(a->udma,    b->udma);
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ed3f26e..649b323 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -399,12 +399,16 @@ enum {
 				  ATA_TIMING_CYC8B,
 	ATA_TIMING_ACTIVE	= (1 << 4),
 	ATA_TIMING_RECOVER	= (1 << 5),
-	ATA_TIMING_CYCLE	= (1 << 6),
-	ATA_TIMING_UDMA		= (1 << 7),
+	ATA_TIMING_WRITE_HOLD	= (1 << 6),
+	ATA_TIMING_DMACK_HOLD	= (1 << 7),
+	ATA_TIMING_CYCLE	= (1 << 8),
+	ATA_TIMING_UDMA		= (1 << 9),
 	ATA_TIMING_ALL		= ATA_TIMING_SETUP | ATA_TIMING_ACT8B |
 				  ATA_TIMING_REC8B | ATA_TIMING_CYC8B |
 				  ATA_TIMING_ACTIVE | ATA_TIMING_RECOVER |
-				  ATA_TIMING_CYCLE | ATA_TIMING_UDMA,
+				  ATA_TIMING_WRITE_HOLD |
+				  ATA_TIMING_DMACK_HOLD | ATA_TIMING_CYCLE |
+				  ATA_TIMING_UDMA,
 };
 
 enum ata_xfer_mask {
@@ -864,6 +868,8 @@ struct ata_timing {
 	unsigned short cyc8b;		/* t0 for 8-bit I/O */
 	unsigned short active;		/* t2 or tD */
 	unsigned short recover;		/* t2i or tK */
+	unsigned short write_hold;	/* t4 */
+	unsigned short dmack_hold;	/* tj */
 	unsigned short cycle;		/* t0 */
 	unsigned short udma;		/* t2CYCTYP/2 */
 };
-- 
1.5.6.5
