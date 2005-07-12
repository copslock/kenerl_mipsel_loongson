Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2005 16:30:51 +0100 (BST)
Received: from loopy.telegraphics.com.au ([IPv6:::ffff:202.45.126.152]:48027
	"EHLO loopy.telegraphics.com.au") by linux-mips.org with ESMTP
	id <S8226648AbVGLPad>; Tue, 12 Jul 2005 16:30:33 +0100
Received: by loopy.telegraphics.com.au (Postfix, from userid 1001)
	id A392972E95; Wed, 13 Jul 2005 01:31:25 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by loopy.telegraphics.com.au (Postfix) with ESMTP id 9D1E22AA01;
	Wed, 13 Jul 2005 01:31:25 +1000 (EST)
Date:	Wed, 13 Jul 2005 01:31:25 +1000 (EST)
From:	Finn Thain <fthain@telegraphics.com.au>
To:	Jeff Garzik <jgarzik@pobox.com>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/m68k <linux-m68k@vger.kernel.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux MIPS <linux-mips@linux-mips.org>,
	Linux net <linux-net@vger.kernel.org>
Subject: Re: [PATCH] macsonic/jazzsonic drivers update (part 2)
In-Reply-To: <42BEEC32.7040807@pobox.com>
Message-ID: <Pine.LNX.4.61.0507130122220.4355@loopy.telegraphics.com.au>
References: <200503070210.j272ARii023023@hera.kernel.org>
 <Pine.LNX.4.62.0503221807160.20753@numbat.sonytel.be> <20050323100139.GB8813@linux-mips.org>
 <Pine.LNX.4.61.0506121454410.1470@loopy.telegraphics.com.au>
 <20050615114158.GA9411@linux-mips.org> <Pine.LNX.4.61.0506152220460.22046@loopy.telegraphics.com.au>
 <20050615142717.GD9411@linux-mips.org> <Pine.LNX.4.61.0506160218310.24328@loopy.telegraphics.com.au>
 <Pine.LNX.4.61.0506160336410.24908@loopy.telegraphics.com.au>
 <20050616092257.GE5202@linux-mips.org> <Pine.LNX.4.61.0506162129450.31164@loopy.telegraphics.com.au>
 <Pine.LNX.4.61.0506270227510.1015@loopy.telegraphics.com.au>
 <42BEEC32.7040807@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <fthain@telegraphics.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fthain@telegraphics.com.au
Precedence: bulk
X-list: linux-mips



On Sun, 26 Jun 2005, Jeff Garzik wrote:

> Patch looks OK to me.  Comments:
> 
> 1) Either Geert or Ralf can merge this, with my ACK.
> 
> 2) Would be nice to get it tested on the machines you list as untested.
> 
> 3) [possible problem in driver, not your changes] I wonder if IRQ_HANDLED is
> ever returned for shared interrupts?  I don't know enough about the platform
> interrupt architecture to answer this question.
> 
> 4) Remove casts to/from void.  This is especially noticable in all the casts
> of the netdev_priv() return value.
>
> 5) If it doesn't cause too much patch noise, consider using enums rather than
> #defines, for numeric constants.  This gives the compiler more type
> information and makes the symbols visible in a debugger.  This is a
> -maintainer preference- issue overall, so don't sweat it if you disagree.


This patch removes the unecessary void* casts introduced in the first patch.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>


--- a/drivers/net/jazzsonic.c	Sun Jul 10 22:11:40 2005
+++ linux/drivers/net/jazzsonic.c	Sun Jul 10 22:22:39 2005
@@ -93,7 +93,7 @@
 	static unsigned version_printed;
 	unsigned int silicon_revision;
 	unsigned int val;
-	struct sonic_local *lp = (struct sonic_local *) netdev_priv(dev);
+	struct sonic_local *lp = netdev_priv(dev);
 	int err = -ENODEV;
 	int i;
 
@@ -145,7 +145,7 @@
 
 	/* Allocate the entire chunk of memory for the descriptors.
            Note that this cannot cross a 64K boundary. */
