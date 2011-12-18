Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Dec 2011 01:56:49 +0100 (CET)
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:51836
        "EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903726Ab1LRA4m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Dec 2011 01:56:42 +0100
Received: from omta02.westchester.pa.mail.comcast.net ([76.96.62.19])
        by qmta09.westchester.pa.mail.comcast.net with comcast
        id AQjr1i0030QuhwU59Qwciz; Sun, 18 Dec 2011 00:56:36 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta02.westchester.pa.mail.comcast.net with comcast
        id AQwb1i00r1rgsis3NQwb7F; Sun, 18 Dec 2011 00:56:36 +0000
Message-ID: <4EED3A3D.9080503@gentoo.org>
Date:   Sat, 17 Dec 2011 19:56:29 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     netdev@vger.kernel.org, Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH] net: meth: Add set_rx_mode hook to fix ICMPv6 neighbor discovery
X-Enigmail-Version: 1.3.3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14294

SGI IP32 (O2)'s ethernet driver (meth) lacks a set_rx_mode function, which
prevents IPv6 from working completely because any ICMPv6 neighbor
solicitation requests aren't picked up by the driver.  So the machine can
ping out and connect to other systems, but other systems will have a very
hard time connecting to the O2.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---

 drivers/net/ethernet/sgi/meth.c |   60 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/sgi/meth.c	2011-12-17 15:51:44.569166824 -0500
+++ b/drivers/net/ethernet/sgi/meth.c	2011-12-17 15:51:20.259167050 -0500
@@ -28,6 +28,7 @@
 #include <linux/tcp.h>         /* struct tcphdr */
 #include <linux/skbuff.h>
 #include <linux/mii.h>         /* MII definitions */
+#include <linux/crc32.h>

 #include <asm/ip32/mace.h>
 #include <asm/ip32/ip32_ints.h>
@@ -57,6 +58,12 @@ static const char *meth_str="SGI O2 Fast
 static int timeout = TX_TIMEOUT;
 module_param(timeout, int, 0);

+/* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
+ * MACE Ethernet uses a 64 element hash table based on the Ethernet CRC.
+ */
+static int multicast_filter_limit = 32;
+
+
 /*
  * This structure is private to each device. It is used to pass
  * packets in and out, so there is place for a packet
@@ -79,6 +86,9 @@ struct meth_private {
 	struct sk_buff *rx_skbs[RX_RING_ENTRIES];
 	unsigned long rx_write;

+	/* Multicast filter. */
+	unsigned long mcast_filter;
+
 	spinlock_t meth_lock;
 };

@@ -765,15 +775,51 @@ static int meth_ioctl(struct net_device
 	}
 }

+static void meth_set_rx_mode(struct net_device *dev)
+{
+	struct meth_private *priv = netdev_priv(dev);
+	unsigned long flags;
+
+	netif_stop_queue(dev);
+	spin_lock_irqsave(&priv->meth_lock, flags);
+	priv->mac_ctrl &= ~(METH_PROMISC);
+
+	if (dev->flags & IFF_PROMISC) {
+		priv->mac_ctrl |= METH_PROMISC;
+		priv->mcast_filter = 0xffffffffffffffffUL;
+		mace->eth.mac_ctrl = priv->mac_ctrl;
+		mace->eth.mcast_filter = priv->mcast_filter;
+	} else if ((netdev_mc_count(dev) > multicast_filter_limit) ||
+			   (dev->flags & IFF_ALLMULTI)) {
+			priv->mac_ctrl |= METH_ACCEPT_AMCAST;
+			priv->mcast_filter = 0xffffffffffffffffUL;
+			mace->eth.mac_ctrl = priv->mac_ctrl;
+			mace->eth.mcast_filter = priv->mcast_filter;
+	} else {
+		struct netdev_hw_addr *ha;
+		priv->mac_ctrl |= METH_ACCEPT_MCAST;
+
+		netdev_for_each_mc_addr(ha, dev)
+			set_bit((ether_crc(ETH_ALEN, ha->addr) >> 26),
+				    (volatile long unsigned int *)&priv->mcast_filter);
+
+		mace->eth.mcast_filter = priv->mcast_filter;
+	}
+
+	spin_unlock_irqrestore(&priv->meth_lock, flags);
+	netif_wake_queue(dev);
+}
+
 static const struct net_device_ops meth_netdev_ops = {
-	.ndo_open		= meth_open,
-	.ndo_stop		= meth_release,
-	.ndo_start_xmit		= meth_tx,
-	.ndo_do_ioctl		= meth_ioctl,
-	.ndo_tx_timeout		= meth_tx_timeout,
-	.ndo_change_mtu		= eth_change_mtu,
-	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_open				= meth_open,
+	.ndo_stop				= meth_release,
+	.ndo_start_xmit			= meth_tx,
+	.ndo_do_ioctl			= meth_ioctl,
+	.ndo_tx_timeout			= meth_tx_timeout,
+	.ndo_change_mtu			= eth_change_mtu,
+	.ndo_validate_addr		= eth_validate_addr,
 	.ndo_set_mac_address	= eth_mac_addr,
+	.ndo_set_rx_mode    	= meth_set_rx_mode,
 };

 /*
