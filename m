Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Aug 2009 01:06:17 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:39344 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493201AbZHPXFr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Aug 2009 01:05:47 +0200
Received: by mail-ew0-f216.google.com with SMTP id 12so2271668ewy.0
        for <multiple recipients>; Sun, 16 Aug 2009 16:05:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=OSVzH1RtYnzlAd2kOLZkolUbsu0tu7B2O9ADnM4t3IU=;
        b=Oy2g3ga/xBWDvtnDeSQYjsZbwgKF39jpQSj3wIK2Qarp2NS7QTjwMVTkEQZ/Xjflh3
         62/+aKyCQiUEjj3kKrKPDA/MiEbeN8gYRqrWVI8V1drsjnT79bz9sTtK3wB0wmrVpJCU
         dSUZ3sf9PR9pFtuq2QJBDPa815ThXZ1qaYZOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=v9S2XN/a2+HuruuQViVszcE7WdAtYFcD2sQd+5l80slN6p9fb5JcojbpXzwOL+gXWT
         dSw0jlSjkAZAZDgyA5u12GGfKBJN8Sq2rB0hANpPlUd7ETgEHAhN+ExFbB4R3IyQ0YjR
         NlxLzgW2XkunUjnDP3MLWbkHcGslz4UhV0/QU=
Received: by 10.210.131.6 with SMTP id e6mr5521092ebd.88.1250463947497;
        Sun, 16 Aug 2009 16:05:47 -0700 (PDT)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id 10sm13904503eyz.21.2009.08.16.16.05.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Aug 2009 16:05:47 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 17 Aug 2009 01:05:44 +0200
Subject: [PATCH 2/2] au1000-eth: convert to a platform driver
MIME-Version: 1.0
X-UID:	1243
X-Length: 20442
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908170105.45770.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch converts the au1000-eth driver to become a full
platform-driver as it ought to be. We now pass PHY-speficic
configurations through platform_data but for compatibility
the driver still assumes the default settings (search for PHY1 on
MAC0) when no platform_data is passed. Tested on my MTX-1 board.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
index 2aab1eb..57cc4f6 100644
--- a/drivers/net/au1000_eth.c
+++ b/drivers/net/au1000_eth.c
@@ -54,6 +54,7 @@
 #include <linux/delay.h>
 #include <linux/crc32.h>
 #include <linux/phy.h>
+#include <linux/platform_device.h>
 
 #include <asm/cpu.h>
 #include <asm/mipsregs.h>
@@ -62,6 +63,7 @@
 #include <asm/processor.h>
 
 #include <au1000.h>
+#include <au1xxx_eth.h>
 #include <prom.h>
 
 #include "au1000_eth.h"
@@ -111,15 +113,15 @@ struct au1000_private *au_macs[NUM_ETH_INTERFACES];
  *
  * PHY detection algorithm
  *
- * If AU1XXX_PHY_STATIC_CONFIG is undefined, the PHY setup is
+ * If phy_static_config is undefined, the PHY setup is
  * autodetected:
  *
  * mii_probe() first searches the current MAC's MII bus for a PHY,
