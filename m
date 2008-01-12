Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2008 23:09:00 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:7145 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20034688AbYALXIv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Jan 2008 23:08:51 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JDpT8-0004Y0-00; Sun, 13 Jan 2008 00:08:50 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 1EB3EC2F35; Sun, 13 Jan 2008 00:08:47 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	netdev@vger.kernel.org, linux-mips@linux-mips.org
cc:	ralf@linux-mips.org, jgarzik@pobox.com
Subject: [PATCH] SGISEEQ: fix oops when doing ifconfig down; ifconfig up
Message-Id: <20080112230847.1EB3EC2F35@solo.franken.de>
Date:	Sun, 13 Jan 2008 00:08:47 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

When doing init_ring checking whether a new skb needs to be allocated
was wrong.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

This is a bug fix for the 2.6.25 driver.

 drivers/net/sgiseeq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/sgiseeq.c b/drivers/net/sgiseeq.c
index c69bb8b..78994ed 100644
--- a/drivers/net/sgiseeq.c
+++ b/drivers/net/sgiseeq.c
@@ -193,7 +193,7 @@ static int seeq_init_ring(struct net_device *dev)
 
 	/* And now the rx ring. */
 	for (i = 0; i < SEEQ_RX_BUFFERS; i++) {
-		if (!sp->rx_desc[i].rdma.pbuf) {
+		if (!sp->rx_desc[i].skb) {
 			dma_addr_t dma_addr;
 			struct sk_buff *skb = netdev_alloc_skb(dev, PKT_BUF_SZ);
 
