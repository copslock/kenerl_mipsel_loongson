Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Feb 2010 01:14:59 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9513 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492152Ab0BSANx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Feb 2010 01:13:53 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b7dd7c70000>; Thu, 18 Feb 2010 16:13:59 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 18 Feb 2010 16:13:28 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 18 Feb 2010 16:13:28 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o1J0DQU9029143;
        Thu, 18 Feb 2010 16:13:26 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o1J0DQ1c029142;
        Thu, 18 Feb 2010 16:13:26 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/3] MIPS: Preliminary vdso.
Date:   Thu, 18 Feb 2010 16:13:04 -0800
Message-Id: <1266538385-29088-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com>
References: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 19 Feb 2010 00:13:28.0838 (UTC) FILETIME=[5CC6A260:01CAB0F8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is a preliminary patch to add a vdso to all user processes.
Still missing are ELF headers and .eh_frame information.  But it is
enough to allow us to move signal trampolines off of the stack.  Note
that emulation of branch delay slots in the FPU emulator still
requires the stack.

We allocate a single page (the vdso) and write all possible signal
trampolines into it.  The stack is moved down by one page and the vdso
is mapped into this space.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/elf.h         |    4 +
 arch/mips/include/asm/mmu.h         |    5 +-
 arch/mips/include/asm/mmu_context.h |    2 +-
 arch/mips/include/asm/processor.h   |   11 +++-
 arch/mips/include/asm/vdso.h        |   29 +++++++++
 arch/mips/kernel/Makefile           |    2 +-
 arch/mips/kernel/syscall.c          |    6 ++-
 arch/mips/kernel/vdso.c             |  112 +++++++++++++++++++++++++++++++++++
 8 files changed, 165 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/include/asm/vdso.h
 create mode 100644 arch/mips/kernel/vdso.c

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index e53d7be..1c3dbf0 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -367,4 +367,8 @@ extern const char *__elf_platform;
 #define ELF_ET_DYN_BASE         (TASK_SIZE / 3 * 2)
 #endif
 
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
+struct linux_binprm;
+extern int arch_setup_additional_pages(struct linux_binprm *bprm,
+				       int uses_interp);
 #endif /* _ASM_ELF_H */
diff --git a/arch/mips/include/asm/mmu.h b/arch/mips/include/asm/mmu.h
index 4063edd..c436138 100644
--- a/arch/mips/include/asm/mmu.h
+++ b/arch/mips/include/asm/mmu.h
@@ -1,6 +1,9 @@
 #ifndef __ASM_MMU_H
 #define __ASM_MMU_H
 
-typedef unsigned long mm_context_t[NR_CPUS];
+typedef struct {
+	unsigned long asid[NR_CPUS];
+	void *vdso;
+} mm_context_t;
 
 #endif /* __ASM_MMU_H */
diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index ada4975..73a640b 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -109,7 +109,7 @@ extern unsigned long smtc_asid_mask;
 
 #endif
 
-#define cpu_context(cpu, mm)	((mm)->context[cpu])
+#define cpu_context(cpu, mm)	((mm)->context.asid[cpu])
 #define cpu_asid(cpu, mm)	(cpu_context((cpu), (mm)) & ASID_MASK)
 #define asid_cache(cpu)		(cpu_data[cpu].asid_cache)
 
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 087a888..ab38791 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -33,13 +33,19 @@ extern void (*cpu_wait)(void);
 
 extern unsigned int vced_count, vcei_count;
 
+/*
+ * A special page (the vdso) is mapped into all processes at the very
+ * top of the virtual memory space.
+ */
+#define SPECIAL_PAGES_SIZE PAGE_SIZE
+
 #ifdef CONFIG_32BIT
 /*
  * User space process size: 2GB. This is hardcoded into a few places,
  * so don't change it unless you know what you are doing.
  */
 #define TASK_SIZE	0x7fff8000UL
-#define STACK_TOP	TASK_SIZE
+#define STACK_TOP	((TASK_SIZE & PAGE_MASK) - SPECIAL_PAGES_SIZE)
 
 /*
  * This decides where the kernel will search for a free chunk of vm
@@ -59,7 +65,8 @@ extern unsigned int vced_count, vcei_count;
 #define TASK_SIZE32	0x7fff8000UL
 #define TASK_SIZE	0x10000000000UL
 #define STACK_TOP	\
-      (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE)
+	(((test_thread_flag(TIF_32BIT_ADDR) ?				\
+	   TASK_SIZE32 : TASK_SIZE) & PAGE_MASK) - SPECIAL_PAGES_SIZE)
 
 /*
  * This decides where the kernel will search for a free chunk of vm
diff --git a/arch/mips/include/asm/vdso.h b/arch/mips/include/asm/vdso.h
new file mode 100644
index 0000000..cca56aa
--- /dev/null
+++ b/arch/mips/include/asm/vdso.h
@@ -0,0 +1,29 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2009 Cavium Networks
+ */
+
+#ifndef __ASM_VDSO_H
+#define __ASM_VDSO_H
+
+#include <linux/types.h>
+
+
+#ifdef CONFIG_32BIT
+struct mips_vdso {
+	u32 signal_trampoline[2];
+	u32 rt_signal_trampoline[2];
+};
+#else  /* !CONFIG_32BIT */
+struct mips_vdso {
+	u32 o32_signal_trampoline[2];
+	u32 o32_rt_signal_trampoline[2];
+	u32 rt_signal_trampoline[2];
+	u32 n32_rt_signal_trampoline[2];
+};
+#endif /* CONFIG_32BIT */
+
+#endif /* __ASM_VDSO_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 924192b..642ae95 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -6,7 +6,7 @@ extra-y		:= head.o init_task.o vmlinux.lds
 
 obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 		   ptrace.o reset.o setup.o signal.o syscall.o \
-		   time.o topology.o traps.o unaligned.o watch.o
+		   time.o topology.o traps.o unaligned.o watch.o vdso.o
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_ftrace.o = -pg
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index e6cb831..d15eb20 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -79,7 +79,11 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	int do_color_align;
 	unsigned long task_size;
 
-	task_size = STACK_TOP;
+#ifdef CONFIG_32BIT
+	task_size = TASK_SIZE;
+#else /* Must be CONFIG_64BIT*/
+	task_size = test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE;
+#endif
 
 	if (len > task_size)
 		return -ENOMEM;
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
new file mode 100644
index 0000000..b773c11
--- /dev/null
+++ b/arch/mips/kernel/vdso.c
@@ -0,0 +1,112 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2009, 2010 Cavium Networks, Inc.
+ */
+
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/binfmts.h>
+#include <linux/elf.h>
+#include <linux/vmalloc.h>
+#include <linux/unistd.h>
+
+#include <asm/vdso.h>
+#include <asm/uasm.h>
+
+/*
+ * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
+ */
+#define __NR_O32_sigreturn		4119
+#define __NR_O32_rt_sigreturn		4193
+#define __NR_N32_rt_sigreturn		6211
+
+static struct page *vdso_page;
+
+static void __init install_trampoline(u32 *tramp, unsigned int sigreturn)
+{
+	uasm_i_addiu(&tramp, 2, 0, sigreturn);	/* li v0, sigreturn */
+	uasm_i_syscall(&tramp, 0);
+}
+
+static int __init init_vdso(void)
+{
+	struct mips_vdso *vdso;
+
+	vdso_page = alloc_page(GFP_KERNEL);
+	if (!vdso_page)
+		panic("Cannot allocate vdso");
+
+	vdso = vmap(&vdso_page, 1, 0, PAGE_KERNEL);
+	if (!vdso)
+		panic("Cannot map vdso");
+	clear_page(vdso);
+
+	install_trampoline(vdso->rt_signal_trampoline, __NR_rt_sigreturn);
+#ifdef CONFIG_32BIT
+	install_trampoline(vdso->signal_trampoline, __NR_sigreturn);
+#else
+	install_trampoline(vdso->n32_rt_signal_trampoline,
+			   __NR_N32_rt_sigreturn);
+	install_trampoline(vdso->o32_signal_trampoline, __NR_O32_sigreturn);
+	install_trampoline(vdso->o32_rt_signal_trampoline,
+			   __NR_O32_rt_sigreturn);
+#endif
+
+	vunmap(vdso);
+
+	pr_notice("init_vdso successfull\n");
+
+	return 0;
+}
+device_initcall(init_vdso);
+
+static unsigned long vdso_addr(unsigned long start)
+{
+	return STACK_TOP;
+}
+
+int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+{
+	int ret;
+	unsigned long addr;
+	struct mm_struct *mm = current->mm;
+
+	down_write(&mm->mmap_sem);
+
+	addr = vdso_addr(mm->start_stack);
+
+	addr = get_unmapped_area(NULL, addr, PAGE_SIZE, 0, 0);
+	if (IS_ERR_VALUE(addr)) {
+		ret = addr;
+		goto up_fail;
+	}
+
+	ret = install_special_mapping(mm, addr, PAGE_SIZE,
+				      VM_READ|VM_EXEC|
+				      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
+				      VM_ALWAYSDUMP,
+				      &vdso_page);
+
+	if (ret)
+		goto up_fail;
+
+	mm->context.vdso = (void *)addr;
+
+up_fail:
+	up_write(&mm->mmap_sem);
+	return ret;
+}
+
+const char *arch_vma_name(struct vm_area_struct *vma)
+{
+	if (vma->vm_mm && vma->vm_start == (long)vma->vm_mm->context.vdso)
+		return "[vdso]";
+	return NULL;
+}
-- 
1.6.6
