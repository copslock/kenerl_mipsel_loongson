Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 15:35:21 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39476 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013934AbbKPOfN2xPAR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2015 15:35:13 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id E493CFB0E9AB1;
        Mon, 16 Nov 2015 14:35:03 +0000 (GMT)
Received: from [10.100.200.62] (10.100.200.62) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server id 14.3.235.1; Mon, 16 Nov 2015
 14:35:06 +0000
Date:   Mon, 16 Nov 2015 14:35:04 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Daniel Sanders <Daniel.Sanders@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 3/4] MIPS: Implement IEEE Std 754 NaN interlinking
 support
In-Reply-To: <alpine.DEB.2.00.1511161358211.7097@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1511161413320.7097@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1511161358211.7097@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.62]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49939
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

Implement the kernel part of IEEE Std 754 NaN interlinking support, as 
per "MIPS ABI Extension for IEEE Std 754 Non-Compliant Interlinking" 
<https://dmz-portal.mips.com/wiki/MIPS_ABI_-_NaN_Interlinking>:

* interpret the MIPS_AFL_FLAGS1_IEEE and MIPS_AFL_FLAGS2_RELAXED flags 
  in PT_MIPS_ABIFLAGS,

* accept or reject ELF binaries and interpreters accordingly,

* initialise auxiliary vector's AT_FLAGS appropriately,

* suppress Invalid Operation exceptions with operations on sNaN data.

Add a `strictest' setting to the `ieee754=' kernel parameter to enforce 
a full IEEE Std 754 conformance and reject any binaries which request 
the relaxed NaN encoding mode.  Update documentation accordingly.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-nan-interlink.diff
Index: linux-sfr-test/Documentation/kernel-parameters.txt
===================================================================
--- linux-sfr-test.orig/Documentation/kernel-parameters.txt	2015-11-11 02:21:08.155578000 +0000
+++ linux-sfr-test/Documentation/kernel-parameters.txt	2015-11-11 12:22:51.732826000 +0000
@@ -1400,7 +1400,8 @@ bytes respectively. Such letter suffixes
 			idle=nomwait: Disable mwait for CPU C-states
 
 	ieee754=	[MIPS] Select IEEE Std 754 conformance mode
-			Format: { strict | legacy | 2008 | relaxed }
+			Format: { strictest | strict | best | legacy | 2008 |
+				  relaxed }
 			Default: strict
 
 			Choose which programs will be accepted for execution
@@ -1412,23 +1413,30 @@ bytes respectively. Such letter suffixes
 			encoding mode.
 
 			Available settings are as follows:
-			strict	accept binaries that request a NaN encoding
-				supported by the FPU
-			legacy	only accept legacy-NaN binaries, if supported
-				by the FPU
-			2008	only accept 2008-NaN binaries, if supported
-				by the FPU
-			relaxed	accept any binaries regardless of whether
-				supported by the FPU
+			strictest	require binaries to request a NaN
+					encoding supported by the FPU, reject
+					binaries that request the relaxed NaN
+					encoding mode
+			strict		accept binaries that request a NaN
+					encoding supported by the FPU
+			best		accept binaries that request a NaN
+					encoding supported by the FPU or all
+					on the emulator
+			legacy		only accept legacy-NaN binaries, if
+					supported by the FPU
+			2008		only accept 2008-NaN binaries, if
+					supported by the FPU
+			relaxed		accept any binaries regardless of
+					whether supported by the FPU
 
 			The FPU emulator is always able to support both NaN
-			encodings, so if no FPU hardware is present or it has
-			been disabled with 'nofpu', then the settings of
+			encodings, so if no FPU hardware is present or it
+			has been disabled with 'nofpu', then the settings of
 			'legacy' and '2008' strap the emulator accordingly,
-			'relaxed' straps the emulator for both legacy-NaN and
-			2008-NaN, whereas 'strict' enables legacy-NaN only on
-			legacy processors and both NaN encodings on MIPS32 or
-			MIPS64 CPUs.
+			'best' and 'relaxed' strap the emulator for both
+			legacy-NaN and 2008-NaN, whereas 'strictest' and
+			'strict' enable legacy-NaN only on legacy processors
+			and both NaN encodings on MIPS32 or MIPS64 CPUs.
 
 			The setting for ABS.fmt/NEG.fmt instruction execution
 			mode generally follows that for the NaN encoding,
Index: linux-sfr-test/arch/mips/include/asm/elf.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/elf.h	2015-11-11 02:21:08.158574000 +0000
+++ linux-sfr-test/arch/mips/include/asm/elf.h	2015-11-11 12:23:55.325343000 +0000
@@ -170,6 +170,13 @@
 #define SHF_MIPS_NAMES		0x02000000
 #define SHF_MIPS_NODUPES	0x01000000
 
