Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2007 18:31:46 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:62164 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20030284AbXK0Sbh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Nov 2007 18:31:37 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Ix5Dc-0000zd-00; Tue, 27 Nov 2007 19:31:36 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id CB8DDC2B2D; Tue, 27 Nov 2007 19:31:33 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Use correct dma flushing in dma_cache_sync()
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20071127183133.CB8DDC2B2D@solo.franken.de>
Date:	Tue, 27 Nov 2007 19:31:33 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Not cache coherent R10k systems (like IP28) need to do real cache
invalidates in dma_cache_sync().

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 33519ce..5cd94a8 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -364,7 +364,7 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	BUG_ON(direction == DMA_NONE);
 
 	if (!plat_device_is_coherent(dev))
-		dma_cache_wback_inv((unsigned long)vaddr, size);
+		__dma_sync((unsigned long)vaddr, size, direction);
 }
 
 EXPORT_SYMBOL(dma_cache_sync);
