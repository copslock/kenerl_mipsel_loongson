Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 16:22:11 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:40183 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133730AbWBAQVw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2006 16:21:52 +0000
Received: from localhost (p6192-ipad212funabasi.chiba.ocn.ne.jp [58.91.170.192])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6E0B38422; Thu,  2 Feb 2006 01:26:54 +0900 (JST)
Date:	Thu, 02 Feb 2006 01:26:34 +0900 (JST)
Message-Id: <20060202.012634.08076945.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix minor sparse warnings
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
X-archive-position: 10282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index e8e43bd..aaec478 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -340,7 +340,7 @@ int setup_rt_frame(struct k_sigaction * 
 
 	/* Create the ucontext.  */
 	err |= __put_user(0, &frame->rs_uc.uc_flags);
-	err |= __put_user(0, &frame->rs_uc.uc_link);
+	err |= __put_user(NULL, &frame->rs_uc.uc_link);
 	err |= __put_user((void *)current->sas_ss_sp,
 	                  &frame->rs_uc.uc_stack.ss_sp);
 	err |= __put_user(sas_ss_flags(regs->regs[29]),
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 7c2241e..136260c 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -456,7 +456,7 @@ int copy_siginfo_to_user32(compat_siginf
 			err |= __put_user(from->si_uid, &to->si_uid);
 			break;
 		case __SI_FAULT >> 16:
-			err |= __put_user((long)from->si_addr, &to->si_addr);
+			err |= __put_user((unsigned long)from->si_addr, &to->si_addr);
 			break;
 		case __SI_POLL >> 16:
 			err |= __put_user(from->si_band, &to->si_band);
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 3d2f8e3..9156863 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -48,6 +48,8 @@
 #define __NR_N32_rt_sigreturn		6211
 #define __NR_N32_restart_syscall	6214
 
+#define DEBUG_SIG 0
+
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
 /* IRIX compatible stack_t  */
