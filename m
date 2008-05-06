Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2008 22:32:31 +0100 (BST)
Received: from mailhub.zebra.lt ([212.59.31.77]:16132 "EHLO mh.zebra.lt")
	by ftp.linux-mips.org with ESMTP id S20032213AbYEFVc1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 6 May 2008 22:32:27 +0100
Received: from localhost (localhost [127.0.0.1])
	by mh.zebra.lt (Postfix) with ESMTP id 83F86118AE3;
	Wed,  7 May 2008 00:31:11 +0300 (EEST)
X-Virus-Scanned: amavisd-new at takas.lt
Received: from mh.zebra.lt ([127.0.0.1])
	by localhost (ispmailfe123.internal.takas.lt [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vd1r-G0F4f4P; Wed,  7 May 2008 00:31:11 +0300 (EEST)
Received: from mailhub.zebra.lt (unknown [192.168.3.104])
	by mh.zebra.lt (Postfix) with ESMTP id 2BDB8118B8E;
	Wed,  7 May 2008 00:31:11 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by mailhub.zebra.lt (Postfix) with ESMTP id 4BD90279DA7;
	Wed,  7 May 2008 00:32:21 +0300 (EEST)
X-Virus-Scanned: amavisd-new at takas.lt
Received: from mailhub.zebra.lt ([127.0.0.1])
	by localhost (ispmailfe104.internal.takas.lt [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ULoOfR-3KQoX; Wed,  7 May 2008 00:32:20 +0300 (EEST)
Received: from paulius.dzuku (78-62-85-225.static.zebra.lt [78.62.85.225])
	by mailhub.zebra.lt (Postfix) with ESMTP id 7A708279DB3;
	Wed,  7 May 2008 00:32:20 +0300 (EEST)
Message-ID: <4820CE63.7050505@teltonika.lt>
Date:	Wed, 07 May 2008 00:32:19 +0300
From:	Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
Newsgroups: gmane.linux.irda.general,gmane.linux.network
CC:	linux-mips@linux-mips.org, ppopov@mvista.com
Subject: [PATCH] au1k_ir: use netstats in net_device structure
Content-Type: multipart/mixed;
 boundary="------------030305010008050208030004"
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <paulius.zaleckas@teltonika.lt>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulius.zaleckas@teltonika.lt
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------030305010008050208030004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Use net_device_stats from net_device structure instead of local.
Kill au1k_irda_stats function, because by default it is used
identical internal_stats function from net/core/dev.c

Haven't tried to compile it. Need ack from MIPS people!

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>

--------------030305010008050208030004
Content-Type: text/x-patch;
 name="au1k_ir_netstats.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="au1k_ir_netstats.patch"

diff --git a/drivers/net/irda/au1000_ircc.h b/drivers/net/irda/au1000_ircc.h
index 7a31d46..1ed665a 100644
--- a/drivers/net/irda/au1000_ircc.h
+++ b/drivers/net/irda/au1000_ircc.h
@@ -107,7 +107,6 @@ struct au1k_private {
 	iobuff_t rx_buff;
 
 	struct net_device *netdev;
-	struct net_device_stats stats;
 	
 	struct timeval stamp;
 	struct timeval now;
diff --git a/drivers/net/irda/au1k_ir.c b/drivers/net/irda/au1k_ir.c
index a1e4508..f4e639b 100644
--- a/drivers/net/irda/au1k_ir.c
+++ b/drivers/net/irda/au1k_ir.c
@@ -53,7 +53,6 @@ static int au1k_irda_hard_xmit(struct sk_buff *, struct net_device *);
 static int au1k_irda_rx(struct net_device *);
 static void au1k_irda_interrupt(int, void *);
 static void au1k_tx_timeout(struct net_device *);
-static struct net_device_stats *au1k_irda_stats(struct net_device *);
 static int au1k_irda_ioctl(struct net_device *, struct ifreq *, int);
 static int au1k_irda_set_speed(struct net_device *dev, int speed);
 
@@ -213,7 +212,6 @@ static int au1k_irda_net_init(struct net_device *dev)
 	dev->open = au1k_irda_start;
 	dev->hard_start_xmit = au1k_irda_hard_xmit;
 	dev->stop = au1k_irda_stop;
-	dev->get_stats = au1k_irda_stats;
 	dev->do_ioctl = au1k_irda_ioctl;
 	dev->tx_timeout = au1k_tx_timeout;
 
@@ -421,7 +419,7 @@ static inline void
 update_tx_stats(struct net_device *dev, u32 status, u32 pkt_len)
 {
 	struct au1k_private *aup = netdev_priv(dev);
-	struct net_device_stats *ps = &aup->stats;
+	struct net_device_stats *ps = &dev->stats;
 
 	ps->tx_packets++;
 	ps->tx_bytes += pkt_len;
@@ -557,7 +555,7 @@ static inline void
 update_rx_stats(struct net_device *dev, u32 status, u32 count)
 {
 	struct au1k_private *aup = netdev_priv(dev);
-	struct net_device_stats *ps = &aup->stats;
+	struct net_device_stats *ps = &dev->stats;
 
 	ps->rx_packets++;
 
@@ -596,7 +594,7 @@ static int au1k_irda_rx(struct net_device *dev)
 			update_rx_stats(dev, flags, count);
 			skb=alloc_skb(count+1,GFP_ATOMIC);
 			if (skb == NULL) {
-				aup->stats.rx_dropped++;
+				dev->stats.rx_dropped++;
 				continue;
 			}
 			skb_reserve(skb, 1);
@@ -833,13 +831,6 @@ au1k_irda_ioctl(struct net_device *dev, struct ifreq *ifreq, int cmd)
 	return ret;
 }
 
-
-static struct net_device_stats *au1k_irda_stats(struct net_device *dev)
-{
-	struct au1k_private *aup = netdev_priv(dev);
-	return &aup->stats;
-}
-
 MODULE_AUTHOR("Pete Popov <ppopov@mvista.com>");
 MODULE_DESCRIPTION("Au1000 IrDA Device Driver");
 

--------------030305010008050208030004--
