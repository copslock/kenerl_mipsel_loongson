Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jun 2003 23:57:26 +0100 (BST)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:49537
	"HELO alpha.total-knowledge.com") by linux-mips.org with SMTP
	id <S8224802AbTF2W5X>; Sun, 29 Jun 2003 23:57:23 +0100
Received: (qmail 26180 invoked from network); 29 Jun 2003 15:51:58 -0000
Received: from unknown (HELO gateway.total-knowledge.com) (12.234.207.60)
  by alpha.total-knowledge.com with SMTP; 29 Jun 2003 15:51:58 -0000
Received: (qmail 30250 invoked by uid 502); 29 Jun 2003 22:57:19 -0000
Date: Sun, 29 Jun 2003 15:57:19 -0700
From: ilya@theIlya.com
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: meth.c
Message-ID: <20030629225719.GH13617@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--w/VI3ydZO+RcZ3Ux
Content-Type: multipart/mixed; boundary="QXO0/MSS4VvK6f+D"
Content-Disposition: inline


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here is what I currently have for my O2 ethernet driver.
It still shows some weired behaviour sometimes, but works well enough to boot
and run O2 over NFS.


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="meth.diff"
Content-Transfer-Encoding: quoted-printable

Index: drivers/net/meth.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/drivers/net/meth.c,v
retrieving revision 1.4
diff -u -r1.4 meth.c
--- drivers/net/meth.c	1 Jul 2002 20:01:25 -0000	1.4
+++ drivers/net/meth.c	29 Jun 2003 22:55:44 -0000
@@ -55,10 +55,6 @@
 MODULE_AUTHOR("Ilya Volynets");
 MODULE_DESCRIPTION("SGI O2 Builtin Fast Ethernet driver");
=20
-/* This is a load-time options */
-/*static int eth =3D 0;
-MODULE_PARM(eth, "i");*/
-
 #define HAVE_TX_TIMEOUT
 /* The maximum time waited (in jiffies) before assuming a Tx failed. (400m=
s) */
 #define TX_TIMEOUT (400*HZ/1000)
@@ -68,15 +64,13 @@
 MODULE_PARM(timeout, "i");
 #endif
=20
-int meth_eth;
-
 /*
  * This structure is private to each device. It is used to pass
  * packets in and out, so there is place for a packet
  */
=20
 typedef struct meth_private {
-    struct net_device_stats stats;
+	struct net_device_stats stats;
 	volatile struct meth_regs *regs;
 	u64 mode; /* in-memory copy of MAC control register */
 	int  phy_addr; /* address of phy, used by mdio_* functions, initialized i=
n mdio_probe*/
@@ -92,12 +86,12 @@
 	dma_addr_t rx_ring_dmas[RX_RING_ENTRIES];
 	int rx_write;
=20
-    spinlock_t meth_lock;
+	spinlock_t meth_lock;
 } meth_private;
=20
 extern struct net_device meth_devs[];
 void meth_tx_timeout (struct net_device *dev);
-void meth_interrupt(int irq, void *dev_id, struct pt_regs *pregs);
+irqreturn_t meth_interrupt(int irq, void *dev_id, struct pt_regs *pregs);
        =20
 /* global, initialized in ip32-setup.c */
 char o2meth_eaddr[8]=3D{0,0,0,0,0,0,0,0};
@@ -109,14 +103,9 @@
 	DPRINTK("Loading MAC Address: %02x:%02x:%02x:%02x:%02x:%02x\n",
 		(int)o2meth_eaddr[0]&0xFF,(int)o2meth_eaddr[1]&0xFF,(int)o2meth_eaddr[2]=
&0xFF,
 		(int)o2meth_eaddr[3]&0xFF,(int)o2meth_eaddr[4]&0xFF,(int)o2meth_eaddr[5]=
&0xFF);
-	//memcpy(dev->dev_addr,o2meth_eaddr+2,6);
 	for (i=3D0; i<6; i++)
 		dev->dev_addr[i]=3Do2meth_eaddr[i];
