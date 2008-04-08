Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2008 23:47:42 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:31403 "EHLO elvis.franken.de")
	by lappi.linux-mips.net with ESMTP id S537510AbYDHVrK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2008 23:47:10 +0200
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JjLbj-0000LK-00; Tue, 08 Apr 2008 23:43:59 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id ECFF7C2C03; Tue,  8 Apr 2008 23:43:46 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] IP27: Fix bootmem memory setup
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080408214346.ECFF7C2C03@solo.franken.de>
Date:	Tue,  8 Apr 2008 23:43:46 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Changes in the generic bootmem code broke memory setup for IP27. This
patch fixes this by replacing lots of special IP27 code with generic
bootmon code. This has been tested only on a single node.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/sgi-ip27/ip27-memory.c |  119 +++++++------------------------------
 1 files changed, 23 insertions(+), 96 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index bf438d0..aedbc28 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -33,10 +33,6 @@
 #define SLOT_PFNSHIFT           (SLOT_SHIFT - PAGE_SHIFT)
 #define PFN_NASIDSHFT           (NASID_SHFT - PAGE_SHIFT)
 
-#define SLOT_IGNORED		0xffff
-
-static short __initdata slot_lastfilled_cache[MAX_COMPACT_NODES];
-static unsigned short __initdata slot_psize_cache[MAX_COMPACT_NODES][MAX_MEM_SLOTS];
 static struct bootmem_data __initdata plat_node_bdata[MAX_COMPACT_NODES];
 
 struct node_data *__node_data[MAX_COMPACT_NODES];
@@ -267,51 +263,6 @@ static pfn_t __init slot_getbasepfn(cnodeid_t cnode, int slot)
 	return ((pfn_t)nasid << PFN_NASIDSHFT) | (slot << SLOT_PFNSHIFT);
 }
 
-/*
- * Return the number of pages of memory provided by the given slot
- * on the specified node.
- */
-static pfn_t __init slot_getsize(cnodeid_t node, int slot)
-{
-	return (pfn_t) slot_psize_cache[node][slot];
-}
-
-/*
- * Return highest slot filled
- */
-static int __init node_getlastslot(cnodeid_t node)
-{
-	return (int) slot_lastfilled_cache[node];
-}
-
-/*
- * Return the pfn of the last free page of memory on a node.
- */
-static pfn_t __init node_getmaxclick(cnodeid_t node)
-{
-	pfn_t	slot_psize;
-	int	slot;
-
-	/*
-	 * Start at the top slot. When we find a slot with memory in it,
-	 * that's the winner.
-	 */
-	for (slot = (MAX_MEM_SLOTS - 1); slot >= 0; slot--) {
-		if ((slot_psize = slot_getsize(node, slot))) {
-			if (slot_psize == SLOT_IGNORED)
-				continue;
-			/* Return the basepfn + the slot size, minus 1. */
-			return slot_getbasepfn(node, slot) + slot_psize - 1;
-		}
-	}
-
-	/*
-	 * If there's no memory on the node, return 0. This is likely
-	 * to cause problems.
-	 */
-	return 0;
-}
-
 static pfn_t __init slot_psize_compute(cnodeid_t node, int slot)
 {
 	nasid_t nasid;
@@ -404,13 +355,13 @@ static void __init mlreset(void)
 static void __init szmem(void)
 {
 	pfn_t slot_psize, slot0sz = 0, nodebytes;	/* Hack to detect problem configs */
-	int slot, ignore;
+	int slot;
 	cnodeid_t node;
 
 	num_physpages = 0;
 
 	for_each_online_node(node) {
-		ignore = nodebytes = 0;
+		nodebytes = 0;
 		for (slot = 0; slot < MAX_MEM_SLOTS; slot++) {
 			slot_psize = slot_psize_compute(node, slot);
 			if (slot == 0)
@@ -420,21 +371,20 @@ static void __init szmem(void)
 			 * kernel text.
 			 */
 			nodebytes += (1LL << SLOT_SHIFT);
+			
+			if (!slot_psize)
+				continue;
+			
 			if ((nodebytes >> PAGE_SHIFT) * (sizeof(struct page)) >
-						(slot0sz << PAGE_SHIFT))
-				ignore = 1;
-			if (ignore && slot_psize) {
+						(slot0sz << PAGE_SHIFT)) {
 				printk("Ignoring slot %d onwards on node %d\n",
 								slot, node);
-				slot_psize_cache[node][slot] = SLOT_IGNORED;
 				slot = MAX_MEM_SLOTS;
 				continue;
 			}
 			num_physpages += slot_psize;
-			slot_psize_cache[node][slot] =
-					(unsigned short) slot_psize;
-			if (slot_psize)
-				slot_lastfilled_cache[node] = slot;
+			add_active_range(node, slot_getbasepfn(node, slot),
+					 slot_getbasepfn(node, slot) + slot_psize);
 		}
 	}
 }
@@ -442,18 +392,20 @@ static void __init szmem(void)
 static void __init node_mem_init(cnodeid_t node)
 {
 	pfn_t slot_firstpfn = slot_getbasepfn(node, 0);
-	pfn_t slot_lastpfn = slot_firstpfn + slot_getsize(node, 0);
 	pfn_t slot_freepfn = node_getfirstfree(node);
-	struct pglist_data *pd;
 	unsigned long bootmap_size;
+	pfn_t start_pfn, end_pfn;
+	
+	get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
 
 	/*
 	 * Allocate the node data structures on the node first.
 	 */
 	__node_data[node] = __va(slot_freepfn << PAGE_SHIFT);
 
-	pd = NODE_DATA(node);
-	pd->bdata = &plat_node_bdata[node];
+	NODE_DATA(node)->bdata = &plat_node_bdata[node];
+	NODE_DATA(node)->node_start_pfn = start_pfn;
+	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
 
 	cpus_clear(hub_data(node)->h_cpus);
 
@@ -461,12 +413,12 @@ static void __init node_mem_init(cnodeid_t node)
 			       sizeof(struct hub_data));
 
   	bootmap_size = init_bootmem_node(NODE_DATA(node), slot_freepfn,
-					slot_firstpfn, slot_lastpfn);
-	free_bootmem_node(NODE_DATA(node), slot_firstpfn << PAGE_SHIFT,
-			(slot_lastpfn - slot_firstpfn) << PAGE_SHIFT);
+					start_pfn, end_pfn);
+	free_bootmem_with_active_regions(node, end_pfn);
 	reserve_bootmem_node(NODE_DATA(node), slot_firstpfn << PAGE_SHIFT,
 		((slot_freepfn - slot_firstpfn) << PAGE_SHIFT) + bootmap_size,
 		BOOTMEM_DEFAULT);
