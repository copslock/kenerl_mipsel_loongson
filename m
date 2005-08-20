Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Aug 2005 06:49:00 +0100 (BST)
Received: from loopy.telegraphics.com.au ([IPv6:::ffff:202.45.126.152]:44459
	"EHLO loopy.telegraphics.com.au") by linux-mips.org with ESMTP
	id <S8224909AbVHTFsX>; Sat, 20 Aug 2005 06:48:23 +0100
Received: by loopy.telegraphics.com.au (Postfix, from userid 1001)
	id 77B46C9740; Sat, 20 Aug 2005 15:53:22 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by loopy.telegraphics.com.au (Postfix) with ESMTP id 73B102A9C4;
	Sat, 20 Aug 2005 15:53:22 +1000 (EST)
Date:	Sat, 20 Aug 2005 15:53:22 +1000 (EST)
From:	Finn Thain <fthain@telegraphics.com.au>
To:	Jeff Garzik <jgarzik@pobox.com>
Cc:	Roman Zippel <zippel@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/m68k <linux-m68k@vger.kernel.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux MIPS <linux-mips@linux-mips.org>,
	Linux net <linux-net@vger.kernel.org>
Subject: Re: [PATCH 1/1 RESEND] macsonic/jazzsonic network drivers update
In-Reply-To: <4306B689.6050705@pobox.com>
Message-ID: <Pine.LNX.4.63.0508201521410.3539@loopy.telegraphics.com.au>
References: <200503070210.j272ARii023023@hera.kernel.org>
 <Pine.LNX.4.62.0503221807160.20753@numbat.sonytel.be> <20050323100139.GB8813@linux-mips.org>
 <Pine.LNX.4.61.0506121454410.1470@loopy.telegraphics.com.au>
 <20050615114158.GA9411@linux-mips.org> <Pine.LNX.4.61.0506152220460.22046@loopy.telegraphics.com.au>
 <20050615142717.GD9411@linux-mips.org> <Pine.LNX.4.61.0506160218310.24328@loopy.telegraphics.com.au>
 <Pine.LNX.4.61.0506160336410.24908@loopy.telegraphics.com.au>
 <20050616092257.GE5202@linux-mips.org> <Pine.LNX.4.61.0506162129450.31164@loopy.telegraphics.com.au>
 <Pine.LNX.4.61.0506270227510.1015@loopy.telegraphics.com.au>
 <42BEEC32.7040807@pobox.com> <Pine.LNX.4.61.0507130122220.4355@loopy.telegraphics.com.au>
 <Pine.LNX.4.63.0508201406350.3539@loopy.telegraphics.com.au>
 <4306B689.6050705@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <fthain@telegraphics.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fthain@telegraphics.com.au
Precedence: bulk
X-list: linux-mips


The purpose of this patch:

- Adopt the DMA API (jazzsonic, macsonic & core driver).

- Adopt the driver model (macsonic).

This part was cribbed from jazzsonic. As a consequence, macsonic once 
again works as a module. Driver model is also used by the DMA calls.

- Support 16 bit cards (macsonic & core driver, also affects jazzsonic)

This code was adapted from the mac68k linux 2.2 kernel, where it has 
languished for a long time.

- Support more 32-bit mac cards (macsonic)

Also from mac68k repo.

- Zero-copy buffer handling (core driver)

Provides a nice performance improvement. The new algorithm incidentally 
helped to replace the old Jazz DMA code.

The patch was tested on a variety of macs (several 32-bit quadra built-in 
NICs, a 16-bit LC PDS NIC and a 16-bit comm-slot NIC), and also on MIPS 
Jazz.

This patch combines the three previous patches in this thread.


Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Acked-by: Jeff Garzik <jgarzik@pobox.com>



--- orig/drivers/net/Space.c	Sun Jul 10 22:11:34 2005
+++ linux/drivers/net/Space.c	Sun Jul 10 22:11:46 2005
@@ -87,7 +87,6 @@
 extern struct net_device *tc515_probe(int unit);
 extern struct net_device *lance_probe(int unit);
 extern struct net_device *mace_probe(int unit);
-extern struct net_device *macsonic_probe(int unit);
 extern struct net_device *mac8390_probe(int unit);
 extern struct net_device *mac89x0_probe(int unit);
 extern struct net_device *mc32_probe(int unit);
@@ -289,9 +288,6 @@
 #endif
 #ifdef CONFIG_MACMACE		/* Mac 68k Quadra AV builtin Ethernet */
 	{mace_probe, 0},
-#endif
-#ifdef CONFIG_MACSONIC		/* Mac SONIC-based Ethernet of all sorts */ 
-	{macsonic_probe, 0},
 #endif
 #ifdef CONFIG_MAC8390           /* NuBus NS8390-based cards */
 	{mac8390_probe, 0},
--- orig/drivers/net/jazzsonic.c	Sun Jul 10 22:11:34 2005
+++ linux/drivers/net/jazzsonic.c	Sun Jul 10 22:22:39 2005
@@ -1,5 +1,10 @@
 /*
- * sonic.c
+ * jazzsonic.c
+ *
+ * (C) 2005 Finn Thain
+ *
+ * Converted to DMA API, and (from the mac68k project) introduced
+ * dhd's support for 16-bit cards.
  *
  * (C) 1996,1998 by Thomas Bogendoerfer (tsbogend@alpha.franken.de)
  * 
@@ -28,8 +33,8 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
-#include <linux/bitops.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/bootinfo.h>
 #include <asm/system.h>
@@ -44,22 +49,20 @@
 
 #define SONIC_MEM_SIZE	0x100
 
-#define SREGS_PAD(n)    u16 n;
-
 #include "sonic.h"
 
 /*
  * Macros to access SONIC registers
  */
-#define SONIC_READ(reg) (*((volatile unsigned int *)base_addr+reg))
+#define SONIC_READ(reg) (*((volatile unsigned int *)dev->base_addr+reg))
 
 #define SONIC_WRITE(reg,val)						\
 do {									\
-	*((volatile unsigned int *)base_addr+(reg)) = (val);		\
+	*((volatile unsigned int *)dev->base_addr+(reg)) = (val);		\
 } while (0)
 
 
-/* use 0 for production, 1 for verification, >2 for debug */
+/* use 0 for production, 1 for verification, >1 for debug */
 #ifdef SONIC_DEBUG
 static unsigned int sonic_debug = SONIC_DEBUG;
 #else 
@@ -85,18 +88,18 @@
 	0xffff			/* end of list */
 };
 
