Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 06:55:19 +0100 (BST)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:25228
	"HELO alpha.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225072AbTGPFzQ>; Wed, 16 Jul 2003 06:55:16 +0100
Received: (qmail 10876 invoked from network); 16 Jul 2003 05:55:08 -0000
Received: from unknown (HELO gateway.total-knowledge.com) (12.234.207.60)
  by alpha.total-knowledge.com with SMTP; 16 Jul 2003 05:55:08 -0000
Received: (qmail 24344 invoked by uid 502); 16 Jul 2003 05:55:08 -0000
Date: Tue, 15 Jul 2003 22:55:08 -0700
From: ilya@theIlya.com
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: latest meth driver update
Message-ID: <20030716055508.GA24113@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips

Here is my latest experiments with meth. Quite a few changes have been made.
 - use spin_lock_irq variants instead of spin_lock - thus locking
   is actually doing something now
 - main interrupt routine was rewritten to loop untill evertything that
   can possibly can be handled, is in fact handled. This eliminates
   overhead of taking extra interrupts.
 - Changed Rx handler to preallocate sk_buff's, and DMA data to them
   directly. This has two advantages: No data copying, and no use of
   "coherent" - uncached memory areas.
 - Some other minor cleanups.

The end result is definite improvement - lot fewer Rx ring underruns, higher
speed. However, I still see strange things, which may ore may not be related
to meth. Biggest one is hang during startup: approximately one out of four
times kernel successfully gets IP configuration from DHCP server, mounts NFS
root, and then hangs happily for indefinite period of time trying to start
init. It is not completely dead - if I type something, I see it echoed back
to me on console. Also, if O2 is flooded with bad network packets, I see
messages from meth complaining about them, yet, init never starts.

Anyways, here is the patch, and if you see anything obviously (or not
obviously) stupid, please let me know.

	Ilya
Index: drivers/net/meth.c
===================================================================
RCS file: /home/cvs/linux/drivers/net/meth.c,v
retrieving revision 1.8
diff -u -r1.8 meth.c
--- drivers/net/meth.c	6 Jul 2003 14:16:24 -0000	1.8
+++ drivers/net/meth.c	16 Jul 2003 05:26:29 -0000
@@ -1,7 +1,7 @@
 /*
  * meth.c -- O2 Builtin 10/100 Ethernet driver
  *
- * Copyright (C) 2001 Ilya Volynets
+ * Copyright (C) 2001-2003 Ilya Volynets
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -47,7 +47,7 @@
 #endif
 
 #if MFE_DEBUG>=1
-#define DPRINTK(str,args...) printk (KERN_DEBUG "meth(%ld): %s: " str, jiffies, __FUNCTION__ , ## args)
+#define DPRINTK(str,args...) printk (KERN_DEBUG "meth: %s: " str, __FUNCTION__ , ## args)
 #define MFE_RX_DEBUG 2
 #else
 #define DPRINTK(str,args...)
@@ -77,6 +77,7 @@
 	struct net_device_stats stats;
 	volatile struct meth_regs *regs;
 	u64 mode; /* in-memory copy of MAC control register */
+	u64 dma_ctrl; /* dma control */
 	int  phy_addr; /* address of phy, used by mdio_* functions, initialized in mdio_probe*/
 	tx_packet *tx_ring;
 	dma_addr_t tx_ring_dma;
@@ -88,6 +89,7 @@
 
 	rx_packet *rx_ring[RX_RING_ENTRIES];
 	dma_addr_t rx_ring_dmas[RX_RING_ENTRIES];
+	struct sk_buff *rx_skbs[RX_RING_ENTRIES];
 	int rx_write;
 
 	spinlock_t meth_lock;
@@ -111,7 +113,7 @@
 	regs->mac_addr=(*(u64*)o2meth_eaddr)>>16;
 }
 
-/*
+ /*
  *Waits for BUSY status of mdio bus to clear
  */
 #define WAIT_FOR_PHY(___regs, ___rval)			\
