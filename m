Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Aug 2010 00:44:54 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6367 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492872Ab0HCWou (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Aug 2010 00:44:50 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c589bfc0000>; Tue, 03 Aug 2010 15:45:16 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 15:44:47 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 15:44:47 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o73MijwL018582;
        Tue, 3 Aug 2010 15:44:45 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o73MiiFp018581;
        Tue, 3 Aug 2010 15:44:44 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Clean up notify_die() usage.
Date:   Tue,  3 Aug 2010 15:44:43 -0700
Message-Id: <1280875483-18540-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
X-OriginalArrivalTime: 03 Aug 2010 22:44:47.0664 (UTC) FILETIME=[79AE6B00:01CB335D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The sixth argument of notify_die() is a signal number, the fifth is a
trap number.

Instead of passing a signal number in a randomly selected argument,
pass it in the sixth.  Extract the exception code from regs and pass
that as the trap number.

Get rid of redundant cast, and remove some gratuitous spaces.

Nobody actually does anything with the signal number or trap number,
but we might as well populate them with sensible values.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/traps.c |   25 +++++++++++++++----------
 1 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 9d71774..62a53c7 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -369,9 +369,14 @@ void show_registers(struct pt_regs *regs)
 	printk("\n");
 }
 
+static int regs_to_trapnr(struct pt_regs *regs)
+{
+	return (regs->cp0_cause >> 2) & 0x1f;
+}
+
 static DEFINE_SPINLOCK(die_lock);
 
-void __noreturn die(const char * str, struct pt_regs * regs)
+void __noreturn die(const char *str, struct pt_regs *regs)
 {
 	static int die_counter;
 	int sig = SIGSEGV;
@@ -379,7 +384,7 @@ void __noreturn die(const char * str, struct pt_regs * regs)
 	unsigned long dvpret = dvpe();
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-	notify_die(DIE_OOPS, str, (struct pt_regs *)regs, SIGSEGV, 0, 0);
+	notify_die(DIE_OOPS, str, regs, 0, regs_to_trapnr(regs), SIGSEGV);
 
 	console_verbose();
 	spin_lock_irq(&die_lock);
@@ -388,7 +393,7 @@ void __noreturn die(const char * str, struct pt_regs * regs)
 	mips_mt_regdump(dvpret);
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-	if (notify_die(DIE_OOPS, str, regs, 0, 0, SIGSEGV) == NOTIFY_STOP)
+	if (notify_die(DIE_OOPS, str, regs, 0, regs_to_trapnr(regs), SIGSEGV) == NOTIFY_STOP)
 		sig = 0;
 
 	printk("%s[#%d]:\n", str, ++die_counter);
@@ -462,7 +467,7 @@ asmlinkage void do_be(struct pt_regs *regs)
 	printk(KERN_ALERT "%s bus error, epc == %0*lx, ra == %0*lx\n",
 	       data ? "Data" : "Instruction",
 	       field, regs->cp0_epc, field, regs->regs[31]);
-	if (notify_die(DIE_OOPS, "bus error", regs, SIGBUS, 0, 0)
+	if (notify_die(DIE_OOPS, "bus error", regs, 0, regs_to_trapnr(regs), SIGBUS)
 	    == NOTIFY_STOP)
 		return;
 
@@ -690,7 +695,7 @@ asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 {
 	siginfo_t info;
 
-	if (notify_die(DIE_FP, "FP exception", regs, SIGFPE, 0, 0)
+	if (notify_die(DIE_FP, "FP exception", regs, 0, regs_to_trapnr(regs), SIGFPE)
 	    == NOTIFY_STOP)
 		return;
 	die_if_kernel("FP exception in kernel code", regs);
@@ -753,11 +758,11 @@ static void do_trap_or_bp(struct pt_regs *regs, unsigned int code,
 	char b[40];
 
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
-	if (kgdb_ll_trap(DIE_TRAP, str, regs, code, 0, 0) == NOTIFY_STOP)
+	if (kgdb_ll_trap(DIE_TRAP, str, regs, code, regs_to_trapnr(regs), SIGTRAP) == NOTIFY_STOP)
 		return;
 #endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */
 
-	if (notify_die(DIE_TRAP, str, regs, code, 0, 0) == NOTIFY_STOP)
+	if (notify_die(DIE_TRAP, str, regs, code, regs_to_trapnr(regs), SIGTRAP) == NOTIFY_STOP)
 		return;
 
 	/*
@@ -829,12 +834,12 @@ asmlinkage void do_bp(struct pt_regs *regs)
 	 */
 	switch (bcode) {
 	case BRK_KPROBE_BP:
-		if (notify_die(DIE_BREAK, "debug", regs, bcode, 0, 0) == NOTIFY_STOP)
+		if (notify_die(DIE_BREAK, "debug", regs, bcode, regs_to_trapnr(regs), SIGTRAP) == NOTIFY_STOP)
 			return;
 		else
 			break;
 	case BRK_KPROBE_SSTEPBP:
-		if (notify_die(DIE_SSTEPBP, "single_step", regs, bcode, 0, 0) == NOTIFY_STOP)
+		if (notify_die(DIE_SSTEPBP, "single_step", regs, bcode, regs_to_trapnr(regs), SIGTRAP) == NOTIFY_STOP)
 			return;
 		else
 			break;
@@ -874,7 +879,7 @@ asmlinkage void do_ri(struct pt_regs *regs)
 	unsigned int opcode = 0;
 	int status = -1;
 
-	if (notify_die(DIE_RI, "RI Fault", regs, SIGSEGV, 0, 0)
+	if (notify_die(DIE_RI, "RI Fault", regs, 0, regs_to_trapnr(regs), SIGILL)
 	    == NOTIFY_STOP)
 		return;
 
-- 
1.7.1.1