-static int __init sonic_probe1(struct net_device *dev, unsigned long base_addr,
-                               unsigned int irq)
+static int __init sonic_probe1(struct net_device *dev)
 {
 	static unsigned version_printed;
 	unsigned int silicon_revision;
 	unsigned int val;
-	struct sonic_local *lp;
+	struct sonic_local *lp = netdev_priv(dev);
 	int err = -ENODEV;
 	int i;
 
-	if (!request_mem_region(base_addr, SONIC_MEM_SIZE, jazz_sonic_string))
+	if (!request_mem_region(dev->base_addr, SONIC_MEM_SIZE, jazz_sonic_string))
 		return -EBUSY;
+
 	/*
 	 * get the Silicon Revision ID. If this is one of the known
 	 * one assume that we found a SONIC ethernet controller at
@@ -120,11 +123,7 @@
 	if (sonic_debug  &&  version_printed++ == 0)
 		printk(version);
 
-	printk("%s: Sonic ethernet found at 0x%08lx, ", dev->name, base_addr);
-
-	/* Fill in the 'dev' fields. */
-	dev->base_addr = base_addr;
-	dev->irq = irq;
+	printk(KERN_INFO "%s: Sonic ethernet found at 0x%08lx, ", lp->device->bus_id, dev->base_addr);
 
 	/*
 	 * Put the sonic into software reset, then
@@ -138,84 +137,44 @@
 		dev->dev_addr[i*2+1] = val >> 8;
 	}
 
-	printk("HW Address ");
-	for (i = 0; i < 6; i++) {
-		printk("%2.2x", dev->dev_addr[i]);
-		if (i<5)
-			printk(":");
-	}
-
-	printk(" IRQ %d\n", irq);
-
 	err = -ENOMEM;
     
 	/* Initialize the device structure. */
-	if (dev->priv == NULL) {
-		/*
-		 * the memory be located in the same 64kb segment
-		 */
-		lp = NULL;
-		i = 0;
-		do {
-			lp = kmalloc(sizeof(*lp), GFP_KERNEL);
-			if ((unsigned long) lp >> 16
-			    != ((unsigned long)lp + sizeof(*lp) ) >> 16) {
-				/* FIXME, free the memory later */
-				kfree(lp);
-				lp = NULL;
-			}
-		} while (lp == NULL && i++ < 20);
-
-		if (lp == NULL) {
-			printk("%s: couldn't allocate memory for descriptors\n",
-			       dev->name);
-			goto out;
-		}
 
-		memset(lp, 0, sizeof(struct sonic_local));
-
-		/* get the virtual dma address */
-		lp->cda_laddr = vdma_alloc(CPHYSADDR(lp),sizeof(*lp));
-		if (lp->cda_laddr == ~0UL) {
-			printk("%s: couldn't get DMA page entry for "
-			       "descriptors\n", dev->name);
-			goto out1;
-		}
-
-		lp->tda_laddr = lp->cda_laddr + sizeof (lp->cda);
-		lp->rra_laddr = lp->tda_laddr + sizeof (lp->tda);
-		lp->rda_laddr = lp->rra_laddr + sizeof (lp->rra);
-	
-		/* allocate receive buffer area */
-		/* FIXME, maybe we should use skbs */
-		lp->rba = kmalloc(SONIC_NUM_RRS * SONIC_RBSIZE, GFP_KERNEL);
-		if (!lp->rba) {
-			printk("%s: couldn't allocate receive buffers\n",
-			       dev->name);
-			goto out2;
-		}
+	lp->dma_bitmode = SONIC_BITMODE32;
 
-		/* get virtual dma address */
-		lp->rba_laddr = vdma_alloc(CPHYSADDR(lp->rba),
-		                           SONIC_NUM_RRS * SONIC_RBSIZE);
-		if (lp->rba_laddr == ~0UL) {
-			printk("%s: couldn't get DMA page entry for receive "
-			       "buffers\n",dev->name);
-			goto out3;
-		}
-
-		/* now convert pointer to KSEG1 pointer */
-		lp->rba = (char *)KSEG1ADDR(lp->rba);
-		flush_cache_all();
-		dev->priv = (struct sonic_local *)KSEG1ADDR(lp);
+	/* Allocate the entire chunk of memory for the descriptors.
+           Note that this cannot cross a 64K boundary. */
+	if ((lp->descriptors = dma_alloc_coherent(lp->device,
+				SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
+				&lp->descriptors_laddr, GFP_KERNEL)) == NULL) {
+		printk(KERN_ERR "%s: couldn't alloc DMA memory for descriptors.\n", lp->device->bus_id);
+		goto out;
 	}
 
-	lp = (struct sonic_local *)dev->priv;
+	/* Now set up the pointers to point to the appropriate places */
+	lp->cda = lp->descriptors;
+	lp->tda = lp->cda + (SIZEOF_SONIC_CDA
+	                     * SONIC_BUS_SCALE(lp->dma_bitmode));
+	lp->rda = lp->tda + (SIZEOF_SONIC_TD * SONIC_NUM_TDS
+	                     * SONIC_BUS_SCALE(lp->dma_bitmode));
+	lp->rra = lp->rda + (SIZEOF_SONIC_RD * SONIC_NUM_RDS
+	                     * SONIC_BUS_SCALE(lp->dma_bitmode));
+
+	lp->cda_laddr = lp->descriptors_laddr;
+	lp->tda_laddr = lp->cda_laddr + (SIZEOF_SONIC_CDA
+	                     * SONIC_BUS_SCALE(lp->dma_bitmode));
+	lp->rda_laddr = lp->tda_laddr + (SIZEOF_SONIC_TD * SONIC_NUM_TDS
+	                     * SONIC_BUS_SCALE(lp->dma_bitmode));
+	lp->rra_laddr = lp->rda_laddr + (SIZEOF_SONIC_RD * SONIC_NUM_RDS
+	                     * SONIC_BUS_SCALE(lp->dma_bitmode));
+
 	dev->open = sonic_open;
 	dev->stop = sonic_close;
 	dev->hard_start_xmit = sonic_send_packet;
-	dev->get_stats	= sonic_get_stats;
+	dev->get_stats = sonic_get_stats;
 	dev->set_multicast_list = &sonic_multicast_list;
+	dev->tx_timeout = sonic_tx_timeout;
 	dev->watchdog_timeo = TX_TIMEOUT;
 
 	/*
@@ -226,14 +185,8 @@
 	SONIC_WRITE(SONIC_MPT,0xffff);
 
 	return 0;
-out3:
-	kfree(lp->rba);
-out2:
-	vdma_free(lp->cda_laddr);
-out1:
-	kfree(lp);
 out:
-	release_region(base_addr, SONIC_MEM_SIZE);
+	release_region(dev->base_addr, SONIC_MEM_SIZE);
 	return err;
 }
 
@@ -245,7 +198,6 @@
 {
 	struct net_device *dev;
 	struct sonic_local *lp;
-	unsigned long base_addr;
 	int err = 0;
 	int i;
 
@@ -255,21 +207,26 @@
 	if (mips_machgroup != MACH_GROUP_JAZZ)
 		return -ENODEV;
 
-	dev = alloc_etherdev(0);
+	dev = alloc_etherdev(sizeof(struct sonic_local));
 	if (!dev)
 		return -ENOMEM;
 
+	lp = netdev_priv(dev);
+	lp->device = device;
+	SET_NETDEV_DEV(dev, device);
+ 	SET_MODULE_OWNER(dev);
+
 	netdev_boot_setup_check(dev);
-	base_addr = dev->base_addr;
 
-	if (base_addr >= KSEG0)	{ /* Check a single specified location. */
-		err = sonic_probe1(dev, base_addr, dev->irq);
-	} else if (base_addr != 0) { /* Don't probe at all. */
+	if (dev->base_addr >= KSEG0) { /* Check a single specified location. */
+		err = sonic_probe1(dev);
+	} else if (dev->base_addr != 0) { /* Don't probe at all. */
 		err = -ENXIO;
 	} else {
 		for (i = 0; sonic_portlist[i].port; i++) {
-			int io = sonic_portlist[i].port;
-			if (sonic_probe1(dev, io, sonic_portlist[i].irq) == 0)
+			dev->base_addr = sonic_portlist[i].port;
+			dev->irq = sonic_portlist[i].irq;
+			if (sonic_probe1(dev) == 0)
 				break;
 		}
 		if (!sonic_portlist[i].port)
@@ -281,14 +238,17 @@
 	if (err)
 		goto out1;
 
+	printk("%s: MAC ", dev->name);
+	for (i = 0; i < 6; i++) {
+		printk("%2.2x", dev->dev_addr[i]);
+		if (i < 5)
+			printk(":");
+	}
+	printk(" IRQ %d\n", dev->irq);
+
 	return 0;
 
 out1:
-	lp = dev->priv;
-	vdma_free(lp->rba_laddr);
-	kfree(lp->rba);
-	vdma_free(lp->cda_laddr);
-	kfree(lp);
 	release_region(dev->base_addr, SONIC_MEM_SIZE);
 out:
 	free_netdev(dev);
@@ -296,21 +256,22 @@
 	return err;
 }
 
-/*
- *      SONIC uses a normal IRQ
- */
-#define sonic_request_irq       request_irq
-#define sonic_free_irq          free_irq
+MODULE_DESCRIPTION("Jazz SONIC ethernet driver");
+module_param(sonic_debug, int, 0);
+MODULE_PARM_DESC(sonic_debug, "jazzsonic debug level (1-4)");
 
-#define sonic_chiptomem(x)      KSEG1ADDR(vdma_log2phys(x))
+#define SONIC_IRQ_FLAG SA_INTERRUPT
 
 #include "sonic.c"
 
 static int __devexit jazz_sonic_device_remove (struct device *device)
 {
 	struct net_device *dev = device->driver_data;
+	struct sonic_local* lp = netdev_priv(dev);
 
 	unregister_netdev (dev);
+	dma_free_coherent(lp->device, SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
+	                  lp->descriptors, lp->descriptors_laddr);
 	release_region (dev->base_addr, SONIC_MEM_SIZE);
 	free_netdev (dev);
 
@@ -323,7 +284,7 @@
 	.probe	= jazz_sonic_probe,
 	.remove	= __devexit_p(jazz_sonic_device_remove),
 };
-                                                                                
+
 static void jazz_sonic_platform_release (struct device *device)
 {
 	struct platform_device *pldev;
@@ -336,10 +297,11 @@
 static int __init jazz_sonic_init_module(void)
 {
 	struct platform_device *pldev;
+	int err;
 
-	if (driver_register(&jazz_sonic_driver)) {
+	if ((err = driver_register(&jazz_sonic_driver))) {
 		printk(KERN_ERR "Driver registration failed\n");
-		return -ENOMEM;
+		return err;
 	}
 
 	jazz_sonic_device = NULL;
--- orig/drivers/net/macsonic.c	Sun Jul 10 22:11:34 2005
+++ linux/drivers/net/macsonic.c	Sun Jul 10 22:23:06 2005
@@ -1,6 +1,12 @@
 /*
  * macsonic.c
  *
+ * (C) 2005 Finn Thain
+ *
+ * Converted to DMA API, converted to unified driver model, made it work as
+ * a module again, and from the mac68k project, introduced more 32-bit cards
+ * and dhd's support for 16-bit cards.
+ *
  * (C) 1998 Alan Cox
  *
  * Debugging Andreas Ehliar, Michael Schmitz
@@ -26,8 +32,8 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/types.h>
-#include <linux/ctype.h>
 #include <linux/fcntl.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -41,8 +47,8 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
-#include <linux/module.h>
-#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/bootinfo.h>
 #include <asm/system.h>
@@ -54,25 +60,28 @@
 #include <asm/macints.h>
 #include <asm/mac_via.h>
 
-#define SREGS_PAD(n)    u16 n;
+static char mac_sonic_string[] = "macsonic";
+static struct platform_device *mac_sonic_device;
 
 #include "sonic.h"
 
-#define SONIC_READ(reg) \
-	nubus_readl(base_addr+(reg))
-#define SONIC_WRITE(reg,val) \
-	nubus_writel((val), base_addr+(reg))
-#define sonic_read(dev, reg) \
-	nubus_readl((dev)->base_addr+(reg))
-#define sonic_write(dev, reg, val) \
-	nubus_writel((val), (dev)->base_addr+(reg))
-
+/* These should basically be bus-size and endian independent (since
+   the SONIC is at least smart enough that it uses the same endianness
+   as the host, unlike certain less enlightened Macintosh NICs) */
+#define SONIC_READ(reg) (nubus_readw(dev->base_addr + (reg * 4) \
+	      + lp->reg_offset))
+#define SONIC_WRITE(reg,val) (nubus_writew(val, dev->base_addr + (reg * 4) \
+	      + lp->reg_offset))
+
+/* use 0 for production, 1 for verification, >1 for debug */
+#ifdef SONIC_DEBUG
+static unsigned int sonic_debug = SONIC_DEBUG;
+#else 
+static unsigned int sonic_debug = 1;
+#endif
 
-static int sonic_debug;
 static int sonic_version_printed;
 
-static int reg_offset;
-
 extern int mac_onboard_sonic_probe(struct net_device* dev);
 extern int mac_nubus_sonic_probe(struct net_device* dev);
 
@@ -108,40 +117,6 @@
 
 #define SONIC_READ_PROM(addr) nubus_readb(prom_addr+addr)
 
-struct net_device * __init macsonic_probe(int unit)
-{
-	struct net_device *dev = alloc_etherdev(0);
-	int err;
-
-	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	if (unit >= 0)
-		sprintf(dev->name, "eth%d", unit);
-
- 	SET_MODULE_OWNER(dev);
-
-	/* This will catch fatal stuff like -ENOMEM as well as success */
-	err = mac_onboard_sonic_probe(dev);
-	if (err == 0)
-		goto found;
-	if (err != -ENODEV)
-		goto out;
-	err = mac_nubus_sonic_probe(dev);
-	if (err)
-		goto out;
-found:
-	err = register_netdev(dev);
-	if (err)
-		goto out1;
-	return dev;
-out1:
-	kfree(dev->priv);
-out:
-	free_netdev(dev);
-	return ERR_PTR(err);
-}
-
 /*
  * For reversing the PROM address
  */
@@ -160,103 +135,55 @@
 
 int __init macsonic_init(struct net_device* dev)
 {
-	struct sonic_local* lp = NULL;
-	int i;
+	struct sonic_local* lp = netdev_priv(dev);
 
 	/* Allocate the entire chunk of memory for the descriptors.
            Note that this cannot cross a 64K boundary. */
-	for (i = 0; i < 20; i++) {
-		unsigned long desc_base, desc_top;
-		if((lp = kmalloc(sizeof(struct sonic_local), GFP_KERNEL | GFP_DMA)) == NULL) {
-			printk(KERN_ERR "%s: couldn't allocate descriptor buffers\n", dev->name);
-			return -ENOMEM;
-		}
-
-		desc_base = (unsigned long) lp;
-		desc_top = desc_base + sizeof(struct sonic_local);
-		if ((desc_top & 0xffff) >= (desc_base & 0xffff))
-			break;
-		/* Hmm. try again (FIXME: does this actually work?) */
-		kfree(lp);
-		printk(KERN_DEBUG
-		       "%s: didn't get continguous chunk [%08lx - %08lx], trying again\n",
-		       dev->name, desc_base, desc_top);
-	}
-
-	if (lp == NULL) {
-		printk(KERN_ERR "%s: tried 20 times to allocate descriptor buffers, giving up.\n",
-		       dev->name);
+	if ((lp->descriptors = dma_alloc_coherent(lp->device,
+	            SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
+	            &lp->descriptors_laddr, GFP_KERNEL)) == NULL) {
+		printk(KERN_ERR "%s: couldn't alloc DMA memory for descriptors.\n", lp->device->bus_id);
 		return -ENOMEM;
-	}		       
-
-	dev->priv = lp;
-
-#if 0
-	/* this code is only here as a curiousity...   mainly, where the 
-	   fuck did SONIC_BUS_SCALE come from, and what was it supposed
-	   to do?  the normal allocation works great for 32 bit stuffs..  */
+	}
 
 	/* Now set up the pointers to point to the appropriate places */
-	lp->cda = lp->sonic_desc;
-	lp->tda = lp->cda + (SIZEOF_SONIC_CDA * SONIC_BUS_SCALE(lp->dma_bitmode));
+	lp->cda = lp->descriptors;
+	lp->tda = lp->cda + (SIZEOF_SONIC_CDA
+	                     * SONIC_BUS_SCALE(lp->dma_bitmode));
 	lp->rda = lp->tda + (SIZEOF_SONIC_TD * SONIC_NUM_TDS
-			     * SONIC_BUS_SCALE(lp->dma_bitmode));
+	                     * SONIC_BUS_SCALE(lp->dma_bitmode));
 	lp->rra = lp->rda + (SIZEOF_SONIC_RD * SONIC_NUM_RDS
-			     * SONIC_BUS_SCALE(lp->dma_bitmode));
+	                     * SONIC_BUS_SCALE(lp->dma_bitmode));
 
-#endif
-	
-	memset(lp, 0, sizeof(struct sonic_local));
-
-	lp->cda_laddr = (unsigned int)&(lp->cda);
-	lp->tda_laddr = (unsigned int)lp->tda;
-	lp->rra_laddr = (unsigned int)lp->rra;
-	lp->rda_laddr = (unsigned int)lp->rda;
-
-	/* FIXME, maybe we should use skbs */
-	if ((lp->rba = (char *)
-	     kmalloc(SONIC_NUM_RRS * SONIC_RBSIZE, GFP_KERNEL | GFP_DMA)) == NULL) {
-		printk(KERN_ERR "%s: couldn't allocate receive buffers\n", dev->name);
-		dev->priv = NULL;
-		kfree(lp);
-		return -ENOMEM;
-	}
-
-	lp->rba_laddr = (unsigned int)lp->rba;
-
-	{
-		int rs, ds;
-
-		/* almost always 12*4096, but let's not take chances */
-		rs = ((SONIC_NUM_RRS * SONIC_RBSIZE + 4095) / 4096) * 4096;
-		/* almost always under a page, but let's not take chances */
-		ds = ((sizeof(struct sonic_local) + 4095) / 4096) * 4096;
-		kernel_set_cachemode(lp->rba, rs, IOMAP_NOCACHE_SER);
-		kernel_set_cachemode(lp, ds, IOMAP_NOCACHE_SER);
-	}
-	
-#if 0
-	flush_cache_all();
-#endif
+	lp->cda_laddr = lp->descriptors_laddr;
+	lp->tda_laddr = lp->cda_laddr + (SIZEOF_SONIC_CDA
+	                     * SONIC_BUS_SCALE(lp->dma_bitmode));
+	lp->rda_laddr = lp->tda_laddr + (SIZEOF_SONIC_TD * SONIC_NUM_TDS
+	                     * SONIC_BUS_SCALE(lp->dma_bitmode));
+	lp->rra_laddr = lp->rda_laddr + (SIZEOF_SONIC_RD * SONIC_NUM_RDS
+	                     * SONIC_BUS_SCALE(lp->dma_bitmode));
 
 	dev->open = sonic_open;
 	dev->stop = sonic_close;
 	dev->hard_start_xmit = sonic_send_packet;
 	dev->get_stats = sonic_get_stats;
 	dev->set_multicast_list = &sonic_multicast_list;
+	dev->tx_timeout = sonic_tx_timeout;
+	dev->watchdog_timeo = TX_TIMEOUT;
 
 	/*
 	 * clear tally counter
 	 */