@@ -135,16 +137,16 @@
 static int mdio_probe(meth_private *priv)
 {
 	int i, p2, p3;
-	DPRINTK("Detecting PHY kind\n");
+	unsigned long flags;
 	/* check if phy is detected already */
 	if(priv->phy_addr>=0&&priv->phy_addr<32)
 		return 0;
-	spin_lock(&priv->meth_lock);
+	spin_lock_irqsave(&priv->meth_lock,flags);
 	for (i=0;i<32;++i){
 		priv->phy_addr=(char)i;
 		p2=mdio_read(priv,2);
-#ifdef MFE_DEBUG
 		p3=mdio_read(priv,3);
+#if MFE_DEBUG>=2
 		switch ((p2<<12)|(p3>>4)){
 		case PHY_QS6612X:
 			DPRINTK("PHY is QS6612X\n");
@@ -165,7 +167,7 @@
 			break;
 		}
 	}
-	spin_unlock(&priv->meth_lock);
+	spin_unlock_irqrestore(&priv->meth_lock,flags);
 	if(priv->phy_addr<32) {
 		return 0;
 	}
@@ -213,7 +215,6 @@
 static int meth_init_tx_ring(meth_private *priv)
 {
 	/* Init TX ring */
-	DPRINTK("Initializing TX ring\n");
 	priv->tx_ring = dma_alloc_coherent(NULL, TX_RING_BUFFER_SIZE,
 	                                   &priv->tx_ring_dma, GFP_ATOMIC);
 	if (!priv->tx_ring)
@@ -225,7 +226,6 @@
 	/* Now init skb save area */
 	memset(priv->tx_skbs,0,sizeof(priv->tx_skbs));
 	memset(priv->tx_skb_dmas,0,sizeof(priv->tx_skb_dmas));
-	DPRINTK("Done with TX ring init\n");
 	return 0;
 }
 
@@ -233,13 +233,17 @@
 {
 	int i;
 	for(i=0;i<RX_RING_ENTRIES;i++){
-		priv->rx_ring[i] = dma_alloc_coherent(NULL, METH_RX_BUFF_SIZE,
-		                                      &priv->rx_ring_dmas[i],0);
+		priv->rx_skbs[i]=alloc_skb(METH_RX_BUFF_SIZE,0);
+		/* 8byte status vector+3quad padding + 2byte padding,
+		   to put data on 64bit aligned boundary */
+		skb_reserve(priv->rx_skbs[i],METH_RX_HEAD);
+		priv->rx_ring[i]=(rx_packet*)(priv->rx_skbs[i]->head);
 		/* I'll need to re-sync it after each RX */
+		priv->rx_ring_dmas[i]=dma_map_single(NULL,priv->rx_ring[i],
+						     METH_RX_BUFF_SIZE,DMA_FROM_DEVICE);
 		priv->regs->rx_fifo=priv->rx_ring_dmas[i];
 	}
-	priv->rx_write = 0;
-	DPRINTK("Done with RX ring\n");
+        priv->rx_write = 0;
 	return 0;
 }
 static void meth_free_tx_ring(meth_private *priv)
@@ -255,13 +259,18 @@
 	dma_free_coherent(NULL, TX_RING_BUFFER_SIZE, priv->tx_ring,
 	                  priv->tx_ring_dma);
 }
+
+/* Presumes RX DMA engine is stopped, and RX fifo ring is reset */
 static void meth_free_rx_ring(meth_private *priv)
 {
 	int i;
 
-	for(i=0;i<RX_RING_ENTRIES;i++)
-		dma_free_coherent(NULL, METH_RX_BUFF_SIZE, priv->rx_ring[i],
-		                  priv->rx_ring_dmas[i]);
+	for(i=0;i<RX_RING_ENTRIES;i++) {
+		dma_unmap_single(NULL,priv->rx_ring_dmas[i],METH_RX_BUFF_SIZE,DMA_FROM_DEVICE);
+		priv->rx_ring[i]=0;
+		priv->rx_ring_dmas[i]=0;
+		kfree_skb(priv->rx_skbs[i]);
+	}
 }
 
 int meth_reset(struct net_device *dev)
@@ -289,12 +298,13 @@
 		priv->mode |= METH_PROMISC;
 	priv->regs->mac_ctrl = priv->mode;
 
-	/* Autonegociate speed and duplex mode */
+	/* Autonegotiate speed and duplex mode */
 	meth_check_link(dev);
 
 	/* Now set dma control, but don't enable DMA, yet */
-	priv->regs->dma_ctrl= (4 << METH_RX_OFFSET_SHIFT) |
+	priv->dma_ctrl= (4 << METH_RX_OFFSET_SHIFT) |
 		(RX_RING_ENTRIES << METH_RX_DEPTH_SHIFT);
+	priv->regs->dma_ctrl=priv->dma_ctrl;
 
 	return(0);
 }
