Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5OMxUA20910
	for linux-mips-outgoing; Sun, 24 Jun 2001 15:59:30 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5OMwxV20819;
	Sun, 24 Jun 2001 15:58:59 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id AAA318552;
	Mon, 25 Jun 2001 00:58:57 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15EIqG-0002iF-00; Mon, 25 Jun 2001 00:58:56 +0200
Date: Mon, 25 Jun 2001 00:58:56 +0200
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: [PATCH] Make sgiseeq.c 64bit ready (was: CVS Update@oss.sgi.com: linux)
Message-ID: <20010625005856.C388@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200106230445.f5N4jtg30745@oss.sgi.com>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> CVSROOT:	/home/pub/cvs
> Module name:	linux
> Changes by:	ralf@oss.sgi.com	01/06/22 21:45:55
> 
> Modified files:
> 	drivers/net    : sgiseeq.c 
> 
> Log message:
> 	Pull bogus 64-bit changes.

This patch makes (as the original) the assumption that
sizeof(void *) == 4, so it will work for 32bit only.

My seemingly working code for mips64 is appeded as patch against
current CVS.


Thiemo


diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/drivers/net/sgiseeq.c linux/drivers/net/sgiseeq.c
--- linux-orig/drivers/net/sgiseeq.c	Sun Jun 24 19:55:01 2001
+++ linux/drivers/net/sgiseeq.c	Sun Jun 24 22:34:11 2001
@@ -1,5 +1,4 @@
-/* $Id: sgiseeq.c,v 1.17 2000/03/27 23:02:57 ralf Exp $
- *
+/*
  * sgiseeq.c: Seeq8003 ethernet driver for SGI machines.
  *
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
@@ -67,7 +66,7 @@
 			    sp->tx_old + (SEEQ_TX_BUFFERS - 1) - sp->tx_new : \
 			    sp->tx_old - sp->tx_new - 1)
 
-#define DEBUG
+/* #define DEBUG */
 
 struct sgiseeq_rx_desc {
 	struct hpc_dma_desc rdma;
@@ -79,19 +78,24 @@
 	signed int buf_vaddr;
 };
 
-/* Warning: This structure is layed out in a certain way because
- *          HPC dma descriptors must be 8-byte aligned.  So don't
- *          touch this without some care.
+/* Warning: This structure is layed out in a certain way because HPC dma
+ *          descriptors must be 8-byte aligned.  So don't touch this without
+ *          some care.
+ *          The spec states 16-byte alignment is needed, so I changed the
+ *          padding and aligned the whole struct accordingly. --THS
  */
 struct sgiseeq_init_block { /* Note the name ;-) */
-	/* Ptrs to the descriptors in KSEG1 uncached space. */
+	/* Ptrs to the descriptors in KSEG1 or XKPHYS uncached space. */
 	struct sgiseeq_rx_desc *rx_desc;
 	struct sgiseeq_tx_desc *tx_desc;
-	unsigned int _padding[30]; /* Pad out to largest cache line size. */
+	/* Pad out to largest cache line size (64 byte with 32bit, 128 byte
+	 * with 64bit pointers).
+	 */
+	char _padding[14 * sizeof(void *)];
 
 	struct sgiseeq_rx_desc rxvector[SEEQ_RX_BUFFERS];
 	struct sgiseeq_tx_desc txvector[SEEQ_TX_BUFFERS];
-};
+} __attribute__((aligned(16)));
 
 struct sgiseeq_private {
 	volatile struct sgiseeq_init_block srings;
@@ -149,6 +153,12 @@
 #define RCNTCFG_INIT  (HPCDMA_OWN | HPCDMA_EORP | HPCDMA_XIE)
 #define RCNTINFO_INIT (RCNTCFG_INIT | (PKT_BUF_SZ & HPCDMA_BCNT))
 
+#ifdef CONFIG_SGI_IP28
+#define THIS_K1ADDR K1ADDR
+#else
+#define THIS_K1ADDR KSEG1ADDR
+#endif
+
 static int seeq_init_ring(struct net_device *dev)
 {
 	struct sgiseeq_private *sp = (struct sgiseeq_private *) dev->priv;
@@ -172,12 +182,12 @@
 		if(!ib->tx_desc[i].tdma.pbuf) {
 			unsigned long buffer;
 
-			buffer = (unsigned long) kmalloc(PKT_BUF_SZ, GFP_KERNEL);
+			buffer = (unsigned long)kmalloc(PKT_BUF_SZ,
+							GFP_KERNEL | GFP_DMA);
 			if (!buffer)
 				return -ENOMEM;
-			ib->tx_desc[i].buf_vaddr = KSEG1ADDR(buffer);
+			ib->tx_desc[i].buf_vaddr = THIS_K1ADDR(buffer);
 			ib->tx_desc[i].tdma.pbuf = PHYSADDR(buffer);
-//			flush_cache_all();
 		}
 		ib->tx_desc[i].tdma.cntinfo = (TCNTINFO_INIT);
 	}
@@ -187,12 +197,12 @@
 		if (!ib->rx_desc[i].rdma.pbuf) {
 			unsigned long buffer;
 
-			buffer = (unsigned long) kmalloc(PKT_BUF_SZ, GFP_KERNEL);
+			buffer = (unsigned long)kmalloc(PKT_BUF_SZ,
+							GFP_KERNEL | GFP_DMA);
 			if (!buffer)
 				return -ENOMEM;
-			ib->rx_desc[i].buf_vaddr = KSEG1ADDR(buffer);
+			ib->rx_desc[i].buf_vaddr = THIS_K1ADDR(buffer);
 			ib->rx_desc[i].rdma.pbuf = PHYSADDR(buffer);
-//			flush_cache_all();
 		}
 		ib->rx_desc[i].rdma.cntinfo = (RCNTINFO_INIT);
 	}
