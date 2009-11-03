Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 01:18:02 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10797 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493951AbZKCARz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2009 01:17:55 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4aef759d0000>; Mon, 02 Nov 2009 16:13:22 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Nov 2009 16:12:43 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Nov 2009 16:12:43 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id nA30Ccwk014543;
	Mon, 2 Nov 2009 16:12:38 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id nA30CZrg014541;
	Mon, 2 Nov 2009 16:12:35 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Make collection of FPU emulator statistics optional.
Date:	Mon,  2 Nov 2009 16:12:35 -0800
Message-Id: <1257207155-14517-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 03 Nov 2009 00:12:43.0269 (UTC) FILETIME=[5D005B50:01CA5C1A]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On SMP systems, the collection of statistics can cause cache line
bouncing in the lines associated with the counters.  Make the
statistics configurable so this can be avoided.  Also we need to make
the counters atomic_t so that they can be reliably modified on SMP
systems.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig                    |   13 +++++++
 arch/mips/include/asm/fpu_emulator.h |   23 +++++++++---
 arch/mips/math-emu/cp1emu.c          |   66 ++++++++++++++++++++-------------
 arch/mips/math-emu/dsemul.c          |    4 +-
 4 files changed, 72 insertions(+), 34 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a4aea20..804e664 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2030,6 +2030,19 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config MIPS_FPU_EMULATOR_STATS
+	bool "Enable FPU emulator statistics"
+	depends on DEBUG_FS
+	default n
+	help
+	  The FPU emulator can collect statistics about how many times
+	  it has been invoked.  On SMP systems making heavy use of the
+	  emulator, the overhead of keeping the statistics may be
+	  large.  The statistics may be read from the files in
+	  /sys/kernel/debug/mips/fpuemustats.
+
+	  If unsure, say N.
+
 endmenu
 
 config LOCKDEP_SUPPORT
diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index e518957..bbe2849 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -25,18 +25,29 @@
 
 #include <asm/break.h>
 #include <asm/inst.h>
+#include <asm/atomic.h>
 
 struct mips_fpu_emulator_stats {
-	unsigned int emulated;
-	unsigned int loads;
-	unsigned int stores;
-	unsigned int cp1ops;
-	unsigned int cp1xops;
-	unsigned int errors;
+	atomic_t emulated;
+	atomic_t loads;
+	atomic_t stores;
+	atomic_t cp1ops;
+	atomic_t cp1xops;
+	atomic_t errors;
 };
 
+#ifdef CONFIG_MIPS_FPU_EMULATOR_STATS
+
 extern struct mips_fpu_emulator_stats fpuemustats;
 
+#define MIPS_FPU_EMU_INC_STATS(M) atomic_inc(&fpuemustats.M)
+
+#else
+
+#define MIPS_FPU_EMU_INC_STATS(M) do { } while (0)
+
+#endif
+
 extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
 	unsigned long cpc);
 extern int do_dsemulret(struct pt_regs *xcp);
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 454b539..46e12af 100644
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
 
+#ifdef CONFIG_MIPS_FPU_EMULATOR_STATS
 struct mips_fpu_emulator_stats fpuemustats;
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
@@ -1275,7 +1278,17 @@ int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 	return sig;
 }
 
-#ifdef CONFIG_DEBUG_FS
+#ifdef CONFIG_MIPS_FPU_EMULATOR_STATS
+
+static int fpuemu_atomic_t_get(void *data, u64 *val)
+{
+	*val = atomic_read((atomic_t *)data);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_fpuemu_atomic_t_ro,
+			fpuemu_atomic_t_get, NULL, "%llu\n");
+
 extern struct dentry *mips_debugfs_dir;
 static int __init debugfs_fpuemu(void)
 {
@@ -1283,7 +1296,7 @@ static int __init debugfs_fpuemu(void)
 	int i;
 	static struct {
 		const char *name;
-		unsigned int *v;
+		atomic_t *v;
 	} vars[] __initdata = {
 		{ "emulated", &fpuemustats.emulated },
 		{ "loads",    &fpuemustats.loads },
@@ -1299,7 +1312,8 @@ static int __init debugfs_fpuemu(void)
 	if (!dir)
 		return -ENOMEM;
 	for (i = 0; i < ARRAY_SIZE(vars); i++) {
-		d = debugfs_create_u32(vars[i].name, S_IRUGO, dir, vars[i].v);
+		d = debugfs_create_file(vars[i].name, S_IRUGO, dir, vars[i].v,
+					&fops_fpuemu_atomic_t_ro);
 		if (!d)
 			return -ENOMEM;
 	}
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
