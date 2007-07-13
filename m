Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2007 15:02:04 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:38390 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023635AbXGMOBu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Jul 2007 15:01:50 +0100
Received: from localhost (p3184-ipad31funabasi.chiba.ocn.ne.jp [221.189.127.184])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id AABE3B5CC; Fri, 13 Jul 2007 23:01:46 +0900 (JST)
Date:	Fri, 13 Jul 2007 23:02:42 +0900 (JST)
Message-Id: <20070713.230242.48795556.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Add some __user tags
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/branch.c   |    5 +++--
 arch/mips/kernel/traps.c    |    2 +-
 arch/mips/math-emu/dsemul.c |   12 ++++++------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 76fd3f2..6b5df8b 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -22,7 +22,8 @@
  */
 int __compute_return_epc(struct pt_regs *regs)
 {
-	unsigned int *addr, bit, fcr31, dspcontrol;
+	unsigned int __user *addr;
+	unsigned int bit, fcr31, dspcontrol;
 	long epc;
 	union mips_instruction insn;
 
@@ -33,7 +34,7 @@ int __compute_return_epc(struct pt_regs *regs)
 	/*
 	 * Read the instruction
 	 */
-	addr = (unsigned int *) epc;
+	addr = (unsigned int __user *) epc;
 	if (__get_user(insn.word, addr)) {
 		force_sig(SIGSEGV, current);
 		return -EFAULT;
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 5e9fa83..6f3e5c1 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -131,7 +131,7 @@ static void show_stacktrace(struct task_struct *task, struct pt_regs *regs)
 	const int field = 2 * sizeof(unsigned long);
 	long stackdata;
 	int i;
-	unsigned long *sp = (unsigned long *)regs->regs[29];
+	unsigned long __user *sp = (unsigned long __user *)regs->regs[29];
 
 	printk("Stack :");
 	i = 0;
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index ea6ba72..653e325 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -54,8 +54,7 @@ struct emuframe {
 int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 {
 	extern asmlinkage void handle_dsemulret(void);
-	mips_instruction *dsemul_insns;
-	struct emuframe *fr;
+	struct emuframe __user *fr;
 	int err;
 
 	if (ir == 0) {		/* a nop is easy */
@@ -87,8 +86,8 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 	 */
 
 	/* Ensure that the two instructions are in the same cache line */
-	dsemul_insns = (mips_instruction *) ((regs->regs[29] - sizeof(struct emuframe)) & ~0x7);
-	fr = (struct emuframe *) dsemul_insns;
+	fr = (struct emuframe __user *)
+		((regs->regs[29] - sizeof(struct emuframe)) & ~0x7);
 
 	/* Verify that the stack pointer is not competely insane */
 	if (unlikely(!access_ok(VERIFY_WRITE, fr, sizeof(struct emuframe))))
@@ -113,12 +112,13 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 
 int do_dsemulret(struct pt_regs *xcp)
 {
-	struct emuframe *fr;
+	struct emuframe __user *fr;
 	unsigned long epc;
 	u32 insn, cookie;
 	int err = 0;
 
-	fr = (struct emuframe *) (xcp->cp0_epc - sizeof(mips_instruction));
+	fr = (struct emuframe __user *)
+		(xcp->cp0_epc - sizeof(mips_instruction));
 
 	/*
 	 * If we can't even access the area, something is very wrong, but we'll