@@ -300,10 +310,6 @@
 	}
 }
 
-#define for_each_rx(rd, sp) for((rd) = &(sp)->srings.rx_desc[(sp)->rx_new]; \
-				!((rd)->rdma.cntinfo & HPCDMA_OWN); \
-				(rd) = &(sp)->srings.rx_desc[(sp)->rx_new])
-
 static inline void sgiseeq_rx(struct net_device *dev, struct sgiseeq_private *sp,
 			      volatile struct hpc3_ethregs *hregs,
 			      volatile struct sgiseeq_regs *sregs)
@@ -316,7 +322,9 @@
 	unsigned int orig_end = PREV_RX(sp->rx_new);
 
 	/* Service every received packet. */
-	for_each_rx(rd, sp) {
+	for(rd = &sp->srings.rx_desc[sp->rx_new];
+	    !(rd->rdma.cntinfo & HPCDMA_OWN);
+	    rd = &sp->srings.rx_desc[sp->rx_new]) {
 		len = (PKT_BUF_SZ - (rd->rdma.cntinfo & HPCDMA_BCNT) - 3);
 		pkt_pointer = (unsigned char *)(long)rd->buf_vaddr;
 		pkt_status = pkt_pointer[len + 2];
@@ -338,7 +346,7 @@
 				sp->stats.rx_packets++;
 				sp->stats.rx_bytes += len;
 			} else {
-				printk ("%s: Memory squeeze, deferring packet.\n",
+				printk("%s: Memory squeeze, deferring packet.\n",
 					dev->name);
 				sp->stats.rx_dropped++;
 			}
@@ -370,12 +378,12 @@
 	/* If the HPC aint doin nothin, and there are more packets
 	 * with ETXD cleared and XIU set we must make very certain
 	 * that we restart the HPC else we risk locking up the
-	 * adapter.  The following code is only safe iff the HPCDMA
+	 * adapter.  The following code is only safe if the HPCDMA
 	 * is not active!
 	 */
 	while ((td->tdma.cntinfo & (HPCDMA_XIU | HPCDMA_ETXD)) ==
 	      (HPCDMA_XIU | HPCDMA_ETXD))
-		td = (struct sgiseeq_tx_desc *)(long) KSEG1ADDR(td->tdma.pnext);
+		td = (struct sgiseeq_tx_desc *)THIS_K1ADDR(td->tdma.pnext);
 	if (td->tdma.cntinfo & HPCDMA_XIU) {
 		hregs->tx_ndptr = PHYSADDR(td);
 		hregs->tx_ctrl = HPC3_ETXCTRL_ACTIVE;
@@ -435,7 +443,7 @@
 	/* Always check for received packets. */
 	sgiseeq_rx(dev, sp, hregs, sregs);
 
-	/* Only check for tx acks iff we have something queued. */
+	/* Only check for tx acks if we have something queued. */
 	if (sp->tx_old != sp->tx_new)
 		sgiseeq_tx(dev, sp, hregs, sregs);
 
@@ -497,11 +505,13 @@
 	return 0;
 }
 
+#ifdef DEBUG
 void sgiseeq_my_reset(void)
 {
 	printk("RESET!\n");
 	sgiseeq_reset(gdev);
 }
+#endif
 
 static int sgiseeq_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
@@ -528,7 +538,7 @@
 	 *    we have completely set up it's state.  This means, do
 	 *    not clear HPCDMA_EOX in the current last descritptor
 	 *    until the one we are adding looks consistant and could
-	 *    be processes right now.
+	 *    be processed right now.
 	 * 3) The tx interrupt code must notice when we've added a new
 	 *    entry and the HPC got to the end of the chain before we
 	 *    added this new entry and restarted it.
@@ -584,7 +594,6 @@
 
 	while (i < (nbufs - 1)) {
 		buf[i].tdma.pnext = PHYSADDR(&buf[i + 1]);
-		buf[i].tdma.pbuf = 0;
 		i++;
 	}
 	buf[i].tdma.pnext = PHYSADDR(&buf[0]);
@@ -596,25 +605,22 @@
 
 	while (i < (nbufs - 1)) {
 		buf[i].rdma.pnext = PHYSADDR(&buf[i + 1]);
-		buf[i].rdma.pbuf = 0;
 		i++;
 	}
-	buf[i].rdma.pbuf = 0;
 	buf[i].rdma.pnext = PHYSADDR(&buf[0]);
 }
 
 static char onboard_eth_addr[6];
 
