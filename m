Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Sep 2002 11:31:54 +0200 (CEST)
Received: from mail.scram.de ([195.226.127.117]:33992 "EHLO mail.scram.de")
	by linux-mips.org with ESMTP id <S1121744AbSI2Jby>;
	Sun, 29 Sep 2002 11:31:54 +0200
Received: from alpha.bocc.de (p5080D7EC.dip.t-dialin.net [80.128.215.236])
	(authenticated)
	by mail.scram.de (8.11.6+3.4W/8.11.0) with ESMTP id g8T9VeA03260;
	Sun, 29 Sep 2002 11:31:42 +0200 (CEST)
Date: Sun, 29 Sep 2002 11:31:32 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@alpha.bocc.de
To: linux-mips@linux-mips.org
cc: debian-ipv6@lists.debian.org
Subject: IPv6 support on Indy
Message-ID: <Pine.LNX.4.44.0209282246520.30409-100000@alpha.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <jochen@scram.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jochen@scram.de
Precedence: bulk
X-list: linux-mips

Hi,

it looks like IPv6 support on Indy is pretty bad because the
builtin ethernet doesn't receive multicast frames (Protocols like OSPF or
RIP2 suffer problems, as well). The following patch is supposed to fix
this.

I guess my Indy is the first one talking IPv6 under Linux then ;-)

--jochen

--- sgiseeq.c.orig	2002-09-29 08:58:12.000000000 +0200
+++ sgiseeq.c	2002-09-29 11:24:48.000000000 +0200
@@ -161,12 +161,6 @@

 	seeq_load_eaddr(dev, sp->sregs);

-	/* XXX for now just accept packets directly to us
-	 * XXX and ether-broadcast.  Will do multicast and
-	 * XXX promiscuous mode later. -davem
-	 */
-	sp->mode = SEEQ_RCMD_RBCAST;
-
 	/* Setup tx ring. */
 	for(i = 0; i < SEEQ_TX_BUFFERS; i++) {
 		if(!ib->tx_desc[i].tdma.pbuf) {
@@ -333,10 +327,15 @@
 				/* Copy out of kseg1 to avoid silly cache flush. */
 				eth_copy_and_sum(skb, pkt_pointer + 2, len, 0);
 				skb->protocol = eth_type_trans(skb, dev);
-				netif_rx(skb);
-				dev->last_rx = jiffies;
-				sp->stats.rx_packets++;
-				sp->stats.rx_bytes += len;
+				if (memcmp(skb->mac.ethernet->h_source, dev->dev_addr, 6)) {
+					netif_rx(skb);
+					dev->last_rx = jiffies;
+					sp->stats.rx_packets++;
+					sp->stats.rx_bytes += len;
+				} else {
+					/* Silently drop my own packets */
+					dev_kfree_skb_irq(skb);
+				}
 			} else {
 				printk ("%s: Memory squeeze, deferring packet.\n",
 					dev->name);
@@ -579,6 +578,22 @@

 static void sgiseeq_set_multicast(struct net_device *dev)
 {
+	struct sgiseeq_private *sp = (struct sgiseeq_private *) dev->priv;
+	unsigned char oldmode = sp->mode;
+
+	if(dev->flags & IFF_PROMISC)
+		sp->mode = SEEQ_RCMD_RANY;
+	else if ((dev->flags & IFF_ALLMULTI) || dev->mc_count)
+		sp->mode = SEEQ_RCMD_RBMCAST;
+	else
+		sp->mode = SEEQ_RCMD_RBCAST;
+
+	/* XXX I know this sucks, but is there a better way to reprogram
+	 * XXX the receiver? At least, this shouldn't happen too often.
+	 */
+
+	if (oldmode != sp->mode)
+		sgiseeq_reset(dev);
 }

 static inline void setup_tx_ring(struct sgiseeq_tx_desc *buf, int nbufs)
@@ -642,6 +657,7 @@
 	sp->sregs = sregs;
 	sp->hregs = hregs;
 	sp->name = sgiseeqstr;
+	sp->mode = SEEQ_RCMD_RBCAST;

 	sp->srings.rx_desc = (struct sgiseeq_rx_desc *)
 	                     (KSEG1ADDR(ALIGNED(&sp->srings.rxvector[0])));
