Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2015 17:13:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22509 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012408AbbBBQN2Dn4XF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Feb 2015 17:13:28 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 11B8924508F35
        for <linux-mips@linux-mips.org>; Mon,  2 Feb 2015 16:13:18 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 2 Feb 2015 16:13:20 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 2 Feb 2015 16:13:19 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v3] MIPS: kernel: elf: Improve the overall ABI and FPU mode checks
Date:   Mon, 2 Feb 2015 16:13:13 +0000
Message-ID: <1422893593-1291-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320FBCA7C@LEMAIL01.le.imgtec.org>
References: <6D39441BF12EF246A7ABCE6654B0235320FBCA7C@LEMAIL01.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45610
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

The previous implementation did not cover all possible FPU combinations
and it silently allowed ABI incompatible objects to be loaded with the
wrong ABI. For example, the previous logic would set the FP_64 ABI as
the matching ABI for an FP_XX object combined with an FP_64A object.
This was wrong, and the matching ABI should have been FP_64A.
The previous logic is now replaced with a new one which determines
the appropriate FPU mode to be used rather than the FP ABI. This has
the advantage that the entire logic is much simpler since it is the FPU
mode we are interested in rather than the FP ABI resulting to code
simplifications.

Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/elf.h |  10 +-
 arch/mips/kernel/elf.c      | 303 +++++++++++++++++++++++++++-----------------
 2 files changed, 194 insertions(+), 119 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index eb4d95de619c..535f196ffe02 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -417,13 +417,15 @@ extern unsigned long arch_randomize_brk(struct mm_struct *mm);
 struct arch_elf_state {
 	int fp_abi;
 	int interp_fp_abi;
-	int overall_abi;
+	int overall_fp_mode;
 };
 
+#define MIPS_ABI_FP_UNKNOWN	(-1)	/* Unknown FP ABI (kernel internal) */
+
 #define INIT_ARCH_ELF_STATE {			\
