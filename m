Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2003 21:32:06 +0100 (BST)
Received: from p0329.as-l042.contactel.cz ([IPv6:::ffff:194.108.238.75]:516
	"EHLO kopretinka") by linux-mips.org with ESMTP id <S8225220AbTEGUcD>;
	Wed, 7 May 2003 21:32:03 +0100
Received: from ladis by kopretinka with local (Exim 3.35 #1 (Debian))
	id 19DVX2-0000B1-00; Wed, 07 May 2003 22:28:52 +0200
Date: Wed, 7 May 2003 22:28:51 +0200
To: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] SGI Seeq cleanup
Message-ID: <20030507202851.GA668@kopretinka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

read eaddr using NVRAM access fuctions and make various cleanups so driver
can be build as module


diff -Naur linux_2_4/drivers/net/Config.in linux_2_4-fucked/drivers/net/Config.in
--- linux_2_4/drivers/net/Config.in	Wed Apr 16 09:11:57 2003
+++ linux_2_4-fucked/drivers/net/Config.in	Wed May  7 19:55:30 2003
@@ -217,7 +217,7 @@
       dep_tristate '    D-Link DE620 pocket adapter support' CONFIG_DE620 $CONFIG_ISA
    fi
    if [ "$CONFIG_SGI_IP22" = "y" ]; then
-      bool '  SGI Seeq ethernet controller support' CONFIG_SGISEEQ
+      tristate '  SGI Seeq ethernet controller support' CONFIG_SGISEEQ
    fi
    if [ "$CONFIG_DECSTATION" = "y" ]; then
       tristate '  DEC LANCE ethernet controller support' CONFIG_DECLANCE
diff -Naur linux_2_4/drivers/net/Space.c linux_2_4-fucked/drivers/net/Space.c
--- linux_2_4/drivers/net/Space.c	Thu Aug  1 21:51:01 2002
+++ linux_2_4-fucked/drivers/net/Space.c	Wed May  7 19:55:30 2003
@@ -83,7 +83,6 @@
 extern int SK_init(struct net_device *);
 extern int seeq8005_probe(struct net_device *);
 extern int smc_init( struct net_device * );
-extern int sgiseeq_probe(struct net_device *);
 extern int atarilance_probe(struct net_device *);
 extern int sun3lance_probe(struct net_device *);
 extern int sun3_82586_probe(struct net_device *);
@@ -366,14 +365,6 @@
 	{NULL, 0},
 };
 
