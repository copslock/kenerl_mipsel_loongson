Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 18:11:32 +0100 (CET)
Received: from mga14.intel.com ([192.55.52.115]:63615 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013535AbaKLRLM0dIwf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Nov 2014 18:11:12 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 12 Nov 2014 09:04:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,370,1413270000"; 
   d="scan'208";a="621313822"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.23.232.122])
  by fmsmga001.fm.intel.com with ESMTP; 12 Nov 2014 09:05:05 -0800
Subject: [PATCH 07/11] x86, mpx: add MPX-specific mmap interface
To:     hpa@zytor.com
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        qiaowei.ren@intel.com, Dave Hansen <dave@sr71.net>,
        dave.hansen@linux.intel.com
From:   Dave Hansen <dave@sr71.net>
Date:   Wed, 12 Nov 2014 09:05:05 -0800
References: <20141112170443.B4BD0899@viggo.jf.intel.com>
In-Reply-To: <20141112170443.B4BD0899@viggo.jf.intel.com>
Message-Id: <20141112170505.692BC764@viggo.jf.intel.com>
Return-Path: <dave@sr71.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44066
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

We have chosen to perform the allocation of bounds tables in
kernel (See the patch "on-demand kernel allocation of bounds
tables") and to mark these VMAs with VM_MPX.

However, there is currently no suitable interface to actually do
this.  Existing interfaces, like do_mmap_pgoff(), have no way to
set a modified ->vm_ops or ->vm_flags and don't hold mmap_sem
long enough to let a caller do it.

This patch wraps mmap_region() and hold mmap_sem long enough to
make the modifications to the VMA which we need.

Also note the 32/64-bit #ifdef in the header.  We actually need
to do this at runtime eventually.  But, for now, we don't support
running 32-bit binaries on 64-bit kernels.  Support for this will
come in later patches.

Signed-off-by: Qiaowei Ren <qiaowei.ren@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/Kconfig           |    4 ++
 b/arch/x86/include/asm/mpx.h |   36 ++++++++++++++++++
 b/arch/x86/mm/Makefile       |    2 +
 b/arch/x86/mm/mpx.c          |   86 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+)

diff -puN /dev/null arch/x86/include/asm/mpx.h
--- /dev/null	2014-10-10 16:10:57.316716958 -0700
+++ b/arch/x86/include/asm/mpx.h	2014-11-12 08:49:25.689880168 -0800
@@ -0,0 +1,36 @@
+#ifndef _ASM_X86_MPX_H
+#define _ASM_X86_MPX_H
+
+#include <linux/types.h>
+#include <asm/ptrace.h>
+
+#ifdef CONFIG_X86_64
+
+/* upper 28 bits [47:20] of the virtual address in 64-bit used to
+ * index into bounds directory (BD).
+ */
+#define MPX_BD_ENTRY_OFFSET	28
+#define MPX_BD_ENTRY_SHIFT	3
+/* bits [19:3] of the virtual address in 64-bit used to index into
+ * bounds table (BT).
+ */
+#define MPX_BT_ENTRY_OFFSET	17
+#define MPX_BT_ENTRY_SHIFT	5
+#define MPX_IGN_BITS		3
+
+#else
+
+#define MPX_BD_ENTRY_OFFSET	20
+#define MPX_BD_ENTRY_SHIFT	2
+#define MPX_BT_ENTRY_OFFSET	10
+#define MPX_BT_ENTRY_SHIFT	4
+#define MPX_IGN_BITS		2
+
+#endif
+
+#define MPX_BD_SIZE_BYTES (1UL<<(MPX_BD_ENTRY_OFFSET+MPX_BD_ENTRY_SHIFT))
+#define MPX_BT_SIZE_BYTES (1UL<<(MPX_BT_ENTRY_OFFSET+MPX_BT_ENTRY_SHIFT))
+
+#define MPX_BNDSTA_ERROR_CODE	0x3
+
+#endif /* _ASM_X86_MPX_H */
diff -puN arch/x86/Kconfig~2014-10-14-03_12-x86-mpx-add-MPX-specific-mmap-interface arch/x86/Kconfig
--- a/arch/x86/Kconfig~2014-10-14-03_12-x86-mpx-add-MPX-specific-mmap-interface	2014-11-12 08:49:25.684879943 -0800
+++ b/arch/x86/Kconfig	2014-11-12 08:49:25.690880213 -0800
@@ -244,6 +244,10 @@ config HAVE_INTEL_TXT
 	def_bool y
 	depends on INTEL_IOMMU && ACPI
 
