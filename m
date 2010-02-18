Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Feb 2010 20:48:31 +0100 (CET)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:2688 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492443Ab0BRTs1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Feb 2010 20:48:27 +0100
Received: from maexch1.caveonetworks.com (Not Verified[192.168.14.20]) by smtp2.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b7d98210000>; Thu, 18 Feb 2010 14:42:25 -0500
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by maexch1.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 18 Feb 2010 14:48:26 -0500
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 18 Feb 2010 11:48:24 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o1IJmM3o000990;
        Thu, 18 Feb 2010 11:48:22 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o1IJmMil000989;
        Thu, 18 Feb 2010 11:48:22 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: Octeon: Replace spinlock with raw_spinlocks in dma-octeon.c.
Date:   Thu, 18 Feb 2010 11:48:20 -0800
Message-Id: <1266522500-955-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6
X-OriginalArrivalTime: 18 Feb 2010 19:48:24.0376 (UTC) FILETIME=[54FA5380:01CAB0D3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/dma-octeon.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index 4b92bfc..be531ec 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -41,7 +41,7 @@ struct bar1_index_state {
 };
 
 #ifdef CONFIG_PCI
-static DEFINE_SPINLOCK(bar1_lock);
+static DEFINE_RAW_SPINLOCK(bar1_lock);
 static struct bar1_index_state bar1_state[32];
 #endif
 
@@ -198,7 +198,7 @@ dma_addr_t octeon_map_dma_mem(struct device *dev, void *ptr, size_t size)
 		start_index = 31;
 
 	/* Only one processor can access the Bar register at once */
-	spin_lock_irqsave(&bar1_lock, flags);
+	raw_spin_lock_irqsave(&bar1_lock, flags);
 
 	/* Look through Bar1 for existing mapping that will work */
 	for (index = start_index; index >= 0; index--) {
@@ -250,7 +250,7 @@ dma_addr_t octeon_map_dma_mem(struct device *dev, void *ptr, size_t size)
 	       (unsigned long long) physical);
 
 done_unlock:
-	spin_unlock_irqrestore(&bar1_lock, flags);
+	raw_spin_unlock_irqrestore(&bar1_lock, flags);
 done:
 	pr_debug("dma_map_single 0x%llx->0x%llx\n", physical, result);
 	return result;
@@ -324,14 +324,14 @@ void octeon_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
 		      "Attempt to unmap an invalid address (0x%llx)\n",
 		      dma_addr);
 
-	spin_lock_irqsave(&bar1_lock, flags);
+	raw_spin_lock_irqsave(&bar1_lock, flags);
 	bar1_state[index].ref_count--;
 	if (bar1_state[index].ref_count == 0)
 		octeon_npi_write32(CVMX_NPI_PCI_BAR1_INDEXX(index), 0);
 	else if (unlikely(bar1_state[index].ref_count < 0))
 		panic("dma_unmap_single: Bar1[%u] reference count < 0\n",
 		      (int) index);
-	spin_unlock_irqrestore(&bar1_lock, flags);
+	raw_spin_unlock_irqrestore(&bar1_lock, flags);
 done:
 	pr_debug("dma_unmap_single 0x%llx\n", dma_addr);
 	return;
-- 
1.6.6