-	regs->mac_addr=3D //dev->dev_addr[0]|(dev->dev_addr[1]<<8)|
-					//dev->dev_addr[2]<<16|(dev->dev_addr[3]<<24)|
-					//dev->dev_addr[4]<<32|(dev->dev_addr[5]<<40);
-	(*(u64*)o2meth_eaddr)>>16;
-	DPRINTK("MAC, finally is %0lx\n",regs->mac_addr);
+	regs->mac_addr=3D(*(u64*)o2meth_eaddr)>>16;
 }
=20
 /*
@@ -124,19 +113,19 @@
  */
 #define WAIT_FOR_PHY(___regs, ___rval)			\
 	while((___rval=3D___regs->phy_data)&MDIO_BUSY){	\
-		udelay(25);								\
+		udelay(25);				\
 	}
 /*read phy register, return value read */
 static int mdio_read(meth_private *priv,int phyreg)
 {
 	volatile meth_regs* regs=3Dpriv->regs;
 	volatile u32 rval;
-	WAIT_FOR_PHY(regs,rval)
+	WAIT_FOR_PHY(regs,rval);
 	regs->phy_registers=3D(priv->phy_addr<<5)|(phyreg&0x1f);
 	udelay(25);
 	regs->phy_trans_go=3D1;
 	udelay(25);
-	WAIT_FOR_PHY(regs,rval)
+	WAIT_FOR_PHY(regs,rval);
 	return rval&MDIO_DATA_MASK;
 }
=20
@@ -145,14 +134,13 @@
 {
 	volatile meth_regs* regs=3Dpriv->regs;
 	int rval;
-///	DPRINTK("Trying to write value %i to reguster %i\n",val, pfyreg);
-	spin_lock_irq(&priv->meth_lock);
-	WAIT_FOR_PHY(regs,rval)
+	spin_lock(&priv->meth_lock);
+	WAIT_FOR_PHY(regs,rval);
 	regs->phy_registers=3D(priv->phy_addr<<5)|(pfyreg&0x1f);
 	regs->phy_data=3Dval;
 	udelay(25);
-	WAIT_FOR_PHY(regs,rval)
-	spin_unlock_irq(&priv->meth_lock);
+	WAIT_FOR_PHY(regs,rval);
+	spin_unlock(&priv->meth_lock);
 }
=20
 /* Modify phy register using given mask and value */
@@ -165,11 +153,6 @@
 	mdio_write(priv,phyreg,rval);
 }
