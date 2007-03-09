Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2007 16:09:11 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:59841 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021482AbXCIQJF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2007 16:09:05 +0000
Received: from localhost (p4160-ipad211funabasi.chiba.ocn.ne.jp [58.91.160.160])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E320EBB19; Sat, 10 Mar 2007 01:07:45 +0900 (JST)
Date:	Sat, 10 Mar 2007 01:07:45 +0900 (JST)
Message-Id: <20070310.010745.07456268.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] do_fpe() cleanup
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 14404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

If we had already lost FPU before disabling preempt, we do not have to
own it at all.  And we do not prevent preemption when managing saved
FCR31 if we did not have FPU ownership.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This is an update of:
http://www.linux-mips.org/archives/linux-mips/2007-02/msg00086.html

 arch/mips/kernel/traps.c |   22 ++++++++--------------
 1 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index d5833a4..2aaf76b 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -610,16 +610,6 @@ asmlinkage void do_fpe(struct pt_regs *r
 	if (fcr31 & FPU_CSR_UNI_X) {
 		int sig;
 
-		preempt_disable();
-
-#ifdef CONFIG_PREEMPT
-		if (!is_fpu_owner()) {
-			/* We might lose fpu before disabling preempt... */
-			own_fpu();
-			BUG_ON(!used_math());
-			restore_fp(current);
-		}
-#endif
 		/*
 		 * Unimplemented operation exception.  If we've got the full
 		 * software emulator on-board, let's use it...
@@ -630,7 +620,11 @@ asmlinkage void do_fpe(struct pt_regs *r
 		 * register operands before invoking the emulator, which seems
 		 * a bit extreme for what should be an infrequent event.
 		 */
-		save_fp(current);
+		preempt_disable();
+
+		/* We might have lost fpu before disabling preempt... */
+		if (is_fpu_owner())
+			save_fp(current);
 		/* Ensure 'resume' not overwrite saved fp context again. */
 		lose_fpu();
 
@@ -639,15 +633,15 @@ asmlinkage void do_fpe(struct pt_regs *r
 		/* Run the emulator */
 		sig = fpu_emulator_cop1Handler (regs, &current->thread.fpu, 1);
 
-		preempt_disable();
-
-		own_fpu();	/* Using the FPU again.  */
 		/*
 		 * We can't allow the emulated instruction to leave any of
 		 * the cause bit set in $fcr31.
 		 */
 		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
 
+		preempt_disable();
+
+		own_fpu();	/* Using the FPU again.  */
 		/* Restore the hardware register state */
 		restore_fp(current);
 
