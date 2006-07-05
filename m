Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jul 2006 15:16:40 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:27336 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133536AbWGEOQb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Jul 2006 15:16:31 +0100
Received: from localhost (p8107-ipad212funabasi.chiba.ocn.ne.jp [58.91.172.107])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id AA691B7B6; Wed,  5 Jul 2006 23:16:22 +0900 (JST)
Date:	Wed, 05 Jul 2006 23:17:37 +0900 (JST)
Message-Id: <20060705.231737.59032119.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] do not count pages in holes with sparsemem
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44ABC59C.6070607@innova-card.com>
References: <20060705.221354.74751389.anemo@mba.ocn.ne.jp>
	<44ABC59C.6070607@innova-card.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 05 Jul 2006 15:58:52 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Does SPARSEMEM is the only memory model where we can have memory holes ?
...
> Does this code really need the ifdef CONFIG_SPARSEMEM ? Can't we make
> it generic instead. Only zholes_size[] initialisation really depends
> on the memory model. Of course FLATMEM will let zholes_size as is...
 
Indeed.  Others can have holes, but might be a bit ineffective.

> If I remember correctly free_area_init_node() takes a pfn number as
> fourth parameter: __pa(PAGE_OFFSET) results in a physical address...

You are right.

> BTW why using __pa(OFFSET) ? isn't it going to yield always into 0 ?
> At least on MIPS, it's defined as
> 
> #define __pa(x)	((unsigned long) (x) - PAGE_OFFSET)
> 
> why not using ARCH_PFN_OFFSET instead ?

Indeed.  I copied the code from free_area_init().  I think 0 is enough
for MIPS.  Patch revised.  Thank you for comments.


With some memory model other than FLATMEM, the single node can
contains some holes so there might be many invalid pages.  For
example, with two 256M memory and one 256M hole, some variables
(num_physpage, totalpages, nr_kernel_pages, nr_all_pages, etc.) will
indicate that there are 768MB on this system.  This is not desired
because, for example, alloc_large_system_hash() allocates too many
entries.

Use free_area_init_node() with counted zholes_size[] instead of
free_area_init().

For num_physpages, use number of ram pages instead of max_low_pfn.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 802bdd3..6c68b2a 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -139,10 +139,36 @@ #endif /* CONFIG_HIGHMEM */
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 extern void pagetable_init(void);
 
+static int __init page_is_ram(unsigned long pagenr)
+{
+	int i;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		unsigned long addr, end;
+
+		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+			/* not usable memory */
+			continue;
+
+		addr = PFN_UP(boot_mem_map.map[i].addr);
+		end = PFN_DOWN(boot_mem_map.map[i].addr +
+			       boot_mem_map.map[i].size);
+
+		if (pagenr >= addr && pagenr < end)
+			return 1;
+	}
+
+	return 0;
+}
+
 void __init paging_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned long zones_size[] = { [0 ... MAX_NR_ZONES - 1] = 0 };
 	unsigned long max_dma, high, low;
+	unsigned long zholes_size[] = { [0 ... MAX_NR_ZONES - 1] = 0 };
+#ifndef CONFIG_FLATMEM
+	unsigned long i, j, pfn;
+#endif
 
 	pagetable_init();
 
@@ -174,29 +200,14 @@ #ifdef CONFIG_HIGHMEM
 		zones_size[ZONE_HIGHMEM] = high - low;
 #endif
 
-	free_area_init(zones_size);
-}
-
-static inline int page_is_ram(unsigned long pagenr)
-{
-	int i;
-
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		unsigned long addr, end;
-
-		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
-			/* not usable memory */
-			continue;
-
-		addr = PFN_UP(boot_mem_map.map[i].addr);
-		end = PFN_DOWN(boot_mem_map.map[i].addr +
-			       boot_mem_map.map[i].size);
-
-		if (pagenr >= addr && pagenr < end)
-			return 1;
-	}
-
-	return 0;
+#ifndef CONFIG_FLATMEM
+	pfn = 0;
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		for (j = 0; j < zones_size[i]; j++, pfn++)
+			if (!page_is_ram(pfn))
+				zholes_size[i]++;
+#endif
+	free_area_init_node(0, NODE_DATA(0), zones_size, 0, zholes_size);
 }
 
 static struct kcore_list kcore_mem, kcore_vmalloc;
@@ -213,9 +224,9 @@ #ifdef CONFIG_HIGHMEM
 #ifdef CONFIG_DISCONTIGMEM
 #error "CONFIG_HIGHMEM and CONFIG_DISCONTIGMEM dont work together yet"
 #endif
-	max_mapnr = num_physpages = highend_pfn;
+	max_mapnr = highend_pfn;
 #else
-	max_mapnr = num_physpages = max_low_pfn;
+	max_mapnr = max_low_pfn;
 #endif
 	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
@@ -229,6 +240,7 @@ #endif
 			if (PageReserved(pfn_to_page(tmp)))
 				reservedpages++;
 		}
+	num_physpages = ram;
 
 #ifdef CONFIG_HIGHMEM
 	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
@@ -247,6 +259,7 @@ #endif
 		totalhigh_pages++;
 	}
 	totalram_pages += totalhigh_pages;
+	num_physpages += totalhigh_pages;
 #endif
 
 	codesize =  (unsigned long) &_etext - (unsigned long) &_text;
