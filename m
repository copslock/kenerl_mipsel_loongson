Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2003 23:55:38 +0000 (GMT)
Received: from fw.osdl.org ([IPv6:::ffff:65.172.181.6]:918 "EHLO mail.osdl.org")
	by linux-mips.org with ESMTP id <S8225385AbTLIXzh>;
	Tue, 9 Dec 2003 23:55:37 +0000
Received: from dell_ss3.pdx.osdl.net (dell_ss3.pdx.osdl.net [172.20.1.60])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id hB9NseZ07044;
	Tue, 9 Dec 2003 15:54:40 -0800
Date: Tue, 9 Dec 2003 15:54:40 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>,
	Jeff Garzik <jgarzik@pobox.com>, Ralf Baechle <ralf@gnu.org>
Cc: linux-mips@linux-mips.org, irda-users@sourceforge.net
Subject: [PATCH] au1k_ir - fix for 2.6
Message-Id: <20031209155440.2615b9cc.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <shemminger@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shemminger@osdl.org
Precedence: bulk
X-list: linux-mips

This fixes some of the issues with the Alchemy irda driver for MIPS on
2.6.0-test11.  Tested with cross compile.  This driver is probably obsolete
but it is one of the two remaining users of dev_alloc

Changes:
	* irqreturn_t for irq routine
	* alloc_irdadev instead of dev_alloc
	* should work as non module

Some mips build notes:
	* no way to enable the device at present since drivers/net/irda/Kconfig
	  expects MIPS_A1000 and arch/mips/Kconfig defines SOC_AU1000!
	* include/asm-mips/timex.h does not define CLOCK_TICK_RATE for this
	  that type.  Code should probably be:

#ifdef CONFIG_SGI_IP22
#define CLOCK_TICK_RATE		1000000
#else
#define CLOCK_TICK_RATE		1193182
#endif

diff -Nru a/drivers/net/irda/au1k_ir.c b/drivers/net/irda/au1k_ir.c
--- a/drivers/net/irda/au1k_ir.c	Mon Dec  8 13:44:44 2003
+++ b/drivers/net/irda/au1k_ir.c	Mon Dec  8 13:44:44 2003
@@ -54,18 +54,17 @@
 #include <net/irda/irda_device.h>
 #include "net/irda/au1000_ircc.h"
 
-static int au1k_irda_net_init(struct net_device *);
 static int au1k_irda_start(struct net_device *);
 static int au1k_irda_stop(struct net_device *dev);
 static int au1k_irda_hard_xmit(struct sk_buff *, struct net_device *);
 static int au1k_irda_rx(struct net_device *);
-static void au1k_irda_interrupt(int, void *, struct pt_regs *);
+static irqreturn_t au1k_irda_interrupt(int, void *, struct pt_regs *);
 static void au1k_tx_timeout(struct net_device *);
 static struct net_device_stats *au1k_irda_stats(struct net_device *);
 static int au1k_irda_ioctl(struct net_device *, struct ifreq *, int);
 static int au1k_irda_set_speed(struct net_device *dev, int speed);
 
-static void *dma_alloc(size_t, dma_addr_t *);
+static void *dma_alloc(size_t);
 static void dma_free(void *, size_t);
 
 static int qos_mtt_bits = 0x07;  /* 1 ms or more */
@@ -81,7 +80,7 @@
  * IrDA peripheral bug. You have to read the register
  * twice to get the right value.
  */
