Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Apr 2006 23:15:02 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:52104 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133463AbWDEWOv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Apr 2006 23:14:51 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FRGPc-0004NR-0A; Thu, 06 Apr 2006 00:23:41 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FRGSC-00053M-VC; Thu, 06 Apr 2006 00:26:21 +0200
Date:	Thu, 6 Apr 2006 00:26:20 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Linux MIPS <linux-mips@linux-mips.org>
Cc:	ppopov@mvista.com
Message-ID: <20060405222620.GP7029@enneenne.com>
References: <20060405154711.GL7029@enneenne.com> <20060405222332.GO7029@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hbBJ5WP8dkNDDowN"
Content-Disposition: inline
In-Reply-To: <20060405222332.GO7029@enneenne.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] Oops! - Re: Power management for au1000_eth.c
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--hbBJ5WP8dkNDDowN
Content-Type: multipart/mixed; boundary="gKYyLFtP+LgnHcbx"
Content-Disposition: inline


--gKYyLFtP+LgnHcbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2006 at 12:23:32AM +0200, Rodolfo Giometti wrote:
> On Wed, Apr 05, 2006 at 05:47:11PM +0200, Rodolfo Giometti wrote:
> > Hello,
> >=20
> > I'm trying to add power management support to au1000_eth.c driver.
>=20
> Solved! :)
>=20
> Here a patch to implement power management functions for au1000_eth.
>=20
> Note that this patch needs my previous one who implements new power
> management's sysfs interface.

The forgotten attachment. :)

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--gKYyLFtP+LgnHcbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1000_eth-pm
Content-Transfer-Encoding: quoted-printable

