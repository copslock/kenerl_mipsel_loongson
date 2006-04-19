Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Apr 2006 19:35:17 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:7042 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8126482AbWDSSe6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Apr 2006 19:34:58 +0100
Received: (qmail 26893 invoked from network); 19 Apr 2006 22:50:27 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 19 Apr 2006 22:50:27 -0000
Message-ID: <4446857D.90507@ru.mvista.com>
Date:	Wed, 19 Apr 2006 22:46:21 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	jgarzik@pobox.com
CC:	Rodolfo Giometti <giometti@linux.it>, netdev@vger.kernel.org,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: [PATCH] au1000_eth.c probe code straightened up
References: <20060405154711.GL7029@enneenne.com> <20060405222332.GO7029@enneenne.com> <20060405222620.GP7029@enneenne.com> <4435290C.50607@ru.mvista.com> <20060406155011.GC23424@enneenne.com>
In-Reply-To: <20060406155011.GC23424@enneenne.com>
Content-Type: multipart/mixed;
 boundary="------------000609040906060803090001"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000609040906060803090001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

      Straighten up the AMD Au1xx0 Ethernet probing code, make it print out (and
store in the 'net_device' structure) the physical address of the controller,
not the KSEG1-based virtual. Make the driver also claim/release the 4-byte MAC
enable registers and assign to the Ethernet ports two consecutive MAC
addresses to match those that are printed on their stickers.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>




--------------000609040906060803090001
Content-Type: text/plain;
 name="au1000_eth-probe-rewrite.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="au1000_eth-probe-rewrite.patch"

diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
index 1363083..d5dfc78 100644
--- a/drivers/net/au1000_eth.c
+++ b/drivers/net/au1000_eth.c
@@ -2,7 +2,7 @@
  *
  * Alchemy Au1x00 ethernet driver
  *
- * Copyright 2001,2002,2003 MontaVista Software Inc.
+ * Copyright 2001-2003, 2006 MontaVista Software Inc.
  * Copyright 2002 TimeSys Corp.
  * Added ethtool/mii-tool support,
  * Copyright 2004 Matt Porter <mporter@kernel.crashing.org>
@@ -67,7 +67,7 @@ static int au1000_debug = 5;
 static int au1000_debug = 3;
 #endif
 
-#define DRV_NAME	"au1000eth"
+#define DRV_NAME	"au1000_eth"
 #define DRV_VERSION	"1.5"
 #define DRV_AUTHOR	"Pete Popov <ppopov@embeddedalley.com>"
 #define DRV_DESC	"Au1xxx on-chip Ethernet driver"
@@ -79,7 +79,7 @@ MODULE_LICENSE("GPL");
 // prototypes
 static void hard_stop(struct net_device *);
 static void enable_rx_tx(struct net_device *dev);
-static struct net_device * au1000_probe(u32 ioaddr, int irq, int port_num);
+static struct net_device * au1000_probe(int port_num);
 static int au1000_init(struct net_device *);
 static int au1000_open(struct net_device *);
 static int au1000_close(struct net_device *);
@@ -1159,12 +1159,27 @@ setup_hw_rings(struct au1000_private *au
 }
 
 static struct {
-	int port;
 	u32 base_addr;
 	u32 macen_addr;
 	int irq;
 	struct net_device *dev;
-} iflist[2];
+} iflist[2] = {
+#ifdef CONFIG_SOC_AU1000
+	{AU1000_ETH0_BASE, AU1000_MAC0_ENABLE, AU1000_MAC0_DMA_INT},
+	{AU1000_ETH1_BASE, AU1000_MAC1_ENABLE, AU1000_MAC1_DMA_INT}
+#endif
+#ifdef CONFIG_SOC_AU1100
+	{AU1100_ETH0_BASE, AU1100_MAC0_ENABLE, AU1100_MAC0_DMA_INT}
+#endif
+#ifdef CONFIG_SOC_AU1500
+	{AU1500_ETH0_BASE, AU1500_MAC0_ENABLE, AU1500_MAC0_DMA_INT},
+	{AU1500_ETH1_BASE, AU1500_MAC1_ENABLE, AU1500_MAC1_DMA_INT}
+#endif
+#ifdef CONFIG_SOC_AU1550
+	{AU1550_ETH0_BASE, AU1550_MAC0_ENABLE, AU1550_MAC0_DMA_INT},
+	{AU1550_ETH1_BASE, AU1550_MAC1_ENABLE, AU1550_MAC1_DMA_INT}
+#endif
+};
 
 static int num_ifs;
 
