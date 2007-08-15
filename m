Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Aug 2007 12:53:21 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:27560 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021408AbXHOLxT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Aug 2007 12:53:19 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7FBrHwa013134;
	Wed, 15 Aug 2007 12:53:18 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7FBrGG1012400;
	Wed, 15 Aug 2007 12:53:16 +0100
Date:	Wed, 15 Aug 2007 12:53:16 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: [METH] Don't use GFP_DMA for zone allocation.
Message-ID: <20070815115316.GB5862@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

IP32 doesn't even have a ZONE_DMA so no point in using GFP_DMA in any
IP32-specific device driver.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/net/meth.c b/drivers/net/meth.c
index 92b403b..32bed6b 100644
--- a/drivers/net/meth.c
+++ b/drivers/net/meth.c
@@ -405,7 +405,7 @@ static void meth_rx(struct net_device* dev, unsigned long int_status)
 				priv->stats.rx_length_errors++;
 				skb = priv->rx_skbs[priv->rx_write];
 			} else {
-				skb = alloc_skb(METH_RX_BUFF_SIZE, GFP_ATOMIC | GFP_DMA);
+				skb = alloc_skb(METH_RX_BUFF_SIZE, GFP_ATOMIC);
 				if (!skb) {
 					/* Ouch! No memory! Drop packet on the floor */
 					DPRINTK("No mem: dropping packet\n");
