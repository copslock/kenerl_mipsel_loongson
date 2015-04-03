Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:37:19 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025315AbbDCW1s5HnoU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:27:48 +0200
Date:   Fri, 3 Apr 2015 23:27:48 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 47/48] MIPS: Respect the ISA level in FCSR handling
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504032248160.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Define the central place the default FCSR value is set from, initialised 
in `cpu_probe'.  Determine the FCSR mask applied to values written to 
the register with CTC1 in the full emulation mode and via ptrace(2), 
according to the ISA level of processor hardware or the writability of 
bits 31:18 if actual FPU hardware is used.

Software may rely on FCSR bits whose functions our emulator does not 
implement, so it should not allow them to be set or software may get 
confused.  For ptrace(2) it's just sanity.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-fcsr-isa.diff
Index: linux/arch/mips/include/asm/cpu-info.h
===================================================================
--- linux.orig/arch/mips/include/asm/cpu-info.h	2015-04-02 20:18:47.496475000 +0100
+++ linux/arch/mips/include/asm/cpu-info.h	2015-04-02 20:27:59.740240000 +0100
@@ -49,6 +49,8 @@ struct cpuinfo_mips {
 	unsigned int		udelay_val;
 	unsigned int		processor_id;
 	unsigned int		fpu_id;
+	unsigned int		fpu_csr31;
+	unsigned int		fpu_msk31;
 	unsigned int		msa_id;
 	unsigned int		cputype;
 	int			isa_level;
Index: linux/arch/mips/include/asm/elf.h
===================================================================
--- linux.orig/arch/mips/include/asm/elf.h	2015-04-02 20:18:47.497482000 +0100
+++ linux/arch/mips/include/asm/elf.h	2015-04-02 20:27:59.742251000 +0100
@@ -11,6 +11,9 @@
 #include <linux/fs.h>
 #include <uapi/linux/elf.h>
 
+#include <asm/cpu-info.h>
+#include <asm/current.h>
+
 /* ELF header e_flags defines. */
 /* MIPS architecture level. */
 #define EF_MIPS_ARCH_1		0x00000000	/* -mips1 code.	 */
@@ -297,6 +300,8 @@ do {									\
 	mips_set_personality_fp(state);					\
 									\
 	current->thread.abi = &mips_abi;				\
+									\
+	current->thread.fpu.fcr31 = current_cpu_data.fpu_csr31;		\
 } while (0)
 
 #endif /* CONFIG_32BIT */
@@ -356,6 +361,8 @@ do {									\
 	else								\
 		current->thread.abi = &mips_abi;			\
 									\
+	current->thread.fpu.fcr31 = current_cpu_data.fpu_csr31;		\
+									\
 	p = personality(current->personality);				\
 	if (p != PER_LINUX32 && p != PER_LINUX)				\
 		set_personality(PER_LINUX);				\
Index: linux/arch/mips/include/asm/fpu.h
===================================================================
--- linux.orig/arch/mips/include/asm/fpu.h	2015-04-02 20:18:47.499480000 +0100
+++ linux/arch/mips/include/asm/fpu.h	2015-04-02 20:27:59.745241000 +0100
@@ -14,6 +14,7 @@
 #include <linux/thread_info.h>
 #include <linux/bitops.h>
 
+#include <asm/current.h>
 #include <asm/mipsregs.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
@@ -30,7 +31,7 @@
 struct sigcontext;
 struct sigcontext32;
 
-extern void _init_fpu(void);
+extern void _init_fpu(unsigned int);
 extern void _save_fp(struct task_struct *);
 extern void _restore_fp(struct task_struct *);
 
@@ -182,6 +183,7 @@ static inline void lose_fpu(int save)
 
 static inline int init_fpu(void)
 {
+	unsigned int fcr31 = current->thread.fpu.fcr31;
 	int ret = 0;
 
 	if (cpu_has_fpu) {
@@ -192,7 +194,7 @@ static inline int init_fpu(void)
 			return ret;
 
 		if (!cpu_has_fre) {
-			_init_fpu();
+			_init_fpu(fcr31);
 
 			return 0;
 		}
@@ -206,7 +208,7 @@ static inline int init_fpu(void)
 		config5 = clear_c0_config5(MIPS_CONF5_FRE);
 		enable_fpu_hazard();
 
-		_init_fpu();
+		_init_fpu(fcr31);
 
 		/* Restore FRE */
 		write_c0_config5(config5);
Index: linux/arch/mips/include/asm/fpu_emulator.h
===================================================================
--- linux.orig/arch/mips/include/asm/fpu_emulator.h	2015-04-02 20:27:58.453234000 +0100
+++ linux/arch/mips/include/asm/fpu_emulator.h	2015-04-02 20:27:59.747241000 +0100
@@ -87,8 +87,6 @@ static inline void fpu_emulator_init_fpu
 	struct task_struct *t = current;
 	int i;
 
-	t->thread.fpu.fcr31 = 0;
-
 	for (i = 0; i < 32; i++)
 		set_fpr64(&t->thread.fpu.fpr[i], 0, SIGNALLING_NAN);
 }
Index: linux/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux.orig/arch/mips/kernel/cpu-probe.c	2015-04-02 20:27:58.890231000 +0100
+++ linux/arch/mips/kernel/cpu-probe.c	2015-04-02 20:27:59.750245000 +0100
@@ -33,6 +33,35 @@
 #include <asm/uaccess.h>
 
 /*
+ * Determine the FCSR mask for FPU hardware.
+ */
+static inline void cpu_set_fpu_fcsr_mask(struct cpuinfo_mips *c)
+{
+	unsigned long sr, mask, fcsr, fcsr0, fcsr1;
+
+	mask = FPU_CSR_ALL_X | FPU_CSR_ALL_E | FPU_CSR_ALL_S | FPU_CSR_RM;
+
+	sr = read_c0_status();
+	__enable_fpu(FPU_AS_IS);
+
+	fcsr = read_32bit_cp1_register(CP1_STATUS);
+
+	fcsr0 = fcsr & mask;
+	write_32bit_cp1_register(CP1_STATUS, fcsr0);
+	fcsr0 = read_32bit_cp1_register(CP1_STATUS);
+
+	fcsr1 = fcsr | ~mask;
+	write_32bit_cp1_register(CP1_STATUS, fcsr1);
+	fcsr1 = read_32bit_cp1_register(CP1_STATUS);
+
+	write_32bit_cp1_register(CP1_STATUS, fcsr);
+
+	write_c0_status(sr);
+
+	c->fpu_msk31 = ~(fcsr0 ^ fcsr1) & ~mask;
+}
+
+/*
  * Set the FIR feature flags for the FPU emulator.
  */
 static void cpu_set_nofpu_id(struct cpuinfo_mips *c)
@@ -50,11 +79,15 @@ static void cpu_set_nofpu_id(struct cpui
 	c->fpu_id = value;
 }
 
+/* Determined FPU emulator mask to use for the boot CPU with "nofpu".  */
+static unsigned int mips_nofpu_msk31;
+
 static int mips_fpu_disabled;
 
 static int __init fpu_disable(char *s)
 {
 	boot_cpu_data.options &= ~MIPS_CPU_FPU;
+	boot_cpu_data.fpu_msk31 = mips_nofpu_msk31;
 	cpu_set_nofpu_id(&boot_cpu_data);
 	mips_fpu_disabled = 1;
 
@@ -595,6 +628,7 @@ static inline void cpu_probe_legacy(stru
 	case PRID_IMP_R2000:
 		c->cputype = CPU_R2000;
 		__cpu_name[cpu] = "R2000";
+		c->fpu_msk31 |= FPU_CSR_CONDX | FPU_CSR_FS;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_3K_CACHE |
 			     MIPS_CPU_NOFPUEX;
 		if (__cpu_has_fpu())
@@ -614,6 +648,7 @@ static inline void cpu_probe_legacy(stru
 			c->cputype = CPU_R3000;
 			__cpu_name[cpu] = "R3000";
 		}
+		c->fpu_msk31 |= FPU_CSR_CONDX | FPU_CSR_FS;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_3K_CACHE |
 			     MIPS_CPU_NOFPUEX;
 		if (__cpu_has_fpu())
@@ -662,6 +697,7 @@ static inline void cpu_probe_legacy(stru
 		}
 
 		set_isa(c, MIPS_CPU_ISA_III);
+		c->fpu_msk31 |= FPU_CSR_CONDX;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
 			     MIPS_CPU_WATCH | MIPS_CPU_VCE |
 			     MIPS_CPU_LLSC;
@@ -669,6 +705,7 @@ static inline void cpu_probe_legacy(stru
 		break;
 	case PRID_IMP_VR41XX:
 		set_isa(c, MIPS_CPU_ISA_III);
+		c->fpu_msk31 |= FPU_CSR_CONDX;
 		c->options = R4K_OPTS;
 		c->tlbsize = 32;
 		switch (c->processor_id & 0xf0) {
@@ -710,6 +747,7 @@ static inline void cpu_probe_legacy(stru
 		c->cputype = CPU_R4300;
 		__cpu_name[cpu] = "R4300";
 		set_isa(c, MIPS_CPU_ISA_III);
+		c->fpu_msk31 |= FPU_CSR_CONDX;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
 			     MIPS_CPU_LLSC;
 		c->tlbsize = 32;
@@ -718,6 +756,7 @@ static inline void cpu_probe_legacy(stru
 		c->cputype = CPU_R4600;
 		__cpu_name[cpu] = "R4600";
 		set_isa(c, MIPS_CPU_ISA_III);
+		c->fpu_msk31 |= FPU_CSR_CONDX;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
 			     MIPS_CPU_LLSC;
 		c->tlbsize = 48;
@@ -733,11 +772,13 @@ static inline void cpu_probe_legacy(stru
 		c->cputype = CPU_R4650;
 		__cpu_name[cpu] = "R4650";
 		set_isa(c, MIPS_CPU_ISA_III);
+		c->fpu_msk31 |= FPU_CSR_CONDX;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
 	#endif
 	case PRID_IMP_TX39:
+		c->fpu_msk31 |= FPU_CSR_CONDX | FPU_CSR_FS;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_TX39_CACHE;
 
 		if ((c->processor_id & 0xf0) == (PRID_REV_TX3927 & 0xf0)) {
@@ -763,6 +804,7 @@ static inline void cpu_probe_legacy(stru
 		c->cputype = CPU_R4700;
 		__cpu_name[cpu] = "R4700";
 		set_isa(c, MIPS_CPU_ISA_III);
+		c->fpu_msk31 |= FPU_CSR_CONDX;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
 			     MIPS_CPU_LLSC;
 		c->tlbsize = 48;
@@ -771,6 +813,7 @@ static inline void cpu_probe_legacy(stru
 		c->cputype = CPU_TX49XX;
 		__cpu_name[cpu] = "R49XX";
 		set_isa(c, MIPS_CPU_ISA_III);
+		c->fpu_msk31 |= FPU_CSR_CONDX;
 		c->options = R4K_OPTS | MIPS_CPU_LLSC;
 		if (!(c->processor_id & 0x08))
 			c->options |= MIPS_CPU_FPU | MIPS_CPU_32FPR;
@@ -812,6 +855,7 @@ static inline void cpu_probe_legacy(stru
 		c->cputype = CPU_R6000;
 		__cpu_name[cpu] = "R6000";
 		set_isa(c, MIPS_CPU_ISA_II);
+		c->fpu_msk31 |= FPU_CSR_CONDX | FPU_CSR_FS;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_FPU |
 			     MIPS_CPU_LLSC;
 		c->tlbsize = 32;
@@ -820,6 +864,7 @@ static inline void cpu_probe_legacy(stru
 		c->cputype = CPU_R6000A;
 		__cpu_name[cpu] = "R6000A";
 		set_isa(c, MIPS_CPU_ISA_II);
+		c->fpu_msk31 |= FPU_CSR_CONDX | FPU_CSR_FS;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_FPU |
 			     MIPS_CPU_LLSC;
 		c->tlbsize = 32;
@@ -886,12 +931,14 @@ static inline void cpu_probe_legacy(stru
 			__cpu_name[cpu] = "ICT Loongson-2";
 			set_elf_platform(cpu, "loongson2e");
 			set_isa(c, MIPS_CPU_ISA_III);
+			c->fpu_msk31 |= FPU_CSR_CONDX;
 			break;
 		case PRID_REV_LOONGSON2F:
 			c->cputype = CPU_LOONGSON2;
 			__cpu_name[cpu] = "ICT Loongson-2";
 			set_elf_platform(cpu, "loongson2f");
 			set_isa(c, MIPS_CPU_ISA_III);
+			c->fpu_msk31 |= FPU_CSR_CONDX;
 			break;
 		case PRID_REV_LOONGSON3A:
 			c->cputype = CPU_LOONGSON3;
@@ -1328,6 +1375,9 @@ void cpu_probe(void)
 	c->cputype	= CPU_UNKNOWN;
 	c->writecombine = _CACHE_UNCACHED;
 
+	c->fpu_csr31	= FPU_CSR_RN;
+	c->fpu_msk31	= FPU_CSR_RSVD | FPU_CSR_ABS2008 | FPU_CSR_NAN2008;
+
 	c->processor_id = read_c0_prid();
 	switch (c->processor_id & PRID_COMP_MASK) {
 	case PRID_COMP_LEGACY:
@@ -1386,6 +1436,7 @@ void cpu_probe(void)
 
 	if (c->options & MIPS_CPU_FPU) {
 		c->fpu_id = cpu_get_fpu_id();
+		mips_nofpu_msk31 = c->fpu_msk31;
 
 		if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M64R1 |
 				    MIPS_CPU_ISA_M32R2 | MIPS_CPU_ISA_M64R2 |
@@ -1395,6 +1446,8 @@ void cpu_probe(void)
 			if (c->fpu_id & MIPS_FPIR_FREP)
 				c->options |= MIPS_CPU_FRE;
 		}
+
+		cpu_set_fpu_fcsr_mask(c);
 	} else
 		cpu_set_nofpu_id(c);
 
Index: linux/arch/mips/kernel/ptrace.c
===================================================================
--- linux.orig/arch/mips/kernel/ptrace.c	2015-04-02 20:18:47.505476000 +0100
+++ linux/arch/mips/kernel/ptrace.c	2015-04-02 20:27:59.753242000 +0100
@@ -32,6 +32,7 @@
 
 #include <asm/byteorder.h>
 #include <asm/cpu.h>
+#include <asm/cpu-info.h>
 #include <asm/dsp.h>
 #include <asm/fpu.h>
 #include <asm/mipsregs.h>
@@ -137,6 +138,9 @@ int ptrace_setfpregs(struct task_struct 
 {
 	union fpureg *fregs;
 	u64 fpr_val;
+	u32 fcr31;
+	u32 value;
+	u32 mask;
 	int i;
 
 	if (!access_ok(VERIFY_READ, data, 33 * 8))
@@ -149,8 +153,10 @@ int ptrace_setfpregs(struct task_struct 
 		set_fpr64(&fregs[i], 0, fpr_val);
 	}
 
-	__get_user(child->thread.fpu.fcr31, data + 64);
-	child->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+	__get_user(value, data + 64);
+	fcr31 = child->thread.fpu.fcr31;
+	mask = current_cpu_data.fpu_msk31;
+	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
 
 	/* FIR may not be written.  */
 
Index: linux/arch/mips/kernel/r2300_switch.S
===================================================================
--- linux.orig/arch/mips/kernel/r2300_switch.S	2015-04-02 20:18:47.506481000 +0100
+++ linux/arch/mips/kernel/r2300_switch.S	2015-04-02 20:27:59.755248000 +0100
@@ -115,11 +115,9 @@ LEAF(_restore_fp)
  * the property that no matter whether considered as single or as double
  * precision represents signaling NANS.
  *
- * We initialize fcr31 to rounding to nearest, no exceptions.
+ * The value to initialize fcr31 to comes in $a0.
  */
 
-#define FPU_DEFAULT  0x00000000
-
 	.set push
 	SET_HARDFLOAT
 
@@ -129,8 +127,7 @@ LEAF(_init_fpu)
 	or	t0, t1
 	mtc0	t0, CP0_STATUS
 
-	li	t1, FPU_DEFAULT
-	ctc1	t1, fcr31
+	ctc1	a0, fcr31
 
 	li	t0, -1
 
Index: linux/arch/mips/kernel/r4k_switch.S
===================================================================
--- linux.orig/arch/mips/kernel/r4k_switch.S	2015-04-02 20:18:47.508482000 +0100
+++ linux/arch/mips/kernel/r4k_switch.S	2015-04-02 20:27:59.758240000 +0100
@@ -165,11 +165,9 @@ LEAF(_init_msa_upper)
  * the property that no matter whether considered as single or as double
  * precision represents signaling NANS.
  *
- * We initialize fcr31 to rounding to nearest, no exceptions.
+ * The value to initialize fcr31 to comes in $a0.
  */
 
-#define FPU_DEFAULT  0x00000000
-
 	.set push
 	SET_HARDFLOAT
 
@@ -180,8 +178,7 @@ LEAF(_init_fpu)
 	mtc0	t0, CP0_STATUS
 	enable_fpu_hazard
 
-	li	t1, FPU_DEFAULT
-	ctc1	t1, fcr31
+	ctc1	a0, fcr31
 
 	li	t1, -1				# SNaN
 
Index: linux/arch/mips/loongson/loongson-3/cop2-ex.c
===================================================================
--- linux.orig/arch/mips/loongson/loongson-3/cop2-ex.c	2015-04-02 20:18:47.515499000 +0100
+++ linux/arch/mips/loongson/loongson-3/cop2-ex.c	2015-04-02 20:27:59.767246000 +0100
@@ -43,7 +43,7 @@ static int loongson_cu2_call(struct noti
 		if (!fpu_owned) {
 			set_thread_flag(TIF_USEDFPU);
 			if (!used_math()) {
-				_init_fpu();
+				_init_fpu(current->thread.fpu.fcr31);
 				set_used_math();
 			} else
 				_restore_fp(current);
Index: linux/arch/mips/math-emu/cp1emu.c
===================================================================
--- linux.orig/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:59.304242000 +0100
+++ linux/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:59.771244000 +0100
@@ -908,6 +908,7 @@ static inline void cop1_ctc(struct pt_re
 {
 	u32 fcr31 = ctx->fcr31;
 	u32 value;
+	u32 mask;
 
 	if (MIPSInst_RT(ir) == 0)
 		value = 0;
@@ -919,9 +920,9 @@ static inline void cop1_ctc(struct pt_re
 		pr_debug("%p gpr[%d]->csr=%08x\n",
 			 (void *)xcp->cp0_epc, MIPSInst_RT(ir), value);
 
-		/* Don't write unsupported bits.  */
-		fcr31 = value &
-			~(FPU_CSR_RSVD | FPU_CSR_ABS2008 | FPU_CSR_NAN2008);
+		/* Preserve read-only bits.  */
+		mask = current_cpu_data.fpu_msk31;
+		fcr31 = (value & ~mask) | (fcr31 & mask);
 		break;
 
 	case FPCREG_FENR:
