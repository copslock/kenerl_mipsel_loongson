Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2006 00:54:46 +0000 (GMT)
Received: from mail.engel-kg.com ([212.6.249.86]:38609 "EHLO
	centauri.engel-kg.com") by ftp.linux-mips.org with ESMTP
	id S8133445AbWCQAy2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Mar 2006 00:54:28 +0000
Received: from _HOSTNAME_ (sirius.engel-kg.com [192.168.3.112])
	by centauri.engel-kg.com (Postfix) with SMTP id C3268B896
	for <linux-mips@linux-mips.org>; Fri, 17 Mar 2006 02:03:38 +0100 (CET)
Received: by _HOSTNAME_ (sSMTP sendmail emulation); Fri, 17 Mar 2006 02:02:27 +0100
From:	"elmar gerdes" <elmar.gerdes@engel-kg.com>
Date:	Fri, 17 Mar 2006 02:02:27 +0100
To:	linux-mips@linux-mips.org
Subject: [PATCH] au1000_tx_timeout and promiscuous mode
Message-ID: <20060317010227.GA16575@engel-kg.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Return-Path: <elmar.gerdes@engel-kg.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elmar.gerdes@engel-kg.com
Precedence: bulk
X-list: linux-mips


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


hi folks,

I have seen several tx_timeouts on my two Au15xx-based boards
 - myCable XXS1500, Rev.B, Au1500-based, and
 - Kurz NVB, Au1550-based, not in kernel-tree.
 
I am running these boards in bridging mode and under kernel 2.6.16-rc6.
the timeout also appears under earlier versions, and it appears when I
cause high network load (rcp big files through the bridge).

the tx_timeout function does the re-init, but it does not re-establish
the promiscuous mode (which is set when bridging).

the patch I attached does this with a call to set_rx_mode(), and it also
introduces calls to netdev_priv(), which should be used according to
Rubini et.al. "Linux Device Drivers", 3rd edition, o-reilly.

on the 2.6.1x systems, the timeout appears after some 5 seconds, under
2.4.31 I thought it did not appear, but after half an hour of full load
I've seen it there, too.  now this makes me wonder why it takes only a
few seconds to have a tx timeout under 2.6 and half an hour under 2.4.
any ideas?

would anybody apply the patch to the official sources?  should some
timeout constant be changed to reduce the number of timeouts under 2.6?

regard,
	elmar


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="au1000_eth.c.patch"

--- __linux-2.6.16-rc6/drivers/net/au1000_eth.c.orig	2006-03-11 23:12:55.000000000 +0100
+++ __linux-2.6.16-rc6/drivers/net/au1000_eth.c	2006-03-17 01:24:20.038733224 +0100
@@ -206,7 +206,7 @@
 		printk(KERN_ERR "bcm_5201_status error: NULL dev\n");
 		return -1;
 	}
-	aup = (struct au1000_private *) dev->priv;
+	aup = netdev_priv(dev);
 
 	mii_data = mdio_read(dev, aup->phy_addr, MII_STATUS);
 	if (mii_data & MII_STAT_LINK) {
@@ -293,7 +293,7 @@
 		printk(KERN_ERR "lsi_80227_status error: NULL dev\n");
 		return -1;
 	}
-	aup = (struct au1000_private *) dev->priv;
+	aup = netdev_priv(dev);
 
 	mii_data = mdio_read(dev, aup->phy_addr, MII_STATUS);
 	if (mii_data & MII_STAT_LINK) {
@@ -404,7 +404,7 @@
 		return -1;
 	}
 
-	aup = (struct au1000_private *) dev->priv;
+	aup = netdev_priv(dev);
 	mii_data = mdio_read(dev, aup->phy_addr, MII_STATUS);
 
 	if (mii_data & MII_STAT_LINK) {
@@ -486,7 +486,7 @@
 		printk(KERN_ERR "lxt971a_status error: NULL dev\n");
 		return -1;
 	}
-	aup = (struct au1000_private *) dev->priv;
+	aup = netdev_priv(dev);
 
 	mii_data = mdio_read(dev, aup->phy_addr, MII_STATUS);
 	if (mii_data & MII_STAT_LINK) {
@@ -571,7 +571,7 @@
 		printk(KERN_ERR "ks8995m_status error: NULL dev\n");
 		return -1;
 	}