+/* AT_FLAGS bits 31:24 are reserved for system semantics in the MIPS psABI.  */
+#define AV_FLAGS_SYSTEM_SHIFT	24
+
+/* MIPS/Linux system AT_FLAGS bits.  */
+#define AV_FLAGS_MIPS_RELAXED	(1U << (AV_FLAGS_SYSTEM_SHIFT + 1))
+						/* Relaxed IEEE 754 mode.  */
+
 #ifndef ELF_ARCH
 /* ELF register definitions */
 #define ELF_NGREG	45
@@ -205,6 +212,14 @@ struct mips_elf_abiflags_v0 {
 #define MIPS_ABI_FP_64		6	/* -mips32r2 -mfp64 */
 #define MIPS_ABI_FP_64A		7	/* -mips32r2 -mfp64 -mno-odd-spreg */
 
+/* Masks for `flags1'.  */
+/* IEEE Std 754 compliance mode selection requested.  */
+#define MIPS_AFL_FLAGS1_IEEE	(1U << 1)
+
+/* Masks for `flags2'.  */
+/* IEEE Std 754 relaxed compliance mode selected.  */
+#define MIPS_AFL_FLAGS2_RELAXED	(1U << 1)
+
 #ifdef CONFIG_32BIT
 
 /*
@@ -379,6 +394,18 @@ do {									\
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	PAGE_SIZE
 
+/* Platform-specific informational flags.  */
+
+#define ELF_FLAGS							\
+({									\
+	elf_addr_t at_flags = 0;					\
+									\
+	if (test_thread_flag(TIF_IEEE754_RELAXED))			\
+		at_flags |= AV_FLAGS_MIPS_RELAXED;			\
+									\
+	at_flags;							\
+})
+
 /* This yields a mask that user programs can use to figure out what
    instruction set this cpu supports.  This could be done in userspace,
    but it's not easy, and we've already done it here.  */
@@ -436,21 +463,31 @@ struct arch_elf_state {
 	int fp_abi;
 	int interp_fp_abi;
 	int overall_fp_mode;
+	bool ieee754_relaxed;
+	bool interp_ieee754_relaxed;
 };
 
 #define MIPS_ABI_FP_UNKNOWN	(-1)	/* Unknown FP ABI (kernel internal) */
 
-#define INIT_ARCH_ELF_STATE {			\
-	.nan_2008 = -1,				\
-	.fp_abi = MIPS_ABI_FP_UNKNOWN,		\
-	.interp_fp_abi = MIPS_ABI_FP_UNKNOWN,	\
-	.overall_fp_mode = -1,			\
+#define INIT_ARCH_ELF_STATE {						\
+	.nan_2008 = -1,							\
+	.fp_abi = MIPS_ABI_FP_UNKNOWN,					\
+	.interp_fp_abi = MIPS_ABI_FP_UNKNOWN,				\
+	.overall_fp_mode = -1,						\
+	.ieee754_relaxed = mips_default_ieee754_relaxed,		\
+	.interp_ieee754_relaxed = false,				\
 }
 
 /* Whether to accept legacy-NaN and 2008-NaN user binaries.  */
 extern bool mips_use_nan_legacy;
 extern bool mips_use_nan_2008;
 
+/* Whether to select the IEEE Std 754 relaxed compliance mode by default.  */
+extern bool mips_default_ieee754_relaxed;
+
+/* Whether to accept IEEE Std 754 relaxed compliance mode binaries.  */
+extern bool mips_accept_ieee754_relaxed;
+
 extern int arch_elf_pt_proc(void *ehdr, void *phdr, struct file *elf,
 			    bool is_interp, struct arch_elf_state *state);
 
Index: linux-sfr-test/arch/mips/include/asm/thread_info.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/thread_info.h	2015-11-11 02:21:08.160573000 +0000
+++ linux-sfr-test/arch/mips/include/asm/thread_info.h	2015-11-11 12:22:51.855825000 +0000
@@ -102,6 +102,7 @@ static inline struct thread_info *curren
 #define TIF_UPROBE		6	/* breakpointed or singlestepping */
 #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
+#define TIF_IEEE754_RELAXED	17	/* Relaxed IEEE Std 754 rules */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_NOHZ		19	/* in adaptive nohz mode */
 #define TIF_FIXADE		20	/* Fix address errors in software */
