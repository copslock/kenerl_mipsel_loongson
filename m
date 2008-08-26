Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 07:55:28 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:10215 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20025457AbYHZGzZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Aug 2008 07:55:25 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 517363207D1;
	Tue, 26 Aug 2008 06:55:17 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue, 26 Aug 2008 06:55:17 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.226]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 25 Aug 2008 23:55:13 -0700
Message-ID: <48B3A8D0.2040108@avtrex.com>
Date:	Mon, 25 Aug 2008 23:55:12 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	e1000-devel@lists.sourceforge.net, netdev@vger.kernel.org
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] e100: Add missing dma sync for proper operation with non-coherent
 caches.
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Aug 2008 06:55:13.0337 (UTC) FILETIME=[B048CA90:01C90748]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

I am running the e100 driver on a MIPS 4KEc system (32 bit mips with
non-coherent DMA).  There was a problem where received packets would
get 'stuck' for several seconds at a time and then be released all at
once.

The cause was that if an interrupt were received when no RX packets
were available, the status for the receive buffer would be stuck in
the cache, so when the next interrupt arrived the old status value was
read (indicating no packets available) instead of the new value.

The fix is to call pci_dma_sync_single_for_device on the RX if the
packet is not available to invalidate the cache so that at the next
interrupt valid status is returned.

The driver currently calls pci_dma_sync_single_for_cpu before reading
the status, and this is indeed needed for cases like the R10000 CPU
where the cache can be polluted by speculative execution, but for most
machines it is a nop.

The patch was tested on 2.6.17-rc4 on a MIPS 4KEc.

Signed-off-by: David Daney <ddaney@avtrex.com>
---
 drivers/net/e100.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/net/e100.c b/drivers/net/e100.c
index 19d32a2..fb8d551 100644
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -1840,6 +1840,11 @@ static int e100_rx_indicate(struct nic *nic, struct rx *rx,
 
 			if (readb(&nic->csr->scb.status) & rus_no_res)
 				nic->ru_running = RU_SUSPENDED;
+		/* We are done looking at the buffer.  Prepare it for
+		 * more DMA.  */
+		pci_dma_sync_single_for_device(nic->pdev, rx->dma_addr,
+					       sizeof(struct rfd),
+					       PCI_DMA_FROMDEVICE);
 		return -ENODATA;
 	}
 
-- 
1.5.5.1
