Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBILd3G16738
	for linux-mips-outgoing; Tue, 18 Dec 2001 13:39:03 -0800
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBILcoo16734
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 13:38:50 -0800
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id MAA78578
	for linux-mips@oss.sgi.com; Tue, 18 Dec 2001 12:38:49 -0800 (PST)
Date: Tue, 18 Dec 2001 12:38:48 -0800
From: Geoffrey Espin <espin@idiom.com>
To: linux-mips@oss.sgi.com
Subject: kmalloc/pci_alloc and skbuff's
Message-ID: <20011218123848.A75986@idiom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


The Markham board (Korva/VR41xx variant) which I'm trying to get
submitted, has a PCI problem.  It doesn't allow a PCI device to
see all the DRAM.  DMA-able data must be in a special 4MB range,
which is currently set at 0x01c00000 (the last 4MB of a 32MB
system). SKB's must be allocated within this area for a
(say, Ethernet) PCI device to access. There appears to be no way
to tell kmalloc(), used in alloc_skb(), to allocate memory from
any special address range.

The pci_{alloc,free}_consistent() routines do the right thing.

Hence the following hack to linux/net/core/skbuff.c.

Any suggestions?

Geoff
-- 
Geoffrey Espin espin@idiom.com
--

--- skbuff.c.ORIG	Tue Aug  7 08:30:50 2001
+++ skbuff.c	Mon Dec 17 13:46:40 2001
@@ -62,6 +62,12 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
+#if defined(CONFIG_NEC_MARKHAM_PCI)
+#warning PCI ALLOC: see linux/arch/mips/markham/pci_fixup.c
+extern void *pci_alloc_consistent(int, int, dma_addr_t *);
+extern void pci_free_consistent(int,int, void *, int);
+#endif
+
 int sysctl_hot_list_len = 128;
 
 static kmem_cache_t *skbuff_head_cache;
@@ -187,6 +193,23 @@
 
 	/* Get the DATA. Size must match skb_add_mtu(). */
 	size = SKB_DATA_ALIGN(size);
+#if defined(CONFIG_NEC_MARKHAM_PCI)
+	/* NEC Markham: see skb_release_data() also */
+
+	/*
+	 * Markham doesn't allow a PCI device to see all the RAM.
+	 * DMAable data must be on this special 4MB range, which
+	 * is currently set at 0x01c00000. SKB buffers must also
+	 * be allocated within this area for a PCI device to
+	 * access. There is no way to tell kmalloc() to allocate
+	 * memory from any special address range. So we do it on
+	 * our own.
+	 *                     Dai, Wed Jun 13 19:34:23 PDT 2001
+	 */
+	if (1)
+		data = (u8 *)pci_alloc_consistent(0,size + sizeof(struct skb_shared_info), NULL);
+	else
+#endif
 	data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
 	if (data == NULL)
 		goto nodata;
@@ -286,6 +309,12 @@
 		if (skb_shinfo(skb)->frag_list)
 			skb_drop_fraglist(skb);
 
+#if defined(CONFIG_NEC_MARKHAM_PCI)
+		/* NEC Markham: see allock_skb() also */
+		if (1)
+			pci_free_consistent(0,0,skb->head,0);
+		else
+#endif
 		kfree(skb->head);
 	}
 }
@@ -505,6 +534,24 @@
 
 	size = (skb->end - skb->head + expand);
 	size = SKB_DATA_ALIGN(size);
+
+#if defined(CONFIG_NEC_MARKHAM_PCI)
+	/* NEC Markham: see skb_release_data() also */
+
+	/*
+	 * Markham doesn't allow a PCI device to see all the RAM.
+	 * DMAable data must be on this special 4MB range, which
+	 * is currently set at 0x01c00000. SKB buffers must also
+	 * be allocated within this area for a PCI device to
+	 * access. There is no way to tell kmalloc() to allocate
+	 * memory from any special address range. So we do it on
+	 * our own.
+	 *                     Dai, Wed Jun 13 19:34:23 PDT 2001
+	 */
+	if (1)
+		data = (u8 *)pci_alloc_consistent(0,size + sizeof(struct skb_shared_info), NULL);
+	else
+#endif
 	data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
 	if (data == NULL)
 		return -ENOMEM;
@@ -512,7 +559,6 @@
 	/* Copy entire thing */
 	if (skb_copy_bits(skb, -headerlen, data, headerlen+skb->len))
 		BUG();
-
 	/* Offset between the two in bytes */
 	offset = data - skb->head;
 
@@ -627,6 +673,23 @@
 
 	size = SKB_DATA_ALIGN(size);
 
+#if defined(CONFIG_NEC_MARKHAM_PCI)
+	/* NEC Markham: see skb_release_data() also */
+
+	/*
+	 * Markham doesn't allow a PCI device to see all the RAM.
+	 * DMAable data must be on this special 4MB range, which
+	 * is currently set at 0x01c00000. SKB buffers must also
+	 * be allocated within this area for a PCI device to
+	 * access. There is no way to tell kmalloc() to allocate
+	 * memory from any special address range. So we do it on
+	 * our own.
+	 *                     Dai, Wed Jun 13 19:34:23 PDT 2001
+	 */
+	if (1)
+		data = (u8 *)pci_alloc_consistent(0,size + sizeof(struct skb_shared_info), NULL);
+	else
+#endif
 	data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
 	if (data == NULL)
 		goto nodata;
