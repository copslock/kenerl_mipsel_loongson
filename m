Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 20:35:27 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7923 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492681AbZKETfS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2009 20:35:18 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4af328e80002>; Thu, 05 Nov 2009 11:35:04 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Nov 2009 11:34:32 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Nov 2009 11:34:32 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id nA5JYRXs027907;
	Thu, 5 Nov 2009 11:34:27 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id nA5JYQ1u027905;
	Thu, 5 Nov 2009 11:34:26 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Collect FPU emulator statistics per-CPU.
Date:	Thu,  5 Nov 2009 11:34:26 -0800
Message-Id: <1257449666-27880-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 05 Nov 2009 19:34:32.0290 (UTC) FILETIME=[FFA45420:01CA5E4E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On SMP systems, the collection of statistics can cause cache line
bouncing in the lines associated with the counters.  Also there are
races incrementing the counters on multiple CPUs.

To fix both problems, we collect the statistics in per-CPU variables,
and add them up in the debugfs read operation.

As a test I ran the LTP float_bessel test on a 12 CPU Octeon system.

Without CONFIG_DEBUG_FS :             2602 seconds.
With CONFIG_DEBUG_FS:                 2640 seconds.
With non-cpu-local atomic statistics: 14569 seconds.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/fpu_emulator.h |   24 ++++++--
 arch/mips/math-emu/cp1emu.c          |  102 ++++++++++++++++++++--------------
 arch/mips/math-emu/dsemul.c          |    4 +-
 3 files changed, 80 insertions(+), 50 deletions(-)

diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index e518957..aecada6 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -25,17 +25,27 @@
 
 #include <asm/break.h>
 #include <asm/inst.h>
+#include <asm/local.h>
+
+#ifdef CONFIG_DEBUG_FS
 
 struct mips_fpu_emulator_stats {
-	unsigned int emulated;
-	unsigned int loads;
-	unsigned int stores;
-	unsigned int cp1ops;
-	unsigned int cp1xops;
-	unsigned int errors;
+	local_t emulated;
+	local_t loads;
+	local_t stores;
+	local_t cp1ops;
+	local_t cp1xops;
+	local_t errors;
 };
 
-extern struct mips_fpu_emulator_stats fpuemustats;
+DECLARE_PER_CPU(struct mips_fpu_emulator_stats, fpuemustats);
+
+#define MIPS_FPU_EMU_INC_STATS(M)					\
+	cpu_local_wrap(__local_inc(&__get_cpu_var(fpuemustats).M))
+
+#else
+#define MIPS_FPU_EMU_INC_STATS(M) do { } while (0)
+#endif /* CONFIG_DEBUG_FS */
 
 extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
 	unsigned long cpc);
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 454b539..8f2f8e9 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -35,6 +35,7 @@
  * better performance by compiling with -msoft-float!
  */
 #include <linux/sched.h>
+#include <linux/module.h>
 #include <linux/debugfs.h>
 
 #include <asm/inst.h>
@@ -68,7 +69,9 @@ static int fpux_emu(struct pt_regs *,
 
 /* Further private data for which no space exists in mips_fpu_struct */
 
-struct mips_fpu_emulator_stats fpuemustats;
+#ifdef CONFIG_DEBUG_FS
+DEFINE_PER_CPU(struct mips_fpu_emulator_stats, fpuemustats);
+#endif
 
 /* Control registers */
 
@@ -209,7 +212,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 	unsigned int cond;
 
 	if (get_user(ir, (mips_instruction __user *) xcp->cp0_epc)) {
-		fpuemustats.errors++;
+		MIPS_FPU_EMU_INC_STATS(errors);
 		return SIGBUS;
 	}
 
@@ -240,7 +243,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 			return SIGILL;
 		}
 		if (get_user(ir, (mips_instruction __user *) emulpc)) {
-			fpuemustats.errors++;
+			MIPS_FPU_EMU_INC_STATS(errors);
 			return SIGBUS;
 		}
 		/* __compute_return_epc() will have updated cp0_epc */
@@ -253,16 +256,16 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 	}
 
       emul:
-	fpuemustats.emulated++;
+	MIPS_FPU_EMU_INC_STATS(emulated);
 	switch (MIPSInst_OPCODE(ir)) {
 	case ldc1_op:{
 		u64 __user *va = (u64 __user *) (xcp->regs[MIPSInst_RS(ir)] +
 			MIPSInst_SIMM(ir));
 		u64 val;
 
-		fpuemustats.loads++;
+		MIPS_FPU_EMU_INC_STATS(loads);
 		if (get_user(val, va)) {
-			fpuemustats.errors++;
+			MIPS_FPU_EMU_INC_STATS(errors);
 			return SIGBUS;
 		}
 		DITOREG(val, MIPSInst_RT(ir));
@@ -274,10 +277,10 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 			MIPSInst_SIMM(ir));
 		u64 val;
 
-		fpuemustats.stores++;
+		MIPS_FPU_EMU_INC_STATS(stores);
 		DIFROMREG(val, MIPSInst_RT(ir));
 		if (put_user(val, va)) {
-			fpuemustats.errors++;
+			MIPS_FPU_EMU_INC_STATS(errors);
 			return SIGBUS;
 		}
 		break;
@@ -288,9 +291,9 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 			MIPSInst_SIMM(ir));
 		u32 val;
 
-		fpuemustats.loads++;
+		MIPS_FPU_EMU_INC_STATS(loads);
 		if (get_user(val, va)) {
-			fpuemustats.errors++;
+			MIPS_FPU_EMU_INC_STATS(errors);
 			return SIGBUS;
 		}
 		SITOREG(val, MIPSInst_RT(ir));
@@ -302,10 +305,10 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 			MIPSInst_SIMM(ir));
 		u32 val;
 
-		fpuemustats.stores++;
+		MIPS_FPU_EMU_INC_STATS(stores);
 		SIFROMREG(val, MIPSInst_RT(ir));
 		if (put_user(val, va)) {
-			fpuemustats.errors++;
+			MIPS_FPU_EMU_INC_STATS(errors);
 			return SIGBUS;
 		}
 		break;
@@ -429,7 +432,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 
 				if (get_user(ir,
 				    (mips_instruction __user *) xcp->cp0_epc)) {
-					fpuemustats.errors++;
+					MIPS_FPU_EMU_INC_STATS(errors);
 					return SIGBUS;
 				}
 
