Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Nov 2015 01:48:41 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47015 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013461AbbKMAsKqYSsl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Nov 2015 01:48:10 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 27416E99AF60A;
        Fri, 13 Nov 2015 00:48:00 +0000 (GMT)
Received: from [10.100.200.62] (10.100.200.62) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server id 14.3.235.1; Fri, 13 Nov 2015
 00:48:03 +0000
Date:   Fri, 13 Nov 2015 00:48:02 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/8] MIPS: ELF: Interpret the NAN2008 file header flag
In-Reply-To: <alpine.DEB.2.00.1511111418430.7097@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1511130006250.7097@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1511111418430.7097@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.62]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Handle the EF_MIPS_NAN2008 ELF file header flag and refuse execution 
where there is no support in the FPU for the NaN encoding mode requested 
by a binary invoked.  Ensure that the setting of the bit in the binary 
matches one in any intepreter used.  Set the thread's initial FCSR 
contents according to the value of the EF_MIPS_NAN2008.

Set the values of the FCSR ABS2008 and NAN2008 bits both to the same 
value if possible, to take the approach taken with existing FPU hardware 
into account.  As of now all implementations have both bits hardwired to 
the same value, that is both are fixed at 0 or both are fixed at 1, even 
though the architecture allows for implementations where the amount of 
control implemented with each of these two individual bits is 
independent of each other.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
This change relies on <https://patchwork.kernel.org/patch/7491081/> to 
work correctly for dynamic binaries, otherwise an opposite-mode 
interpreter will be incorrectly accepted, and worse yet enforce any 
additional shared binaries to have their NaN mode opposite to that of the 
main binary.  This will normally only happen for broken installations or 
incorrectly built binaries where PT_INTERP points to the wrong dynamic 
linker though.  Static binaries are unaffected.

linux-mips-elf-nan2008.diff
Index: linux-sfr-test/arch/mips/include/asm/elf.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/elf.h	2015-11-11 02:20:02.099077000 +0000
+++ linux-sfr-test/arch/mips/include/asm/elf.h	2015-11-11 02:20:16.030180000 +0000
@@ -12,7 +12,6 @@
 #include <linux/fs.h>
 #include <uapi/linux/elf.h>
 
-#include <asm/cpu-info.h>
 #include <asm/current.h>
 
 /* ELF header e_flags defines. */
@@ -44,6 +43,7 @@
 #define EF_MIPS_OPTIONS_FIRST	0x00000080
 #define EF_MIPS_32BITMODE	0x00000100
 #define EF_MIPS_FP64		0x00000200
+#define EF_MIPS_NAN2008		0x00000400
 #define EF_MIPS_ABI		0x0000f000
 #define EF_MIPS_ARCH		0xf0000000
 
@@ -305,7 +305,7 @@ do {									\
 									\
 	current->thread.abi = &mips_abi;				\
 									\
-	current->thread.fpu.fcr31 = boot_cpu_data.fpu_csr31;		\
+	mips_set_personality_nan(state);				\
 } while (0)
 
 #endif /* CONFIG_32BIT */