+	sparse_memory_present_with_active_regions(node);
 }
 
 /*
@@ -515,16 +467,15 @@ void __init paging_init(void)
 	pagetable_init();
 
 	for_each_online_node(node) {
-		pfn_t start_pfn = slot_getbasepfn(node, 0);
-		pfn_t end_pfn = node_getmaxclick(node) + 1;
-
-		zones_size[ZONE_NORMAL] = end_pfn - start_pfn;
-		free_area_init_node(node, NODE_DATA(node),
-				zones_size, start_pfn, NULL);
+		pfn_t start_pfn, end_pfn;
+		
+		get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
 
 		if (end_pfn > max_low_pfn)
 			max_low_pfn = end_pfn;
 	}
+	zones_size[ZONE_NORMAL] = max_low_pfn;
+	free_area_init_nodes(zones_size);
 }
 
 void __init mem_init(void)
@@ -535,34 +486,10 @@ void __init mem_init(void)
 	high_memory = (void *) __va(num_physpages << PAGE_SHIFT);
 
 	for_each_online_node(node) {
-		unsigned slot, numslots;
-		struct page *end, *p;
-
 		/*
 		 * This will free up the bootmem, ie, slot 0 memory.
 		 */
 		totalram_pages += free_all_bootmem_node(NODE_DATA(node));
-
-		/*
-		 * We need to manually do the other slots.
-		 */
-		numslots = node_getlastslot(node);
-		for (slot = 1; slot <= numslots; slot++) {
-			p = nid_page_nr(node, slot_getbasepfn(node, slot) -
-					      slot_getbasepfn(node, 0));
-
-			/*
-			 * Free valid memory in current slot.
-			 */
-			for (end = p + slot_getsize(node, slot); p < end; p++) {
-				/* if (!page_is_ram(pgnr)) continue; */
-				/* commented out until page_is_ram works */
-				ClearPageReserved(p);
-				init_page_count(p);
-				__free_page(p);
-				totalram_pages++;
-			}
-		}
 	}
 
 	totalram_pages -= setup_zero_pages();	/* This comes from node 0 */
