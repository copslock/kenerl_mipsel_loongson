From: Maarten Lankhorst <a class="moz-txt-link-rfc2396E" href="mailto:M.B.Lankhorst@gmail.com">&lt;M.B.Lankhorst@gmail.com&gt;</a>
Date: Tue, 10 Oct 2006 13:15:40 +0200
Subject: [PATCH] b44 bcm47xx support
Message-ID: <20061010111540.xLjEI8U6pt4BR1gmgKZi_cSUewH0GDeYj9BDh4XUDN8@z>

---
 drivers/net/b44.c |  524 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/net/b44.h |    8 +
 2 files changed, 481 insertions(+), 51 deletions(-)

diff --git a/drivers/net/b44.c b/drivers/net/b44.c
index b124eee..a9717ba 100644
--- a/drivers/net/b44.c
+++ b/drivers/net/b44.c
@@ -1,8 +1,10 @@
-/* b44.c: Broadcom 4400 device driver.
+/* b44.c: Broadcom 4400/47xx device driver.
  *
  * Copyright (C) 2002 David S. Miller (<a class="moz-txt-link-abbreviated" href="mailto:davem@redhat.com">davem@redhat.com</a>)
- * Fixed by Pekka Pietikainen (<a class="moz-txt-link-abbreviated" href="mailto:pp@ee.oulu.fi">pp@ee.oulu.fi</a>)
+ * Copyright (C) 2004 Pekka Pietikainen (<a class="moz-txt-link-abbreviated" href="mailto:pp@ee.oulu.fi">pp@ee.oulu.fi</a>)
+ * Copyright (C) 2004 Florian Schirmer (<a class="moz-txt-link-abbreviated" href="mailto:jolt@tuxbox.org">jolt@tuxbox.org</a>)
  * Copyright (C) 2006 Broadcom Corporation.
+ * Copyright (C) 2006 Felix Fietkau (<a class="moz-txt-link-abbreviated" href="mailto:nbd@openwrt.org">nbd@openwrt.org</a>)
  *
  * Distribute under GPL.
  */
@@ -32,6 +34,28 @@ #define PFX DRV_MODULE_NAME	": "
 #define DRV_MODULE_VERSION	"1.01"
 #define DRV_MODULE_RELDATE	"Jun 16, 2006"
 
+#ifdef CONFIG_BCM947XX
+extern char *nvram_get(char *name);
+static inline void e_aton(char *str, char *dest)
+{
+	int i = 0;
+
+	if (str == NULL) {
+		memset(dest, 0, 6);
+		return;
+	}
+	
+	for (;;) {
+		dest[i++] = (char) simple_strtoul(str, NULL, 16);
+		str += 2;
+		if (!*str++ || i == 6)
+			break;
+	}
+}
+
+static int b44_4713_instance;
+#endif
+
 #define B44_DEF_MSG_ENABLE	  \
 	(NETIF_MSG_DRV		| \
 	 NETIF_MSG_PROBE	| \
@@ -87,8 +111,8 @@ #define B44_ETHIPV4UDP_HLEN	42
 static char version[] __devinitdata =
 	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
 
-MODULE_AUTHOR("Florian Schirmer, Pekka Pietikainen, David S. Miller");
-MODULE_DESCRIPTION("Broadcom 4400 10/100 PCI ethernet driver");
+MODULE_AUTHOR("Felix Fietkau, Florian Schirmer, Pekka Pietikainen, David S. Miller");
+MODULE_DESCRIPTION("Broadcom 4400/47xx 10/100 PCI ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_MODULE_VERSION);
 
@@ -103,6 +127,10 @@ static struct pci_device_id b44_pci_tbl[
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401B1,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+#ifdef CONFIG_BCM947XX
+	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4713,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+#endif
 	{ }	/* terminate list with empty entry */
 };
 
@@ -141,17 +169,6 @@ static inline void b44_sync_dma_desc_for
 	                              dma_desc_sync_size, dir);
 }
 
-static inline unsigned long br32(const struct b44 *bp, unsigned long reg)
-{
-	return readl(bp-&gt;regs + reg);
-}
-
-static inline void bw32(const struct b44 *bp,
-			unsigned long reg, unsigned long val)
-{
-	writel(val, bp-&gt;regs + reg);
-}
-
 static int b44_wait_bit(struct b44 *bp, unsigned long reg,
 			u32 bit, unsigned long timeout, const int clear)
 {
@@ -278,6 +295,10 @@ #if 0
 		break;
 	};
 #endif
+#ifdef CONFIG_BCM947XX
+	if (bp-&gt;pdev-&gt;device == PCI_DEVICE_ID_BCM4713)
+		return b44_4713_instance++;
+#endif
 	return 0;
 }
 
