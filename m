Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Oct 2008 01:49:13 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12404 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21747240AbYJRAtL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 18 Oct 2008 01:49:11 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48f932770000>; Fri, 17 Oct 2008 20:48:55 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 17 Oct 2008 17:48:53 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 17 Oct 2008 17:48:53 -0700
Message-ID: <48F93275.8010305@caviumnetworks.com>
Date:	Fri, 17 Oct 2008 17:48:53 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: [PATCH] Don't unmap the memory for dma_sync*.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Oct 2008 00:48:53.0462 (UTC) FILETIME=[4B26C760:01C930BB]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Don't unmap the memory for dma_sync*.

This must have been typo, it cannot have been correct.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/dma-default.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 891312f..5b98d0e 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -324,7 +324,6 @@ void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
 		if (cpu_is_noncoherent_r10000(dev))
 			__dma_sync((unsigned long)page_address(sg_page(sg)),
 			           sg->length, direction);
-		plat_unmap_dma_mem(sg->dma_address);
 	}
 }
 
@@ -342,7 +341,6 @@ void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nele
 		if (!plat_device_is_coherent(dev))
 			__dma_sync((unsigned long)page_address(sg_page(sg)),
 			           sg->length, direction);
-		plat_unmap_dma_mem(sg->dma_address);
 	}
 }
 
