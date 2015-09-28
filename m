Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Sep 2015 12:10:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48004 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007052AbbI1KK16NfWf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Sep 2015 12:10:27 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 73C11CC0E5A7;
        Mon, 28 Sep 2015 11:10:19 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 28 Sep 2015 11:10:21 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.88) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 28 Sep 2015 11:10:20 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <alex@alex-smith.me.uk>, Alex Smith <alex.smith@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/3] MIPS: Initial implementation of a VDSO
Date:   Mon, 28 Sep 2015 11:10:11 +0100
Message-ID: <1443435011-17061-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1443434629-14325-1-git-send-email-markos.chandras@imgtec.com>
References: <1443434629-14325-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.88]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Alex Smith <alex.smith@imgtec.com>

Add an initial implementation of a proper (i.e. an ELF shared library)
VDSO. With this commit it does not export any symbols, it only replaces
the current signal return trampoline page. A later commit will add user
implementations of gettimeofday()/clock_gettime().

To support both new toolchains and old ones which don't generate ABI
flags section, we define its content manually and then use a tool
(genvdso) to patch up the section to have the correct name and type.
genvdso also extracts symbol offsets ({,rt_}sigreturn) needed by the
kernel, and generates a C file containing a "struct mips_vdso_image"
containing both the VDSO data and these offsets. This C file is
compiled into the kernel.

On 64-bit kernels we require a different VDSO for each supported ABI,
so we may build up to 3 different VDSOs. The VDSO to use is selected by
the mips_abi structure.

A kernel/user shared data page is created and mapped below the VDSO
image. This is currently empty, but will be used by the user time
function implementations which are added later.

[markos.chandras@imgtec.com:
- Add more comments
- Move abi detection in genvdso.h since it's the get_symbol function
that needs it.
- Add an R6 specific way to calculate the base address of VDSO in order
to avoid the branch instruction which affects performance.
- Do not patch .gnu.attributes since it's not needed for dynamic linking.
- Simplify Makefile a little bit.
- checkpatch fixes]

Cc: linux-kernel@vger.kernel.org
Cc: Matthew Fortune <matthew.fortune@imgtec.com>
Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/Kbuild                    |   1 +
 arch/mips/include/asm/abi.h         |   5 +-
 arch/mips/include/asm/elf.h         |   7 +
 arch/mips/include/asm/processor.h   |   8 +-
 arch/mips/include/asm/vdso.h        |  73 +++++++--
 arch/mips/include/uapi/asm/Kbuild   |   2 +-
 arch/mips/include/uapi/asm/auxvec.h |  17 +++
 arch/mips/kernel/signal.c           |  12 +-
 arch/mips/kernel/signal32.c         |   7 +-
 arch/mips/kernel/signal_n32.c       |   5 +-
 arch/mips/kernel/vdso.c             | 160 ++++++++++----------
 arch/mips/vdso/.gitignore           |   4 +
 arch/mips/vdso/Makefile             | 142 +++++++++++++++++
 arch/mips/vdso/elf.S                |  68 +++++++++
 arch/mips/vdso/genvdso.c            | 293 ++++++++++++++++++++++++++++++++++++
 arch/mips/vdso/genvdso.h            | 187 +++++++++++++++++++++++
 arch/mips/vdso/sigreturn.S          |  49 ++++++
 arch/mips/vdso/vdso.h               |  79 ++++++++++
 arch/mips/vdso/vdso.lds.S           | 100 ++++++++++++
 19 files changed, 1095 insertions(+), 124 deletions(-)
 create mode 100644 arch/mips/include/uapi/asm/auxvec.h
 create mode 100644 arch/mips/vdso/.gitignore
 create mode 100644 arch/mips/vdso/Makefile
 create mode 100644 arch/mips/vdso/elf.S
 create mode 100644 arch/mips/vdso/genvdso.c
 create mode 100644 arch/mips/vdso/genvdso.h
 create mode 100644 arch/mips/vdso/sigreturn.S
 create mode 100644 arch/mips/vdso/vdso.h
 create mode 100644 arch/mips/vdso/vdso.lds.S

diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index dd295335891a..5c3f688a5232 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -17,6 +17,7 @@ obj- := $(platform-)
 obj-y += kernel/
 obj-y += mm/
 obj-y += net/
+obj-y += vdso/
 
 ifdef CONFIG_KVM
 obj-y += kvm/
diff --git a/arch/mips/include/asm/abi.h b/arch/mips/include/asm/abi.h
index 37f84078e78a..940760844e2f 100644
--- a/arch/mips/include/asm/abi.h
+++ b/arch/mips/include/asm/abi.h
@@ -11,19 +11,20 @@
 
 #include <asm/signal.h>
 #include <asm/siginfo.h>
+#include <asm/vdso.h>
 
 struct mips_abi {
 	int (* const setup_frame)(void *sig_return, struct ksignal *ksig,
 				  struct pt_regs *regs, sigset_t *set);
-	const unsigned long	signal_return_offset;
 	int (* const setup_rt_frame)(void *sig_return, struct ksignal *ksig,
 				     struct pt_regs *regs, sigset_t *set);
-	const unsigned long	rt_signal_return_offset;
 	const unsigned long	restart;
 
 	unsigned	off_sc_fpregs;
 	unsigned	off_sc_fpc_csr;
 	unsigned	off_sc_used_math;
+
+	struct mips_vdso_image *vdso;
 };
 
 #endif /* _ASM_ABI_H */
diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index 53b26933b12c..b01a6ff468e0 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -8,6 +8,7 @@
 #ifndef _ASM_ELF_H
 #define _ASM_ELF_H
 
+#include <linux/auxvec.h>
 #include <linux/fs.h>
 #include <uapi/linux/elf.h>
 
@@ -419,6 +420,12 @@ extern const char *__elf_platform;
 #define ELF_ET_DYN_BASE		(TASK_SIZE / 3 * 2)
 #endif
 
+#define ARCH_DLINFO							\
+do {									\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
+		    (unsigned long)current->mm->context.vdso);		\
+} while (0)
+
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 59ee6dcf6eed..3f832c3dd8f5 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -36,12 +36,6 @@ extern unsigned int vced_count, vcei_count;
  */
 #define HAVE_ARCH_PICK_MMAP_LAYOUT 1
 
-/*
- * A special page (the vdso) is mapped into all processes at the very
- * top of the virtual memory space.
- */
-#define SPECIAL_PAGES_SIZE PAGE_SIZE
-
 #ifdef CONFIG_32BIT
 #ifdef CONFIG_KVM_GUEST
 /* User space process size is limited to 1GB in KVM Guest Mode */
@@ -80,7 +74,7 @@ extern unsigned int vced_count, vcei_count;
 
 #endif
 