=20
-/* handle errata data on MDIO bus */
-//static void mdio_errata(meth_private *priv)
-//{
-	/* Hmmm... what the hell is phyerrata? does it come from sys init paramet=
ers in IRIX */
-//}
 static int mdio_probe(meth_private *priv)
 {
 	int i, p2, p3;
@@ -177,25 +160,25 @@
 	/* check if phy is detected already */
 	if(priv->phy_addr>=3D0&&priv->phy_addr<32)
 		return 0;
-	spin_lock_irq(&priv->meth_lock);
+	spin_lock(&priv->meth_lock);
 	for (i=3D0;i<32;++i){
 		priv->phy_addr=3D(char)i;
 		p2=3Dmdio_read(priv,2);
 #ifdef MFE_DEBUG
 		p3=3Dmdio_read(priv,3);
 		switch ((p2<<12)|(p3>>4)){
-			case PHY_QS6612X:
-				DPRINTK("PHY is QS6612X\n");
-				break;
-			case PHY_ICS1889:
-				DPRINTK("PHY is ICS1889\n");
-				break;
-			case PHY_ICS1890:
-				DPRINTK("PHY is ICS1890\n");
-				break;
-			case PHY_DP83840:
-				DPRINTK("PHY is DP83840\n");
-				break;
+		case PHY_QS6612X:
+			DPRINTK("PHY is QS6612X\n");
+			break;
+		case PHY_ICS1889:
+			DPRINTK("PHY is ICS1889\n");
+			break;
+		case PHY_ICS1890:
+			DPRINTK("PHY is ICS1890\n");
+			break;
+		case PHY_DP83840:
+			DPRINTK("PHY is DP83840\n");
+			break;
 		}
 #endif
 		if(p2!=3D0xffff&&p2!=3D0x0000){
@@ -203,7 +186,7 @@
 			break;
 		}
 	}
-	spin_unlock_irq(&priv->meth_lock);
+	spin_unlock(&priv->meth_lock);
 	if(priv->phy_addr<32) {
 		return 0;
 	}
@@ -269,15 +252,9 @@
 static int meth_init_rx_ring(meth_private *priv)
 {
 	int i;
-	DPRINTK("Initializing RX ring\n");
 	for(i=3D0;i<RX_RING_ENTRIES;i++){
-		DPRINTK("\t1:\t%i\t",i);
-		/*if(!(priv->rx_ring[i]=3Dget_free_page(GFP_KERNEL)))
-			return -ENOMEM;
-		DPRINTK("\t2:\t%i\n",i);*/
 		priv->rx_ring[i]=3D(rx_packet*)pci_alloc_consistent(NULL,METH_RX_BUFF_SI=
ZE,&(priv->rx_ring_dmas[i]));
 		/* I'll need to re-sync it after each RX */
-		DPRINTK("\t%p\n",priv->rx_ring[i]);
 		priv->regs->rx_fifo=3Dpriv->rx_ring_dmas[i];
 	}
 	priv->rx_write =3D 0;
@@ -290,8 +267,8 @@
=20
 	/* Remove any pending skb */
 	for (i =3D 0; i < TX_RING_ENTRIES; i++) {
-	  if (priv->tx_skbs[i])
-		dev_kfree_skb(priv->tx_skbs[i]);
+		if (priv->tx_skbs[i])
+			dev_kfree_skb(priv->tx_skbs[i]);
 		priv->tx_skbs[i] =3D NULL;
 	}
 	pci_free_consistent(NULL,
@@ -318,7 +295,6 @@
 	priv->regs->mac_ctrl =3D SGI_MAC_RESET;
 	priv->regs->mac_ctrl =3D 0;
 	udelay(25);
-	DPRINTK("MAC control after reset: %016lx\n", priv->regs->mac_ctrl);
=20
 	/* Load ethernet address */
 	load_eaddr(dev, priv->regs);
@@ -341,7 +317,7 @@
=20
 	/* Now set dma control, but don't enable DMA, yet */
 	priv->regs->dma_ctrl=3D (4 << METH_RX_OFFSET_SHIFT) |
-		              (RX_RING_ENTRIES << METH_RX_DEPTH_SHIFT);
+		(RX_RING_ENTRIES << METH_RX_DEPTH_SHIFT);
=20
 	return(0);
 }
@@ -356,9 +332,20 @@
 {
 	meth_private *priv=3Ddev->priv;
 	volatile meth_regs *regs=3Dpriv->regs;
+	int ret;
=20
-	MOD_INC_USE_COUNT;
+	/* Initialize the hardware */
+	if((ret=3Dmeth_reset(dev)) < 0)
+	        return ret;
+
+	/* Allocate the ring buffers */
+	if((ret=3Dmeth_init_tx_ring(priv))<0||(ret=3Dmeth_init_rx_ring(priv))<0){
+		meth_free_tx_ring(priv);
+		meth_free_rx_ring(priv);
+		return ret;
+	}
=20
+	DPRINTK("Will set dma_ctl now\n");
 	/* Start DMA */
 	regs->dma_ctrl|=3D
 	        METH_DMA_TX_EN|/*METH_DMA_TX_INT_EN|*/
@@ -368,6 +355,7 @@
 		printk(KERN_ERR "%s: Can't get irq %d\n", dev->name, dev->irq);
 		return -EAGAIN;
 	}
+	DPRINTK("About to start queue\n");
 	netif_start_queue(dev);
 	DPRINTK("Opened... DMA control=3D0x%08lx\n", regs->dma_ctrl);
 	return 0;
@@ -375,14 +363,16 @@
=20
 int meth_release(struct net_device *dev)
 {
-    netif_stop_queue(dev); /* can't transmit any more */
+	meth_private *priv=3Ddev->priv;
+	netif_stop_queue(dev); /* can't transmit any more */
 	/* shut down dma */
 	((meth_private*)(dev->priv))->regs->dma_ctrl&=3D
 		~(METH_DMA_TX_EN|METH_DMA_TX_INT_EN|
-		METH_DMA_RX_EN|METH_DMA_RX_INT_EN);
+		  METH_DMA_RX_EN|METH_DMA_RX_INT_EN);
 	free_irq(dev->irq, dev);
-    MOD_DEC_USE_COUNT;
-    return 0;
+	meth_free_tx_ring(priv);
+	meth_free_rx_ring(priv);
+	return 0;
 }
=20
 /*
@@ -390,24 +380,24 @@
  */
 int meth_config(struct net_device *dev, struct ifmap *map)
 {
-    if (dev->flags & IFF_UP) /* can't act on a running interface */
-        return -EBUSY;
+	if (dev->flags & IFF_UP) /* can't act on a running interface */
+		return -EBUSY;
=20
-    /* Don't allow changing the I/O address */
-    if (map->base_addr !=3D dev->base_addr) {
-        printk(KERN_WARNING "meth: Can't change I/O address\n");
-        return -EOPNOTSUPP;
-    }
-
-    /* Allow changing the IRQ */
-    if (map->irq !=3D dev->irq) {
-        printk(KERN_WARNING "meth: Can't change IRQ\n");
-        return -EOPNOTSUPP;
-    }
+	/* Don't allow changing the I/O address */
+	if (map->base_addr !=3D dev->base_addr) {
+		printk(KERN_WARNING "meth: Can't change I/O address\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* Don't allow changing the IRQ */
+	if (map->irq !=3D dev->irq) {
+		printk(KERN_WARNING "meth: Can't change IRQ\n");
+		return -EOPNOTSUPP;
+	}
 	DPRINTK("Configured\n");
=20
-    /* ignore other fields */
-    return 0;
+	/* ignore other fields */
+	return 0;
 }
=20
 /*
@@ -415,49 +405,62 @@
  */
 void meth_rx(struct net_device* dev)
 {
-    struct sk_buff *skb;
-    struct meth_private *priv =3D (struct meth_private *) dev->priv;
+	struct sk_buff *skb;
+	struct meth_private *priv =3D (struct meth_private *) dev->priv;
 	rx_packet *rxb;
-	DPRINTK("RX...\n");
-	// TEMP	while((rxb=3Dpriv->rx_ring[priv->rx_write])->status.raw&0x8000000=
000000000){
-	while((rxb=3Dpriv->rx_ring[priv->rx_write])->status.raw&0x800000000000000=
0){
-	        int len=3Drxb->status.parsed.rx_len - 4; /* omit CRC */
-		DPRINTK("(%i)\n",priv->rx_write);
+	int twptr=3Dpriv->rx_write;
+	u64 status;
+	spin_lock(&(priv->meth_lock));
+	while ((status=3D(rxb=3Dpriv->rx_ring[priv->rx_write])->status.raw)&0x800=
0000000000000)
+	{
+		int len=3D(status&0xFFFF) - 4; /* omit CRC */
 		/* length sanity check */
 		if(len < 60 || len > 1518) {
-		  printk(KERN_DEBUG "%s: bogus packet size: %d, status=3D%#2x.\n",
-			 dev->name, priv->rx_write, rxb->status.raw);
-		  priv->stats.rx_errors++;
-		  priv->stats.rx_length_errors++;
+			printk(KERN_DEBUG "%s: bogus packet size: %d, status=3D%#2lx.\n",
+			       dev->name, priv->rx_write, rxb->status.raw);
+			priv->stats.rx_errors++;
+			priv->stats.rx_length_errors++;
 		}
-		if(!(rxb->status.raw&METH_RX_STATUS_ERRORS)){
+		if(!(status&METH_RX_STATUS_ERRORS)){
 			skb=3Dalloc_skb(len+2,GFP_ATOMIC);/* Should be atomic -- we are in inte=
rrupt */
 			if(!skb){
 				/* Ouch! No memory! Drop packet on the floor */
-				DPRINTK("!!!>>>Ouch! Not enough Memory for RX buffer!\n");
 				priv->stats.rx_dropped++;
 			} else {
 				skb_reserve(skb, 2); /* align IP on 16B boundary */ =20
-    			memcpy(skb_put(skb, len), rxb->buf, len);
-			    /* Write metadata, and then pass to the receive level */
-			    skb->dev =3D dev;
-			    skb->protocol =3D eth_type_trans(skb, dev);
-				//skb->ip_summed =3D CHECKSUM_UNNECESSARY; /* don't check it */
-			  =20
-				DPRINTK("passing packet\n");
-				DPRINTK("len =3D %d rxb->status =3D %x\n",
-					len, rxb->status.raw);
-				netif_rx(skb);
+				memcpy(skb_put(skb, len), rxb->buf, len);
+				/* Write metadata, and then pass to the receive level */
+				skb->dev =3D dev;
+				skb->protocol =3D eth_type_trans(skb, dev);
+			=09
 				dev->last_rx =3D jiffies;
 				priv->stats.rx_packets++;
 				priv->stats.rx_bytes+=3Dlen;
-				DPRINTK("There we go... Whew...\n");
+				netif_rx(skb);
 			}
+		} else {
+			printk(KERN_WARNING "meth: RX error: status=3D0x%016lx\n",status);
+			if(status&METH_RX_ST_RCV_CODE_VIOLATION)
+				printk(KERN_WARNING "Receive Code Violation\n");
+			if(status&METH_RX_ST_CRC_ERR)
+				printk(KERN_WARNING "CRC error\n");
+			if(status&METH_RX_ST_INV_PREAMBLE_CTX)
+				printk(KERN_WARNING "Invalid Preamble Context\n");
+			if(status&METH_RX_ST_LONG_EVT_SEEN)
+				printk(KERN_WARNING "Long Event Seen...\n");
+			if(status&METH_RX_ST_BAD_PACKET)
+				printk(KERN_WARNING "Bad Packet\n");
+			if(status&METH_RX_ST_CARRIER_EVT_SEEN)
+				printk(KERN_WARNING "Carrier Event Seen\n");
 		}
+		rxb->status.raw=3D0;
 		priv->regs->rx_fifo=3Dpriv->rx_ring_dmas[priv->rx_write];
-		rxb->status.raw=3D0;	=09
 		priv->rx_write=3D(priv->rx_write+1)&(RX_RING_ENTRIES-1);
+		if(priv->rx_write=3D=3Dtwptr) {
+			DPRINTK("going rounds\n");
+		}
 	}
+	spin_unlock(&(priv->meth_lock));
 }
=20
 static int meth_tx_full(struct net_device *dev)
@@ -505,20 +508,10 @@
 /*
  * The typical interrupt entry point
  */
-void meth_interrupt(int irq, void *dev_id, struct pt_regs *pregs)
+irqreturn_t meth_interrupt(int irq, void *dev_id, struct pt_regs *pregs)
 {
 	struct meth_private *priv;
-	union {
-		u32	reg; /*Whole status register */
-		struct {
-			u32			:	2,
-				rx_seq	:	5,
-				tx_read	:	9,
-			=09
-				rx_read	:	8,
-				int_mask:	8;
-		} parsed;
-	} status;
+	u32 status;
 	/*
 	 * As usual, check the "device" pointer for shared handlers.
 	 * Then assign "struct device *dev"
@@ -526,33 +519,44 @@
 	struct net_device *dev =3D (struct net_device *)dev_id;
 	/* ... and check with hw if it's really ours */
=20
-	if (!dev /*paranoid*/ ) return;
+	if (!dev /*paranoid*/ ) return IRQ_HANDLED;
=20
-	/* Lock the device */
 	priv =3D (struct meth_private *) dev->priv;
=20
-	status.reg =3D priv->regs->int_flags;
+	status =3D priv->regs->int_flags;
    =20
-	DPRINTK("Interrupt, status %08x...\n",status.reg);
-	if (status.parsed.int_mask & METH_INT_RX_THRESHOLD) {
+	if (status & METH_INT_RX_THRESHOLD) {
 		/* send it to meth_rx for handling */
 		meth_rx(dev);
 	}
=20
-	if (status.parsed.int_mask & (METH_INT_TX_EMPTY|METH_INT_TX_PKT)) {
+	if (status & (METH_INT_TX_EMPTY|METH_INT_TX_PKT)) {
 		/* a transmission is over: free the skb */
-		meth_tx_cleanup(dev, status.parsed.tx_read);
+		meth_tx_cleanup(dev, (priv->regs->tx_info&TX_INFO_RPTR)>>16);
 	}
 	/* check for errors too... */
-	if (status.parsed.int_mask & (METH_INT_TX_LINK_FAIL))
+	if (status & (METH_INT_TX_LINK_FAIL))
 		printk(KERN_WARNING "meth: link failure\n");
-	if (status.parsed.int_mask & (METH_INT_MEM_ERROR))
+	if (status & (METH_INT_MEM_ERROR))
 		printk(KERN_WARNING "meth: memory error\n");
-	if (status.parsed.int_mask & (METH_INT_TX_ABORT))
+	if (status & (METH_INT_TX_ABORT))
 		printk(KERN_WARNING "meth: aborted\n");
-	DPRINTK("Interrupt handling done...\n");
-=09
-	priv->regs->int_flags=3Dstatus.reg&0xff; /* clear interrupts */
+	if (status & (METH_INT_RX_OVERFLOW))
+		printk(KERN_WARNING "meth: RX overflow\n");
+	if (status & (METH_INT_RX_UNDERFLOW))
+		printk(KERN_WARNING "meth: RX underflow\n");
+
+#define METH_INT_ERROR	(METH_INT_TX_LINK_FAIL| \
+			METH_INT_MEM_ERROR| \
+			METH_INT_TX_ABORT| \
+			METH_INT_RX_OVERFLOW| \
+			METH_INT_RX_UNDERFLOW)
+	if( status & METH_INT_ERROR) {
+		printk(KERN_WARNING "meth: error status: 0x%08x\n",status);
+		netif_wake_queue(dev);
+	}
+	priv->regs->int_flags=3Dstatus&0xff; /* clear interrupts */
+	return IRQ_HANDLED;
 }
=20
 /*
@@ -563,13 +567,11 @@
 	tx_packet *desc=3D&priv->tx_ring[priv->tx_write];
 	int len =3D (skb->len<ETH_ZLEN)?ETH_ZLEN:skb->len;
=20
-	DPRINTK("preparing short packet\n");
 	/* maybe I should set whole thing to 0 first... */
 	memcpy(desc->data.dt+(120-len),skb->data,skb->len);
 	if(skb->len < len)
 		memset(desc->data.dt+120-len+skb->len,0,len-skb->len);
 	desc->header.raw=3DMETH_TX_CMD_INT_EN|(len-1)|((128-len)<<16);
-	DPRINTK("desc=3D%016lx\n",desc->header.raw);
 }
 #define TX_CATBUF1 BIT(25)
 static void meth_tx_1page_prepare(meth_private* priv, struct sk_buff* skb)
@@ -580,13 +582,6 @@
 	int buffer_len =3D skb->len - unaligned_len;
 	dma_addr_t catbuf;
=20
-	DPRINTK("preparing 1 page...\n");
-	DPRINTK("length=3D%d data=3D%p\n", skb->len, skb->data);
-	DPRINTK("unaligned_len=3D%d\n", unaligned_len);
-	DPRINTK("buffer_data=3D%p buffer_len=3D%d\n",
-	       buffer_data,
-	       buffer_len);
-
 	desc->header.raw=3DMETH_TX_CMD_INT_EN|TX_CATBUF1|(skb->len-1);
=20
 	/* unaligned part */
@@ -601,11 +596,8 @@
 				buffer_data,
 				buffer_len,
 				PCI_DMA_TODEVICE);
-	DPRINTK("catbuf=3D%x\n", catbuf);
 	desc->data.cat_buf[0].form.start_addr =3D catbuf >> 3;
 	desc->data.cat_buf[0].form.len =3D buffer_len-1;
-	DPRINTK("desc=3D%016lx\n",desc->header.raw);
-	DPRINTK("cat_buf[0].raw=3D%016lx\n",desc->data.cat_buf[0].raw);
 }
 #define TX_CATBUF2 BIT(26)
 static void meth_tx_2page_prepare(meth_private* priv, struct sk_buff* skb)
@@ -618,16 +610,6 @@
 	int buffer2_len =3D skb->len - buffer1_len - unaligned_len;
 	dma_addr_t catbuf1, catbuf2;
=20
-	DPRINTK("preparing 2 pages... \n");
-	DPRINTK("length=3D%d data=3D%p\n", skb->len, skb->data);
-	DPRINTK("unaligned_len=3D%d\n", unaligned_len);
-	DPRINTK("buffer1_data=3D%p buffer1_len=3D%d\n",
-	       buffer1_data,
-	       buffer1_len);
-	DPRINTK("buffer2_data=3D%p buffer2_len=3D%d\n",
-	       buffer2_data,
-	       buffer2_len);
-
 	desc->header.raw=3DMETH_TX_CMD_INT_EN|TX_CATBUF1|TX_CATBUF2|(skb->len-1);
 	/* unaligned part */
 	if(unaligned_len){
@@ -641,7 +623,6 @@
 				 buffer1_data,
 				 buffer1_len,
 				 PCI_DMA_TODEVICE);
-	DPRINTK("catbuf1=3D%x\n", catbuf1);
 	desc->data.cat_buf[0].form.start_addr =3D catbuf1 >> 3;
 	desc->data.cat_buf[0].form.len =3D buffer1_len-1;
 	/* second page */
@@ -649,18 +630,12 @@
 				 buffer2_data,
 				 buffer2_len,
 				 PCI_DMA_TODEVICE);
-	DPRINTK("catbuf2=3D%x\n", catbuf2);
 	desc->data.cat_buf[1].form.start_addr =3D catbuf2 >> 3;
 	desc->data.cat_buf[1].form.len =3D buffer2_len-1;
-	DPRINTK("desc=3D%016lx\n",desc->header.raw);
-	DPRINTK("cat_buf[0].raw=3D%016lx\n",desc->data.cat_buf[0].raw);
-	DPRINTK("cat_buf[1].raw=3D%016lx\n",desc->data.cat_buf[1].raw);
 }
=20
-
 void meth_add_to_tx_ring(meth_private *priv, struct sk_buff* skb)
 {
-	DPRINTK("Transmitting data...\n");
 	if(skb->len <=3D 120) {
 		/* Whole packet fits into descriptor */
 		meth_tx_short_prepare(priv,skb);
@@ -676,7 +651,7 @@
 	/* Remember the skb, so we can free it at interrupt time */
 	priv->tx_skbs[priv->tx_write] =3D skb;
 	priv->tx_write =3D (priv->tx_write+1) & (TX_RING_ENTRIES-1);
-	priv->regs->tx_info.wptr =3D priv->tx_write;
+	priv->regs->tx_info =3D priv->tx_write;
 	priv->tx_count ++;
 	/* Enable DMA transfer */
 	priv->regs->dma_ctrl |=3D METH_DMA_TX_INT_EN;
@@ -689,18 +664,18 @@
 {
 	struct meth_private *priv =3D (struct meth_private *) dev->priv;
=20
-	spin_lock_irq(&priv->meth_lock);
+	spin_lock(&priv->meth_lock);
=20
 	meth_add_to_tx_ring(priv, skb);
 	dev->trans_start =3D jiffies; /* save the timestamp */
=20
 	/* If TX ring is full, tell the upper layer to stop sending packets */
 	if (meth_tx_full(dev)) {
-	        DPRINTK("TX full: stopping\n");
+	        printk("TX full: stopping\n");
 		netif_stop_queue(dev);
 	}
=20
-	spin_unlock_irq(&priv->meth_lock);
+	spin_unlock(&priv->meth_lock);
=20
 	return 0;
 }
@@ -716,9 +691,9 @@
 	printk(KERN_WARNING "%s: transmit timed out\n", dev->name);
=20
 	/* Protect against concurrent rx interrupts */
-	spin_lock_irq(&priv->meth_lock);
+	spin_lock(&priv->meth_lock);
=20
-	/* Try to reset the adaptor. */
+	/* Try to reset the interface. */
 	meth_reset(dev);
=20
 	priv->stats.tx_errors++;
@@ -733,7 +708,7 @@
 	priv->regs->dma_ctrl|=3DMETH_DMA_TX_EN|METH_DMA_RX_EN|METH_DMA_RX_INT_EN;
=20
 	/* Enable interrupt */
-	spin_unlock_irq(&priv->meth_lock);
+	spin_unlock(&priv->meth_lock);
=20
 	dev->trans_start =3D jiffies;
 	netif_wake_queue(dev);
@@ -747,8 +722,8 @@
 int meth_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 =20
-    DPRINTK("ioctl\n");
-    return 0;
+	DPRINTK("ioctl\n");
+	return 0;
 }
=20
 /*
@@ -756,8 +731,8 @@
  */
 struct net_device_stats *meth_stats(struct net_device *dev)
 {
-    struct meth_private *priv =3D (struct meth_private *) dev->priv;
-    return &priv->stats;
+	struct meth_private *priv =3D (struct meth_private *) dev->priv;
+	return &priv->stats;
 }
=20
 /*
@@ -767,7 +742,6 @@
 int meth_init(struct net_device *dev)
 {
 	meth_private *priv;
-	int ret;
 	/*=20
 	 * Then, assign other fields in dev, using ether_setup() and some
 	 * hand assignments
@@ -806,20 +780,9 @@
 	dev->base_addr=3DSGI_MFE;
 	priv->phy_addr =3D -1; /* No phy is known yet... */
=20
-	/* Initialize the hardware */
-	if((ret=3Dmeth_reset(dev)) < 0)
-	        return ret;
-
-	/* Allocate the ring buffers */
-	if((ret=3Dmeth_init_tx_ring(priv))<0||(ret=3Dmeth_init_rx_ring(priv))<0){
-		meth_free_tx_ring(priv);
-		meth_free_rx_ring(priv);
-		return ret;
-	}
-
 	printk("SGI O2 Fast Ethernet rev. %ld\n", priv->regs->mac_ctrl >> 29);
=20
-    return 0;
+	return 0;
 }
=20
 /*
@@ -827,7 +790,7 @@
  */
=20
 struct net_device meth_devs[1] =3D {
-    { init: meth_init, }  /* init, nothing more */
+	{ init: meth_init, }  /* init, nothing more */
 };
=20
 /*
@@ -844,18 +807,15 @@
 		printk("meth: error %i registering device \"%s\"\n",
 		       result, meth_devs->name);
 	else device_present++;
-#ifndef METH_DEBUG
-	EXPORT_NO_SYMBOLS;
-#endif
 =09
 	return device_present ? 0 : -ENODEV;
 }
=20
 void meth_cleanup(void)
 {
-    kfree(meth_devs->priv);
-    unregister_netdev(meth_devs);
-    return;
+	kfree(meth_devs->priv);
+	unregister_netdev(meth_devs);
+	return;
 }
=20
 module_init(meth_init_module);
Index: drivers/net/meth.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/drivers/net/meth.h,v
retrieving revision 1.2
diff -u -r1.2 meth.h
--- drivers/net/meth.h	1 Jul 2002 20:01:25 -0000	1.2
+++ drivers/net/meth.h	29 Jun 2003 22:55:45 -0000
@@ -85,7 +85,7 @@
 } tx_packet;
=20
 typedef union rx_status_vector {
-	struct {
+	volatile struct {
 		u64		pad1:1;/*fill it with ones*/
 		u64		pad2:15;/*fill with 0*/
 		u64		ip_chk_sum:16;
@@ -103,7 +103,7 @@
 		u64		rx_code_violation:1;
 		u64		rx_len:16;
 	} parsed;