--- /home/develop/embedded/mipsel/linux/linux-mips.git/arch/mips/au1000/com=
mon/au1xxx_irqmap.c	2006-03-31 16:57:26.000000000 +0200
+++ arch/mips/au1000/common/au1xxx_irqmap.c	2006-04-03 17:50:49.000000000 +=
0200
@@ -118,7 +118,7 @@
 	{ AU1000_USB_DEV_SUS_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_USB_HOST_INT, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1000_ACSYNC_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1500_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1000_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
 	{ AU1500_MAC1_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
 	{ AU1000_AC97C_INT, INTC_INT_RISE_EDGE, 0 },
=20
@@ -152,7 +152,7 @@
 	{ AU1000_USB_DEV_SUS_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_USB_HOST_INT, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1000_ACSYNC_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1100_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1000_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
 	/*{ AU1000_GPIO215_208_INT, INTC_INT_HIGH_LEVEL, 0},*/
 	{ AU1100_LCD_INT, INTC_INT_HIGH_LEVEL, 0},
 	{ AU1000_AC97C_INT, INTC_INT_RISE_EDGE, 0 },
--- /home/develop/embedded/mipsel/linux/linux-mips.git/arch/mips/au1000/com=
mon/platform.c	2006-04-03 18:22:05.000000000 +0200
+++ arch/mips/au1000/common/platform.c	2006-04-05 23:08:55.000000000 +0200
@@ -16,6 +16,78 @@
=20
 #include <asm/mach-au1x00/au1xxx.h>
=20
+#if defined(CONFIG_MIPS_AU1X00_ENET) || defined(CONFIG_MIPS_AU1X00_ENET_MO=
DULE)
+/* Ethernet controllers */
+static struct resource au1xxx_eth0_resources[] =3D {
+	[0] =3D {
+		.name	=3D "eth-base",
+		.start	=3D ETH0_BASE,
+		.end	=3D ETH0_BASE + 0x0ffff,
+		.flags	=3D IORESOURCE_MEM,
+	},
+	[1] =3D {
+		.name	=3D "eth-mac",
+		.start	=3D MAC0_ENABLE,
+		.end	=3D MAC0_ENABLE + 0x0ffff,
+		.flags	=3D IORESOURCE_MEM,
+	},
+	[2] =3D {
+		.name	=3D "eth-irq",
+#if defined(CONFIG_SOC_AU1550)
+		.start	=3D AU1550_MAC0_DMA_INT,
+		.end	=3D AU1550_MAC0_DMA_INT,
+#else
+		.start	=3D AU1000_MAC0_DMA_INT,
+		.end	=3D AU1000_MAC0_DMA_INT,
+#endif
+		.flags	=3D IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device au1xxx_eth0_device =3D {
+	.name		=3D "au1xxx-eth",
+ 	.id		=3D 0,
+	.num_resources	=3D ARRAY_SIZE(au1xxx_eth0_resources),
+	.resource	=3D au1xxx_eth0_resources,
+};
+
+#if defined(CONFIG_SOC_AU1000) || \
+    defined(CONFIG_SOC_AU1500) || defined(CONFIG_SOC_AU1550)
+static struct resource au1xxx_eth1_resources[] =3D {
+	[0] =3D {
+		.name	=3D "eth-base",
+		.start	=3D ETH1_BASE,
+		.end	=3D ETH1_BASE + 0x0ffff,
+		.flags	=3D IORESOURCE_MEM,
+	},
+	[1] =3D {
+		.name	=3D "eth-mac",
+		.start	=3D MAC1_ENABLE,
+		.end	=3D MAC1_ENABLE + 0x0ffff,
+		.flags	=3D IORESOURCE_MEM,
+	},
+	[2] =3D {
+		.name	=3D "eth-irq",
+#if defined(CONFIG_SOC_AU1550)
+		.start	=3D AU1550_MAC1_DMA_INT,
+		.end	=3D AU1550_MAC1_DMA_INT,
+#else
+		.start	=3D AU1000_MAC1_DMA_INT,
+		.end	=3D AU1000_MAC1_DMA_INT,
+#endif
+		.flags	=3D IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device au1xxx_eth1_device =3D {
+	.name		=3D "au1xxx-eth",
+ 	.id		=3D 1,
+	.num_resources	=3D ARRAY_SIZE(au1xxx_eth1_resources),
+	.resource	=3D au1xxx_eth1_resources,
+};
+#endif
+#endif
+
 /* OHCI (USB full speed host controller) */
 static struct resource au1xxx_usb_ohci_resources[] =3D {
 	[0] =3D {
@@ -272,6 +344,13 @@
 #endif
=20
 static struct platform_device *au1xxx_platform_devices[] __initdata =3D {
+#if defined(CONFIG_MIPS_AU1X00_ENET) || defined(CONFIG_MIPS_AU1X00_ENET_MO=
DULE)
+	&au1xxx_eth0_device,
+#if defined(CONFIG_SOC_AU1000) || \
+	    defined(CONFIG_SOC_AU1500) || defined(CONFIG_SOC_AU1550)
+	&au1xxx_eth1_device,
+#endif
+#endif
 	&au1xxx_usb_ohci_device,
 	&au1x00_pcmcia_device,
 #ifdef CONFIG_FB_AU1100
--- a/drivers/net/Kconfig	2 Jul 2005 06:46:30 -0000	1.1.1.1
+++ b/drivers/net/Kconfig	5 Apr 2006 21:20:30 -0000
@@ -440,12 +440,12 @@
 	  Say Y here to support the Ethernet subsystem on your GT96100 card.
=20
 config MIPS_AU1X00_ENET
-	bool "MIPS AU1000 Ethernet support"
+	tristate "MIPS AU1000 Ethernet support"
 	depends on NET_ETHERNET && SOC_AU1X00
 	select CRC32
 	help
 	  If you have an Alchemy Semi AU1X00 based system
-	  say Y.  Otherwise, say N.
+	  say Y or M.  Otherwise, say N.
=20
 config SGI_IOC3_ETH
 	bool "SGI IOC3 Ethernet"
--- /home/develop/embedded/mipsel/linux/linux-mips.git/drivers/net/au1000_e=
th.c	2006-04-03 18:23:17.000000000 +0200
+++ drivers/net/au1000_eth.c	2006-04-05 23:43:18.000000000 +0200
@@ -9,6 +9,9 @@
  * Update: 2004 Bjoern Riemer, riemer@fokus.fraunhofer.de=20
  * or riemer@riemer-nt.de: fixed the link beat detection with=20
  * ioctls (SIOCGMIIPHY)
+ * Update: 2006 Rodolfo Giometti: PM support, module support.
+ * Copyright 2006 Rodolfo Giometti <giometti@linux.it>
+ *
  * Author: MontaVista Software, Inc.
  *         	ppopov@mvista.com or source@mvista.com
  *
@@ -57,6 +60,7 @@
 #include <asm/io.h>
 #include <asm/processor.h>
=20
+#include <linux/platform_device.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/cpu.h>
 #include "au1000_eth.h"
@@ -67,8 +71,8 @@
 static int au1000_debug =3D 3;
 #endif
=20
-#define DRV_NAME	"au1000eth"
-#define DRV_VERSION	"1.5"
+#define DRV_NAME	"au1xxx-eth"
+#define DRV_VERSION	"1.6"
 #define DRV_AUTHOR	"Pete Popov <ppopov@embeddedalley.com>"
 #define DRV_DESC	"Au1xxx on-chip Ethernet driver"
=20
@@ -79,7 +83,8 @@
 // prototypes
 static void hard_stop(struct net_device *);
 static void enable_rx_tx(struct net_device *dev);
-static struct net_device * au1000_probe(u32 ioaddr, int irq, int port_num);
+static int au1000_lowlevel_probe(struct net_device *ndev, u32 ioaddr, u32 =
macen_addr, int port_num);
+static void au1000_lowlevel_remove(struct net_device *ndev);
 static int au1000_init(struct net_device *);
 static int au1000_open(struct net_device *);
 static int au1000_close(struct net_device *);
@@ -432,6 +437,34 @@
 	return 0;
 }
=20
+#ifdef CONFIG_PM
+int am79c874_suspend(struct net_device *dev, int phy_addr, int level)
+{
+	s16 mii_control;
+=09
+	if (au1000_debug > 4)
+		printk("am79c874_suspend\n");
+
+	mii_control =3D mdio_read(dev, phy_addr, MII_CONTROL);
+	mdio_write(dev, phy_addr, MII_CONTROL, mii_control | MII_CNTL_PWRDWN);
+	mdelay(1);
+	return 0;
+}
+
+int am79c874_resume(struct net_device *dev, int phy_addr, int level)
+{
+	s16 mii_control;
+=09
+	if (au1000_debug > 4)
+		printk("am79c874_resume\n");
+
+	mii_control =3D mdio_read(dev, phy_addr, MII_CONTROL);
+	mdio_write(dev, phy_addr, MII_CONTROL, mii_control & ~MII_CNTL_PWRDWN);
+	mdelay(1);
+	return 0;
+}
+#endif
+
 int lxt971a_init(struct net_device *dev, int phy_addr)
 {
 	if (au1000_debug > 4)
@@ -727,6 +760,10 @@
 	am79c874_init,
 	am79c874_reset,
 	am79c874_status,
+#ifdef CONFIG_PM
+	am79c874_suspend,
+	am79c874_resume,
+#endif
 };
=20
 struct phy_ops am79c901_ops =3D {
@@ -1108,9 +1145,6 @@
 				dev->name, (unsigned)aup);
=20
 	spin_lock_irqsave(&aup->lock, flags);
-	if (aup->timer.function =3D=3D &au1000_timer) {/* check if timer initted =
*/
-		del_timer(&aup->timer);
-	}
=20
 	hard_stop(dev);
 	#ifdef CONFIG_BCM5222_DUAL_PHY
@@ -1158,84 +1192,6 @@
 	}
 }
=20
-static struct {
-	int port;
-	u32 base_addr;
-	u32 macen_addr;
-	int irq;
-	struct net_device *dev;
-} iflist[2];
-
-static int num_ifs;
-
-/*
- * Setup the base address and interupt of the Au1xxx ethernet macs
- * based on cpu type and whether the interface is enabled in sys_pinfunc
- * register. The last interface is enabled if SYS_PF_NI2 (bit 4) is 0.
- */
-static int __init au1000_init_module(void)
-{
-	struct cpuinfo_mips *c =3D &current_cpu_data;
-	int ni =3D (int)((au_readl(SYS_PINFUNC) & (u32)(SYS_PF_NI2)) >> 4);
-	struct net_device *dev;
-	int i, found_one =3D 0;
-
-	switch (c->cputype) {
-#ifdef CONFIG_SOC_AU1000
-	case CPU_AU1000:
-		num_ifs =3D 2 - ni;
-		iflist[0].base_addr =3D AU1000_ETH0_BASE;
-		iflist[1].base_addr =3D AU1000_ETH1_BASE;
-		iflist[0].macen_addr =3D AU1000_MAC0_ENABLE;
-		iflist[1].macen_addr =3D AU1000_MAC1_ENABLE;
-		iflist[0].irq =3D AU1000_MAC0_DMA_INT;
-		iflist[1].irq =3D AU1000_MAC1_DMA_INT;
-		break;
-#endif
-#ifdef CONFIG_SOC_AU1100
-	case CPU_AU1100:
-		num_ifs =3D 1 - ni;
-		iflist[0].base_addr =3D AU1100_ETH0_BASE;
-		iflist[0].macen_addr =3D AU1100_MAC0_ENABLE;
-		iflist[0].irq =3D AU1100_MAC0_DMA_INT;
-		break;
-#endif
-#ifdef CONFIG_SOC_AU1500
-	case CPU_AU1500:
-		num_ifs =3D 2 - ni;
-		iflist[0].base_addr =3D AU1500_ETH0_BASE;
-		iflist[1].base_addr =3D AU1500_ETH1_BASE;
-		iflist[0].macen_addr =3D AU1500_MAC0_ENABLE;
-		iflist[1].macen_addr =3D AU1500_MAC1_ENABLE;
-		iflist[0].irq =3D AU1500_MAC0_DMA_INT;
-		iflist[1].irq =3D AU1500_MAC1_DMA_INT;
-		break;
-#endif
-#ifdef CONFIG_SOC_AU1550
-	case CPU_AU1550:
-		num_ifs =3D 2 - ni;
-		iflist[0].base_addr =3D AU1550_ETH0_BASE;
-		iflist[1].base_addr =3D AU1550_ETH1_BASE;
-		iflist[0].macen_addr =3D AU1550_MAC0_ENABLE;
-		iflist[1].macen_addr =3D AU1550_MAC1_ENABLE;
-		iflist[0].irq =3D AU1550_MAC0_DMA_INT;
-		iflist[1].irq =3D AU1550_MAC1_DMA_INT;
-		break;
-#endif
-	default:
-		num_ifs =3D 0;
-	}
-	for(i =3D 0; i < num_ifs; i++) {
-		dev =3D au1000_probe(iflist[i].base_addr, iflist[i].irq, i);
-		iflist[i].dev =3D dev;
-		if (dev)
-			found_one++;
-	}
-	if (!found_one)
-		return -ENODEV;
-	return 0;
-}
-
 static int au1000_setup_aneg(struct net_device *dev, u32 advertise)
 {
 	struct au1000_private *aup =3D (struct au1000_private *)dev->priv;
@@ -1435,40 +1391,14 @@
 	.get_link =3D au1000_get_link
 };
=20
-static struct net_device *
-au1000_probe(u32 ioaddr, int irq, int port_num)
+static int=20
+au1000_lowlevel_probe(struct net_device *ndev, u32 ioaddr, u32 macen_addr,=
 int port_num)
 {
-	static unsigned version_printed =3D 0;
-	struct au1000_private *aup =3D NULL;
-	struct net_device *dev =3D NULL;
+	struct au1000_private *aup =3D ndev->priv;
 	db_dest_t *pDB, *pDBfree;
 	char *pmac, *argptr;
 	char ethaddr[6];
-	int i, err;
-
-	if (!request_mem_region(CPHYSADDR(ioaddr), MAC_IOSIZE, "Au1x00 ENET"))
-		return NULL;
-
-	if (version_printed++ =3D=3D 0)=20
-		printk("%s version %s %s\n", DRV_NAME, DRV_VERSION, DRV_AUTHOR);
-
-	dev =3D alloc_etherdev(sizeof(struct au1000_private));
-	if (!dev) {
-		printk (KERN_ERR "au1000 eth: alloc_etherdev failed\n"); =20
-		return NULL;
-	}
-
-	if ((err =3D register_netdev(dev))) {
-		printk(KERN_ERR "Au1x_eth Cannot register net device err %d\n",
-				err);
-		free_netdev(dev);
-		return NULL;
-	}
-
-	printk("%s: Au1x Ethernet found at 0x%x, irq %d\n",=20
-			dev->name, ioaddr, irq);
-
-	aup =3D dev->priv;
+	int i, ret;
=20
 	/* Allocate the data buffers */
 	/* Snooping works fine with eth on all au1xxx */
@@ -1477,15 +1407,16 @@
 			&aup->dma_addr,
 			0);
 	if (!aup->vaddr) {
-		free_netdev(dev);
-		release_mem_region(CPHYSADDR(ioaddr), MAC_IOSIZE);
-		return NULL;
+		printk(KERN_ERR "%s: cannot dma_alloc_noncoherent\n",
+		       ndev->name);
+		ret =3D -ENOMEM;
+		goto out;
 	}
=20
 	/* aup->mac is the base address of the MAC's registers */
 	aup->mac =3D (volatile mac_reg_t *)((unsigned long)ioaddr);
 	/* Setup some variables for quick register address access */
-	if (ioaddr =3D=3D iflist[0].base_addr)
+	if (port_num =3D=3D 0)
 	{
 		/* check env variables first */
 		if (!get_ethernet_addr(ethaddr)) {=20
@@ -1495,7 +1426,7 @@
 			argptr =3D prom_getcmdline();
 			if ((pmac =3D strstr(argptr, "ethaddr=3D")) =3D=3D NULL) {
 				printk(KERN_INFO "%s: No mac address found\n",=20
-						dev->name);
+						ndev->name);
 				/* use the hard coded mac addresses */
 			} else {
 				str2eaddr(ethaddr, pmac + strlen("ethaddr=3D"));
@@ -1504,26 +1435,26 @@
 			}
 		}
 			aup->enable =3D (volatile u32 *)=20
-				((unsigned long)iflist[0].macen_addr);
-		memcpy(dev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
+				((unsigned long) macen_addr);
+		memcpy(ndev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
 		setup_hw_rings(aup, MAC0_RX_DMA_ADDR, MAC0_TX_DMA_ADDR);
 		aup->mac_id =3D 0;
 		au_macs[0] =3D aup;
 	}
 		else
-	if (ioaddr =3D=3D iflist[1].base_addr)
+	if (port_num =3D=3D 1)
 	{
 			aup->enable =3D (volatile u32 *)=20
-				((unsigned long)iflist[1].macen_addr);
-		memcpy(dev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
-		dev->dev_addr[4] +=3D 0x10;
+				((unsigned long) macen_addr);
+		memcpy(ndev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
+		ndev->dev_addr[4] +=3D 0x10;
 		setup_hw_rings(aup, MAC1_RX_DMA_ADDR, MAC1_TX_DMA_ADDR);
 		aup->mac_id =3D 1;
 		au_macs[1] =3D aup;
 	}
 	else
 	{
-		printk(KERN_ERR "%s: bad ioaddr\n", dev->name);
+		printk(KERN_ERR "%s: bad ioaddr\n", ndev->name);
 	}
=20
 	/* bring the device out of reset, otherwise probing the mii
@@ -1536,7 +1467,8 @@
=20
 	aup->mii =3D kmalloc(sizeof(struct mii_phy), GFP_KERNEL);
 	if (!aup->mii) {
-		printk(KERN_ERR "%s: out of memory\n", dev->name);
+		printk(KERN_ERR "%s: out of memory\n", ndev->name);
+		ret =3D -ENOMEM;
 		goto err_out;
 	}
 	aup->mii->next =3D NULL;
@@ -1545,7 +1477,8 @@
 	aup->mii->mii_control_reg =3D 0;
 	aup->mii->mii_data_reg =3D 0;
=20
-	if (mii_probe(dev) !=3D 0) {
+	if (mii_probe(ndev) !=3D 0) {
+		ret =3D -EBUSY;
 		goto err_out;
 	}
=20
@@ -1564,6 +1497,7 @@
 	for (i =3D 0; i < NUM_RX_DMA; i++) {
 		pDB =3D GetFreeDB(aup);
 		if (!pDB) {
+			ret =3D -ENOMEM;
 			goto err_out;
 		}
 		aup->rx_dma_ring[i]->buff_stat =3D (unsigned)pDB->dma_addr;
@@ -1572,6 +1506,7 @@
 	for (i =3D 0; i < NUM_TX_DMA; i++) {
 		pDB =3D GetFreeDB(aup);
 		if (!pDB) {
+			ret =3D -ENOMEM;
 			goto err_out;
 		}
 		aup->tx_dma_ring[i]->buff_stat =3D (unsigned)pDB->dma_addr;
@@ -1579,32 +1514,24 @@
 		aup->tx_db_inuse[i] =3D pDB;
 	}
=20
-	spin_lock_init(&aup->lock);
-	dev->base_addr =3D ioaddr;
-	dev->irq =3D irq;
-	dev->open =3D au1000_open;
-	dev->hard_start_xmit =3D au1000_tx;
-	dev->stop =3D au1000_close;
-	dev->get_stats =3D au1000_get_stats;
-	dev->set_multicast_list =3D &set_rx_mode;
-	dev->do_ioctl =3D &au1000_ioctl;
-	SET_ETHTOOL_OPS(dev, &au1000_ethtool_ops);
-	dev->set_config =3D &au1000_set_config;
-	dev->tx_timeout =3D au1000_tx_timeout;
-	dev->watchdog_timeo =3D ETH_TX_TIMEOUT;
=20
-	/*=20
-	 * The boot code uses the ethernet controller, so reset it to start=20
-	 * fresh.  au1000_init() expects that the device is in reset state.
-	 */
-	reset_mac(dev);
+	return 0;
=20
-	return dev;
+err_out :
+	au1000_lowlevel_remove(ndev);
+out :
+	return ret;
+}
+
+static void
+au1000_lowlevel_remove(struct net_device *ndev)
+{
+	struct au1000_private *aup =3D ndev->priv;
+	int i;
=20
-err_out:
 	/* here we should have a valid dev plus aup-> register addresses
 	 * so we can reset the mac properly.*/
-	reset_mac(dev);
+	reset_mac(ndev);
 	kfree(aup->mii);
 	for (i =3D 0; i < NUM_RX_DMA; i++) {
 		if (aup->rx_db_inuse[i])
@@ -1618,10 +1545,6 @@
 			MAX_BUF_SIZE * (NUM_TX_BUFFS+NUM_RX_BUFFS),
 			(void *)aup->vaddr,
 			aup->dma_addr);
-	unregister_netdev(dev);
-	free_netdev(dev);
-	release_mem_region(CPHYSADDR(ioaddr), MAC_IOSIZE);
-	return NULL;
 }
=20
 /*=20
@@ -1779,6 +1712,7 @@
 	if (au1000_debug > 4)
 		printk("%s: close: dev=3D%p\n", dev->name, dev);
=20
+	del_timer_sync(&aup->timer);
 	reset_mac(dev);
=20
 	spin_lock_irqsave(&aup->lock, flags);
@@ -1793,36 +1727,6 @@
 	return 0;
 }
=20
-static void __exit au1000_cleanup_module(void)
-{
-	int i, j;
-	struct net_device *dev;
-	struct au1000_private *aup;
-
-	for (i =3D 0; i < num_ifs; i++) {
-		dev =3D iflist[i].dev;
-		if (dev) {
-			aup =3D (struct au1000_private *) dev->priv;
-			unregister_netdev(dev);
-			kfree(aup->mii);
-			for (j =3D 0; j < NUM_RX_DMA; j++) {
-				if (aup->rx_db_inuse[j])
-					ReleaseDB(aup, aup->rx_db_inuse[j]);
-			}
-			for (j =3D 0; j < NUM_TX_DMA; j++) {
-				if (aup->tx_db_inuse[j])
-					ReleaseDB(aup, aup->tx_db_inuse[j]);
-			}
-			dma_free_noncoherent(NULL,
-					MAX_BUF_SIZE * (NUM_TX_BUFFS+NUM_RX_BUFFS),
-					(void *)aup->vaddr,
-					aup->dma_addr);
-			free_netdev(dev);
-			release_mem_region(CPHYSADDR(iflist[i].base_addr), MAC_IOSIZE);
-		}
-	}
-}
-
 static void update_tx_stats(struct net_device *dev, u32 status)
 {
 	struct au1000_private *aup =3D (struct au1000_private *) dev->priv;
@@ -2255,5 +2162,232 @@
 	return 0;
 }
=20
-module_init(au1000_init_module);
-module_exit(au1000_cleanup_module);
+/*
+ * Setup the base address and interupt of the Au1xxx ethernet macs
+ * based on cpu type and whether the interface is enabled in sys_pinfunc
+ * register. The last interface is enabled if SYS_PF_NI2 (bit 4) is 0.
+ */
+static int au1000_drv_probe(struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct net_device *ndev;
+	struct au1000_private *aup;
+	struct resource *res;
+	static unsigned version_printed =3D 0;
+	u32 base_addr, macen_addr;
+	int irq, ret;
+
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "eth-base");
+	if (!res) {
+		ret =3D -ENODEV;
+		goto out;
+	}
+	base_addr =3D res->start;
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "eth-mac");
+	if (!res) {
+		ret =3D -ENODEV;
+		goto out;
+	}
+	macen_addr =3D res->start;
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_IRQ, "eth-irq");
+	if (!res) {
+		ret =3D -ENODEV;
+		goto out;
+	}
+	irq =3D res->start;
+
+	if (!request_mem_region(CPHYSADDR(base_addr), MAC_IOSIZE, "Au1x00 ENET"))=
 {
+		ret =3D -EBUSY;
+		goto out;
+	}
+
+	if (version_printed++ =3D=3D 0)=20
+		printk("%s version %s %s\n", DRV_NAME, DRV_VERSION, DRV_AUTHOR);
+
+	ndev =3D alloc_etherdev(sizeof(struct au1000_private));
+	if (!ndev) {
+		printk (KERN_ERR "%s: alloc etherdev failed\n", DRV_NAME); =20
+		ret =3D -ENOMEM;
+		goto out_release_io;
+	}
+	SET_MODULE_OWNER(ndev);
+	SET_NETDEV_DEV(ndev, dev);
+
+	ret =3D au1000_lowlevel_probe(ndev, base_addr, macen_addr, pdev->id);
+	if (ret < 0) {
+		printk (KERN_ERR "%s: low level probe failed\n", DRV_NAME); =20
+		goto out_free_netdev;
+	}
+
+	aup =3D ndev->priv;
+
+	spin_lock_init(&aup->lock);
+	ndev->base_addr =3D base_addr;
+	ndev->irq =3D irq;
+	ndev->open =3D au1000_open;
+	ndev->hard_start_xmit =3D au1000_tx;
+	ndev->stop =3D au1000_close;
+	ndev->get_stats =3D au1000_get_stats;
+	ndev->set_multicast_list =3D &set_rx_mode;
+	ndev->do_ioctl =3D &au1000_ioctl;
+	SET_ETHTOOL_OPS(ndev, &au1000_ethtool_ops);
+	ndev->set_config =3D &au1000_set_config;
+	ndev->tx_timeout =3D au1000_tx_timeout;
+	ndev->watchdog_timeo =3D ETH_TX_TIMEOUT;
+
+	/*=20
+	 * The boot code uses the ethernet controller, so reset it to start=20
+	 * fresh.  au1000_init() expects that the device is in reset state.
+	 */
+	reset_mac(ndev);
+
+	ret =3D register_netdev(ndev);
+	if (ret) {
+		printk(KERN_ERR "%s: cannot register net device err %d\n",
+		       DRV_NAME, ret);
+		goto out_lowlevel_remove;
+	}
+
+	printk("%s: Au1x Ethernet found at 0x%x, irq %d\n",=20
+			ndev->name, base_addr, irq);
+
+	dev_set_drvdata(dev, ndev);
+
+	return 0;
+
+out_lowlevel_remove :
+	au1000_lowlevel_remove(ndev);
+out_free_netdev :
+	free_netdev(ndev);
+out_release_io :
+	release_mem_region(CPHYSADDR(base_addr), MAC_IOSIZE);
+out :
+	printk("%s: not found (%d).\n", DRV_NAME, ret);
+
+	return ret;
+}
+
+static int au1000_drv_remove(struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct net_device *ndev =3D dev_get_drvdata(dev);
+	struct resource *res;
+
+	dev_set_drvdata(dev, NULL);
+
+	unregister_netdev(ndev);
+	au1000_lowlevel_remove(ndev);
+	free_netdev(ndev);
+
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "eth-base");
+	if (!res) {
+		printk(DRV_NAME ": warning! Invalid data!");
+		return -EINVAL;
+	}
+	release_mem_region(CPHYSADDR(res->start), MAC_IOSIZE);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int au1000_drv_suspend(struct device *dev, pm_message_t state, u32 =
level)
+{
+	struct net_device *ndev =3D dev_get_drvdata(dev);
+	struct au1000_private *aup =3D (struct au1000_private *) ndev->priv;
+
+	if (!ndev)
+		return 0;
+
+	switch (level) {
+	case SUSPEND_DISABLE :
+		if (netif_running(ndev))
+			netif_device_detach(ndev);
+
+		break;
+=09
+	case SUSPEND_SAVE_STATE :
+		/* bring the device out of reset, otherwise accessing to mii
+	 	 * will hang */
+		*aup->enable =3D MAC_EN_CLOCK_ENABLE;
+		au_sync_delay(2);
+		*aup->enable =3D MAC_EN_RESET0 | MAC_EN_RESET1 |=20
+				MAC_EN_RESET2 | MAC_EN_CLOCK_ENABLE;
+		au_sync_delay(2);
+
+		if (aup->phy_ops->phy_suspend)
+			aup->phy_ops->phy_suspend(ndev, aup->phy_addr, level);
+
+		au1000_lowlevel_remove(ndev);
+
+		break;
+
+	case SUSPEND_POWER_DOWN :
+
+		break;
+	}
+
+	return 0;
+}
+
+static int au1000_drv_resume(struct device *dev, u32 level)
+{
+	struct net_device *ndev =3D dev_get_drvdata(dev);
+	struct au1000_private *aup =3D (struct au1000_private *) ndev->priv;
+	int ret;
+
+	if (!ndev)
+		return 0;
+
+	switch (level) {
+	case RESUME_RESTORE_STATE :
+		ret =3D au1000_lowlevel_probe(ndev, aup->mac, aup->enable, aup->mac_id);
+		if (ret < 0) {
+			printk (KERN_ERR "%s: low level probe failed\n", DRV_NAME); =20
+			return ret;
+		}
+
+		if (aup->phy_ops->phy_resume)
+			aup->phy_ops->phy_resume(ndev, aup->phy_addr, level);
+		aup->phy_ops->phy_init(ndev, aup->phy_addr);
+
+		/* au1000_init() expects that the device is in reset state.
+		 */
+		reset_mac(ndev); /* au1000_init() expects the device in reset */
+		au1000_init(ndev);
+
+		break;
+
+	case RESUME_ENABLE :
+		if (netif_running(ndev))
+			netif_device_attach(ndev);
+
+		break;
+	}
+
+	return 0;
+}
+#endif
+
+static struct device_driver au1000_driver =3D {
+	.name		=3D DRV_NAME,
+	.bus		=3D &platform_bus_type,
+	.probe          =3D au1000_drv_probe,
+	.remove         =3D au1000_drv_remove,
+#ifdef CONFIG_PM
+	.suspend        =3D au1000_drv_suspend,
+	.resume         =3D au1000_drv_resume,
+#endif
+};
+
+static int __init au1000_eth_init(void)
+{
+	return driver_register(&au1000_driver);
+}
+
+static void __exit au1000_eth_cleanup(void)
+{
+	driver_unregister(&au1000_driver);
+}
+
+module_init(au1000_eth_init);
+module_exit(au1000_eth_cleanup);
--- /home/develop/embedded/mipsel/linux/linux-mips.git/drivers/net/au1000_e=
th.h	2006-03-31 16:58:55.000000000 +0200
+++ drivers/net/au1000_eth.h	2006-04-05 12:55:56.000000000 +0200
@@ -152,6 +152,8 @@
 	int (*phy_init) (struct net_device *, int);
 	int (*phy_reset) (struct net_device *, int);
 	int (*phy_status) (struct net_device *, int, u16 *, u16 *);
+	int (*phy_suspend) (struct net_device *, int, int);
+	int (*phy_resume) (struct net_device *, int, int);
 };
=20
 /*=20

--gKYyLFtP+LgnHcbx--

--hbBJ5WP8dkNDDowN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFENEQMQaTCYNJaVjMRAni3AJ476k6BnYMSfYPpAVq1yBpSA2ATpQCgyt++
tAiUqb75CVIW4cNUrdfD9k8=
=EDFg
-----END PGP SIGNATURE-----

--hbBJ5WP8dkNDDowN--
