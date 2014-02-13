Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Feb 2014 12:27:04 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:10839 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817179AbaBML075moNn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Feb 2014 12:26:59 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v3 01/15] mips: simplify FP context access
Date:   Thu, 13 Feb 2014 11:26:41 +0000
Message-ID: <1392290801-17938-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1390836194-26286-2-git-send-email-paul.burton@imgtec.com>
References: <1390836194-26286-2-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_02_13_11_26_55
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This patch replaces the fpureg_t typedef with a "union fpureg" enabling
easier access to 32 & 64 bit values. This allows the access macros used
in cp1emu.c to be simplified somewhat. It will also make it easier to
expand the width of the FP registers as will be done in a future
patch in order to support the 128 bit registers introduced with MSA.

No behavioural change is intended by this patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
Changes in v3:
  - Fix the l_fmt case for __mips64 builds in fpu_emu.

Changes in v2:
  - Remove extraneous braces in SIFROMREG, SITOREG macros.
---
 arch/mips/include/asm/fpu.h         |  2 +-
 arch/mips/include/asm/processor.h   | 31 ++++++++++++++++++++++++++---
 arch/mips/kernel/ptrace.c           | 39 ++++++++++++++++---------------------
 arch/mips/kernel/ptrace32.c         | 25 ++++++++----------------
 arch/mips/math-emu/cp1emu.c         | 37 ++++++++++++++++++++++-------------
 arch/mips/math-emu/kernel_linkage.c | 21 +++++++++++---------
 6 files changed, 90 insertions(+), 65 deletions(-)

diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index cfe092f..8d57b71 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -178,7 +178,7 @@ static inline void restore_fp(struct task_struct *tsk)
 		_restore_fp(tsk);
 }
 
