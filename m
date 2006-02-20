Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 16:21:23 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:14276 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133390AbWBTQVP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Feb 2006 16:21:15 +0000
Received: from localhost (p8134-ipad206funabasi.chiba.ocn.ne.jp [222.145.82.134])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BE35E8BEC; Tue, 21 Feb 2006 01:28:08 +0900 (JST)
Date:	Tue, 21 Feb 2006 01:27:59 +0900 (JST)
Message-Id: <20060221.012759.41630456.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix wrong __user usage in  _sysn32_rt_sigsuspend
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
X-archive-position: 10573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 3e168c0..84d1009 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -87,7 +87,8 @@ save_static_function(sysn32_rt_sigsuspen
 __attribute_used__ noinline static int
 _sysn32_rt_sigsuspend(nabi_no_regargs struct pt_regs regs)
 {
-	compat_sigset_t __user *unewset, uset;
+	compat_sigset_t __user *unewset;
+	compat_sigset_t uset;
 	size_t sigsetsize;
 	sigset_t newset;
 
