Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Oct 2017 18:55:59 +0100 (CET)
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:39320 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992181AbdJ3RzwtDsLi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Oct 2017 18:55:52 +0100
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 19A3640E92;
        Mon, 30 Oct 2017 18:55:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cI1EX0eRoyrD; Mon, 30 Oct 2017 18:55:38 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 2A11740E88;
        Mon, 30 Oct 2017 18:55:24 +0100 (CET)
Date:   Mon, 30 Oct 2017 18:55:17 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20171030175516.GA18586@localhost.localdomain>
References: <20170916133423.GB32582@localhost.localdomain>
 <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
 <20170918192428.GA391@localhost.localdomain>
 <alpine.DEB.2.00.1709182055090.16752@tp.orcam.me.uk>
 <20170920145440.GB9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
 <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej,

> > For this reason the R5900 patch modifies the __{save,restore}_dsp macros,
> > mips_dsp_state::dspcontrol, DSP_INIT, sigcontext32::sc_dsp, etc. I've seen
> > the cpu_has_dsp macro too, but haven't looked at the details of this yet.
> 
>  Given that the R5900 does not expand DSP support anyhow that sounds 
> suspicious to me.

I've taken a closer look at the R5900 changes to the DSP kernel code now:

The R5900 has four three-operand instructions: MADD, MADDU, MULT and MULTU.
In addition, it has ten instructions for pipeline 1: MULT1, MULTU1, DIV1,
DIVU1, MADD1, MADDU1, MFHI1, MFLO1, MTHI1 and MTLO1. Those are the reason
(parts of) the cpu_has_dsp infrastructure is used, as shown in the patch
below. What are your thoughts on this?

The instructions are specific to the R5900, and notably incompatible with
similar ones in the base MIPS32 architecture. They are also distinct from
the (also R5900 specific) 128-bit multimedia instructions.

By the way, "machine" is set to "Unknown" and "ASEs implemented" is empty
in /proc/cpuinfo. What would be the proper values for the R5900?

Fredrik

diff --git a/arch/mips/include/asm/dsp.h b/arch/mips/include/asm/dsp.h
index 7bfad0520e25..1bf4da622795 100644
--- a/arch/mips/include/asm/dsp.h
+++ b/arch/mips/include/asm/dsp.h
@@ -27,11 +27,13 @@ static inline void __init_dsp(void)
 {
 	mthi1(0);
 	mtlo1(0);
+#ifndef CONFIG_CPU_R5900
 	mthi2(0);
 	mtlo2(0);
 	mthi3(0);
 	mtlo3(0);
 	wrdsp(DSP_DEFAULT, DSP_MASK);
+#endif
 }
 
 static inline void init_dsp(void)
@@ -40,6 +42,13 @@ static inline void init_dsp(void)
 		__init_dsp();
 }
 
+#ifdef CONFIG_CPU_R5900
+#define __save_dsp(tsk)							\
+do {									\
+	tsk->thread.dsp.dspr[0] = mfhi1();				\
+	tsk->thread.dsp.dspr[1] = mflo1();				\
+} while (0)
+#else
 #define __save_dsp(tsk)							\
 do {									\
 	tsk->thread.dsp.dspr[0] = mfhi1();				\
@@ -50,6 +59,7 @@ do {									\
 	tsk->thread.dsp.dspr[5] = mflo3();				\
 	tsk->thread.dsp.dspcontrol = rddsp(DSP_MASK);			\
 } while (0)
+#endif
 
 #define save_dsp(tsk)							\
 do {									\
@@ -57,6 +67,13 @@ do {									\
 		__save_dsp(tsk);					\
 } while (0)
 
+#ifdef CONFIG_CPU_R5900
+#define __restore_dsp(tsk)						\
+do {									\
+	mthi1(tsk->thread.dsp.dspr[0]);					\
+	mtlo1(tsk->thread.dsp.dspr[1]);					\
+} while (0)
+#else
 #define __restore_dsp(tsk)						\
 do {									\
 	mthi1(tsk->thread.dsp.dspr[0]);					\
@@ -67,6 +84,7 @@ do {									\
 	mtlo3(tsk->thread.dsp.dspr[5]);					\
 	wrdsp(tsk->thread.dsp.dspcontrol, DSP_MASK);			\
 } while (0)
+#endif
 
 #define restore_dsp(tsk)						\
 do {									\
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 95b8c471f572..7330530f31b0 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -139,13 +139,19 @@ struct mips_fpu_struct {
 	unsigned int	msacsr;
 };
 
+#ifdef CONFIG_CPU_R5900
+#define NUM_DSP_REGS   2
+#else
 #define NUM_DSP_REGS   6
+#endif
 
 typedef __u32 dspreg_t;
 
 struct mips_dsp_state {
 	dspreg_t	dspr[NUM_DSP_REGS];
+#ifndef CONFIG_CPU_R5900
 	unsigned int	dspcontrol;
+#endif
 };
 
 #define INIT_CPUMASK { \
@@ -304,10 +310,20 @@ struct thread_struct {
 #define FPAFF_INIT
 #endif /* CONFIG_MIPS_MT_FPAFF */
 
-#define INIT_THREAD  {						\
-	/*							\
-	 * Saved main processor registers			\
-	 */							\
+#ifdef CONFIG_CPU_R5900
+#define DSP_INIT \
+	.dsp			= {				\
+		.dspr		= {0, },			\
+	},
+#else
+#define DSP_INIT \
+	.dsp			= {				\
+		.dspr		= {0, },			\
+		.dspcontrol	= 0,				\
+	},
+#endif
+
+#define REGS_INIT \
 	.reg16			= 0,				\
 	.reg17			= 0,				\
 	.reg18			= 0,				\
@@ -318,7 +334,13 @@ struct thread_struct {
 	.reg23			= 0,				\
 	.reg29			= 0,				\
 	.reg30			= 0,				\
-	.reg31			= 0,				\
+	.reg31			= 0,
+
+#define INIT_THREAD  {						\
+        /*							\
+         * Saved main processor registers			\
+         */							\
+	REGS_INIT						\
 	/*							\
 	 * Saved cp0 stuff					\
 	 */							\
@@ -342,10 +364,7 @@ struct thread_struct {
 	/*							\
 	 * Saved DSP stuff					\
 	 */							\
-	.dsp			= {				\
-		.dspr		= {0, },			\
-		.dspcontrol	= 0,				\
-	},							\
+	DSP_INIT						\
 	/*							\
 	 * saved watch register stuff				\
 	 */							\
diff --git a/arch/mips/include/asm/sigcontext.h b/arch/mips/include/asm/sigcontext.h
index eeeb0f48c767..4e975a3291f6 100644
--- a/arch/mips/include/asm/sigcontext.h
+++ b/arch/mips/include/asm/sigcontext.h
@@ -23,15 +23,19 @@ struct sigcontext32 {
 	__u32		sc_fpc_csr;
 	__u32		sc_fpc_eir;	/* Unused */
 	__u32		sc_used_math;
+#ifndef CONFIG_CPU_R5900
 	__u32		sc_dsp;		/* dsp status, was sc_ssflags */
+#endif
 	__u64		sc_mdhi;
 	__u64		sc_mdlo;
 	__u32		sc_hi1;		/* Was sc_cause */
 	__u32		sc_lo1;		/* Was sc_badvaddr */
+#ifndef CONFIG_CPU_R5900
 	__u32		sc_hi2;		/* Was sc_sigset[4] */
 	__u32		sc_lo2;
 	__u32		sc_hi3;
 	__u32		sc_lo3;
+#endif
 };
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
 #endif /* _ASM_SIGCONTEXT_H */
diff --git a/arch/mips/include/uapi/asm/sigcontext.h b/arch/mips/include/uapi/asm/sigcontext.h
index 5cbd9ae6421f..7564ba82425a 100644
--- a/arch/mips/include/uapi/asm/sigcontext.h
+++ b/arch/mips/include/uapi/asm/sigcontext.h
@@ -40,15 +40,26 @@ struct sigcontext {
 	unsigned int		sc_fpc_csr;
 	unsigned int		sc_fpc_eir;	/* Unused */
 	unsigned int		sc_used_math;
+#ifdef CONFIG_CPU_R5900
+	unsigned int		pad0;
+#else
 	unsigned int		sc_dsp;		/* dsp status, was sc_ssflags */
+#endif
 	unsigned long long	sc_mdhi;
 	unsigned long long	sc_mdlo;
 	unsigned long		sc_hi1;		/* Was sc_cause */
 	unsigned long		sc_lo1;		/* Was sc_badvaddr */
+#ifdef CONFIG_CPU_R5900
+	unsigned long		pad1;
+	unsigned long		pad2;
+	unsigned long		pad3;
+	unsigned long		pad4;
+#else
 	unsigned long		sc_hi2;		/* Was sc_sigset[4] */
 	unsigned long		sc_lo2;
 	unsigned long		sc_hi3;
 	unsigned long		sc_lo3;
+#endif
 };
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
@@ -71,16 +82,22 @@ struct sigcontext {
 	__u64	sc_fpregs[32];
 	__u64	sc_mdhi;
 	__u64	sc_hi1;
+#ifndef CONFIG_CPU_R5900
 	__u64	sc_hi2;
 	__u64	sc_hi3;
+#endif
 	__u64	sc_mdlo;
 	__u64	sc_lo1;
+#ifndef CONFIG_CPU_R5900
 	__u64	sc_lo2;
 	__u64	sc_lo3;
+#endif
 	__u64	sc_pc;
 	__u32	sc_fpc_csr;
 	__u32	sc_used_math;
+#ifndef CONFIG_CPU_R5900
 	__u32	sc_dsp;
+#endif
 	__u32	sc_reserved;
 };
 
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index a670c0c11875..041ed07e7910 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -226,10 +226,12 @@ void output_sc_defines(void)
 	OFFSET(SC_FPC_EIR, sigcontext, sc_fpc_eir);
 	OFFSET(SC_HI1, sigcontext, sc_hi1);
 	OFFSET(SC_LO1, sigcontext, sc_lo1);
+#ifndef CONFIG_CPU_R5900
 	OFFSET(SC_HI2, sigcontext, sc_hi2);
 	OFFSET(SC_LO2, sigcontext, sc_lo2);
 	OFFSET(SC_HI3, sigcontext, sc_hi3);
 	OFFSET(SC_LO3, sigcontext, sc_lo3);
+#endif
 	BLANK();
 }
 #endif
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index f702a459a830..b675c112aac3 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -416,9 +416,12 @@ int __MIPS16e_compute_return_epc(struct pt_regs *regs)
 int __compute_return_epc_for_insn(struct pt_regs *regs,
 				   union mips_instruction insn)
 {
-	unsigned int bit, fcr31, dspcontrol, reg;
+	unsigned int bit, fcr31, reg;
 	long epc = regs->cp0_epc;
 	int ret = 0;
+#ifndef CONFIG_CPU_R5900
+	unsigned int dspcontrol;
+#endif
 
 	switch (insn.i_format.opcode) {
 	/*
@@ -539,9 +542,12 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 			break;
 
 		case bposge32_op:
+#ifndef CONFIG_CPU_R5900
 			if (!cpu_has_dsp)
+#endif
 				goto sigill_dsp;
 
+#ifndef CONFIG_CPU_R5900
 			dspcontrol = rddsp(0x01);
 
 			if (dspcontrol >= 32) {
@@ -549,6 +555,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 			} else
 				epc += 8;
 			regs->cp0_epc = epc;
+#endif
 			break;
 		}
 		break;
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 6931fe722a0b..c1b854542561 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -710,7 +710,7 @@ long arch_ptrace(struct task_struct *child, long request,
 			/* implementation / version register */
 			tmp = boot_cpu_data.fpu_id;
 			break;
-		case DSP_BASE ... DSP_BASE + 5: {
+		case DSP_BASE ... DSP_BASE + NUM_DSP_REGS - 1: {
 			dspreg_t *dregs;
 
 			if (!cpu_has_dsp) {
@@ -722,6 +722,7 @@ long arch_ptrace(struct task_struct *child, long request,
 			tmp = (unsigned long) (dregs[addr - DSP_BASE]);
 			break;
 		}
+#ifndef CONFIG_CPU_R5900
 		case DSP_CONTROL:
 			if (!cpu_has_dsp) {
 				tmp = 0;
@@ -730,6 +731,7 @@ long arch_ptrace(struct task_struct *child, long request,
 			}
 			tmp = child->thread.dsp.dspcontrol;
 			break;
+#endif
 		default:
 			tmp = 0;
 			ret = -EIO;
@@ -791,7 +793,7 @@ long arch_ptrace(struct task_struct *child, long request,
 			init_fp_ctx(child);
 			ptrace_setfcr31(child, data);
 			break;
-		case DSP_BASE ... DSP_BASE + 5: {
+		case DSP_BASE ... DSP_BASE + NUM_DSP_REGS - 1: {
 			dspreg_t *dregs;
 
 			if (!cpu_has_dsp) {
@@ -803,6 +805,7 @@ long arch_ptrace(struct task_struct *child, long request,
 			dregs[addr - DSP_BASE] = data;
 			break;
 		}
+#ifndef CONFIG_CPU_R5900
 		case DSP_CONTROL:
 			if (!cpu_has_dsp) {
 				ret = -EIO;
@@ -810,6 +813,7 @@ long arch_ptrace(struct task_struct *child, long request,
 			}
 			child->thread.dsp.dspcontrol = data;
 			break;
+#endif
 		default:
 			/* The rest are not allowed. */
 			ret = -EIO;
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index 40e212d6b26b..232a28c94cce 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -132,7 +132,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			/* implementation / version register */
 			tmp = boot_cpu_data.fpu_id;
 			break;
-		case DSP_BASE ... DSP_BASE + 5: {
+		case DSP_BASE ... DSP_BASE + NUM_DSP_REGS - 1: {
 			dspreg_t *dregs;
 
 			if (!cpu_has_dsp) {
@@ -144,6 +144,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			tmp = (unsigned long) (dregs[addr - DSP_BASE]);
 			break;
 		}
+#ifndef CONFIG_CPU_R5900
 		case DSP_CONTROL:
 			if (!cpu_has_dsp) {
 				tmp = 0;
@@ -152,6 +153,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			}
 			tmp = child->thread.dsp.dspcontrol;
 			break;
+#endif
 		default:
 			tmp = 0;
 			ret = -EIO;
@@ -230,7 +232,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		case FPC_CSR:
 			child->thread.fpu.fcr31 = data;
 			break;
-		case DSP_BASE ... DSP_BASE + 5: {
+		case DSP_BASE ... DSP_BASE + NUM_DSP_REGS - 1: {
 			dspreg_t *dregs;
 
 			if (!cpu_has_dsp) {
@@ -242,6 +244,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			dregs[addr - DSP_BASE] = data;
 			break;
 		}
+#ifndef CONFIG_CPU_R5900
 		case DSP_CONTROL:
 			if (!cpu_has_dsp) {
 				ret = -EIO;
@@ -249,6 +252,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			}
 			child->thread.dsp.dspcontrol = data;
 			break;
+#endif
 		default:
 			/* The rest are not allowed. */
 			ret = -EIO;
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 9e224469c788..3ca0f424c78b 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -426,11 +426,13 @@ int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 	if (cpu_has_dsp) {
 		err |= __put_user(mfhi1(), &sc->sc_hi1);
 		err |= __put_user(mflo1(), &sc->sc_lo1);
+#ifndef CONFIG_CPU_R5900
 		err |= __put_user(mfhi2(), &sc->sc_hi2);
 		err |= __put_user(mflo2(), &sc->sc_lo2);
 		err |= __put_user(mfhi3(), &sc->sc_hi3);
 		err |= __put_user(mflo3(), &sc->sc_lo3);
 		err |= __put_user(rddsp(DSP_MASK), &sc->sc_dsp);
+#endif
 	}
 
 
@@ -503,11 +505,13 @@ int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 	if (cpu_has_dsp) {
 		err |= __get_user(treg, &sc->sc_hi1); mthi1(treg);
 		err |= __get_user(treg, &sc->sc_lo1); mtlo1(treg);
+#ifndef CONFIG_CPU_R5900
 		err |= __get_user(treg, &sc->sc_hi2); mthi2(treg);
 		err |= __get_user(treg, &sc->sc_lo2); mtlo2(treg);
 		err |= __get_user(treg, &sc->sc_hi3); mthi3(treg);
 		err |= __get_user(treg, &sc->sc_lo3); mtlo3(treg);
 		err |= __get_user(treg, &sc->sc_dsp); wrdsp(treg, DSP_MASK);
+#endif
 	}
 
 	for (i = 1; i < 32; i++)
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 9979eb78c592..5b63fcc11733 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1607,8 +1607,10 @@ asmlinkage void do_mt(struct pt_regs *regs)
 
 asmlinkage void do_dsp(struct pt_regs *regs)
 {
+#ifndef CONFIG_CPU_R5900
 	if (cpu_has_dsp)
 		panic("Unexpected DSP exception");
+#endif
 
 	force_sig(SIGILL, current);
 }
