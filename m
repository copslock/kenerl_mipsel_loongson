Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2006 16:41:00 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:41419 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133465AbWFZPkr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Jun 2006 16:40:47 +0100
Received: from localhost (p2207-ipad02funabasi.chiba.ocn.ne.jp [61.214.22.207])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 87E1AB6E1; Tue, 27 Jun 2006 00:40:39 +0900 (JST)
Date:	Tue, 27 Jun 2006 00:41:49 +0900 (JST)
Message-Id: <20060627.004149.126573918.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix smp.h warning on non SMP build
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
X-archive-position: 11858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

smp_call_function() is inline for SMP but macro for non SMP.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/smp.h b/include/asm-mips/smp.h
index af23139..aa3778f 100644
--- a/include/asm-mips/smp.h
+++ b/include/asm-mips/smp.h
@@ -111,10 +111,10 @@ static inline void smp_send_reschedule(i
 
 extern asmlinkage void smp_call_function_interrupt(void);
 
-#endif /* CONFIG_SMP */
-
 int smp_call_function(void(*func)(void *info), void *info, int retry, int wait);
 
+#endif /* CONFIG_SMP */
+
 /*
  * Special Variant of smp_call_function for use by cache functions:
  *
@@ -127,7 +127,8 @@ int smp_call_function(void(*func)(void *
  */
 static inline void __on_other_cores(void (*func) (void *info), void *info)
 {
-#if !defined(CONFIG_MIPS_MT_SMP) && !defined(CONFIG_MIPS_MT_SMTC)
+#if defined(CONFIG_SMP) && \
+	!defined(CONFIG_MIPS_MT_SMP) && !defined(CONFIG_MIPS_MT_SMTC)
 	smp_call_function(func, info, 1, 1);
 #endif
 }
