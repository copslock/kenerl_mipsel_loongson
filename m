Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2007 12:05:04 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:30387 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021901AbXHPLFC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Aug 2007 12:05:02 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7GB51uH005805
	for <linux-mips@linux-mips.org>; Thu, 16 Aug 2007 12:05:02 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7GB51oA005804
	for linux-mips@linux-mips.org; Thu, 16 Aug 2007 12:05:01 +0100
Date:	Thu, 16 Aug 2007 12:05:01 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Alchemy DMA and GFP_DMA
Message-ID: <20070816110501.GA5701@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

arch/mips/au1000/common/dbdma.c uses GFP_DMA in two places and I think
both instances are uncessary.  Could some alchmist confirm that both are
unnecessary?

Thanks,

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/au1000/common/dbdma.c b/arch/mips/au1000/common/dbdma.c
index 626de44..708b83b 100644
--- a/arch/mips/au1000/common/dbdma.c
+++ b/arch/mips/au1000/common/dbdma.c
@@ -397,7 +397,7 @@ au1xxx_dbdma_ring_alloc(u32 chanid, int entries)
 	 * slabs of memory.
 	 */
 	desc_base = (u32)kmalloc(entries * sizeof(au1x_ddma_desc_t),
-			GFP_KERNEL|GFP_DMA);
+			GFP_KERNEL);
 	if (desc_base == 0)
 		return 0;
 
@@ -408,7 +408,7 @@ au1xxx_dbdma_ring_alloc(u32 chanid, int entries)
 		kfree((const void *)desc_base);
 		i = entries * sizeof(au1x_ddma_desc_t);
 		i += (sizeof(au1x_ddma_desc_t) - 1);
-		if ((desc_base = (u32)kmalloc(i, GFP_KERNEL|GFP_DMA)) == 0)
+		if ((desc_base = (u32)kmalloc(i, GFP_KERNEL)) == 0)
 			return 0;
 
 		desc_base = ALIGN_ADDR(desc_base, sizeof(au1x_ddma_desc_t));
