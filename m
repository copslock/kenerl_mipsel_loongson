Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Nov 2006 15:01:26 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:18934 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038979AbWKXPBF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Nov 2006 15:01:05 +0000
Received: from localhost (p6014-ipad01funabasi.chiba.ocn.ne.jp [61.207.80.14])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 552D1B989; Sat, 25 Nov 2006 00:01:00 +0900 (JST)
Date:	Sat, 25 Nov 2006 00:03:44 +0900 (JST)
Message-Id: <20061125.000344.03977447.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 1/3] do_fpe() cleanup
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
X-archive-position: 13253
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
 traps.c |   22 ++++++++--------------
 1 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 9fda1b8..b18aeb6 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -614,16 +614,6 @@ asmlinkage void do_fpe(struct pt_regs *r
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
@@ -634,7 +624,11 @@ #endif
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
 
@@ -643,15 +637,15 @@ #endif
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
 