-	sonic_write(dev, SONIC_CRCT, 0xffff);
-	sonic_write(dev, SONIC_FAET, 0xffff);
-	sonic_write(dev, SONIC_MPT, 0xffff);
+	SONIC_WRITE(SONIC_CRCT, 0xffff);
+	SONIC_WRITE(SONIC_FAET, 0xffff);
+	SONIC_WRITE(SONIC_MPT, 0xffff);
 
 	return 0;
 }
 
 int __init mac_onboard_sonic_ethernet_addr(struct net_device* dev)
 {
+	struct sonic_local *lp = netdev_priv(dev);
 	const int prom_addr = ONBOARD_SONIC_PROM_BASE;
 	int i;
 
@@ -270,6 +197,7 @@
 	   why this is so. */
 	if (memcmp(dev->dev_addr, "\x08\x00\x07", 3) &&
 	    memcmp(dev->dev_addr, "\x00\xA0\x40", 3) &&
+	    memcmp(dev->dev_addr, "\x00\x80\x19", 3) &&
 	    memcmp(dev->dev_addr, "\x00\x05\x02", 3))
 		bit_reverse_addr(dev->dev_addr);
 	else
@@ -281,22 +209,23 @@
            the card... */
 	if (memcmp(dev->dev_addr, "\x08\x00\x07", 3) &&
 	    memcmp(dev->dev_addr, "\x00\xA0\x40", 3) &&
+	    memcmp(dev->dev_addr, "\x00\x80\x19", 3) &&
 	    memcmp(dev->dev_addr, "\x00\x05\x02", 3))
 	{
 		unsigned short val;
 
 		printk(KERN_INFO "macsonic: PROM seems to be wrong, trying CAM entry 15\n");
 		
-		sonic_write(dev, SONIC_CMD, SONIC_CR_RST);
-		sonic_write(dev, SONIC_CEP, 15);
+		SONIC_WRITE(SONIC_CMD, SONIC_CR_RST);
+		SONIC_WRITE(SONIC_CEP, 15);
 
-		val = sonic_read(dev, SONIC_CAP2);
+		val = SONIC_READ(SONIC_CAP2);
 		dev->dev_addr[5] = val >> 8;
 		dev->dev_addr[4] = val & 0xff;
-		val = sonic_read(dev, SONIC_CAP1);
+		val = SONIC_READ(SONIC_CAP1);
 		dev->dev_addr[3] = val >> 8;
 		dev->dev_addr[2] = val & 0xff;
-		val = sonic_read(dev, SONIC_CAP0);
+		val = SONIC_READ(SONIC_CAP0);
 		dev->dev_addr[1] = val >> 8;
 		dev->dev_addr[0] = val & 0xff;
 		
@@ -311,6 +240,7 @@
 
 	if (memcmp(dev->dev_addr, "\x08\x00\x07", 3) &&
 	    memcmp(dev->dev_addr, "\x00\xA0\x40", 3) &&
+	    memcmp(dev->dev_addr, "\x00\x80\x19", 3) &&
 	    memcmp(dev->dev_addr, "\x00\x05\x02", 3))
 	{
 		/*
@@ -325,8 +255,9 @@
 {
 	/* Bwahahaha */
 	static int once_is_more_than_enough;
-	int i;
-	int dma_bitmode;
+	struct sonic_local* lp = netdev_priv(dev);
+	int sr;
+	int commslot = 0;
 	
 	if (once_is_more_than_enough)
 		return -ENODEV;
@@ -335,20 +266,18 @@
 	if (!MACH_IS_MAC)
 		return -ENODEV;
 
-	printk(KERN_INFO "Checking for internal Macintosh ethernet (SONIC).. ");
-
 	if (macintosh_config->ether_type != MAC_ETHER_SONIC)
-	{
-		printk("none.\n");
 		return -ENODEV;
-	}
-
+	
+	printk(KERN_INFO "Checking for internal Macintosh ethernet (SONIC).. ");
+	
 	/* Bogus probing, on the models which may or may not have
 	   Ethernet (BTW, the Ethernet *is* always at the same
 	   address, and nothing else lives there, at least if Apple's
 	   documentation is to be believed) */
 	if (macintosh_config->ident == MAC_MODEL_Q630 ||
 	    macintosh_config->ident == MAC_MODEL_P588 ||
+	    macintosh_config->ident == MAC_MODEL_P575 ||
 	    macintosh_config->ident == MAC_MODEL_C610) {
 		unsigned long flags;
 		int card_present;
@@ -361,13 +290,13 @@
 			printk("none.\n");
 			return -ENODEV;
 		}
+		commslot = 1;
 	}
 
 	printk("yes\n");	
 
-	/* Danger!  My arms are flailing wildly!  You *must* set this
-           before using sonic_read() */
-
+	/* Danger!  My arms are flailing wildly!  You *must* set lp->reg_offset
+	 * and dev->base_addr before using SONIC_READ() or SONIC_WRITE() */
 	dev->base_addr = ONBOARD_SONIC_REGISTERS;
 	if (via_alt_mapping)
 		dev->irq = IRQ_AUTO_3;
@@ -379,84 +308,66 @@
 		sonic_version_printed = 1;
 	}
 	printk(KERN_INFO "%s: onboard / comm-slot SONIC at 0x%08lx\n",
-	       dev->name, dev->base_addr);
-
-	/* Now do a song and dance routine in an attempt to determine
-           the bus width */
+	       lp->device->bus_id, dev->base_addr);
 
 	/* The PowerBook's SONIC is 16 bit always. */
 	if (macintosh_config->ident == MAC_MODEL_PB520) {
-		reg_offset = 0;
-		dma_bitmode = 0;
-	} else if (macintosh_config->ident == MAC_MODEL_C610) {
-		reg_offset = 0;
-		dma_bitmode = 1;
-	} else {
+		lp->reg_offset = 0;
+		lp->dma_bitmode = SONIC_BITMODE16;
+		sr = SONIC_READ(SONIC_SR);
+	} else if (commslot) {
 		/* Some of the comm-slot cards are 16 bit.  But some
-                   of them are not.  The 32-bit cards use offset 2 and
-                   pad with zeroes or sometimes ones (I think...)
-                   Therefore, if we try offset 0 and get a silicon
-                   revision of 0, we assume 16 bit. */
-		int sr;
-
-		/* Technically this is not necessary since we zeroed
-                   it above */
-		reg_offset = 0;
-		dma_bitmode = 0;
-		sr = sonic_read(dev, SONIC_SR);
-		if (sr == 0 || sr == 0xffff) {
-			reg_offset = 2;
-			/* 83932 is 0x0004, 83934 is 0x0100 or 0x0101 */
-			sr = sonic_read(dev, SONIC_SR);
-			dma_bitmode = 1;
-			
+		   of them are not.  The 32-bit cards use offset 2 and
+		   have known revisions, we try reading the revision
+		   register at offset 2, if we don't get a known revision
+		   we assume 16 bit at offset 0.  */
+		lp->reg_offset = 2;
+		lp->dma_bitmode = SONIC_BITMODE16;
+
+		sr = SONIC_READ(SONIC_SR);
+		if (sr == 0x0004 || sr == 0x0006 || sr == 0x0100 || sr == 0x0101) 
+			/* 83932 is 0x0004 or 0x0006, 83934 is 0x0100 or 0x0101 */
+			lp->dma_bitmode = SONIC_BITMODE32;
+		else {
+			lp->dma_bitmode = SONIC_BITMODE16;
+			lp->reg_offset = 0;
+			sr = SONIC_READ(SONIC_SR);
 		}
-		printk(KERN_INFO
-		       "%s: revision 0x%04x, using %d bit DMA and register offset %d\n",
-		       dev->name, sr, dma_bitmode?32:16, reg_offset);
-	}
-	
+	} else {
+		/* All onboard cards are at offset 2 with 32 bit DMA. */
+		lp->reg_offset = 2;
+		lp->dma_bitmode = SONIC_BITMODE32;
+		sr = SONIC_READ(SONIC_SR);
+	}
+	printk(KERN_INFO
+	       "%s: revision 0x%04x, using %d bit DMA and register offset %d\n",
+	       lp->device->bus_id, sr, lp->dma_bitmode?32:16, lp->reg_offset);
+
+#if 0 /* This is sometimes useful to find out how MacOS configured the card. */
+	printk(KERN_INFO "%s: DCR: 0x%04x, DCR2: 0x%04x\n", lp->device->bus_id,
+	       SONIC_READ(SONIC_DCR) & 0xffff, SONIC_READ(SONIC_DCR2) & 0xffff);
+#endif
 
-	/* this carries my sincere apologies -- by the time I got to updating
-	   the driver, support for "reg_offsets" appeares nowhere in the sonic
-	   code, going back for over a year.  Fortunately, my Mac does't seem
-	   to use whatever this was.
-
-	   If you know how this is supposed to be implemented, either fix it,
-	   or contact me (sammy@oh.verio.com) to explain what it is. --Sam */
-	   
-	if(reg_offset) {
-		printk("%s: register offset unsupported.  please fix this if you know what it is.\n", dev->name);
-		return -ENODEV;
-	}
-	
 	/* Software reset, then initialize control registers. */
-	sonic_write(dev, SONIC_CMD, SONIC_CR_RST);
-	sonic_write(dev, SONIC_DCR, SONIC_DCR_BMS |
-		    SONIC_DCR_RFT1 | SONIC_DCR_TFT0 | SONIC_DCR_EXBUS |
-		    (dma_bitmode ? SONIC_DCR_DW : 0));
+	SONIC_WRITE(SONIC_CMD, SONIC_CR_RST);
+
+	SONIC_WRITE(SONIC_DCR, SONIC_DCR_EXBUS | SONIC_DCR_BMS |
+	                       SONIC_DCR_RFT1  | SONIC_DCR_TFT0 |
+	                       (lp->dma_bitmode ? SONIC_DCR_DW : 0));
 
 	/* This *must* be written back to in order to restore the
-           extended programmable output bits */
-	sonic_write(dev, SONIC_DCR2, 0);
+	 * extended programmable output bits, as it may not have been
+	 * initialised since the hardware reset. */
+	SONIC_WRITE(SONIC_DCR2, 0);
 
 	/* Clear *and* disable interrupts to be on the safe side */
-	sonic_write(dev, SONIC_ISR,0x7fff);
-	sonic_write(dev, SONIC_IMR,0);
+	SONIC_WRITE(SONIC_IMR, 0);
+	SONIC_WRITE(SONIC_ISR, 0x7fff);
 
 	/* Now look for the MAC address. */
 	if (mac_onboard_sonic_ethernet_addr(dev) != 0)
 		return -ENODEV;
 
-	printk(KERN_INFO "MAC ");
-	for (i = 0; i < 6; i++) {
-		printk("%2.2x", dev->dev_addr[i]);
-		if (i < 5)
-			printk(":");
-	}
-
-	printk(" IRQ %d\n", dev->irq);
-
 	/* Shared init code */
 	return macsonic_init(dev);
 }
@@ -468,8 +379,10 @@
 	int i;
 	for(i = 0; i < 6; i++)
 		dev->dev_addr[i] = SONIC_READ_PROM(i);
-	/* For now we are going to assume that they're all bit-reversed */
-	bit_reverse_addr(dev->dev_addr);
+
+	/* Some of the addresses are bit-reversed */
+	if (id != MACSONIC_DAYNA)
+		bit_reverse_addr(dev->dev_addr);
 
 	return 0;
 }
@@ -487,6 +400,15 @@
 		else
 			return MACSONIC_APPLE;
 	}
+	
+	if (ndev->dr_hw == NUBUS_DRHW_SMC9194 &&
+	    ndev->dr_sw == NUBUS_DRSW_DAYNA)
+		return MACSONIC_DAYNA;
+	
+	if (ndev->dr_hw == NUBUS_DRHW_SONIC_LC &&
+	    ndev->dr_sw == 0) { /* huh? */
+		return MACSONIC_APPLE16;
+	}
 	return -1;
 }
 
@@ -494,12 +416,12 @@
 {
 	static int slots;
 	struct nubus_dev* ndev = NULL;
+	struct sonic_local* lp = netdev_priv(dev);
 	unsigned long base_addr, prom_addr;
 	u16 sonic_dcr;
-	int id;
-	int i;
-	int dma_bitmode;
-
+	int id = -1;
+	int reg_offset, dma_bitmode;
+	
 	/* Find the first SONIC that hasn't been initialized already */
 	while ((ndev = nubus_find_type(NUBUS_CAT_NETWORK,
 				       NUBUS_TYPE_ETHERNET, ndev)) != NULL)
@@ -521,51 +443,52 @@
 	case MACSONIC_DUODOCK:
 		base_addr = ndev->board->slot_addr + DUODOCK_SONIC_REGISTERS;
 		prom_addr = ndev->board->slot_addr + DUODOCK_SONIC_PROM_BASE;
-		sonic_dcr = SONIC_DCR_EXBUS | SONIC_DCR_RFT0 | SONIC_DCR_RFT1
-			| SONIC_DCR_TFT0;
+		sonic_dcr = SONIC_DCR_EXBUS | SONIC_DCR_RFT0 | SONIC_DCR_RFT1 |
+		            SONIC_DCR_TFT0;
 		reg_offset = 2;
-		dma_bitmode = 1;
+		dma_bitmode = SONIC_BITMODE32;
 		break;
 	case MACSONIC_APPLE:
 		base_addr = ndev->board->slot_addr + APPLE_SONIC_REGISTERS;
 		prom_addr = ndev->board->slot_addr + APPLE_SONIC_PROM_BASE;
 		sonic_dcr = SONIC_DCR_BMS | SONIC_DCR_RFT1 | SONIC_DCR_TFT0;
 		reg_offset = 0;
-		dma_bitmode = 1;
+		dma_bitmode = SONIC_BITMODE32;
 		break;
 	case MACSONIC_APPLE16:
 		base_addr = ndev->board->slot_addr + APPLE_SONIC_REGISTERS;
 		prom_addr = ndev->board->slot_addr + APPLE_SONIC_PROM_BASE;
-		sonic_dcr = SONIC_DCR_EXBUS
- 			| SONIC_DCR_RFT1 | SONIC_DCR_TFT0
-			| SONIC_DCR_PO1 | SONIC_DCR_BMS; 
+		sonic_dcr = SONIC_DCR_EXBUS | SONIC_DCR_RFT1 | SONIC_DCR_TFT0 |
+		            SONIC_DCR_PO1 | SONIC_DCR_BMS; 
 		reg_offset = 0;
-		dma_bitmode = 0;
+		dma_bitmode = SONIC_BITMODE16;
 		break;
 	case MACSONIC_DAYNALINK:
 		base_addr = ndev->board->slot_addr + APPLE_SONIC_REGISTERS;
 		prom_addr = ndev->board->slot_addr + DAYNALINK_PROM_BASE;
-		sonic_dcr = SONIC_DCR_RFT1 | SONIC_DCR_TFT0
-			| SONIC_DCR_PO1 | SONIC_DCR_BMS; 
+		sonic_dcr = SONIC_DCR_RFT1 | SONIC_DCR_TFT0 |
+		            SONIC_DCR_PO1 | SONIC_DCR_BMS; 
 		reg_offset = 0;
-		dma_bitmode = 0;
+		dma_bitmode = SONIC_BITMODE16;
 		break;
 	case MACSONIC_DAYNA:
 		base_addr = ndev->board->slot_addr + DAYNA_SONIC_REGISTERS;
 		prom_addr = ndev->board->slot_addr + DAYNA_SONIC_MAC_ADDR;
-		sonic_dcr = SONIC_DCR_BMS
-			| SONIC_DCR_RFT1 | SONIC_DCR_TFT0 | SONIC_DCR_PO1;
+		sonic_dcr = SONIC_DCR_BMS |
+		            SONIC_DCR_RFT1 | SONIC_DCR_TFT0 | SONIC_DCR_PO1;
 		reg_offset = 0;
-		dma_bitmode = 0;
+		dma_bitmode = SONIC_BITMODE16;
 		break;
 	default:
 		printk(KERN_ERR "macsonic: WTF, id is %d\n", id);
 		return -ENODEV;
 	}
 
-	/* Danger!  My arms are flailing wildly!  You *must* set this
-           before using sonic_read() */
+	/* Danger!  My arms are flailing wildly!  You *must* set lp->reg_offset
+	 * and dev->base_addr before using SONIC_READ() or SONIC_WRITE() */
 	dev->base_addr = base_addr;
+	lp->reg_offset = reg_offset;
+	lp->dma_bitmode = dma_bitmode;
 	dev->irq = SLOT2IRQ(ndev->board->slot);
 
 	if (!sonic_version_printed) {
@@ -573,29 +496,66 @@
 		sonic_version_printed = 1;
 	}
 	printk(KERN_INFO "%s: %s in slot %X\n",
-	       dev->name, ndev->board->name, ndev->board->slot);
+	       lp->device->bus_id, ndev->board->name, ndev->board->slot);
 	printk(KERN_INFO "%s: revision 0x%04x, using %d bit DMA and register offset %d\n",
-	       dev->name, sonic_read(dev, SONIC_SR), dma_bitmode?32:16, reg_offset);
+	       lp->device->bus_id, SONIC_READ(SONIC_SR), dma_bitmode?32:16, reg_offset);
 