- * selecting the first (or last, if AU1XXX_PHY_SEARCH_HIGHEST_ADDR is
+ * selecting the first (or last, if phy_search_highest_addr is
  * defined) PHY address not already claimed by another netdev.
  *
  * If nothing was found that way when searching for the 2nd ethernet
- * controller's PHY and AU1XXX_PHY1_SEARCH_ON_MAC0 is defined, then
+ * controller's PHY and phy1_search_mac0 is defined, then
  * the first MII bus is searched as well for an unclaimed PHY; this is
  * needed in case of a dual-PHY accessible only through the MAC0's MII
  * bus.
@@ -128,9 +130,7 @@ struct au1000_private *au_macs[NUM_ETH_INTERFACES];
  * controller is not registered to the network subsystem.
  */
 
-/* autodetection defaults */
-#undef  AU1XXX_PHY_SEARCH_HIGHEST_ADDR
-#define AU1XXX_PHY1_SEARCH_ON_MAC0
+/* autodetection defaults: phy1_search_mac0 */
 
 /* static PHY setup
  *
@@ -147,29 +147,6 @@ struct au1000_private *au_macs[NUM_ETH_INTERFACES];
  * specific irq-map
  */
 
-#if defined(CONFIG_MIPS_BOSPORUS)
-/*
- * Micrel/Kendin 5 port switch attached to MAC0,
- * MAC0 is associated with PHY address 5 (== WAN port)
- * MAC1 is not associated with any PHY, since it's connected directly
- * to the switch.
- * no interrupts are used
- */
-# define AU1XXX_PHY_STATIC_CONFIG
-
-# define AU1XXX_PHY0_ADDR  5
-# define AU1XXX_PHY0_BUSID 0
-#  undef AU1XXX_PHY0_IRQ
-
-#  undef AU1XXX_PHY1_ADDR
-#  undef AU1XXX_PHY1_BUSID
-#  undef AU1XXX_PHY1_IRQ
-#endif
-
-#if defined(AU1XXX_PHY0_BUSID) && (AU1XXX_PHY0_BUSID > 0)
-# error MAC0-associated PHY attached 2nd MACs MII bus not supported yet
-#endif
-
 static void enable_mac(struct net_device *dev, int force_reset)
 {
 	unsigned long flags;
@@ -389,67 +366,54 @@ static int mii_probe (struct net_device *dev)
 	struct au1000_private *const aup = netdev_priv(dev);
 	struct phy_device *phydev = NULL;
 
-#if defined(AU1XXX_PHY_STATIC_CONFIG)
-	BUG_ON(aup->mac_id < 0 || aup->mac_id > 1);
+	if (aup->phy_static_config) {
+		BUG_ON(aup->mac_id < 0 || aup->mac_id > 1);
 
-	if(aup->mac_id == 0) { /* get PHY0 */
-# if defined(AU1XXX_PHY0_ADDR)
-		phydev = au_macs[AU1XXX_PHY0_BUSID]->mii_bus->phy_map[AU1XXX_PHY0_ADDR];
-# else
-		printk (KERN_INFO DRV_NAME ":%s: using PHY-less setup\n",
-			dev->name);
-		return 0;
-# endif /* defined(AU1XXX_PHY0_ADDR) */
-	} else if (aup->mac_id == 1) { /* get PHY1 */
-# if defined(AU1XXX_PHY1_ADDR)
-		phydev = au_macs[AU1XXX_PHY1_BUSID]->mii_bus->phy_map[AU1XXX_PHY1_ADDR];
-# else
-		printk (KERN_INFO DRV_NAME ":%s: using PHY-less setup\n",
-			dev->name);
+		if (aup->phy_addr)
+			phydev = aup->mii_bus->phy_map[aup->phy_addr];
+		else
+			printk (KERN_INFO DRV_NAME ":%s: using PHY-less setup\n",
+				dev->name);
 		return 0;
-# endif /* defined(AU1XXX_PHY1_ADDR) */
-	}
-
-#else /* defined(AU1XXX_PHY_STATIC_CONFIG) */
-	int phy_addr;
-
-	/* find the first (lowest address) PHY on the current MAC's MII bus */
-	for (phy_addr = 0; phy_addr < PHY_MAX_ADDR; phy_addr++)
-		if (aup->mii_bus->phy_map[phy_addr]) {
-			phydev = aup->mii_bus->phy_map[phy_addr];
-# if !defined(AU1XXX_PHY_SEARCH_HIGHEST_ADDR)
-			break; /* break out with first one found */
-# endif
-		}
-
-# if defined(AU1XXX_PHY1_SEARCH_ON_MAC0)
-	/* try harder to find a PHY */
-	if (!phydev && (aup->mac_id == 1)) {
-		/* no PHY found, maybe we have a dual PHY? */
-		printk (KERN_INFO DRV_NAME ": no PHY found on MAC1, "
-			"let's see if it's attached to MAC0...\n");
-
-		BUG_ON(!au_macs[0]);
-
-		/* find the first (lowest address) non-attached PHY on
-		 * the MAC0 MII bus */
-		for (phy_addr = 0; phy_addr < PHY_MAX_ADDR; phy_addr++) {
-			struct phy_device *const tmp_phydev =
-				au_macs[0]->mii_bus->phy_map[phy_addr];
-
-			if (!tmp_phydev)
-				continue; /* no PHY here... */
-
-			if (tmp_phydev->attached_dev)
-				continue; /* already claimed by MAC0 */
+	} else {
+		int phy_addr;
+
+		/* find the first (lowest address) PHY on the current MAC's MII bus */
+		for (phy_addr = 0; phy_addr < PHY_MAX_ADDR; phy_addr++)
+			if (aup->mii_bus->phy_map[phy_addr]) {
+				phydev = aup->mii_bus->phy_map[phy_addr];
+				if (!aup->phy_search_highest_addr)
+					break; /* break out with first one found */
+			}
 
-			phydev = tmp_phydev;
-			break; /* found it */
+		if (aup->phy1_search_mac0) {
+			/* try harder to find a PHY */
+			if (!phydev && (aup->mac_id == 1)) {
+				/* no PHY found, maybe we have a dual PHY? */
+				printk (KERN_INFO DRV_NAME ": no PHY found on MAC1, "
+					"let's see if it's attached to MAC0...\n");
+
+				/* find the first (lowest address) non-attached PHY on
+		 		* the MAC0 MII bus */
+				for (phy_addr = 0; phy_addr < PHY_MAX_ADDR; phy_addr++) {
+					if (aup->mac_id == 1)
+						break;
+					struct phy_device *const tmp_phydev =
+							aup->mii_bus->phy_map[phy_addr];
+
+					if (!tmp_phydev)
+						continue; /* no PHY here... */
+
+					if (tmp_phydev->attached_dev)
+						continue; /* already claimed by MAC0 */
+
+					phydev = tmp_phydev;
+					break; /* found it */
+				}
+			}
 		}
 	}
-# endif /* defined(AU1XXX_PHY1_SEARCH_OTHER_BUS) */
 
-#endif /* defined(AU1XXX_PHY_STATIC_CONFIG) */
 	if (!phydev) {
 		printk (KERN_ERR DRV_NAME ":%s: no PHY found\n", dev->name);
 		return -1;
@@ -577,31 +541,6 @@ setup_hw_rings(struct au1000_private *aup, u32 rx_base, u32 tx_base)
 	}
 }
 
-static struct {
-	u32 base_addr;
-	u32 macen_addr;
-	int irq;
-	struct net_device *dev;
-} iflist[2] = {
-#ifdef CONFIG_SOC_AU1000
-	{AU1000_ETH0_BASE, AU1000_MAC0_ENABLE, AU1000_MAC0_DMA_INT},
-	{AU1000_ETH1_BASE, AU1000_MAC1_ENABLE, AU1000_MAC1_DMA_INT}
-#endif
-#ifdef CONFIG_SOC_AU1100
-	{AU1100_ETH0_BASE, AU1100_MAC0_ENABLE, AU1100_MAC0_DMA_INT}
-#endif
-#ifdef CONFIG_SOC_AU1500
-	{AU1500_ETH0_BASE, AU1500_MAC0_ENABLE, AU1500_MAC0_DMA_INT},
-	{AU1500_ETH1_BASE, AU1500_MAC1_ENABLE, AU1500_MAC1_DMA_INT}
-#endif
-#ifdef CONFIG_SOC_AU1550
-	{AU1550_ETH0_BASE, AU1550_MAC0_ENABLE, AU1550_MAC0_DMA_INT},
-	{AU1550_ETH1_BASE, AU1550_MAC1_ENABLE, AU1550_MAC1_DMA_INT}
-#endif
-};
-
-static int num_ifs;
-
 /*
  * ethtool operations
  */
@@ -1059,46 +998,59 @@ static const struct net_device_ops au1000_netdev_ops = {
 	.ndo_change_mtu		= eth_change_mtu,
 };
 
-static struct net_device * au1000_probe(int port_num)
+static int __devinit au1000_probe(struct platform_device *pdev)
 {
 	static unsigned version_printed = 0;
 	struct au1000_private *aup = NULL;
+	struct au1000_eth_platform_data *pd;
 	struct net_device *dev = NULL;
 	db_dest_t *pDB, *pDBfree;
-	char ethaddr[6];
-	int irq, i, err;
-	u32 base, macen;
-
-	if (port_num >= NUM_ETH_INTERFACES)
-		return NULL;
+	int irq, i, err = 0;
+	struct resource *base, *macen;
+	DECLARE_MAC_BUF(ethaddr);
+
+	base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!base) {
+		printk(KERN_ERR DRV_NAME ": failed to retrieve base register\n");
+		err = -ENODEV;
+		goto out;
+	}
 
-	base  = CPHYSADDR(iflist[port_num].base_addr );
-	macen = CPHYSADDR(iflist[port_num].macen_addr);
-	irq = iflist[port_num].irq;
+	macen = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!macen) {
+		printk(KERN_ERR DRV_NAME ": failed to retrieve MAC Enable register\n");
+		err = -ENODEV;
+		goto out;
+	}
 
-	if (!request_mem_region( base, MAC_IOSIZE, "Au1x00 ENET") ||
-	    !request_mem_region(macen, 4, "Au1x00 ENET"))
-		return NULL;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		printk(KERN_ERR DRV_NAME ": failed to retrieve IRQ\n");
+		err = -ENODEV;
+		goto out;
+	}
 
-	if (version_printed++ == 0)
-		printk("%s version %s %s\n", DRV_NAME, DRV_VERSION, DRV_AUTHOR);
+	if (!request_mem_region(base->start, resource_size(base), pdev->name)) {
+		printk(KERN_ERR DRV_NAME ": failed to request memory region for base registers\n");
+		err = -ENXIO;
+		goto out;
+	}
+	
+	if (!request_mem_region(macen->start, resource_size(macen), pdev->name)) {
+		printk(KERN_ERR DRV_NAME ": failed to request memory region for MAC enable register\n");
+		err = -ENXIO;
+		goto err_request;
+	}
 
 	dev = alloc_etherdev(sizeof(struct au1000_private));
 	if (!dev) {
 		printk(KERN_ERR "%s: alloc_etherdev failed\n", DRV_NAME);
-		return NULL;
-	}
-
-	if ((err = register_netdev(dev)) != 0) {
-		printk(KERN_ERR "%s: Cannot register net device, error %d\n",
-				DRV_NAME, err);
-		free_netdev(dev);
-		return NULL;
+		err = -ENOMEM;
+		goto err_alloc;
 	}
 
-	printk("%s: Au1xx0 Ethernet found at 0x%x, irq %d\n",
-		dev->name, base, irq);
-
+	SET_NETDEV_DEV(dev, &pdev->dev);
+	platform_set_drvdata(pdev, dev);
 	aup = netdev_priv(dev);
 
 	spin_lock_init(&aup->lock);
@@ -1109,21 +1061,29 @@ static struct net_device * au1000_probe(int port_num)
 						(NUM_TX_BUFFS + NUM_RX_BUFFS),
 						&aup->dma_addr,	0);
 	if (!aup->vaddr) {
-		free_netdev(dev);
-		release_mem_region( base, MAC_IOSIZE);
-		release_mem_region(macen, 4);
-		return NULL;
+		printk(KERN_ERR DRV_NAME ": failed to allocate data buffers\n");
+		err = -ENOMEM;
+		goto err_vaddr;
 	}
 
 	/* aup->mac is the base address of the MAC's registers */