-	if ((lp->descriptors = (void *) dma_alloc_coherent(lp->device,
+	if ((lp->descriptors = dma_alloc_coherent(lp->device,
 				SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
 				&lp->descriptors_laddr, GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "%s: couldn't alloc DMA memory for descriptors.\n", lp->device->bus_id);
@@ -211,7 +211,7 @@
 	if (!dev)
 		return -ENOMEM;
 
-	lp = (struct sonic_local *) netdev_priv(dev);
+	lp = netdev_priv(dev);
 	lp->device = device;
 	SET_NETDEV_DEV(dev, device);
  	SET_MODULE_OWNER(dev);
@@ -267,7 +267,7 @@
 static int __devexit jazz_sonic_device_remove (struct device *device)
 {
 	struct net_device *dev = device->driver_data;
-	struct sonic_local* lp = (struct sonic_local *) netdev_priv(dev);
+	struct sonic_local* lp = netdev_priv(dev);
 
 	unregister_netdev (dev);
 	dma_free_coherent(lp->device, SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
--- a/drivers/net/macsonic.c	Sun Jul 10 22:11:40 2005
+++ linux/drivers/net/macsonic.c	Sun Jul 10 22:23:06 2005
@@ -135,11 +135,11 @@
 
 int __init macsonic_init(struct net_device* dev)
 {
-	struct sonic_local* lp = (struct sonic_local *) netdev_priv(dev);
+	struct sonic_local* lp = netdev_priv(dev);
 
 	/* Allocate the entire chunk of memory for the descriptors.
            Note that this cannot cross a 64K boundary. */
-	if ((lp->descriptors = (void *) dma_alloc_coherent(lp->device,
+	if ((lp->descriptors = dma_alloc_coherent(lp->device,
 	            SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
 	            &lp->descriptors_laddr, GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "%s: couldn't alloc DMA memory for descriptors.\n", lp->device->bus_id);
@@ -183,7 +183,7 @@
 
 int __init mac_onboard_sonic_ethernet_addr(struct net_device* dev)
 {
-	struct sonic_local *lp = (struct sonic_local *) netdev_priv(dev);
+	struct sonic_local *lp = netdev_priv(dev);
 	const int prom_addr = ONBOARD_SONIC_PROM_BASE;
 	int i;
 
@@ -255,7 +255,7 @@
 {
 	/* Bwahahaha */
 	static int once_is_more_than_enough;
-	struct sonic_local* lp = (struct sonic_local *) netdev_priv(dev);
+	struct sonic_local* lp = netdev_priv(dev);
 	int sr;
 	int commslot = 0;
 	
@@ -416,7 +416,7 @@
 {
 	static int slots;
 	struct nubus_dev* ndev = NULL;
-	struct sonic_local* lp = (struct sonic_local *) netdev_priv(dev);
+	struct sonic_local* lp = netdev_priv(dev);
 	unsigned long base_addr, prom_addr;
 	u16 sonic_dcr;
 	int id = -1;
@@ -536,7 +536,7 @@
 	if (!dev)
 		return -ENOMEM;
 
-	lp = (struct sonic_local *) netdev_priv(dev);
+	lp = netdev_priv(dev);
 	lp->device = device;
 	SET_NETDEV_DEV(dev, device);
  	SET_MODULE_OWNER(dev);
@@ -582,7 +582,7 @@
 static int __devexit mac_sonic_device_remove (struct device *device)
 {
 	struct net_device *dev = device->driver_data;
-	struct sonic_local* lp = (struct sonic_local *) netdev_priv(dev);
+	struct sonic_local* lp = netdev_priv(dev);
 
 	unregister_netdev (dev);
 	dma_free_coherent(lp->device, SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
--- a/drivers/net/sonic.c	Sun Jul 10 22:11:40 2005
+++ linux/drivers/net/sonic.c	Sun Jul 10 22:26:14 2005
@@ -44,7 +44,7 @@
  */
 static int sonic_open(struct net_device *dev)
 {
-	struct sonic_local *lp = (struct sonic_local *) netdev_priv(dev);
+	struct sonic_local *lp = netdev_priv(dev);
 	int i;
 	
 	if (sonic_debug > 2)
@@ -131,7 +131,7 @@
  */
 static int sonic_close(struct net_device *dev)
 {
-	struct sonic_local *lp = (struct sonic_local *) netdev_priv(dev);
+	struct sonic_local *lp = netdev_priv(dev);
 	int i;
 
 	if (sonic_debug > 2)
@@ -177,7 +177,7 @@
 
 static void sonic_tx_timeout(struct net_device *dev)
 {
-	struct sonic_local *lp = (struct sonic_local *) netdev_priv(dev);
+	struct sonic_local *lp = netdev_priv(dev);
 	int i;
 	/* Stop the interrupts for this */
 	SONIC_WRITE(SONIC_IMR, 0);
@@ -221,7 +221,7 @@
 
 static int sonic_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
-	struct sonic_local *lp = (struct sonic_local *) netdev_priv(dev);
+	struct sonic_local *lp = netdev_priv(dev);
 	dma_addr_t laddr;
 	int length;
 	int entry = lp->next_tx;
@@ -297,7 +297,7 @@
 static irqreturn_t sonic_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *) dev_id;
-	struct sonic_local *lp = (struct sonic_local *) netdev_priv(dev);
+	struct sonic_local *lp = netdev_priv(dev);
 	int status;
 
 	if (dev == NULL) {
@@ -436,7 +436,7 @@
  */
 static void sonic_rx(struct net_device *dev)
 {
-	struct sonic_local *lp = (struct sonic_local *) netdev_priv(dev);
+	struct sonic_local *lp = netdev_priv(dev);
 	int status;
 	int entry = lp->cur_rx;
 
@@ -539,7 +539,7 @@
  */
 static struct net_device_stats *sonic_get_stats(struct net_device *dev)
 {
-	struct sonic_local *lp = (struct sonic_local *) netdev_priv(dev);
+	struct sonic_local *lp = netdev_priv(dev);
 
 	/* read the tally counter from the SONIC and reset them */
 	lp->stats.rx_crc_errors += SONIC_READ(SONIC_CRCT);
@@ -558,7 +558,7 @@
  */
 static void sonic_multicast_list(struct net_device *dev)
 {
-	struct sonic_local *lp = (struct sonic_local *) netdev_priv(dev);
+	struct sonic_local *lp = netdev_priv(dev);
 	unsigned int rcr;
 	struct dev_mc_list *dmi = dev->mc_list;
 	unsigned char *addr;
@@ -604,7 +604,7 @@
 static int sonic_init(struct net_device *dev)
 {
 	unsigned int cmd;
-	struct sonic_local *lp = (struct sonic_local *) netdev_priv(dev);
+	struct sonic_local *lp = netdev_priv(dev);
 	int i;
 
 	/*
