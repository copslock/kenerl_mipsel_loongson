Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2009 01:27:37 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:12764 "EHLO
	smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493126AbZFWX1a (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Jun 2009 01:27:30 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a4164170000>; Tue, 23 Jun 2009 19:24:08 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Jun 2009 16:21:02 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Jun 2009 16:21:02 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n5NNKvU8005121;
	Tue, 23 Jun 2009 16:20:57 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n5NNKuYc005119;
	Tue, 23 Jun 2009 16:20:56 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org, gregkh@suse.de
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] Staging: octeon-ethernet: Fix race freeing transmit buffers.
Date:	Tue, 23 Jun 2009 16:20:56 -0700
Message-Id: <1245799256-5095-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 23 Jun 2009 23:21:02.0061 (UTC) FILETIME=[460291D0:01C9F459]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The existing code had the following race:

Thread-1                       Thread-2

inc/read in_use
                               inc/read in_use
inc tx_free_list[qos].len
                               inc tx_free_list[qos].len



The actual in_use value was incremented twice, but thread-1 is going
to free memory based on its stale value, and will free one too many
times.  The result is that memory is freed back to the kernel while
its packet is still in the transmit buffer.  If the memory is
overwritten before it is transmitted, the hardware will put a valid
checksum on it and send it out (just like it does with good packets).
If by chance the TCP flags are clobbered but not the addresses or
ports, the result can be a broken TCP stream.

The fix is to track the number of freed packets in a single location
(a Fetch-and-Add Unit register).  That way it can never get out of sync
with itself.

We try to free up to MAX_SKB_TO_FREE (currently 10) buffers at a time.
If fewer are available we adjust the free count with the difference.
The action of claiming buffers to free is atomic so two threads cannot
claim the same buffers.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

As with the previous patch, we may want to merge it via Ralf's
tree as Octeon is a MIPS SOC.

 drivers/staging/octeon/ethernet-defines.h |    2 +
 drivers/staging/octeon/ethernet-tx.c      |   56 ++++++++++-------
 drivers/staging/octeon/ethernet-tx.h      |   25 ++++++++
 drivers/staging/octeon/ethernet.c         |   91 +++++++++++++++--------------
 4 files changed, 107 insertions(+), 67 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-defines.h b/drivers/staging/octeon/ethernet-defines.h
index 8f7374e..f13131b 100644
--- a/drivers/staging/octeon/ethernet-defines.h
+++ b/drivers/staging/octeon/ethernet-defines.h
@@ -117,6 +117,8 @@
 
 /* Maximum number of packets to process per interrupt. */
 #define MAX_RX_PACKETS 120
+/* Maximum number of SKBs to try to free per xmit packet. */
+#define MAX_SKB_TO_FREE 10
 #define MAX_OUT_QUEUE_DEPTH 1000
 
 #ifndef CONFIG_SMP
diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index bfd3dd2..81a8513 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -47,6 +47,7 @@
 
 #include "ethernet-defines.h"
 #include "octeon-ethernet.h"
+#include "ethernet-tx.h"
 #include "ethernet-util.h"
 
 #include "cvmx-wqe.h"
@@ -82,8 +83,10 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 	uint64_t old_scratch2;
 	int dropped;
 	int qos;
+	int queue_it_up;
 	struct octeon_ethernet *priv = netdev_priv(dev);
-	int32_t in_use;
+	int32_t skb_to_free;
+	int32_t undo;
 	int32_t buffers_to_free;
 #if REUSE_SKBUFFS_WITHOUT_FREE
 	unsigned char *fpa_head;
@@ -120,15 +123,15 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 		old_scratch2 = cvmx_scratch_read64(CVMX_SCR_SCRATCH + 8);
 
 		/*
-		 * Assume we're going to be able t osend this
-		 * packet. Fetch and increment the number of pending
-		 * packets for output.
+		 * Fetch and increment the number of packets to be
+		 * freed.
 		 */
 		cvmx_fau_async_fetch_and_add32(CVMX_SCR_SCRATCH + 8,
 					       FAU_NUM_PACKET_BUFFERS_TO_FREE,
 					       0);
 		cvmx_fau_async_fetch_and_add32(CVMX_SCR_SCRATCH,
-					       priv->fau + qos * 4, 1);
+					       priv->fau + qos * 4,
+					       MAX_SKB_TO_FREE);
 	}
 
 	/*
@@ -286,16 +289,30 @@ dont_put_skbuff_in_hw:
 	if (USE_ASYNC_IOBDMA) {
 		/* Get the number of skbuffs in use by the hardware */
 		CVMX_SYNCIOBDMA;
