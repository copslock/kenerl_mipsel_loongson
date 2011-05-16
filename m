From: Jian Peng <jipeng2005@gmail.com>
Date: Mon, 16 May 2011 12:07:37 -0700
Subject: [PATCH 1/1] MIPS: topdown mmap support
Message-ID: <20110516190737.iMmd4MAqo2J9-t6yrKuAViDB68eSZtubBMLRAa6D7iY@z>

This patch introduced topdown mmap support in user process address
space allocation policy.

Recently, we ran some large applications that use mmap heavily and
lead to OOM due to inflexible mmap allocation policy on MIPS32.

Since most other major archs supported it for years, it is reasonable
to follow the trend and reduce the pain of porting applications.

Due to cache aliasing concern, arch_get_unmapped_area_topdown() and
other helper functions are implemented in arch/mips/kernel/syscall.c.

Signed-off-by: Jian Peng <jipeng2005@gmail.com>
---
 arch/mips/include/asm/pgtable.h |    1 +
 arch/mips/kernel/syscall.c      |  180 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 178 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 7e40f37..b2202a6 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -414,6 +414,7 @@ int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
  * constraints placed on us by the cache architecture.
  */
 #define HAVE_ARCH_UNMAPPED_AREA
+#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 
 /*
  * No page table caches to initialise
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 58beabf..beda0ee 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -42,6 +42,7 @@
 #include <asm/shmparam.h>
 #include <asm/sysmips.h>
 #include <asm/uaccess.h>
+#include <linux/personality.h>
 
 /*
  * For historic reasons the pipe(2) syscall on MIPS has an unusual calling
@@ -70,6 +71,54 @@ unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
 
 EXPORT_SYMBOL(shm_align_mask);
 
+/* gap between mmap and stack */
+#define MIN_GAP (128*1024*1024UL)
+#define MAX_GAP(task_size)	((task_size)/6*5)
+
+/* add mmap layout code */
+static int mmap_is_legacy(void)
+{
+	if (current->personality & ADDR_COMPAT_LAYOUT)
+		return 1;
+
+	if (rlimit(RLIMIT_STACK) == RLIM_INFINITY)
+		return 1;
+
+	return sysctl_legacy_va_layout;
+}
+
+static unsigned long mmap_base(unsigned long rnd)
+{
+	unsigned long gap = rlimit(RLIMIT_STACK);
+	unsigned long task_size;
+
+#ifdef CONFIG_32BIT
+	task_size = TASK_SIZE;
+#else /* Must be CONFIG_64BIT*/
+	task_size = test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE;
+#endif
+
+	if (gap < MIN_GAP)
+		gap = MIN_GAP;
+	else if (gap > MAX_GAP(task_size))
+		gap = MAX_GAP(task_size);
+
+	return PAGE_ALIGN(task_size - gap - rnd);
+}
+
+/* add COLOUR_ALIGN_DOWN */
+static inline unsigned long COLOUR_ALIGN_DOWN(unsigned long addr,
+					      unsigned long pgoff)
+{
+	unsigned long base = addr & ~shm_align_mask;
+	unsigned long off = (pgoff << PAGE_SHIFT) & shm_align_mask;
+
+	if (base + off <= addr)
+		return base + off;
+
+	return base - off;
+}
+
 #define COLOUR_ALIGN(addr,pgoff)				\
 	((((addr) + shm_align_mask) & ~shm_align_mask) +	\
 	 (((pgoff) << PAGE_SHIFT) & shm_align_mask))
@@ -136,6 +185,125 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	}
 }
 