-u32 read_ir_reg(u32 addr) 
+static u32 read_ir_reg(u32 addr) 
 { 
 	readl(addr);
 	return readl(addr);
@@ -93,32 +92,23 @@
  * has the virtual and dma address of a buffer suitable for 
  * both, receive and transmit operations.
  */
-static db_dest_t *GetFreeDB(struct au1k_private *aup)
+static inline db_dest_t *GetFreeDB(struct au1k_private *aup)
 {
 	db_dest_t *pDB;
 	pDB = aup->pDBfree;
 
-	if (pDB) {
+	if (pDB) 
 		aup->pDBfree = pDB->pnext;
-	}
-	return pDB;
-}
 
-static void ReleaseDB(struct au1k_private *aup, db_dest_t *pDB)
-{
-	db_dest_t *pDBfree = aup->pDBfree;
-	if (pDBfree)
-		pDBfree->pnext = pDB;
-	aup->pDBfree = pDB;
+	return pDB;
 }
 
-
 /*
   DMA memory allocation, derived from pci_alloc_consistent.
   However, the Au1000 data cache is coherent (when programmed
   so), therefore we return KSEG0 address, not KSEG1.
 */
-static void *dma_alloc(size_t size, dma_addr_t * dma_handle)
+static void *dma_alloc(size_t size)
 {
 	void *ret;
 	int gfp = GFP_ATOMIC | GFP_DMA;
@@ -127,8 +117,7 @@
 
 	if (ret != NULL) {
 		memset(ret, 0, size);
-		*dma_handle = virt_to_bus(ret);
-		ret = KSEG0ADDR(ret);
+		ret = (void *) KSEG0ADDR(ret);
 	}
 	return ret;
 }
@@ -136,7 +125,7 @@
 
 static void dma_free(void *vaddr, size_t size)
 {
-	vaddr = KSEG0ADDR(vaddr);
+	vaddr = (void *) KSEG0ADDR(vaddr);
 	free_pages((unsigned long) vaddr, get_order(size));
 }
 
@@ -155,48 +144,7 @@
 	}
 }
 
