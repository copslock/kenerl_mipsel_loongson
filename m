Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2009 22:34:45 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:698 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20029819AbZDUVeg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Apr 2009 22:34:36 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49ee3bdc0002>; Tue, 21 Apr 2009 17:34:20 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 21 Apr 2009 14:33:29 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 21 Apr 2009 14:33:29 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n3LLXQJ3001947;
	Tue, 21 Apr 2009 14:33:26 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n3LLXPvt001945;
	Tue, 21 Apr 2009 14:33:25 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Preliminary vdso.
Date:	Tue, 21 Apr 2009 14:33:24 -0700
Message-Id: <1240349605-1921-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <49EE3B0F.3040506@caviumnetworks.com>
References: <49EE3B0F.3040506@caviumnetworks.com>
X-OriginalArrivalTime: 21 Apr 2009 21:33:29.0143 (UTC) FILETIME=[CFBF2C70:01C9C2C8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is a preliminary patch to add a vdso to all user processes.
Still missing are ELF headers and .eh_frame information.  But it is
enough to allow us to move signal trampolines off of the stack.

We allocate a single page (the vdso) and write all possible signal
trampolines into it.  The stack is moved down by one page and the vdso
is mapped into this space.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/elf.h         |    4 +
 arch/mips/include/asm/mmu.h         |    5 +-
 arch/mips/include/asm/mmu_context.h |    2 +-
 arch/mips/include/asm/processor.h   |    5 +-
 arch/mips/include/asm/vdso.h        |   29 ++++++++++
 arch/mips/kernel/Makefile           |    2 +-
 arch/mips/kernel/syscall.c          |    2 +-
 arch/mips/kernel/vdso.c             |  104 +++++++++++++++++++++++++++++++++++
 8 files changed, 147 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/include/asm/vdso.h
 create mode 100644 arch/mips/kernel/vdso.c

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index d58f128..08b3bc5 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -364,4 +364,8 @@ extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *);
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
index d7f3eb0..62bcf13 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -73,7 +73,7 @@ extern unsigned long smtc_asid_mask;
 
 #endif
 
-#define cpu_context(cpu, mm)	((mm)->context[cpu])
+#define cpu_context(cpu, mm)	((mm)->context.asid[cpu])
 #define cpu_asid(cpu, mm)	(cpu_context((cpu), (mm)) & ASID_MASK)
 #define asid_cache(cpu)		(cpu_data[cpu].asid_cache)
 
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 0f926aa..530b01f 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -39,7 +39,7 @@ extern unsigned int vced_count, vcei_count;
  * so don't change it unless you know what you are doing.
  */
 #define TASK_SIZE	0x7fff8000UL
-#define STACK_TOP	TASK_SIZE
+#define STACK_TOP	(TASK_SIZE - PAGE_SIZE)
 
 /*
  * This decides where the kernel will search for a free chunk of vm
@@ -59,7 +59,8 @@ extern unsigned int vced_count, vcei_count;
 #define TASK_SIZE32	0x7fff8000UL
 #define TASK_SIZE	0x10000000000UL
 #define STACK_TOP	\
-      (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE)
+	((test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE) - \
+	 PAGE_SIZE)
 
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
index e961221..b8158b5 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -6,7 +6,7 @@ extra-y		:= head.o init_task.o vmlinux.lds
 
 obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 		   ptrace.o reset.o setup.o signal.o syscall.o \
-		   time.o topology.o traps.o unaligned.o watch.o
+		   time.o topology.o traps.o unaligned.o watch.o vdso.o
 
 obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
 obj-$(CONFIG_CEVT_R4K_LIB)	+= cevt-r4k.o
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 955c5f0..491e5be 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -77,7 +77,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	int do_color_align;
 	unsigned long task_size;
 
-	task_size = STACK_TOP;
+	task_size = test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE;
 
 	if (len > task_size)
 		return -ENOMEM;
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
new file mode 100644
index 0000000..a1f38a6
--- /dev/null
+++ b/arch/mips/kernel/vdso.c
@@ -0,0 +1,104 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2009 Cavium Networks
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
+	tramp[0] = 0x24020000 + sigreturn;	/* li v0, sigreturn */
+	tramp[1] = 0x0000000c;			/* syscall */
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
-- 
1.6.0.6
