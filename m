Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 16:19:55 +0100 (CET)
Received: from mga09.intel.com ([134.134.136.24]:64874 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013734AbaKNPSdQCr83 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Nov 2014 16:18:33 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 14 Nov 2014 07:16:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,386,1413270000"; 
   d="scan'208";a="607882386"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.23.232.122])
  by orsmga001.jf.intel.com with ESMTP; 14 Nov 2014 07:18:31 -0800
Subject: [PATCH 10/11] x86, mpx: cleanup unused bound tables
To:     hpa@zytor.com
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        qiaowei.ren@intel.com, Dave Hansen <dave@sr71.net>,
        dave.hansen@linux.intel.com
From:   Dave Hansen <dave@sr71.net>
Date:   Fri, 14 Nov 2014 07:18:31 -0800
References: <20141114151816.F56A3072@viggo.jf.intel.com>
In-Reply-To: <20141114151816.F56A3072@viggo.jf.intel.com>
Message-Id: <20141114151831.E4531C4A@viggo.jf.intel.com>
Return-Path: <dave@sr71.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave@sr71.net
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


From: Dave Hansen <dave.hansen@linux.intel.com>

The previous patch allocates bounds tables on-demand.  As noted in
an earlier description, these can add up to *HUGE* amounts of
memory.  This has caused OOMs in practice when running tests.

This patch adds support for freeing bounds tables when they are no
longer in use.

There are two types of mappings in play when unmapping tables:
 1. The mapping with the actual data, which userspace is
    munmap()ing or brk()ing away, etc...
 2. The mapping for the bounds table *backing* the data
    (is tagged with VM_MPX, see the patch "add MPX specific
    mmap interface").

If userspace use the prctl() indroduced earlier in this patchset
to enable the management of bounds tables in kernel, when it
unmaps the first type of mapping with the actual data, the kernel
needs to free the mapping for the bounds table backing the data.
This patch hooks in at the very end of do_unmap() to do so.
We look at the addresses being unmapped and find the bounds
directory entries and tables which cover those addresses.  If
an entire table is unused, we clear associated directory entry
and free the table.

Once we unmap the bounds table, we would have a bounds directory
entry pointing at empty address space. That address space might
now be allocated for some other (random) use, and the MPX
hardware might now try to walk it as if it were a bounds table.
That would be bad.  So any unmapping of an enture bounds table
has to be accompanied by a corresponding write to the bounds
directory entry to invalidate it.  That write to the bounds
directory can fault, which causes the following problem:

Since we are doing the freeing from munmap() (and other paths
like it), we hold mmap_sem for write. If we fault, the page
fault handler will attempt to acquire mmap_sem for read and
we will deadlock.  To avoid the deadlock, we pagefault_disable()
when touching the bounds directory entry and use a
get_user_pages() to resolve the fault.

The unmapping of bounds tables happends under vm_munmap().  We
also (indirectly) call vm_munmap() to _do_ the unmapping of the
bounds tables.  We avoid unbounded recursion by disallowing
freeing of bounds tables *for* bounds tables.  This would not
occur normally, so should not have any practical impact.  Being
strict about it here helps ensure that we do not have an
exploitable stack overflow.

Signed-off-by: Qiaowei Ren <qiaowei.ren@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/mmu_context.h |    7 
 b/arch/x86/include/asm/mpx.h         |   14 +
 b/arch/x86/mm/mpx.c                  |  393 +++++++++++++++++++++++++++++++++++
 b/include/asm-generic/mmu_context.h  |    6 
 b/mm/mmap.c                          |    2 
 5 files changed, 422 insertions(+)

diff -puN arch/x86/include/asm/mmu_context.h~mpx-v11-cleanup-unused-bound-tables arch/x86/include/asm/mmu_context.h
--- a/arch/x86/include/asm/mmu_context.h~mpx-v11-cleanup-unused-bound-tables	2014-11-14 07:06:24.584713396 -0800
+++ b/arch/x86/include/asm/mmu_context.h	2014-11-14 07:06:24.594713847 -0800
@@ -112,4 +112,11 @@ static inline void arch_bprm_mm_init(str
 #endif
 }
 
+static inline void arch_unmap(struct mm_struct *mm,
+		struct vm_area_struct *vma,
+		unsigned long start, unsigned long end)
+{
+	mpx_notify_unmap(mm, vma, start, end);
+}
+
 #endif /* _ASM_X86_MMU_CONTEXT_H */
diff -puN arch/x86/include/asm/mpx.h~mpx-v11-cleanup-unused-bound-tables arch/x86/include/asm/mpx.h
--- a/arch/x86/include/asm/mpx.h~mpx-v11-cleanup-unused-bound-tables	2014-11-14 07:06:24.586713486 -0800
+++ b/arch/x86/include/asm/mpx.h	2014-11-14 07:06:24.595713892 -0800
@@ -51,6 +51,13 @@
 #define MPX_BNDCFG_ADDR_MASK	(~((1UL<<MPX_BNDCFG_TAIL)-1))
 #define MPX_BNDSTA_ERROR_CODE	0x3
 
+#define MPX_BD_ENTRY_MASK	((1<<MPX_BD_ENTRY_OFFSET)-1)
+#define MPX_BT_ENTRY_MASK	((1<<MPX_BT_ENTRY_OFFSET)-1)
+#define MPX_GET_BD_ENTRY_OFFSET(addr)	((((addr)>>(MPX_BT_ENTRY_OFFSET+ \
+		MPX_IGN_BITS)) & MPX_BD_ENTRY_MASK) << MPX_BD_ENTRY_SHIFT)
+#define MPX_GET_BT_ENTRY_OFFSET(addr)	((((addr)>>MPX_IGN_BITS) & \
+		MPX_BT_ENTRY_MASK) << MPX_BT_ENTRY_SHIFT)
+
 #ifdef CONFIG_X86_INTEL_MPX
 siginfo_t *mpx_generate_siginfo(struct pt_regs *regs,
 				struct xsave_struct *xsave_buf);
