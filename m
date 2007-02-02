Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 16:44:01 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.231]:31381 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039212AbXBBQnz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Feb 2007 16:43:55 +0000
Received: by hu-out-0506.google.com with SMTP id 22so344440hug
        for <linux-mips@linux-mips.org>; Fri, 02 Feb 2007 08:42:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=Zz3rXuqRL/Y0ptadFza9izdFy/RI6hgXIdzVgRorYgxusvYszuuAzClOZx2VKCWwEnafporBLAPvyhZLrIxuJXAsjvxzwkagbXolfaOOvbhBTApMHwQugMkEPbgmaoy3ZEO7ZY+d6Fq7qiyGNzo7qZHlsOeyRm1oIQ5h9MotAxA=
Received: by 10.49.41.18 with SMTP id t18mr6686567nfj.1170434573773;
        Fri, 02 Feb 2007 08:42:53 -0800 (PST)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id l38sm15717641nfc.2007.02.02.08.42.52;
        Fri, 02 Feb 2007 08:42:53 -0800 (PST)
Message-ID: <45C369CB.2040400@innova-card.com>
Date:	Fri, 02 Feb 2007 17:41:47 +0100
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Franck <vagabon.xyz@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [RFC] Add basic SMARTMIPS ASE support
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch adds trivial support for SMARTMIPS extension. This
extension is currently implemented by 4KS[CD] CPUs.

Basically it saves/restores ACX register, which is part of the
SMARTMIPS ASE, when needed. This patch does *not* add any support
for Smartmips MMU features.

Futhermore this patch does not add explicit support for 4KS[CD]
CPUs since they are respectively mips32 and mips32r2 compliant.
So with the current processor configuration, a platform that
has such CPUs needs to select both configs:

	CPU_HAS_SMARTMIPS
	SYS_HAS_CPU_MIPS32_R[12]

This is due to the processor configuration which is mixing up all
the architecture variants and the processor types.

The drawback of this, is that we currently pass '-march=mips32'
option to gcc when building a kernel instead of '-march=4ksc' for
4KSC case. This can lead to a kernel image a little bit bigger than
required.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

	Ralf,

 Here's the basic support for SMARTMIPS ASE. I'm not very confident
 with the sigcontext part, if you could double check that would be
 nice.

 Please consider,

		Franck

 arch/mips/Kconfig              |    3 +++
 arch/mips/Makefile             |    2 ++
 arch/mips/kernel/asm-offsets.c |    4 ++++
 arch/mips/kernel/ptrace.c      |   10 ++++++++++
 arch/mips/kernel/ptrace32.c    |   10 ++++++++++
 arch/mips/kernel/signal.c      |    7 +++++++
 arch/mips/kernel/signal32.c    |    7 +++++++
 arch/mips/kernel/traps.c       |    3 +++
 include/asm-mips/ptrace.h      |    4 ++++
 include/asm-mips/sigcontext.h  |    6 ++++--
 include/asm-mips/stackframe.h  |   30 ++++++++++++++++++++++++------
 11 files changed, 78 insertions(+), 8 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index da26de5..652ec23 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1633,6 +1633,9 @@ config CPU_HAS_LLSC
 config CPU_HAS_WB
 	bool
 
+config CPU_HAS_SMARTMIPS
+	bool
+
 #
 # Vectored interrupt mode is an R2 feature
 #
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d1b026a..d31fe0d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -103,6 +103,8 @@ predef-le += -DMIPSEL -D_MIPSEL -D__MIPSEL -D__MIPSEL__
 cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(shell $(CC) -dumpmachine |grep -q 'mips.*el-.*' && echo -EB $(undef-all) $(predef-be))
 cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= $(shell $(CC) -dumpmachine |grep -q 'mips.*el-.*' || echo -EL $(undef-all) $(predef-le))
 
+cflags-$(CONFIG_CPU_HAS_SMARTMIPS)	+= $(call cc-option,-msmartmips)
+
 cflags-$(CONFIG_SB1XXX_CORELIS)	+= $(call cc-option,-mno-sched-prolog) \
 				   -fno-omit-frame-pointer
 
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index ff88b06..c97dd46 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -64,6 +64,9 @@ void output_ptreg_defines(void)
 	offset("#define PT_R31    ", struct pt_regs, regs[31]);
 	offset("#define PT_LO     ", struct pt_regs, lo);
 	offset("#define PT_HI     ", struct pt_regs, hi);
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+	offset("#define PT_ACX    ", struct pt_regs, acx);
+#endif
 	offset("#define PT_EPC    ", struct pt_regs, cp0_epc);
 	offset("#define PT_BVADDR ", struct pt_regs, cp0_badvaddr);
 	offset("#define PT_STATUS ", struct pt_regs, cp0_status);
