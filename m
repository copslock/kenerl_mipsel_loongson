Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2012 23:58:26 +0200 (CEST)
Received: from shelob.surriel.com ([74.92.59.67]:39539 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903472Ab2FUV6P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jun 2012 23:58:15 +0200
Received: from [2002:4a5c:3b41:1:224:e8ff:fe38:995c] (helo=annuminas.surriel.com)
        by shelob.surriel.com with esmtp (Exim 4.63)
        (envelope-from <riel@surriel.com>)
        id 1ShpNX-0006VJ-QW; Thu, 21 Jun 2012 17:57:27 -0400
Received: from annuminas.surriel.com (localhost.localdomain [127.0.0.1])
        by annuminas.surriel.com (8.14.5/8.14.5) with ESMTP id q5LLvR2Z028685;
        Thu, 21 Jun 2012 17:57:27 -0400
Received: (from riel@localhost)
        by annuminas.surriel.com (8.14.5/8.14.5/Submit) id q5LLvQVt028684;
        Thu, 21 Jun 2012 17:57:26 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, aarcange@redhat.com,
        peterz@infradead.org, minchan@gmail.com, kosaki.motohiro@gmail.com,
        andi@firstfloor.org, hannes@cmpxchg.org, mel@csn.ul.ie,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Ralf Baechle <ralf@linux-mips.org>, sjhill@mips.com,
        linux-mips@linux-mips.org, Rik van Riel <riel@redhat.com>
Subject: [PATCH -mm v2 09/11] mm: remove MIPS arch_get_unmapped_area code
Date:   Thu, 21 Jun 2012 17:57:13 -0400
Message-Id: <1340315835-28571-10-git-send-email-riel@surriel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1340315835-28571-1-git-send-email-riel@surriel.com>
References: <1340315835-28571-1-git-send-email-riel@surriel.com>
X-archive-position: 33756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: riel@surriel.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Remove all the MIPS specific arch_get_unmapped_area(_topdown) and
page colouring code, now that the generic code should be able to
handle things.

Untested, because I do not have any MIPS systems.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: sjhill@mips.com
Cc: linux-mips@linux-mips.org
Signed-off-by: Rik van Riel <riel@redhat.com>
---
 arch/mips/include/asm/pgtable.h |    8 --
 arch/mips/mm/mmap.c             |  175 ---------------------------------------
 2 files changed, 0 insertions(+), 183 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index f133a4c..5f9c49a 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -410,14 +410,6 @@ int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
 #endif
 
 /*
- * We provide our own get_unmapped area to cope with the virtual aliasing
- * constraints placed on us by the cache architecture.
- */
-#define HAVE_ARCH_UNMAPPED_AREA
-#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
-#define HAVE_ARCH_ALIGN_ADDR
-
-/*
  * No page table caches to initialise
  */
 #define pgtable_cache_init()	do { } while (0)
diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index 3f8af17..ac342bd 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -15,9 +15,6 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 
-unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
-EXPORT_SYMBOL(shm_align_mask);
-
 /* gap between mmap and stack */
 #define MIN_GAP (128*1024*1024UL)
 #define MAX_GAP ((TASK_SIZE)/6*5)
@@ -45,178 +42,6 @@ static unsigned long mmap_base(unsigned long rnd)
 	return PAGE_ALIGN(TASK_SIZE - gap - rnd);
 }
 