-	aup->mac = (volatile mac_reg_t *)iflist[port_num].base_addr;
+	aup->mac = (volatile mac_reg_t *)ioremap_nocache(base->start, resource_size(base));
+	if (!aup->mac) {
+		printk(KERN_ERR DRV_NAME ": failed to ioremap MAC registers\n");
+		err = -ENXIO;
+		goto err_remap1;
+	}
 
-	/* Setup some variables for quick register address access */
-	aup->enable = (volatile u32 *)iflist[port_num].macen_addr;
-	aup->mac_id = port_num;
-	au_macs[port_num] = aup;
+        /* Setup some variables for quick register address access */
+        aup->enable = (volatile u32 *)ioremap_nocache(macen->start, resource_size(macen));
+	if (!aup->enable) {
+		printk(KERN_ERR DRV_NAME ": failed to ioremap MAC enable register\n");
+		err = -ENXIO;
+		goto err_remap2;
+	}
+	aup->mac_id = pdev->id;
 
-	if (port_num == 0) {
+	if (pdev->id == 0) {
 		if (prom_get_ethernet_addr(ethaddr) == 0)
 			memcpy(au1000_mac_addr, ethaddr, sizeof(au1000_mac_addr));
 		else {
@@ -1133,7 +1093,7 @@ static struct net_device * au1000_probe(int port_num)
 		}
 
 		setup_hw_rings(aup, MAC0_RX_DMA_ADDR, MAC0_TX_DMA_ADDR);
-	} else if (port_num == 1)
+	} else if (pdev->id == 1)
 		setup_hw_rings(aup, MAC1_RX_DMA_ADDR, MAC1_TX_DMA_ADDR);
 
 	/*
@@ -1141,14 +1101,37 @@ static struct net_device * au1000_probe(int port_num)
 	 * to match those that are printed on their stickers
 	 */
 	memcpy(dev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
-	dev->dev_addr[5] += port_num;
+	dev->dev_addr[5] += pdev->id;
 
 	*aup->enable = 0;
 	aup->mac_enabled = 0;
 
+	pd = pdev->dev.platform_data;
+	if (!pd) {
+		printk(KERN_INFO DRV_NAME ": no platform_data passed, PHY search on MAC0\n");
+		aup->phy1_search_mac0 = 1;
+	} else {
+		aup->phy_static_config = pd->phy_static_config;
+		aup->phy_search_highest_addr = pd->phy_search_highest_addr;
+		aup->phy1_search_mac0 = pd->phy1_search_mac0;
+		aup->phy_addr = pd->phy_addr;
+		aup->phy_busid = pd->phy_busid;
+		aup->phy_irq = pd->phy_irq;
+	}
+
+	if (aup->phy_busid && aup->phy_busid > 0) {
+		printk(KERN_ERR DRV_NAME ": MAC0-associated PHY attached 2nd MACs MII"
+				"bus not supported yet\n");
+		err = -ENODEV;
+		goto err_mdiobus_alloc;
+	}
+
 	aup->mii_bus = mdiobus_alloc();
-	if (aup->mii_bus == NULL)
-		goto err_out;
+	if (aup->mii_bus == NULL) {
+		printk(KERN_ERR DRV_NAME ": failed to allocate mdiobus structure\n");
+		err = -ENOMEM;
+		goto err_mdiobus_alloc;
+	}
 
 	aup->mii_bus->priv = dev;
 	aup->mii_bus->read = au1000_mdiobus_read;
@@ -1159,23 +1142,19 @@ static struct net_device * au1000_probe(int port_num)
 	aup->mii_bus->irq = kmalloc(sizeof(int)*PHY_MAX_ADDR, GFP_KERNEL);
 	for(i = 0; i < PHY_MAX_ADDR; ++i)
 		aup->mii_bus->irq[i] = PHY_POLL;
-
 	/* if known, set corresponding PHY IRQs */
-#if defined(AU1XXX_PHY_STATIC_CONFIG)
-# if defined(AU1XXX_PHY0_IRQ)
-	if (AU1XXX_PHY0_BUSID == aup->mac_id)
-		aup->mii_bus->irq[AU1XXX_PHY0_ADDR] = AU1XXX_PHY0_IRQ;
-# endif
-# if defined(AU1XXX_PHY1_IRQ)
-	if (AU1XXX_PHY1_BUSID == aup->mac_id)
-		aup->mii_bus->irq[AU1XXX_PHY1_ADDR] = AU1XXX_PHY1_IRQ;
-# endif
-#endif
-	mdiobus_register(aup->mii_bus);
+	if (aup->phy_static_config)
+		if (aup->phy_irq && aup->phy_busid == aup->mac_id)
+			aup->mii_bus->irq[aup->phy_addr] = aup->phy_irq;
+	
+	err = mdiobus_register(aup->mii_bus);
+	if (err) {
+		printk(KERN_ERR DRV_NAME " failed to register MDIO bus\n");
+		goto err_mdiobus_reg;
+	}
 
-	if (mii_probe(dev) != 0) {
+	if (mii_probe(dev) != 0)
 		goto err_out;
-	}
 
 	pDBfree = NULL;
 	/* setup the data buffer descriptors and attach a buffer to each one */
@@ -1207,7 +1186,7 @@ static struct net_device * au1000_probe(int port_num)
 		aup->tx_db_inuse[i] = pDB;
 	}
 