@@ -287,6 +308,30 @@ static int ssb_is_core_up(struct b44 *bp
 		== SBTMSLOW_CLOCK);
 }
 
+#ifdef CONFIG_BCM947XX
+static inline void __b44_cam_read(struct b44 *bp, unsigned char *data, int index)
+{
+	u32 val;
+
+	bw32(bp, B44_CAM_CTRL, (CAM_CTRL_READ |
+			    (index &lt;&lt; CAM_CTRL_INDEX_SHIFT)));
+
+	b44_wait_bit(bp, B44_CAM_CTRL, CAM_CTRL_BUSY, 100, 1);
+
+	val = br32(bp, B44_CAM_DATA_LO);
+
+	data[2] = (val &gt;&gt; 24) &amp; 0xFF;
+	data[3] = (val &gt;&gt; 16) &amp; 0xFF;
+	data[4] = (val &gt;&gt; 8) &amp; 0xFF;
+	data[5] = (val &gt;&gt; 0) &amp; 0xFF;
+
+	val = br32(bp, B44_CAM_DATA_HI);
+
+	data[0] = (val &gt;&gt; 8) &amp; 0xFF;
+	data[1] = (val &gt;&gt; 0) &amp; 0xFF;
+}
+#endif
+
 static void __b44_cam_write(struct b44 *bp, unsigned char *data, int index)
 {
 	u32 val;
@@ -323,14 +368,14 @@ static void b44_enable_ints(struct b44 *
 	bw32(bp, B44_IMASK, bp-&gt;imask);
 }
 
-static int b44_readphy(struct b44 *bp, int reg, u32 *val)
+static int __b44_readphy(struct b44 *bp, int phy_addr, int reg, u32 *val)
 {
 	int err;
 
 	bw32(bp, B44_EMAC_ISTAT, EMAC_INT_MII);
 	bw32(bp, B44_MDIO_DATA, (MDIO_DATA_SB_START |
 			     (MDIO_OP_READ &lt;&lt; MDIO_DATA_OP_SHIFT) |
-			     (bp-&gt;phy_addr &lt;&lt; MDIO_DATA_PMD_SHIFT) |
+			     (phy_addr &lt;&lt; MDIO_DATA_PMD_SHIFT) |
 			     (reg &lt;&lt; MDIO_DATA_RA_SHIFT) |
 			     (MDIO_TA_VALID &lt;&lt; MDIO_DATA_TA_SHIFT)));
 	err = b44_wait_bit(bp, B44_EMAC_ISTAT, EMAC_INT_MII, 100, 0);
@@ -339,18 +384,34 @@ static int b44_readphy(struct b44 *bp, i
 	return err;
 }
 
-static int b44_writephy(struct b44 *bp, int reg, u32 val)
+static int __b44_writephy(struct b44 *bp, int phy_addr, int reg, u32 val)
 {
 	bw32(bp, B44_EMAC_ISTAT, EMAC_INT_MII);
 	bw32(bp, B44_MDIO_DATA, (MDIO_DATA_SB_START |
 			     (MDIO_OP_WRITE &lt;&lt; MDIO_DATA_OP_SHIFT) |
-			     (bp-&gt;phy_addr &lt;&lt; MDIO_DATA_PMD_SHIFT) |
+			     (phy_addr &lt;&lt; MDIO_DATA_PMD_SHIFT) |
 			     (reg &lt;&lt; MDIO_DATA_RA_SHIFT) |
 			     (MDIO_TA_VALID &lt;&lt; MDIO_DATA_TA_SHIFT) |
 			     (val &amp; MDIO_DATA_DATA)));
 	return b44_wait_bit(bp, B44_EMAC_ISTAT, EMAC_INT_MII, 100, 0);
 }
 
+static inline int b44_readphy(struct b44 *bp, int reg, u32 *val)
+{
+	if (bp-&gt;phy_addr == B44_PHY_ADDR_NO_PHY)
+		return 0;
+
+	return __b44_readphy(bp, bp-&gt;phy_addr, reg, val);
+}
+
+static inline int b44_writephy(struct b44 *bp, int reg, u32 val)
+{
+	if (bp-&gt;phy_addr == B44_PHY_ADDR_NO_PHY)
+		return 0;
+		
+	return __b44_writephy(bp, bp-&gt;phy_addr, reg, val);
+}
+
 /* miilib interface */
 /* FIXME FIXME: phy_id is ignored, bp-&gt;phy_addr use is unconditional
  * due to code existing before miilib use was added to this driver.
@@ -379,6 +440,8 @@ static int b44_phy_reset(struct b44 *bp)
 	u32 val;
 	int err;
 
+	if (bp-&gt;phy_addr == B44_PHY_ADDR_NO_PHY)
+		return 0;
 	err = b44_writephy(bp, MII_BMCR, BMCR_RESET);
 	if (err)
 		return err;
@@ -442,6 +505,22 @@ static int b44_setup_phy(struct b44 *bp)
 	u32 val;
 	int err;
 
+#ifdef CONFIG_BCM947XX
+	/*
+	 * workaround for bad hardware design in Linksys WAP54G v1.0
+	 * see <a class="moz-txt-link-freetext" href="https://dev.openwrt.org/ticket/146">https://dev.openwrt.org/ticket/146</a>
+	 * check and reset bit "isolate"
+	 */
+	if ((bp-&gt;pdev-&gt;device == PCI_DEVICE_ID_BCM4713) &amp;&amp;
+			(atoi(nvram_get("boardnum")) == 2) &amp;&amp;
+			(__b44_readphy(bp, 0, MII_BMCR, &amp;val) == 0) &amp;&amp; 
+			(val &amp; BMCR_ISOLATE) &amp;&amp;
+			(__b44_writephy(bp, 0, MII_BMCR, val &amp; ~BMCR_ISOLATE) != 0)) {
+		printk(KERN_WARNING PFX "PHY: cannot reset MII transceiver isolate bit.\n");
+	}
+#endif
+	if (bp-&gt;phy_addr == B44_PHY_ADDR_NO_PHY)
+		return 0;
 	if ((err = b44_readphy(bp, B44_MII_ALEDCTRL, &amp;val)) != 0)
 		goto out;
 	if ((err = b44_writephy(bp, B44_MII_ALEDCTRL,
@@ -537,6 +616,19 @@ static void b44_check_phy(struct b44 *bp
 {
 	u32 bmsr, aux;
 
+	if (bp-&gt;phy_addr == B44_PHY_ADDR_NO_PHY) {
+		bp-&gt;flags |= B44_FLAG_100_BASE_T;
+		bp-&gt;flags |= B44_FLAG_FULL_DUPLEX;
+		if (!netif_carrier_ok(bp-&gt;dev)) {
+			u32 val = br32(bp, B44_TX_CTRL);
+			val |= TX_CTRL_DUPLEX;
+			bw32(bp, B44_TX_CTRL, val);
+			netif_carrier_on(bp-&gt;dev);
+			b44_link_report(bp);
+		}
+		return;
+	}
+
 	if (!b44_readphy(bp, MII_BMSR, &amp;bmsr) &amp;&amp;
 	    !b44_readphy(bp, B44_MII_AUXCTRL, &amp;aux) &amp;&amp;
 	    (bmsr != 0xffff)) {
@@ -1291,9 +1383,10 @@ static void b44_chip_reset(struct b44 *b
 		bw32(bp, B44_DMARX_CTRL, 0);
 		bp-&gt;rx_prod = bp-&gt;rx_cons = 0;
 	} else {
-		ssb_pci_setup(bp, (bp-&gt;core_unit == 0 ?
-				   SBINTVEC_ENET0 :
-				   SBINTVEC_ENET1));
+		if (bp-&gt;pdev-&gt;device != PCI_DEVICE_ID_BCM4713)
+			ssb_pci_setup(bp, (bp-&gt;core_unit == 0 ?
+					   SBINTVEC_ENET0 :
+					   SBINTVEC_ENET1));
 	}
 
 	ssb_core_reset(bp);
@@ -1301,8 +1394,14 @@ static void b44_chip_reset(struct b44 *b
 	b44_clear_stats(bp);
 
 	/* Make PHY accessible. */
-	bw32(bp, B44_MDIO_CTRL, (MDIO_CTRL_PREAMBLE |
+	if (bp-&gt;pdev-&gt;device == PCI_DEVICE_ID_BCM4713)
+		bw32(bp, B44_MDIO_CTRL, (MDIO_CTRL_PREAMBLE |
+			     (((100000000 + (B44_MDC_RATIO / 2)) / B44_MDC_RATIO)
+			     &amp; MDIO_CTRL_MAXF_MASK)));
+	else
+		bw32(bp, B44_MDIO_CTRL, (MDIO_CTRL_PREAMBLE |
 			     (0x0d &amp; MDIO_CTRL_MAXF_MASK)));
+
 	br32(bp, B44_MDIO_CTRL);
 
 	if (!(br32(bp, B44_DEVCTRL) &amp; DEVCTRL_IPP)) {
@@ -1345,6 +1444,7 @@ static int b44_set_mac_addr(struct net_d
 {
 	struct b44 *bp = netdev_priv(dev);
 	struct sockaddr *addr = p;
+ 	u32 val;
 
 	if (netif_running(dev))
 		return -EBUSY;
@@ -1355,7 +1455,11 @@ static int b44_set_mac_addr(struct net_d
 	memcpy(dev-&gt;dev_addr, addr-&gt;sa_data, dev-&gt;addr_len);
 
 	spin_lock_irq(&amp;bp-&gt;lock);
-	__b44_set_mac_addr(bp);
+   
+   	val = br32(bp, B44_RXCONFIG);
+   	if (!(val &amp; RXCONFIG_CAM_ABSENT))
+		__b44_set_mac_addr(bp);
+   
 	spin_unlock_irq(&amp;bp-&gt;lock);
 
 	return 0;
@@ -1697,7 +1801,7 @@ static void __b44_set_rx_mode(struct net
 
 	val = br32(bp, B44_RXCONFIG);
 	val &amp;= ~(RXCONFIG_PROMISC | RXCONFIG_ALLMULTI);
-	if (dev-&gt;flags &amp; IFF_PROMISC) {
+	if ((dev-&gt;flags &amp; IFF_PROMISC) || (val &amp; RXCONFIG_CAM_ABSENT)) {
 		val |= RXCONFIG_PROMISC;
 		bw32(bp, B44_RXCONFIG, val);
 	} else {
@@ -2032,18 +2136,297 @@ static const struct ethtool_ops b44_etht
 	.get_perm_addr		= ethtool_op_get_perm_addr,
 };
 
+static int b44_ethtool_ioctl (struct net_device *dev, void __user *useraddr)
+{
+	struct b44 *bp = dev-&gt;priv;
+	struct pci_dev *pci_dev = bp-&gt;pdev;
+	u32 ethcmd;
+
+	if (copy_from_user (&amp;ethcmd, useraddr, sizeof (ethcmd)))
+		return -EFAULT;
+
+	switch (ethcmd) {
+	case ETHTOOL_GDRVINFO: {
+		struct ethtool_drvinfo info = { ETHTOOL_GDRVINFO };
+		strcpy (info.driver, DRV_MODULE_NAME);
+		strcpy (info.version, DRV_MODULE_VERSION);
+		memset(&amp;info.fw_version, 0, sizeof(info.fw_version));
+		strcpy (info.bus_info, pci_name(pci_dev));
+		info.eedump_len = 0;
+		info.regdump_len = 0;
+		if (copy_to_user (useraddr, &amp;info, sizeof (info)))
+			return -EFAULT;
+		return 0;
+	}
+
+	case ETHTOOL_GSET: {
+		struct ethtool_cmd cmd = { ETHTOOL_GSET };
+
+		if (!(bp-&gt;flags &amp; B44_FLAG_INIT_COMPLETE))
+			return -EAGAIN;
+		cmd.supported = (SUPPORTED_Autoneg);
+		cmd.supported |= (SUPPORTED_100baseT_Half |
+				  SUPPORTED_100baseT_Full |
+				  SUPPORTED_10baseT_Half |
+				  SUPPORTED_10baseT_Full |
+				  SUPPORTED_MII);
+
+		cmd.advertising = 0;
+		if (bp-&gt;flags &amp; B44_FLAG_ADV_10HALF)
+			cmd.advertising |= ADVERTISE_10HALF;
+		if (bp-&gt;flags &amp; B44_FLAG_ADV_10FULL)
+			cmd.advertising |= ADVERTISE_10FULL;
+		if (bp-&gt;flags &amp; B44_FLAG_ADV_100HALF)
+			cmd.advertising |= ADVERTISE_100HALF;
+		if (bp-&gt;flags &amp; B44_FLAG_ADV_100FULL)
+			cmd.advertising |= ADVERTISE_100FULL;
+		cmd.advertising |= ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM;
+		cmd.speed = (bp-&gt;flags &amp; B44_FLAG_100_BASE_T) ?
+			SPEED_100 : SPEED_10;
+		cmd.duplex = (bp-&gt;flags &amp; B44_FLAG_FULL_DUPLEX) ?
+			DUPLEX_FULL : DUPLEX_HALF;
+		cmd.port = 0;
+		cmd.phy_address = bp-&gt;phy_addr;
+		cmd.transceiver = (bp-&gt;flags &amp; B44_FLAG_INTERNAL_PHY) ?
+			XCVR_INTERNAL : XCVR_EXTERNAL;
+		cmd.autoneg = (bp-&gt;flags &amp; B44_FLAG_FORCE_LINK) ?
+			AUTONEG_DISABLE : AUTONEG_ENABLE;
+		cmd.maxtxpkt = 0;
+		cmd.maxrxpkt = 0;
+		if (copy_to_user(useraddr, &amp;cmd, sizeof(cmd)))
+			return -EFAULT;
+		return 0;
+	}
+	case ETHTOOL_SSET: {
+		struct ethtool_cmd cmd;
+
+		if (!(bp-&gt;flags &amp; B44_FLAG_INIT_COMPLETE))
+			return -EAGAIN;
+
+		if (copy_from_user(&amp;cmd, useraddr, sizeof(cmd)))
+			return -EFAULT;
+
+		/* We do not support gigabit. */
+		if (cmd.autoneg == AUTONEG_ENABLE) {
+			if (cmd.advertising &amp;
+			    (ADVERTISED_1000baseT_Half |
+			     ADVERTISED_1000baseT_Full))
+				return -EINVAL;
+		} else if ((cmd.speed != SPEED_100 &amp;&amp;
+			    cmd.speed != SPEED_10) ||
+			   (cmd.duplex != DUPLEX_HALF &amp;&amp;
+			    cmd.duplex != DUPLEX_FULL)) {
+				return -EINVAL;
+		}
+
+		spin_lock_irq(&amp;bp-&gt;lock);
+
+		if (cmd.autoneg == AUTONEG_ENABLE) {
+			bp-&gt;flags &amp;= ~B44_FLAG_FORCE_LINK;
+			bp-&gt;flags &amp;= ~(B44_FLAG_ADV_10HALF |
+				       B44_FLAG_ADV_10FULL |
+				       B44_FLAG_ADV_100HALF |
+				       B44_FLAG_ADV_100FULL);
+			if (cmd.advertising &amp; ADVERTISE_10HALF)
+				bp-&gt;flags |= B44_FLAG_ADV_10HALF;
+			if (cmd.advertising &amp; ADVERTISE_10FULL)
+				bp-&gt;flags |= B44_FLAG_ADV_10FULL;
+			if (cmd.advertising &amp; ADVERTISE_100HALF)
+				bp-&gt;flags |= B44_FLAG_ADV_100HALF;
+			if (cmd.advertising &amp; ADVERTISE_100FULL)
+				bp-&gt;flags |= B44_FLAG_ADV_100FULL;
+		} else {
+			bp-&gt;flags |= B44_FLAG_FORCE_LINK;
+			if (cmd.speed == SPEED_100)
+				bp-&gt;flags |= B44_FLAG_100_BASE_T;
+			if (cmd.duplex == DUPLEX_FULL)
+				bp-&gt;flags |= B44_FLAG_FULL_DUPLEX;
+		}
+
+		b44_setup_phy(bp);
+
+		spin_unlock_irq(&amp;bp-&gt;lock);
+
+		return 0;
+	}
+
+	case ETHTOOL_GMSGLVL: {
+		struct ethtool_value edata = { ETHTOOL_GMSGLVL };
+		edata.data = bp-&gt;msg_enable;
+		if (copy_to_user(useraddr, &amp;edata, sizeof(edata)))
+			return -EFAULT;
+		return 0;
+	}
+	case ETHTOOL_SMSGLVL: {
+		struct ethtool_value edata;
+		if (copy_from_user(&amp;edata, useraddr, sizeof(edata)))
+			return -EFAULT;
+		bp-&gt;msg_enable = edata.data;
+		return 0;
+	}
+	case ETHTOOL_NWAY_RST: {
+		u32 bmcr;
+		int r;
+
+		spin_lock_irq(&amp;bp-&gt;lock);
+		b44_readphy(bp, MII_BMCR, &amp;bmcr);
+		b44_readphy(bp, MII_BMCR, &amp;bmcr);
+		r = -EINVAL;
+		if (bmcr &amp; BMCR_ANENABLE) {
+			b44_writephy(bp, MII_BMCR,
+				     bmcr | BMCR_ANRESTART);
+			r = 0;
+		}
+		spin_unlock_irq(&amp;bp-&gt;lock);
+
+		return r;
+	}
+	case ETHTOOL_GLINK: {
+		struct ethtool_value edata = { ETHTOOL_GLINK };
+		edata.data = netif_carrier_ok(bp-&gt;dev) ? 1 : 0;
+		if (copy_to_user(useraddr, &amp;edata, sizeof(edata)))
+			return -EFAULT;
+		return 0;
+	}
+	case ETHTOOL_GRINGPARAM: {
+		struct ethtool_ringparam ering = { ETHTOOL_GRINGPARAM };
+
+		ering.rx_max_pending = B44_RX_RING_SIZE - 1;
+		ering.rx_pending = bp-&gt;rx_pending;
+
+		/* XXX ethtool lacks a tx_max_pending, oops... */
+
+		if (copy_to_user(useraddr, &amp;ering, sizeof(ering)))
+			return -EFAULT;
+		return 0;
+	}
+	case ETHTOOL_SRINGPARAM: {
+		struct ethtool_ringparam ering;
+
+		if (copy_from_user(&amp;ering, useraddr, sizeof(ering)))
+			return -EFAULT;
+
+		if ((ering.rx_pending &gt; B44_RX_RING_SIZE - 1) ||
+		    (ering.rx_mini_pending != 0) ||
+		    (ering.rx_jumbo_pending != 0) ||
+		    (ering.tx_pending &gt; B44_TX_RING_SIZE - 1))
+			return -EINVAL;
+
+		spin_lock_irq(&amp;bp-&gt;lock);
+
+		bp-&gt;rx_pending = ering.rx_pending;
+		bp-&gt;tx_pending = ering.tx_pending;
+
+		b44_halt(bp);
+		b44_init_rings(bp);
+		b44_init_hw(bp, 1);
+		netif_wake_queue(bp-&gt;dev);
+		spin_unlock_irq(&amp;bp-&gt;lock);
+
+		b44_enable_ints(bp);
+		
+		return 0;
+	}
+	case ETHTOOL_GPAUSEPARAM: {
+		struct ethtool_pauseparam epause = { ETHTOOL_GPAUSEPARAM };
+
+		epause.autoneg =
+			(bp-&gt;flags &amp; B44_FLAG_PAUSE_AUTO) != 0;
+		epause.rx_pause =
+			(bp-&gt;flags &amp; B44_FLAG_RX_PAUSE) != 0;
+		epause.tx_pause =
+			(bp-&gt;flags &amp; B44_FLAG_TX_PAUSE) != 0;
+		if (copy_to_user(useraddr, &amp;epause, sizeof(epause)))
+			return -EFAULT;
+		return 0;
+	}
+	case ETHTOOL_SPAUSEPARAM: {
+		struct ethtool_pauseparam epause;
+
+		if (copy_from_user(&amp;epause, useraddr, sizeof(epause)))
+			return -EFAULT;
+
+		spin_lock_irq(&amp;bp-&gt;lock);
+		if (epause.autoneg)
+			bp-&gt;flags |= B44_FLAG_PAUSE_AUTO;
+		else
+			bp-&gt;flags &amp;= ~B44_FLAG_PAUSE_AUTO;
+		if (epause.rx_pause)
+			bp-&gt;flags |= B44_FLAG_RX_PAUSE;
+		else
+			bp-&gt;flags &amp;= ~B44_FLAG_RX_PAUSE;
+		if (epause.tx_pause)
+			bp-&gt;flags |= B44_FLAG_TX_PAUSE;
+		else
+			bp-&gt;flags &amp;= ~B44_FLAG_TX_PAUSE;
+		if (bp-&gt;flags &amp; B44_FLAG_PAUSE_AUTO) {
+			b44_halt(bp);
+			b44_init_rings(bp);
+			b44_init_hw(bp, 1);
+		} else {
+			__b44_set_flow_ctrl(bp, bp-&gt;flags);
+		}
+		spin_unlock_irq(&amp;bp-&gt;lock);
+
+		b44_enable_ints(bp);
+		
+		return 0;
+	}
+	};
+
+	return -EOPNOTSUPP;
+}
+
 static int b44_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	struct mii_ioctl_data *data = if_mii(ifr);
 	struct b44 *bp = netdev_priv(dev);
 	int err = -EINVAL;
 
-	if (!netif_running(dev))
+	if (bp-&gt;pdev-&gt;device != PCI_DEVICE_ID_BCM4713) {
+		if (!netif_running(dev))
+			goto out;
+
+		spin_lock_irq(&amp;bp-&gt;lock);
+		err = generic_mii_ioctl(&amp;bp-&gt;mii_if, data, cmd, NULL);
+		spin_unlock_irq(&amp;bp-&gt;lock);
 		goto out;
+	}
 
-	spin_lock_irq(&amp;bp-&gt;lock);
-	err = generic_mii_ioctl(&amp;bp-&gt;mii_if, data, cmd, NULL);
-	spin_unlock_irq(&amp;bp-&gt;lock);
+	switch (cmd) {
+	case SIOCETHTOOL:
+		return b44_ethtool_ioctl(dev, (void __user*) ifr-&gt;ifr_data);
+
+	case SIOCGMIIPHY:
+		data-&gt;phy_id = bp-&gt;phy_addr;
+
+		/* fallthru */
+	case SIOCGMIIREG: {
+		u32 mii_regval;
+		spin_lock_irq(&amp;bp-&gt;lock);
+		err = __b44_readphy(bp, data-&gt;phy_id &amp; 0x1f, data-&gt;reg_num &amp; 0x1f, &amp;mii_regval);
+		spin_unlock_irq(&amp;bp-&gt;lock);
+
+		data-&gt;val_out = mii_regval;
+
+		return err;
+	}
+
+	case SIOCSMIIREG:
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+
+		spin_lock_irq(&amp;bp-&gt;lock);
+		err = __b44_writephy(bp, data-&gt;phy_id &amp; 0x1f, data-&gt;reg_num &amp; 0x1f, data-&gt;val_in);
+		spin_unlock_irq(&amp;bp-&gt;lock);
+
+		return err;
+
+	default:
+		break;
+	};
+	return -EOPNOTSUPP;
+		
 out:
 	return err;
 }
@@ -2063,27 +2446,65 @@ static int b44_read_eeprom(struct b44 *b
 static int __devinit b44_get_invariants(struct b44 *bp)
 {
 	u8 eeprom[128];
-	int err;
+	u8 buf[32];
+	int err = 0;
+	unsigned long flags;
+
+#ifdef CONFIG_BCM947XX
+	if (bp-&gt;pdev-&gt;device == PCI_DEVICE_ID_BCM4713) {
+		/*
+		 * BCM47xx boards don't have a EEPROM. The MAC is stored in
+		 * a NVRAM area somewhere in the flash memory.
+		 */
+		sprintf(buf, "et%dmacaddr", b44_4713_instance);
+		if (nvram_get(buf)) {
+			e_aton(nvram_get(buf), bp-&gt;dev-&gt;dev_addr);
+		} else {
+			/*
+			 * Getting the MAC out of NVRAM failed. To make it work
+			 * here, we simply rely on the bootloader to write the
+			 * MAC into the CAM.
+			 */
+			spin_lock_irqsave(&amp;bp-&gt;lock, flags);
+			__b44_cam_read(bp, bp-&gt;dev-&gt;dev_addr, 0);
+			spin_unlock_irqrestore(&amp;bp-&gt;lock, flags);
+		}
 
-	err = b44_read_eeprom(bp, &amp;eeprom[0]);
-	if (err)
-		goto out;
+		if (!is_valid_ether_addr(&amp;bp-&gt;dev-&gt;dev_addr[0])){
+			printk(KERN_ERR PFX "Invalid MAC address found in NVRAM\n");
+			return -EINVAL;
+		}
 
-	bp-&gt;dev-&gt;dev_addr[0] = eeprom[79];
-	bp-&gt;dev-&gt;dev_addr[1] = eeprom[78];
-	bp-&gt;dev-&gt;dev_addr[2] = eeprom[81];
-	bp-&gt;dev-&gt;dev_addr[3] = eeprom[80];
-	bp-&gt;dev-&gt;dev_addr[4] = eeprom[83];
-	bp-&gt;dev-&gt;dev_addr[5] = eeprom[82];
+		/*
+		 * BCM47xx boards don't have a PHY. Usually there is a switch
+		 * chip with multiple PHYs connected to the PHY port.
+		 */
+		bp-&gt;phy_addr = B44_PHY_ADDR_NO_PHY;
+		bp-&gt;dma_offset = 0;
+	} else
+#endif
+	{
+		err = b44_read_eeprom(bp, &amp;eeprom[0]);
+		if (err)
+			goto out;
 
-	if (!is_valid_ether_addr(&amp;bp-&gt;dev-&gt;dev_addr[0])){
-		printk(KERN_ERR PFX "Invalid MAC address found in EEPROM\n");
-		return -EINVAL;
-	}
+		bp-&gt;dev-&gt;dev_addr[0] = eeprom[79];
+		bp-&gt;dev-&gt;dev_addr[1] = eeprom[78];
+		bp-&gt;dev-&gt;dev_addr[2] = eeprom[81];
+		bp-&gt;dev-&gt;dev_addr[3] = eeprom[80];
+		bp-&gt;dev-&gt;dev_addr[4] = eeprom[83];
+		bp-&gt;dev-&gt;dev_addr[5] = eeprom[82];
+
+		if (!is_valid_ether_addr(&amp;bp-&gt;dev-&gt;dev_addr[0])){
+			printk(KERN_ERR PFX "Invalid MAC address found in EEPROM\n");
+			return -EINVAL;
+		}
 
-	memcpy(bp-&gt;dev-&gt;perm_addr, bp-&gt;dev-&gt;dev_addr, bp-&gt;dev-&gt;addr_len);
+		memcpy(bp-&gt;dev-&gt;perm_addr, bp-&gt;dev-&gt;dev_addr, bp-&gt;dev-&gt;addr_len);
 
-	bp-&gt;phy_addr = eeprom[90] &amp; 0x1f;
+		bp-&gt;phy_addr = eeprom[90] &amp; 0x1f;
+		bp-&gt;dma_offset = SB_PCI_DMA;
+	}
 
 	/* With this, plus the rx_header prepended to the data by the
 	 * hardware, we'll land the ethernet header on a 2-byte boundary.
@@ -2093,11 +2514,6 @@ static int __devinit b44_get_invariants(
 	bp-&gt;imask = IMASK_DEF;
 
 	bp-&gt;core_unit = ssb_core_unit(bp);
-	bp-&gt;dma_offset = SB_PCI_DMA;
-
-	/* XXX - really required?
-	   bp-&gt;flags |= B44_FLAG_BUGGY_TXPTR;
-         */
 
  	if (ssb_get_core_rev(bp) &gt;= 7)
  		bp-&gt;flags |= B44_FLAG_B0_ANDLATER;
@@ -2244,11 +2660,17 @@ #endif
 	 */
 	b44_chip_reset(bp);
 
-	printk(KERN_INFO "%s: Broadcom 4400 10/100BaseT Ethernet ", dev-&gt;name);
+	printk(KERN_INFO "%s: Broadcom %s 10/100BaseT Ethernet ", dev-&gt;name,
+		(pdev-&gt;device == PCI_DEVICE_ID_BCM4713) ? "47xx" : "4400");
 	for (i = 0; i &lt; 6; i++)
 		printk("%2.2x%c", dev-&gt;dev_addr[i],
 		       i == 5 ? '\n' : ':');
 
+	/* Initialize phy */
+	spin_lock_irq(&amp;bp-&gt;lock);
+	b44_chip_reset(bp);
+	spin_unlock_irq(&amp;bp-&gt;lock);
+
 	return 0;
 
 err_out_iounmap:
diff --git a/drivers/net/b44.h b/drivers/net/b44.h
index 4944507..1e6f2c5 100644
--- a/drivers/net/b44.h
+++ b/drivers/net/b44.h
@@ -129,6 +129,7 @@ #define  RXCONFIG_LPBACK	0x00000010 /* L
 #define  RXCONFIG_FLOW		0x00000020 /* Flow Control Enable */
 #define  RXCONFIG_FLOW_ACCEPT	0x00000040 /* Accept Unicast Flow Control Frame */
 #define  RXCONFIG_RFILT		0x00000080 /* Reject Filter */
+#define  RXCONFIG_CAM_ABSENT	0x00000100 /* CAM Absent */
 #define B44_RXMAXLEN	0x0404UL /* EMAC RX Max Packet Length */
 #define B44_TXMAXLEN	0x0408UL /* EMAC TX Max Packet Length */
 #define B44_MDIO_CTRL	0x0410UL /* EMAC MDIO Control */
@@ -297,6 +298,10 @@ #define SSB_PCI_MASK0		0xfc000000
 #define SSB_PCI_MASK1		0xfc000000
 #define SSB_PCI_MASK2		0xc0000000
 
+#define br32(bp, REG)	readl((void *)bp-&gt;regs + (REG))
+#define bw32(bp, REG,VAL)	writel((VAL), (void *)bp-&gt;regs + (REG))
+#define atoi(str) simple_strtoul(((str != NULL) ? str : ""), NULL, 0)
+
 /* 4400 PHY registers */
 #define B44_MII_AUXCTRL		24	/* Auxiliary Control */
 #define  MII_AUXCTRL_DUPLEX	0x0001  /* Full Duplex */
@@ -350,6 +355,8 @@ struct ring_info {
 };
 
 #define B44_MCAST_TABLE_SIZE	32
+#define B44_PHY_ADDR_NO_PHY	30
+#define B44_MDC_RATIO		5000000
 
 #define	B44_STAT_REG_DECLARE		\
 	_B44(tx_good_octets)		\
@@ -428,6 +435,7 @@ struct b44 {
 #define B44_FLAG_B0_ANDLATER	0x00000001
 #define B44_FLAG_BUGGY_TXPTR	0x00000002
 #define B44_FLAG_REORDER_BUG	0x00000004
+#define B44_FLAG_INIT_COMPLETE	0x00000008
 #define B44_FLAG_PAUSE_AUTO	0x00008000
 #define B44_FLAG_FULL_DUPLEX	0x00010000
 #define B44_FLAG_100_BASE_T	0x00020000
-- 
1.4.1
</pre>
</body>
</html>

--------------020609010802070204080008--
