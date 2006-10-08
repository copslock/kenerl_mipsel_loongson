Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Oct 2006 16:07:55 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:36301 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038870AbWJHPHx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 8 Oct 2006 16:07:53 +0100
Received: from localhost (p7241-ipad29funabasi.chiba.ocn.ne.jp [221.184.74.241])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4D55BAAC7; Mon,  9 Oct 2006 00:07:47 +0900 (JST)
Date:	Mon, 09 Oct 2006 00:10:01 +0900 (JST)
Message-Id: <20061009.001001.74753036.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, mlachwani@mvista.com
Subject: [PATCH] Make sure cpu_has_fpu is used only in atomic context
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060901.170817.118968734.nemoto@toshiba-tops.co.jp>
References: <44F715F2.7050305@mvista.com>
	<20060901.122527.63741495.nemoto@toshiba-tops.co.jp>
	<20060901.170817.118968734.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Make sure cpu_has_fpu (which uses smp_processor_id()) is used
only in atomic context.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 arch/mips/kernel/proc.c     |    2 +-
 arch/mips/kernel/process.c  |    2 +-
 arch/mips/kernel/ptrace.c   |   18 ++++++++++--------
 arch/mips/kernel/ptrace32.c |    3 ++-
 arch/mips/kernel/traps.c    |   16 +++++++++-------
 arch/mips/math-emu/cp1emu.c |    7 +++----
 include/asm-mips/fpu.h      |    6 ++++--
 7 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 46ee5a6..4ed37ba 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -107,7 +107,7 @@ #endif
 
 	seq_printf(m, "processor\t\t: %ld\n", n);
 	sprintf(fmt, "cpu model\t\t: %%s V%%d.%%d%s\n",
-	        cpu_has_fpu ? "  FPU V%d.%d" : "");
+	        cpu_data[n].options & MIPS_CPU_FPU ? "  FPU V%d.%d" : "");
 	seq_printf(m, fmt, cpu_name[cpu_data[n].cputype <= CPU_LAST ?
 	                            cpu_data[n].cputype : CPU_UNKNOWN],
 	                           (version >> 4) & 0x0f, version & 0x0f,
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 045d987..9f307eb 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -115,7 +115,7 @@ #endif
 	status |= KU_USER;
 	regs->cp0_status = status;
 	clear_used_math();
-	lose_fpu();
+	clear_fpu_owner();
 	if (cpu_has_dsp)
 		__init_dsp();
 	regs->cp0_epc = pc;
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 9c3b5fc..1fd705a 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -106,6 +106,7 @@ int ptrace_setregs (struct task_struct *
 int ptrace_getfpregs (struct task_struct *child, __u32 __user *data)
 {
 	int i;
+	unsigned int tmp;
 
 	if (!access_ok(VERIFY_WRITE, data, 33 * 8))
 		return -EIO;
@@ -121,10 +122,10 @@ int ptrace_getfpregs (struct task_struct
 
 	__put_user (child->thread.fpu.fcr31, data + 64);
 
+	preempt_disable();
 	if (cpu_has_fpu) {
-		unsigned int flags, tmp;
+		unsigned int flags;
 
-		preempt_disable();
 		if (cpu_has_mipsmt) {
 			unsigned int vpflags = dvpe();
 			flags = read_c0_status();
@@ -138,11 +139,11 @@ int ptrace_getfpregs (struct task_struct
 			__asm__ __volatile__("cfc1\t%0,$0" : "=r" (tmp));
 			write_c0_status(flags);
 		}
-		preempt_enable();
-		__put_user (tmp, data + 65);
 	} else {
-		__put_user ((__u32) 0, data + 65);
+		tmp = 0;
 	}
+	preempt_enable();
+	__put_user (tmp, data + 65);
 
 	return 0;
 }
@@ -245,16 +246,17 @@ #ifdef CONFIG_MIPS_MT_SMTC
 			unsigned int mtflags;
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-			if (!cpu_has_fpu)
+			preempt_disable();
+			if (!cpu_has_fpu) {
+				preempt_enable();
 				break;
+			}
 
 #ifdef CONFIG_MIPS_MT_SMTC
 			/* Read-modify-write of Status must be atomic */
 			local_irq_save(irqflags);
 			mtflags = dmt();
 #endif /* CONFIG_MIPS_MT_SMTC */
-
-			preempt_disable();
 			if (cpu_has_mipsmt) {
 				unsigned int vpflags = dvpe();
 				flags = read_c0_status();
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index f40ecd8..d9a39c1 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -175,7 +175,9 @@ #ifdef CONFIG_MIPS_MT_SMTC
 			unsigned int mtflags;
 #endif /* CONFIG_MIPS_MT_SMTC */
 
+			preempt_disable();
 			if (!cpu_has_fpu) {
+				preempt_enable();
 				tmp = 0;
 				break;
 			}
@@ -186,7 +188,6 @@ #ifdef CONFIG_MIPS_MT_SMTC
 			mtflags = dmt();
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-			preempt_disable();
 			if (cpu_has_mipsmt) {
 				unsigned int vpflags = dvpe();
 				flags = read_c0_status();
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index b7292a5..cce8313 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -66,7 +66,7 @@ extern asmlinkage void handle_mcheck(voi
 extern asmlinkage void handle_reserved(void);
 
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
-	struct mips_fpu_struct *ctx);
+	struct mips_fpu_struct *ctx, int has_fpu);
 
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
@@ -641,7 +641,7 @@ #endif
 		preempt_enable();
 
 		/* Run the emulator */
-		sig = fpu_emulator_cop1Handler (regs, &current->thread.fpu);
+		sig = fpu_emulator_cop1Handler (regs, &current->thread.fpu, 1);
 
 		preempt_disable();
 
@@ -791,11 +791,13 @@ asmlinkage void do_cpu(struct pt_regs *r
 			set_used_math();
 		}
 
-		preempt_enable();
-
-		if (!cpu_has_fpu) {
-			int sig = fpu_emulator_cop1Handler(regs,
-						&current->thread.fpu);
+		if (cpu_has_fpu) {
+			preempt_enable();
+		} else {
+			int sig;
+			preempt_enable();
+			sig = fpu_emulator_cop1Handler(regs,
+						&current->thread.fpu, 0);
 			if (sig)
 				force_sig(sig, current);
 #ifdef CONFIG_MIPS_MT_FPAFF
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 3f0d5d2..80531b3 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -38,8 +38,6 @@ #include <linux/sched.h>
 
 #include <asm/inst.h>
 #include <asm/bootinfo.h>
-#include <asm/cpu.h>
-#include <asm/cpu-features.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/signal.h>
@@ -1233,7 +1231,8 @@ #endif
 	return 0;
 }
 
-int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
+int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
+	int has_fpu)
 {
 	unsigned long oldepc, prevepc;
 	mips_instruction insn;
@@ -1263,7 +1262,7 @@ int fpu_emulator_cop1Handler(struct pt_r
 			ieee754_csr.rm = mips_rm[ieee754_csr.rm];
 		}
 
-		if (cpu_has_fpu)
+		if (has_fpu)
 			break;
 		if (sig)
 			break;
diff --git a/include/asm-mips/fpu.h b/include/asm-mips/fpu.h
index 58c561a..efef843 100644
--- a/include/asm-mips/fpu.h
+++ b/include/asm-mips/fpu.h
@@ -134,9 +134,11 @@ static inline void restore_fp(struct tas
 
 static inline fpureg_t *get_fpu_regs(struct task_struct *tsk)
 {
-	if (cpu_has_fpu) {
-		if ((tsk == current) && __is_fpu_owner())
+	if (tsk == current) {
+		preempt_disable();
+		if (is_fpu_owner())
 			_save_fp(current);
+		preempt_enable();
 	}
 
 	return tsk->thread.fpu.fpr;