@@ -1175,58 +1190,14 @@ static int num_ifs;
  */
 static int __init au1000_init_module(void)
 {
-	struct cpuinfo_mips *c = &current_cpu_data;
 	int ni = (int)((au_readl(SYS_PINFUNC) & (u32)(SYS_PF_NI2)) >> 4);
 	struct net_device *dev;
 	int i, found_one = 0;
 
-	switch (c->cputype) {
-#ifdef CONFIG_SOC_AU1000
-	case CPU_AU1000:
-		num_ifs = 2 - ni;
-		iflist[0].base_addr = AU1000_ETH0_BASE;
-		iflist[1].base_addr = AU1000_ETH1_BASE;
-		iflist[0].macen_addr = AU1000_MAC0_ENABLE;
-		iflist[1].macen_addr = AU1000_MAC1_ENABLE;
-		iflist[0].irq = AU1000_MAC0_DMA_INT;
-		iflist[1].irq = AU1000_MAC1_DMA_INT;
-		break;
-#endif
-#ifdef CONFIG_SOC_AU1100
-	case CPU_AU1100:
-		num_ifs = 1 - ni;
-		iflist[0].base_addr = AU1100_ETH0_BASE;
-		iflist[0].macen_addr = AU1100_MAC0_ENABLE;
-		iflist[0].irq = AU1100_MAC0_DMA_INT;
-		break;
-#endif
-#ifdef CONFIG_SOC_AU1500
-	case CPU_AU1500:
-		num_ifs = 2 - ni;
-		iflist[0].base_addr = AU1500_ETH0_BASE;
-		iflist[1].base_addr = AU1500_ETH1_BASE;
-		iflist[0].macen_addr = AU1500_MAC0_ENABLE;
-		iflist[1].macen_addr = AU1500_MAC1_ENABLE;
-		iflist[0].irq = AU1500_MAC0_DMA_INT;
-		iflist[1].irq = AU1500_MAC1_DMA_INT;
-		break;
-#endif
-#ifdef CONFIG_SOC_AU1550
-	case CPU_AU1550:
-		num_ifs = 2 - ni;
-		iflist[0].base_addr = AU1550_ETH0_BASE;
-		iflist[1].base_addr = AU1550_ETH1_BASE;
-		iflist[0].macen_addr = AU1550_MAC0_ENABLE;
-		iflist[1].macen_addr = AU1550_MAC1_ENABLE;
-		iflist[0].irq = AU1550_MAC0_DMA_INT;
-		iflist[1].irq = AU1550_MAC1_DMA_INT;
-		break;
-#endif
-	default:
-		num_ifs = 0;
-	}
+	num_ifs = NUM_ETH_INTERFACES - ni;
+
 	for(i = 0; i < num_ifs; i++) {
-		dev = au1000_probe(iflist[i].base_addr, iflist[i].irq, i);
+		dev = au1000_probe(i);
 		iflist[i].dev = dev;
 		if (dev)
 			found_one++;
@@ -1435,8 +1406,7 @@ static struct ethtool_ops au1000_ethtool
 	.get_link = au1000_get_link
 };
 
-static struct net_device *
-au1000_probe(u32 ioaddr, int irq, int port_num)
+static struct net_device * au1000_probe(int port_num)
 {
 	static unsigned version_printed = 0;
 	struct au1000_private *aup = NULL;
@@ -1444,94 +1414,95 @@ au1000_probe(u32 ioaddr, int irq, int po
 	db_dest_t *pDB, *pDBfree;
 	char *pmac, *argptr;
 	char ethaddr[6];
-	int i, err;
+	int irq, i, err;
+	u32 base, macen;
+
+	if (port_num >= NUM_ETH_INTERFACES)
+ 		return NULL;
 
-	if (!request_mem_region(CPHYSADDR(ioaddr), MAC_IOSIZE, "Au1x00 ENET"))
+	base  = CPHYSADDR(iflist[port_num].base_addr );
+	macen = CPHYSADDR(iflist[port_num].macen_addr);
+	irq = iflist[port_num].irq;
+
+	if (!request_mem_region( base, MAC_IOSIZE, "Au1x00 ENET") ||
+	    !request_mem_region(macen, 4, "Au1x00 ENET"))
 		return NULL;
 
-	if (version_printed++ == 0) 
+	if (version_printed++ == 0)
 		printk("%s version %s %s\n", DRV_NAME, DRV_VERSION, DRV_AUTHOR);
 
 	dev = alloc_etherdev(sizeof(struct au1000_private));
 	if (!dev) {
-		printk (KERN_ERR "au1000 eth: alloc_etherdev failed\n");  
+		printk(KERN_ERR "%s: alloc_etherdev failed\n", DRV_NAME);
 		return NULL;
 	}
 
-	if ((err = register_netdev(dev))) {
-		printk(KERN_ERR "Au1x_eth Cannot register net device err %d\n",
-				err);
+	if ((err = register_netdev(dev)) != 0) {
+		printk(KERN_ERR "%s: Cannot register net device, error %d\n",
+				DRV_NAME, err);
 		free_netdev(dev);
 		return NULL;
 	}
 
-	printk("%s: Au1x Ethernet found at 0x%x, irq %d\n", 
-			dev->name, ioaddr, irq);
+	printk("%s: Au1xx0 Ethernet found at 0x%x, irq %d\n",
+		dev->name, base, irq);
 
 	aup = dev->priv;
 
 	/* Allocate the data buffers */
 	/* Snooping works fine with eth on all au1xxx */
-	aup->vaddr = (u32)dma_alloc_noncoherent(NULL,
-			MAX_BUF_SIZE * (NUM_TX_BUFFS+NUM_RX_BUFFS),
-			&aup->dma_addr,
-			0);
+	aup->vaddr = (u32)dma_alloc_noncoherent(NULL, MAX_BUF_SIZE *
+						(NUM_TX_BUFFS + NUM_RX_BUFFS),
+						&aup->dma_addr,	0);
 	if (!aup->vaddr) {
 		free_netdev(dev);
-		release_mem_region(CPHYSADDR(ioaddr), MAC_IOSIZE);
+		release_mem_region( base, MAC_IOSIZE);
+		release_mem_region(macen, 4);
 		return NULL;
 	}
 
 	/* aup->mac is the base address of the MAC's registers */
-	aup->mac = (volatile mac_reg_t *)((unsigned long)ioaddr);
+	aup->mac = (volatile mac_reg_t *)iflist[port_num].base_addr;
+
 	/* Setup some variables for quick register address access */
-	if (ioaddr == iflist[0].base_addr)
-	{
-		/* check env variables first */
-		if (!get_ethernet_addr(ethaddr)) { 
+	aup->enable = (volatile u32 *)iflist[port_num].macen_addr;
+	aup->mac_id = port_num;
+	au_macs[port_num] = aup;
+
+	if (port_num == 0) {
+		/* Check the environment variables first */
+		if (get_ethernet_addr(ethaddr) == 0)
 			memcpy(au1000_mac_addr, ethaddr, sizeof(au1000_mac_addr));
-		} else {
+		else {
 			/* Check command line */
 			argptr = prom_getcmdline();
-			if ((pmac = strstr(argptr, "ethaddr=")) == NULL) {
-				printk(KERN_INFO "%s: No mac address found\n", 
-						dev->name);
-				/* use the hard coded mac addresses */
-			} else {
+			if ((pmac = strstr(argptr, "ethaddr=")) == NULL)
+				printk(KERN_INFO "%s: No MAC address found\n",
+						 dev->name);
+				/* Use the hard coded MAC addresses */
+			else {
 				str2eaddr(ethaddr, pmac + strlen("ethaddr="));
 				memcpy(au1000_mac_addr, ethaddr, 
-						sizeof(au1000_mac_addr));
+				       sizeof(au1000_mac_addr));
 			}
 		}
-			aup->enable = (volatile u32 *) 
-				((unsigned long)iflist[0].macen_addr);
-		memcpy(dev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
+
 		setup_hw_rings(aup, MAC0_RX_DMA_ADDR, MAC0_TX_DMA_ADDR);
-		aup->mac_id = 0;
-		au_macs[0] = aup;
-	}
-		else
-	if (ioaddr == iflist[1].base_addr)
-	{
-			aup->enable = (volatile u32 *) 
-				((unsigned long)iflist[1].macen_addr);
-		memcpy(dev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
-		dev->dev_addr[4] += 0x10;
+	} else if (port_num == 1)
 		setup_hw_rings(aup, MAC1_RX_DMA_ADDR, MAC1_TX_DMA_ADDR);
-		aup->mac_id = 1;
-		au_macs[1] = aup;
-	}
-	else
-	{
-		printk(KERN_ERR "%s: bad ioaddr\n", dev->name);
-	}
 
-	/* bring the device out of reset, otherwise probing the mii
-	 * will hang */
+	/*
+	 * Assign to the Ethernet ports two consecutive MAC addresses
+	 * to match those that are printed on their stickers
+	 */
+	memcpy(dev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
+	dev->dev_addr[5] += port_num;
+
+	/* Bring the device out of reset, otherwise probing the MII will hang */
 	*aup->enable = MAC_EN_CLOCK_ENABLE;
 	au_sync_delay(2);
-	*aup->enable = MAC_EN_RESET0 | MAC_EN_RESET1 | 
-		MAC_EN_RESET2 | MAC_EN_CLOCK_ENABLE;
+	*aup->enable = MAC_EN_RESET0 | MAC_EN_RESET1 | MAC_EN_RESET2 |
+		       MAC_EN_CLOCK_ENABLE;
 	au_sync_delay(2);
 
 	aup->mii = kmalloc(sizeof(struct mii_phy), GFP_KERNEL);
@@ -1580,7 +1551,7 @@ au1000_probe(u32 ioaddr, int irq, int po
 	}
 
 	spin_lock_init(&aup->lock);
-	dev->base_addr = ioaddr;
+	dev->base_addr = base;
 	dev->irq = irq;
 	dev->open = au1000_open;
 	dev->hard_start_xmit = au1000_tx;
@@ -1614,13 +1585,12 @@ err_out:
 		if (aup->tx_db_inuse[i])
 			ReleaseDB(aup, aup->tx_db_inuse[i]);
 	}
-	dma_free_noncoherent(NULL,
-			MAX_BUF_SIZE * (NUM_TX_BUFFS+NUM_RX_BUFFS),
-			(void *)aup->vaddr,
-			aup->dma_addr);
+	dma_free_noncoherent(NULL, MAX_BUF_SIZE * (NUM_TX_BUFFS + NUM_RX_BUFFS),
+			     (void *)aup->vaddr, aup->dma_addr);
 	unregister_netdev(dev);
 	free_netdev(dev);
-	release_mem_region(CPHYSADDR(ioaddr), MAC_IOSIZE);
+	release_mem_region( base, MAC_IOSIZE);
+	release_mem_region(macen, 4);
 	return NULL;
 }
 
@@ -1805,20 +1775,18 @@ static void __exit au1000_cleanup_module
 			aup = (struct au1000_private *) dev->priv;
 			unregister_netdev(dev);
 			kfree(aup->mii);
-			for (j = 0; j < NUM_RX_DMA; j++) {
+			for (j = 0; j < NUM_RX_DMA; j++)
 				if (aup->rx_db_inuse[j])
 					ReleaseDB(aup, aup->rx_db_inuse[j]);
-			}
-			for (j = 0; j < NUM_TX_DMA; j++) {
+			for (j = 0; j < NUM_TX_DMA; j++)
 				if (aup->tx_db_inuse[j])
 					ReleaseDB(aup, aup->tx_db_inuse[j]);
-			}
-			dma_free_noncoherent(NULL,
-					MAX_BUF_SIZE * (NUM_TX_BUFFS+NUM_RX_BUFFS),
-					(void *)aup->vaddr,
-					aup->dma_addr);
+ 			dma_free_noncoherent(NULL, MAX_BUF_SIZE *
+ 					     (NUM_TX_BUFFS + NUM_RX_BUFFS),
+ 					     (void *)aup->vaddr, aup->dma_addr);
+ 			release_mem_region(dev->base_addr, MAC_IOSIZE);
+ 			release_mem_region(CPHYSADDR(iflist[i].macen_addr), 4);
 			free_netdev(dev);
-			release_mem_region(CPHYSADDR(iflist[i].base_addr), MAC_IOSIZE);
 		}
 	}
 }


--------------000609040906060803090001--