-		in_use = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
+		skb_to_free = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
 		buffers_to_free = cvmx_scratch_read64(CVMX_SCR_SCRATCH + 8);
 	} else {
 		/* Get the number of skbuffs in use by the hardware */
-		in_use = cvmx_fau_fetch_and_add32(priv->fau + qos * 4, 1);
+		skb_to_free = cvmx_fau_fetch_and_add32(priv->fau + qos * 4,
+						       MAX_SKB_TO_FREE);
 		buffers_to_free =
 		    cvmx_fau_fetch_and_add32(FAU_NUM_PACKET_BUFFERS_TO_FREE, 0);
 	}
 
 	/*
+	 * We try to claim MAX_SKB_TO_FREE buffers.  If there were not
+	 * that many available, we have to un-claim (undo) any that
+	 * were in excess.  If skb_to_free is positive we will free
+	 * that many buffers.
+	 */
+	undo = skb_to_free > 0 ?
+		MAX_SKB_TO_FREE : skb_to_free + MAX_SKB_TO_FREE;
+	if (undo > 0)
+		cvmx_fau_atomic_add32(priv->fau+qos*4, -undo);
+	skb_to_free = -skb_to_free > MAX_SKB_TO_FREE ?
+		MAX_SKB_TO_FREE : -skb_to_free;
+
+	/*
 	 * If we're sending faster than the receive can free them then
 	 * don't do the HW free.
 	 */
@@ -330,38 +347,31 @@ dont_put_skbuff_in_hw:
 		cvmx_scratch_write64(CVMX_SCR_SCRATCH + 8, old_scratch2);
 	}
 
+	queue_it_up = 0;
 	if (unlikely(dropped)) {
 		dev_kfree_skb_any(skb);
-		cvmx_fau_atomic_add32(priv->fau + qos * 4, -1);
 		priv->stats.tx_dropped++;
 	} else {
 		if (USE_SKBUFFS_IN_HW) {
 			/* Put this packet on the queue to be freed later */
 			if (pko_command.s.dontfree)
-				skb_queue_tail(&priv->tx_free_list[qos], skb);
-			else {
+				queue_it_up = 1;
+			else
 				cvmx_fau_atomic_add32
 				    (FAU_NUM_PACKET_BUFFERS_TO_FREE, -1);
-				cvmx_fau_atomic_add32(priv->fau + qos * 4, -1);
-			}
 		} else {
 			/* Put this packet on the queue to be freed later */
-			skb_queue_tail(&priv->tx_free_list[qos], skb);
+			queue_it_up = 1;
 		}
 	}
 
-	/* Free skbuffs not in use by the hardware, possibly two at a time */
-	if (skb_queue_len(&priv->tx_free_list[qos]) > in_use) {
+	if (queue_it_up) {
 		spin_lock(&priv->tx_free_list[qos].lock);
-		/*
-		 * Check again now that we have the lock. It might
-		 * have changed.
-		 */
-		if (skb_queue_len(&priv->tx_free_list[qos]) > in_use)
-			dev_kfree_skb(__skb_dequeue(&priv->tx_free_list[qos]));
-		if (skb_queue_len(&priv->tx_free_list[qos]) > in_use)
-			dev_kfree_skb(__skb_dequeue(&priv->tx_free_list[qos]));
+		__skb_queue_tail(&priv->tx_free_list[qos], skb);
+		cvm_oct_free_tx_skbs(priv, skb_to_free, qos, 0);
 		spin_unlock(&priv->tx_free_list[qos].lock);
+	} else {
+		cvm_oct_free_tx_skbs(priv, skb_to_free, qos, 1);
 	}
 
 	return 0;
diff --git a/drivers/staging/octeon/ethernet-tx.h b/drivers/staging/octeon/ethernet-tx.h
index 5106236..c0bebf7 100644
--- a/drivers/staging/octeon/ethernet-tx.h
+++ b/drivers/staging/octeon/ethernet-tx.h
@@ -30,3 +30,28 @@ int cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev);
 int cvm_oct_transmit_qos(struct net_device *dev, void *work_queue_entry,
 			 int do_free, int qos);
 void cvm_oct_tx_shutdown(struct net_device *dev);
+
+/**
+ * Free dead transmit skbs.
+ *
+ * @priv:		The driver data
+ * @skb_to_free:	The number of SKBs to free (free none if negative).
+ * @qos:		The queue to free from.
+ * @take_lock:		If true, acquire the skb list lock.
+ */
+static inline void cvm_oct_free_tx_skbs(struct octeon_ethernet *priv,
+					int skb_to_free,
+					int qos, int take_lock)
+{
+	/* Free skbuffs not in use by the hardware.  */
+	if (skb_to_free > 0) {
+		if (take_lock)
+			spin_lock(&priv->tx_free_list[qos].lock);
+		while (skb_to_free > 0) {
+			dev_kfree_skb(__skb_dequeue(&priv->tx_free_list[qos]));
+			skb_to_free--;
+		}
+		if (take_lock)
+			spin_unlock(&priv->tx_free_list[qos].lock);
+	}
+}
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 2d9356d..b847951 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -37,13 +37,14 @@
 #include <asm/octeon/octeon.h>
 
 #include "ethernet-defines.h"
