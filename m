Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2010 03:06:56 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8629 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491117Ab0IXBGx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Sep 2010 03:06:53 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c9bf9cb0000>; Thu, 23 Sep 2010 18:07:24 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 Sep 2010 18:06:51 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 Sep 2010 18:06:51 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o8O16jUu004391;
        Thu, 23 Sep 2010 18:06:45 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o8O16h0p004390;
        Thu, 23 Sep 2010 18:06:43 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Remove plat_map_dma_mem_page().
Date:   Thu, 23 Sep 2010 18:06:38 -0700
Message-Id: <1285290398-4358-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1285281496-24696-10-git-send-email-ddaney@caviumnetworks.com>
References: <1285281496-24696-10-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Sep 2010 01:06:51.0273 (UTC) FILETIME=[C5372F90:01CB5B84]
X-archive-position: 27816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18949

It is now unused.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

This is a small addition to the rest of the patch set.  It could be
rolled into [PATCH 9/9] MIPS: Octeon: Rewrite DMA mapping functions.

 .../include/asm/mach-cavium-octeon/dma-coherence.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
index a0058fb..cedf254 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
@@ -23,12 +23,6 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 	BUG();
 }
 
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-	struct page *page)
-{
-	BUG();
-}
-
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
-- 
1.7.2.2