-	if(reg_offset) {
-		printk("%s: register offset unsupported.  please fix this if you know what it is.\n", dev->name);
-		return -ENODEV;
-	}
+#if 0 /* This is sometimes useful to find out how MacOS configured the card. */
+	printk(KERN_INFO "%s: DCR: 0x%04x, DCR2: 0x%04x\n", lp->device->bus_id,
+	       SONIC_READ(SONIC_DCR) & 0xffff, SONIC_READ(SONIC_DCR2) & 0xffff);
+#endif
 
 	/* Software reset, then initialize control registers. */
-	sonic_write(dev, SONIC_CMD, SONIC_CR_RST);
-	sonic_write(dev, SONIC_DCR, sonic_dcr
-		    | (dma_bitmode ? SONIC_DCR_DW : 0));
+	SONIC_WRITE(SONIC_CMD, SONIC_CR_RST);
+	SONIC_WRITE(SONIC_DCR, sonic_dcr | (dma_bitmode ? SONIC_DCR_DW : 0));
+	/* This *must* be written back to in order to restore the
+	 * extended programmable output bits, since it may not have been
+	 * initialised since the hardware reset. */
+	SONIC_WRITE(SONIC_DCR2, 0);
 
 	/* Clear *and* disable interrupts to be on the safe side */
-	sonic_write(dev, SONIC_ISR,0x7fff);
-	sonic_write(dev, SONIC_IMR,0);
+	SONIC_WRITE(SONIC_IMR, 0);
+	SONIC_WRITE(SONIC_ISR, 0x7fff);
 
 	/* Now look for the MAC address. */
 	if (mac_nubus_sonic_ethernet_addr(dev, prom_addr, id) != 0)
 		return -ENODEV;
 
-	printk(KERN_INFO "MAC ");
+	/* Shared init code */
+	return macsonic_init(dev);
+}
+
+static int __init mac_sonic_probe(struct device *device)
+{
+	struct net_device *dev;
+	struct sonic_local *lp;
+	int err;
+	int i;
+
+	dev = alloc_etherdev(sizeof(struct sonic_local));
+	if (!dev)
+		return -ENOMEM;
+
+	lp = netdev_priv(dev);
+	lp->device = device;
+	SET_NETDEV_DEV(dev, device);
+ 	SET_MODULE_OWNER(dev);
+
+	/* This will catch fatal stuff like -ENOMEM as well as success */
+	err = mac_onboard_sonic_probe(dev);
+	if (err == 0)
+		goto found;
+	if (err != -ENODEV)
+		goto out;
+	err = mac_nubus_sonic_probe(dev);
+	if (err)
+		goto out;
+found:
+	err = register_netdev(dev);
+	if (err)
+		goto out;
+
+	printk("%s: MAC ", dev->name);
 	for (i = 0; i < 6; i++) {
 		printk("%2.2x", dev->dev_addr[i]);
 		if (i < 5)
@@ -603,55 +563,95 @@
 	}
 	printk(" IRQ %d\n", dev->irq);
 
-	/* Shared init code */
-	return macsonic_init(dev);
-}
+	return 0;
 
-#ifdef MODULE
-static struct net_device *dev_macsonic;
+out:
+	free_netdev(dev);
+
+	return err;
+}
 
-MODULE_PARM(sonic_debug, "i");
+MODULE_DESCRIPTION("Macintosh SONIC ethernet driver");
+module_param(sonic_debug, int, 0);
 MODULE_PARM_DESC(sonic_debug, "macsonic debug level (1-4)");
 
-int
-init_module(void)
+#define SONIC_IRQ_FLAG IRQ_FLG_FAST
+
+#include "sonic.c"
+
+static int __devexit mac_sonic_device_remove (struct device *device)
 {
-        dev_macsonic = macsonic_probe(-1);
-	if (IS_ERR(dev_macsonic)) {
-                printk(KERN_WARNING "macsonic.c: No card found\n");
-		return PTR_ERR(dev_macsonic);
-	}
+	struct net_device *dev = device->driver_data;
+	struct sonic_local* lp = netdev_priv(dev);
+
+	unregister_netdev (dev);
+	dma_free_coherent(lp->device, SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
+	                  lp->descriptors, lp->descriptors_laddr);
+	free_netdev (dev);
+
 	return 0;
 }
 
-void
-cleanup_module(void)
+static struct device_driver mac_sonic_driver = {
+	.name   = mac_sonic_string,
+	.bus    = &platform_bus_type,
+	.probe  = mac_sonic_probe,
+	.remove = __devexit_p(mac_sonic_device_remove),
+};
+
+static void mac_sonic_platform_release(struct device *device)
 {
-	unregister_netdev(dev_macsonic);
-	kfree(dev_macsonic->priv);
-	free_netdev(dev_macsonic);
+	struct platform_device *pldev;
+
+	/* free device */
+	pldev = to_platform_device (device);
+	kfree (pldev);
 }
-#endif /* MODULE */
 
+static int __init mac_sonic_init_module(void)
+{
+	struct platform_device *pldev;
+	int err;
+
+	if ((err = driver_register(&mac_sonic_driver))) {
+		printk(KERN_ERR "Driver registration failed\n");
+		return err;
+	}
 
-#define vdma_alloc(foo, bar) ((u32)foo)
-#define vdma_free(baz)
-#define sonic_chiptomem(bat) (bat)
-#define PHYSADDR(quux) (quux)
-#define CPHYSADDR(quux) (quux)
+	mac_sonic_device = NULL;
 
-#define sonic_request_irq       request_irq
-#define sonic_free_irq          free_irq
+	if (!(pldev = kmalloc (sizeof (*pldev), GFP_KERNEL))) {
+		goto out_unregister;
+	}
 
-#include "sonic.c"
+	memset(pldev, 0, sizeof (*pldev));
+	pldev->name		= mac_sonic_string;
+	pldev->id		= 0;
+	pldev->dev.release	= mac_sonic_platform_release;
+	mac_sonic_device	= pldev;
 
-/*
- * Local variables:
- *  compile-command: "m68k-linux-gcc -D__KERNEL__ -I../../include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -pipe -fno-strength-reduce -ffixed-a2 -DMODULE -DMODVERSIONS -include ../../include/linux/modversions.h   -c -o macsonic.o macsonic.c"
- *  version-control: t
- *  kept-new-versions: 5
- *  c-indent-level: 8
- *  tab-width: 8
- * End:
- *
- */
+	if (platform_device_register (pldev)) {
+		kfree(pldev);
+		mac_sonic_device = NULL;
+	}
+
+	return 0;
+
+out_unregister:
+	platform_device_unregister(pldev);
+
+	return -ENOMEM;
+}
+
+static void __exit mac_sonic_cleanup_module(void)
+{
+	driver_unregister(&mac_sonic_driver);
+
+	if (mac_sonic_device) {
+		platform_device_unregister(mac_sonic_device);
+		mac_sonic_device = NULL;
+	}
+}
+
+module_init(mac_sonic_init_module);
+module_exit(mac_sonic_cleanup_module);
--- orig/drivers/net/sonic.c	Sun Jul 10 22:11:34 2005
+++ linux/drivers/net/sonic.c	Sun Jul 10 22:26:14 2005
@@ -1,6 +1,11 @@
 /*
  * sonic.c
  *
+ * (C) 2005 Finn Thain
+ *
+ * Converted to DMA API, added zero-copy buffer handling, and
+ * (from the mac68k project) introduced dhd's support for 16-bit cards.
+ *
  * (C) 1996,1998 by Thomas Bogendoerfer (tsbogend@alpha.franken.de)
  * 
  * This driver is based on work from Andreas Busse, but most of
@@ -9,12 +14,23 @@
  * (C) 1995 by Andreas Busse (andy@waldorf-gmbh.de)
  *
  *    Core code included by system sonic drivers
+ *
+ * And... partially rewritten again by David Huggins-Daines in order
+ * to cope with screwed up Macintosh NICs that may or may not use
+ * 16-bit DMA.
+ *
+ * (C) 1999 David Huggins-Daines <dhd@debian.org>
+ *
  */
 
 /*
  * Sources: Olivetti M700-10 Risc Personal Computer hardware handbook,
  * National Semiconductors data sheet for the DP83932B Sonic Ethernet
  * controller, and the files "8390.c" and "skeleton.c" in this directory.
+ *
+ * Additional sources: Nat Semi data sheet for the DP83932C and Nat Semi
+ * Application Note AN-746, the files "lance.c" and "ibmlana.c". See also
+ * the NetBSD file "sys/arch/mac68k/dev/if_sn.c".
  */
 
 
@@ -28,6 +44,9 @@
  */
 static int sonic_open(struct net_device *dev)
 {
+	struct sonic_local *lp = netdev_priv(dev);
+	int i;
+	
 	if (sonic_debug > 2)
 		printk("sonic_open: initializing sonic driver.\n");
 
@@ -40,14 +59,59 @@
  * This means that during execution of the handler interrupt are disabled
  * covering another bug otherwise corrupting data.  This doesn't mean
  * this glue works ok under all situations.
+ *
+ * Note (dhd): this also appears to prevent lockups on the Macintrash
+ * when more than one Ethernet card is installed (knock on wood)
+ *
+ * Note (fthain): whether the above is still true is anyones guess. Certainly
+ * the buffer handling algorithms will not tolerate re-entrance without some
+ * mutual exclusion added. Anyway, the memcpy has now been eliminated from the
+ * rx code to make this a faster "fast interrupt".
  */
-//    if (sonic_request_irq(dev->irq, &sonic_interrupt, 0, "sonic", dev)) {
-	if (sonic_request_irq(dev->irq, &sonic_interrupt, SA_INTERRUPT,
-	                      "sonic", dev)) {
-		printk("\n%s: unable to get IRQ %d .\n", dev->name, dev->irq);
+	if (request_irq(dev->irq, &sonic_interrupt, SONIC_IRQ_FLAG, "sonic", dev)) {
+		printk(KERN_ERR "\n%s: unable to get IRQ %d .\n", dev->name, dev->irq);
 		return -EAGAIN;
 	}
 
+	for (i = 0; i < SONIC_NUM_RRS; i++) {
+		struct sk_buff *skb = dev_alloc_skb(SONIC_RBSIZE + 2);
+		if (skb == NULL) {
+			while(i > 0) { /* free any that were allocated successfully */
+				i--;
+				dev_kfree_skb(lp->rx_skb[i]);
+				lp->rx_skb[i] = NULL;
+			}
+			printk(KERN_ERR "%s: couldn't allocate receive buffers\n",
+			       dev->name);
+			return -ENOMEM;
+		}
+		skb->dev = dev;
+		/* align IP header unless DMA requires otherwise */
+		if (SONIC_BUS_SCALE(lp->dma_bitmode) == 2)
+			skb_reserve(skb, 2);
+		lp->rx_skb[i] = skb;
+	}
+
+	for (i = 0; i < SONIC_NUM_RRS; i++) {
+		dma_addr_t laddr = dma_map_single(lp->device, skb_put(lp->rx_skb[i], SONIC_RBSIZE),
+		                                  SONIC_RBSIZE, DMA_FROM_DEVICE);
+		if (!laddr) {
+			while(i > 0) { /* free any that were mapped successfully */
+				i--;
+				dma_unmap_single(lp->device, lp->rx_laddr[i], SONIC_RBSIZE, DMA_FROM_DEVICE);
+				lp->rx_laddr[i] = (dma_addr_t)0;
+			}
+			for (i = 0; i < SONIC_NUM_RRS; i++) {
+				dev_kfree_skb(lp->rx_skb[i]);
+				lp->rx_skb[i] = NULL;
+			}
+			printk(KERN_ERR "%s: couldn't map rx DMA buffers\n",
+			       dev->name);
+			return -ENOMEM;
+		}
+		lp->rx_laddr[i] = laddr;
+	}
+
 	/*
 	 * Initialize the SONIC
 	 */
@@ -67,7 +131,8 @@
  */
 static int sonic_close(struct net_device *dev)
 {
-	unsigned int base_addr = dev->base_addr;
+	struct sonic_local *lp = netdev_priv(dev);
+	int i;
 
 	if (sonic_debug > 2)
 		printk("sonic_close\n");
@@ -77,20 +142,56 @@
 	/*
 	 * stop the SONIC, disable interrupts
 	 */
-	SONIC_WRITE(SONIC_ISR, 0x7fff);
 	SONIC_WRITE(SONIC_IMR, 0);
+	SONIC_WRITE(SONIC_ISR, 0x7fff);
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_RST);
 
-	sonic_free_irq(dev->irq, dev);	/* release the IRQ */
+	/* unmap and free skbs that haven't been transmitted */
+	for (i = 0; i < SONIC_NUM_TDS; i++) {
+		if(lp->tx_laddr[i]) {
+			dma_unmap_single(lp->device, lp->tx_laddr[i], lp->tx_len[i], DMA_TO_DEVICE);
+			lp->tx_laddr[i] = (dma_addr_t)0;
+		}
+		if(lp->tx_skb[i]) {
+			dev_kfree_skb(lp->tx_skb[i]);
+			lp->tx_skb[i] = NULL;
+		}
+	}
+
+	/* unmap and free the receive buffers */
+	for (i = 0; i < SONIC_NUM_RRS; i++) {
+		if(lp->rx_laddr[i]) {
+			dma_unmap_single(lp->device, lp->rx_laddr[i], SONIC_RBSIZE, DMA_FROM_DEVICE);
+			lp->rx_laddr[i] = (dma_addr_t)0;
+		}
+		if(lp->rx_skb[i]) {
+			dev_kfree_skb(lp->rx_skb[i]);
+			lp->rx_skb[i] = NULL;
+		}
+	}
+
+	free_irq(dev->irq, dev);	/* release the IRQ */
 
 	return 0;
 }
 
 static void sonic_tx_timeout(struct net_device *dev)
 {
-	struct sonic_local *lp = (struct sonic_local *) dev->priv;
-	printk("%s: transmit timed out.\n", dev->name);
-
+	struct sonic_local *lp = netdev_priv(dev);
+	int i;
+	/* Stop the interrupts for this */
+	SONIC_WRITE(SONIC_IMR, 0);
+	/* We could resend the original skbs. Easier to re-initialise. */
+	for (i = 0; i < SONIC_NUM_TDS; i++) {
+		if(lp->tx_laddr[i]) {
+			dma_unmap_single(lp->device, lp->tx_laddr[i], lp->tx_len[i], DMA_TO_DEVICE);
+			lp->tx_laddr[i] = (dma_addr_t)0;
+		}
+		if(lp->tx_skb[i]) {
+			dev_kfree_skb(lp->tx_skb[i]);
+			lp->tx_skb[i] = NULL;
+		}
+	}
 	/* Try to restart the adaptor. */
 	sonic_init(dev);
 	lp->stats.tx_errors++;
@@ -100,60 +201,92 @@
 
 /*
  * transmit packet
+ *
+ * Appends new TD during transmission thus avoiding any TX interrupts
+ * until we run out of TDs.
+ * This routine interacts closely with the ISR in that it may,
+ *   set tx_skb[i]
+ *   reset the status flags of the new TD
+ *   set and reset EOL flags
+ *   stop the tx queue
+ * The ISR interacts with this routine in various ways. It may,
+ *   reset tx_skb[i]
+ *   test the EOL and status flags of the TDs
+ *   wake the tx queue
+ * Concurrently with all of this, the SONIC is potentially writing to
+ * the status flags of the TDs.
+ * Until some mutual exclusion is added, this code will not work with SMP. However,
+ * MIPS Jazz machines and m68k Macs were all uni-processor machines.
  */
+
 static int sonic_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
-	struct sonic_local *lp = (struct sonic_local *) dev->priv;
-	unsigned int base_addr = dev->base_addr;
-	unsigned int laddr;
-	int entry, length;
-
-	netif_stop_queue(dev);
+	struct sonic_local *lp = netdev_priv(dev);
+	dma_addr_t laddr;
+	int length;
+	int entry = lp->next_tx;
 
 	if (sonic_debug > 2)
 		printk("sonic_send_packet: skb=%p, dev=%p\n", skb, dev);
 
+	length = skb->len;
+	if (length < ETH_ZLEN) {
+		skb = skb_padto(skb, ETH_ZLEN);
+		if (skb == NULL)
+			return 0;
+		length = ETH_ZLEN;
+	}
+
 	/*
 	 * Map the packet data into the logical DMA address space
 	 */
-	if ((laddr = vdma_alloc(CPHYSADDR(skb->data), skb->len)) == ~0UL) {
-		printk("%s: no VDMA entry for transmit available.\n",
-		       dev->name);
+
+	laddr = dma_map_single(lp->device, skb->data, length, DMA_TO_DEVICE);
+	if (!laddr) {
+		printk(KERN_ERR "%s: failed to map tx DMA buffer.\n", dev->name);
 		dev_kfree_skb(skb);
-		netif_start_queue(dev);
 		return 1;
 	}
-	entry = lp->cur_tx & SONIC_TDS_MASK;
-	lp->tx_laddr[entry] = laddr;
-	lp->tx_skb[entry] = skb;
-
-	length = (skb->len < ETH_ZLEN) ? ETH_ZLEN : skb->len;
-	flush_cache_all();
+   
+	sonic_tda_put(dev, entry, SONIC_TD_STATUS, 0);       /* clear status */
+	sonic_tda_put(dev, entry, SONIC_TD_FRAG_COUNT, 1);   /* single fragment */
+	sonic_tda_put(dev, entry, SONIC_TD_PKTSIZE, length); /* length of packet */
+	sonic_tda_put(dev, entry, SONIC_TD_FRAG_PTR_L, laddr & 0xffff);
+	sonic_tda_put(dev, entry, SONIC_TD_FRAG_PTR_H, laddr >> 16);
+	sonic_tda_put(dev, entry, SONIC_TD_FRAG_SIZE, length);
+	sonic_tda_put(dev, entry, SONIC_TD_LINK,
+		sonic_tda_get(dev, entry, SONIC_TD_LINK) | SONIC_EOL);
 
 	/*
-	 * Setup the transmit descriptor and issue the transmit command.
+	 * Must set tx_skb[entry] only after clearing status, and
+	 * before clearing EOL and before stopping queue
 	 */
-	lp->tda[entry].tx_status = 0;	/* clear status */
-	lp->tda[entry].tx_frag_count = 1;	/* single fragment */
-	lp->tda[entry].tx_pktsize = length;	/* length of packet */
-	lp->tda[entry].tx_frag_ptr_l = laddr & 0xffff;
-	lp->tda[entry].tx_frag_ptr_h = laddr >> 16;
-	lp->tda[entry].tx_frag_size = length;
-	lp->cur_tx++;
-	lp->stats.tx_bytes += length;
+	wmb();
+	lp->tx_len[entry] = length;
+	lp->tx_laddr[entry] = laddr;
+	lp->tx_skb[entry] = skb;
+
+	wmb();
+	sonic_tda_put(dev, lp->eol_tx, SONIC_TD_LINK,
+				  sonic_tda_get(dev, lp->eol_tx, SONIC_TD_LINK) & ~SONIC_EOL);
+	lp->eol_tx = entry;
+
+	lp->next_tx = (entry + 1) & SONIC_TDS_MASK;
+	if (lp->tx_skb[lp->next_tx] != NULL) {
+		/* The ring is full, the ISR has yet to process the next TD. */
+		if (sonic_debug > 3)
+			printk("%s: stopping queue\n", dev->name);
+		netif_stop_queue(dev);
+		/* after this packet, wait for ISR to free up some TDAs */
+	} else netif_start_queue(dev);
 
 	if (sonic_debug > 2)
-		printk("sonic_send_packet: issueing Tx command\n");
+		printk("sonic_send_packet: issuing Tx command\n");
 
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_TXP);
 
 	dev->trans_start = jiffies;
 
-	if (lp->cur_tx < lp->dirty_tx + SONIC_NUM_TDS)
-		netif_start_queue(dev);
-	else
-		lp->tx_full = 1;
-
 	return 0;
 }
 
@@ -164,175 +297,199 @@
 static irqreturn_t sonic_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *) dev_id;