@@ -63,6 +70,8 @@ static inline void mpx_mm_init(struct mm
 {
 	mm->bd_addr = MPX_INVALID_BOUNDS_DIR;
 }
+void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
+		      unsigned long start, unsigned long end);
 #else
 static inline siginfo_t *mpx_generate_siginfo(struct pt_regs *regs,
 					      struct xsave_struct *xsave_buf)
@@ -80,6 +89,11 @@ static inline int kernel_managing_mpx_ta
 static inline void mpx_mm_init(struct mm_struct *mm)
 {
 }
+static inline void mpx_notify_unmap(struct mm_struct *mm,
+				    struct vm_area_struct *vma,
+				    unsigned long start, unsigned long end)
+{
+}
 #endif /* CONFIG_X86_INTEL_MPX */
 
 #endif /* _ASM_X86_MPX_H */
diff -puN arch/x86/mm/mpx.c~mpx-v11-cleanup-unused-bound-tables arch/x86/mm/mpx.c
--- a/arch/x86/mm/mpx.c~mpx-v11-cleanup-unused-bound-tables	2014-11-14 07:06:24.588713576 -0800
+++ b/arch/x86/mm/mpx.c	2014-11-14 07:06:24.595713892 -0800
@@ -13,6 +13,7 @@
 #include <asm/i387.h>
 #include <asm/insn.h>
 #include <asm/mman.h>
+#include <asm/mmu_context.h>
 #include <asm/mpx.h>
 #include <asm/processor.h>
 #include <asm/xsave.h>
@@ -27,6 +28,11 @@ static struct vm_operations_struct mpx_v
 	.name = mpx_mapping_name,
 };
 