@@ -250,6 +253,7 @@ void output_sc_defines(void)
 	text("/* Linux sigcontext offsets. */");
 	offset("#define SC_REGS       ", struct sigcontext, sc_regs);
 	offset("#define SC_FPREGS     ", struct sigcontext, sc_fpregs);
+	offset("#define SC_ACX        ", struct sigcontext, sc_acx);
 	offset("#define SC_MDHI       ", struct sigcontext, sc_mdhi);
 	offset("#define SC_MDLO       ", struct sigcontext, sc_mdlo);
 	offset("#define SC_PC         ", struct sigcontext, sc_pc);
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 1fd705a..478355a 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -236,6 +236,11 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 		case MMLO:
 			tmp = regs->lo;
 			break;
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+		case ACX:
+			tmp = regs->acx;
+			break;
+#endif
 		case FPC_CSR:
 			tmp = child->thread.fpu.fcr31;
 			break;
@@ -362,6 +367,11 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 		case MMLO:
 			regs->lo = data;
 			break;
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+		case ACX:
+			regs->acx = data;
+			break;
+#endif
 		case FPC_CSR:
 			child->thread.fpu.fcr31 = data;
 			break;
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index d9a39c1..783f17a 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -165,6 +165,11 @@ asmlinkage int sys32_ptrace(int request, int pid, int addr, int data)
 		case MMLO:
 			tmp = regs->lo;
 			break;
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+		case ACX:
+			tmp = regs->acx;
+			break;
+#endif
 		case FPC_CSR:
 			tmp = child->thread.fpu.fcr31;
 			break;