-static inline fpureg_t *get_fpu_regs(struct task_struct *tsk)
+static inline union fpureg *get_fpu_regs(struct task_struct *tsk)
 {
 	if (tsk == current) {
 		preempt_disable();
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 3605b84..49a61be 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -96,8 +96,33 @@ extern unsigned int vced_count, vcei_count;
 
 
 #define NUM_FPU_REGS	32
+#define FPU_REG_WIDTH	64
 
-typedef __u64 fpureg_t;
+union fpureg {
+	__u32	val32[FPU_REG_WIDTH / 32];
+	__u64	val64[FPU_REG_WIDTH / 64];
+};
+
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+# define FPR_IDX(width, idx)	(idx)
+#else
+# define FPR_IDX(width, idx)	((FPU_REG_WIDTH / (width)) - 1 - (idx))
+#endif
+
+#define BUILD_FPR_ACCESS(width) \
+static inline u##width get_fpr##width(union fpureg *fpr, unsigned idx)	\
+{									\
+	return fpr->val##width[FPR_IDX(width, idx)];			\
+}									\
+									\
+static inline void set_fpr##width(union fpureg *fpr, unsigned idx,	\
+				  u##width val)				\
+{									\
+	fpr->val##width[FPR_IDX(width, idx)] = val;			\
+}
+
+BUILD_FPR_ACCESS(32)
+BUILD_FPR_ACCESS(64)
 
 /*
  * It would be nice to add some more fields for emulator statistics, but there
@@ -107,7 +132,7 @@ typedef __u64 fpureg_t;
  */
 
 struct mips_fpu_struct {
-	fpureg_t	fpr[NUM_FPU_REGS];
+	union fpureg	fpr[NUM_FPU_REGS];
 	unsigned int	fcr31;
 };
 
@@ -284,7 +309,7 @@ struct thread_struct {
 	 * Saved FPU/FPU emulator stuff				\
 	 */							\
 	.fpu			= {				\
-		.fpr		= {0,},				\
+		.fpr		= {{{0,},},},			\
 		.fcr31		= 0,				\
 	},							\
 	/*							\
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 7da9b76..624773e 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -120,9 +120,10 @@ int ptrace_getfpregs(struct task_struct *child, __u32 __user *data)
 		return -EIO;
 
 	if (tsk_used_math(child)) {
-		fpureg_t *fregs = get_fpu_regs(child);
+		union fpureg *fregs = get_fpu_regs(child);
 		for (i = 0; i < 32; i++)
-			__put_user(fregs[i], i + (__u64 __user *) data);
+			__put_user(get_fpr64(&fregs[i], 0),
+				   i + (__u64 __user *)data);
 	} else {
 		for (i = 0; i < 32; i++)
 			__put_user((__u64) -1, i + (__u64 __user *) data);
@@ -158,7 +159,8 @@ int ptrace_getfpregs(struct task_struct *child, __u32 __user *data)
 
 int ptrace_setfpregs(struct task_struct *child, __u32 __user *data)
 {
-	fpureg_t *fregs;
+	union fpureg *fregs;
+	u64 fpr_val;
 	int i;
 
 	if (!access_ok(VERIFY_READ, data, 33 * 8))
@@ -166,8 +168,10 @@ int ptrace_setfpregs(struct task_struct *child, __u32 __user *data)
 
 	fregs = get_fpu_regs(child);
 
-	for (i = 0; i < 32; i++)
-		__get_user(fregs[i], i + (__u64 __user *) data);
+	for (i = 0; i < 32; i++) {
+		__get_user(fpr_val, i + (__u64 __user *)data);
+		set_fpr64(&fregs[i], 0, fpr_val);
+	}
 
 	__get_user(child->thread.fpu.fcr31, data + 64);
 
@@ -408,7 +412,7 @@ long arch_ptrace(struct task_struct *child, long request,
 	/* Read the word at location addr in the USER area. */
 	case PTRACE_PEEKUSR: {
 		struct pt_regs *regs;
-		fpureg_t *fregs;
+		union fpureg *fregs;
 		unsigned long tmp = 0;
 
 		regs = task_pt_regs(child);
@@ -433,14 +437,12 @@ long arch_ptrace(struct task_struct *child, long request,
 				 * order bits of the values stored in the even
 				 * registers - unless we're using r2k_switch.S.
 				 */
-				if (addr & 1)
-					tmp = fregs[(addr & ~1) - 32] >> 32;
-				else
-					tmp = fregs[addr - 32];
+				tmp = get_fpr32(&fregs[(addr & ~1) - FPR_BASE],
+						addr & 1);
 				break;
 			}
 #endif
-			tmp = fregs[addr - FPR_BASE];
+			tmp = get_fpr32(&fregs[addr - FPR_BASE], 0);
 			break;
 		case PC:
 			tmp = regs->cp0_epc;
@@ -548,7 +550,7 @@ long arch_ptrace(struct task_struct *child, long request,
 			regs->regs[addr] = data;
 			break;
 		case FPR_BASE ... FPR_BASE + 31: {
-			fpureg_t *fregs = get_fpu_regs(child);
+			union fpureg *fregs = get_fpu_regs(child);
 
 			if (!tsk_used_math(child)) {
 				/* FP not yet used  */
@@ -563,19 +565,12 @@ long arch_ptrace(struct task_struct *child, long request,
 				 * order bits of the values stored in the even
 				 * registers - unless we're using r2k_switch.S.
 				 */
-				if (addr & 1) {
-					fregs[(addr & ~1) - FPR_BASE] &=
-						0xffffffff;
-					fregs[(addr & ~1) - FPR_BASE] |=
-						((u64)data) << 32;
-				} else {
-					fregs[addr - FPR_BASE] &= ~0xffffffffLL;
-					fregs[addr - FPR_BASE] |= data;
-				}
+				set_fpr32(&fregs[(addr & ~1) - FPR_BASE],
+					  addr & 1, data);
 				break;
 			}
 #endif
-			fregs[addr - FPR_BASE] = data;
+			set_fpr64(&fregs[addr - FPR_BASE], 0, data);
 			break;
 		}
 		case PC:
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index b8aa2dd..c394d8f 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -80,7 +80,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 	/* Read the word at location addr in the USER area. */
 	case PTRACE_PEEKUSR: {
 		struct pt_regs *regs;
-		fpureg_t *fregs;
+		union fpureg *fregs;
 		unsigned int tmp;
 
 		regs = task_pt_regs(child);
@@ -103,13 +103,11 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 				 * order bits of the values stored in the even
 				 * registers - unless we're using r2k_switch.S.
 				 */
-				if (addr & 1)
-					tmp = fregs[(addr & ~1) - 32] >> 32;
-				else
-					tmp = fregs[addr - 32];
+				tmp = get_fpr32(&fregs[(addr & ~1) - FPR_BASE],
+						addr & 1);
 				break;
 			}
-			tmp = fregs[addr - FPR_BASE];
+			tmp = get_fpr32(&fregs[addr - FPR_BASE], 0);
 			break;
 		case PC:
 			tmp = regs->cp0_epc;
@@ -233,7 +231,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			regs->regs[addr] = data;
 			break;
 		case FPR_BASE ... FPR_BASE + 31: {
-			fpureg_t *fregs = get_fpu_regs(child);
+			union fpureg *fregs = get_fpu_regs(child);
 
 			if (!tsk_used_math(child)) {
 				/* FP not yet used  */
@@ -247,18 +245,11 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 				 * order bits of the values stored in the even
 				 * registers - unless we're using r2k_switch.S.
 				 */
-				if (addr & 1) {
-					fregs[(addr & ~1) - FPR_BASE] &=
-						0xffffffff;
-					fregs[(addr & ~1) - FPR_BASE] |=
-						((u64)data) << 32;
-				} else {
-					fregs[addr - FPR_BASE] &= ~0xffffffffLL;
-					fregs[addr - FPR_BASE] |= data;
-				}
+				set_fpr32(&fregs[(addr & ~1) - FPR_BASE],
+					  addr & 1, data);
 				break;
 			}
-			fregs[addr - FPR_BASE] = data;
+			set_fpr64(&fregs[addr - FPR_BASE], 0, data);
 			break;
 		}
 		case PC:
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 506925b..196cf1a 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -876,20 +876,28 @@ static inline int cop1_64bit(struct pt_regs *xcp)
 #endif
 }
 
-#define SIFROMREG(si, x) ((si) = cop1_64bit(xcp) || !(x & 1) ? \
-			(int)ctx->fpr[x] : (int)(ctx->fpr[x & ~1] >> 32))
+#define SIFROMREG(si, x) do {						\
+	if (cop1_64bit(xcp))						\
+		(si) = get_fpr32(&ctx->fpr[x], 0);			\
+	else								\
+		(si) = get_fpr32(&ctx->fpr[(x) & ~1], (x) & 1);		\
+} while (0)
 
-#define SITOREG(si, x)	(ctx->fpr[x & ~(cop1_64bit(xcp) == 0)] = \
-			cop1_64bit(xcp) || !(x & 1) ? \
-			ctx->fpr[x & ~1] >> 32 << 32 | (u32)(si) : \
-			ctx->fpr[x & ~1] << 32 >> 32 | (u64)(si) << 32)
+#define SITOREG(si, x) do {						\
+	if (cop1_64bit(xcp))						\
+		set_fpr32(&ctx->fpr[x], 0, si);				\
+	else								\
+		set_fpr32(&ctx->fpr[(x) & ~1], (x) & 1, si);		\
+} while (0)
 
-#define SIFROMHREG(si, x)	((si) = (int)(ctx->fpr[x] >> 32))
-#define SITOHREG(si, x)		(ctx->fpr[x] = \
-				ctx->fpr[x] << 32 >> 32 | (u64)(si) << 32)
+#define SIFROMHREG(si, x)	((si) = get_fpr32(&ctx->fpr[x], 1))
+#define SITOHREG(si, x)		set_fpr32(&ctx->fpr[x], 1, si)
 