-	dev->base_addr = base;
+	dev->base_addr = base->start;
 	dev->irq = irq;
 	dev->netdev_ops = &au1000_netdev_ops;
 	SET_ETHTOOL_OPS(dev, &au1000_ethtool_ops);
@@ -1219,14 +1198,24 @@ static struct net_device * au1000_probe(int port_num)
 	 */
 	reset_mac(dev);
 
-	return dev;
+	err = register_netdev(dev);
+	if (err) {
+		printk(KERN_ERR DRV_NAME "%s: Cannot register net device, aborting.\n",
+					dev->name);
+		goto err_out;
+	}
+	
+	printk("%s: Au1xx0 Ethernet found at 0x%x, irq %d\n",
+					dev->name, base->start, irq);
+	if (version_printed++ == 0)
+		printk("%s version %s %s\n", DRV_NAME, DRV_VERSION, DRV_AUTHOR);
+
+	return 0;
 
 err_out:
-	if (aup->mii_bus != NULL) {
+	if (aup->mii_bus != NULL)
 		mdiobus_unregister(aup->mii_bus);
-		mdiobus_free(aup->mii_bus);
-	}
-
+	
 	/* here we should have a valid dev plus aup-> register addresses
 	 * so we can reset the mac properly.*/
 	reset_mac(dev);