Index: linux-sfr-test/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/cpu-probe.c	2015-11-11 02:21:08.161578000 +0000
+++ linux-sfr-test/arch/mips/kernel/cpu-probe.c	2015-11-11 12:22:51.859824000 +0000
@@ -154,13 +154,15 @@ static void cpu_set_fpu_2008(struct cpui
  * IEEE 754 conformance mode to use.  Affects the NaN encoding and the
  * ABS.fmt/NEG.fmt execution mode.
  */
-static enum { STRICT, LEGACY, STD2008, RELAXED } ieee754 = STRICT;
+static enum {
+	STRICTEST, STRICT, BEST, LEGACY, STD2008, RELAXED
+} ieee754 = STRICT;
 
 /*
  * Set the IEEE 754 NaN encodings and the ABS.fmt/NEG.fmt execution modes
  * to support by the FPU emulator according to the IEEE 754 conformance
- * mode selected.  Note that "relaxed" straps the emulator so that it
- * allows 2008-NaN binaries even for legacy processors.
+ * mode selected.  Note that "best" and "relaxed" strap the emulator so
+ * that it allows 2008-NaN binaries even for legacy processors.
  */
 static void cpu_set_nofpu_2008(struct cpuinfo_mips *c)
 {
@@ -169,6 +171,7 @@ static void cpu_set_nofpu_2008(struct cp
 	c->fpu_msk31 &= ~(FPU_CSR_ABS2008 | FPU_CSR_NAN2008);
 
 	switch (ieee754) {
+	case STRICTEST:
 	case STRICT:
 		if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M64R1 |
 				    MIPS_CPU_ISA_M32R2 | MIPS_CPU_ISA_M64R2 |
@@ -179,6 +182,9 @@ static void cpu_set_nofpu_2008(struct cp
 			c->fpu_msk31 |= FPU_CSR_ABS2008 | FPU_CSR_NAN2008;
 		}
 		break;
+	case BEST:
+		c->options |= MIPS_CPU_NAN_2008 | MIPS_CPU_NAN_LEGACY;
+		break;
 	case LEGACY:
 		c->options |= MIPS_CPU_NAN_LEGACY;
 		c->fpu_msk31 |= FPU_CSR_ABS2008 | FPU_CSR_NAN2008;
@@ -200,8 +206,13 @@ static void cpu_set_nofpu_2008(struct cp
  */
 static void cpu_set_nan_2008(struct cpuinfo_mips *c)
 {
+	mips_default_ieee754_relaxed = ieee754 == RELAXED;
+	mips_accept_ieee754_relaxed = ieee754 != STRICTEST;
+
 	switch (ieee754) {
+	case STRICTEST:
 	case STRICT:
+	case BEST:
 		mips_use_nan_legacy = !!cpu_has_nan_legacy;
 		mips_use_nan_2008 = !!cpu_has_nan_2008;
 		break;
@@ -224,17 +235,23 @@ static void cpu_set_nan_2008(struct cpui
  * IEEE 754 NaN encoding and ABS.fmt/NEG.fmt execution mode override
  * settings:
  *
- * strict:  accept binaries that request a NaN encoding supported by the FPU
- * legacy:  only accept legacy-NaN binaries
- * 2008:    only accept 2008-NaN binaries
- * relaxed: accept any binaries regardless of whether supported by the FPU
+ * strictest: require binaries to request a NaN encoding supported by the FPU
+ * strict:    accept binaries that request a NaN encoding supported by the FPU
+ * best:      accept all binaries in full FP emulation, otherwise like "strict"
+ * legacy:    only accept legacy-NaN binaries
+ * 2008:      only accept 2008-NaN binaries
+ * relaxed:   accept any binaries regardless of whether supported by the FPU
  */
 static int __init ieee754_setup(char *s)
 {
 	if (!s)
 		return -1;
+	else if (!strcmp(s, "strictest"))
+		ieee754 = STRICTEST;
 	else if (!strcmp(s, "strict"))
 		ieee754 = STRICT;
+	else if (!strcmp(s, "best"))
+		ieee754 = BEST;
 	else if (!strcmp(s, "legacy"))
 		ieee754 = LEGACY;
 	else if (!strcmp(s, "2008"))
Index: linux-sfr-test/arch/mips/kernel/elf.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/elf.c	2015-11-11 02:21:08.163575000 +0000
+++ linux-sfr-test/arch/mips/kernel/elf.c	2015-11-11 12:22:51.861832000 +0000
@@ -17,6 +17,12 @@
 bool mips_use_nan_legacy;
 bool mips_use_nan_2008;
 
+/* Whether to select the IEEE Std 754 relaxed compliance mode by default.  */
+bool mips_default_ieee754_relaxed;
+
+/* Whether to accept IEEE Std 754 relaxed compliance mode binaries.  */
+bool mips_accept_ieee754_relaxed;
+
 /* FPU modes */
 enum {
 	FP_FRE,
@@ -81,6 +87,7 @@ int arch_elf_pt_proc(void *_ehdr, void *
 	struct elf32_phdr *phdr32 = _phdr;
 	struct elf64_phdr *phdr64 = _phdr;
 	struct mips_elf_abiflags_v0 abiflags;
+	bool relaxed;
 	bool elf32;
 	u32 flags;
 	int ret;
@@ -131,6 +138,17 @@ int arch_elf_pt_proc(void *_ehdr, void *
 	else
 		state->fp_abi = abiflags.fp_abi;
 
+	/* Record any requested IEEE Std 754 compliance mode.  */
+	relaxed = !!(abiflags.flags2 & MIPS_AFL_FLAGS2_RELAXED);
+	if (abiflags.flags1 & MIPS_AFL_FLAGS1_IEEE) {
+		if (is_interp)
+			state->interp_ieee754_relaxed = relaxed;
+		else
+			state->ieee754_relaxed = relaxed;
+	} else if (relaxed) {
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -147,6 +165,7 @@ int arch_check_elf(void *_ehdr, bool has
 	} *iehdr = _interp_ehdr;
 	struct mode_req prog_req, interp_req;
 	int fp_abi, interp_fp_abi, abi0, abi1, max_abi;
+	bool relaxed;
 	bool elf32;
 	u32 flags;
 
@@ -155,23 +174,31 @@ int arch_check_elf(void *_ehdr, bool has
 
 	/*
 	 * Determine the NaN personality, reject the binary if not allowed.
-	 * Also ensure that any interpreter matches the executable.
+	 * Check hardware support if strict conformance requested by the
+	 * binary, otherwise respect any kernel override.  Also ensure that
+	 * any interpreter matches the executable.
 	 */
+	relaxed = state->ieee754_relaxed;
+	if (relaxed && !mips_accept_ieee754_relaxed)
+		return -ENOEXEC;
 	if (flags & EF_MIPS_NAN2008) {
-		if (mips_use_nan_2008)
-			state->nan_2008 = 1;
+		if (relaxed || mips_use_nan_2008)
+			state->nan_2008 = mips_use_nan_2008;
 		else
 			return -ENOEXEC;
 	} else {
-		if (mips_use_nan_legacy)
-			state->nan_2008 = 0;
+		if (relaxed || mips_use_nan_legacy)
+			state->nan_2008 = !mips_use_nan_legacy;
 		else
 			return -ENOEXEC;
 	}
-	if (has_interpreter) {
+	if (has_interpreter && !relaxed) {
 		bool ielf32;
 		u32 iflags;
 
+		if (state->interp_ieee754_relaxed)
+			return -ELIBBAD;
+
 		ielf32 = iehdr->e32.e_ident[EI_CLASS] == ELFCLASS32;
 		iflags = ielf32 ? iehdr->e32.e_flags : iehdr->e64.e_flags;
 
@@ -312,6 +339,11 @@ void mips_set_personality_nan(struct arc
 	struct cpuinfo_mips *c = &boot_cpu_data;
 	struct task_struct *t = current;
 
+	if (state->ieee754_relaxed)
+		set_thread_flag(TIF_IEEE754_RELAXED);
+	else
+		clear_thread_flag(TIF_IEEE754_RELAXED);
+
 	t->thread.fpu.fcr31 = c->fpu_csr31;
 	switch (state->nan_2008) {
 	case 0:
Index: linux-sfr-test/arch/mips/math-emu/ieee754dp.c
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/ieee754dp.c	2015-11-11 02:21:08.165573000 +0000
+++ linux-sfr-test/arch/mips/math-emu/ieee754dp.c	2015-11-11 12:22:51.884826000 +0000
@@ -53,7 +53,8 @@ union ieee754dp __cold ieee754dp_nanxcpt
 {
 	assert(ieee754dp_issnan(r));
 
-	ieee754_setcx(IEEE754_INVALID_OPERATION);
+	if (!test_thread_flag(TIF_IEEE754_RELAXED))
+		ieee754_setcx(IEEE754_INVALID_OPERATION);
 	if (ieee754_csr.nan2008) {
 		DPMANT(r) |= DP_MBIT(DP_FBITS - 1);
 	} else {
Index: linux-sfr-test/arch/mips/math-emu/ieee754sp.c
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/ieee754sp.c	2015-11-11 02:21:08.167574000 +0000
+++ linux-sfr-test/arch/mips/math-emu/ieee754sp.c	2015-11-11 12:22:51.887824000 +0000
@@ -53,7 +53,8 @@ union ieee754sp __cold ieee754sp_nanxcpt
 {
 	assert(ieee754sp_issnan(r));
 
-	ieee754_setcx(IEEE754_INVALID_OPERATION);
+	if (!test_thread_flag(TIF_IEEE754_RELAXED))
+		ieee754_setcx(IEEE754_INVALID_OPERATION);
 	if (ieee754_csr.nan2008) {
 		SPMANT(r) |= SP_MBIT(SP_FBITS - 1);
 	} else {