-	unsigned int base_addr = dev->base_addr;
-	struct sonic_local *lp;
+	struct sonic_local *lp = netdev_priv(dev);
 	int status;
 
 	if (dev == NULL) {
-		printk("sonic_interrupt: irq %d for unknown device.\n", irq);
+		printk(KERN_ERR "sonic_interrupt: irq %d for unknown device.\n", irq);
 		return IRQ_NONE;
 	}
 
-	lp = (struct sonic_local *) dev->priv;
-
-	status = SONIC_READ(SONIC_ISR);
-	SONIC_WRITE(SONIC_ISR, 0x7fff);	/* clear all bits */
-
-	if (sonic_debug > 2)
-		printk("sonic_interrupt: ISR=%x\n", status);
-
-	if (status & SONIC_INT_PKTRX) {
-		sonic_rx(dev);	/* got packet(s) */
-	}
-
-	if (status & SONIC_INT_TXDN) {
-		int dirty_tx = lp->dirty_tx;
+	if (!(status = SONIC_READ(SONIC_ISR) & SONIC_IMR_DEFAULT))
+		return IRQ_NONE;
 
-		while (dirty_tx < lp->cur_tx) {
-			int entry = dirty_tx & SONIC_TDS_MASK;
-			int status = lp->tda[entry].tx_status;
+	do {
+		if (status & SONIC_INT_PKTRX) {
+			if (sonic_debug > 2)
+				printk("%s: packet rx\n", dev->name);
+			sonic_rx(dev);	/* got packet(s) */
+			SONIC_WRITE(SONIC_ISR, SONIC_INT_PKTRX); /* clear the interrupt */
+		}
 
-			if (sonic_debug > 3)
-				printk
-				    ("sonic_interrupt: status %d, cur_tx %d, dirty_tx %d\n",
-				     status, lp->cur_tx, lp->dirty_tx);
+		if (status & SONIC_INT_TXDN) {
+			int entry = lp->cur_tx;
+			int td_status;
+			int freed_some = 0;
+
+			/* At this point, cur_tx is the index of a TD that is one of:
+			 *   unallocated/freed                          (status set   & tx_skb[entry] clear)
+			 *   allocated and sent                         (status set   & tx_skb[entry] set  )
+			 *   allocated and not yet sent                 (status clear & tx_skb[entry] set  )
+			 *   still being allocated by sonic_send_packet (status clear & tx_skb[entry] clear)
+			 */
 
-			if (status == 0) {
-				/* It still hasn't been Txed, kick the sonic again */
-				SONIC_WRITE(SONIC_CMD, SONIC_CR_TXP);
-				break;
-			}
+			if (sonic_debug > 2)
+				printk("%s: tx done\n", dev->name);
 
-			/* put back EOL and free descriptor */
-			lp->tda[entry].tx_frag_count = 0;
-			lp->tda[entry].tx_status = 0;
-
-			if (status & 0x0001)
-				lp->stats.tx_packets++;
-			else {
-				lp->stats.tx_errors++;
-				if (status & 0x0642)
-					lp->stats.tx_aborted_errors++;
-				if (status & 0x0180)
-					lp->stats.tx_carrier_errors++;
-				if (status & 0x0020)
-					lp->stats.tx_window_errors++;
-				if (status & 0x0004)
-					lp->stats.tx_fifo_errors++;
-			}
+			while (lp->tx_skb[entry] != NULL) {
+				if ((td_status = sonic_tda_get(dev, entry, SONIC_TD_STATUS)) == 0)
+					break;
+
+				if (td_status & 0x0001) {
+					lp->stats.tx_packets++;
+					lp->stats.tx_bytes += sonic_tda_get(dev, entry, SONIC_TD_PKTSIZE);
+				} else {
+					lp->stats.tx_errors++;
+					if (td_status & 0x0642)
+						lp->stats.tx_aborted_errors++;
+					if (td_status & 0x0180)
+						lp->stats.tx_carrier_errors++;
+					if (td_status & 0x0020)
+						lp->stats.tx_window_errors++;
+					if (td_status & 0x0004)
+						lp->stats.tx_fifo_errors++;
+				}
 
-			/* We must free the original skb */
-			if (lp->tx_skb[entry]) {
+				/* We must free the original skb */
 				dev_kfree_skb_irq(lp->tx_skb[entry]);
-				lp->tx_skb[entry] = 0;
+				lp->tx_skb[entry] = NULL;
+				/* and unmap DMA buffer */
+				dma_unmap_single(lp->device, lp->tx_laddr[entry], lp->tx_len[entry], DMA_TO_DEVICE);
+				lp->tx_laddr[entry] = (dma_addr_t)0;
+				freed_some = 1;
+
+				if (sonic_tda_get(dev, entry, SONIC_TD_LINK) & SONIC_EOL) {
+					entry = (entry + 1) & SONIC_TDS_MASK;
+					break;
+				}
+				entry = (entry + 1) & SONIC_TDS_MASK;
 			}
-			/* and the VDMA address */
-			vdma_free(lp->tx_laddr[entry]);
-			dirty_tx++;
-		}
 
-		if (lp->tx_full
-		    && dirty_tx + SONIC_NUM_TDS > lp->cur_tx + 2) {
-			/* The ring is no longer full, clear tbusy. */
-			lp->tx_full = 0;
-			netif_wake_queue(dev);
+			if (freed_some || lp->tx_skb[entry] == NULL)
+				netif_wake_queue(dev);  /* The ring is no longer full */
+			lp->cur_tx = entry;
+			SONIC_WRITE(SONIC_ISR, SONIC_INT_TXDN); /* clear the interrupt */
 		}
 
-		lp->dirty_tx = dirty_tx;
-	}
+		/*
+		 * check error conditions
+		 */
+		if (status & SONIC_INT_RFO) {
+			if (sonic_debug > 1)
+				printk("%s: rx fifo overrun\n", dev->name);
+			lp->stats.rx_fifo_errors++;
+			SONIC_WRITE(SONIC_ISR, SONIC_INT_RFO); /* clear the interrupt */
+		}
+		if (status & SONIC_INT_RDE) {
+			if (sonic_debug > 1)
+				printk("%s: rx descriptors exhausted\n", dev->name);
+			lp->stats.rx_dropped++;
+			SONIC_WRITE(SONIC_ISR, SONIC_INT_RDE); /* clear the interrupt */
+		}
+		if (status & SONIC_INT_RBAE) {
+			if (sonic_debug > 1)
+				printk("%s: rx buffer area exceeded\n", dev->name);
+			lp->stats.rx_dropped++;
+			SONIC_WRITE(SONIC_ISR, SONIC_INT_RBAE); /* clear the interrupt */
+		}
 
-	/*
-	 * check error conditions
-	 */
-	if (status & SONIC_INT_RFO) {
-		printk("%s: receive fifo underrun\n", dev->name);
-		lp->stats.rx_fifo_errors++;
-	}
-	if (status & SONIC_INT_RDE) {
-		printk("%s: receive descriptors exhausted\n", dev->name);
-		lp->stats.rx_dropped++;
-	}
-	if (status & SONIC_INT_RBE) {
-		printk("%s: receive buffer exhausted\n", dev->name);
-		lp->stats.rx_dropped++;
-	}
-	if (status & SONIC_INT_RBAE) {
-		printk("%s: receive buffer area exhausted\n", dev->name);
-		lp->stats.rx_dropped++;
-	}
+		/* counter overruns; all counters are 16bit wide */
+		if (status & SONIC_INT_FAE) {
+			lp->stats.rx_frame_errors += 65536;
+			SONIC_WRITE(SONIC_ISR, SONIC_INT_FAE); /* clear the interrupt */
+		}
+		if (status & SONIC_INT_CRC) {
+			lp->stats.rx_crc_errors += 65536;
+			SONIC_WRITE(SONIC_ISR, SONIC_INT_CRC); /* clear the interrupt */
+		}
+		if (status & SONIC_INT_MP) {
+			lp->stats.rx_missed_errors += 65536;
+			SONIC_WRITE(SONIC_ISR, SONIC_INT_MP); /* clear the interrupt */
+		}
 
-	/* counter overruns; all counters are 16bit wide */
-	if (status & SONIC_INT_FAE)
-		lp->stats.rx_frame_errors += 65536;
-	if (status & SONIC_INT_CRC)
-		lp->stats.rx_crc_errors += 65536;
-	if (status & SONIC_INT_MP)
-		lp->stats.rx_missed_errors += 65536;
+		/* transmit error */
+		if (status & SONIC_INT_TXER) {
+			if ((SONIC_READ(SONIC_TCR) & SONIC_TCR_FU) && (sonic_debug > 2))
+				printk(KERN_ERR "%s: tx fifo underrun\n", dev->name);
+			SONIC_WRITE(SONIC_ISR, SONIC_INT_TXER); /* clear the interrupt */
+		}
 
-	/* transmit error */
-	if (status & SONIC_INT_TXER)
-		lp->stats.tx_errors++;
+		/* bus retry */
+		if (status & SONIC_INT_BR) {
+			printk(KERN_ERR "%s: Bus retry occurred! Device interrupt disabled.\n",
+				dev->name);
+			/* ... to help debug DMA problems causing endless interrupts. */
+			/* Bounce the eth interface to turn on the interrupt again. */
+			SONIC_WRITE(SONIC_IMR, 0);
+			SONIC_WRITE(SONIC_ISR, SONIC_INT_BR); /* clear the interrupt */
+		}
 
-	/*
-	 * clear interrupt bits and return
-	 */
-	SONIC_WRITE(SONIC_ISR, status);
+		/* load CAM done */
+		if (status & SONIC_INT_LCD)
+			SONIC_WRITE(SONIC_ISR, SONIC_INT_LCD); /* clear the interrupt */
+	} while((status = SONIC_READ(SONIC_ISR) & SONIC_IMR_DEFAULT));
 	return IRQ_HANDLED;
 }
 
 /*
- * We have a good packet(s), get it/them out of the buffers.
+ * We have a good packet(s), pass it/them up the network stack.
  */
 static void sonic_rx(struct net_device *dev)
 {
-	unsigned int base_addr = dev->base_addr;
-	struct sonic_local *lp = (struct sonic_local *) dev->priv;
-	sonic_rd_t *rd = &lp->rda[lp->cur_rx & SONIC_RDS_MASK];
+	struct sonic_local *lp = netdev_priv(dev);
 	int status;
+	int entry = lp->cur_rx;
 
-	while (rd->in_use == 0) {
-		struct sk_buff *skb;
+	while (sonic_rda_get(dev, entry, SONIC_RD_IN_USE) == 0) {
+		struct sk_buff *used_skb;
+		struct sk_buff *new_skb;
+		dma_addr_t new_laddr;
+		u16 bufadr_l;
+		u16 bufadr_h;
 		int pkt_len;
-		unsigned char *pkt_ptr;
 
-		status = rd->rx_status;
-		if (sonic_debug > 3)
-			printk("status %x, cur_rx %d, cur_rra %x\n",
-			       status, lp->cur_rx, lp->cur_rra);
+		status = sonic_rda_get(dev, entry, SONIC_RD_STATUS);
 		if (status & SONIC_RCR_PRX) {
-			pkt_len = rd->rx_pktlen;
-			pkt_ptr =
-			    (char *)
-			    sonic_chiptomem((rd->rx_pktptr_h << 16) +
-					    rd->rx_pktptr_l);
-
-			if (sonic_debug > 3)
-				printk
-				    ("pktptr %p (rba %p) h:%x l:%x, bsize h:%x l:%x\n",
-				     pkt_ptr, lp->rba, rd->rx_pktptr_h,
-				     rd->rx_pktptr_l,
-				     SONIC_READ(SONIC_RBWC1),
-				     SONIC_READ(SONIC_RBWC0));
-
 			/* Malloc up new buffer. */
-			skb = dev_alloc_skb(pkt_len + 2);
-			if (skb == NULL) {
-				printk
-				    ("%s: Memory squeeze, dropping packet.\n",
-				     dev->name);
+			new_skb = dev_alloc_skb(SONIC_RBSIZE + 2);
+			if (new_skb == NULL) {
+				printk(KERN_ERR "%s: Memory squeeze, dropping packet.\n", dev->name);
 				lp->stats.rx_dropped++;
 				break;
 			}
-			skb->dev = dev;
-			skb_reserve(skb, 2);	/* 16 byte align */
-			skb_put(skb, pkt_len);	/* Make room */
-			eth_copy_and_sum(skb, pkt_ptr, pkt_len, 0);
-			skb->protocol = eth_type_trans(skb, dev);
-			netif_rx(skb);	/* pass the packet to upper layers */
+			new_skb->dev = dev;
+			/* provide 16 byte IP header alignment unless DMA requires otherwise */
+			if(SONIC_BUS_SCALE(lp->dma_bitmode) == 2)
+				skb_reserve(new_skb, 2); 
+
+			new_laddr = dma_map_single(lp->device, skb_put(new_skb, SONIC_RBSIZE),
+		                               SONIC_RBSIZE, DMA_FROM_DEVICE);
+			if (!new_laddr) {
+				dev_kfree_skb(new_skb);
+				printk(KERN_ERR "%s: Failed to map rx buffer, dropping packet.\n", dev->name);
+				lp->stats.rx_dropped++;
+				break;
+			}
+
+			/* now we have a new skb to replace it, pass the used one up the stack */
+			dma_unmap_single(lp->device, lp->rx_laddr[entry], SONIC_RBSIZE, DMA_FROM_DEVICE);
+			used_skb = lp->rx_skb[entry];
+			pkt_len = sonic_rda_get(dev, entry, SONIC_RD_PKTLEN);
+			skb_trim(used_skb, pkt_len);
+			used_skb->protocol = eth_type_trans(used_skb, dev);
+			netif_rx(used_skb);
 			dev->last_rx = jiffies;
 			lp->stats.rx_packets++;
 			lp->stats.rx_bytes += pkt_len;
 
+			/* and insert the new skb */
+			lp->rx_laddr[entry] = new_laddr;
+			lp->rx_skb[entry] = new_skb;
+
+			bufadr_l = (unsigned long)new_laddr & 0xffff;
+			bufadr_h = (unsigned long)new_laddr >> 16;
+			sonic_rra_put(dev, entry, SONIC_RR_BUFADR_L, bufadr_l);
+			sonic_rra_put(dev, entry, SONIC_RR_BUFADR_H, bufadr_h);
 		} else {
 			/* This should only happen, if we enable accepting broken packets. */
 			lp->stats.rx_errors++;
@@ -341,29 +498,35 @@
 			if (status & SONIC_RCR_CRCR)
 				lp->stats.rx_crc_errors++;
 		}
-
-		rd->in_use = 1;
-		rd = &lp->rda[(++lp->cur_rx) & SONIC_RDS_MASK];
-		/* now give back the buffer to the receive buffer area */
 		if (status & SONIC_RCR_LPKT) {
 			/*
-			 * this was the last packet out of the current receice buffer
+			 * this was the last packet out of the current receive buffer
 			 * give the buffer back to the SONIC
 			 */
-			lp->cur_rra += sizeof(sonic_rr_t);
-			if (lp->cur_rra >
-			    (lp->rra_laddr +
-			     (SONIC_NUM_RRS -
-			      1) * sizeof(sonic_rr_t))) lp->cur_rra =
-				    lp->rra_laddr;
-			SONIC_WRITE(SONIC_RWP, lp->cur_rra & 0xffff);
+			lp->cur_rwp += SIZEOF_SONIC_RR * SONIC_BUS_SCALE(lp->dma_bitmode);
+			if (lp->cur_rwp >= lp->rra_end) lp->cur_rwp = lp->rra_laddr & 0xffff;
+			SONIC_WRITE(SONIC_RWP, lp->cur_rwp);
+			if (SONIC_READ(SONIC_ISR) & SONIC_INT_RBE) {
+				if (sonic_debug > 2)
+					printk("%s: rx buffer exhausted\n", dev->name);
+				SONIC_WRITE(SONIC_ISR, SONIC_INT_RBE); /* clear the flag */
+			}
 		} else
-			printk
-			    ("%s: rx desc without RCR_LPKT. Shouldn't happen !?\n",
+			printk(KERN_ERR "%s: rx desc without RCR_LPKT. Shouldn't happen !?\n",
 			     dev->name);
+		/*
+		 * give back the descriptor
+		 */
+		sonic_rda_put(dev, entry, SONIC_RD_LINK,
+			sonic_rda_get(dev, entry, SONIC_RD_LINK) | SONIC_EOL);
+		sonic_rda_put(dev, entry, SONIC_RD_IN_USE, 1);
+		sonic_rda_put(dev, lp->eol_rx, SONIC_RD_LINK,
+			sonic_rda_get(dev, lp->eol_rx, SONIC_RD_LINK) & ~SONIC_EOL);
+		lp->eol_rx = entry;
+		lp->cur_rx = entry = (entry + 1) & SONIC_RDS_MASK;
 	}
 	/*
-	 * If any worth-while packets have been received, dev_rint()
+	 * If any worth-while packets have been received, netif_rx()
 	 * has done a mark_bh(NET_BH) for us and will work on them
 	 * when we get to the bottom-half routine.
 	 */
@@ -376,8 +539,7 @@
  */
 static struct net_device_stats *sonic_get_stats(struct net_device *dev)
 {
-	struct sonic_local *lp = (struct sonic_local *) dev->priv;
-	unsigned int base_addr = dev->base_addr;
+	struct sonic_local *lp = netdev_priv(dev);
 
 	/* read the tally counter from the SONIC and reset them */
 	lp->stats.rx_crc_errors += SONIC_READ(SONIC_CRCT);
@@ -396,8 +558,7 @@
  */
 static void sonic_multicast_list(struct net_device *dev)
 {
-	struct sonic_local *lp = (struct sonic_local *) dev->priv;
-	unsigned int base_addr = dev->base_addr;
+	struct sonic_local *lp = netdev_priv(dev);
 	unsigned int rcr;
 	struct dev_mc_list *dmi = dev->mc_list;
 	unsigned char *addr;
@@ -413,20 +574,15 @@
 			rcr |= SONIC_RCR_AMC;
 		} else {
 			if (sonic_debug > 2)
-				printk
-				    ("sonic_multicast_list: mc_count %d\n",
-				     dev->mc_count);
-			lp->cda.cam_enable = 1;	/* always enable our own address */
+				printk("sonic_multicast_list: mc_count %d\n", dev->mc_count);
+			sonic_set_cam_enable(dev, 1);  /* always enable our own address */
 			for (i = 1; i <= dev->mc_count; i++) {
 				addr = dmi->dmi_addr;
 				dmi = dmi->next;
-				lp->cda.cam_desc[i].cam_cap0 =
-				    addr[1] << 8 | addr[0];
-				lp->cda.cam_desc[i].cam_cap1 =
-				    addr[3] << 8 | addr[2];
-				lp->cda.cam_desc[i].cam_cap2 =
-				    addr[5] << 8 | addr[4];
-				lp->cda.cam_enable |= (1 << i);
+				sonic_cda_put(dev, i, SONIC_CD_CAP0, addr[1] << 8 | addr[0]);
+				sonic_cda_put(dev, i, SONIC_CD_CAP1, addr[3] << 8 | addr[2]);
+				sonic_cda_put(dev, i, SONIC_CD_CAP2, addr[5] << 8 | addr[4]);
+				sonic_set_cam_enable(dev, sonic_get_cam_enable(dev) | (1 << i));
 			}
 			SONIC_WRITE(SONIC_CDC, 16);
 			/* issue Load CAM command */
@@ -447,19 +603,16 @@
  */
 static int sonic_init(struct net_device *dev)
 {
-	unsigned int base_addr = dev->base_addr;
 	unsigned int cmd;
-	struct sonic_local *lp = (struct sonic_local *) dev->priv;
-	unsigned int rra_start;
-	unsigned int rra_end;
+	struct sonic_local *lp = netdev_priv(dev);
 	int i;
 
 	/*
 	 * put the Sonic into software-reset mode and
 	 * disable all interrupts
 	 */
-	SONIC_WRITE(SONIC_ISR, 0x7fff);
 	SONIC_WRITE(SONIC_IMR, 0);
+	SONIC_WRITE(SONIC_ISR, 0x7fff);
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_RST);
 
 	/*
@@ -475,34 +628,32 @@
 	if (sonic_debug > 2)
 		printk("sonic_init: initialize receive resource area\n");
 
-	rra_start = lp->rra_laddr & 0xffff;
-	rra_end =
-	    (rra_start + (SONIC_NUM_RRS * sizeof(sonic_rr_t))) & 0xffff;
-
 	for (i = 0; i < SONIC_NUM_RRS; i++) {
-		lp->rra[i].rx_bufadr_l =
-		    (lp->rba_laddr + i * SONIC_RBSIZE) & 0xffff;
-		lp->rra[i].rx_bufadr_h =
-		    (lp->rba_laddr + i * SONIC_RBSIZE) >> 16;
-		lp->rra[i].rx_bufsize_l = SONIC_RBSIZE >> 1;
-		lp->rra[i].rx_bufsize_h = 0;
+		u16 bufadr_l = (unsigned long)lp->rx_laddr[i] & 0xffff;
+		u16 bufadr_h = (unsigned long)lp->rx_laddr[i] >> 16;
+		sonic_rra_put(dev, i, SONIC_RR_BUFADR_L, bufadr_l);
+		sonic_rra_put(dev, i, SONIC_RR_BUFADR_H, bufadr_h);
+		sonic_rra_put(dev, i, SONIC_RR_BUFSIZE_L, SONIC_RBSIZE >> 1);
+		sonic_rra_put(dev, i, SONIC_RR_BUFSIZE_H, 0);
 	}
 
 	/* initialize all RRA registers */
-	SONIC_WRITE(SONIC_RSA, rra_start);
-	SONIC_WRITE(SONIC_REA, rra_end);
-	SONIC_WRITE(SONIC_RRP, rra_start);
-	SONIC_WRITE(SONIC_RWP, rra_end);
+	lp->rra_end = (lp->rra_laddr + SONIC_NUM_RRS * SIZEOF_SONIC_RR *
+					SONIC_BUS_SCALE(lp->dma_bitmode)) & 0xffff;
+	lp->cur_rwp = (lp->rra_laddr + (SONIC_NUM_RRS - 1) * SIZEOF_SONIC_RR *
+					SONIC_BUS_SCALE(lp->dma_bitmode)) & 0xffff;
+  
+	SONIC_WRITE(SONIC_RSA, lp->rra_laddr & 0xffff);
+	SONIC_WRITE(SONIC_REA, lp->rra_end);
+	SONIC_WRITE(SONIC_RRP, lp->rra_laddr & 0xffff);
+	SONIC_WRITE(SONIC_RWP, lp->cur_rwp);
 	SONIC_WRITE(SONIC_URRA, lp->rra_laddr >> 16);
-	SONIC_WRITE(SONIC_EOBC, (SONIC_RBSIZE - 2) >> 1);
-
-	lp->cur_rra =
-	    lp->rra_laddr + (SONIC_NUM_RRS - 1) * sizeof(sonic_rr_t);
+	SONIC_WRITE(SONIC_EOBC, (SONIC_RBSIZE >> 1) - (lp->dma_bitmode ? 2 : 1));
 
 	/* load the resource pointers */
 	if (sonic_debug > 3)
-		printk("sonic_init: issueing RRRA command\n");
-
+		printk("sonic_init: issuing RRRA command\n");
+  
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_RRRA);
 	i = 0;
 	while (i++ < 100) {
@@ -511,27 +662,30 @@
 	}
 
 	if (sonic_debug > 2)
-		printk("sonic_init: status=%x\n", SONIC_READ(SONIC_CMD));
-
+		printk("sonic_init: status=%x i=%d\n", SONIC_READ(SONIC_CMD), i);
+    
 	/*
 	 * Initialize the receive descriptors so that they
 	 * become a circular linked list, ie. let the last
 	 * descriptor point to the first again.
 	 */
 	if (sonic_debug > 2)
-		printk("sonic_init: initialize receive descriptors\n");
-	for (i = 0; i < SONIC_NUM_RDS; i++) {
-		lp->rda[i].rx_status = 0;
-		lp->rda[i].rx_pktlen = 0;
-		lp->rda[i].rx_pktptr_l = 0;
-		lp->rda[i].rx_pktptr_h = 0;
-		lp->rda[i].rx_seqno = 0;
-		lp->rda[i].in_use = 1;
-		lp->rda[i].link =
-		    lp->rda_laddr + (i + 1) * sizeof(sonic_rd_t);
+		printk("sonic_init: initialize receive descriptors\n");      
+	for (i=0; i<SONIC_NUM_RDS; i++) {
+		sonic_rda_put(dev, i, SONIC_RD_STATUS, 0);
+		sonic_rda_put(dev, i, SONIC_RD_PKTLEN, 0);
+		sonic_rda_put(dev, i, SONIC_RD_PKTPTR_L, 0);
+		sonic_rda_put(dev, i, SONIC_RD_PKTPTR_H, 0);
+		sonic_rda_put(dev, i, SONIC_RD_SEQNO, 0);
+		sonic_rda_put(dev, i, SONIC_RD_IN_USE, 1);
+		sonic_rda_put(dev, i, SONIC_RD_LINK,
+			lp->rda_laddr +
+			((i+1) * SIZEOF_SONIC_RD * SONIC_BUS_SCALE(lp->dma_bitmode)));
 	}
 	/* fix last descriptor */
-	lp->rda[SONIC_NUM_RDS - 1].link = lp->rda_laddr;
+	sonic_rda_put(dev, SONIC_NUM_RDS - 1, SONIC_RD_LINK,
+		(lp->rda_laddr & 0xffff) | SONIC_EOL);
+	lp->eol_rx = SONIC_NUM_RDS - 1;
 	lp->cur_rx = 0;
 	SONIC_WRITE(SONIC_URDA, lp->rda_laddr >> 16);
 	SONIC_WRITE(SONIC_CRDA, lp->rda_laddr & 0xffff);
@@ -542,34 +696,34 @@
 	if (sonic_debug > 2)
 		printk("sonic_init: initialize transmit descriptors\n");
 	for (i = 0; i < SONIC_NUM_TDS; i++) {
-		lp->tda[i].tx_status = 0;
-		lp->tda[i].tx_config = 0;
-		lp->tda[i].tx_pktsize = 0;
-		lp->tda[i].tx_frag_count = 0;
-		lp->tda[i].link =
-		    (lp->tda_laddr +
-		     (i + 1) * sizeof(sonic_td_t)) | SONIC_END_OF_LINKS;
+		sonic_tda_put(dev, i, SONIC_TD_STATUS, 0);
+		sonic_tda_put(dev, i, SONIC_TD_CONFIG, 0);
+		sonic_tda_put(dev, i, SONIC_TD_PKTSIZE, 0);
+		sonic_tda_put(dev, i, SONIC_TD_FRAG_COUNT, 0);
+		sonic_tda_put(dev, i, SONIC_TD_LINK,
+			(lp->tda_laddr & 0xffff) +
+			(i + 1) * SIZEOF_SONIC_TD * SONIC_BUS_SCALE(lp->dma_bitmode));
+		lp->tx_skb[i] = NULL;
 	}
-	lp->tda[SONIC_NUM_TDS - 1].link =
-	    (lp->tda_laddr & 0xffff) | SONIC_END_OF_LINKS;
+	/* fix last descriptor */
+	sonic_tda_put(dev, SONIC_NUM_TDS - 1, SONIC_TD_LINK,
+		(lp->tda_laddr & 0xffff));
 
 	SONIC_WRITE(SONIC_UTDA, lp->tda_laddr >> 16);
 	SONIC_WRITE(SONIC_CTDA, lp->tda_laddr & 0xffff);
-	lp->cur_tx = lp->dirty_tx = 0;
-
+	lp->cur_tx = lp->next_tx = 0;
+	lp->eol_tx = SONIC_NUM_TDS - 1;
+    
 	/*
 	 * put our own address to CAM desc[0]
 	 */
-	lp->cda.cam_desc[0].cam_cap0 =
-	    dev->dev_addr[1] << 8 | dev->dev_addr[0];
-	lp->cda.cam_desc[0].cam_cap1 =
-	    dev->dev_addr[3] << 8 | dev->dev_addr[2];
-	lp->cda.cam_desc[0].cam_cap2 =
-	    dev->dev_addr[5] << 8 | dev->dev_addr[4];
-	lp->cda.cam_enable = 1;
+	sonic_cda_put(dev, 0, SONIC_CD_CAP0, dev->dev_addr[1] << 8 | dev->dev_addr[0]);
+	sonic_cda_put(dev, 0, SONIC_CD_CAP1, dev->dev_addr[3] << 8 | dev->dev_addr[2]);
+	sonic_cda_put(dev, 0, SONIC_CD_CAP2, dev->dev_addr[5] << 8 | dev->dev_addr[4]);
+	sonic_set_cam_enable(dev, 1);
 
 	for (i = 0; i < 16; i++)
-		lp->cda.cam_desc[i].cam_entry_pointer = i;
+		sonic_cda_put(dev, i, SONIC_CD_ENTRY_POINTER, i);
 
 	/*
 	 * initialize CAM registers
@@ -588,8 +742,8 @@
 			break;
 	}
 	if (sonic_debug > 2) {
-		printk("sonic_init: CMD=%x, ISR=%x\n",
-		       SONIC_READ(SONIC_CMD), SONIC_READ(SONIC_ISR));
+		printk("sonic_init: CMD=%x, ISR=%x\n, i=%d",
+		       SONIC_READ(SONIC_CMD), SONIC_READ(SONIC_ISR), i);
 	}
 
 	/*
@@ -604,7 +758,7 @@
 
 	cmd = SONIC_READ(SONIC_CMD);
 	if ((cmd & SONIC_CR_RXEN) == 0 || (cmd & SONIC_CR_STP) == 0)
-		printk("sonic_init: failed, status=%x\n", cmd);
+		printk(KERN_ERR "sonic_init: failed, status=%x\n", cmd);
 
 	if (sonic_debug > 2)
 		printk("sonic_init: new status=%x\n",
--- orig/drivers/net/sonic.h	Sun Jul 10 22:11:34 2005
+++ linux/drivers/net/sonic.h	Sun Jul 10 22:11:46 2005
@@ -1,5 +1,5 @@
 /*
- * Helpfile for sonic.c
+ * Header file for sonic.c
  *
  * (C) Waldorf Electronics, Germany
  * Written by Andreas Busse
@@ -9,10 +9,16 @@
  * and pad structure members must be exchanged. Also, the structures
  * need to be changed accordingly to the bus size. 
  *
- * 981229 MSch:	did just that for the 68k Mac port (32 bit, big endian),
- *		see CONFIG_MACSONIC branch below.
+ * 981229 MSch:	did just that for the 68k Mac port (32 bit, big endian)
  *
+ * 990611 David Huggins-Daines <dhd@debian.org>: This machine abstraction
+ * does not cope with 16-bit bus sizes very well.  Therefore I have
+ * rewritten it with ugly macros and evil inlines.
+ *
+ * 050625 Finn Thain: introduced more 32-bit cards and dhd's support
+ *        for 16-bit cards (from the mac68k project).
  */
+
 #ifndef SONIC_H
 #define SONIC_H
 
@@ -83,6 +89,7 @@
 /*
  * Error counters
  */
+
 #define SONIC_CRCT              0x2c
 #define SONIC_FAET              0x2d
 #define SONIC_MPT               0x2e
@@ -182,14 +189,14 @@
 
 #define SONIC_INT_BR		0x4000
 #define SONIC_INT_HBL		0x2000
-#define SONIC_INT_LCD           0x1000
-#define SONIC_INT_PINT          0x0800
-#define SONIC_INT_PKTRX         0x0400
-#define SONIC_INT_TXDN          0x0200
-#define SONIC_INT_TXER          0x0100
-#define SONIC_INT_TC            0x0080
-#define SONIC_INT_RDE           0x0040
-#define SONIC_INT_RBE           0x0020
+#define SONIC_INT_LCD		0x1000
+#define SONIC_INT_PINT		0x0800
+#define SONIC_INT_PKTRX		0x0400
+#define SONIC_INT_TXDN		0x0200
+#define SONIC_INT_TXER		0x0100
+#define SONIC_INT_TC		0x0080
+#define SONIC_INT_RDE		0x0040
+#define SONIC_INT_RBE		0x0020
 #define SONIC_INT_RBAE		0x0010
 #define SONIC_INT_CRC		0x0008
 #define SONIC_INT_FAE		0x0004
@@ -201,224 +208,61 @@
  * The interrupts we allow.
  */
 
-#define SONIC_IMR_DEFAULT	(SONIC_INT_BR | \
-				SONIC_INT_LCD | \
-                                SONIC_INT_PINT | \
+#define SONIC_IMR_DEFAULT     ( SONIC_INT_BR | \
+                                SONIC_INT_LCD | \
+                                SONIC_INT_RFO | \
                                 SONIC_INT_PKTRX | \
                                 SONIC_INT_TXDN | \
                                 SONIC_INT_TXER | \
                                 SONIC_INT_RDE | \
-                                SONIC_INT_RBE | \
                                 SONIC_INT_RBAE | \
                                 SONIC_INT_CRC | \
                                 SONIC_INT_FAE | \
                                 SONIC_INT_MP)
 
 
-#define	SONIC_END_OF_LINKS	0x0001
-
-
-#ifdef CONFIG_MACSONIC
-/*
- * Big endian like structures on 680x0 Macs
- */
-
-typedef struct {
-	u32 rx_bufadr_l;	/* receive buffer ptr */
-	u32 rx_bufadr_h;
-
-	u32 rx_bufsize_l;	/* no. of words in the receive buffer */
-	u32 rx_bufsize_h;
-} sonic_rr_t;
-
-/*
- * Sonic receive descriptor. Receive descriptors are
- * kept in a linked list of these structures.
- */
-
-typedef struct {
-	SREGS_PAD(pad0);
-	u16 rx_status;		/* status after reception of a packet */
-	 SREGS_PAD(pad1);
-	u16 rx_pktlen;		/* length of the packet incl. CRC */
-
-	/*
-	 * Pointers to the location in the receive buffer area (RBA)
-	 * where the packet resides. A packet is always received into
-	 * a contiguous piece of memory.
-	 */
-	 SREGS_PAD(pad2);
-	u16 rx_pktptr_l;
-	 SREGS_PAD(pad3);
-	u16 rx_pktptr_h;
-
-	 SREGS_PAD(pad4);
-	u16 rx_seqno;		/* sequence no. */
-
-	 SREGS_PAD(pad5);
-	u16 link;		/* link to next RDD (end if EOL bit set) */
-
-	/*
-	 * Owner of this descriptor, 0= driver, 1=sonic
-	 */
-
-	 SREGS_PAD(pad6);
-	u16 in_use;
-
-	caddr_t rda_next;	/* pointer to next RD */
-} sonic_rd_t;
-
-
-/*
- * Describes a Transmit Descriptor
- */
-typedef struct {
-	SREGS_PAD(pad0);
-	u16 tx_status;		/* status after transmission of a packet */
-	 SREGS_PAD(pad1);
-	u16 tx_config;		/* transmit configuration for this packet */
-	 SREGS_PAD(pad2);
-	u16 tx_pktsize;		/* size of the packet to be transmitted */
-	 SREGS_PAD(pad3);
-	u16 tx_frag_count;	/* no. of fragments */
-
-	 SREGS_PAD(pad4);
-	u16 tx_frag_ptr_l;
-	 SREGS_PAD(pad5);
-	u16 tx_frag_ptr_h;
-	 SREGS_PAD(pad6);
-	u16 tx_frag_size;
-
-	 SREGS_PAD(pad7);
-	u16 link;		/* ptr to next descriptor */
-} sonic_td_t;
-
-
-/*
- * Describes an entry in the CAM Descriptor Area.
- */
-
-typedef struct {
-	SREGS_PAD(pad0);
-	u16 cam_entry_pointer;
-	 SREGS_PAD(pad1);
-	u16 cam_cap0;
-	 SREGS_PAD(pad2);
-	u16 cam_cap1;
-	 SREGS_PAD(pad3);
-	u16 cam_cap2;
-} sonic_cd_t;
-
+#define SONIC_EOL       0x0001
 #define CAM_DESCRIPTORS 16
 
+/* Offsets in the various DMA buffers accessed by the SONIC */
 
-typedef struct {
-	sonic_cd_t cam_desc[CAM_DESCRIPTORS];
-	 SREGS_PAD(pad);
-	u16 cam_enable;
-} sonic_cda_t;
-
-#else				/* original declarations, little endian 32 bit */
-
-/*
- * structure definitions
- */
-
-typedef struct {
-	u32 rx_bufadr_l;	/* receive buffer ptr */
-	u32 rx_bufadr_h;
-
-	u32 rx_bufsize_l;	/* no. of words in the receive buffer */
-	u32 rx_bufsize_h;
-} sonic_rr_t;
-
-/*
- * Sonic receive descriptor. Receive descriptors are
- * kept in a linked list of these structures.
- */
-
-typedef struct {
-	u16 rx_status;		/* status after reception of a packet */
-	 SREGS_PAD(pad0);
-	u16 rx_pktlen;		/* length of the packet incl. CRC */
-	 SREGS_PAD(pad1);
-
-	/*
-	 * Pointers to the location in the receive buffer area (RBA)
-	 * where the packet resides. A packet is always received into
-	 * a contiguous piece of memory.
-	 */
-	u16 rx_pktptr_l;
-	 SREGS_PAD(pad2);
-	u16 rx_pktptr_h;
-	 SREGS_PAD(pad3);
-
-	u16 rx_seqno;		/* sequence no. */
-	 SREGS_PAD(pad4);
-
-	u16 link;		/* link to next RDD (end if EOL bit set) */
-	 SREGS_PAD(pad5);
-
-	/*
-	 * Owner of this descriptor, 0= driver, 1=sonic
-	 */
-
-	u16 in_use;
-	 SREGS_PAD(pad6);
-
-	caddr_t rda_next;	/* pointer to next RD */
-} sonic_rd_t;
-
-
-/*
- * Describes a Transmit Descriptor
- */
-typedef struct {
-	u16 tx_status;		/* status after transmission of a packet */
-	 SREGS_PAD(pad0);
-	u16 tx_config;		/* transmit configuration for this packet */
-	 SREGS_PAD(pad1);
-	u16 tx_pktsize;		/* size of the packet to be transmitted */
-	 SREGS_PAD(pad2);
-	u16 tx_frag_count;	/* no. of fragments */
-	 SREGS_PAD(pad3);
-
-	u16 tx_frag_ptr_l;
-	 SREGS_PAD(pad4);
-	u16 tx_frag_ptr_h;
-	 SREGS_PAD(pad5);
-	u16 tx_frag_size;
-	 SREGS_PAD(pad6);
-
-	u16 link;		/* ptr to next descriptor */
-	 SREGS_PAD(pad7);
-} sonic_td_t;
-
-
-/*
- * Describes an entry in the CAM Descriptor Area.
- */
-
-typedef struct {
-	u16 cam_entry_pointer;
-	 SREGS_PAD(pad0);
-	u16 cam_cap0;
-	 SREGS_PAD(pad1);
-	u16 cam_cap1;
-	 SREGS_PAD(pad2);
-	u16 cam_cap2;
-	 SREGS_PAD(pad3);
-} sonic_cd_t;
-
-#define CAM_DESCRIPTORS 16
+#define SONIC_BITMODE16 0
+#define SONIC_BITMODE32 1
+#define SONIC_BUS_SCALE(bitmode) ((bitmode) ? 4 : 2)
+/* Note!  These are all measured in bus-size units, so use SONIC_BUS_SCALE */
+#define SIZEOF_SONIC_RR 4
+#define SONIC_RR_BUFADR_L  0
+#define SONIC_RR_BUFADR_H  1
+#define SONIC_RR_BUFSIZE_L 2
+#define SONIC_RR_BUFSIZE_H 3
+
+#define SIZEOF_SONIC_RD 7
+#define SONIC_RD_STATUS   0
+#define SONIC_RD_PKTLEN   1
+#define SONIC_RD_PKTPTR_L 2
+#define SONIC_RD_PKTPTR_H 3
+#define SONIC_RD_SEQNO    4
+#define SONIC_RD_LINK     5
+#define SONIC_RD_IN_USE   6
+
+#define SIZEOF_SONIC_TD 8
+#define SONIC_TD_STATUS       0
+#define SONIC_TD_CONFIG       1
+#define SONIC_TD_PKTSIZE      2
+#define SONIC_TD_FRAG_COUNT   3
+#define SONIC_TD_FRAG_PTR_L   4
+#define SONIC_TD_FRAG_PTR_H   5
+#define SONIC_TD_FRAG_SIZE    6
+#define SONIC_TD_LINK         7
+
+#define SIZEOF_SONIC_CD 4
+#define SONIC_CD_ENTRY_POINTER 0
+#define SONIC_CD_CAP0          1
+#define SONIC_CD_CAP1          2
+#define SONIC_CD_CAP2          3
 
-
-typedef struct {
-	sonic_cd_t cam_desc[CAM_DESCRIPTORS];
-	u16 cam_enable;
-	 SREGS_PAD(pad);
-} sonic_cda_t;
-#endif				/* endianness */
+#define SIZEOF_SONIC_CDA ((CAM_DESCRIPTORS * SIZEOF_SONIC_CD) + 1)
+#define SONIC_CDA_CAM_ENABLE   (CAM_DESCRIPTORS * SIZEOF_SONIC_CD)
 
 /*
  * Some tunables for the buffer areas. Power of 2 is required
@@ -426,44 +270,60 @@
  *
  * MSch: use more buffer space for the slow m68k Macs!
  */
-#ifdef CONFIG_MACSONIC
-#define SONIC_NUM_RRS    32	/* number of receive resources */
-#define SONIC_NUM_RDS    SONIC_NUM_RRS	/* number of receive descriptors */
-#define SONIC_NUM_TDS    32	/* number of transmit descriptors */
-#else
-#define SONIC_NUM_RRS    16	/* number of receive resources */
-#define SONIC_NUM_RDS    SONIC_NUM_RRS	/* number of receive descriptors */
-#define SONIC_NUM_TDS    16	/* number of transmit descriptors */
-#endif
-#define SONIC_RBSIZE   1520	/* size of one resource buffer */
-
-#define SONIC_RDS_MASK   (SONIC_NUM_RDS-1)
-#define SONIC_TDS_MASK   (SONIC_NUM_TDS-1)
-
+#define SONIC_NUM_RRS   16            /* number of receive resources */
+#define SONIC_NUM_RDS   SONIC_NUM_RRS /* number of receive descriptors */
+#define SONIC_NUM_TDS   16            /* number of transmit descriptors */
+
+#define SONIC_RDS_MASK  (SONIC_NUM_RDS-1)
+#define SONIC_TDS_MASK  (SONIC_NUM_TDS-1)
+
+#define SONIC_RBSIZE	1520          /* size of one resource buffer */
+
+/* Again, measured in bus size units! */
+#define SIZEOF_SONIC_DESC (SIZEOF_SONIC_CDA	\
+	+ (SIZEOF_SONIC_TD * SONIC_NUM_TDS)	\
+	+ (SIZEOF_SONIC_RD * SONIC_NUM_RDS)	\
+	+ (SIZEOF_SONIC_RR * SONIC_NUM_RRS))
 
 /* Information that need to be kept for each board. */
 struct sonic_local {
-	sonic_cda_t cda;	/* virtual CPU address of CDA */
-	sonic_td_t tda[SONIC_NUM_TDS];	/* transmit descriptor area */
-	sonic_rr_t rra[SONIC_NUM_RRS];	/* receive resource area */
-	sonic_rd_t rda[SONIC_NUM_RDS];	/* receive descriptor area */
-	struct sk_buff *tx_skb[SONIC_NUM_TDS];	/* skbuffs for packets to transmit */
-	unsigned int tx_laddr[SONIC_NUM_TDS];	/* logical DMA address fro skbuffs */
-	unsigned char *rba;	/* start of receive buffer areas */
-	unsigned int cda_laddr;	/* logical DMA address of CDA */
-	unsigned int tda_laddr;	/* logical DMA address of TDA */
-	unsigned int rra_laddr;	/* logical DMA address of RRA */
-	unsigned int rda_laddr;	/* logical DMA address of RDA */
-	unsigned int rba_laddr;	/* logical DMA address of RBA */
-	unsigned int cur_rra;	/* current indexes to resource areas */
+	/* Bus size.  0 == 16 bits, 1 == 32 bits. */
+	int dma_bitmode;
+	/* Register offset within the longword (independent of endianness,
+	   and varies from one type of Macintosh SONIC to another
+	   (Aarrgh)) */
+	int reg_offset;
+	void *descriptors;
+	/* Crud.  These areas have to be within the same 64K.  Therefore
+       we allocate a desriptors page, and point these to places within it. */
+	void *cda;  /* CAM descriptor area */
+	void *tda;  /* Transmit descriptor area */
+	void *rra;  /* Receive resource area */
+	void *rda;  /* Receive descriptor area */
+	struct sk_buff* volatile rx_skb[SONIC_NUM_RRS];	/* packets to be received */
+	struct sk_buff* volatile tx_skb[SONIC_NUM_TDS];	/* packets to be transmitted */
+	unsigned int tx_len[SONIC_NUM_TDS]; /* lengths of tx DMA mappings */
+	/* Logical DMA addresses on MIPS, bus addresses on m68k
+	 * (so "laddr" is a bit misleading) */
+	dma_addr_t descriptors_laddr;
+	u32 cda_laddr;              /* logical DMA address of CDA */
+	u32 tda_laddr;              /* logical DMA address of TDA */
+	u32 rra_laddr;              /* logical DMA address of RRA */
+	u32 rda_laddr;              /* logical DMA address of RDA */
+	dma_addr_t rx_laddr[SONIC_NUM_RRS]; /* logical DMA addresses of rx skbuffs */
+	dma_addr_t tx_laddr[SONIC_NUM_TDS]; /* logical DMA addresses of tx skbuffs */
+	unsigned int rra_end;
+	unsigned int cur_rwp;
 	unsigned int cur_rx;
-	unsigned int cur_tx;
-	unsigned int dirty_tx;	/* last unacked transmit packet */
-	char tx_full;
+	unsigned int cur_tx;           /* first unacked transmit packet */
+	unsigned int eol_rx;
+	unsigned int eol_tx;           /* last unacked transmit packet */
+	unsigned int next_tx;          /* next free TD */
+	struct device *device;         /* generic device */
 	struct net_device_stats stats;
 };
 
-#define TX_TIMEOUT 6
+#define TX_TIMEOUT (3 * HZ)
 
 /* Index to functions, as function prototypes. */
 
@@ -476,6 +336,114 @@
 static void sonic_multicast_list(struct net_device *dev);
 static int sonic_init(struct net_device *dev);
 static void sonic_tx_timeout(struct net_device *dev);
+
+/* Internal inlines for reading/writing DMA buffers.  Note that bus
+   size and endianness matter here, whereas they don't for registers,
+   as far as we can tell. */
+/* OpenBSD calls this "SWO".  I'd like to think that sonic_buf_put()
+   is a much better name. */
+static inline void sonic_buf_put(void* base, int bitmode,
+				 int offset, __u16 val)
+{
+	if (bitmode)
+#ifdef __BIG_ENDIAN
+		((__u16 *) base + (offset*2))[1] = val;
+#else
+		((__u16 *) base + (offset*2))[0] = val;
+#endif
+	else
+	 	((__u16 *) base)[offset] = val;
+}
+
+static inline __u16 sonic_buf_get(void* base, int bitmode,
+				  int offset)
+{
+	if (bitmode)
+#ifdef __BIG_ENDIAN
+		return ((volatile __u16 *) base + (offset*2))[1];
+#else
+		return ((volatile __u16 *) base + (offset*2))[0];
+#endif
+	else
+		return ((volatile __u16 *) base)[offset];
+}
+
+/* Inlines that you should actually use for reading/writing DMA buffers */
+static inline void sonic_cda_put(struct net_device* dev, int entry,
+				 int offset, __u16 val)
+{
+	struct sonic_local* lp = (struct sonic_local *) dev->priv;
+	sonic_buf_put(lp->cda, lp->dma_bitmode,
+		      (entry * SIZEOF_SONIC_CD) + offset, val);
+}
+
+static inline __u16 sonic_cda_get(struct net_device* dev, int entry,
+				  int offset)
+{
+	struct sonic_local* lp = (struct sonic_local *) dev->priv;
+	return sonic_buf_get(lp->cda, lp->dma_bitmode,
+			     (entry * SIZEOF_SONIC_CD) + offset);
+}
+
+static inline void sonic_set_cam_enable(struct net_device* dev, __u16 val)
+{
+	struct sonic_local* lp = (struct sonic_local *) dev->priv;
+	sonic_buf_put(lp->cda, lp->dma_bitmode, SONIC_CDA_CAM_ENABLE, val);
+}
+
+static inline __u16 sonic_get_cam_enable(struct net_device* dev)
+{
+	struct sonic_local* lp = (struct sonic_local *) dev->priv;
+	return sonic_buf_get(lp->cda, lp->dma_bitmode, SONIC_CDA_CAM_ENABLE);
+}
+
+static inline void sonic_tda_put(struct net_device* dev, int entry,
+				 int offset, __u16 val)
+{
+	struct sonic_local* lp = (struct sonic_local *) dev->priv;
+	sonic_buf_put(lp->tda, lp->dma_bitmode,
+		      (entry * SIZEOF_SONIC_TD) + offset, val);
+}
+
+static inline __u16 sonic_tda_get(struct net_device* dev, int entry,
+				  int offset)
+{
+	struct sonic_local* lp = (struct sonic_local *) dev->priv;
+	return sonic_buf_get(lp->tda, lp->dma_bitmode,
+			     (entry * SIZEOF_SONIC_TD) + offset);
+}
+
+static inline void sonic_rda_put(struct net_device* dev, int entry,
+				 int offset, __u16 val)
+{
+	struct sonic_local* lp = (struct sonic_local *) dev->priv;
+	sonic_buf_put(lp->rda, lp->dma_bitmode,
+		      (entry * SIZEOF_SONIC_RD) + offset, val);
+}
+
+static inline __u16 sonic_rda_get(struct net_device* dev, int entry,
+				  int offset)
+{
+	struct sonic_local* lp = (struct sonic_local *) dev->priv;
+	return sonic_buf_get(lp->rda, lp->dma_bitmode,
+			     (entry * SIZEOF_SONIC_RD) + offset);
+}
+
+static inline void sonic_rra_put(struct net_device* dev, int entry,
+				 int offset, __u16 val)
+{
+	struct sonic_local* lp = (struct sonic_local *) dev->priv;
+	sonic_buf_put(lp->rra, lp->dma_bitmode,
+		      (entry * SIZEOF_SONIC_RR) + offset, val);
+}
+
+static inline __u16 sonic_rra_get(struct net_device* dev, int entry,
+				  int offset)
+{
+	struct sonic_local* lp = (struct sonic_local *) dev->priv;
+	return sonic_buf_get(lp->rra, lp->dma_bitmode,
+			     (entry * SIZEOF_SONIC_RR) + offset);
+}
 
 static const char *version =
     "sonic.c:v0.92 20.9.98 tsbogend@alpha.franken.de\n";