+/* add  arch_get_unmapped_area_topdown */
+unsigned long
+arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
+			  const unsigned long len, const unsigned long pgoff,
+			  const unsigned long flags)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm = current->mm;
+	unsigned long addr = addr0;
+	int do_colour_align;
+	unsigned long task_size;
+
+#ifdef CONFIG_32BIT
+	task_size = TASK_SIZE;
+#else /* Must be CONFIG_64BIT*/
+	task_size = test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE;
+#endif
+
+	if (flags & MAP_FIXED) {
+		/* We do not accept a shared mapping if it would violate
+		 * cache aliasing constraints.
+		 */
+		if ((flags & MAP_SHARED) &&
+		    ((addr - (pgoff << PAGE_SHIFT)) & shm_align_mask))
+			return -EINVAL;
+		return addr;
+	}
+
+	if (unlikely(len > task_size))
+		return -ENOMEM;
+
+	do_colour_align = 0;
+	if (filp || (flags & MAP_SHARED))
+		do_colour_align = 1;
+
+	/* requesting a specific address */
+	if (addr) {
+		if (do_colour_align)
+			addr = COLOUR_ALIGN(addr, pgoff);
+		else
+			addr = PAGE_ALIGN(addr);
+
+		vma = find_vma(mm, addr);
+		if (task_size - len >= addr &&
+		    (!vma || addr + len <= vma->vm_start))
+			return addr;
+	}
+
+	/* check if free_area_cache is useful for us */
+	if (len <= mm->cached_hole_size) {
+		mm->cached_hole_size = 0;
+		mm->free_area_cache = mm->mmap_base;
+	}
+
+	/* either no address requested or can't fit in requested address hole */
+	addr = mm->free_area_cache;
+	if (do_colour_align) {
+		unsigned long base = COLOUR_ALIGN_DOWN(addr-len, pgoff);
+
+		addr = base + len;
+	}
+
+	/* make sure it can fit in the remaining address space */
+	if (likely(addr > len)) {
+		vma = find_vma(mm, addr-len);
+		if (!vma || addr <= vma->vm_start) {
+			/* remember the address as a hint for next time */
+			return mm->free_area_cache = addr-len;
+		}
+	}
+
+	if (unlikely(mm->mmap_base < len))
+		goto bottomup;
+
+	addr = mm->mmap_base-len;
+	if (do_colour_align)
+		addr = COLOUR_ALIGN_DOWN(addr, pgoff);
+
+	do {
+		/*
+		 * Lookup failure means no vma is above this address,
+		 * else if new region fits below vma->vm_start,
+		 * return with success:
+		 */
+		vma = find_vma(mm, addr);
+		if (likely(!vma || addr+len <= vma->vm_start)) {
+			/* remember the address as a hint for next time */
+			return mm->free_area_cache = addr;
+		}
+
+		/* remember the largest hole we saw so far */
+		if (addr + mm->cached_hole_size < vma->vm_start)
+			mm->cached_hole_size = vma->vm_start - addr;
+
+		/* try just below the current vma->vm_start */
+		addr = vma->vm_start-len;
+		if (do_colour_align)
+			addr = COLOUR_ALIGN_DOWN(addr, pgoff);
+	} while (likely(len < vma->vm_start));
+
+bottomup:
+	/*
+	 * A failed mmap() very likely causes application failure,
+	 * so fall back to the bottom-up function here. This scenario
+	 * can happen with large stack limits and large mmap()
+	 * allocations.
+	 */
+	mm->cached_hole_size = ~0UL;
+	mm->free_area_cache = TASK_UNMAPPED_BASE;
+	addr = arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
+	/*
+	 * Restore the topdown base:
+	 */
+	mm->free_area_cache = mm->mmap_base;
+	mm->cached_hole_size = ~0UL;
+
+	return addr;
+}
+
 void arch_pick_mmap_layout(struct mm_struct *mm)
 {
 	unsigned long random_factor = 0UL;
@@ -149,9 +317,15 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 			random_factor &= 0xffffffful;
 	}
 
-	mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
-	mm->get_unmapped_area = arch_get_unmapped_area;
-	mm->unmap_area = arch_unmap_area;
+	if (mmap_is_legacy()) {
+		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
+		mm->get_unmapped_area = arch_get_unmapped_area;
+		mm->unmap_area = arch_unmap_area;
+	} else {
+		mm->mmap_base = mmap_base(random_factor);
+		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
+		mm->unmap_area = arch_unmap_area_topdown;
+	}
 }
 
 static inline unsigned long brk_rnd(void)
-- 
1.7.4.1
