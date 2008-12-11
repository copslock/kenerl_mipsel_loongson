Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2008 02:15:26 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:31315 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207755AbYLKCPR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Dec 2008 02:15:17 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B494077ac0000>; Wed, 10 Dec 2008 21:15:08 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Dec 2008 18:14:45 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Dec 2008 18:14:45 -0800
Message-ID: <49407795.9010208@caviumnetworks.com>
Date:	Wed, 10 Dec 2008 18:14:45 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
Subject: [Patch] MIPS: Add missing calls to plat_unmap_dma_mem.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Dec 2008 02:14:45.0772 (UTC) FILETIME=[3C7964C0:01C95B36]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

It appears that dma_free_noncoherent() and dma_free_coherent() are
missing calls to plat_unmap_dma_mem().  This patch adds them.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
This is split out from my OCTEON processor support patch at Ralf's
request.

 arch/mips/mm/dma-default.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 5b98d0e..e6708b3 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -111,6 +111,7 @@ EXPORT_SYMBOL(dma_alloc_coherent);
 void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
 	dma_addr_t dma_handle)
 {
+	plat_unmap_dma_mem(dma_handle);
 	free_pages((unsigned long) vaddr, get_order(size));
 }
 
@@ -121,6 +122,8 @@ void dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 {
 	unsigned long addr = (unsigned long) vaddr;
 
+	plat_unmap_dma_mem(dma_handle);
+
 	if (!plat_device_is_coherent(dev))
 		addr = CAC_ADDR(addr);
 