@@ -367,7 +367,7 @@ do {									\
 	else								\
 		current->thread.abi = &mips_abi;			\
 									\
-	current->thread.fpu.fcr31 = boot_cpu_data.fpu_csr31;		\
+	mips_set_personality_nan(state);				\
 									\
 	p = personality(current->personality);				\
 	if (p != PER_LINUX32 && p != PER_LINUX)				\
@@ -432,6 +432,7 @@ extern int arch_setup_additional_pages(s
 				       int uses_interp);
 
 struct arch_elf_state {
+	int nan_2008;
 	int fp_abi;
 	int interp_fp_abi;
 	int overall_fp_mode;
@@ -440,6 +441,7 @@ struct arch_elf_state {
 #define MIPS_ABI_FP_UNKNOWN	(-1)	/* Unknown FP ABI (kernel internal) */
 
 #define INIT_ARCH_ELF_STATE {			\
+	.nan_2008 = -1,				\
 	.fp_abi = MIPS_ABI_FP_UNKNOWN,		\
 	.interp_fp_abi = MIPS_ABI_FP_UNKNOWN,	\
 	.overall_fp_mode = -1,			\
@@ -451,6 +453,7 @@ extern int arch_elf_pt_proc(void *ehdr, 
 extern int arch_check_elf(void *ehdr, bool has_interpreter, void *interp_ehdr,
 			  struct arch_elf_state *state);
 
+extern void mips_set_personality_nan(struct arch_elf_state *state);
 extern void mips_set_personality_fp(struct arch_elf_state *state);
 
 #endif /* _ASM_ELF_H */
Index: linux-sfr-test/arch/mips/kernel/elf.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/elf.c	2015-11-11 02:20:02.104077000 +0000
+++ linux-sfr-test/arch/mips/kernel/elf.c	2015-11-11 02:20:16.033179000 +0000
@@ -11,6 +11,8 @@
 #include <linux/elf.h>
 #include <linux/sched.h>
 
+#include <asm/cpu-info.h>
+
 /* FPU modes */
 enum {
 	FP_FRE,
@@ -135,6 +137,10 @@ int arch_check_elf(void *_ehdr, bool has
 		struct elf32_hdr e32;
 		struct elf64_hdr e64;
 	} *ehdr = _ehdr;
+	union {
+		struct elf32_hdr e32;
+		struct elf64_hdr e64;
+	} *iehdr = _interp_ehdr;
 	struct mode_req prog_req, interp_req;
 	int fp_abi, interp_fp_abi, abi0, abi1, max_abi;
 	bool elf32;
@@ -143,6 +149,32 @@ int arch_check_elf(void *_ehdr, bool has
 	elf32 = ehdr->e32.e_ident[EI_CLASS] == ELFCLASS32;
 	flags = elf32 ? ehdr->e32.e_flags : ehdr->e64.e_flags;
 
+	/*
+	 * Determine the NaN personality, reject the binary if no hardware
+	 * support.  Also ensure that any interpreter matches the executable.
+	 */
+	if (flags & EF_MIPS_NAN2008) {
+		if (cpu_has_nan_2008)
+			state->nan_2008 = 1;
+		else
+			return -ENOEXEC;
+	} else {
+		if (cpu_has_nan_legacy)
+			state->nan_2008 = 0;
+		else
+			return -ENOEXEC;
+	}
+	if (has_interpreter) {
+		bool ielf32;
+		u32 iflags;
+
+		ielf32 = iehdr->e32.e_ident[EI_CLASS] == ELFCLASS32;
+		iflags = ielf32 ? iehdr->e32.e_flags : iehdr->e64.e_flags;
+
+		if ((flags ^ iflags) & EF_MIPS_NAN2008)
+			return -ELIBBAD;
+	}
+
 	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
 		return 0;
 
@@ -266,3 +298,27 @@ void mips_set_personality_fp(struct arch
 		BUG();
 	}
 }
+
+/*
+ * Select the IEEE 754 NaN encoding and ABS.fmt/NEG.fmt execution mode
+ * in FCSR according to the ELF NaN personality.
+ */
+void mips_set_personality_nan(struct arch_elf_state *state)
+{
+	struct cpuinfo_mips *c = &boot_cpu_data;
+	struct task_struct *t = current;
+
+	t->thread.fpu.fcr31 = c->fpu_csr31;
+	switch (state->nan_2008) {
+	case 0:
+		break;
+	case 1:
+		if (!(c->fpu_msk31 & FPU_CSR_NAN2008))
+			t->thread.fpu.fcr31 |= FPU_CSR_NAN2008;
+		if (!(c->fpu_msk31 & FPU_CSR_ABS2008))
+			t->thread.fpu.fcr31 |= FPU_CSR_ABS2008;
+		break;
+	default:
+		BUG();
+	}
+}