-
-static struct devprobe sgi_probes[] __initdata = {
-#ifdef CONFIG_SGISEEQ
-	{sgiseeq_probe, 0},
-#endif
-	{NULL, 0},
-};
-
 static struct devprobe mips_probes[] __initdata = {
 #ifdef CONFIG_MIPS_JAZZ_SONIC
 	{sonic_probe, 0},
@@ -407,8 +398,6 @@
 	if (probe_list(dev, m68k_probes) == 0)
 		return 0;
 	if (probe_list(dev, mips_probes) == 0)
-		return 0;
-	if (probe_list(dev, sgi_probes) == 0)
 		return 0;
 	if (probe_list(dev, eisa_probes) == 0)
 		return 0;
diff -Naur linux_2_4/drivers/net/sgiseeq.c linux_2_4-fucked/drivers/net/sgiseeq.c
--- linux_2_4/drivers/net/sgiseeq.c	Wed Mar 19 18:33:03 2003
+++ linux_2_4-fucked/drivers/net/sgiseeq.c	Wed May  7 19:55:30 2003
@@ -5,6 +5,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
@@ -96,8 +97,8 @@
 struct sgiseeq_private {
 	volatile struct sgiseeq_init_block srings;
 	char *name;
-	volatile struct hpc3_ethregs *hregs;
-	volatile struct sgiseeq_regs *sregs;
+	struct hpc3_ethregs *hregs;
+	struct sgiseeq_regs *sregs;
 
 	/* Ring entry counters. */
 	unsigned int rx_new, tx_new;
@@ -108,17 +109,22 @@
 	unsigned char mode;
 
 	struct net_device_stats stats;
+
+	struct net_device *next_module;
 };
 
-static inline void hpc3_eth_reset(volatile struct hpc3_ethregs *hregs)
+/* A list of all installed seeq devices, for removing the driver module. */
+static struct net_device *root_sgiseeq_dev;
+
+static inline void hpc3_eth_reset(struct hpc3_ethregs *hregs)
 {
 	hregs->rx_reset = (HPC3_ERXRST_CRESET | HPC3_ERXRST_CLRIRQ);
 	udelay(20);
 	hregs->rx_reset = 0;
 }
 
-static inline void reset_hpc3_and_seeq(volatile struct hpc3_ethregs *hregs,
-				       volatile struct sgiseeq_regs *sregs)
+static inline void reset_hpc3_and_seeq(struct hpc3_ethregs *hregs,
+				       struct sgiseeq_regs *sregs)
 {
 	hregs->rx_ctrl = hregs->tx_ctrl = 0;
 	hpc3_eth_reset(hregs);
@@ -128,15 +134,15 @@
 		       SEEQ_RCMD_IDRIB | SEEQ_RCMD_ICRC)
 
 static inline void seeq_go(struct sgiseeq_private *sp,
-			   volatile struct hpc3_ethregs *hregs,
-			   volatile struct sgiseeq_regs *sregs)
+			   struct hpc3_ethregs *hregs,
+			   struct sgiseeq_regs *sregs)
 {
 	sregs->rstat = sp->mode | RSTAT_GO_BITS;
 	hregs->rx_ctrl = HPC3_ERXCTRL_ACTIVE;
 }
 
 static inline void seeq_load_eaddr(struct net_device *dev,
-				   volatile struct sgiseeq_regs *sregs)
+				   struct sgiseeq_regs *sregs)
 {
 	int i;
 
@@ -177,7 +183,6 @@
 				return -ENOMEM;
 			ib->tx_desc[i].buf_vaddr = KSEG1ADDR(buffer);
 			ib->tx_desc[i].tdma.pbuf = PHYSADDR(buffer);
-//			flush_cache_all();
 		}
 		ib->tx_desc[i].tdma.cntinfo = (TCNTINFO_INIT);
 	}
@@ -192,7 +197,6 @@
 				return -ENOMEM;
 			ib->rx_desc[i].buf_vaddr = KSEG1ADDR(buffer);
 			ib->rx_desc[i].rdma.pbuf = PHYSADDR(buffer);
-//			flush_cache_all();
 		}
 		ib->rx_desc[i].rdma.cntinfo = (RCNTINFO_INIT);
 	}
@@ -209,7 +213,7 @@
 	static int once;
 	struct sgiseeq_rx_desc *r = gpriv->srings.rx_desc;
 	struct sgiseeq_tx_desc *t = gpriv->srings.tx_desc;
-	volatile struct hpc3_ethregs *hregs = gpriv->hregs;
+	struct hpc3_ethregs *hregs = gpriv->hregs;
 	int i;
 
 	if(once)
