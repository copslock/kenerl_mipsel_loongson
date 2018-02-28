Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 17:03:36 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53298 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992917AbeB1QD1YRhUz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 17:03:27 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yt-0006Xm-CI; Wed, 28 Feb 2018 15:22:31 +0000
Received: from ben by deadeye with local (Exim 4.90_1)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yg-0008WU-AM; Wed, 28 Feb 2018 15:22:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.280316027@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 100/254] MIPS: Respect the ISA level in FCSR handling
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@linux-mips.org>

commit 9b26616c8d9dae53fbac7f7cb2c6dd1308102976 upstream.

Define the central place the default FCSR value is set from, initialised
in `cpu_probe'.  Determine the FCSR mask applied to values written to
the register with CTC1 in the full emulation mode and via ptrace(2),
according to the ISA level of processor hardware or the writability of
bits 31:18 if actual FPU hardware is used.

Software may rely on FCSR bits whose functions our emulator does not
implement, so it should not allow them to be set or software may get
confused.  For ptrace(2) it's just sanity.

[ralf@linux-mips.org: Fixed double inclusion of <asm/current.h>.]

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9711/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.16:
 - In cop1Emulate(), keep converting the rounding mode
 - Drop change in loongson_cu2_call()
 - Add definitions of FPU_CSR_{FS,CONDX} in <asm/mipsregs.h>
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -49,6 +49,8 @@ struct cpuinfo_mips {
 	unsigned int		udelay_val;
 	unsigned int		processor_id;
 	unsigned int		fpu_id;
+	unsigned int		fpu_csr31;
+	unsigned int		fpu_msk31;
 	unsigned int		msa_id;
 	unsigned int		cputype;
 	int			isa_level;
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -9,6 +9,9 @@
 #define _ASM_ELF_H
 
 
+#include <asm/cpu-info.h>
+#include <asm/current.h>
+
 /* ELF header e_flags defines. */
 /* MIPS architecture level. */
 #define EF_MIPS_ARCH_1		0x00000000	/* -mips1 code.	 */
@@ -273,6 +276,8 @@ do {									\
 		set_personality(PER_LINUX);				\
 									\
 	current->thread.abi = &mips_abi;				\
+									\
+	current->thread.fpu.fcr31 = current_cpu_data.fpu_csr31;		\
 } while (0)
 
 #endif /* CONFIG_32BIT */
@@ -332,6 +337,8 @@ do {									\
 	else								\
 		current->thread.abi = &mips_abi;			\
 									\
+	current->thread.fpu.fcr31 = current_cpu_data.fpu_csr31;		\
+									\
 	p = personality(current->personality);				\
 	if (p != PER_LINUX32 && p != PER_LINUX)				\
 		set_personality(PER_LINUX);				\
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -30,7 +30,7 @@
 struct sigcontext;
 struct sigcontext32;
 
-extern void _init_fpu(void);
+extern void _init_fpu(unsigned int);
 extern void _save_fp(struct task_struct *);
 extern void _restore_fp(struct task_struct *);
 
@@ -163,6 +163,7 @@ static inline void lose_fpu(int save)
 
 static inline int init_fpu(void)
 {
+	unsigned int fcr31 = current->thread.fpu.fcr31;
 	int ret = 0;
 
 	preempt_disable();
@@ -170,7 +171,7 @@ static inline int init_fpu(void)
 	if (cpu_has_fpu) {
 		ret = __own_fpu();
 		if (!ret)
-			_init_fpu();
+			_init_fpu(fcr31);
 	} else
 		fpu_emulator_init_fpu();
 
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -87,8 +87,6 @@ static inline void fpu_emulator_init_fpu
 	struct task_struct *t = current;
 	int i;
 
-	t->thread.fpu.fcr31 = 0;
-
 	for (i = 0; i < 32; i++)
 		set_fpr64(&t->thread.fpu.fpr[i], 0, SIGNALLING_NAN);
 }
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -30,11 +30,44 @@
 #include <asm/spram.h>
 #include <asm/uaccess.h>
 
+/*
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
+/* Determined FPU emulator mask to use for the boot CPU with "nofpu".  */
+static unsigned int mips_nofpu_msk31;
+
 static int mips_fpu_disabled;
 
 static int __init fpu_disable(char *s)
 {
-	cpu_data[0].options &= ~MIPS_CPU_FPU;
+	boot_cpu_data.options &= ~MIPS_CPU_FPU;
+	boot_cpu_data.fpu_msk31 = mips_nofpu_msk31;
 	mips_fpu_disabled = 1;
 
 	return 1;
@@ -470,6 +503,7 @@ static inline void cpu_probe_legacy(stru
 	case PRID_IMP_R2000:
 		c->cputype = CPU_R2000;
 		__cpu_name[cpu] = "R2000";
+		c->fpu_msk31 |= FPU_CSR_CONDX | FPU_CSR_FS;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_3K_CACHE |
 			     MIPS_CPU_NOFPUEX;
 		if (__cpu_has_fpu())
@@ -489,6 +523,7 @@ static inline void cpu_probe_legacy(stru
 			c->cputype = CPU_R3000;
 			__cpu_name[cpu] = "R3000";
 		}
+		c->fpu_msk31 |= FPU_CSR_CONDX | FPU_CSR_FS;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_3K_CACHE |
 			     MIPS_CPU_NOFPUEX;
 		if (__cpu_has_fpu())
@@ -537,6 +572,7 @@ static inline void cpu_probe_legacy(stru
 		}
 
 		set_isa(c, MIPS_CPU_ISA_III);
+		c->fpu_msk31 |= FPU_CSR_CONDX;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
 			     MIPS_CPU_WATCH | MIPS_CPU_VCE |
 			     MIPS_CPU_LLSC;
@@ -544,6 +580,7 @@ static inline void cpu_probe_legacy(stru
 		break;
 	case PRID_IMP_VR41XX:
 		set_isa(c, MIPS_CPU_ISA_III);
+		c->fpu_msk31 |= FPU_CSR_CONDX;
 		c->options = R4K_OPTS;
 		c->tlbsize = 32;
 		switch (c->processor_id & 0xf0) {
@@ -585,6 +622,7 @@ static inline void cpu_probe_legacy(stru
 		c->cputype = CPU_R4300;
 		__cpu_name[cpu] = "R4300";
 		set_isa(c, MIPS_CPU_ISA_III);
+		c->fpu_msk31 |= FPU_CSR_CONDX;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
 			     MIPS_CPU_LLSC;
 		c->tlbsize = 32;
@@ -593,6 +631,7 @@ static inline void cpu_probe_legacy(stru
 		c->cputype = CPU_R4600;
 		__cpu_name[cpu] = "R4600";
 		set_isa(c, MIPS_CPU_ISA_III);
+		c->fpu_msk31 |= FPU_CSR_CONDX;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
 			     MIPS_CPU_LLSC;
 		c->tlbsize = 48;
@@ -608,11 +647,13 @@ static inline void cpu_probe_legacy(stru
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
@@ -638,6 +679,7 @@ static inline void cpu_probe_legacy(stru
 		c->cputype = CPU_R4700;
 		__cpu_name[cpu] = "R4700";
 		set_isa(c, MIPS_CPU_ISA_III);
+		c->fpu_msk31 |= FPU_CSR_CONDX;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
 			     MIPS_CPU_LLSC;
 		c->tlbsize = 48;
@@ -646,6 +688,7 @@ static inline void cpu_probe_legacy(stru
 		c->cputype = CPU_TX49XX;
 		__cpu_name[cpu] = "R49XX";
 		set_isa(c, MIPS_CPU_ISA_III);
+		c->fpu_msk31 |= FPU_CSR_CONDX;
 		c->options = R4K_OPTS | MIPS_CPU_LLSC;
 		if (!(c->processor_id & 0x08))
 			c->options |= MIPS_CPU_FPU | MIPS_CPU_32FPR;
@@ -687,6 +730,7 @@ static inline void cpu_probe_legacy(stru
 		c->cputype = CPU_R6000;
 		__cpu_name[cpu] = "R6000";
 		set_isa(c, MIPS_CPU_ISA_II);
+		c->fpu_msk31 |= FPU_CSR_CONDX | FPU_CSR_FS;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_FPU |
 			     MIPS_CPU_LLSC;
 		c->tlbsize = 32;
@@ -695,6 +739,7 @@ static inline void cpu_probe_legacy(stru
 		c->cputype = CPU_R6000A;
 		__cpu_name[cpu] = "R6000A";
 		set_isa(c, MIPS_CPU_ISA_II);
+		c->fpu_msk31 |= FPU_CSR_CONDX | FPU_CSR_FS;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_FPU |
 			     MIPS_CPU_LLSC;
 		c->tlbsize = 32;
@@ -760,11 +805,13 @@ static inline void cpu_probe_legacy(stru
 			c->cputype = CPU_LOONGSON2;
 			__cpu_name[cpu] = "ICT Loongson-2";
 			set_elf_platform(cpu, "loongson2e");
+			c->fpu_msk31 |= FPU_CSR_CONDX;
 			break;
 		case PRID_REV_LOONGSON2F:
 			c->cputype = CPU_LOONGSON2;
 			__cpu_name[cpu] = "ICT Loongson-2";
 			set_elf_platform(cpu, "loongson2f");
+			c->fpu_msk31 |= FPU_CSR_CONDX;
 			break;
 		case PRID_REV_LOONGSON3A:
 			c->cputype = CPU_LOONGSON3;
@@ -1168,6 +1215,9 @@ void cpu_probe(void)
 	c->fpu_id	= FPIR_IMP_NONE;
 	c->cputype	= CPU_UNKNOWN;
 
+	c->fpu_csr31	= FPU_CSR_RN;
+	c->fpu_msk31	= FPU_CSR_RSVD | FPU_CSR_ABS2008 | FPU_CSR_NAN2008;
+
 	c->processor_id = read_c0_prid();
 	switch (c->processor_id & PRID_COMP_MASK) {
 	case PRID_COMP_LEGACY:
@@ -1220,12 +1270,15 @@ void cpu_probe(void)
 
 	if (c->options & MIPS_CPU_FPU) {
 		c->fpu_id = cpu_get_fpu_id();
+		mips_nofpu_msk31 = c->fpu_msk31;
 
 		if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M32R2 |
 				    MIPS_CPU_ISA_M64R1 | MIPS_CPU_ISA_M64R2)) {
 			if (c->fpu_id & MIPS_FPIR_3D)
 				c->ases |= MIPS_ASE_MIPS3D;
 		}
+
+		cpu_set_fpu_fcsr_mask(c);
 	}
 
 	if (cpu_has_mips_r2) {
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -33,6 +33,7 @@
 
 #include <asm/byteorder.h>
 #include <asm/cpu.h>
+#include <asm/cpu-info.h>
 #include <asm/dsp.h>
 #include <asm/fpu.h>
 #include <asm/mipsregs.h>
@@ -158,6 +159,9 @@ int ptrace_setfpregs(struct task_struct
 {
 	union fpureg *fregs;
 	u64 fpr_val;
+	u32 fcr31;
+	u32 value;
+	u32 mask;
 	int i;
 
 	if (!access_ok(VERIFY_READ, data, 33 * 8))
@@ -171,8 +175,10 @@ int ptrace_setfpregs(struct task_struct
 		set_fpr64(&fregs[i], 0, fpr_val);
 	}
 
-	__get_user(child->thread.fpu.fcr31, data + 64);
-	child->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+	__get_user(value, data + 64);
+	fcr31 = child->thread.fpu.fcr31;
+	mask = current_cpu_data.fpu_msk31;
+	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
 
 	/* FIR may not be written.  */
 
--- a/arch/mips/kernel/r2300_switch.S
+++ b/arch/mips/kernel/r2300_switch.S
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
 
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -163,11 +163,9 @@ LEAF(_init_msa_upper)
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
 
@@ -178,8 +176,7 @@ LEAF(_init_fpu)
 	mtc0	t0, CP0_STATUS
 	enable_fpu_hazard
 
-	li	t1, FPU_DEFAULT
-	ctc1	t1, fcr31
+	ctc1	a0, fcr31
 
 	li	t1, -1				# SNaN
 
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -924,17 +924,19 @@ emul:
 			/* we only have one writable control reg
 			 */
 			if (MIPSInst_RD(ir) == FPCREG_CSR) {
+				u32 mask;
+
 				pr_debug("%p gpr[%d]->csr=%08x\n",
 					 (void *) (xcp->cp0_epc),
 					 MIPSInst_RT(ir), value);
 
 				/*
-				 * Don't write unsupported bits,
+				 * Preserve read-only bits,
 				 * and convert to ieee library modes
 				 */
-				ctx->fcr31 = (value &
-					      ~(FPU_CSR_RSVD | FPU_CSR_ABS2008 |
-						FPU_CSR_NAN2008 | FPU_CSR_RM)) |
+				mask = current_cpu_data.fpu_msk31;
+				ctx->fcr31 = (value & ~(mask | FPU_CSR_RM)) |
+					     (ctx->fcr31 & mask) |
 					     modeindex(value);
 			}
 			if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -123,6 +123,11 @@
 /*
  * Status Register Values
  */
+#define FPU_CSR_FS_S	24		/* flush denormalised results to 0 */
+#define FPU_CSR_FS	(_ULCAST_(1) << FPU_CSR_FS_S)
+
+#define FPU_CSR_CONDX_S	25					/* $fcc[7:1] */
+#define FPU_CSR_CONDX	(_ULCAST_(127) << FPU_CSR_CONDX_S)
 
 #define FPU_CSR_FLUSH	0x01000000	/* flush denormalised results to 0 */
 #define FPU_CSR_COND	0x00800000	/* $fcc0 */