-	u64 raw;
+	volatile u64 raw;
 } rx_status_vector;
=20
 typedef struct rx_packet {
@@ -113,6 +113,8 @@
 	char buf[METH_RX_BUFF_SIZE-sizeof(rx_status_vector)-3*sizeof(u64)-sizeof(=
u16)];/* data */
 } rx_packet;
=20
+#define TX_INFO_RPTR    0x00FF0000
+#define TX_INFO_WPTR    0x000000FF
 typedef struct meth_regs {
 	u64		mac_ctrl;		/*0x00,rw,31:0*/
 	u64		int_flags;		/*0x08,rw,30:0*/
@@ -120,10 +122,7 @@
 	u64		timer;			/*0x18,rw,5:0*/
 	u64		int_tx;			/*0x20,wo,0:0*/
 	u64		int_rx;			/*0x28,wo,9:4*/
-	struct {
-		u32 tx_info_pad;
-		u32 rptr:16,wptr:16;
-	}		tx_info;		/*0x30,rw,31:0*/
+	u64             tx_info;		/*0x30,rw,31:0*/
 	u64		tx_info_al;		/*0x38,rw,31:0*/
 	struct {
 		u32	rx_buff_pad1;

--QXO0/MSS4VvK6f+D--

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+/27P7sVBmHZT8w8RAm7iAKCa84SHcecXKPO1jmIK8K873S/1FwCgxwVH
Vc+5o32DkFi4GJkCH/Z+jFI=
=IUrM
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--
