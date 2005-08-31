Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2005 17:09:07 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:50912 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225555AbVHaQIv>; Wed, 31 Aug 2005 17:08:51 +0100
Received: from localhost (p8037-ipad31funabasi.chiba.ocn.ne.jp [221.189.132.37])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 398983DA6; Thu,  1 Sep 2005 01:15:04 +0900 (JST)
Date:	Thu, 01 Sep 2005 01:15:51 +0900 (JST)
Message-Id: <20050901.011551.96687558.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: setup_frame and variants
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
X-archive-position: 8846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Now setup_frame and variants return int.  Here is a patch for
remaining bits.


Index: arch/mips/kernel/signal.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/signal.c,v
retrieving revision 1.92
diff -u -r1.92 signal.c
--- arch/mips/kernel/signal.c	11 Jul 2005 20:46:28 -0000	1.92
+++ arch/mips/kernel/signal.c	31 Aug 2005 14:35:17 -0000
@@ -384,9 +384,6 @@
 	return 0;
 }
 
-extern void setup_rt_frame_n32(struct k_sigaction * ka,
-	struct pt_regs *regs, int signr, sigset_t *set, siginfo_t *info);
-
 static inline int handle_signal(unsigned long sig, siginfo_t *info,
 	struct k_sigaction *ka, sigset_t *oldset, struct pt_regs *regs)
 {
Index: arch/mips/kernel/signal32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/signal32.c,v
retrieving revision 1.33
diff -u -r1.33 signal32.c
--- arch/mips/kernel/signal32.c	11 Jul 2005 20:46:28 -0000	1.33
+++ arch/mips/kernel/signal32.c	31 Aug 2005 14:35:18 -0000
@@ -647,8 +647,8 @@
 	return (void *)((sp - frame_size) & ALMASK);
 }
 
-void setup_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
-			       int signr, sigset_t *set)
+int setup_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
+			      int signr, sigset_t *set)
 {
 	struct sigframe *frame;
 	int err = 0;
@@ -694,13 +694,14 @@
 	       current->comm, current->pid,
 	       frame, regs->cp0_epc, frame->sf_code);
 #endif
-        return;
+        return 1;
 
 give_sigsegv:
 	force_sigsegv(signr, current);
+	return 0;
 }
 
-void setup_rt_frame_32(struct k_sigaction * ka, struct pt_regs *regs, int signr,	sigset_t *set, siginfo_t *info)
+int setup_rt_frame_32(struct k_sigaction * ka, struct pt_regs *regs, int signr,	sigset_t *set, siginfo_t *info)
 {
 	struct rt_sigframe32 *frame;
 	int err = 0;
@@ -763,10 +764,11 @@
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