+config X86_INTEL_MPX
+	def_bool y
+	depends on CPU_SUP_INTEL
+
 config X86_32_SMP
 	def_bool y
 	depends on X86_32 && SMP
diff -puN arch/x86/mm/Makefile~2014-10-14-03_12-x86-mpx-add-MPX-specific-mmap-interface arch/x86/mm/Makefile
--- a/arch/x86/mm/Makefile~2014-10-14-03_12-x86-mpx-add-MPX-specific-mmap-interface	2014-11-12 08:49:25.686880033 -0800
+++ b/arch/x86/mm/Makefile	2014-11-12 08:49:25.690880213 -0800
@@ -30,3 +30,5 @@ obj-$(CONFIG_ACPI_NUMA)		+= srat.o
 obj-$(CONFIG_NUMA_EMU)		+= numa_emulation.o
 
 obj-$(CONFIG_MEMTEST)		+= memtest.o
+
+obj-$(CONFIG_X86_INTEL_MPX)	+= mpx.o
diff -puN /dev/null arch/x86/mm/mpx.c
--- /dev/null	2014-10-10 16:10:57.316716958 -0700
+++ b/arch/x86/mm/mpx.c	2014-11-12 08:49:25.690880213 -0800
@@ -0,0 +1,86 @@
+/*
+ * mpx.c - Memory Protection eXtensions
+ *
+ * Copyright (c) 2014, Intel Corporation.
+ * Qiaowei Ren <qiaowei.ren@intel.com>
+ * Dave Hansen <dave.hansen@intel.com>
+ */
+#include <linux/kernel.h>
+#include <linux/syscalls.h>
+#include <linux/sched/sysctl.h>
+
+#include <asm/mman.h>
+#include <asm/mpx.h>
+
+static const char *mpx_mapping_name(struct vm_area_struct *vma)
+{
+	return "[mpx]";
+}
+
+static struct vm_operations_struct mpx_vma_ops = {
+	.name = mpx_mapping_name,
+};
+
+/*
+ * This is really a simplified "vm_mmap". it only handles MPX
+ * bounds tables (the bounds directory is user-allocated).
+ *
+ * Later on, we use the vma->vm_ops to uniquely identify these
+ * VMAs.
+ */
+static unsigned long mpx_mmap(unsigned long len)
+{
+	unsigned long ret;
+	unsigned long addr, pgoff;
+	struct mm_struct *mm = current->mm;
+	vm_flags_t vm_flags;
+	struct vm_area_struct *vma;
+
+	/* Only bounds table and bounds directory can be allocated here */
+	if (len != MPX_BD_SIZE_BYTES && len != MPX_BT_SIZE_BYTES)
+		return -EINVAL;
+
+	down_write(&mm->mmap_sem);
+
+	/* Too many mappings? */
+	if (mm->map_count > sysctl_max_map_count) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Obtain the address to map to. we verify (or select) it and ensure
+	 * that it represents a valid section of the address space.
+	 */
+	addr = get_unmapped_area(NULL, 0, len, 0, MAP_ANONYMOUS | MAP_PRIVATE);
+	if (addr & ~PAGE_MASK) {
+		ret = addr;
+		goto out;
+	}
+
+	vm_flags = VM_READ | VM_WRITE | VM_MPX |
+			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
+
+	/* Set pgoff according to addr for anon_vma */
+	pgoff = addr >> PAGE_SHIFT;
+
+	ret = mmap_region(NULL, addr, len, vm_flags, pgoff);
+	if (IS_ERR_VALUE(ret))
+		goto out;
+
+	vma = find_vma(mm, ret);
+	if (!vma) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	vma->vm_ops = &mpx_vma_ops;
+
+	if (vm_flags & VM_LOCKED) {
+		up_write(&mm->mmap_sem);
+		mm_populate(ret, len);
+		return ret;
+	}
+
+out:
+	up_write(&mm->mmap_sem);
+	return ret;
+}
_
