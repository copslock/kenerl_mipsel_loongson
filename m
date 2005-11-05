Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Nov 2005 14:01:27 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:44227 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133476AbVKEOBB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 5 Nov 2005 14:01:01 +0000
Received: from localhost (p5048-ipad205funabasi.chiba.ocn.ne.jp [222.146.100.48])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7E5F9AAE8; Sat,  5 Nov 2005 23:01:57 +0900 (JST)
Date:	Sat, 05 Nov 2005 23:00:58 +0900 (JST)
Message-Id: <20051105.230058.25910302.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix return type of setup_frame variants
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
X-archive-position: 9426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Since 2.6.13-rc1, setup_frame and its variants return int.  But there
are some remaining bits.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -384,9 +384,6 @@ give_sigsegv:
 	return 0;
 }
 
-extern void setup_rt_frame_n32(struct k_sigaction * ka,
-	struct pt_regs *regs, int signr, sigset_t *set, siginfo_t *info);
-
 static inline int handle_signal(unsigned long sig, siginfo_t *info,
 	struct k_sigaction *ka, sigset_t *oldset, struct pt_regs *regs)
 {
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -647,8 +647,8 @@ static inline void *get_sigframe(struct 
 	return (void *)((sp - frame_size) & ALMASK);
 }
 
-void setup_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
-			       int signr, sigset_t *set)
+int setup_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
+	int signr, sigset_t *set)
 {
 	struct sigframe *frame;
 	int err = 0;
@@ -694,13 +694,15 @@ void setup_frame_32(struct k_sigaction *
 	       current->comm, current->pid,
 	       frame, regs->cp0_epc, frame->sf_code);
 #endif
-        return;
+	return 1;
 
 give_sigsegv:
 	force_sigsegv(signr, current);
+	return 0;
 }
 
-void setup_rt_frame_32(struct k_sigaction * ka, struct pt_regs *regs, int signr,	sigset_t *set, siginfo_t *info)
+int setup_rt_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
+	int signr, sigset_t *set, siginfo_t *info)
 {
 	struct rt_sigframe32 *frame;
 	int err = 0;
@@ -763,10 +765,11 @@ void setup_rt_frame_32(struct k_sigactio
 	       current->comm, current->pid,
 	       frame, regs->cp0_epc, frame->rs_code);
 #endif
-	return;
+	return 1;
 
 give_sigsegv:
 	force_sigsegv(signr, current);
+	return 0;
 }
 
 static inline int handle_signal(unsigned long sig, siginfo_t *info,
