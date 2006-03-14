Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2006 02:14:33 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:25067 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8134488AbWCNCOY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Mar 2006 02:14:24 +0000
Received: (qmail 6525 invoked from network); 14 Mar 2006 02:23:27 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 14 Mar 2006 02:23:27 -0000
Message-ID: <441628AF.2000300@ru.mvista.com>
Date:	Tue, 14 Mar 2006 05:21:35 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: [PATCH] Fix for Au1x00 ethernet tx stats
References: <41F11AB7.3010105@corelatus.se>
In-Reply-To: <41F11AB7.3010105@corelatus.se>
Content-Type: multipart/mixed;
 boundary="------------080502030207000009010206"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080502030207000009010206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Thomas Lange wrote:
> With current CVS head, ethernet TX bytes always remain zero.
> 
> The problem seems to be that when packet has been transmitted,
> the len word in DMA buffer is zero.
> 
> Attached is a patch against 2_4 HEAD that updates the stats when
> DMA buffer is written to fix this.
> 
> * Patch by Thomas Lange, 21 Jan 2005:
>  Fix update of ethernet tx bytes stats for au1x00

      More than a year ago, this is still an issue with both 2.4 and 2.6 driver.
Here's the 2.6 patch...

> /Thomas

WBR, Sergei

Signed-off-by: Thomas Lange <thomas@corelatus.se>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------080502030207000009010206
Content-Type: text/plain;
 name="Au1xx0-ETH-fix-TX-stats.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1xx0-ETH-fix-TX-stats.patch"

diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
index cd0b1dc..a4df316 100644
--- a/drivers/net/au1000_eth.c
+++ b/drivers/net/au1000_eth.c
@@ -90,7 +90,7 @@ static void au1000_tx_timeout(struct net
 static int au1000_set_config(struct net_device *dev, struct ifmap *map);
 static void set_rx_mode(struct net_device *);
 static struct net_device_stats *au1000_get_stats(struct net_device *);
-static inline void update_tx_stats(struct net_device *, u32, u32);
+static inline void update_tx_stats(struct net_device *, u32);
 static inline void update_rx_stats(struct net_device *, u32);
 static void au1000_timer(unsigned long);
 static int au1000_ioctl(struct net_device *, struct ifreq *, int);
@@ -1827,14 +1827,11 @@ static void __exit au1000_cleanup_module
 
 
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
@@ -1867,7 +1864,7 @@ static void au1000_tx_ack(struct net_dev
 	ptxd = aup->tx_dma_ring[aup->tx_tail];
 
 	while (ptxd->buff_stat & TX_T_DONE) {
-		update_tx_stats(dev, ptxd->status, ptxd->len & 0x3ff);
+		update_tx_stats(dev, ptxd->status);
 		ptxd->buff_stat &= ~TX_T_DONE;
 		ptxd->len = 0;
 		au_sync();
@@ -1889,6 +1886,7 @@ static void au1000_tx_ack(struct net_dev
 static int au1000_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct net_device_stats *ps = &aup->stats;
 	volatile tx_dma_t *ptxd;
 	u32 buff_stat;
 	db_dest_t *pDB;
@@ -1908,7 +1906,7 @@ static int au1000_tx(struct sk_buff *skb
 		return 1;
 	}
 	else if (buff_stat & TX_T_DONE) {
-		update_tx_stats(dev, ptxd->status, ptxd->len & 0x3ff);
+		update_tx_stats(dev, ptxd->status);
 		ptxd->len = 0;
 	}
 
@@ -1928,6 +1926,9 @@ static int au1000_tx(struct sk_buff *skb
 	else
 		ptxd->len = skb->len;
 
+	ps->tx_packets++;
+	ps->tx_bytes += ptxd->len;
+
 	ptxd->buff_stat = pDB->dma_addr | TX_DMA_ENABLE;
 	au_sync();
 	dev_kfree_skb(skb);


--------------080502030207000009010206--