@@ -322,30 +332,32 @@
 		return ret;
 	}
 
-	DPRINTK("Will set dma_ctl now\n");
-	/* Start DMA */
-	regs->dma_ctrl|=
-	        METH_DMA_TX_EN|/*METH_DMA_TX_INT_EN|*/
-		METH_DMA_RX_EN|METH_DMA_RX_INT_EN;
-
 	if(request_irq(dev->irq,meth_interrupt,SA_SHIRQ,meth_str,dev)){
 		printk(KERN_ERR "%s: Can't get irq %d\n", dev->name, dev->irq);
 		return -EAGAIN;
 	}
+
+	/* Start DMA */
+	priv->dma_ctrl|=
+	        METH_DMA_TX_EN|/*METH_DMA_TX_INT_EN|*/
+		METH_DMA_RX_EN|METH_DMA_RX_INT_EN;
+	regs->dma_ctrl=priv->dma_ctrl;
+
 	DPRINTK("About to start queue\n");
 	netif_start_queue(dev);
-	DPRINTK("Opened... DMA control=0x%08lx\n", regs->dma_ctrl);
 	return 0;
 }
 
 int meth_release(struct net_device *dev)
 {
 	meth_private *priv=dev->priv;
+	DPRINTK("Stopping queue\n");
 	netif_stop_queue(dev); /* can't transmit any more */
 	/* shut down dma */
-	((meth_private*)(dev->priv))->regs->dma_ctrl&=
+	priv->dma_ctrl&=
 		~(METH_DMA_TX_EN|METH_DMA_TX_INT_EN|
 		  METH_DMA_RX_EN|METH_DMA_RX_INT_EN);
+	priv->regs->dma_ctrl=priv->dma_ctrl;
 	free_irq(dev->irq, dev);
 	meth_free_tx_ring(priv);
 	meth_free_rx_ring(priv);
@@ -380,42 +392,67 @@
 /*
  * Receive a packet: retrieve, encapsulate and pass over to upper levels
  */
-void meth_rx(struct net_device* dev)
+void meth_rx(struct net_device* dev,u64 int_status)
 {
 	struct sk_buff *skb;
 	struct meth_private *priv = (struct meth_private *) dev->priv;
-	rx_packet *rxb;
-	int twptr=priv->rx_write;
-	u64 status;
-	spin_lock(&(priv->meth_lock));
-	while ((status=(rxb=priv->rx_ring[priv->rx_write])->status.raw)&0x8000000000000000)
-	{
-		int len=(status&0xFFFF) - 4; /* omit CRC */
-		/* length sanity check */
-		if(len < 60 || len > 1518) {
-			printk(KERN_DEBUG "%s: bogus packet size: %d, status=%#2lx.\n",
-			       dev->name, priv->rx_write, rxb->status.raw);
-			priv->stats.rx_errors++;
-			priv->stats.rx_length_errors++;
+	unsigned int fifo_rptr=(int_status&METH_INT_RX_RPTR_MASK)>>8;
+	unsigned int flags;
+	spin_lock_irqsave(&priv->meth_lock,flags);
+	priv->dma_ctrl&=~METH_DMA_RX_INT_EN;
+	priv->regs->dma_ctrl=priv->dma_ctrl;
+	spin_unlock_irqrestore(&priv->meth_lock,flags);
+
+	if (int_status & METH_INT_RX_UNDERFLOW){
+		fifo_rptr=(fifo_rptr-1)&(0xF);
+	}
+	while(priv->rx_write != fifo_rptr) {
+		u64 status;
+		dma_unmap_single(NULL,priv->rx_ring_dmas[priv->rx_write],
+				 METH_RX_BUFF_SIZE,DMA_FROM_DEVICE);
+		status=priv->rx_ring[priv->rx_write]->status.raw;
+#if MFE_DEBUG
+		if(!(status&METH_RX_ST_VALID)) {
+			DPRINTK("Not received? status=%016lx\n",status);
 		}
-		if(!(status&METH_RX_STATUS_ERRORS)){
-			skb=alloc_skb(len+2,GFP_ATOMIC);/* Should be atomic -- we are in interrupt */
-			if(!skb){
-				/* Ouch! No memory! Drop packet on the floor */
-				priv->stats.rx_dropped++;
+#endif
+		if((!(status&METH_RX_STATUS_ERRORS))&&(status&METH_RX_ST_VALID)){
+			int len=(status&0xFFFF) - 4; /* omit CRC */
+			/* length sanity check */
+			if(len < 60 || len > 1518) {
+				printk(KERN_DEBUG "%s: bogus packet size: %d, status=%#2lx.\n",
+				       dev->name, priv->rx_write,
+				       priv->rx_ring[priv->rx_write]->status.raw);
+				priv->stats.rx_errors++;
+				priv->stats.rx_length_errors++;
+				skb=priv->rx_skbs[priv->rx_write];
 			} else {
-				skb_reserve(skb, 2); /* align IP on 16B boundary */  
-				memcpy(skb_put(skb, len), rxb->buf, len);
-				/* Write metadata, and then pass to the receive level */
-				skb->dev = dev;
-				skb->protocol = eth_type_trans(skb, dev);
-				
-				dev->last_rx = jiffies;
-				priv->stats.rx_packets++;
-				priv->stats.rx_bytes+=len;
-				netif_rx(skb);
+				skb=alloc_skb(METH_RX_BUFF_SIZE,GFP_ATOMIC|GFP_DMA);
+				if(!skb){
+					/* Ouch! No memory! Drop packet on the floor */
+					DPRINTK("No mem: dropping packet\n");
+					priv->stats.rx_dropped++;
+					skb=priv->rx_skbs[priv->rx_write];
+				} else {
+					struct sk_buff *skb_c=priv->rx_skbs[priv->rx_write];
+					/* 8byte status vector+3quad padding + 2byte padding,
+					   to put data on 64bit aligned boundary */
+					skb_reserve(skb,METH_RX_HEAD);
+					/* Write metadata, and then pass to the receive level */
+					skb_put(skb_c,len);
+					priv->rx_skbs[priv->rx_write]=skb;
+					skb_c->dev = dev;
+					skb_c->protocol = eth_type_trans(skb_c, dev);
+					dev->last_rx = jiffies;
+					priv->stats.rx_packets++;
+					priv->stats.rx_bytes+=len;
+					netif_rx(skb_c);
+				}
 			}
 		} else {
+			priv->stats.rx_errors++;
+			skb=priv->rx_skbs[priv->rx_write];
+#if MFE_DEBUG>0
 			printk(KERN_WARNING "meth: RX error: status=0x%016lx\n",status);
 			if(status&METH_RX_ST_RCV_CODE_VIOLATION)
 				printk(KERN_WARNING "Receive Code Violation\n");
@@ -429,15 +466,21 @@
 				printk(KERN_WARNING "Bad Packet\n");
 			if(status&METH_RX_ST_CARRIER_EVT_SEEN)
 				printk(KERN_WARNING "Carrier Event Seen\n");
+#endif
 		}
-		rxb->status.raw=0;
+		priv->rx_ring[priv->rx_write]=(rx_packet*)skb->head;
+		priv->rx_ring[priv->rx_write]->status.raw=0;
+		priv->rx_ring_dmas[priv->rx_write]=dma_map_single(NULL,priv->rx_ring[priv->rx_write],
+								  METH_RX_BUFF_SIZE,DMA_FROM_DEVICE);
 		priv->regs->rx_fifo=priv->rx_ring_dmas[priv->rx_write];
-		priv->rx_write=(priv->rx_write+1)&(RX_RING_ENTRIES-1);
-		if(priv->rx_write==twptr) {
-			DPRINTK("going rounds\n");
-		}
+		ADVANCE_RX_PTR(priv->rx_write);
 	}
-	spin_unlock(&(priv->meth_lock));
+	spin_lock_irqsave(&priv->meth_lock,flags);
+	/* In case there was underflow, and Rx DMA was disabled */
+	priv->dma_ctrl|=METH_DMA_RX_INT_EN|METH_DMA_RX_EN;
+	priv->regs->dma_ctrl=priv->dma_ctrl;
+	priv->regs->int_flags=METH_INT_RX_THRESHOLD;
+	spin_unlock_irqrestore(&priv->meth_lock,flags);
 }
 
 static int meth_tx_full(struct net_device *dev)
@@ -447,16 +490,19 @@
 	return(priv->tx_count >= TX_RING_ENTRIES-1);
 }
 
-void meth_tx_cleanup(struct net_device* dev, int rptr)
+void meth_tx_cleanup(struct net_device* dev, int int_status)
 {
 	meth_private *priv=dev->priv;
 	tx_packet* status;
 	struct sk_buff *skb;
+	unsigned long flags;
+	int rptr=(int_status&TX_INFO_RPTR)>>16;
 
-	spin_lock(&priv->meth_lock);
+	spin_lock_irqsave(&priv->meth_lock,flags);
 
-	/* Stop DMA */
-	priv->regs->dma_ctrl &= ~(METH_DMA_TX_INT_EN);
+	/* Stop DMA notification */
+	priv->dma_ctrl &= ~(METH_DMA_TX_INT_EN);
+	priv->regs->dma_ctrl=priv->dma_ctrl;
 
 	while(priv->tx_read != rptr){
 		skb = priv->tx_skbs[priv->tx_read];
@@ -479,7 +525,41 @@
 		netif_wake_queue(dev);
 	}
 
-	spin_unlock(priv->meth_lock);
+	priv->regs->int_flags=METH_INT_TX_EMPTY|METH_INT_TX_PKT;
+	spin_unlock_irqrestore(&priv->meth_lock,flags);
+}
+
+static void meth_error(struct net_device* dev, u32 status)
+{
+	struct meth_private *priv;
+	priv = (struct meth_private *) dev->priv;
+
+	printk(KERN_WARNING "meth: error status: 0x%08x\n",status);
+	/* check for errors too... */
+	if (status & (METH_INT_TX_LINK_FAIL))
+		printk(KERN_WARNING "meth: link failure\n");
+	/* Should I do full reset in this case? */
+	if (status & (METH_INT_MEM_ERROR))
+		printk(KERN_WARNING "meth: memory error\n");
+	if (status & (METH_INT_TX_ABORT))
+		printk(KERN_WARNING "meth: aborted\n");
+	if (status & (METH_INT_RX_OVERFLOW))
+		printk(KERN_WARNING "meth: Rx overflow\n");
+	if (status & (METH_INT_RX_UNDERFLOW)) {
+		unsigned long flags;
+		printk(KERN_WARNING "meth: Rx underflow\n");
+		spin_lock_irqsave(&priv->meth_lock,flags);
+		priv->regs->int_flags=METH_INT_RX_UNDERFLOW;
+		/* more underflow interrupts will be delivered, 
+		   effectively throwing us into an infinite loop.
+		   Thus I stop processing Rx in this case.
+		*/
+		priv->dma_ctrl&=~METH_DMA_RX_EN;
+		priv->regs->dma_ctrl=priv->dma_ctrl;
+		DPRINTK("Disabled meth Rx DMA temporarily\n");
+		spin_unlock_irqrestore(&priv->meth_lock,flags);
+	}
+	priv->regs->int_flags=METH_INT_ERROR;
 }
 
 /*
@@ -489,50 +569,37 @@
 {
 	struct meth_private *priv;
 	u32 status;
+
 	/*
 	 * As usual, check the "device" pointer for shared handlers.
 	 * Then assign "struct device *dev"
 	 */
 	struct net_device *dev = (struct net_device *)dev_id;
-	/* ... and check with hw if it's really ours */
-
-	if (!dev /*paranoid*/ ) return IRQ_HANDLED;
 
 	priv = (struct meth_private *) dev->priv;
 
 	status = priv->regs->int_flags;
-    
-	if (status & (METH_INT_RX_THRESHOLD|METH_INT_RX_UNDERFLOW)) {
-		/* send it to meth_rx for handling */
-		meth_rx(dev);
+	while (status&0xFF) {
+		/* First handle errors - if we get Rx underflow,
+		   Rx DMA will be disabled, and Rx handler will reenable
+		   it. I don't think it's possible to get Rx underflow,
+		   without getting Rx interrupt */
+		if( status & METH_INT_ERROR) {
+			meth_error(dev,status);
+		}
+		if (status & (METH_INT_TX_EMPTY|METH_INT_TX_PKT)) {
+			/* a transmission is over: free the skb */
+			meth_tx_cleanup(dev, status);
+		}
+		if (status & METH_INT_RX_THRESHOLD) {
+			if(!(priv->dma_ctrl&METH_DMA_RX_INT_EN))
+				break;
+			/* send it to meth_rx for handling */
+			meth_rx(dev,status);
+		}
+ 		status = priv->regs->int_flags;
 	}
 
-	if (status & (METH_INT_TX_EMPTY|METH_INT_TX_PKT)) {
-		/* a transmission is over: free the skb */
-		meth_tx_cleanup(dev, (priv->regs->tx_info&TX_INFO_RPTR)>>16);
-	}
-	/* check for errors too... */
-	if (status & (METH_INT_TX_LINK_FAIL))
-		printk(KERN_WARNING "meth: link failure\n");
-	if (status & (METH_INT_MEM_ERROR))
-		printk(KERN_WARNING "meth: memory error\n");
-	if (status & (METH_INT_TX_ABORT))
-		printk(KERN_WARNING "meth: aborted\n");
-	if (status & (METH_INT_RX_OVERFLOW))
-		printk(KERN_WARNING "meth: RX overflow\n");
-	if (status & (METH_INT_RX_UNDERFLOW))
-		printk(KERN_WARNING "meth: RX underflow\n");
-
-#define METH_INT_ERROR	(METH_INT_TX_LINK_FAIL| \
-			METH_INT_MEM_ERROR| \
-			METH_INT_TX_ABORT| \
-			METH_INT_RX_OVERFLOW| \
-			METH_INT_RX_UNDERFLOW)
-	if( status & METH_INT_ERROR) {
-		printk(KERN_WARNING "meth: error status: 0x%08x\n",status);
-		netif_wake_queue(dev);
-	}
-	priv->regs->int_flags=status&0xff; /* clear interrupts */
 	return IRQ_HANDLED;
 }
 
@@ -624,8 +691,6 @@
 	priv->tx_write = (priv->tx_write+1) & (TX_RING_ENTRIES-1);
 	priv->regs->tx_info = priv->tx_write;
 	priv->tx_count ++;
-	/* Enable DMA transfer */
-	priv->regs->dma_ctrl |= METH_DMA_TX_INT_EN;
 }
 
 /*
@@ -634,19 +699,28 @@
 int meth_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct meth_private *priv = (struct meth_private *) dev->priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->meth_lock,flags);
+	/* Stop DMA notification */
+	priv->dma_ctrl &= ~(METH_DMA_TX_INT_EN);
+	priv->regs->dma_ctrl=priv->dma_ctrl;
 
-	spin_lock(&priv->meth_lock);
 
 	meth_add_to_tx_ring(priv, skb);
 	dev->trans_start = jiffies; /* save the timestamp */
 
 	/* If TX ring is full, tell the upper layer to stop sending packets */
 	if (meth_tx_full(dev)) {
-	        printk("TX full: stopping\n");
+	        printk(KERN_DEBUG "TX full: stopping\n");
 		netif_stop_queue(dev);
 	}
 
-	spin_unlock(&priv->meth_lock);
+	/* Restart DMA notification */
+	priv->dma_ctrl |= METH_DMA_TX_INT_EN;
+	  priv->regs->dma_ctrl=priv->dma_ctrl;
+
+	spin_unlock_irqrestore(&priv->meth_lock,flags);
 
 	return 0;
 }
@@ -658,11 +732,12 @@
 void meth_tx_timeout (struct net_device *dev)
 {
 	struct meth_private *priv = (struct meth_private *) dev->priv;
-	
+	unsigned long flags;
+
 	printk(KERN_WARNING "%s: transmit timed out\n", dev->name);
 
 	/* Protect against concurrent rx interrupts */
-	spin_lock(&priv->meth_lock);
+	spin_lock_irqsave(&priv->meth_lock,flags);
 
 	/* Try to reset the interface. */
 	meth_reset(dev);
@@ -676,10 +751,11 @@
 	meth_init_rx_ring(priv);
 
 	/* Restart dma */
-	priv->regs->dma_ctrl|=METH_DMA_TX_EN|METH_DMA_RX_EN|METH_DMA_RX_INT_EN;
+	priv->dma_ctrl|=METH_DMA_TX_EN|METH_DMA_RX_EN|METH_DMA_RX_INT_EN;
+	priv->regs->dma_ctrl=priv->dma_ctrl;
 
 	/* Enable interrupt */
-	spin_unlock(&priv->meth_lock);
+	spin_unlock_irqrestore(&priv->meth_lock,flags);
 
 	dev->trans_start = jiffies;
 	netif_wake_queue(dev);
Index: drivers/net/meth.h
===================================================================
RCS file: /home/cvs/linux/drivers/net/meth.h,v
retrieving revision 1.3
diff -u -r1.3 meth.h
--- drivers/net/meth.h	30 Jun 2003 04:09:29 -0000	1.3
+++ drivers/net/meth.h	16 Jul 2003 05:26:30 -0000
@@ -27,6 +27,7 @@
 #define TX_RING_BUFFER_SIZE	(TX_RING_ENTRIES*sizeof(tx_packet))
 #define RX_BUFFER_SIZE 1546 /* ethenet packet size */
 #define METH_RX_BUFF_SIZE 4096
+#define METH_RX_HEAD 34 /* status + 3 quad garbage-fill + 2 byte zero-pad */
 #define RX_BUFFER_OFFSET (sizeof(rx_status_vector)+2) /* staus vector + 2 bytes of padding */
 #define RX_BUCKET_SIZE 256
 
@@ -124,13 +125,7 @@
 	u64		int_rx;			/*0x28,wo,9:4*/
 	u64             tx_info;		/*0x30,rw,31:0*/
 	u64		tx_info_al;		/*0x38,rw,31:0*/
-	struct {
-		u32	rx_buff_pad1;
-		u32	rx_buff_pad2:8,
-			wptr:8,
-			rptr:8,
-			depth:8;
-	}		rx_buff;		/*0x40,ro,23:0*/
+	u64             rx_buff;		/*0x40,ro,23:0*/
 	u64		rx_buff_al1;	/*0x48,ro,23:0*/
 	u64		rx_buff_al2;	/*0x50,ro,23:0*/
 	u64		int_update;		/*0x58,wo,31:0*/
@@ -202,9 +197,14 @@
 #define METH_DMA_RX_EN BIT(15) /* Enable RX */
 #define METH_DMA_RX_INT_EN BIT(9) /* Enable interrupt on RX packet */
 
+/* RX FIFO MCL Info bits */
+#define METH_RX_FIFO_WPTR(x)   ((x>>16)&0xF)
+#define METH_RX_FIFO_RPTR(x)   ((x>>8)&0xF)
+#define METH_RX_FIFO_DEPTH(x)  (x&0x1F)
 
 /* RX status bits */
 
+#define METH_RX_ST_VALID BIT(63)
 #define METH_RX_ST_RCV_CODE_VIOLATION BIT(16)
 #define METH_RX_ST_DRBL_NBL BIT(17)
 #define METH_RX_ST_CRC_ERR BIT(18)
@@ -239,7 +239,8 @@
 #define METH_INT_RX_UNDERFLOW	BIT(6)	/* 0: No interrupt pending, 1: FIFO was empty, packet could not be queued */
 #define METH_INT_RX_OVERFLOW		BIT(7)	/* 0: No interrupt pending, 1: DMA FIFO Overflow, DMA stopped, FATAL */
 
-#define METH_INT_RX_RPTR_MASK 0x0001F00		/* Bits 8 through 12 alias of RX read-pointer */
+/*#define METH_INT_RX_RPTR_MASK 0x0001F00*/		/* Bits 8 through 12 alias of RX read-pointer */
+#define METH_INT_RX_RPTR_MASK 0x0000F00		/* Bits 8 through 11 alias of RX read-pointer - so, is Rx FIFO 16 or 32 entry?*/
 
 						/* Bits 13 through 15 are always 0. */
 
@@ -248,11 +249,11 @@
 #define METH_INT_SEQ_MASK    0x2E000000	        /* Bits 25 through 29 are the starting seq number for the message at the */
 						/* top of the queue */
 
-#define METH_ERRORS ( \
-	METH_INT_RX_OVERFLOW|	\
-	METH_INT_RX_UNDERFLOW|	\
-	METH_INT_MEM_ERROR|			\
-	METH_INT_TX_ABORT)
+#define METH_INT_ERROR	(METH_INT_TX_LINK_FAIL| \
+			METH_INT_MEM_ERROR| \
+			METH_INT_TX_ABORT| \
+			METH_INT_RX_OVERFLOW| \
+			METH_INT_RX_UNDERFLOW)
 
 #define METH_INT_MCAST_HASH		BIT(30) /* If RX DMA is enabled the hash select logic output is latched here */
 
@@ -270,3 +271,5 @@
 #define PHY_ICS1889    0x0015F41    /* ICS FX */
 #define PHY_ICS1890    0x0015F42    /* ICS TX */
 #define PHY_DP83840    0x20005C0    /* National TX */
+
+#define ADVANCE_RX_PTR(x)  x=(x+1)&(RX_RING_ENTRIES-1)