-
-/* 
- * Device has already been stopped at this point.
- */
-static void au1k_irda_net_uninit(struct net_device *dev)
-{
-	dev->hard_start_xmit = NULL;
-	dev->open            = NULL;
-	dev->stop            = NULL;
-	dev->do_ioctl        = NULL;
-	dev->get_stats       = NULL;
-	dev->priv            = NULL;
-}
-
-
-static int au1k_irda_init(void)
-{
-	static unsigned version_printed = 0;
-	struct net_device *dev;
-	int err;
-
-	if (version_printed++ == 0) printk(version);
-
-	rtnl_lock();
-	dev = dev_alloc("irda%d", &err);
-	if (dev) {
-		dev->irq = AU1000_IRDA_RX_INT; /* TX has its own interrupt */
-		dev->init = au1k_irda_net_init;
-		dev->uninit = au1k_irda_net_uninit;
-		err = register_netdevice(dev);
-
-		if (err)
-			kfree(dev);
-		else
-			ir_devs[0] = dev;
-		printk(KERN_INFO "IrDA: Registered device %s\n", dev->name);
-	}
-	rtnl_unlock();
-	return err;
-}
-
-static int au1k_irda_init_iobuf(iobuff_t *io, int size)
+static __init int au1k_irda_init_iobuf(iobuff_t *io, int size)
 {
 	io->head = kmalloc(size, GFP_KERNEL);
 	if (io->head != NULL) {
@@ -208,25 +156,26 @@
 	return io->head ? 0 : -ENOMEM;
 }
 
-static int au1k_irda_net_init(struct net_device *dev)
+static __init int au1k_irda_init(void)
 {
-	struct au1k_private *aup = NULL;
-	int i, retval = 0, err;
+	static unsigned version_printed = 0;
+	struct net_device *dev;
+	struct au1k_private *aup;
 	db_dest_t *pDB, *pDBfree;
-	unsigned long temp;
+	int i, err;
 
-	dev->priv = kmalloc(sizeof(struct au1k_private), GFP_KERNEL);
-	if (dev->priv == NULL) {
-		retval = -ENOMEM;
-		goto out;
-	}
-	memset(dev->priv, 0, sizeof(struct au1k_private));
-	aup = dev->priv;
+	if (version_printed++ == 0) printk(version);
 
+	dev = alloc_irdadev(sizeof(struct au1k_private));
+	if (!dev) 
+		return -ENOMEM;
+
+	aup = dev->priv;
 	err = au1k_irda_init_iobuf(&aup->rx_buff, 14384);
 	if (err)
-		goto out;
+		goto out1;
 
+	dev->irq = AU1000_IRDA_RX_INT; /* TX has its own interrupt */
 	dev->open = au1k_irda_start;
 	dev->hard_start_xmit = au1k_irda_hard_xmit;
 	dev->stop = au1k_irda_stop;
@@ -244,19 +193,19 @@
 	aup->qos.min_turn_time.bits = qos_mtt_bits;
 	irda_qos_bits_to_value(&aup->qos);
 
-
+	err = -ENOMEM;
 	/* Tx ring follows rx ring + 512 bytes */
 	/* we need a 1k aligned buffer */
 	aup->rx_ring[0] = (ring_dest_t *)
-		dma_alloc(2*MAX_NUM_IR_DESC*(sizeof(ring_dest_t)), &temp);
+		dma_alloc(2*MAX_NUM_IR_DESC*(sizeof(ring_dest_t)));
+
+	if (!aup->rx_ring[0])
+		goto out2;
 
 	/* allocate the data buffers */
-	aup->db[0].vaddr = 
-		(void *)dma_alloc(MAX_BUF_SIZE * 2*NUM_IR_DESC, &temp);
-	if (!aup->db[0].vaddr || !aup->rx_ring[0]) {
-		retval = -ENOMEM;
-		goto out;
-	}
+	aup->db[0].vaddr = dma_alloc(MAX_BUF_SIZE * 2*NUM_IR_DESC);
+	if (!aup->db[0].vaddr) 
+		goto out3;
 
 	setup_hw_rings(aup, (u32)aup->rx_ring[0], (u32)aup->rx_ring[0] + 512);
 
@@ -275,16 +224,17 @@
 	/* attach a data buffer to each descriptor */
 	for (i=0; i<NUM_IR_DESC; i++) {
 		pDB = GetFreeDB(aup);
-		if (!pDB) goto out;
+		if (!pDB) goto out4;
 		aup->rx_ring[i]->addr_0 = (u8)(pDB->dma_addr & 0xff);
 		aup->rx_ring[i]->addr_1 = (u8)((pDB->dma_addr>>8) & 0xff);
 		aup->rx_ring[i]->addr_2 = (u8)((pDB->dma_addr>>16) & 0xff);
 		aup->rx_ring[i]->addr_3 = (u8)((pDB->dma_addr>>24) & 0xff);
 		aup->rx_db_inuse[i] = pDB;
 	}
+
 	for (i=0; i<NUM_IR_DESC; i++) {
 		pDB = GetFreeDB(aup);
-		if (!pDB) goto out;
+		if (!pDB) goto out4;
 		aup->tx_ring[i]->addr_0 = (u8)(pDB->dma_addr & 0xff);
 		aup->tx_ring[i]->addr_1 = (u8)((pDB->dma_addr>>8) & 0xff);
 		aup->tx_ring[i]->addr_2 = (u8)((pDB->dma_addr>>16) & 0xff);
@@ -294,24 +244,28 @@
 		aup->tx_ring[i]->flags = 0;
 		aup->tx_db_inuse[i] = pDB;
 	}
-	return 0;
 
-out:
-	if (aup->db[0].vaddr) 
-		dma_free((void *)aup->db[0].vaddr, 
-				MAX_BUF_SIZE * 2*NUM_IR_DESC);
-	if (aup->rx_ring[0])
-		kfree((void *)aup->rx_ring[0]);
-	if (aup->rx_buff.head)
-		kfree(aup->rx_buff.head);
-	if (dev->priv != NULL)
-		kfree(dev->priv);
-	unregister_netdevice(dev);
-	printk(KERN_ERR "%s: au1k_init_module failed.  Returns %d\n",
-	       dev->name, retval);
-	return retval;
-}
+	err = register_netdev(dev);
+	if (err)
+		goto out4;
+	else {
+		ir_devs[0] = dev;
+		printk(KERN_INFO "IrDA: Registered device %s\n", dev->name);
+	}
+	return err;
 
+ out4:
+	dma_free((void *)aup->db[0].vaddr, 
+		 MAX_BUF_SIZE * 2*NUM_IR_DESC);
+ out3:
+	dma_free((void *)aup->rx_ring[0],
+		 2*MAX_NUM_IR_DESC*(sizeof(ring_dest_t)));
+ out2:
+	kfree(aup->rx_buff.head);
+ out1:
+	free_netdev(dev);
+	return err;
+}
 
 static int au1k_init(struct net_device *dev)
 {
@@ -361,11 +315,8 @@
 	char hwname[32];
 	struct au1k_private *aup = (struct au1k_private *) dev->priv;
 
-	MOD_INC_USE_COUNT;
-
 	if ((retval = au1k_init(dev))) {
 		printk(KERN_ERR "%s: error in au1k_init\n", dev->name);
-		MOD_DEC_USE_COUNT;
 		return retval;
 	}
 
@@ -373,7 +324,6 @@
 					0, dev->name, dev))) {
 		printk(KERN_ERR "%s: unable to get IRQ %d\n", 
 				dev->name, dev->irq);
-		MOD_DEC_USE_COUNT;
 		return retval;
 	}
 	if ((retval = request_irq(AU1000_IRDA_RX_INT, &au1k_irda_interrupt, 
@@ -381,7 +331,6 @@
 		free_irq(AU1000_IRDA_TX_INT, dev);
 		printk(KERN_ERR "%s: unable to get IRQ %d\n", 
 				dev->name, dev->irq);
-		MOD_DEC_USE_COUNT;
 		return retval;
 	}
 
@@ -418,19 +367,20 @@
 	/* disable the interrupt */
 	free_irq(AU1000_IRDA_TX_INT, dev);
 	free_irq(AU1000_IRDA_RX_INT, dev);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
 static void __exit au1k_irda_exit(void)
 {
 	struct net_device *dev = ir_devs[0];
-	struct au1k_private *aup = (struct au1k_private *) dev->priv;
+	struct au1k_private *aup;
 
 	if (!dev) {
 		printk(KERN_ERR "au1k_ircc no dev found\n");
 		return;
 	}
+
+	aup = (struct au1k_private *) dev->priv;
 	if (aup->db[0].vaddr)  {
 		dma_free((void *)aup->db[0].vaddr, 
 				MAX_BUF_SIZE * 2*NUM_IR_DESC);
@@ -441,10 +391,16 @@
 				2*MAX_NUM_IR_DESC*(sizeof(ring_dest_t)));
 		aup->rx_ring[0] = 0;
 	}
-	rtnl_lock();
-	unregister_netdevice(dev);
-	rtnl_unlock();
+
+	unregister_netdev(dev);
+
+	dma_free((void *)aup->db[0].vaddr, MAX_BUF_SIZE * 2*NUM_IR_DESC);
+	dma_free((void *)aup->rx_ring[0], 
+		 2*MAX_NUM_IR_DESC*(sizeof(ring_dest_t)));
+	kfree(aup->rx_buff.head);
+
 	ir_devs[0] = 0;
+	free_netdev(dev);
 }
 
 
@@ -656,19 +612,21 @@
 }
 
 
-void au1k_irda_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t au1k_irda_interrupt(int irq, void *dev_id, 
+				       struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *) dev_id;
 
 	if (dev == NULL) {
 		printk(KERN_ERR "%s: isr: null dev ptr\n", dev->name);
-		return;
+		return IRQ_NONE;
 	}
 
 	writel(0, IR_INT_CLEAR); /* ack irda interrupts */
 
 	au1k_irda_rx(dev);
 	au1k_tx_ack(dev);
+	return IRQ_HANDLED;
 }
 
 
@@ -859,10 +817,8 @@
 	return &aup->stats;
 }
 
-#ifdef MODULE
 MODULE_AUTHOR("Pete Popov <ppopov@mvista.com>");
 MODULE_DESCRIPTION("Au1000 IrDA Device Driver");
 
 module_init(au1k_irda_init);
 module_exit(au1k_irda_exit);
-#endif /* MODULE */