+#include "octeon-ethernet.h"
 #include "ethernet-mem.h"
 #include "ethernet-rx.h"
 #include "ethernet-tx.h"
 #include "ethernet-mdio.h"
 #include "ethernet-util.h"
 #include "ethernet-proc.h"
-#include "octeon-ethernet.h"
+
 
 #include "cvmx-pip.h"
 #include "cvmx-pko.h"
@@ -130,53 +131,55 @@ extern struct semaphore mdio_sem;
  */
 static void cvm_do_timer(unsigned long arg)
 {
+	int32_t skb_to_free, undo;
+	int queues_per_port;
+	int qos;
+	struct octeon_ethernet *priv;
 	static int port;
-	if (port < CVMX_PIP_NUM_INPUT_PORTS) {
-		if (cvm_oct_device[port]) {
-			int queues_per_port;
-			int qos;
-			struct octeon_ethernet *priv =
-				netdev_priv(cvm_oct_device[port]);
-			if (priv->poll) {
-				/* skip polling if we don't get the lock */
-				if (!down_trylock(&mdio_sem)) {
-					priv->poll(cvm_oct_device[port]);
-					up(&mdio_sem);
-				}
-			}
 
-			queues_per_port = cvmx_pko_get_num_queues(port);
-			/* Drain any pending packets in the free list */
-			for (qos = 0; qos < queues_per_port; qos++) {
-				if (skb_queue_len(&priv->tx_free_list[qos])) {
-					spin_lock(&priv->tx_free_list[qos].
-						  lock);
-					while (skb_queue_len
-					       (&priv->tx_free_list[qos]) >
-					       cvmx_fau_fetch_and_add32(priv->
-									fau +
-									qos * 4,
-									0))
-						dev_kfree_skb(__skb_dequeue
-							      (&priv->
-							       tx_free_list
-							       [qos]));
-					spin_unlock(&priv->tx_free_list[qos].
-						    lock);
-				}
-			}
-			cvm_oct_device[port]->netdev_ops->ndo_get_stats(cvm_oct_device[port]);
-		}
-		port++;
-		/* Poll the next port in a 50th of a second.
-		   This spreads the polling of ports out a little bit */
-		mod_timer(&cvm_oct_poll_timer, jiffies + HZ / 50);
-	} else {
+	if (port >= CVMX_PIP_NUM_INPUT_PORTS) {
+		/*
+		 * All ports have been polled. Start the next
+		 * iteration through the ports in one second.
+		 */
 		port = 0;
-		/* All ports have been polled. Start the next iteration through
-		   the ports in one second */
 		mod_timer(&cvm_oct_poll_timer, jiffies + HZ);
+		return;
+	}
+	if (!cvm_oct_device[port])
+		goto out;
+
+	priv = netdev_priv(cvm_oct_device[port]);
+	if (priv->poll) {
+		/* skip polling if we don't get the lock */
+		if (!down_trylock(&mdio_sem)) {
+			priv->poll(cvm_oct_device[port]);
+			up(&mdio_sem);
+		}
+	}
+
+	queues_per_port = cvmx_pko_get_num_queues(port);
+	/* Drain any pending packets in the free list */
+	for (qos = 0; qos < queues_per_port; qos++) {
+		if (skb_queue_len(&priv->tx_free_list[qos]) == 0)
+			continue;
+		skb_to_free = cvmx_fau_fetch_and_add32(priv->fau + qos * 4,
+						       MAX_SKB_TO_FREE);
+		undo = skb_to_free > 0 ?
+			MAX_SKB_TO_FREE : skb_to_free + MAX_SKB_TO_FREE;
+		if (undo > 0)
+			cvmx_fau_atomic_add32(priv->fau+qos*4, -undo);
+		skb_to_free = -skb_to_free > MAX_SKB_TO_FREE ?
+			MAX_SKB_TO_FREE : -skb_to_free;
+		cvm_oct_free_tx_skbs(priv, skb_to_free, qos, 1);
 	}
+	cvm_oct_device[port]->netdev_ops->ndo_get_stats(cvm_oct_device[port]);
+
+out:
+	port++;
+	/* Poll the next port in a 50th of a second.
+	   This spreads the polling of ports out a little bit */
+	mod_timer(&cvm_oct_poll_timer, jiffies + HZ / 50);
 }
 
 /**
-- 
1.6.0.6
