Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2006 13:50:49 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:38327 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20041131AbWHHMtS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Aug 2006 13:49:18 +0100
Received: by nf-out-0910.google.com with SMTP id o60so240925nfa
        for <linux-mips@linux-mips.org>; Tue, 08 Aug 2006 05:49:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WS0doi4gX/6uWblOtUwuMeWp+vC5XfKFES2gEhc73LPoQ6Su6Mjkuy44x7pJd3kom2owbmnOqkeK2mIjmIq52PfW//a7v5ct1zpQN3Eik3+gVzuL9n5yBUEsNaRh19RAmvRcPKHqvwyh81lusaHt5V11Gj5zWdd36XKCJi+3lK4=
Received: by 10.49.8.4 with SMTP id l4mr550656nfi;
        Tue, 08 Aug 2006 05:49:14 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id y24sm765663nfb.2006.08.08.05.49.13;
        Tue, 08 Aug 2006 05:49:14 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id B83D723F759; Tue,  8 Aug 2006 14:48:32 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp, Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 1/6] setup.c: cleanup bootmem_init()
Date:	Tue,  8 Aug 2006 14:48:27 +0200
Message-Id: <1155041312225-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <1155041312273-git-send-email-vagabon.xyz@gmail.com>
References: <1155041312273-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

This function although doing simple thing is hard to follow. It's
mainly due to:

    - a lot of #ifdef
    - bad local names
    - redundant tests

So this patch try to address these issues. It also do not use
max_pfn global which is marked as an unused exported symbol.

As a bonus side, it's now really easy to see what part of the
code is for no-numa system.

There's also no point to make this function inline.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/setup.c |  135 +++++++++++++++++++---------------------------
 1 files changed, 57 insertions(+), 78 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8c2b596..e331e63 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -96,6 +96,12 @@ void __init add_memory_region(phys_t sta
 	int x = boot_mem_map.nr_map;
 	struct boot_mem_map_entry *prev = boot_mem_map.map + x - 1;
 
+	/* Sanity check */
+	if (start + size < start) {
+		printk("Trying to add an invalid memory region, skipped\n");
+		return;
+	}
+
 	/*
 	 * Try to merge with previous entry if any.  This is far less than
 	 * perfect but is sufficient for most real world cases.
@@ -257,15 +263,16 @@ #endif
 	return 0;
 }
 
-#define MAXMEM		HIGHMEM_START
-#define MAXMEM_PFN	PFN_DOWN(MAXMEM)
-
-static inline void bootmem_init(void)
+/*
+ * Initialize the bootmem allocator. It also setup initrd related data
+ * if needed.
+ */
+static void __init bootmem_init(void)
 {
-	unsigned long start_pfn;
 	unsigned long reserved_end = (unsigned long)&_end;
 #ifndef CONFIG_SGI_IP27
-	unsigned long first_usable_pfn;
+	unsigned long highest = 0;
+	unsigned long mapstart = -1UL;
 	unsigned long bootmap_size;
 	int i;
 #endif
@@ -281,7 +288,7 @@ #ifdef CONFIG_BLK_DEV_INITRD
 		unsigned long tmp;
 		u32 *initrd_header;
 
-		tmp = ((reserved_end + PAGE_SIZE-1) & PAGE_MASK) - sizeof(u32) * 2;
+		tmp = PAGE_ALIGN(reserved_end) - sizeof(u32) * 2;
 		if (tmp < reserved_end)
 			tmp += PAGE_SIZE;
 		initrd_header = (u32 *)tmp;
@@ -294,16 +301,15 @@ #ifdef CONFIG_BLK_DEV_INITRD
 	}
 #endif	/* CONFIG_BLK_DEV_INITRD */
 
+#ifndef CONFIG_SGI_IP27
 	/*
-	 * Partially used pages are not usable - thus
-	 * we are rounding upwards.
+	 * reserved_end is now a pfn
 	 */
-	start_pfn = PFN_UP(CPHYSADDR(reserved_end));
+	reserved_end = PFN_UP(CPHYSADDR(reserved_end));
 
-#ifndef CONFIG_SGI_IP27
-	/* Find the highest page frame number we have available.  */
-	max_pfn = 0;
-	first_usable_pfn = -1UL;
+	/*
+	 * Find the highest page frame number we have available.
+	 */
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		unsigned long start, end;
 
@@ -312,56 +318,38 @@ #ifndef CONFIG_SGI_IP27
 
 		start = PFN_UP(boot_mem_map.map[i].addr);
 		end = PFN_DOWN(boot_mem_map.map[i].addr
-		      + boot_mem_map.map[i].size);
+				+ boot_mem_map.map[i].size);
 
-		if (start >= end)
+		if (end > highest)
+			highest = end;
+		if (end <= reserved_end)
 			continue;