+static int is_mpx_vma(struct vm_area_struct *vma)
+{
+	return (vma->vm_ops == &mpx_vma_ops);
+}
+
 /*
  * This is really a simplified "vm_mmap". it only handles MPX
  * bounds tables (the bounds directory is user-allocated).
@@ -536,3 +542,390 @@ int mpx_handle_bd_fault(struct xsave_str
 	}
 	return 0;
 }
+
+/*
+ * A thin wrapper around get_user_pages().  Returns 0 if the
+ * fault was resolved or -errno if not.
+ */
+static int mpx_resolve_fault(long __user *addr, int write)
+{
+	long gup_ret;
+	int nr_pages = 1;
+	int force = 0;
+
+	gup_ret = get_user_pages(current, current->mm, (unsigned long)addr,
+				 nr_pages, write, force, NULL, NULL);
+	/*
+	 * get_user_pages() returns number of pages gotten.
+	 * 0 means we failed to fault in and get anything,
+	 * probably because 'addr' is bad.
+	 */
+	if (!gup_ret)
+		return -EFAULT;
+	/* Other error, return it */
+	if (gup_ret < 0)
+		return gup_ret;
+	/* must have gup'd a page and gup_ret>0, success */
+	return 0;
+}
+
+/*
+ * Get the base of bounds tables pointed by specific bounds
+ * directory entry.
+ */
+static int get_bt_addr(struct mm_struct *mm,
+			long __user *bd_entry, unsigned long *bt_addr)
+{
+	int ret;
+	int valid_bit;
+
+	if (!access_ok(VERIFY_READ, (bd_entry), sizeof(*bd_entry)))
+		return -EFAULT;
+
+	while (1) {
+		int need_write = 0;
+
+		pagefault_disable();
+		ret = get_user(*bt_addr, bd_entry);
+		pagefault_enable();
+		if (!ret)
+			break;
+		if (ret == -EFAULT)
+			ret = mpx_resolve_fault(bd_entry, need_write);
+		/*
+		 * If we could not resolve the fault, consider it
+		 * userspace's fault and error out.
+		 */
+		if (ret)
+			return ret;
+	}
+
+	valid_bit = *bt_addr & MPX_BD_ENTRY_VALID_FLAG;
+	*bt_addr &= MPX_BT_ADDR_MASK;
+
+	/*
+	 * When the kernel is managing bounds tables, a bounds directory
+	 * entry will either have a valid address (plus the valid bit)
+	 * *OR* be completely empty. If we see a !valid entry *and* some
+	 * data in the address field, we know something is wrong. This
+	 * -EINVAL return will cause a SIGSEGV.
+	 */
+	if (!valid_bit && *bt_addr)
+		return -EINVAL;
+	/*
+	 * Do we have an completely zeroed bt entry?  That is OK.  It
+	 * just means there was no bounds table for this memory.  Make
+	 * sure to distinguish this from -EINVAL, which will cause
+	 * a SEGV.
+	 */
+	if (!valid_bit)
+		return -ENOENT;
+
+	return 0;
+}
+
+/*
+ * Free the backing physical pages of bounds table 'bt_addr'.
+ * Assume start...end is within that bounds table.
+ */
+static int zap_bt_entries(struct mm_struct *mm,
+		unsigned long bt_addr,
+		unsigned long start, unsigned long end)
+{
+	struct vm_area_struct *vma;
+	unsigned long addr, len;
+
+	/*
+	 * Find the first overlapping vma. If vma->vm_start > start, there
+	 * will be a hole in the bounds table. This -EINVAL return will
+	 * cause a SIGSEGV.
+	 */
+	vma = find_vma(mm, start);
+	if (!vma || vma->vm_start > start)
+		return -EINVAL;
+
+	/*
+	 * A NUMA policy on a VM_MPX VMA could cause this bouds table to
+	 * be split. So we need to look across the entire 'start -> end'
+	 * range of this bounds table, find all of the VM_MPX VMAs, and
+	 * zap only those.
+	 */
+	addr = start;
+	while (vma && vma->vm_start < end) {
+		/*
+		 * We followed a bounds directory entry down
+		 * here.  If we find a non-MPX VMA, that's bad,
+		 * so stop immediately and return an error.  This
+		 * probably results in a SIGSEGV.
+		 */
+		if (!is_mpx_vma(vma))
+			return -EINVAL;
+
+		len = min(vma->vm_end, end) - addr;
+		zap_page_range(vma, addr, len, NULL);
+
+		vma = vma->vm_next;
+		addr = vma->vm_start;
+	}
+
+	return 0;
+}
+
+static int unmap_single_bt(struct mm_struct *mm,
+		long __user *bd_entry, unsigned long bt_addr)
+{
+	unsigned long expected_old_val = bt_addr | MPX_BD_ENTRY_VALID_FLAG;
+	unsigned long actual_old_val = 0;
+	int ret;
+
+	while (1) {
+		int need_write = 1;
+
+		pagefault_disable();
+		ret = user_atomic_cmpxchg_inatomic(&actual_old_val, bd_entry,
+						   expected_old_val, 0);
+		pagefault_enable();
+		if (!ret)
+			break;
+		if (ret == -EFAULT)
+			ret = mpx_resolve_fault(bd_entry, need_write);
+		/*
+		 * If we could not resolve the fault, consider it
+		 * userspace's fault and error out.
+		 */
+		if (ret)
+			return ret;
+	}
+	/*
+	 * The cmpxchg was performed, check the results.
+	 */
+	if (actual_old_val != expected_old_val) {
+		/*
+		 * Someone else raced with us to unmap the table.
+		 * There was no bounds table pointed to by the
+		 * directory, so declare success.  Somebody freed
+		 * it.
+		 */
+		if (!actual_old_val)
+			return 0;
+		/*
+		 * Something messed with the bounds directory
+		 * entry.  We hold mmap_sem for read or write
+		 * here, so it could not be a _new_ bounds table
+		 * that someone just allocated.  Something is
+		 * wrong, so pass up the error and SIGSEGV.
+		 */
+		return -EINVAL;
+	}
+
+	/*
+	 * Note, we are likely being called under do_munmap() already. To
+	 * avoid recursion, do_munmap() will check whether it comes
+	 * from one bounds table through VM_MPX flag.
+	 */
+	return do_munmap(mm, bt_addr, MPX_BT_SIZE_BYTES);
+}
+
+/*
+ * If the bounds table pointed by bounds directory 'bd_entry' is
+ * not shared, unmap this whole bounds table. Otherwise, only free
+ * those backing physical pages of bounds table entries covered
+ * in this virtual address region start...end.
+ */
+static int unmap_shared_bt(struct mm_struct *mm,
+		long __user *bd_entry, unsigned long start,
+		unsigned long end, bool prev_shared, bool next_shared)
+{
+	unsigned long bt_addr;
+	int ret;
+
+	ret = get_bt_addr(mm, bd_entry, &bt_addr);
+	/*
+	 * We could see an "error" ret for not-present bounds
+	 * tables (not really an error), or actual errors, but
+	 * stop unmapping either way.
+	 */
+	if (ret)
+		return ret;
+
+	if (prev_shared && next_shared)
+		ret = zap_bt_entries(mm, bt_addr,
+				bt_addr+MPX_GET_BT_ENTRY_OFFSET(start),
+				bt_addr+MPX_GET_BT_ENTRY_OFFSET(end));
+	else if (prev_shared)
+		ret = zap_bt_entries(mm, bt_addr,
+				bt_addr+MPX_GET_BT_ENTRY_OFFSET(start),
+				bt_addr+MPX_BT_SIZE_BYTES);
+	else if (next_shared)
+		ret = zap_bt_entries(mm, bt_addr, bt_addr,
+				bt_addr+MPX_GET_BT_ENTRY_OFFSET(end));
+	else
+		ret = unmap_single_bt(mm, bd_entry, bt_addr);
+
+	return ret;
+}
+
+/*
+ * A virtual address region being munmap()ed might share bounds table
+ * with adjacent VMAs. We only need to free the backing physical
+ * memory of these shared bounds tables entries covered in this virtual
+ * address region.
+ */
+static int unmap_edge_bts(struct mm_struct *mm,
+		unsigned long start, unsigned long end)
+{
+	int ret;
+	long __user *bde_start, *bde_end;
+	struct vm_area_struct *prev, *next;
+	bool prev_shared = false, next_shared = false;
+
+	bde_start = mm->bd_addr + MPX_GET_BD_ENTRY_OFFSET(start);
+	bde_end = mm->bd_addr + MPX_GET_BD_ENTRY_OFFSET(end-1);
+
+	/*
+	 * Check whether bde_start and bde_end are shared with adjacent
+	 * VMAs.
+	 *
+	 * We already unliked the VMAs from the mm's rbtree so 'start'
+	 * is guaranteed to be in a hole. This gets us the first VMA
+	 * before the hole in to 'prev' and the next VMA after the hole
+	 * in to 'next'.
+	 */
+	next = find_vma_prev(mm, start, &prev);
+	if (prev && (mm->bd_addr + MPX_GET_BD_ENTRY_OFFSET(prev->vm_end-1))
+			== bde_start)
+		prev_shared = true;
+	if (next && (mm->bd_addr + MPX_GET_BD_ENTRY_OFFSET(next->vm_start))
+			== bde_end)
+		next_shared = true;
+
+	/*
+	 * This virtual address region being munmap()ed is only
+	 * covered by one bounds table.
+	 *
+	 * In this case, if this table is also shared with adjacent
+	 * VMAs, only part of the backing physical memory of the bounds
+	 * table need be freeed. Otherwise the whole bounds table need
+	 * be unmapped.
+	 */
+	if (bde_start == bde_end) {
+		return unmap_shared_bt(mm, bde_start, start, end,
+				prev_shared, next_shared);
+	}
+
+	/*
+	 * If more than one bounds tables are covered in this virtual
+	 * address region being munmap()ed, we need to separately check
+	 * whether bde_start and bde_end are shared with adjacent VMAs.
+	 */
+	ret = unmap_shared_bt(mm, bde_start, start, end, prev_shared, false);
+	if (ret)
+		return ret;
+	ret = unmap_shared_bt(mm, bde_end, start, end, false, next_shared);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mpx_unmap_tables(struct mm_struct *mm,
+		unsigned long start, unsigned long end)
+{
+	int ret;
+	long __user *bd_entry, *bde_start, *bde_end;
+	unsigned long bt_addr;
+
+	/*
+	 * "Edge" bounds tables are those which are being used by the region
+	 * (start -> end), but that may be shared with adjacent areas.  If they
+	 * turn out to be completely unshared, they will be freed.  If they are
+	 * shared, we will free the backing store (like an MADV_DONTNEED) for
+	 * areas used by this region.
+	 */
+	ret = unmap_edge_bts(mm, start, end);
+	switch (ret) {
+		/* non-present tables are OK */
+		case 0:
+		case -ENOENT:
+			/* Success, or no tables to unmap */
+			break;
+		case -EINVAL:
+		case -EFAULT:
+		default:
+			return ret;
+	}
+
+	/*
+	 * Only unmap the bounds table that are
+	 *   1. fully covered
+	 *   2. not at the edges of the mapping, even if full aligned
+	 */
+	bde_start = mm->bd_addr + MPX_GET_BD_ENTRY_OFFSET(start);
+	bde_end = mm->bd_addr + MPX_GET_BD_ENTRY_OFFSET(end-1);
+	for (bd_entry = bde_start + 1; bd_entry < bde_end; bd_entry++) {
+		ret = get_bt_addr(mm, bd_entry, &bt_addr);
+		switch (ret) {
+			case 0:
+				break;
+			case -ENOENT:
+				/* No table here, try the next one */
+				continue;
+			case -EINVAL:
+			case -EFAULT:
+			default:
+				/*
+				 * Note: we are being strict here.
+				 * Any time we run in to an issue
+				 * unmapping tables, we stop and
+				 * SIGSEGV.
+				 */
+				return ret;
+		}
+
+		ret = unmap_single_bt(mm, bd_entry, bt_addr);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * Free unused bounds tables covered in a virtual address region being
+ * munmap()ed. Assume end > start.
+ *
+ * This function will be called by do_munmap(), and the VMAs covering
+ * the virtual address region start...end have already been split if
+ * necessary, and the 'vma' is the first vma in this range (start -> end).
+ */
+void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end)
+{
+	int ret;
+
+	/*
+	 * Refuse to do anything unless userspace has asked
+	 * the kernel to help manage the bounds tables,
+	 */
+	if (!kernel_managing_mpx_tables(current->mm))
+		return;
+	/*
+	 * This will look across the entire 'start -> end' range,
+	 * and find all of the non-VM_MPX VMAs.
+	 *
+	 * To avoid recursion, if a VM_MPX vma is found in the range
+	 * (start->end), we will not continue follow-up work. This
+	 * recursion represents having bounds tables for bounds tables,
+	 * which should not occur normally. Being strict about it here
+	 * helps ensure that we do not have an exploitable stack overflow.
+	 */
+	do {
+		if (vma->vm_flags & VM_MPX)
+			return;
+		vma = vma->vm_next;
+	} while (vma && vma->vm_start < end);
+
+	ret = mpx_unmap_tables(mm, start, end);
+	if (ret)
+		force_sig(SIGSEGV, current);
+}
diff -puN include/asm-generic/mmu_context.h~mpx-v11-cleanup-unused-bound-tables include/asm-generic/mmu_context.h
--- a/include/asm-generic/mmu_context.h~mpx-v11-cleanup-unused-bound-tables	2014-11-14 07:06:24.589713622 -0800
+++ b/include/asm-generic/mmu_context.h	2014-11-14 07:06:24.596713937 -0800
@@ -47,4 +47,10 @@ static inline void arch_bprm_mm_init(str
 {
 }
 
+static inline void arch_unmap(struct mm_struct *mm,
+			struct vm_area_struct *vma,
+			unsigned long start, unsigned long end)
+{
+}
+
 #endif /* __ASM_GENERIC_MMU_CONTEXT_H */
diff -puN mm/mmap.c~mpx-v11-cleanup-unused-bound-tables mm/mmap.c
--- a/mm/mmap.c~mpx-v11-cleanup-unused-bound-tables	2014-11-14 07:06:24.591713712 -0800
+++ b/mm/mmap.c	2014-11-14 07:06:24.597713983 -0800
@@ -2597,6 +2597,8 @@ int do_munmap(struct mm_struct *mm, unsi
 	detach_vmas_to_be_unmapped(mm, vma, prev, end);
 	unmap_region(mm, vma, prev, start, end);
 
+	arch_unmap(mm, vma, start, end);
+
 	/* Fix up all other VM information */
 	remove_vma_list(mm, vma);
 
_
