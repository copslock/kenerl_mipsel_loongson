Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2005 15:07:57 +0000 (GMT)
Received: from [IPv6:::ffff:62.13.60.4] ([IPv6:::ffff:62.13.60.4]:57620 "EHLO
	mail.swemic.net") by linux-mips.org with ESMTP id <S8225335AbVAUPHv>;
	Fri, 21 Jan 2005 15:07:51 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.swemic.net (Postfix) with ESMTP
	id 936AE75F9C; Fri, 21 Jan 2005 16:07:49 +0100 (CET)
Received: from mail.swemic.net ([127.0.0.1])
 by localhost (seagle [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 00500-07; Fri, 21 Jan 2005 16:07:35 +0100 (CET)
Received: from [172.16.1.31] (unknown [62.13.60.22])
	by mail.swemic.net (Postfix) with ESMTP
	id 61BAC75D83; Fri, 21 Jan 2005 16:07:34 +0100 (CET)
Message-ID: <41F11AB7.3010105@corelatus.se>
Date:	Fri, 21 Jan 2005 16:07:35 +0100
From:	Thomas Lange <thomas@corelatus.se>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040911
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	ppopov@linux-mips.org
Subject: [PATCH] Fix for Au1x00 ethernet tx stats
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020804040201060107080300"
X-Virus-Scanned: by amavisd-new at hawk.swemic.net
Return-Path: <thomas@corelatus.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@corelatus.se
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------020804040201060107080300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

With current CVS head, ethernet TX bytes always remain zero.

The problem seems to be that when packet has been transmitted,
the len word in DMA buffer is zero.

Attached is a patch against 2_4 HEAD that updates the stats when
DMA buffer is written to fix this.

* Patch by Thomas Lange, 21 Jan 2005:
  Fix update of ethernet tx bytes stats for au1x00

/Thomas

--------------020804040201060107080300
Content-Type: text/plain;
 name="au1000_eth.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="au1000_eth.diff"

Index: au1000_eth.c
===================================================================
RCS file: /home/cvs/linux/drivers/net/au1000_eth.c,v
retrieving revision 1.5.2.33
diff -p -u -r1.5.2.33 au1000_eth.c
--- au1000_eth.c	26 Nov 2004 08:40:13 -0000	1.5.2.33
+++ au1000_eth.c	21 Jan 2005 14:33:47 -0000
@@ -83,7 +83,7 @@ static void au1000_tx_timeout(struct net
 static int au1000_set_config(struct net_device *dev, struct ifmap *map);
 static void set_rx_mode(struct net_device *);
 static struct net_device_stats *au1000_get_stats(struct net_device *);
-static inline void update_tx_stats(struct net_device *, u32, u32);
+static inline void update_tx_stats(struct net_device *, u32);
 static inline void update_rx_stats(struct net_device *, u32);
 static void au1000_timer(unsigned long);
 static int au1000_ioctl(struct net_device *, struct ifreq *, int);
@@ -1542,14 +1542,11 @@ static void __exit au1000_cleanup_module
 
 
 static inline void 
-update_tx_stats(struct net_device *dev, u32 status, u32 pkt_len)
+update_tx_stats(struct net_device *dev, u32 status)
 {
 	struct au1000_private *aup = (struct au1000_private *) dev->priv;
 	struct net_device_stats *ps = &aup->stats;
 
-	ps->tx_packets++;
-	ps->tx_bytes += pkt_len;
-
 	if (status & TX_FRAME_ABORTED) {
 		if (dev->if_port == IF_PORT_100BASEFX) {
 			if (status & (TX_JAB_TIMEOUT | TX_UNDERRUN)) {
@@ -1582,7 +1579,7 @@ static void au1000_tx_ack(struct net_dev
 	ptxd = aup->tx_dma_ring[aup->tx_tail];
 
 	while (ptxd->buff_stat & TX_T_DONE) {
-		update_tx_stats(dev, ptxd->status, ptxd->len & 0x3ff);
+		update_tx_stats(dev, ptxd->status);
 		ptxd->buff_stat &= ~TX_T_DONE;
 		ptxd->len = 0;
 		au_sync();
@@ -1604,6 +1601,7 @@ static void au1000_tx_ack(struct net_dev
 static int au1000_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct net_device_stats *ps = &aup->stats;
 	volatile tx_dma_t *ptxd;
 	u32 buff_stat;
 	db_dest_t *pDB;
@@ -1623,7 +1621,7 @@ static int au1000_tx(struct sk_buff *skb
 		return 1;
 	}
 	else if (buff_stat & TX_T_DONE) {
-		update_tx_stats(dev, ptxd->status, ptxd->len & 0x3ff);
+		update_tx_stats(dev, ptxd->status);
 		ptxd->len = 0;
 	}
 
@@ -1643,6 +1641,9 @@ static int au1000_tx(struct sk_buff *skb
 	else
 		ptxd->len = skb->len;
 
+	ps->tx_packets++;
+	ps->tx_bytes += ptxd->len;
+
 	ptxd->buff_stat = pDB->dma_addr | TX_DMA_ENABLE;
 	au_sync();
 	dev_kfree_skb(skb);

--------------020804040201060107080300--
