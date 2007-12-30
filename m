Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Dec 2007 11:45:55 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:41394 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20029582AbXL3Lpr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 30 Dec 2007 11:45:47 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1J8wbx-0007pf-01; Sun, 30 Dec 2007 12:45:45 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id A0ADFC2EEF; Sun, 30 Dec 2007 12:45:40 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Wrong CONFIG option prevents setup of DMA zone.
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20071230114540.A0ADFC2EEF@solo.franken.de>
Date:	Sun, 30 Dec 2007 12:45:40 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Wrong CONFIG option prevents setup of DMA zone.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/mm/dma-default.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index ae76795..810535d 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -45,7 +45,7 @@ static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
 	/* ignore region specifiers */
 	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
-#ifdef CONFIG_ZONE_DMA32
+#ifdef CONFIG_ZONE_DMA
 	if (dev == NULL)
 		gfp |= __GFP_DMA;
 	else if (dev->coherent_dma_mask < DMA_BIT_MASK(24))