-#define DIFROMREG(di, x) ((di) = ctx->fpr[x & ~(cop1_64bit(xcp) == 0)])
-#define DITOREG(di, x)	(ctx->fpr[x & ~(cop1_64bit(xcp) == 0)] = (di))
+#define DIFROMREG(di, x) \
+	((di) = get_fpr64(&ctx->fpr[(x) & ~(cop1_64bit(xcp) == 0)], 0))
+
+#define DITOREG(di, x) \
+	set_fpr64(&ctx->fpr[(x) & ~(cop1_64bit(xcp) == 0)], 0, di)
 
 #define SPFROMREG(sp, x) SIFROMREG((sp).bits, x)
 #define SPTOREG(sp, x)	SITOREG((sp).bits, x)
@@ -1960,15 +1968,18 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 
 #if defined(__mips64)
 	case l_fmt:{
+		u64 bits;
+		DIFROMREG(bits, MIPSInst_FS(ir));
+
 		switch (MIPSInst_FUNC(ir)) {
 		case fcvts_op:
 			/* convert long to single precision real */
-			rv.s = ieee754sp_flong(ctx->fpr[MIPSInst_FS(ir)]);
+			rv.s = ieee754sp_flong(bits);
 			rfmt = s_fmt;
 			goto copcsr;
 		case fcvtd_op:
 			/* convert long to double precision real */
-			rv.d = ieee754dp_flong(ctx->fpr[MIPSInst_FS(ir)]);
+			rv.d = ieee754dp_flong(bits);
 			rfmt = d_fmt;
 			goto copcsr;
 		default:
diff --git a/arch/mips/math-emu/kernel_linkage.c b/arch/mips/math-emu/kernel_linkage.c
index 3aeae07..9b46213 100644
--- a/arch/mips/math-emu/kernel_linkage.c
+++ b/arch/mips/math-emu/kernel_linkage.c
@@ -40,9 +40,8 @@ void fpu_emulator_init_fpu(void)
 	}
 
 	current->thread.fpu.fcr31 = 0;
-	for (i = 0; i < 32; i++) {
-		current->thread.fpu.fpr[i] = SIGNALLING_NAN;
-	}
+	for (i = 0; i < 32; i++)
+		set_fpr64(&current->thread.fpu.fpr[i], 0, SIGNALLING_NAN);
 }
 
 