-#define ALIGNED(x)  ((((unsigned long)(x)) + 0xf) & ~(0xf))
-
-int sgiseeq_init(struct net_device *dev, struct sgiseeq_regs *sregs,
-		 struct hpc3_ethregs *hregs, int irq)
+static int sgiseeq_init(struct net_device *dev, struct sgiseeq_regs *sregs,
+			struct hpc3_ethregs *hregs, int irq)
 {
 	static unsigned version_printed;
 	int i;
 	struct sgiseeq_private *sp;
 
-	dev->priv = (struct sgiseeq_private *) get_free_page(GFP_KERNEL);
+	dev->priv = (struct sgiseeq_private *)
+		    get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (dev->priv == NULL)
 		return -ENOMEM;
 
@@ -635,17 +641,16 @@
 	gpriv = sp;
 	gdev = dev;
 #endif
-	memset((char *)dev->priv, 0, sizeof(struct sgiseeq_private));
 	sp->sregs = sregs;
 	sp->hregs = hregs;
 	sp->name = sgiseeqstr;
 
 	sp->srings.rx_desc = (struct sgiseeq_rx_desc *)
-	                     (KSEG1ADDR(ALIGNED(&sp->srings.rxvector[0])));
+	                     (THIS_K1ADDR(&sp->srings.rxvector[0]));
 	dma_cache_wback_inv((unsigned long)&sp->srings.rxvector,
 	                    sizeof(sp->srings.rxvector));
 	sp->srings.tx_desc = (struct sgiseeq_tx_desc *)
-	                     (KSEG1ADDR(ALIGNED(&sp->srings.txvector[0])));
+	                     (THIS_K1ADDR(&sp->srings.txvector[0]));
 	dma_cache_wback_inv((unsigned long)&sp->srings.txvector,
 	                    sizeof(sp->srings.txvector));
 
@@ -677,6 +682,8 @@
 	return 0;
 }
 
+#undef THIS_K1ADDR
+
 static inline unsigned char str2hexnum(unsigned char c)
 {
 	if (c >= '0' && c <= '9')
@@ -712,7 +719,6 @@
 
 	/* First get the ethernet address of the onboard interface from ARCS.
 	 * This is fragile; PROM doesn't like running from cache.
-	 * On MIPS64 it crashes for some other, yet unknown reason ...
 	 */
 	ep = ArcGetEnvironmentVariable("eaddr");
 	str2eaddr(onboard_eth_addr, ep);
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips64/addrspace.h linux/include/asm-mips64/addrspace.h
--- linux-orig/include/asm-mips64/addrspace.h	Thu Oct 26 03:18:01 2000
+++ linux/include/asm-mips64/addrspace.h	Sun Jun 24 22:09:29 2001
@@ -1,5 +1,4 @@
-/* $Id: addrspace.h,v 1.5 2000/02/01 00:32:01 kanoj Exp $
- *
+/*
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
@@ -104,9 +103,13 @@
 #endif
 #define K2BASE		0xc000000000000000
 
+#define K0ADDR(x)	(PHYSADDR(x) | K0BASE)
+#define K1ADDR(x)	(PHYSADDR(x) | K1BASE)
+#define K2ADDR(x)	(PHYSADDR(x) | K2BASE)
+
 #if !defined (CONFIG_CPU_R8000)
-#define COMPAT_K1BASE32		0xffffffffa0000000
-#define PHYS_TO_COMPATK1(x)	((x) | COMPAT_K1BASE32) /* 32-bit compat k1 */
+#define COMPAT_K1BASE32		0xffffffffa0000000  /* 32-bit compat k1 */
+#define PHYS_TO_COMPATK1(x)	((unsigned long)(x) | COMPAT_K1BASE32)
 #endif
 
 #define KDM_TO_PHYS(x)	((unsigned long)(x) & TO_PHYS_MASK)
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips64/sgi/sgihpc.h linux/include/asm-mips64/sgi/sgihpc.h
--- linux-orig/include/asm-mips64/sgi/sgihpc.h	Sat Dec  4 04:59:13 1999
+++ linux/include/asm-mips64/sgi/sgihpc.h	Sun Jun 24 23:20:21 2001
@@ -1,5 +1,4 @@
-/* $Id: sgihpc.h,v 1.2 1999/10/19 20:51:54 ralf Exp $
- *
+/*
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
@@ -36,7 +35,8 @@
 #define HPCDMA_BCNT   0x00003fff /* size in bytes of this dma buffer */
 
 	int pnext;		 /* paddr of next hpc_dma_desc if any */
-};
+	int _padding;		 /* pad to quad word size */
+} __attribute__((aligned(16)));
 
 typedef volatile unsigned int hpcreg;
 
@@ -333,8 +333,6 @@
 
 /* We need software copies of these because they are write only. */
 extern unsigned int sgi_hpc_write1, sgi_hpc_write2;
-
-#define SGI_KEYBOARD_IRQ 20
 
 struct hpc_keyb {
 #ifdef __MIPSEB__