@@ -315,6 +320,11 @@ asmlinkage int sys32_ptrace(int request, int pid, int addr, int data)
 		case MMLO:
 			regs->lo = data;
 			break;
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+		case ACX:
+			regs->acx = data;
+			break;
+#endif
 		case FPC_CSR:
 			child->thread.fpu.fcr31 = data;
 			break;
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index d3f6b0a..e6237c0 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -71,6 +71,9 @@ int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 	for (i = 1; i < 32; i++)
 		err |= __put_user(regs->regs[i], &sc->sc_regs[i]);
 
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+	err |= __put_user(regs->acx, &sc->sc_acx);
+#endif
 	err |= __put_user(regs->hi, &sc->sc_mdhi);
 	err |= __put_user(regs->lo, &sc->sc_mdlo);
 	if (cpu_has_dsp) {
@@ -114,6 +117,10 @@ int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
 
 	err |= __get_user(regs->cp0_epc, &sc->sc_pc);
+
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+	err |= __get_user(regs->acx, &sc->sc_acx);
+#endif
 	err |= __get_user(regs->hi, &sc->sc_mdhi);
 	err |= __get_user(regs->lo, &sc->sc_mdlo);
 	if (cpu_has_dsp) {
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 0994d6e..ec3af4c 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -175,6 +175,9 @@ static int setup_sigcontext32(struct pt_regs *regs,
 	for (i = 1; i < 32; i++)
 		err |= __put_user(regs->regs[i], &sc->sc_regs[i]);
 
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+	err |= __put_user(regs->acx, &sc->sc_acx);
+#endif
 	err |= __put_user(regs->hi, &sc->sc_mdhi);
 	err |= __put_user(regs->lo, &sc->sc_mdlo);
 	if (cpu_has_dsp) {
@@ -219,6 +222,10 @@ static int restore_sigcontext32(struct pt_regs *regs,
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
 
 	err |= __get_user(regs->cp0_epc, &sc->sc_pc);
+
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+	err |= __get_user(regs->acx, &sc->sc_acx);
+#endif
 	err |= __get_user(regs->hi, &sc->sc_mdhi);
 	err |= __get_user(regs->lo, &sc->sc_mdlo);
 	if (cpu_has_dsp) {
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 2a932ca..2167c55 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -229,6 +229,9 @@ void show_regs(struct pt_regs *regs)
 			printk("\n");
 	}
 
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+	printk("Acx    : %0*lx\n", field, regs->acx);
+#endif
 	printk("Hi    : %0*lx\n", field, regs->hi);
 	printk("Lo    : %0*lx\n", field, regs->lo);
 
diff --git a/include/asm-mips/ptrace.h b/include/asm-mips/ptrace.h
index 8a1f2b6..1906938 100644
--- a/include/asm-mips/ptrace.h
+++ b/include/asm-mips/ptrace.h
@@ -21,6 +21,7 @@
 #define FPC_EIR		70
 #define DSP_BASE	71		/* 3 more hi / lo register pairs */
 #define DSP_CONTROL	77
+#define ACX		78
 
 /*
  * This struct defines the way the registers are stored on the stack during a
@@ -39,6 +40,9 @@ struct pt_regs {
 	unsigned long cp0_status;
 	unsigned long hi;
 	unsigned long lo;
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+	unsigned long acx;
+#endif
 	unsigned long cp0_badvaddr;
 	unsigned long cp0_cause;
 	unsigned long cp0_epc;
diff --git a/include/asm-mips/sigcontext.h b/include/asm-mips/sigcontext.h
index cefa657..c3cf365 100644
--- a/include/asm-mips/sigcontext.h
+++ b/include/asm-mips/sigcontext.h
@@ -23,7 +23,7 @@ struct sigcontext {
 	unsigned long long	sc_pc;
 	unsigned long long	sc_regs[32];
 	unsigned long long	sc_fpregs[32];
-	unsigned int		sc_ownedfp;	/* Unused */
+	unsigned int		sc_acx;		/* Was sc_ownedfp */
 	unsigned int		sc_fpc_csr;
 	unsigned int		sc_fpc_eir;	/* Unused */
 	unsigned int		sc_used_math;
@@ -51,10 +51,12 @@ struct sigcontext {
  * binary compatibility - no prisoners.
  * DSP ASE in 2.6.12-rc4.  Turn sc_mdhi and sc_mdlo into an array of four
  * entries, add sc_dsp and sc_reserved for padding.  No prisoners.
+ * SMARTMIPS ASE in 2.6.20. Add sc_acx.
  */
 struct sigcontext {
 	unsigned long	sc_regs[32];
 	unsigned long	sc_fpregs[32];
+	unsigned long	sc_acx;
 	unsigned long	sc_mdhi;
 	unsigned long	sc_hi1;
 	unsigned long	sc_hi2;
@@ -80,7 +82,7 @@ struct sigcontext32 {
 	__u64		sc_pc;
 	__u64		sc_regs[32];
 	__u64		sc_fpregs[32];
-	__u32		sc_ownedfp;	/* Unused */
+	__u32		sc_acx;		/* Was sc_ownedfp */
 	__u32		sc_fpc_csr;
 	__u32		sc_fpc_eir;	/* Unused */
 	__u32		sc_used_math;
diff --git a/include/asm-mips/stackframe.h b/include/asm-mips/stackframe.h
index 1fae5dc..7afa1fd 100644
--- a/include/asm-mips/stackframe.h
+++ b/include/asm-mips/stackframe.h
@@ -29,16 +29,25 @@
 		.endm
 
 		.macro	SAVE_TEMP
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+		mflhxu	v1
+		LONG_S	v1, PT_LO(sp)
+		mflhxu	v1
+		LONG_S	v1, PT_HI(sp)
+		mflhxu	v1
+		LONG_S	v1, PT_ACX(sp)
+#else
 		mfhi	v1
+		LONG_S	v1, PT_HI(sp)
+		mflo	v1
+		LONG_S	v1, PT_LO(sp)
+#endif
 #ifdef CONFIG_32BIT
 		LONG_S	$8, PT_R8(sp)
 		LONG_S	$9, PT_R9(sp)
 #endif
-		LONG_S	v1, PT_HI(sp)
-		mflo	v1
 		LONG_S	$10, PT_R10(sp)
 		LONG_S	$11, PT_R11(sp)
-		LONG_S	v1,  PT_LO(sp)
 		LONG_S	$12, PT_R12(sp)
 		LONG_S	$13, PT_R13(sp)
 		LONG_S	$14, PT_R14(sp)
@@ -182,16 +191,25 @@
 		.endm
 
 		.macro	RESTORE_TEMP
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+		LONG_L	$24, PT_ACX(sp)
+		mtlhx	$24
+		LONG_L	$24, PT_HI(sp)
+		mtlhx	$24
 		LONG_L	$24, PT_LO(sp)
+		mtlhx	$24
+#else
+		LONG_L	$24, PT_LO(sp)
+		mtlo	$24
+		LONG_L	$24, PT_HI(sp)
+		mthi	$24
+#endif
 #ifdef CONFIG_32BIT
 		LONG_L	$8, PT_R8(sp)
 		LONG_L	$9, PT_R9(sp)
 #endif
-		mtlo	$24
-		LONG_L	$24, PT_HI(sp)
 		LONG_L	$10, PT_R10(sp)
 		LONG_L	$11, PT_R11(sp)
-		mthi	$24
 		LONG_L	$12, PT_R12(sp)
 		LONG_L	$13, PT_R13(sp)
 		LONG_L	$14, PT_R14(sp)
-- 
1.4.4.3.ge6d4
