Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2007 16:12:35 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:50142 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021878AbXCJQM3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 10 Mar 2007 16:12:29 +0000
Received: from localhost (p5205-ipad211funabasi.chiba.ocn.ne.jp [58.91.161.205])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E394AB741; Sun, 11 Mar 2007 01:11:07 +0900 (JST)
Date:	Sun, 11 Mar 2007 01:11:07 +0900 (JST)
Message-Id: <20070311.011107.130240811.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Micro optimize setup/restore sigcontext
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
X-archive-position: 14424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

No need to call used_math() twice in setup_sigcontext, and no need to
call used_math() in restore_sigcontext.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/signal.c   |    8 +++++---
 arch/mips/kernel/signal32.c |    8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 5b50569..8c3c5a5 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -82,6 +82,7 @@ int setup_sigcontext(struct pt_regs *reg
 {
 	int err = 0;
 	int i;
+	unsigned int used_math;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
 
@@ -104,9 +105,10 @@ int setup_sigcontext(struct pt_regs *reg
 		err |= __put_user(rddsp(DSP_MASK), &sc->sc_dsp);
 	}
 
-	err |= __put_user(!!used_math(), &sc->sc_used_math);
+	used_math = !!used_math();
+	err |= __put_user(used_math, &sc->sc_used_math);
 
-	if (used_math()) {
+	if (used_math) {
 		/*
 		 * Save FPU state to signal context. Signal handler
 		 * will "inherit" current FPU state.
@@ -183,7 +185,7 @@ int restore_sigcontext(struct pt_regs *r
 	err |= __get_user(used_math, &sc->sc_used_math);
 	conditional_used_math(used_math);
 
-	if (used_math()) {
+	if (used_math) {
 		/* restore fpu context if we have used it before */
 		own_fpu(0);
 		enable_fp_in_kernel();
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index c90c8cf..151fd2f 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -181,6 +181,7 @@ static int setup_sigcontext32(struct pt_
 {
 	int err = 0;
 	int i;
+	u32 used_math;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
 
@@ -200,9 +201,10 @@ static int setup_sigcontext32(struct pt_
 		err |= __put_user(mflo3(), &sc->sc_lo3);
 	}
 
-	err |= __put_user(!!used_math(), &sc->sc_used_math);
+	used_math = !!used_math();
+	err |= __put_user(used_math, &sc->sc_used_math);
 
-	if (used_math()) {
+	if (used_math) {
 		/*
 		 * Save FPU state to signal context.  Signal handler
 		 * will "inherit" current FPU state.
@@ -257,7 +259,7 @@ static int restore_sigcontext32(struct p
 	err |= __get_user(used_math, &sc->sc_used_math);
 	conditional_used_math(used_math);
 
-	if (used_math()) {
+	if (used_math) {
 		/* restore fpu context if we have used it before */
 		own_fpu(0);
 		enable_fp_in_kernel();
