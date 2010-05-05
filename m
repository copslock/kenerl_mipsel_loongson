Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 01:05:10 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1675 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492513Ab0EEXDx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 01:03:53 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4be1f9650006>; Wed, 05 May 2010 16:04:05 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 5 May 2010 16:03:24 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 5 May 2010 16:03:24 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o45N3JCj011103;
        Wed, 5 May 2010 16:03:19 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o45N3J9u011102;
        Wed, 5 May 2010 16:03:19 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     netdev@vger.kernel.org
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 5/6] netdev: octeon_mgmt: Try not to drop TX packets when stopping the queue.
Date:   Wed,  5 May 2010 16:03:12 -0700
Message-Id: <1273100593-11043-6-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1273100593-11043-1-git-send-email-ddaney@caviumnetworks.com>
References: <1273100593-11043-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 05 May 2010 23:03:24.0395 (UTC) FILETIME=[2A208BB0:01CAECA7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Stop the queue when we add the packet that will fill it instead of dropping the packet

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/net/octeon/octeon_mgmt.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/octeon/octeon_mgmt.c b/drivers/net/octeon/octeon_mgmt.c
index 3cf6f62..1fdc7b3 100644
--- a/drivers/net/octeon/octeon_mgmt.c
+++ b/drivers/net/octeon/octeon_mgmt.c
@@ -955,6 +955,7 @@ static int octeon_mgmt_xmit(struct sk_buff *skb, struct net_device *netdev)
 	int port = p->port;
 	union mgmt_port_ring_entry re;
 	unsigned long flags;
+	int rv = NETDEV_TX_BUSY;
 
 	re.d64 = 0;
 	re.s.len = skb->len;
@@ -964,15 +965,18 @@ static int octeon_mgmt_xmit(struct sk_buff *skb, struct net_device *netdev)
 
 	spin_lock_irqsave(&p->tx_list.lock, flags);
 
+	if (unlikely(p->tx_current_fill >= ring_max_fill(OCTEON_MGMT_TX_RING_SIZE) - 1)) {
+		spin_unlock_irqrestore(&p->tx_list.lock, flags);
+		netif_stop_queue(netdev);
+		spin_lock_irqsave(&p->tx_list.lock, flags);
+	}
+
 	if (unlikely(p->tx_current_fill >=
 		     ring_max_fill(OCTEON_MGMT_TX_RING_SIZE))) {
 		spin_unlock_irqrestore(&p->tx_list.lock, flags);
-
 		dma_unmap_single(p->dev, re.s.addr, re.s.len,
 				 DMA_TO_DEVICE);
-
-		netif_stop_queue(netdev);
-		return NETDEV_TX_BUSY;
+		goto out;
 	}
 
 	__skb_queue_tail(&p->tx_list, skb);
@@ -995,8 +999,10 @@ static int octeon_mgmt_xmit(struct sk_buff *skb, struct net_device *netdev)
 	cvmx_write_csr(CVMX_MIXX_ORING2(port), 1);
 
 	netdev->trans_start = jiffies;
+	rv = NETDEV_TX_OK;
+out:
 	octeon_mgmt_update_tx_stats(netdev);
-	return NETDEV_TX_OK;
+	return rv;
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-- 
1.6.6.1