@@ -595,7 +598,7 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 {
 	unsigned rcsr = 0;	/* resulting csr */
 
-	fpuemustats.cp1xops++;
+	MIPS_FPU_EMU_INC_STATS(cp1xops);
 
 	switch (MIPSInst_FMA_FFMT(ir)) {
 	case s_fmt:{		/* 0 */
@@ -610,9 +613,9 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			va = (void __user *) (xcp->regs[MIPSInst_FR(ir)] +
 				xcp->regs[MIPSInst_FT(ir)]);
 
-			fpuemustats.loads++;
+			MIPS_FPU_EMU_INC_STATS(loads);
 			if (get_user(val, va)) {
-				fpuemustats.errors++;
+				MIPS_FPU_EMU_INC_STATS(errors);
 				return SIGBUS;
 			}
 			SITOREG(val, MIPSInst_FD(ir));
@@ -622,11 +625,11 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			va = (void __user *) (xcp->regs[MIPSInst_FR(ir)] +
 				xcp->regs[MIPSInst_FT(ir)]);
 
-			fpuemustats.stores++;
+			MIPS_FPU_EMU_INC_STATS(stores);
 
 			SIFROMREG(val, MIPSInst_FS(ir));
 			if (put_user(val, va)) {
-				fpuemustats.errors++;
+				MIPS_FPU_EMU_INC_STATS(errors);
 				return SIGBUS;
 			}
 			break;
@@ -687,9 +690,9 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			va = (void __user *) (xcp->regs[MIPSInst_FR(ir)] +
 				xcp->regs[MIPSInst_FT(ir)]);
 
-			fpuemustats.loads++;
+			MIPS_FPU_EMU_INC_STATS(loads);
 			if (get_user(val, va)) {
-				fpuemustats.errors++;
+				MIPS_FPU_EMU_INC_STATS(errors);
 				return SIGBUS;
 			}
 			DITOREG(val, MIPSInst_FD(ir));
@@ -699,10 +702,10 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			va = (void __user *) (xcp->regs[MIPSInst_FR(ir)] +
 				xcp->regs[MIPSInst_FT(ir)]);
 
-			fpuemustats.stores++;
+			MIPS_FPU_EMU_INC_STATS(stores);
 			DIFROMREG(val, MIPSInst_FS(ir));
 			if (put_user(val, va)) {
-				fpuemustats.errors++;
+				MIPS_FPU_EMU_INC_STATS(errors);
 				return SIGBUS;
 			}
 			break;
@@ -769,7 +772,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 #endif
 	} rv;			/* resulting value */
 
-	fpuemustats.cp1ops++;
+	MIPS_FPU_EMU_INC_STATS(cp1ops);
 	switch (rfmt = (MIPSInst_FFMT(ir) & 0xf)) {
 	case s_fmt:{		/* 0 */
 		union {
@@ -1240,7 +1243,7 @@ int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		prevepc = xcp->cp0_epc;
 
 		if (get_user(insn, (mips_instruction __user *) xcp->cp0_epc)) {
-			fpuemustats.errors++;
+			MIPS_FPU_EMU_INC_STATS(errors);
 			return SIGBUS;
 		}
 		if (insn == 0)
@@ -1276,33 +1279,50 @@ int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 }
 
 #ifdef CONFIG_DEBUG_FS
+
+static int fpuemu_stat_get(void *data, u64 *val)
+{
+	int cpu;
+	unsigned long sum = 0;
+	for_each_online_cpu(cpu) {
+		struct mips_fpu_emulator_stats *ps;
+		local_t *pv;
+		ps = &per_cpu(fpuemustats, cpu);
+		pv = (void *)ps + (unsigned long)data;
+		sum += local_read(pv);
+	}
+	*val = sum;
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(fops_fpuemu_stat, fpuemu_stat_get, NULL, "%llu\n");
+
 extern struct dentry *mips_debugfs_dir;
 static int __init debugfs_fpuemu(void)
 {
 	struct dentry *d, *dir;
-	int i;
-	static struct {
-		const char *name;
-		unsigned int *v;
-	} vars[] __initdata = {
-		{ "emulated", &fpuemustats.emulated },
-		{ "loads",    &fpuemustats.loads },
-		{ "stores",   &fpuemustats.stores },
-		{ "cp1ops",   &fpuemustats.cp1ops },
-		{ "cp1xops",  &fpuemustats.cp1xops },
-		{ "errors",   &fpuemustats.errors },
-	};
 
 	if (!mips_debugfs_dir)
 		return -ENODEV;
 	dir = debugfs_create_dir("fpuemustats", mips_debugfs_dir);
 	if (!dir)
 		return -ENOMEM;
-	for (i = 0; i < ARRAY_SIZE(vars); i++) {
-		d = debugfs_create_u32(vars[i].name, S_IRUGO, dir, vars[i].v);
-		if (!d)
-			return -ENOMEM;
-	}
+
+#define FPU_STAT_CREATE(M)						\
+	do {								\
+		d = debugfs_create_file(#M , S_IRUGO, dir,		\
+			(void *)offsetof(struct mips_fpu_emulator_stats, M), \
+			&fops_fpuemu_stat);				\
+		if (!d)							\
+			return -ENOMEM;					\
+	} while (0)
+
+	FPU_STAT_CREATE(emulated);
+	FPU_STAT_CREATE(loads);
+	FPU_STAT_CREATE(stores);
+	FPU_STAT_CREATE(cp1ops);
+	FPU_STAT_CREATE(cp1xops);
+	FPU_STAT_CREATE(errors);
+
 	return 0;
 }
 __initcall(debugfs_fpuemu);
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index df7b9d9..36d975a 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -98,7 +98,7 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 	err |= __put_user(cpc, &fr->epc);
 
 	if (unlikely(err)) {
-		fpuemustats.errors++;
+		MIPS_FPU_EMU_INC_STATS(errors);
 		return SIGBUS;
 	}
 
@@ -136,7 +136,7 @@ int do_dsemulret(struct pt_regs *xcp)
 	err |= __get_user(cookie, &fr->cookie);
 
 	if (unlikely(err || (insn != BREAK_MATH) || (cookie != BD_COOKIE))) {
-		fpuemustats.errors++;
+		MIPS_FPU_EMU_INC_STATS(errors);
 		return 0;
 	}
 
-- 
1.6.0.6