@@ -59,7 +58,8 @@ int fpu_emulator_save_context(struct sigcontext __user *sc)
 
 	for (i = 0; i < 32; i++) {
 		err |=
-		    __put_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
+		    __put_user(get_fpr64(&current->thread.fpu.fpr[i], 0),
+			       &sc->sc_fpregs[i]);
 	}
 	err |= __put_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
 
@@ -70,10 +70,11 @@ int fpu_emulator_restore_context(struct sigcontext __user *sc)
 {
 	int i;
 	int err = 0;
+	u64 fpr_val;
 
 	for (i = 0; i < 32; i++) {
-		err |=
-		    __get_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
+		err |= __get_user(fpr_val, &sc->sc_fpregs[i]);
+		set_fpr64(&current->thread.fpu.fpr[i], 0, fpr_val);
 	}
 	err |= __get_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
 
@@ -93,7 +94,8 @@ int fpu_emulator_save_context32(struct sigcontext32 __user *sc)
 
 	for (i = 0; i < 32; i += inc) {
 		err |=
-		    __put_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
+		    __put_user(get_fpr64(&current->thread.fpu.fpr[i], 0),
+			       &sc->sc_fpregs[i]);
 	}
 	err |= __put_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
 
@@ -105,10 +107,11 @@ int fpu_emulator_restore_context32(struct sigcontext32 __user *sc)
 	int i;
 	int err = 0;
 	int inc = test_thread_flag(TIF_32BIT_FPREGS) ? 2 : 1;
+	u64 fpr_val;
 
 	for (i = 0; i < 32; i += inc) {
-		err |=
-		    __get_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
+		err |= __get_user(fpr_val, &sc->sc_fpregs[i]);
+		set_fpr64(&current->thread.fpu.fpr[i], 0, fpr_val);
 	}
 	err |= __get_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
 
-- 
1.8.5.3