-		if (end > max_pfn)
-			max_pfn = end;
-		if (start < first_usable_pfn) {
-			if (start > start_pfn) {
-				first_usable_pfn = start;
-			} else if (end > start_pfn) {
-				first_usable_pfn = start_pfn;
-			}
-		}
+		if (start >= mapstart)
+			continue;
+		mapstart = max(reserved_end, start);
 	}
 
 	/*
 	 * Determine low and high memory ranges
 	 */
-	max_low_pfn = max_pfn;
-	if (max_low_pfn > MAXMEM_PFN) {
-		max_low_pfn = MAXMEM_PFN;
-#ifndef CONFIG_HIGHMEM
-		/* Maximum memory usable is what is directly addressable */
-		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
-		       MAXMEM >> 20);
-		printk(KERN_WARNING "Use a HIGHMEM enabled kernel.\n");
+	if (highest > PFN_DOWN(HIGHMEM_START)) {
+#ifdef CONFIG_HIGHMEM
+		highstart_pfn = PFN_DOWN(HIGHMEM_START);
+		highend_pfn = highest;
 #endif
+		highest = PFN_DOWN(HIGHMEM_START);
 	}
 
-#ifdef CONFIG_HIGHMEM
 	/*
-	 * Crude, we really should make a better attempt at detecting
-	 * highstart_pfn
+	 * Initialize the boot-time allocator with low memory only.
 	 */
-	highstart_pfn = highend_pfn = max_pfn;
-	if (max_pfn > MAXMEM_PFN) {
-		highstart_pfn = MAXMEM_PFN;
-		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
-		       (highend_pfn - highstart_pfn) >> (20 - PAGE_SHIFT));
-	}
-#endif
-
-	/* Initialize the boot-time allocator with low memory only.  */
-	bootmap_size = init_bootmem(first_usable_pfn, max_low_pfn);
+	bootmap_size = init_bootmem(mapstart, highest);
 
 	/*
 	 * Register fully available low RAM pages with the bootmem allocator.
 	 */
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		unsigned long curr_pfn, last_pfn, size;
+		unsigned long start, end, size;
 
 		/*
 		 * Reserve usable memory.
@@ -369,49 +357,37 @@ #endif
 		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
 			continue;
 
-		/*
-		 * We are rounding up the start address of usable memory:
-		 */
-		curr_pfn = PFN_UP(boot_mem_map.map[i].addr);
-		if (curr_pfn >= max_low_pfn)
-			continue;
-		if (curr_pfn < start_pfn)
-			curr_pfn = start_pfn;
-
-		/*
-		 * ... and at the end of the usable range downwards:
-		 */
-		last_pfn = PFN_DOWN(boot_mem_map.map[i].addr
+		start = PFN_UP(boot_mem_map.map[i].addr);
+		end   = PFN_DOWN(boot_mem_map.map[i].addr
 				    + boot_mem_map.map[i].size);
-
-		if (last_pfn > max_low_pfn)
-			last_pfn = max_low_pfn;
-
 		/*
-		 * Only register lowmem part of lowmem segment with bootmem.
+		 * We are rounding up the start address of usable memory 
+		 * and at the end of the usable range downwards.
 		 */
-		size = last_pfn - curr_pfn;
-		if (curr_pfn > PFN_DOWN(HIGHMEM_START))
-			continue;
-		if (curr_pfn + size - 1 > PFN_DOWN(HIGHMEM_START))
-			size = PFN_DOWN(HIGHMEM_START) - curr_pfn;
-		if (!size)
+		if (start >= max_low_pfn)
 			continue;
+		if (start < reserved_end)
+			start = reserved_end;
+		if (end > max_low_pfn)
+			end = max_low_pfn;
 
 		/*
-		 * ... finally, did all the rounding and playing
-		 * around just make the area go away?
+		 * ... finally, is the area going away?
 		 */
-		if (last_pfn <= curr_pfn)
+		if (end <= start)
 			continue;
+		size = end - start;
 
 		/* Register lowmem ranges */
-		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));
-		memory_present(0, curr_pfn, curr_pfn + size - 1);
+		free_bootmem(PFN_PHYS(start), size << PAGE_SHIFT);
+		memory_present(0, start, end);
 	}
 
-	/* Reserve the bootmap memory.  */
-	reserve_bootmem(PFN_PHYS(first_usable_pfn), bootmap_size);
+	/*
+	 * Reserve the bootmap memory.
+	 */
+	reserve_bootmem(PFN_PHYS(mapstart), bootmap_size);
+
 #endif /* CONFIG_SGI_IP27 */
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -483,6 +459,9 @@ static void __init arch_mem_init(char **
 	paging_init();
 }
 
+#define MAXMEM		HIGHMEM_START
+#define MAXMEM_PFN	PFN_DOWN(MAXMEM)
+
 static inline void resource_init(void)
 {
 	int i;
-- 
1.4.2.rc2