-#define STACK_TOP	((TASK_SIZE & PAGE_MASK) - SPECIAL_PAGES_SIZE)
+#define STACK_TOP	(TASK_SIZE & PAGE_MASK)
 
 /*
  * This decides where the kernel will search for a free chunk of vm
diff --git a/arch/mips/include/asm/vdso.h b/arch/mips/include/asm/vdso.h
index cca56aa40ff4..db2d45be8f2e 100644
--- a/arch/mips/include/asm/vdso.h
+++ b/arch/mips/include/asm/vdso.h
@@ -1,29 +1,70 @@
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
  *
- * Copyright (C) 2009 Cavium Networks
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
  */
 
 #ifndef __ASM_VDSO_H
 #define __ASM_VDSO_H
 
-#include <linux/types.h>
+#include <linux/mm_types.h>
 
+/**
+ * struct mips_vdso_image - Details of a VDSO image.
+ * @data: Pointer to VDSO image data (page-aligned).
+ * @size: Size of the VDSO image data (page-aligned).
+ * @off_sigreturn: Offset of the sigreturn() trampoline.
+ * @off_rt_sigreturn: Offset of the rt_sigreturn() trampoline.
+ * @mapping: Special mapping structure.
+ *
+ * This structure contains details of a VDSO image, including the image data
+ * and offsets of certain symbols required by the kernel. It is generated as
+ * part of the VDSO build process, aside from the mapping page array, which is
+ * populated at runtime.
+ */
+struct mips_vdso_image {
+	void *data;
+	unsigned long size;
 
-#ifdef CONFIG_32BIT
-struct mips_vdso {
-	u32 signal_trampoline[2];
-	u32 rt_signal_trampoline[2];
+	unsigned long off_sigreturn;
+	unsigned long off_rt_sigreturn;
+
+	struct vm_special_mapping mapping;
 };
-#else  /* !CONFIG_32BIT */
-struct mips_vdso {
-	u32 o32_signal_trampoline[2];
-	u32 o32_rt_signal_trampoline[2];
-	u32 rt_signal_trampoline[2];
-	u32 n32_rt_signal_trampoline[2];
+
+/*
+ * The following structures are auto-generated as part of the build for each
+ * ABI by genvdso, see arch/mips/vdso/Makefile.
+ */
+
+extern struct mips_vdso_image vdso_image;
+
+#ifdef CONFIG_MIPS32_O32
+extern struct mips_vdso_image vdso_image_o32;
+#endif
+
+#ifdef CONFIG_MIPS32_N32
+extern struct mips_vdso_image vdso_image_n32;
+#endif
+
+/**
+ * union mips_vdso_data - Data provided by the kernel for the VDSO.
+ *
+ * This structure contains data needed by functions within the VDSO. It is
+ * populated by the kernel and mapped read-only into user memory.
+ *
+ * Note: Care should be taken when modifying as the layout must remain the same
+ * for both 64- and 32-bit (for 32-bit userland on 64-bit kernel).
+ */
+union mips_vdso_data {
+	struct {
+	};
+
+	u8 page[PAGE_SIZE];
 };
-#endif /* CONFIG_32BIT */
 
 #endif /* __ASM_VDSO_H */
diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
index 96fe7395ed8d..f2cf41461146 100644
--- a/arch/mips/include/uapi/asm/Kbuild
+++ b/arch/mips/include/uapi/asm/Kbuild
@@ -1,9 +1,9 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
 generic-y += ipcbuf.h
 
+header-y += auxvec.h
 header-y += bitfield.h
 header-y += bitsperlong.h
 header-y += break.h
diff --git a/arch/mips/include/uapi/asm/auxvec.h b/arch/mips/include/uapi/asm/auxvec.h
new file mode 100644
index 000000000000..c9c7195272c4
--- /dev/null
+++ b/arch/mips/include/uapi/asm/auxvec.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_AUXVEC_H
+#define __ASM_AUXVEC_H
+
+/* Location of VDSO image. */
+#define AT_SYSINFO_EHDR		33
+
+#endif /* __ASM_AUXVEC_H */
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 2fec67bfc457..bf792e2839a6 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -36,7 +36,6 @@
 #include <asm/ucontext.h>
 #include <asm/cpu-features.h>
 #include <asm/war.h>
-#include <asm/vdso.h>
 #include <asm/dsp.h>
 #include <asm/inst.h>
 #include <asm/msa.h>
@@ -752,16 +751,15 @@ static int setup_rt_frame(void *sig_return, struct ksignal *ksig,
 struct mips_abi mips_abi = {
 #ifdef CONFIG_TRAD_SIGNALS
 	.setup_frame	= setup_frame,
-	.signal_return_offset = offsetof(struct mips_vdso, signal_trampoline),
 #endif
 	.setup_rt_frame = setup_rt_frame,
-	.rt_signal_return_offset =
-		offsetof(struct mips_vdso, rt_signal_trampoline),
 	.restart	= __NR_restart_syscall,
 
 	.off_sc_fpregs = offsetof(struct sigcontext, sc_fpregs),
 	.off_sc_fpc_csr = offsetof(struct sigcontext, sc_fpc_csr),
 	.off_sc_used_math = offsetof(struct sigcontext, sc_used_math),
+
+	.vdso		= &vdso_image,
 };
 
 static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
@@ -801,11 +799,11 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	}
 
 	if (sig_uses_siginfo(&ksig->ka))
-		ret = abi->setup_rt_frame(vdso + abi->rt_signal_return_offset,
+		ret = abi->setup_rt_frame(vdso + abi->vdso->off_rt_sigreturn,
 					  ksig, regs, oldset);
 	else
-		ret = abi->setup_frame(vdso + abi->signal_return_offset, ksig,
-				       regs, oldset);
+		ret = abi->setup_frame(vdso + abi->vdso->off_sigreturn,
+				       ksig, regs, oldset);
 
 	signal_setup_done(ret, ksig, 0);
 }
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index f7e89524e316..4909639aa35b 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -31,7 +31,6 @@
 #include <asm/ucontext.h>
 #include <asm/fpu.h>
 #include <asm/war.h>
-#include <asm/vdso.h>
 #include <asm/dsp.h>
 
 #include "signal-common.h"
@@ -406,14 +405,12 @@ static int setup_rt_frame_32(void *sig_return, struct ksignal *ksig,
  */
 struct mips_abi mips_abi_32 = {
 	.setup_frame	= setup_frame_32,
-	.signal_return_offset =
-		offsetof(struct mips_vdso, o32_signal_trampoline),
 	.setup_rt_frame = setup_rt_frame_32,
-	.rt_signal_return_offset =
-		offsetof(struct mips_vdso, o32_rt_signal_trampoline),
 	.restart	= __NR_O32_restart_syscall,
 
 	.off_sc_fpregs = offsetof(struct sigcontext32, sc_fpregs),
 	.off_sc_fpc_csr = offsetof(struct sigcontext32, sc_fpc_csr),
 	.off_sc_used_math = offsetof(struct sigcontext32, sc_used_math),
+
+	.vdso		= &vdso_image_o32,
 };
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 0d017fdcaf07..a7bc38430500 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -38,7 +38,6 @@
 #include <asm/fpu.h>
 #include <asm/cpu-features.h>
 #include <asm/war.h>
-#include <asm/vdso.h>
 
 #include "signal-common.h"
 
@@ -151,11 +150,11 @@ static int setup_rt_frame_n32(void *sig_return, struct ksignal *ksig,
 
 struct mips_abi mips_abi_n32 = {
 	.setup_rt_frame = setup_rt_frame_n32,
-	.rt_signal_return_offset =
-		offsetof(struct mips_vdso, n32_rt_signal_trampoline),
 	.restart	= __NR_N32_restart_syscall,
 
 	.off_sc_fpregs = offsetof(struct sigcontext, sc_fpregs),
 	.off_sc_fpc_csr = offsetof(struct sigcontext, sc_fpc_csr),
 	.off_sc_used_math = offsetof(struct sigcontext, sc_used_math),
+
+	.vdso		= &vdso_image_n32,
 };
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index ed2a278722a9..56cc3c4377fb 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -1,122 +1,116 @@
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
  *
- * Copyright (C) 2009, 2010 Cavium Networks, Inc.
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
  */
 
-
-#include <linux/kernel.h>
-#include <linux/err.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/init.h>
 #include <linux/binfmts.h>
 #include <linux/elf.h>
-#include <linux/vmalloc.h>
-#include <linux/unistd.h>
-#include <linux/random.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
 
+#include <asm/abi.h>
 #include <asm/vdso.h>
-#include <asm/uasm.h>
-#include <asm/processor.h>
+
+/* Kernel-provided data used by the VDSO. */
+static union mips_vdso_data vdso_data __page_aligned_data;
 
 /*
- * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
+ * Mapping for the VDSO data pages. The real pages are mapped manually, as
+ * what we map and where within the area they are mapped is determined at
+ * runtime.
  */
-#define __NR_O32_sigreturn		4119
-#define __NR_O32_rt_sigreturn		4193
-#define __NR_N32_rt_sigreturn		6211
+static struct page *no_pages[] = { NULL };
+static struct vm_special_mapping vdso_vvar_mapping = {
+	.name = "[vvar]",
+	.pages = no_pages,
+};
 
-static struct page *vdso_page;
-
-static void __init install_trampoline(u32 *tramp, unsigned int sigreturn)
+static void __init init_vdso_image(struct mips_vdso_image *image)
 {
-	uasm_i_addiu(&tramp, 2, 0, sigreturn);	/* li v0, sigreturn */
-	uasm_i_syscall(&tramp, 0);
+	unsigned long num_pages, i;
+
+	BUG_ON(!PAGE_ALIGNED(image->data));
+	BUG_ON(!PAGE_ALIGNED(image->size));
+
+	num_pages = image->size / PAGE_SIZE;
+
+	for (i = 0; i < num_pages; i++) {
+		image->mapping.pages[i] =
+			virt_to_page(image->data + (i * PAGE_SIZE));
+	}
 }
 
 static int __init init_vdso(void)
 {
-	struct mips_vdso *vdso;
-
-	vdso_page = alloc_page(GFP_KERNEL);
-	if (!vdso_page)
-		panic("Cannot allocate vdso");
-
-	vdso = vmap(&vdso_page, 1, 0, PAGE_KERNEL);
-	if (!vdso)
-		panic("Cannot map vdso");
-	clear_page(vdso);
-
-	install_trampoline(vdso->rt_signal_trampoline, __NR_rt_sigreturn);
-#ifdef CONFIG_32BIT
-	install_trampoline(vdso->signal_trampoline, __NR_sigreturn);
-#else
-	install_trampoline(vdso->n32_rt_signal_trampoline,
-			   __NR_N32_rt_sigreturn);
-	install_trampoline(vdso->o32_signal_trampoline, __NR_O32_sigreturn);
-	install_trampoline(vdso->o32_rt_signal_trampoline,
-			   __NR_O32_rt_sigreturn);
+	init_vdso_image(&vdso_image);
+
+#ifdef CONFIG_MIPS32_O32
+	init_vdso_image(&vdso_image_o32);
 #endif
 
-	vunmap(vdso);
+#ifdef CONFIG_MIPS32_N32
+	init_vdso_image(&vdso_image_n32);
+#endif
 
 	return 0;
 }
 subsys_initcall(init_vdso);
 
-static unsigned long vdso_addr(unsigned long start)
-{
-	unsigned long offset = 0UL;
-
-	if (current->flags & PF_RANDOMIZE) {
-		offset = get_random_int();
-		offset <<= PAGE_SHIFT;
-		if (TASK_IS_32BIT_ADDR)
-			offset &= 0xfffffful;
-		else
-			offset &= 0xffffffful;
-	}
-
-	return STACK_TOP + offset;
-}
-
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
-	int ret;
-	unsigned long addr;
+	struct mips_vdso_image *image = current->thread.abi->vdso;
 	struct mm_struct *mm = current->mm;
+	unsigned long base, vdso_addr;
+	struct vm_area_struct *vma;
+	int ret;
 
 	down_write(&mm->mmap_sem);
 
-	addr = vdso_addr(mm->start_stack);
-
-	addr = get_unmapped_area(NULL, addr, PAGE_SIZE, 0, 0);
-	if (IS_ERR_VALUE(addr)) {
-		ret = addr;
-		goto up_fail;
+	base = get_unmapped_area(NULL, 0, PAGE_SIZE + image->size, 0, 0);
+	if (IS_ERR_VALUE(base)) {
+		ret = base;
+		goto out;
 	}
 
-	ret = install_special_mapping(mm, addr, PAGE_SIZE,
-				      VM_READ|VM_EXEC|
-				      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
-				      &vdso_page);
+	vdso_addr = base + PAGE_SIZE;
+
+	vma = _install_special_mapping(mm, base, PAGE_SIZE,
+				       VM_READ | VM_MAYREAD,
+				       &vdso_vvar_mapping);
+	if (IS_ERR(vma)) {
+		ret = PTR_ERR(vma);
+		goto out;
+	}
 
+	/* Map data page. */
+	ret = remap_pfn_range(vma, base,
+			      virt_to_phys(&vdso_data) >> PAGE_SHIFT,
+			      PAGE_SIZE, PAGE_READONLY);
 	if (ret)
-		goto up_fail;
+		goto out;
+
+	/* Map VDSO image. */
+	vma = _install_special_mapping(mm, vdso_addr, image->size,
+				       VM_READ | VM_EXEC |
+				       VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
+				       &image->mapping);
+	if (IS_ERR(vma)) {
+		ret = PTR_ERR(vma);
+		goto out;
+	}
 
-	mm->context.vdso = (void *)addr;
+	mm->context.vdso = (void *)vdso_addr;
+	ret = 0;
 
-up_fail:
+out:
 	up_write(&mm->mmap_sem);
 	return ret;
 }
-
-const char *arch_vma_name(struct vm_area_struct *vma)
-{
-	if (vma->vm_mm && vma->vm_start == (long)vma->vm_mm->context.vdso)
-		return "[vdso]";
-	return NULL;
-}
diff --git a/arch/mips/vdso/.gitignore b/arch/mips/vdso/.gitignore
new file mode 100644
index 000000000000..5286a7d73d79
--- /dev/null
+++ b/arch/mips/vdso/.gitignore
@@ -0,0 +1,4 @@
+*.so*
+vdso-*image.c
+genvdso
+vdso*.lds
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
new file mode 100644
index 000000000000..9a8a6b373eb0
--- /dev/null
+++ b/arch/mips/vdso/Makefile
@@ -0,0 +1,142 @@
+# Objects to go into the VDSO.
+obj-vdso-y := elf.o sigreturn.o
+
+# Common compiler flags between ABIs.
+ccflags-vdso := \
+	$(filter -I%,$(KBUILD_CFLAGS)) \
+	$(filter -E%,$(KBUILD_CFLAGS)) \
+	$(filter -march=%,$(KBUILD_CFLAGS))
+cflags-vdso := $(ccflags-vdso) \
+	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
+	-O2 -g -fPIC -fno-common -fno-builtin -G 0 -DDISABLE_BRANCH_PROFILING \
+	$(call cc-option, -fno-stack-protector)
+aflags-vdso := $(ccflags-vdso) \
+	$(filter -I%,$(KBUILD_CFLAGS)) \
+	$(filter -E%,$(KBUILD_CFLAGS)) \
+	-D__ASSEMBLY__ -Wa,-gdwarf-2
+
+# VDSO linker flags.
+VDSO_LDFLAGS := \
+	-Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=linux-vdso.so.1 \
+	-nostdlib -shared \
+	$(call cc-ldoption, -Wl$(comma)--hash-style=sysv) \
+	$(call cc-ldoption, -Wl$(comma)--build-id)
+
+GCOV_PROFILE := n
+
+#
+# Shared build commands.
+#
+
+quiet_cmd_vdsold = VDSO    $@
+      cmd_vdsold = $(CC) $(c_flags) $(VDSO_LDFLAGS) \
+                   -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) -o $@
+
+hostprogs-y := genvdso
+
+quiet_cmd_genvdso = GENVDSO $@
+define cmd_genvdso
+	cp $< $(<:%.dbg=%) && \
+	$(OBJCOPY) -S $< $(<:%.dbg=%) && \
+	$(obj)/genvdso $< $(<:%.dbg=%) $@ $(VDSO_NAME)
+endef
+
+#
+# Build native VDSO.
+#
+
+native-abi := $(filter -mabi=%,$(KBUILD_CFLAGS))
+
+targets += $(obj-vdso-y)
+targets += vdso.lds vdso.so.dbg vdso.so vdso-image.c
+
+obj-vdso := $(obj-vdso-y:%.o=$(obj)/%.o)
+
+$(obj-vdso): KBUILD_CFLAGS := $(cflags-vdso) $(native-abi)
+$(obj-vdso): KBUILD_AFLAGS := $(aflags-vdso) $(native-abi)
+
+$(obj)/vdso.lds: KBUILD_CPPFLAGS := $(native-abi)
+
+$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
+	$(call if_changed,vdsold)
+
+$(obj)/vdso-image.c: $(obj)/vdso.so.dbg $(obj)/genvdso FORCE
+	$(call if_changed,genvdso)
+
+obj-y += vdso-image.o
+
+#
+# Build O32 VDSO.
+#
+
+# Define these outside the ifdef to ensure they are picked up by clean.
+targets += $(obj-vdso-y:%.o=%-o32.o)
+targets += vdso-o32.lds vdso-o32.so.dbg vdso-o32.so vdso-o32-image.c
+
+ifdef CONFIG_MIPS32_O32
+
+obj-vdso-o32 := $(obj-vdso-y:%.o=$(obj)/%-o32.o)
+
+$(obj-vdso-o32): KBUILD_CFLAGS := $(cflags-vdso) -mabi=32
+$(obj-vdso-o32): KBUILD_AFLAGS := $(aflags-vdso) -mabi=32
+
+$(obj)/%-o32.o: $(src)/%.S FORCE
+	$(call if_changed_dep,as_o_S)
+
+$(obj)/%-o32.o: $(src)/%.c FORCE
+	$(call cmd,force_checksrc)
+	$(call if_changed_rule,cc_o_c)
+
+$(obj)/vdso-o32.lds: KBUILD_CPPFLAGS := -mabi=32
+$(obj)/vdso-o32.lds: $(src)/vdso.lds.S FORCE
+	$(call if_changed_dep,cpp_lds_S)
+
+$(obj)/vdso-o32.so.dbg: $(obj)/vdso-o32.lds $(obj-vdso-o32) FORCE
+	$(call if_changed,vdsold)
+
+$(obj)/vdso-o32-image.c: VDSO_NAME := o32
+$(obj)/vdso-o32-image.c: $(obj)/vdso-o32.so.dbg $(obj)/genvdso FORCE
+	$(call if_changed,genvdso)
+
+obj-y += vdso-o32-image.o
+
+endif
+
+#
+# Build N32 VDSO.
+#
+
+targets += $(obj-vdso-y:%.o=%-n32.o)
+targets += vdso-n32.lds vdso-n32.so.dbg vdso-n32.so vdso-n32-image.c
+
+ifdef CONFIG_MIPS32_N32
+
+obj-vdso-n32 := $(obj-vdso-y:%.o=$(obj)/%-n32.o)
+
+$(obj-vdso-n32): KBUILD_CFLAGS := $(cflags-vdso) -mabi=n32
+$(obj-vdso-n32): KBUILD_AFLAGS := $(aflags-vdso) -mabi=n32
+
+$(obj)/%-n32.o: $(src)/%.S FORCE
+	$(call if_changed_dep,as_o_S)
+
+$(obj)/%-n32.o: $(src)/%.c FORCE
+	$(call cmd,force_checksrc)
+	$(call if_changed_rule,cc_o_c)
+
+$(obj)/vdso-n32.lds: KBUILD_CPPFLAGS := -mabi=n32
+$(obj)/vdso-n32.lds: $(src)/vdso.lds.S FORCE
+	$(call if_changed_dep,cpp_lds_S)
+
+$(obj)/vdso-n32.so.dbg: $(obj)/vdso-n32.lds $(obj-vdso-n32) FORCE
+	$(call if_changed,vdsold)
+
+$(obj)/vdso-n32-image.c: VDSO_NAME := n32
+$(obj)/vdso-n32-image.c: $(obj)/vdso-n32.so.dbg $(obj)/genvdso FORCE
+	$(call if_changed,genvdso)
+
+obj-y += vdso-n32-image.o
+
+endif
+
+# FIXME: Need install rule for debug.
+# Needs to deal with dependency for generation of dbg by cmd_genvdso...
diff --git a/arch/mips/vdso/elf.S b/arch/mips/vdso/elf.S
new file mode 100644
index 000000000000..60c23d0d452c
--- /dev/null
+++ b/arch/mips/vdso/elf.S
@@ -0,0 +1,68 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include "vdso.h"
+
+#include <linux/elfnote.h>
+#include <linux/version.h>
+
+ELFNOTE_START(Linux, 0, "a")
+	.long LINUX_VERSION_CODE
+ELFNOTE_END
+
+/*
+ * The .MIPS.abiflags section must be defined with the FP ABI flags set
+ * to 'any' to be able to link with both old and new libraries.
+ * Newer toolchains are capable of automatically generating this, but we want
+ * to work with older toolchains as well. Therefore, we define the contents of
+ * this section here (under different names), and then genvdso will patch
+ * it to have the correct name and type.
+ *
+ * We base the .MIPS.abiflags section on preprocessor definitions rather than
+ * CONFIG_* because we need to match the particular ABI we are building the
+ * VDSO for.
+ *
+ * See https://dmz-portal.mips.com/wiki/MIPS_O32_ABI_-_FR0_and_FR1_Interlinking
+ * for the .MIPS.abitflags and .gnu.attributes section description.
+ */
+
+	.section .mips_abiflags, "a"
+	.align 3
+__mips_abiflags:
+	.hword	0		/* version */
+	.byte	__mips		/* isa_level */
+
+	/* isa_rev */
+#ifdef __mips_isa_rev
+	.byte	__mips_isa_rev
+#else
+	.byte	0
+#endif
+
+	/* gpr_size */
+#ifdef __mips64
+	.byte	2		/* AFL_REG_64 */
+#else
+	.byte	1		/* AFL_REG_32 */
+#endif
+
+	/* cpr1_size */
+#if (defined(__mips_isa_rev) && __mips_isa_rev >= 6) || defined(__mips64)
+	.byte	2		/* AFL_REG_64 */
+#else
+	.byte	1		/* AFL_REG_32 */
+#endif
+
+	.byte	0		/* cpr2_size (AFL_REG_NONE) */
+	.byte	0		/* fp_abi (Val_GNU_MIPS_ABI_FP_ANY) */
+	.word	0		/* isa_ext */
+	.word	0		/* ases */
+	.word	0		/* flags1 */
+	.word	0		/* flags2 */
diff --git a/arch/mips/vdso/genvdso.c b/arch/mips/vdso/genvdso.c
new file mode 100644
index 000000000000..530a36f465ce
--- /dev/null
+++ b/arch/mips/vdso/genvdso.c
@@ -0,0 +1,293 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/*
+ * This tool is used to generate the real VDSO images from the raw image. It
+ * first patches up the MIPS ABI flags and GNU attributes sections defined in
+ * elf.S to have the correct name and type. It then generates a C source file
+ * to be compiled into the kernel containing the VDSO image data and a
+ * mips_vdso_image struct for it, including symbol offsets extracted from the
+ * image.
+ *
+ * We need to be passed both a stripped and unstripped VDSO image. The stripped
+ * image is compiled into the kernel, but we must also patch up the unstripped
+ * image's ABI flags sections so that it can be installed and used for
+ * debugging.
+ */
+
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#include <byteswap.h>
+#include <elf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+/* Define these in case the system elf.h is not new enough to have them. */
+#ifndef SHT_GNU_ATTRIBUTES
+# define SHT_GNU_ATTRIBUTES	0x6ffffff5
+#endif
+#ifndef SHT_MIPS_ABIFLAGS
+# define SHT_MIPS_ABIFLAGS	0x7000002a
+#endif
+
+enum {
+	ABI_O32 = (1 << 0),
+	ABI_N32 = (1 << 1),
+	ABI_N64 = (1 << 2),
+
+	ABI_ALL = ABI_O32 | ABI_N32 | ABI_N64,
+};
+
+/* Symbols the kernel requires offsets for. */
+static struct {
+	const char *name;
+	const char *offset_name;
+	unsigned int abis;
+} vdso_symbols[] = {
+	{ "__vdso_sigreturn", "off_sigreturn", ABI_O32 },
+	{ "__vdso_rt_sigreturn", "off_rt_sigreturn", ABI_ALL },
+	{}
+};
+
+static const char *program_name;
+static const char *vdso_name;
+static unsigned char elf_class;
+static unsigned int elf_abi;
+static bool need_swap;
+static FILE *out_file;
+
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+# define HOST_ORDER		ELFDATA2LSB
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+# define HOST_ORDER		ELFDATA2MSB
+#endif
+
+#define BUILD_SWAP(bits)						\
+	static uint##bits##_t swap_uint##bits(uint##bits##_t val)	\
+	{								\
+		return need_swap ? bswap_##bits(val) : val;		\
+	}
+
+BUILD_SWAP(16)
+BUILD_SWAP(32)
+BUILD_SWAP(64)
+
+#define __FUNC(name, bits) name##bits
+#define _FUNC(name, bits) __FUNC(name, bits)
+#define FUNC(name) _FUNC(name, ELF_BITS)
+
+#define __ELF(x, bits) Elf##bits##_##x
+#define _ELF(x, bits) __ELF(x, bits)
+#define ELF(x) _ELF(x, ELF_BITS)
+
+/*
+ * Include genvdso.h twice with ELF_BITS defined differently to get functions
+ * for both ELF32 and ELF64.
+ */
+
+#define ELF_BITS 64
+#include "genvdso.h"
+#undef ELF_BITS
+
+#define ELF_BITS 32
+#include "genvdso.h"
+#undef ELF_BITS
+
+static void *map_vdso(const char *path, size_t *_size)
+{
+	int fd;
+	struct stat stat;
+	void *addr;
+	const Elf32_Ehdr *ehdr;
+
+	fd = open(path, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "%s: Failed to open '%s': %s\n", program_name,
+			path, strerror(errno));
+		return NULL;
+	}
+
+	if (fstat(fd, &stat) != 0) {
+		fprintf(stderr, "%s: Failed to stat '%s': %s\n", program_name,
+			path, strerror(errno));
+		return NULL;
+	}
+
+	addr = mmap(NULL, stat.st_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
+		    0);
+	if (addr == MAP_FAILED) {
+		fprintf(stderr, "%s: Failed to map '%s': %s\n", program_name,
+			path, strerror(errno));
+		return NULL;
+	}
+
+	/* ELF32/64 header formats are the same for the bits we're checking. */
+	ehdr = addr;
+
+	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0) {
+		fprintf(stderr, "%s: '%s' is not an ELF file\n", program_name,
+			path);
+		return NULL;
+	}
+
+	elf_class = ehdr->e_ident[EI_CLASS];
+	switch (elf_class) {
+	case ELFCLASS32:
+	case ELFCLASS64:
+		break;
+	default:
+		fprintf(stderr, "%s: '%s' has invalid ELF class\n",
+			program_name, path);
+		return NULL;
+	}
+
+	switch (ehdr->e_ident[EI_DATA]) {
+	case ELFDATA2LSB:
+	case ELFDATA2MSB:
+		need_swap = ehdr->e_ident[EI_DATA] != HOST_ORDER;
+		break;
+	default:
+		fprintf(stderr, "%s: '%s' has invalid ELF data order\n",
+			program_name, path);
+		return NULL;
+	}
+
+	if (swap_uint16(ehdr->e_machine) != EM_MIPS) {
+		fprintf(stderr,
+			"%s: '%s' has invalid ELF machine (expected EM_MIPS)\n",
+			program_name, path);
+		return NULL;
+	} else if (swap_uint16(ehdr->e_type) != ET_DYN) {
+		fprintf(stderr,
+			"%s: '%s' has invalid ELF type (expected ET_DYN)\n",
+			program_name, path);
+		return NULL;
+	}
+
+	*_size = stat.st_size;
+	return addr;
+}
+
+static bool patch_vdso(const char *path, void *vdso)
+{
+	if (elf_class == ELFCLASS64)
+		return patch_vdso64(path, vdso);
+	else
+		return patch_vdso32(path, vdso);
+}
+
+static bool get_symbols(const char *path, void *vdso)
+{
+	if (elf_class == ELFCLASS64)
+		return get_symbols64(path, vdso);
+	else
+		return get_symbols32(path, vdso);
+}
+
+int main(int argc, char **argv)
+{
+	const char *dbg_vdso_path, *vdso_path, *out_path;
+	void *dbg_vdso, *vdso;
+	size_t dbg_vdso_size, vdso_size, i;
+
+	program_name = argv[0];
+
+	if (argc < 4 || argc > 5) {
+		fprintf(stderr,
+			"Usage: %s <debug VDSO> <stripped VDSO> <output file> [<name>]\n",
+			program_name);
+		return EXIT_FAILURE;
+	}
+
+	dbg_vdso_path = argv[1];
+	vdso_path = argv[2];
+	out_path = argv[3];
+	vdso_name = (argc > 4) ? argv[4] : "";
+
+	dbg_vdso = map_vdso(dbg_vdso_path, &dbg_vdso_size);
+	if (!dbg_vdso)
+		return EXIT_FAILURE;
+
+	vdso = map_vdso(vdso_path, &vdso_size);
+	if (!vdso)
+		return EXIT_FAILURE;
+
+	/* Patch both the VDSOs' ABI flags sections. */
+	if (!patch_vdso(dbg_vdso_path, dbg_vdso))
+		return EXIT_FAILURE;
+	if (!patch_vdso(vdso_path, vdso))
+		return EXIT_FAILURE;
+
+	if (msync(dbg_vdso, dbg_vdso_size, MS_SYNC) != 0) {
+		fprintf(stderr, "%s: Failed to sync '%s': %s\n", program_name,
+			dbg_vdso_path, strerror(errno));
+		return EXIT_FAILURE;
+	} else if (msync(vdso, vdso_size, MS_SYNC) != 0) {
+		fprintf(stderr, "%s: Failed to sync '%s': %s\n", program_name,
+			vdso_path, strerror(errno));
+		return EXIT_FAILURE;
+	}
+
+	out_file = fopen(out_path, "w");
+	if (!out_file) {
+		fprintf(stderr, "%s: Failed to open '%s': %s\n", program_name,
+			out_path, strerror(errno));
+		return EXIT_FAILURE;
+	}
+
+	fprintf(out_file, "/* Automatically generated - do not edit */\n");
+	fprintf(out_file, "#include <linux/linkage.h>\n");
+	fprintf(out_file, "#include <linux/mm.h>\n");
+	fprintf(out_file, "#include <asm/vdso.h>\n");
+
+	/* Write out the stripped VDSO data. */
+	fprintf(out_file,
+		"static unsigned char vdso_data[PAGE_ALIGN(%zu)] __page_aligned_data = {\n\t",
+		vdso_size);
+	for (i = 0; i < vdso_size; i++) {
+		if (!(i % 10))
+			fprintf(out_file, "\n\t");
+		fprintf(out_file, "0x%02x, ", ((unsigned char *)vdso)[i]);
+	}
+	fprintf(out_file, "\n};\n");
+
+	/* Preallocate a page array. */
+	fprintf(out_file,
+		"static struct page *vdso_pages[PAGE_ALIGN(%zu) / PAGE_SIZE];\n",
+		vdso_size);
+
+	fprintf(out_file, "struct mips_vdso_image vdso_image%s%s = {\n",
+		(vdso_name[0]) ? "_" : "", vdso_name);
+	fprintf(out_file, "\t.data = vdso_data,\n");
+	fprintf(out_file, "\t.size = PAGE_ALIGN(%zu),\n", vdso_size);
+	fprintf(out_file, "\t.mapping = {\n");
+	fprintf(out_file, "\t\t.name = \"[vdso]\",\n");
+	fprintf(out_file, "\t\t.pages = vdso_pages,\n");
+	fprintf(out_file, "\t},\n");
+
+	/* Calculate and write symbol offsets to <output file> */
+	if (!get_symbols(dbg_vdso_path, dbg_vdso)) {
+		unlink(out_path);
+		return EXIT_FAILURE;
+	}
+
+	fprintf(out_file, "};\n");
+
+	return EXIT_SUCCESS;
+}
diff --git a/arch/mips/vdso/genvdso.h b/arch/mips/vdso/genvdso.h
new file mode 100644
index 000000000000..94334727059a
--- /dev/null
+++ b/arch/mips/vdso/genvdso.h
@@ -0,0 +1,187 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+static inline bool FUNC(patch_vdso)(const char *path, void *vdso)
+{
+	const ELF(Ehdr) *ehdr = vdso;
+	void *shdrs;
+	ELF(Shdr) *shdr;
+	char *shstrtab, *name;
+	uint16_t sh_count, sh_entsize, i;
+	unsigned int local_gotno, symtabno, gotsym;
+	ELF(Dyn) *dyn = NULL;
+
+	shdrs = vdso + FUNC(swap_uint)(ehdr->e_shoff);
+	sh_count = swap_uint16(ehdr->e_shnum);
+	sh_entsize = swap_uint16(ehdr->e_shentsize);
+
+	shdr = shdrs + (sh_entsize * swap_uint16(ehdr->e_shstrndx));
+	shstrtab = vdso + FUNC(swap_uint)(shdr->sh_offset);
+
+	for (i = 0; i < sh_count; i++) {
+		shdr = shdrs + (i * sh_entsize);
+		name = shstrtab + swap_uint32(shdr->sh_name);
+
+		/*
+		 * Ensure there are no relocation sections - ld.so does not
+		 * relocate the VDSO so if there are relocations things will
+		 * break.
+		 */
+		switch (swap_uint32(shdr->sh_type)) {
+		case SHT_REL:
+		case SHT_RELA:
+			fprintf(stderr,
+				"%s: '%s' contains relocation sections\n",
+				program_name, path);
+			return false;
+		case SHT_DYNAMIC:
+			dyn = vdso + FUNC(swap_uint)(shdr->sh_offset);
+			break;
+		}
+
+		/* Check for existing sections. */
+		if (strcmp(name, ".MIPS.abiflags") == 0) {
+			fprintf(stderr,
+				"%s: '%s' already contains a '.MIPS.abiflags' section\n",
+				program_name, path);
+			return false;
+		}
+
+		if (strcmp(name, ".mips_abiflags") == 0) {
+			strcpy(name, ".MIPS.abiflags");
+			shdr->sh_type = swap_uint32(SHT_MIPS_ABIFLAGS);
+			shdr->sh_entsize = shdr->sh_size;
+		}
+	}
+
+	/*
+	 * Ensure the GOT has no entries other than the standard 2, for the same
+	 * reason we check that there's no relocation sections above.
+	 * The standard two entries are:
+	 * - Lazy resolver
+	 * - Module pointer
+	 */
+	if (dyn) {
+		local_gotno = symtabno = gotsym = 0;
+
+		while (FUNC(swap_uint)(dyn->d_tag) != DT_NULL) {
+			switch (FUNC(swap_uint)(dyn->d_tag)) {
+			/*
+			 * This member holds the number of local GOT entries.
+			 */
+			case DT_MIPS_LOCAL_GOTNO:
+				local_gotno = FUNC(swap_uint)(dyn->d_un.d_val);
+				break;
+			/*
+			 * This member holds the number of entries in the
+			 * .dynsym section.
+			 */
+			case DT_MIPS_SYMTABNO:
+				symtabno = FUNC(swap_uint)(dyn->d_un.d_val);
+				break;
+			/*
+			 * This member holds the index of the first dynamic
+			 * symbol table entry that corresponds to an entry in
+			 * the GOT.
+			 */
+			case DT_MIPS_GOTSYM:
+				gotsym = FUNC(swap_uint)(dyn->d_un.d_val);
+				break;
+			}
+
+			dyn++;
+		}
+
+		if (local_gotno > 2 || symtabno - gotsym) {
+			fprintf(stderr,
+				"%s: '%s' contains unexpected GOT entries\n",
+				program_name, path);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static inline bool FUNC(get_symbols)(const char *path, void *vdso)
+{
+	const ELF(Ehdr) *ehdr = vdso;
+	void *shdrs, *symtab;
+	ELF(Shdr) *shdr;
+	const ELF(Sym) *sym;
+	char *strtab, *name;
+	uint16_t sh_count, sh_entsize, st_count, st_entsize, i, j;
+	uint64_t offset;
+	uint32_t flags;
+
+	shdrs = vdso + FUNC(swap_uint)(ehdr->e_shoff);
+	sh_count = swap_uint16(ehdr->e_shnum);
+	sh_entsize = swap_uint16(ehdr->e_shentsize);
+
+	for (i = 0; i < sh_count; i++) {
+		shdr = shdrs + (i * sh_entsize);
+
+		if (swap_uint32(shdr->sh_type) == SHT_SYMTAB)
+			break;
+	}
+
+	if (i == sh_count) {
+		fprintf(stderr, "%s: '%s' has no symbol table\n", program_name,
+			path);
+		return false;
+	}
+
+	/* Get flags */
+	flags = swap_uint32(ehdr->e_flags);
+	if (elf_class == ELFCLASS64)
+		elf_abi = ABI_N64;
+	else if (flags & EF_MIPS_ABI2)
+		elf_abi = ABI_N32;
+	else
+		elf_abi = ABI_O32;
+
+	/* Get symbol table. */
+	symtab = vdso + FUNC(swap_uint)(shdr->sh_offset);
+	st_entsize = FUNC(swap_uint)(shdr->sh_entsize);
+	st_count = FUNC(swap_uint)(shdr->sh_size) / st_entsize;
+
+	/* Get string table. */
+	shdr = shdrs + (swap_uint32(shdr->sh_link) * sh_entsize);
+	strtab = vdso + FUNC(swap_uint)(shdr->sh_offset);
+
+	/* Write offsets for symbols needed by the kernel. */
+	for (i = 0; vdso_symbols[i].name; i++) {
+		if (!(vdso_symbols[i].abis & elf_abi))
+			continue;
+
+		for (j = 0; j < st_count; j++) {
+			sym = symtab + (j * st_entsize);
+			name = strtab + swap_uint32(sym->st_name);
+
+			if (!strcmp(name, vdso_symbols[i].name)) {
+				offset = FUNC(swap_uint)(sym->st_value);
+
+				fprintf(out_file,
+					"\t.%s = 0x%" PRIx64 ",\n",
+					vdso_symbols[i].offset_name, offset);
+				break;
+			}
+		}
+
+		if (j == st_count) {
+			fprintf(stderr,
+				"%s: '%s' is missing required symbol '%s'\n",
+				program_name, path, vdso_symbols[i].name);
+			return false;
+		}
+	}
+
+	return true;
+}
diff --git a/arch/mips/vdso/sigreturn.S b/arch/mips/vdso/sigreturn.S
new file mode 100644
index 000000000000..715bf5993529
--- /dev/null
+++ b/arch/mips/vdso/sigreturn.S
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include "vdso.h"
+
+#include <uapi/asm/unistd.h>
+
+#include <asm/regdef.h>
+#include <asm/asm.h>
+
+	.section	.text
+	.cfi_sections	.debug_frame
+
+LEAF(__vdso_rt_sigreturn)
+	.cfi_startproc
+	.frame	sp, 0, ra
+	.mask	0x00000000, 0
+	.fmask	0x00000000, 0
+	.cfi_signal_frame
+
+	li	v0, __NR_rt_sigreturn
+	syscall
+
+	.cfi_endproc
+	END(__vdso_rt_sigreturn)
+
+#if _MIPS_SIM == _MIPS_SIM_ABI32
+
+LEAF(__vdso_sigreturn)
+	.cfi_startproc
+	.frame	sp, 0, ra
+	.mask	0x00000000, 0
+	.fmask	0x00000000, 0
+	.cfi_signal_frame
+
+	li	v0, __NR_sigreturn
+	syscall
+
+	.cfi_endproc
+	END(__vdso_sigreturn)
+
+#endif
diff --git a/arch/mips/vdso/vdso.h b/arch/mips/vdso/vdso.h
new file mode 100644
index 000000000000..64b98967e245
--- /dev/null
+++ b/arch/mips/vdso/vdso.h
@@ -0,0 +1,79 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <asm/sgidefs.h>
+
+#if _MIPS_SIM != _MIPS_SIM_ABI64 && defined(CONFIG_64BIT)
+
+/* Building 32-bit VDSO for the 64-bit kernel. Fake a 32-bit Kconfig. */
+#undef CONFIG_64BIT
+#define CONFIG_32BIT 1
+
+#endif
+
+#ifndef __ASSEMBLY__
+
+#include <asm/asm.h>
+#include <asm/page.h>
+#include <asm/vdso.h>
+
+static inline unsigned long get_vdso_base(void)
+{
+	unsigned long addr;
+
+	/*
+	 * Get the base load address of the VDSO. We have to avoid generating
+	 * relocations and references to the GOT because ld.so does not peform
+	 * relocations on the VDSO. We use the current offset from the VDSO base
+	 * and perform a PC-relative branch which gives the absolute address in
+	 * ra, and take the difference. The assembler chokes on
+	 * "li %0, _start - .", so embed the offset as a word and branch over
+	 * it.
+	 *
+	 * TODO: Is there a better way to do this?
+	 */
+
+#ifdef CONFIG_CPU_MIPSR6
+	/*
+	 * We can't use cpu_has_mips_r6 since it will create a relocation
+	 * in the VDSO because of the global cpu_data[] variable.
+	 */
+
+	/* lapc <symbol> is an alias to addiupc reg, <symbol> - .
+	 *
+	 * We can't use addiupc because there is no label-label
+	 * support for the addiupc reloc
+	 */
+	__asm__("lapc	%0, _start			\n"
+		: "=r" (addr) : :);
+#else
+	__asm__(
+	"	.set push				\n"
+	"	.set noreorder				\n"
+	"	bal	1f				\n"
+	"	 nop					\n"
+	"	.word	_start - .			\n"
+	"1:	lw	%0, 0($31)			\n"
+	"	" STR(PTR_ADDU) " %0, $31, %0		\n"
+	"	.set pop				\n"
+	: "=r" (addr)
+	:
+	: "$31");
+#endif /* CONFIG_CPU_MIPSR6 */
+
+	return addr;
+}
+
+static inline const union mips_vdso_data *get_vdso_data(void)
+{
+	return (const union mips_vdso_data *)(get_vdso_base() - PAGE_SIZE);
+}
+
+#endif /* __ASSEMBLY__ */
diff --git a/arch/mips/vdso/vdso.lds.S b/arch/mips/vdso/vdso.lds.S
new file mode 100644
index 000000000000..21655b6fefc5
--- /dev/null
+++ b/arch/mips/vdso/vdso.lds.S
@@ -0,0 +1,100 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <asm/sgidefs.h>
+
+#if _MIPS_SIM == _MIPS_SIM_ABI64
+OUTPUT_FORMAT("elf64-tradlittlemips", "elf64-tradbigmips", "elf64-tradlittlemips")
+#elif _MIPS_SIM == _MIPS_SIM_NABI32
+OUTPUT_FORMAT("elf32-ntradlittlemips", "elf32-ntradbigmips", "elf32-ntradlittlemips")
+#else
+OUTPUT_FORMAT("elf32-tradlittlemips", "elf32-tradbigmips", "elf32-tradlittlemips")
+#endif
+
+OUTPUT_ARCH(mips)
+
+SECTIONS
+{
+	PROVIDE(_start = .);
+	. = SIZEOF_HEADERS;
+
+	/*
+	 * In order to retain compatibility with older toolchains we provide the
+	 * ABI flags section ourself. Newer assemblers will automatically
+	 * generate .MIPS.abiflags sections so we discard such input sections,
+	 * and then manually define our own section here. genvdso will patch
+	 * this section to have the correct name/type.
+	 */
+	.mips_abiflags	: { *(.mips_abiflags) } 	:text :abiflags
+
+	.reginfo	: { *(.reginfo) }		:text :reginfo
+
+	.hash		: { *(.hash) }			:text
+	.gnu.hash	: { *(.gnu.hash) }
+	.dynsym		: { *(.dynsym) }
+	.dynstr		: { *(.dynstr) }
+	.gnu.version	: { *(.gnu.version) }
+	.gnu.version_d	: { *(.gnu.version_d) }
+	.gnu.version_r	: { *(.gnu.version_r) }
+
+	.note		: { *(.note.*) }		:text :note
+
+	.text		: { *(.text*) }			:text
+	PROVIDE (__etext = .);
+	PROVIDE (_etext = .);
+	PROVIDE (etext = .);
+
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text :eh_frame_hdr
+	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+
+	.dynamic	: { *(.dynamic) }		:text :dynamic
+
+	.rodata		: { *(.rodata*) }		:text
+
+	_end = .;
+	PROVIDE(end = .);
+
+	/DISCARD/	: {
+		*(.MIPS.abiflags)
+		*(.gnu.attributes)
+		*(.note.GNU-stack)
+		*(.data .data.* .gnu.linkonce.d.* .sdata*)
+		*(.bss .sbss .dynbss .dynsbss)
+	}
+}
+
+PHDRS
+{
+	/*
+	 * Provide a PT_MIPS_ABIFLAGS header to assign the ABI flags section
+	 * to. We can specify the header type directly here so no modification
+	 * is needed later on.
+	 */
+	abiflags	0x70000003;
+
+	/*
+	 * The ABI flags header must exist directly after the PT_INTERP header,
+	 * so we must explicitly place the PT_MIPS_REGINFO header after it to
+	 * stop the linker putting one in at the start.
+	 */
+	reginfo		0x70000000;
+
+	text		PT_LOAD		FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
+	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
+	note		PT_NOTE		FLAGS(4);		/* PF_R */
+	eh_frame_hdr	PT_GNU_EH_FRAME;
+}
+
+VERSION
+{
+	LINUX_2.6 {
+	local: *;
+	};
+}
-- 
2.5.3