-	.fp_abi = -1,				\
-	.interp_fp_abi = -1,			\
-	.overall_abi = -1,			\
+	.fp_abi = MIPS_ABI_FP_UNKNOWN,		\
+	.interp_fp_abi = MIPS_ABI_FP_UNKNOWN,	\
+	.overall_fp_mode = -1,			\
 }
 
 extern int arch_elf_pt_proc(void *ehdr, void *phdr, struct file *elf,
diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index c92b15df6893..d2c09f6475c5 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -11,29 +11,112 @@
 #include <linux/elf.h>
 #include <linux/sched.h>
 
+/* FPU modes */
 enum {
-	FP_ERROR = -1,
-	FP_DOUBLE_64A = -2,
+	FP_FRE,
+	FP_FR0,
+	FP_FR1,
 };
 
+/**
+ * struct mode_req - ABI FPU mode requirements
+ * @single:	The program being loaded needs an FPU but it will only issue
+ *		single precision instructions meaning that it can execute in
+ *		either FR0 or FR1.
+ * @soft:	The soft(-float) requirement means that the program being
+ *		loaded needs has no FPU dependency at all (i.e. it has no
+ *		FPU instructions).
+ * @fr1:	The program being loaded depends on FPU being in FR=1 mode.
+ * @frdefault:	The program being loaded depends on the default FPU mode.
+ *		That is FR0 for O32 and FR1 for N32/N64.
+ * @fre:	The program being loaded depends on FPU with FRE=1. This mode is
+ *		a bridge which uses FR=1 whilst still being able to maintain
+ *		full compatibility with pre-existing code using the O32 FP32
+ *		ABI.
+ *
+ * More information about the FP ABIs can be found here:
+ *
+ * https://dmz-portal.mips.com/wiki/MIPS_O32_ABI_-_FR0_and_FR1_Interlinking#10.4.1._Basic_mode_set-up
+ *
+ */
+
+struct mode_req {
+	bool single;
+	bool soft;
+	bool fr1;
+	bool frdefault;
+	bool fre;
+};
+
+static const struct mode_req fpu_reqs[] = {
+	[MIPS_ABI_FP_ANY]    = { true,  true,  true,  true,  true  },
+	[MIPS_ABI_FP_DOUBLE] = { false, false, false, true,  true  },
+	[MIPS_ABI_FP_SINGLE] = { true,  false, false, false, false },
+	[MIPS_ABI_FP_SOFT]   = { false, true,  false, false, false },
+	[MIPS_ABI_FP_OLD_64] = { false, false, false, false, false },
+	[MIPS_ABI_FP_XX]     = { false, false, true,  true,  true  },
+	[MIPS_ABI_FP_64]     = { false, false, true,  false, false },
+	[MIPS_ABI_FP_64A]    = { false, false, true,  false, true  }
+};
+
+/*
+ * Mode requirements when .MIPS.abiflags is not present in the ELF.
+ * Not present means that everything is acceptable except FR1.
+ */
+static struct mode_req none_req = { true, true, false, true, true };
+
 int arch_elf_pt_proc(void *_ehdr, void *_phdr, struct file *elf,
 		     bool is_interp, struct arch_elf_state *state)
 {
-	struct elfhdr *ehdr = _ehdr;
-	struct elf_phdr *phdr = _phdr;
+	struct elf32_hdr *ehdr32 = _ehdr;
+	struct elf32_phdr *phdr32 = _phdr;
+	struct elf64_phdr *phdr64 = _phdr;
 	struct mips_elf_abiflags_v0 abiflags;
 	int ret;
 
-	if (config_enabled(CONFIG_64BIT) &&
-	    (ehdr->e_ident[EI_CLASS] != ELFCLASS32))
-		return 0;
-	if (phdr->p_type != PT_MIPS_ABIFLAGS)
-		return 0;
-	if (phdr->p_filesz < sizeof(abiflags))
-		return -EINVAL;
+	/* Lets see if this is an O32 ELF */
+	if (ehdr32->e_ident[EI_CLASS] == ELFCLASS32) {
+		/* FR = 1 for N32 */
+		if (ehdr32->e_flags & EF_MIPS_ABI2)
+			state->overall_fp_mode = FP_FR1;
+		else
+			/* Set a good default FPU mode for O32 */
+			state->overall_fp_mode = cpu_has_mips_r6 ?
+				FP_FRE : FP_FR0;
+
+		if (ehdr32->e_flags & EF_MIPS_FP64) {
+			/*
+			 * Set MIPS_ABI_FP_OLD_64 for EF_MIPS_FP64. We will override it
+			 * later if needed
+			 */
+			if (is_interp)
+				state->interp_fp_abi = MIPS_ABI_FP_OLD_64;
+			else
+				state->fp_abi = MIPS_ABI_FP_OLD_64;
+		}
+		if (phdr32->p_type != PT_MIPS_ABIFLAGS)
+			return 0;
+
+		if (phdr32->p_filesz < sizeof(abiflags))
+			return -EINVAL;
+
+		ret = kernel_read(elf, phdr32->p_offset,
+				  (char *)&abiflags,
+				  sizeof(abiflags));
+	} else {
+		/* FR=1 is really the only option for 64-bit */
+		state->overall_fp_mode = FP_FR1;
+
+		if (phdr64->p_type != PT_MIPS_ABIFLAGS)
+			return 0;
+		if (phdr64->p_filesz < sizeof(abiflags))
+			return -EINVAL;
+
+		ret = kernel_read(elf, phdr64->p_offset,
+				  (char *)&abiflags,
+				  sizeof(abiflags));
+	}
 
-	ret = kernel_read(elf, phdr->p_offset, (char *)&abiflags,
-			  sizeof(abiflags));
 	if (ret < 0)
 		return ret;
 	if (ret != sizeof(abiflags))
@@ -48,35 +131,30 @@ int arch_elf_pt_proc(void *_ehdr, void *_phdr, struct file *elf,
 	return 0;
 }
 
-static inline unsigned get_fp_abi(struct elfhdr *ehdr, int in_abi)
+static inline unsigned get_fp_abi(int in_abi)
 {
 	/* If the ABI requirement is provided, simply return that */
-	if (in_abi != -1)
+	if (in_abi != MIPS_ABI_FP_UNKNOWN)
 		return in_abi;
 
-	/* If the EF_MIPS_FP64 flag was set, return MIPS_ABI_FP_64 */
-	if (ehdr->e_flags & EF_MIPS_FP64)
-		return MIPS_ABI_FP_64;
-
-	/* Default to MIPS_ABI_FP_DOUBLE */
-	return MIPS_ABI_FP_DOUBLE;
+	/* Unknown ABI */
+	return MIPS_ABI_FP_UNKNOWN;
 }
 
 int arch_check_elf(void *_ehdr, bool has_interpreter,
 		   struct arch_elf_state *state)
 {
-	struct elfhdr *ehdr = _ehdr;
-	unsigned fp_abi, interp_fp_abi, abi0, abi1;
+	struct elf32_hdr *ehdr = _ehdr;
+	struct mode_req prog_req, interp_req;
+	int fp_abi, interp_fp_abi, abi0, abi1, max_abi;
 
-	/* Ignore non-O32 binaries */
-	if (config_enabled(CONFIG_64BIT) &&
-	    (ehdr->e_ident[EI_CLASS] != ELFCLASS32))
+	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
 		return 0;
 
-	fp_abi = get_fp_abi(ehdr, state->fp_abi);
+	fp_abi = get_fp_abi(state->fp_abi);
 
 	if (has_interpreter) {
-		interp_fp_abi = get_fp_abi(ehdr, state->interp_fp_abi);
+		interp_fp_abi = get_fp_abi(state->interp_fp_abi);
 
 		abi0 = min(fp_abi, interp_fp_abi);
 		abi1 = max(fp_abi, interp_fp_abi);
@@ -84,108 +162,103 @@ int arch_check_elf(void *_ehdr, bool has_interpreter,
 		abi0 = abi1 = fp_abi;
 	}
 
-	state->overall_abi = FP_ERROR;
-
-	if (abi0 == abi1) {
-		state->overall_abi = abi0;
-	} else if (abi0 == MIPS_ABI_FP_ANY) {
-		state->overall_abi = abi1;
-	} else if (abi0 == MIPS_ABI_FP_DOUBLE) {
-		switch (abi1) {
-		case MIPS_ABI_FP_XX:
-			state->overall_abi = MIPS_ABI_FP_DOUBLE;
-			break;
-
-		case MIPS_ABI_FP_64A:
-			state->overall_abi = FP_DOUBLE_64A;
-			break;
-		}
-	} else if (abi0 == MIPS_ABI_FP_SINGLE ||
-		   abi0 == MIPS_ABI_FP_SOFT) {
-		/* Cannot link with other ABIs */
-	} else if (abi0 == MIPS_ABI_FP_OLD_64) {
-		switch (abi1) {
-		case MIPS_ABI_FP_XX:
-		case MIPS_ABI_FP_64:
-		case MIPS_ABI_FP_64A:
-			state->overall_abi = MIPS_ABI_FP_64;
-			break;
-		}
-	} else if (abi0 == MIPS_ABI_FP_XX ||
-		   abi0 == MIPS_ABI_FP_64 ||
-		   abi0 == MIPS_ABI_FP_64A) {
-		state->overall_abi = MIPS_ABI_FP_64;
-	}
+	/* ABI limits. O32 = FP_64A, N32/N64 = FP_SOFT */
+	max_abi = ((ehdr->e_ident[EI_CLASS] == ELFCLASS32) &&
+		   (!(ehdr->e_flags & EF_MIPS_ABI2))) ?
+		MIPS_ABI_FP_64A : MIPS_ABI_FP_SOFT;
 
-	switch (state->overall_abi) {
-	case MIPS_ABI_FP_64:
-	case MIPS_ABI_FP_64A:
-	case FP_DOUBLE_64A:
-		if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
-			return -ELIBBAD;
-		break;
+	if ((abi0 > max_abi && abi0 != MIPS_ABI_FP_UNKNOWN) ||
+	    (abi1 > max_abi && abi1 != MIPS_ABI_FP_UNKNOWN))
+		return -ELIBBAD;
+
+	/* It's time to determine the FPU mode requirements */
+	prog_req = (abi0 == MIPS_ABI_FP_UNKNOWN) ? none_req : fpu_reqs[abi0];
+	interp_req = (abi1 == MIPS_ABI_FP_UNKNOWN) ? none_req : fpu_reqs[abi1];
 
-	case FP_ERROR:
+	/*
+	 * Check whether the program's and interp's ABIs have a matching FPU
+	 * mode requirement.
+	 */
+	prog_req.single = interp_req.single && prog_req.single;
+	prog_req.soft = interp_req.soft && prog_req.soft;
+	prog_req.fr1 = interp_req.fr1 && prog_req.fr1;
+	prog_req.frdefault = interp_req.frdefault && prog_req.frdefault;
+	prog_req.fre = interp_req.fre && prog_req.fre;
+
+	/*
+	 * Determine the desired FPU mode
+	 *
+	 * Decision making:
+	 *
+	 * - We want FR_FRE if FRE=1 and both FR=1 and FR=0 are false. This
+	 *   means that we have a combination of program and interpreter
+	 *   that inherently require the hybrid FP mode.
+	 * - If FR1 and FRDEFAULT is true, that means we hit the any-abi or
+	 *   fpxx case. This is because, in any-ABI (or no-ABI) we have no FPU
+	 *   instructions so we don't care about the mode. We will simply use
+	 *   the one preferred by the hardware. In fpxx case, that ABI can
+	 *   handle both FR=1 and FR=0, so, again, we simply choose the one
+	 *   preferred by the hardware. Next, if we only use single-precision
+	 *   FPU instructions, and the default ABI FPU mode is not good
+	 *   (ie single + any ABI combination), we set again the FPU mode to the
+	 *   one is preferred by the hardware. Next, if we know that the code
+	 *   will only use single-precision instructions, shown by single being
+	 *   true but frdefault being false, then we again set the FPU mode to
+	 *   the one that is preferred by the hardware.
+	 * - We want FP_FR1 if that's the only matching mode and the default one
+	 *   is not good.
+	 * - Return with -ELIBADD if we can't find a matching FPU mode.
+	 */
+	if (prog_req.fre && !prog_req.frdefault && !prog_req.fr1)
+		state->overall_fp_mode = FP_FRE;
+	else if ((prog_req.fr1 && prog_req.frdefault) ||
+		 (prog_req.single && !prog_req.frdefault))
+		/* Make sure 64-bit MIPS III/IV/64R1 will not pick FR1 */
+		state->overall_fp_mode = ((current_cpu_data.fpu_id & MIPS_FPIR_F64) &&
+					  cpu_has_mips_r2_r6) ?
+					  FP_FR1 : FP_FR0;
+	else if (prog_req.fr1)
+		state->overall_fp_mode = FP_FR1;
+	else  if (!prog_req.fre && !prog_req.frdefault &&
+		  !prog_req.fr1 && !prog_req.single && !prog_req.soft)
 		return -ELIBBAD;
-	}
 
 	return 0;
 }
 
-void mips_set_personality_fp(struct arch_elf_state *state)
+static inline void set_thread_fp_mode(int hybrid, int regs32)
 {
-	if (config_enabled(CONFIG_FP32XX_HYBRID_FPRS)) {
-		/*
-		 * Use hybrid FPRs for all code which can correctly execute
-		 * with that mode.
-		 */
-		switch (state->overall_abi) {
-		case MIPS_ABI_FP_DOUBLE:
-		case MIPS_ABI_FP_SINGLE:
-		case MIPS_ABI_FP_SOFT:
-		case MIPS_ABI_FP_XX:
-		case MIPS_ABI_FP_ANY:
-			/* FR=1, FRE=1 */
-			clear_thread_flag(TIF_32BIT_FPREGS);
-			set_thread_flag(TIF_HYBRID_FPREGS);
-			return;
-		}
-	}
-
-	switch (state->overall_abi) {
-	case MIPS_ABI_FP_DOUBLE:
-	case MIPS_ABI_FP_SINGLE:
-	case MIPS_ABI_FP_SOFT:
-		/* FR=0 */
-		set_thread_flag(TIF_32BIT_FPREGS);
+	if (hybrid)
+		set_thread_flag(TIF_HYBRID_FPREGS);
+	else
 		clear_thread_flag(TIF_HYBRID_FPREGS);
-		break;
-
-	case FP_DOUBLE_64A:
-		/* FR=1, FRE=1 */
+	if (regs32)
+		set_thread_flag(TIF_32BIT_FPREGS);
+	else
 		clear_thread_flag(TIF_32BIT_FPREGS);
-		set_thread_flag(TIF_HYBRID_FPREGS);
-		break;
+}
 
-	case MIPS_ABI_FP_64:
-	case MIPS_ABI_FP_64A:
-		/* FR=1, FRE=0 */
-		clear_thread_flag(TIF_32BIT_FPREGS);
-		clear_thread_flag(TIF_HYBRID_FPREGS);
-		break;
+void mips_set_personality_fp(struct arch_elf_state *state)
+{
+	/*
+	 * This function is only ever called for O32 ELFs so we should
+	 * not be worried about N32/N64 binaries.
+	 */
 
-	case MIPS_ABI_FP_XX:
-	case MIPS_ABI_FP_ANY:
-		if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
-			set_thread_flag(TIF_32BIT_FPREGS);
-		else
-			clear_thread_flag(TIF_32BIT_FPREGS);
+	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
+		return;
 
-		clear_thread_flag(TIF_HYBRID_FPREGS);
+	switch (state->overall_fp_mode) {
+	case FP_FRE:
+		set_thread_fp_mode(1, 0);
+		break;
+	case FP_FR0:
+		set_thread_fp_mode(0, 1);
+		break;
+	case FP_FR1:
+		set_thread_fp_mode(0, 0);
 		break;
-
 	default:
-	case FP_ERROR:
 		BUG();
 	}
 }
-- 
2.2.2