@@ -1239,67 +1228,84 @@ err_out:
 		if (aup->tx_db_inuse[i])
 			ReleaseDB(aup, aup->tx_db_inuse[i]);
 	}
+err_mdiobus_reg:
+	mdiobus_free(aup->mii_bus);
+err_mdiobus_alloc:
+	iounmap(aup->enable);
+err_remap2:
+	iounmap(aup->mac);
+err_remap1:
 	dma_free_noncoherent(NULL, MAX_BUF_SIZE * (NUM_TX_BUFFS + NUM_RX_BUFFS),
 			     (void *)aup->vaddr, aup->dma_addr);
-	unregister_netdev(dev);
+err_vaddr:
 	free_netdev(dev);
-	release_mem_region( base, MAC_IOSIZE);
-	release_mem_region(macen, 4);
-	return NULL;
+err_alloc:
+	release_mem_region(macen->start, resource_size(macen));
+err_request:
+	release_mem_region(base->start, resource_size(base));
+out:
+	return err;
 }
 
-/*
- * Setup the base address and interrupt of the Au1xxx ethernet macs
- * based on cpu type and whether the interface is enabled in sys_pinfunc
- * register. The last interface is enabled if SYS_PF_NI2 (bit 4) is 0.
- */
-static int __init au1000_init_module(void)
+static int __devexit au1000_remove(struct platform_device *pdev)
 {
-	int ni = (int)((au_readl(SYS_PINFUNC) & (u32)(SYS_PF_NI2)) >> 4);
-	struct net_device *dev;
-	int i, found_one = 0;
+	struct net_device *dev = platform_get_drvdata(pdev);
+	struct au1000_private *aup = netdev_priv(dev);
+	int i;
+	struct resource *base, *macen;
 
-	num_ifs = NUM_ETH_INTERFACES - ni;
+	platform_set_drvdata(pdev, NULL);
+
+	unregister_netdev(dev);
+	mdiobus_unregister(aup->mii_bus);
+	mdiobus_free(aup->mii_bus);
+
+	for (i = 0; i < NUM_RX_DMA; i++)
+		if (aup->rx_db_inuse[i])
+			ReleaseDB(aup, aup->rx_db_inuse[i]);
+
+	for (i = 0; i < NUM_TX_DMA; i++)
+		if (aup->tx_db_inuse[i])
+			ReleaseDB(aup, aup->tx_db_inuse[i]);
+
+	dma_free_noncoherent(NULL, MAX_BUF_SIZE *
+			(NUM_TX_BUFFS + NUM_RX_BUFFS),
+			(void *)aup->vaddr, aup->dma_addr);
+
+	iounmap(aup->mac);
+	iounmap(aup->enable);
+
+	base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(base->start, resource_size(base));
+
+	macen = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	release_mem_region(macen->start, resource_size(macen));
+	
+	free_netdev(dev);
 
-	for(i = 0; i < num_ifs; i++) {
-		dev = au1000_probe(i);
-		iflist[i].dev = dev;
-		if (dev)
-			found_one++;
-	}
-	if (!found_one)
-		return -ENODEV;
 	return 0;
 }
 
