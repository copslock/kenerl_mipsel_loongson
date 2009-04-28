Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 16:11:22 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:54258 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20025528AbZD1PLQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Apr 2009 16:11:16 +0100
Received: from localhost.localdomain (p2111-ipad309funabasi.chiba.ocn.ne.jp [123.217.196.111])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 97A4AAAC9; Wed, 29 Apr 2009 00:11:10 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, dan.j.williams@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] txx9dmac: Fix clearing of CHAR register in 32-bit kernel
Date:	Wed, 29 Apr 2009 00:11:15 +0900
Message-Id: <1240931475-31326-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The CHAR register is 64-bit width but 32-bit kernel uses its lower
part only.  Be careful of initializing it.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch is against linux-mips.org linux-queue tree.
Please queue this or fold into "DMA: TXx9 Soc DMA Controller driver" patch.

 drivers/dma/txx9dmac.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index c655350..9aa9ea9 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -72,6 +72,16 @@ static void channel64_write_CHAR(const struct txx9dmac_chan *dc, dma_addr_t val)
 		channel64_writel(dc, CHAR, val);
 }
 
+static void channel64_clear_CHAR(const struct txx9dmac_chan *dc)
+{
+#if defined(CONFIG_32BIT) && !defined(CONFIG_64BIT_PHYS_ADDR)
+	channel64_writel(dc, CHAR, 0);
+	channel64_writel(dc, __pad_CHAR, 0);
+#else
+	channel64_writeq(dc, CHAR, 0);
+#endif
+}
+
 static dma_addr_t channel_read_CHAR(const struct txx9dmac_chan *dc)
 {
 	if (is_dmac64(dc))
@@ -318,7 +328,7 @@ static void txx9dmac_reset_chan(struct txx9dmac_chan *dc)
 {
 	channel_writel(dc, CCR, TXX9_DMA_CCR_CHRST);
 	if (is_dmac64(dc)) {
-		channel_writeq(dc, CHAR, 0);
+		channel64_clear_CHAR(dc);
 		channel_writeq(dc, SAR, 0);
 		channel_writeq(dc, DAR, 0);
 	} else {
-- 
1.5.6.3
