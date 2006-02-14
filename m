Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 13:34:49 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:25074 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133495AbWBNNek (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2006 13:34:40 +0000
Received: from localhost (p3141-ipad30funabasi.chiba.ocn.ne.jp [221.184.78.141])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BF2CA94F0; Tue, 14 Feb 2006 22:40:58 +0900 (JST)
Date:	Tue, 14 Feb 2006 22:40:45 +0900 (JST)
Message-Id: <20060214.224045.41632501.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix typo in _sys32_rt_sigreturn, _sysn32_rt_sigreturn
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
X-archive-position: 10458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index da3271e..8a8b8dd 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -537,7 +537,7 @@ _sys32_rt_sigreturn(nabi_no_regargs stru
 	/* The ucontext contains a stack32_t, so we must convert!  */
 	if (__get_user(sp, &frame->rs_uc.uc_stack.ss_sp))
 		goto badframe;
-	st.ss_size = (long) sp;
+	st.ss_sp = (void *)(long) sp;
 	if (__get_user(st.ss_size, &frame->rs_uc.uc_stack.ss_size))
 		goto badframe;
 	if (__get_user(st.ss_flags, &frame->rs_uc.uc_stack.ss_flags))
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 384fc4a..5a37760 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -108,7 +108,7 @@ _sysn32_rt_sigreturn(nabi_no_regargs str
 	/* The ucontext contains a stack32_t, so we must convert!  */
 	if (__get_user(sp, &frame->rs_uc.uc_stack.ss_sp))
 		goto badframe;
-	st.ss_size = (long) sp;
+	st.ss_sp = (void *)(long) sp;
 	if (__get_user(st.ss_size, &frame->rs_uc.uc_stack.ss_size))
 		goto badframe;
 	if (__get_user(st.ss_flags, &frame->rs_uc.uc_stack.ss_flags))