@@ -248,9 +252,9 @@
 #define RDMACFG_INIT    (HPC3_ERXDCFG_FRXDC | HPC3_ERXDCFG_FEOP | HPC3_ERXDCFG_FIRQ)
 
 static int init_seeq(struct net_device *dev, struct sgiseeq_private *sp,
-		      volatile struct sgiseeq_regs *sregs)
+		     struct sgiseeq_regs *sregs)
 {
-	volatile struct hpc3_ethregs *hregs = sp->hregs;
+	struct hpc3_ethregs *hregs = sp->hregs;
 	int err;
 
 	reset_hpc3_and_seeq(hregs, sregs);
@@ -291,8 +295,8 @@
 }
 
 static inline void rx_maybe_restart(struct sgiseeq_private *sp,
-				    volatile struct hpc3_ethregs *hregs,
-				    volatile struct sgiseeq_regs *sregs)
+				    struct hpc3_ethregs *hregs,
+				    struct sgiseeq_regs *sregs)
 {
 	if (!(hregs->rx_ctrl & HPC3_ERXCTRL_ACTIVE)) {
 		hregs->rx_ndptr = PHYSADDR(&sp->srings.rx_desc[sp->rx_new]);
@@ -305,8 +309,8 @@
 				(rd) = &(sp)->srings.rx_desc[(sp)->rx_new])
 
 static inline void sgiseeq_rx(struct net_device *dev, struct sgiseeq_private *sp,
-			      volatile struct hpc3_ethregs *hregs,
-			      volatile struct sgiseeq_regs *sregs)
+			      struct hpc3_ethregs *hregs,
+			      struct sgiseeq_regs *sregs)
 {
 	struct sgiseeq_rx_desc *rd;
 	struct sk_buff *skb = 0;
@@ -338,7 +342,7 @@
 				sp->stats.rx_packets++;
 				sp->stats.rx_bytes += len;
 			} else {
-				printk ("%s: Memory squeeze, deferring packet.\n",
+				printk (KERN_NOTICE "%s: Memory squeeze, deferring packet.\n",
 					dev->name);
 				sp->stats.rx_dropped++;
 			}
@@ -356,7 +360,7 @@
 }
 
 static inline void tx_maybe_reset_collisions(struct sgiseeq_private *sp,
-					     volatile struct sgiseeq_regs *sregs)
+					     struct sgiseeq_regs *sregs)
 {
 	if (sp->is_edlc) {
 		sregs->rw.wregs.control = sp->control & ~(SEEQ_CTRL_XCNT);
@@ -365,7 +369,7 @@
 }
 
 static inline void kick_tx(struct sgiseeq_tx_desc *td,
-			   volatile struct hpc3_ethregs *hregs)
+			   struct hpc3_ethregs *hregs)
 {
 	/* If the HPC aint doin nothin, and there are more packets
 	 * with ETXD cleared and XIU set we must make very certain
@@ -383,8 +387,8 @@
 }
 
 static inline void sgiseeq_tx(struct net_device *dev, struct sgiseeq_private *sp,
-			      volatile struct hpc3_ethregs *hregs,
-			      volatile struct sgiseeq_regs *sregs)
+			      struct hpc3_ethregs *hregs,
+			      struct sgiseeq_regs *sregs)
 {
 	struct sgiseeq_tx_desc *td;
 	unsigned long status = hregs->tx_ctrl;
@@ -426,8 +430,8 @@
 {
 	struct net_device *dev = (struct net_device *) dev_id;
 	struct sgiseeq_private *sp = (struct sgiseeq_private *) dev->priv;
-	volatile struct hpc3_ethregs *hregs = sp->hregs;
-	volatile struct sgiseeq_regs *sregs = sp->sregs;
+	struct hpc3_ethregs *hregs = sp->hregs;
+	struct sgiseeq_regs *sregs = sp->sregs;
 
 	/* Ack the IRQ and set software state. */
 	hregs->rx_reset = HPC3_ERXRST_CLRIRQ;
@@ -435,7 +439,7 @@
 	/* Always check for received packets. */
 	sgiseeq_rx(dev, sp, hregs, sregs);
 
-	/* Only check for tx acks iff we have something queued. */
+	/* Only check for tx acks if we have something queued. */
 	if (sp->tx_old != sp->tx_new)
 		sgiseeq_tx(dev, sp, hregs, sregs);
 
@@ -447,47 +451,34 @@
 static int sgiseeq_open(struct net_device *dev)
 {
 	struct sgiseeq_private *sp = (struct sgiseeq_private *)dev->priv;
-	volatile struct sgiseeq_regs *sregs = sp->sregs;
-	unsigned long flags;
-	int err;
-
-	__save_and_cli(flags);
+	struct sgiseeq_regs *sregs = sp->sregs;
 
-	err = -EAGAIN;
-	if (request_irq(dev->irq, sgiseeq_interrupt, 0, sgiseeqstr, dev)) {
-		printk("Seeq8003: Can't get irq %d\n", dev->irq);
-		goto out;
-	}
-	err = init_seeq(dev, sp, sregs);
+	int err = init_seeq(dev, sp, sregs);
 	if (err)
-		goto out;
+		return err;
 
 	netif_start_queue(dev);
 
-out:
-	__restore_flags(flags);
-	return err;
+	return 0;
 }
 
 static int sgiseeq_close(struct net_device *dev)
 {
 	struct sgiseeq_private *sp = (struct sgiseeq_private *) dev->priv;
-	volatile struct sgiseeq_regs *sregs = sp->sregs;
+	struct sgiseeq_regs *sregs = sp->sregs;
 
 	netif_stop_queue(dev);
 
 	/* Shutdown the Seeq. */
 	reset_hpc3_and_seeq(sp->hregs, sregs);
 
-	free_irq(dev->irq, dev);
-
 	return 0;
 }
 
 static inline int sgiseeq_reset(struct net_device *dev)
 {
 	struct sgiseeq_private *sp = (struct sgiseeq_private *) dev->priv;
-	volatile struct sgiseeq_regs *sregs = sp->sregs;
+	struct sgiseeq_regs *sregs = sp->sregs;
 	int err;
 
 	err = init_seeq(dev, sp, sregs);
@@ -509,7 +500,7 @@
 static int sgiseeq_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct sgiseeq_private *sp = (struct sgiseeq_private *) dev->priv;
-	volatile struct hpc3_ethregs *hregs = sp->hregs;
+	struct hpc3_ethregs *hregs = sp->hregs;
 	unsigned long flags;
 	struct sgiseeq_tx_desc *td;
 	int skblen, len, entry;
@@ -565,7 +556,7 @@
 
 static void timeout(struct net_device *dev)
 {
-	printk("%s: transmit timed out, resetting\n", dev->name);
+	printk(KERN_NOTICE "%s: transmit timed out, resetting\n", dev->name);
 	sgiseeq_reset(dev);
 
 	dev->trans_start = jiffies;
@@ -608,41 +599,58 @@
 	buf[i].rdma.pnext = PHYSADDR(&buf[0]);
 }
 
-static char onboard_eth_addr[6];
-
 #define ALIGNED(x)  ((((unsigned long)(x)) + 0xf) & ~(0xf))
 
-int sgiseeq_init(struct net_device *dev, struct sgiseeq_regs *sregs,
-		 struct hpc3_ethregs *hregs, int irq)
+int sgiseeq_init(struct hpc3_regs* regs, int irq)
 {
-	static unsigned version_printed;
-	int i;
+	struct net_device *dev;
 	struct sgiseeq_private *sp;
-
-	dev->priv = (struct sgiseeq_private *) get_zeroed_page(GFP_KERNEL);
-	if (dev->priv == NULL)
+	int i;
+	
+	sp = (struct sgiseeq_private *) get_zeroed_page(GFP_KERNEL);
+	if (!sp) {
+		printk (KERN_ERR
+			"Seeq8003: Could not allocate private data.\n");
 		return -ENOMEM;
+	}
 
-	if (!version_printed++)
-		printk(version);
-
-	printk("%s: SGI Seeq8003 ", dev->name);
-
-	for (i = 0; i < 6; i++)
-		printk("%2.2x%c",
-		       dev->dev_addr[i] = onboard_eth_addr[i],
-		       i == 5 ? ' ': ':');
+	dev = init_etherdev(NULL, 0);
+	if (!dev) {
+		printk (KERN_ERR
+			"Seeq8003: Could not allocate memory for device.\n");
+		free_page((unsigned long) sp);
+		return -ENOMEM;
+	}
+	/* let unregister_netdev free memory for us */
+	dev->features |= NETIF_F_DYNALLOC;
 
+	if (request_irq(irq, sgiseeq_interrupt, 0, sgiseeqstr, dev)) {
+		printk(KERN_ERR "Seeq8003: Can't get irq %d\n", dev->irq);
+		free_page((unsigned long) sp);
+		unregister_netdev(dev);
+		return -EAGAIN;
+	}
+
+	printk(KERN_INFO "%s: SGI Seeq8003 ", dev->name);
+
+#define EADDR_NVOFS     250
+	for (i = 0; i < 3; i++) {
+		unsigned short tmp = ip22_nvram_read(EADDR_NVOFS / 2 + i);
+
+		printk("%2.2x:%2.2x%c",
+			dev->dev_addr[2 * i]     = tmp >> 8,
+			dev->dev_addr[2 * i + 1] = tmp & 0xff,
+			i == 2 ? ' ' : ':');
+	}
 	printk("\n");
 
-	sp = (struct sgiseeq_private *) dev->priv;
+	dev->priv = sp;
 #ifdef DEBUG
 	gpriv = sp;
 	gdev = dev;
 #endif
-	memset((char *)dev->priv, 0, sizeof(struct sgiseeq_private));
-	sp->sregs = sregs;
-	sp->hregs = hregs;
+	sp->sregs = (struct sgiseeq_regs *) &hpc3c0->eth_ext[0];
+	sp->hregs = &hpc3c0->ethregs;
 	sp->name = sgiseeqstr;
 
 	sp->srings.rx_desc = (struct sgiseeq_rx_desc *)
@@ -659,14 +667,13 @@
 	setup_tx_ring(sp->srings.tx_desc, SEEQ_TX_BUFFERS);
 
 	/* Reset the chip. */
-	hpc3_eth_reset((volatile struct hpc3_ethregs *) hregs);
+	hpc3_eth_reset(sp->hregs);
 
-	sp->is_edlc = !(sregs->rw.rregs.collision_tx[0] & 0xff);
-	if (sp->is_edlc) {
+	sp->is_edlc = !(sp->sregs->rw.rregs.collision_tx[0] & 0xff);
+	if (sp->is_edlc)
 		sp->control = (SEEQ_CTRL_XCNT | SEEQ_CTRL_ACCNT |
 			       SEEQ_CTRL_SFLAG | SEEQ_CTRL_ESHORT |
 			       SEEQ_CTRL_ENCARR);
-	}
 
 	dev->open                 = sgiseeq_open;
 	dev->stop                 = sgiseeq_close;
@@ -679,58 +686,36 @@
 	dev->dma                  = 0;
 	ether_setup(dev);
 
+	sp->next_module = root_sgiseeq_dev;
+	root_sgiseeq_dev = dev;
+
 	return 0;
 }
 
-static inline unsigned char str2hexnum(unsigned char c)
+static int __init sgiseeq_probe(void)
 {
-	if (c >= '0' && c <= '9')
-		return c - '0';
-	if (c >= 'a' && c <= 'f')
-		return c - 'a' + 10;
-	return 0; /* foo */
+	printk(version);
+
+	/* On board adapter on 1st HPC is always present */
+	return sgiseeq_init(hpc3c0, SGI_ENET_IRQ);
 }
 
-static inline void str2eaddr(unsigned char *ea, unsigned char *str)
+static void __exit sgiseeq_exit(void)
 {
-	int i;
-
-	for (i = 0; i < 6; i++) {
-		unsigned char num;
+	struct sgiseeq_private *sp;
+	struct net_device *next, *dev = root_sgiseeq_dev;
 
-		if(*str == ':')
-			str++;
-		num = str2hexnum(*str++) << 4;
-		num |= (str2hexnum(*str++));
-		ea[i] = num;
+	while (dev) {
+		sp = (struct sgiseeq_private *) dev->priv;
+		next = sp->next_module;
+		free_irq(dev->irq, dev);
+		free_page((unsigned long) sp);
+		unregister_netdev(dev);
+		dev = next;
 	}
 }
 
-int sgiseeq_probe(struct net_device *dev)
-{
-	static int initialized;
-	char *ep;
-
-	if (initialized)	/* Already initialized? */
-		return 1;
-	initialized++;
-
-	/* First get the ethernet address of the onboard interface from ARCS.
-	 * This is fragile; PROM doesn't like running from cache.
-	 * On MIPS64 it crashes for some other, yet unknown reason ...
-	 */
-	ep = ArcGetEnvironmentVariable("eaddr");
-	if (ep == NULL) {
-		/*
-		 * This one is likely to be caused by a broken NVRAM
-		 */
-		printk(KERN_CRIT "Seeq8003: Can't get MAC address!\n");
-		return -ENODEV;
-	}
-	str2eaddr(onboard_eth_addr, ep);
-	return sgiseeq_init(dev,
-			    (struct sgiseeq_regs *) (KSEG1ADDR(0x1fbd4000)),
-			    &hpc3c0->ethregs, SGI_ENET_IRQ);
-}
+module_init(sgiseeq_probe);
+module_exit(sgiseeq_exit);
 
 MODULE_LICENSE("GPL");