-static inline unsigned long COLOUR_ALIGN_DOWN(unsigned long addr,
-					      unsigned long pgoff)
-{
-	unsigned long base = addr & ~shm_align_mask;
-	unsigned long off = (pgoff << PAGE_SHIFT) & shm_align_mask;
-
-	if (base + off <= addr)
-		return base + off;
-
-	return base - off;
-}
-
-#define COLOUR_ALIGN(addr, pgoff)				\
-	((((addr) + shm_align_mask) & ~shm_align_mask) +	\
-	 (((pgoff) << PAGE_SHIFT) & shm_align_mask))
-
-static unsigned long arch_get_unmapped_area_common(struct file *filp,
-	unsigned long addr0, unsigned long len, unsigned long pgoff,
-	unsigned long flags, enum mmap_allocation_direction dir)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	unsigned long addr = addr0;
-	int do_color_align;
-
-	if (unlikely(len > TASK_SIZE))
-		return -ENOMEM;
-
-	if (flags & MAP_FIXED) {
-		/* Even MAP_FIXED mappings must reside within TASK_SIZE */
-		if (TASK_SIZE - len < addr)
-			return -EINVAL;
-
-		/*
-		 * We do not accept a shared mapping if it would violate
-		 * cache aliasing constraints.
-		 */
-		if ((flags & MAP_SHARED) &&
-		    ((addr - (pgoff << PAGE_SHIFT)) & shm_align_mask))
-			return -EINVAL;
-		return addr;
-	}
-
-	do_color_align = 0;
-	if (filp || (flags & MAP_SHARED))
-		do_color_align = 1;
-
-	/* requesting a specific address */
-	if (addr) {
-		if (do_color_align)
-			addr = COLOUR_ALIGN(addr, pgoff);
-		else
-			addr = PAGE_ALIGN(addr);
-
-		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
-		    (!vma || addr + len <= vma->vm_start))
-			return addr;
-	}
-
-	if (dir == ALLOC_UP) {
-		addr = mm->mmap_base;
-		if (do_color_align)
-			addr = COLOUR_ALIGN(addr, pgoff);
-		else
-			addr = PAGE_ALIGN(addr);
-
-		for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
-			/* At this point:  (!vma || addr < vma->vm_end). */
-			if (TASK_SIZE - len < addr)
-				return -ENOMEM;
-			if (!vma || addr + len <= vma->vm_start)
-				return addr;
-			addr = vma->vm_end;
-			if (do_color_align)
-				addr = COLOUR_ALIGN(addr, pgoff);
-		 }
-	 } else {
-		/* check if free_area_cache is useful for us */
-		if (len <= mm->cached_hole_size) {
-			mm->cached_hole_size = 0;
-			mm->free_area_cache = mm->mmap_base;
-		}
-
-		/*
-		 * either no address requested, or the mapping can't fit into
-		 * the requested address hole
-		 */
-		addr = mm->free_area_cache;
-		if (do_color_align) {
-			unsigned long base =
-				COLOUR_ALIGN_DOWN(addr - len, pgoff);
-			addr = base + len;
-		}
-
-		/* make sure it can fit in the remaining address space */
-		if (likely(addr > len)) {
-			vma = find_vma(mm, addr - len);
-			if (!vma || addr <= vma->vm_start) {
-				/* cache the address as a hint for next time */
-				return mm->free_area_cache = addr - len;
-			}
-		}
-
-		if (unlikely(mm->mmap_base < len))
-			goto bottomup;
-
-		addr = mm->mmap_base - len;
-		if (do_color_align)
-			addr = COLOUR_ALIGN_DOWN(addr, pgoff);
-
-		do {
-			/*
-			 * Lookup failure means no vma is above this address,
-			 * else if new region fits below vma->vm_start,
-			 * return with success:
-			 */
-			vma = find_vma(mm, addr);
-			if (likely(!vma || addr + len <= vma->vm_start)) {
-				/* cache the address as a hint for next time */
-				return mm->free_area_cache = addr;
-			}
-
-			/* remember the largest hole we saw so far */
-			if (addr + mm->cached_hole_size < vma->vm_start)
-				mm->cached_hole_size = vma->vm_start - addr;
-
-			/* try just below the current vma->vm_start */
-			addr = vma->vm_start - len;
-			if (do_color_align)
-				addr = COLOUR_ALIGN_DOWN(addr, pgoff);
-		} while (likely(len < vma->vm_start));
-
-bottomup:
-		/*
-		 * A failed mmap() very likely causes application failure,
-		 * so fall back to the bottom-up function here. This scenario
-		 * can happen with large stack limits and large mmap()
-		 * allocations.
-		 */
-		mm->cached_hole_size = ~0UL;
-		mm->free_area_cache = TASK_UNMAPPED_BASE;
-		addr = arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
-		/*
-		 * Restore the topdown base:
-		 */
-		mm->free_area_cache = mm->mmap_base;
-		mm->cached_hole_size = ~0UL;
-
-		return addr;
-	}
-}
-
-unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr0,
-	unsigned long len, unsigned long pgoff, unsigned long flags)
-{
-	return arch_get_unmapped_area_common(filp,
-			addr0, len, pgoff, flags, ALLOC_UP);
-}
-
-/*
- * There is no need to export this but sched.h declares the function as
- * extern so making it static here results in an error.
- */
-unsigned long arch_get_unmapped_area_topdown(struct file *filp,
-	unsigned long addr0, unsigned long len, unsigned long pgoff,
-	unsigned long flags)
-{
-	return arch_get_unmapped_area_common(filp,
-			addr0, len, pgoff, flags, ALLOC_DOWN);
-}
-
 void arch_pick_mmap_layout(struct mm_struct *mm)
 {
 	unsigned long random_factor = 0UL;
-- 
1.7.7.6