-static void __exit au1000_cleanup_module(void)
+static struct platform_driver au1000_eth_driver = {
+	.probe  = au1000_probe,
+	.remove = __devexit_p(au1000_remove),
+	.driver = {
+		.name   = "au1000-eth",
+		.owner  = THIS_MODULE,
+	},
+};
+MODULE_ALIAS("platform:au1000-eth");
+
+
+static int __init au1000_init_module(void)
 {
-	int i, j;
-	struct net_device *dev;
-	struct au1000_private *aup;
-
-	for (i = 0; i < num_ifs; i++) {
-		dev = iflist[i].dev;
-		if (dev) {
-			aup = netdev_priv(dev);
-			unregister_netdev(dev);
-			mdiobus_unregister(aup->mii_bus);
-			mdiobus_free(aup->mii_bus);
-			for (j = 0; j < NUM_RX_DMA; j++)
-				if (aup->rx_db_inuse[j])
-					ReleaseDB(aup, aup->rx_db_inuse[j]);
-			for (j = 0; j < NUM_TX_DMA; j++)
-				if (aup->tx_db_inuse[j])
-					ReleaseDB(aup, aup->tx_db_inuse[j]);
-			dma_free_noncoherent(NULL, MAX_BUF_SIZE *
-					     (NUM_TX_BUFFS + NUM_RX_BUFFS),
-					     (void *)aup->vaddr, aup->dma_addr);
-			release_mem_region(dev->base_addr, MAC_IOSIZE);
-			release_mem_region(CPHYSADDR(iflist[i].macen_addr), 4);
-			free_netdev(dev);
-		}
-	}
+	return platform_driver_register(&au1000_eth_driver);
+}
+
+static void __exit au1000_exit_module(void)
+{
+	platform_driver_unregister(&au1000_eth_driver);
 }
 
 module_init(au1000_init_module);
-module_exit(au1000_cleanup_module);
+module_exit(au1000_exit_module);
diff --git a/drivers/net/au1000_eth.h b/drivers/net/au1000_eth.h
index 824ecd5..f9d29a2 100644
--- a/drivers/net/au1000_eth.h
+++ b/drivers/net/au1000_eth.h
@@ -108,6 +108,15 @@ struct au1000_private {
 	struct phy_device *phy_dev;
 	struct mii_bus *mii_bus;
 
+	/* PHY configuration */
+	int phy_static_config;
+	int phy_search_highest_addr;
+	int phy1_search_mac0;
+
+	int phy_addr;
+	int phy_busid;
+	int phy_irq;
+
 	/* These variables are just for quick access to certain regs addresses. */
 	volatile mac_reg_t *mac;  /* mac registers                      */
 	volatile u32 *enable;     /* address of MAC Enable Register     */
