Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Oct 2014 06:52:25 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:23788 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010223AbaJLEvhp0Vvq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Oct 2014 06:51:37 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 11 Oct 2014 21:51:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,703,1406617200"; 
   d="scan'208";a="604027252"
Received: from unknown (HELO localhost.localdomain.org) ([10.239.48.107])
  by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2014 21:51:31 -0700
From:   Qiaowei Ren <qiaowei.ren@intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        Qiaowei Ren <qiaowei.ren@intel.com>
Subject: [PATCH v9 03/12] x86, mpx: add MPX specific mmap interface
Date:   Sun, 12 Oct 2014 12:41:46 +0800
Message-Id: <1413088915-13428-4-git-send-email-qiaowei.ren@intel.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com>
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com>
Return-Path: <qiaowei.ren@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qiaowei.ren@intel.com
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

We have to do the allocation of bounds tables in kernel (See the patch
"on-demand kernel allocation of bounds tables"). Moreover, if we want
to track MPX VMAs we need to be able to stick new VM_MPX flag and a
specific vm_ops for MPX in the vma_area_struct.

But there are not suitable interfaces to do this in current kernel.
Existing interfaces, like do_mmap_pgoff(), could not stick specific
->vm_ops in the vma_area_struct when a VMA is created. So, this patch
adds MPX specific mmap interface to do the allocation of bounds tables.

Signed-off-by: Qiaowei Ren <qiaowei.ren@intel.com>
---
 arch/x86/Kconfig           |    4 ++
 arch/x86/include/asm/mpx.h |   38 +++++++++++++++++++++
 arch/x86/mm/Makefile       |    2 +
 arch/x86/mm/mpx.c          |   79 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 0 deletions(-)
 create mode 100644 arch/x86/include/asm/mpx.h
 create mode 100644 arch/x86/mm/mpx.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4b663e1..e5bcc70 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -243,6 +243,10 @@ config HAVE_INTEL_TXT
 	def_bool y
 	depends on INTEL_IOMMU && ACPI
 
+config X86_INTEL_MPX
+	def_bool y
+	depends on CPU_SUP_INTEL
+
 config X86_32_SMP
 	def_bool y
 	depends on X86_32 && SMP
diff --git a/arch/x86/include/asm/mpx.h b/arch/x86/include/asm/mpx.h
new file mode 100644
index 0000000..5725ac4
--- /dev/null
+++ b/arch/x86/include/asm/mpx.h
@@ -0,0 +1,38 @@
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
+unsigned long mpx_mmap(unsigned long len);
+
+#endif /* _ASM_X86_MPX_H */
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 6a19ad9..ecfdc46 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -30,3 +30,5 @@ obj-$(CONFIG_ACPI_NUMA)		+= srat.o
 obj-$(CONFIG_NUMA_EMU)		+= numa_emulation.o
 
 obj-$(CONFIG_MEMTEST)		+= memtest.o
+
+obj-$(CONFIG_X86_INTEL_MPX)	+= mpx.o
diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
new file mode 100644
index 0000000..e1b28e6
--- /dev/null
+++ b/arch/x86/mm/mpx.c
@@ -0,0 +1,79 @@
+#include <linux/kernel.h>
+#include <linux/syscalls.h>
+#include <asm/mpx.h>
+#include <asm/mman.h>
+#include <linux/sched/sysctl.h>
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
+ * this is really a simplified "vm_mmap". it only handles mpx
+ * related maps, including bounds table and bounds directory.
+ *
+ * here we can stick new vm_flag VM_MPX in the vma_area_struct
+ * when create a bounds table or bounds directory, in order to
+ * track MPX specific memory.
+ */
+unsigned long mpx_mmap(unsigned long len)
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
-- 
1.7.1
