Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2006 04:31:02 +0000 (GMT)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:9611 "EHLO
	duck.specifix.com") by ftp.linux-mips.org with ESMTP
	id S8133399AbWCJEam (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Mar 2006 04:30:42 +0000
Received: from localhost.localdomain (duck.corp.specifix.com [192.168.1.1])
	by duck.specifix.com (Postfix) with ESMTP
	id 3B2E7FC53; Thu,  9 Mar 2006 20:39:14 -0800 (PST)
Date:	Thu, 09 Mar 2006 22:42:21 -0600
From:	"Tom Rix" <trix@specifix.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: [PATCH] Broadcom Sibyte SB1xxx NAPI ethernet support
Cc:	"Mark E Mason" <mark.e.mason@broadcom.com>
References: <20060309060606.GA16963@deprecation.cyrius.com> <op.s544y1x4thfl8t@localhost.localdomain>
Organization: specifix
Content-Type: multipart/mixed; boundary=----------WDAN2car0kumta6zzcvcjH
MIME-Version: 1.0
Message-ID: <op.s56kmdy3thfl8t@localhost.localdomain>
In-Reply-To: <op.s544y1x4thfl8t@localhost.localdomain>
User-Agent: Opera M2/8.51 (Linux, build 1462)
Return-Path: <trix@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trix@specifix.com
Precedence: bulk
X-list: linux-mips

------------WDAN2car0kumta6zzcvcjH
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 8bit

This patch adds NAPI support for the Broadcom Sibyte SB1xxx family.  The  
changes are limited to adding a new config key SBMAC_NAPI to the  
drivers/net/Kconfig and by adding the poll op and interrupt support to  
drivers/net/sb1250-mac.c.

This patch also has a fix to drivers/net/sb1250-mac.c, the dma descriptor  
table ptr is allocated, aligned and the aligned ptr is freed.  If the ptr  
was not already aligned (usually is) then the free would not work of what  
was returned by the kmalloc. A variable was added to store the unaligned  
pointer so that it could be properly freed.

I have tested this patch on a BCM91250A-SWARM Pass 2 / An.

Mark Mason from Broadcom was very helpful and tested this patch on at  
least a 1480.

Tom






------------WDAN2car0kumta6zzcvcjH
Content-Disposition: attachment; filename=mips-sb1250-mac-NAPI-3.patch.txt
Content-Type: text/plain; name=mips-sb1250-mac-NAPI-3.patch.txt
Content-Transfer-Encoding: 8bit

diff -rup a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2006-03-09 04:25:38.000000000 -0600
+++ b/drivers/net/Kconfig	2006-03-09 05:30:48.000000000 -0600
@@ -2008,10 +2008,6 @@ config R8169_NAPI
 
 	  If in doubt, say N.
 
-config NET_SB1250_MAC
-	tristate "SB1250 Ethernet support"
-	depends on SIBYTE_SB1xxx_SOC
-
 config R8169_VLAN
 	bool "VLAN support"
 	depends on R8169 && VLAN_8021Q
@@ -2021,6 +2017,27 @@ config R8169_VLAN
 	  
 	  If in doubt, say Y.
 
+config NET_SB1250_MAC
+	tristate "SB1250 Ethernet support"
+	depends on SIBYTE_SB1xxx_SOC
+
+config SBMAC_NAPI
+	bool "Use Rx Polling (NAPI) (EXPERIMENTAL)"
+	depends on NET_SB1250_MAC && EXPERIMENTAL
+	help
+	  NAPI is a new driver API designed to reduce CPU and interrupt load
+	  when the driver is receiving lots of packets from the card. It is
+	  still somewhat experimental and thus not yet enabled by default.
+
+	  If your estimated Rx load is 10kpps or more, or if the card will be
+	  deployed on potentially unfriendly networks (e.g. in a firewall),
+	  then say Y here.
+
+	  See <file:Documentation/networking/NAPI_HOWTO.txt> for more
+	  information.
+
+	  If in doubt, say y.
+
 config SIS190
 	tristate "SiS190/SiS191 gigabit ethernet support"
 	depends on PCI
diff -rup a/drivers/net/sb1250-mac.c b/drivers/net/sb1250-mac.c
--- a/drivers/net/sb1250-mac.c	2006-03-09 04:25:41.000000000 -0600
+++ b/drivers/net/sb1250-mac.c	2006-03-09 05:30:52.000000000 -0600
@@ -209,6 +209,7 @@ typedef struct sbmacdma_s {
 	 * This stuff is for maintenance of the ring
 	 */
 
+	sbdmadscr_t     *sbdma_dscrtable_unaligned; 
 	sbdmadscr_t     *sbdma_dscrtable;	/* base of descriptor table */
 	sbdmadscr_t     *sbdma_dscrtable_end; /* end of descriptor table */
 
@@ -291,8 +292,8 @@ static int sbdma_add_rcvbuffer(sbmacdma_
 static int sbdma_add_txbuffer(sbmacdma_t *d,struct sk_buff *m);
 static void sbdma_emptyring(sbmacdma_t *d);
 static void sbdma_fillring(sbmacdma_t *d);
-static void sbdma_rx_process(struct sbmac_softc *sc,sbmacdma_t *d);
-static void sbdma_tx_process(struct sbmac_softc *sc,sbmacdma_t *d);
+static int sbdma_rx_process(struct sbmac_softc *sc,sbmacdma_t *d, int poll);
+static void sbdma_tx_process(struct sbmac_softc *sc,sbmacdma_t *d, int poll);
 static int sbmac_initctx(struct sbmac_softc *s);
 static void sbmac_channel_start(struct sbmac_softc *s);
 static void sbmac_channel_stop(struct sbmac_softc *s);
@@ -313,6 +314,10 @@ static struct net_device_stats *sbmac_ge
 static void sbmac_set_rx_mode(struct net_device *dev);
 static int sbmac_mii_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static int sbmac_close(struct net_device *dev);
+#if defined (CONFIG_SBMAC_NAPI)
+static int sbmac_poll(struct net_device *poll_dev, int *budget);
+#endif
+
 static int sbmac_mii_poll(struct sbmac_softc *s,int noisy);
 static int sbmac_mii_probe(struct net_device *dev);
 
@@ -740,7 +745,7 @@ static void sbdma_initctx(sbmacdma_t *d,
 
 	d->sbdma_maxdescr = maxdescr;
 
-	d->sbdma_dscrtable = (sbdmadscr_t *)
+	d->sbdma_dscrtable_unaligned = d->sbdma_dscrtable = (sbdmadscr_t *)
 		kmalloc((d->sbdma_maxdescr+1)*sizeof(sbdmadscr_t), GFP_KERNEL);
 
 	/*
@@ -782,7 +787,6 @@ static void sbdma_initctx(sbmacdma_t *d,
 		d->sbdma_int_timeout = 0;
 	}
 #endif
-
 }
 
 /**********************************************************************
@@ -1150,13 +1154,14 @@ static void sbdma_fillring(sbmacdma_t *d
  *  	   nothing
  ********************************************************************* */
 
-static void sbdma_rx_process(struct sbmac_softc *sc,sbmacdma_t *d)
+static int sbdma_rx_process(struct sbmac_softc *sc,sbmacdma_t *d, int poll)
 {
 	int curidx;
 	int hwidx;
 	sbdmadscr_t *dsc;
 	struct sk_buff *sb;
 	int len;
+	int work_done = 0;
 
 	for (;;) {
 		/*
@@ -1234,8 +1239,15 @@ static void sbdma_rx_process(struct sbma
 						sb->ip_summed = CHECKSUM_NONE;
 					}
 				}
-
+				
+#if defined(CONFIG_SBMAC_NAPI)
+				if (0 == poll)
+					netif_rx(sb);
+				else
+					netif_receive_skb(sb);
+#else
 				netif_rx(sb);
+#endif				
 			}
 		} else {
 			/*
@@ -1252,8 +1264,9 @@ static void sbdma_rx_process(struct sbma
 		 */
 
 		d->sbdma_remptr = SBDMA_NEXTBUF(d,sbdma_remptr);
-
+		work_done++;
 	}
+	return work_done;
 }
 
 
@@ -1275,15 +1288,22 @@ static void sbdma_rx_process(struct sbma
  *  	   nothing
  ********************************************************************* */
 
-static void sbdma_tx_process(struct sbmac_softc *sc,sbmacdma_t *d)
+static void sbdma_tx_process(struct sbmac_softc *sc,sbmacdma_t *d, int poll)
 {
 	int curidx;
 	int hwidx;
 	sbdmadscr_t *dsc;
 	struct sk_buff *sb;
 	unsigned long flags;
+	int packets_handled = 0;
 
 	spin_lock_irqsave(&(sc->sbm_lock), flags);
+	
+	if (d->sbdma_remptr == d->sbdma_addptr)
+		goto end_unlock;
+
+	hwidx = (int) (((__raw_readq(d->sbdma_curdscr) & M_DMA_CURDSCR_ADDR) -
+			d->sbdma_dscrtable_phys) / sizeof(sbdmadscr_t));
 
 	for (;;) {
 		/*
@@ -1298,15 +1318,12 @@ static void sbdma_tx_process(struct sbma
 		 */
 
 		curidx = d->sbdma_remptr - d->sbdma_dscrtable;
-		hwidx = (int) (((__raw_readq(d->sbdma_curdscr) & M_DMA_CURDSCR_ADDR) -
-				d->sbdma_dscrtable_phys) / sizeof(sbdmadscr_t));
 
 		/*
 		 * If they're the same, that means we've processed all
 		 * of the descriptors up to (but not including) the one that
 		 * the hardware is working on right now.
 		 */
-
 		if (curidx == hwidx)
 			break;
 
@@ -1337,6 +1354,7 @@ static void sbdma_tx_process(struct sbma
 
 		d->sbdma_remptr = SBDMA_NEXTBUF(d,sbdma_remptr);
 
+		packets_handled++;
 	}
 
 	/*
@@ -1344,15 +1362,15 @@ static void sbdma_tx_process(struct sbma
 	 * Other drivers seem to do this when we reach a low
 	 * watermark on the transmit queue.
 	 */
+	
+	if (packets_handled)
+		netif_wake_queue(d->sbdma_eth->sbm_dev);
 
-	netif_wake_queue(d->sbdma_eth->sbm_dev);
-
+ end_unlock:
 	spin_unlock_irqrestore(&(sc->sbm_lock), flags);
 
 }
 
-
-
 /**********************************************************************
  *  SBMAC_INITCTX(s)
  *
@@ -1396,7 +1414,6 @@ static int sbmac_initctx(struct sbmac_so
 	 * Initialize the DMA channels.  Right now, only one per MAC is used
 	 * Note: Only do this _once_, as it allocates memory from the kernel!
 	 */
-
 	sbdma_initctx(&(s->sbm_txdma),s,0,DMA_TX,SBMAC_MAX_TXDESCR);
 	sbdma_initctx(&(s->sbm_rxdma),s,0,DMA_RX,SBMAC_MAX_RXDESCR);
 
@@ -1420,9 +1437,9 @@ static int sbmac_initctx(struct sbmac_so
 
 static void sbdma_uninitctx(struct sbmacdma_s *d)
 {
-	if (d->sbdma_dscrtable) {
-		kfree(d->sbdma_dscrtable);
-		d->sbdma_dscrtable = NULL;
+	if (d->sbdma_dscrtable_unaligned) {
+		kfree(d->sbdma_dscrtable_unaligned);
+		d->sbdma_dscrtable_unaligned = d->sbdma_dscrtable = NULL;
 	}
 
 	if (d->sbdma_ctxtable) {
@@ -1609,12 +1626,12 @@ static void sbmac_channel_start(struct s
 
 #if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
 	__raw_writeq(M_MAC_RXDMA_EN0 |
-		       M_MAC_TXDMA_EN0, s->sbm_macenable);
+		     M_MAC_TXDMA_EN0, s->sbm_macenable);
 #elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
 	__raw_writeq(M_MAC_RXDMA_EN0 |
-		       M_MAC_TXDMA_EN0 |
-		       M_MAC_RX_ENABLE |
-		       M_MAC_TX_ENABLE, s->sbm_macenable);
+		     M_MAC_TXDMA_EN0 |
+		     M_MAC_RX_ENABLE |
+		     M_MAC_TX_ENABLE, s->sbm_macenable);
 #else
 #error invalid SiByte MAC configuation
 #endif
@@ -1624,15 +1641,15 @@ static void sbmac_channel_start(struct s
 	 * Accept any TX interrupt and EOP count/timer RX interrupts on ch 0
 	 */
 	__raw_writeq(((M_MAC_INT_EOP_COUNT | M_MAC_INT_EOP_TIMER) << S_MAC_TX_CH0) |
-		       ((M_MAC_INT_EOP_COUNT | M_MAC_INT_EOP_TIMER) << S_MAC_RX_CH0), s->sbm_imr);
+		     ((M_MAC_INT_EOP_COUNT | M_MAC_INT_EOP_TIMER) << S_MAC_RX_CH0), 
+		     s->sbm_imr);
 #else
 	/*
 	 * Accept any kind of interrupt on TX and RX DMA channel 0
 	 */
 	__raw_writeq((M_MAC_INT_CHANNEL << S_MAC_TX_CH0) |
-		       (M_MAC_INT_CHANNEL << S_MAC_RX_CH0), s->sbm_imr);
+		     (M_MAC_INT_CHANNEL << S_MAC_RX_CH0), s->sbm_imr);
 #endif
-
 	/*
 	 * Enable receiving unicasts and broadcasts
 	 */
@@ -2067,7 +2084,6 @@ static irqreturn_t sbmac_intr(int irq,vo
 		 * Read the ISR (this clears the bits in the real
 		 * register, except for counter addr)
 		 */
-
 		isr = __raw_readq(sc->sbm_isr) & ~M_MAC_COUNTER_ADDR;
 
 		if (isr == 0)
@@ -2079,13 +2095,31 @@ static irqreturn_t sbmac_intr(int irq,vo
 		 * Transmits on channel 0
 		 */
 
+#if defined(CONFIG_SBMAC_NAPI)
 		if (isr & (M_MAC_INT_CHANNEL << S_MAC_TX_CH0)) {
-			sbdma_tx_process(sc,&(sc->sbm_txdma));
+			sbdma_tx_process(sc,&(sc->sbm_txdma), 0);
 		}
 
 		/*
 		 * Receives on channel 0
 		 */
+		if (isr & (M_MAC_INT_CHANNEL << S_MAC_RX_CH0)) {
+			if (netif_rx_schedule_prep(dev))
+			{
+				__raw_writeq(0, sc->sbm_imr);
+				__netif_rx_schedule(dev);
+			}
+			else
+			{
+				sbdma_rx_process(sc,&(sc->sbm_rxdma), 0);
+			}
+		}
+#else
+		/* Non NAPI */
+
+		if (isr & (M_MAC_INT_CHANNEL << S_MAC_TX_CH0)) {
+			sbdma_tx_process(sc,&(sc->sbm_txdma), 0);
+		}
 
 		/*
 		 * It's important to test all the bits (or at least the
@@ -2105,8 +2139,9 @@ static irqreturn_t sbmac_intr(int irq,vo
 
 
 		if (isr & (M_MAC_INT_CHANNEL << S_MAC_RX_CH0)) {
-			sbdma_rx_process(sc,&(sc->sbm_rxdma));
+			sbdma_rx_process(sc,&(sc->sbm_rxdma), 0);
 		}
+#endif
 	}
 	return IRQ_RETVAL(handled);
 }
@@ -2405,7 +2440,10 @@ static int sbmac_init(struct net_device 
 	dev->do_ioctl           = sbmac_mii_ioctl;
 	dev->tx_timeout         = sbmac_tx_timeout;
 	dev->watchdog_timeo     = TX_TIMEOUT;
-
+#if defined(CONFIG_SBMAC_NAPI)
+	dev->poll               = sbmac_poll;
+	dev->weight             = 16;
+#endif
 	dev->change_mtu         = sb1250_change_mtu;
 
 	/* This is needed for PASS2 for Rx H/W checksum feature */
@@ -2818,7 +2856,37 @@ static int sbmac_close(struct net_device
 	return 0;
 }
 
+#if defined(CONFIG_SBMAC_NAPI)
+static int sbmac_poll(struct net_device *dev, int *budget)
+{
+	int work_to_do;
+	int work_done;
+	struct sbmac_softc *sc = netdev_priv(dev);
+
+	work_to_do = min(*budget, dev->quota);
+	work_done = sbdma_rx_process(sc,&(sc->sbm_rxdma), 1);
 
+	sbdma_tx_process(sc,&(sc->sbm_txdma), 1);
+
+	*budget -= work_done;
+	dev->quota -= work_done;
+
+	if (work_done < work_to_do) {
+		netif_rx_complete(dev);
+
+#ifdef CONFIG_SBMAC_COALESCE
+		__raw_writeq(((M_MAC_INT_EOP_COUNT | M_MAC_INT_EOP_TIMER) << S_MAC_TX_CH0) |
+			     ((M_MAC_INT_EOP_COUNT | M_MAC_INT_EOP_TIMER) << S_MAC_RX_CH0), 
+			     sc->sbm_imr);
+#else
+		__raw_writeq((M_MAC_INT_CHANNEL << S_MAC_TX_CH0) |
+			     (M_MAC_INT_CHANNEL << S_MAC_RX_CH0), sc->sbm_imr);
+#endif
+	}
+
+	return (work_done >= work_to_do);
+}
+#endif
 
 #if defined(SBMAC_ETH0_HWADDR) || defined(SBMAC_ETH1_HWADDR) || defined(SBMAC_ETH2_HWADDR) || defined(SBMAC_ETH3_HWADDR)
 static void

------------WDAN2car0kumta6zzcvcjH--