-	aup = (struct au1000_private *) dev->priv;
+	aup = netdev_priv(dev);
 
 	mii_data = mdio_read(dev, aup->phy_addr, MII_STATUS);
 	if (mii_data & MII_STAT_LINK) {
@@ -664,7 +664,7 @@
 		return -1;
 	}
 
-	aup = (struct au1000_private *) dev->priv;
+	aup = netdev_priv(dev);
 	mii_data = mdio_read(dev, aup->phy_addr, MII_STATUS);
 
 	if (mii_data & MII_STAT_LINK) {
@@ -794,7 +794,7 @@
 
 static int mdio_read(struct net_device *dev, int phy_id, int reg)
 {
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 	volatile u32 *mii_control_reg;
 	volatile u32 *mii_data_reg;
 	u32 timedout = 20;
@@ -854,7 +854,7 @@
 
 static void mdio_write(struct net_device *dev, int phy_id, int reg, u16 value)
 {
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 	volatile u32 *mii_control_reg;
 	volatile u32 *mii_data_reg;
 	u32 timedout = 20;
@@ -911,7 +911,7 @@
 
 static int mii_probe (struct net_device * dev)
 {
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 	int phy_addr;
 #ifdef CONFIG_MIPS_BOSPORUS
 	int phy_found=0;
@@ -1078,7 +1078,7 @@
 
 static void enable_rx_tx(struct net_device *dev)
 {
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 
 	if (au1000_debug > 4)
 		printk(KERN_INFO "%s: enable_rx_tx\n", dev->name);
@@ -1089,7 +1089,7 @@
 
 static void hard_stop(struct net_device *dev)
 {
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 
 	if (au1000_debug > 4)
 		printk(KERN_INFO "%s: hard stop\n", dev->name);
@@ -1103,7 +1103,7 @@
 {
 	int i;
 	u32 flags;
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 
 	if (au1000_debug > 4) 
 		printk(KERN_INFO "%s: reset mac, aup %x\n", 
@@ -1240,7 +1240,7 @@
 
 static int au1000_setup_aneg(struct net_device *dev, u32 advertise)
 {
-	struct au1000_private *aup = (struct au1000_private *)dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 	u16 ctl, adv;
 
 	/* Setup standard advertise */
@@ -1266,7 +1266,7 @@
 
 static int au1000_setup_forced(struct net_device *dev, int speed, int fd)
 {
-	struct au1000_private *aup = (struct au1000_private *)dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 	u16 ctl;
 
 	ctl = mdio_read(dev, aup->phy_addr, MII_BMCR);
@@ -1297,7 +1297,7 @@
 static void
 au1000_start_link(struct net_device *dev, struct ethtool_cmd *cmd)
 {
-	struct au1000_private *aup = (struct au1000_private *)dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 	u32 advertise;
 	int autoneg;
 	int forced_speed;
@@ -1333,7 +1333,7 @@
 
 static int au1000_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
-	struct au1000_private *aup = (struct au1000_private *)dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 	u16 link, speed;
 
 	cmd->supported = GENMII_DEFAULT_FEATURES;
@@ -1358,7 +1358,7 @@
 
 static int au1000_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
-	 struct au1000_private *aup = (struct au1000_private *)dev->priv;
+	 struct au1000_private *aup = netdev_priv(dev);
 	  unsigned long features = GENMII_DEFAULT_FEATURES;
 
 	 if (!capable(CAP_NET_ADMIN))
@@ -1402,7 +1402,7 @@
 
 static int au1000_nway_reset(struct net_device *dev)
 {
-	struct au1000_private *aup = (struct au1000_private *)dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 
 	if (!aup->want_autoneg)
 		return -EINVAL;
@@ -1415,7 +1415,7 @@
 static void
 au1000_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
 {
-	struct au1000_private *aup = (struct au1000_private *)dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 
 	strcpy(info->driver, DRV_NAME);
 	strcpy(info->version, DRV_VERSION);
@@ -1470,7 +1470,7 @@
 	printk("%s: Au1x Ethernet found at 0x%x, irq %d\n", 
 			dev->name, ioaddr, irq);
 
-	aup = dev->priv;
+	aup = netdev_priv(dev);
 
 	/* Allocate the data buffers */
 	/* Snooping works fine with eth on all au1xxx */
@@ -1637,7 +1637,7 @@
  */
 static int au1000_init(struct net_device *dev)
 {
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 	u32 flags;
 	int i;
 	u32 control;
@@ -1689,7 +1689,7 @@
 static void au1000_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 	unsigned char if_port;
 	u16 link, speed;
 
@@ -1742,7 +1742,7 @@
 static int au1000_open(struct net_device *dev)
 {
 	int retval;
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 
 	if (au1000_debug > 4)
 		printk("%s: open: dev=%p\n", dev->name, dev);
@@ -1776,7 +1776,7 @@
 static int au1000_close(struct net_device *dev)
 {
 	u32 flags;
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 
 	if (au1000_debug > 4)
 		printk("%s: close: dev=%p\n", dev->name, dev);
@@ -1804,7 +1804,7 @@
 	for (i = 0; i < num_ifs; i++) {
 		dev = iflist[i].dev;
 		if (dev) {
-			aup = (struct au1000_private *) dev->priv;
+			aup = netdev_priv(dev);
 			unregister_netdev(dev);
 			kfree(aup->mii);
 			for (j = 0; j < NUM_RX_DMA; j++) {
@@ -1829,7 +1829,7 @@
 static inline void 
 update_tx_stats(struct net_device *dev, u32 status, u32 pkt_len)
 {
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 	struct net_device_stats *ps = &aup->stats;
 
 	ps->tx_packets++;
@@ -1861,7 +1861,7 @@
  */
 static void au1000_tx_ack(struct net_device *dev)
 {
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 	volatile tx_dma_t *ptxd;
 
 	ptxd = aup->tx_dma_ring[aup->tx_tail];
@@ -1888,7 +1888,7 @@
  */
 static int au1000_tx(struct sk_buff *skb, struct net_device *dev)
 {
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 	volatile tx_dma_t *ptxd;
 	u32 buff_stat;
 	db_dest_t *pDB;
@@ -1939,7 +1939,7 @@
 
 static inline void update_rx_stats(struct net_device *dev, u32 status)
 {
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 	struct net_device_stats *ps = &aup->stats;
 
 	ps->rx_packets++;
@@ -1967,7 +1967,7 @@
  */
 static int au1000_rx(struct net_device *dev)
 {
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 	struct sk_buff *skb;
 	volatile rx_dma_t *prxd;
 	u32 buff_stat, status;
@@ -2070,6 +2070,7 @@
 	printk(KERN_ERR "%s: au1000_tx_timeout: dev=%p\n", dev->name, dev);
 	reset_mac(dev);
 	au1000_init(dev);
+	set_rx_mode(dev);	// EG 2006-03-15: set promiscuous mode
 	dev->trans_start = jiffies;
 	netif_wake_queue(dev);
 }
@@ -2093,7 +2094,7 @@
 
 static void set_rx_mode(struct net_device *dev)
 {
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 
 	if (au1000_debug > 4) 
 		printk("%s: set_rx_mode: flags=%x\n", dev->name, dev->flags);
@@ -2127,7 +2128,7 @@
 
 static int au1000_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	struct au1000_private *aup = (struct au1000_private *)dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 	u16 *data = (u16 *)&rq->ifr_ifru;
 
 	switch(cmd) { 
@@ -2154,7 +2155,7 @@
 
 static int au1000_set_config(struct net_device *dev, struct ifmap *map)
 {
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 	u16 control;
 
 	if (au1000_debug > 4)  {
@@ -2248,7 +2249,7 @@
 
 static struct net_device_stats *au1000_get_stats(struct net_device *dev)
 {
-	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct au1000_private *aup = netdev_priv(dev);
 
 	if (au1000_debug > 4)
 		printk("%s: au1000_get_stats: dev=%p\n", dev->name, dev);

--AhhlLboLdkugWU4S--
