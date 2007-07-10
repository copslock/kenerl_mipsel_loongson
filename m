Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2007 16:23:26 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:54479 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021631AbXGJPXY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Jul 2007 16:23:24 +0100
Received: from localhost (p1061-ipad210funabasi.chiba.ocn.ne.jp [58.88.120.61])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 22517D88; Wed, 11 Jul 2007 00:23:21 +0900 (JST)
Date:	Wed, 11 Jul 2007 00:24:14 +0900 (JST)
Message-Id: <20070711.002414.108121506.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Change names of local variables to silence sparse
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This patch is an workaround for these sparse warnings:

linux/include/linux/calc64.h:25:17: warning: symbol '__quot' shadows an earlier one
linux/include/linux/calc64.h:25:17: originally declared here
linux/include/linux/calc64.h:25:17: warning: symbol '__mod' shadows an earlier one
linux/include/linux/calc64.h:25:17: originally declared here

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/div64.h b/include/asm-mips/div64.h
index 66189f5..716371b 100644
--- a/include/asm-mips/div64.h
+++ b/include/asm-mips/div64.h
@@ -20,7 +20,7 @@
  */
 
 #define do_div64_32(res, high, low, base) ({ \
-	unsigned long __quot, __mod; \
+	unsigned long __quot32, __mod32; \
 	unsigned long __cf, __tmp, __tmp2, __i; \
 	\
 	__asm__(".set	push\n\t" \
@@ -48,12 +48,13 @@
 		"bnez	%4, 0b\n\t" \
 		" srl	%5, %1, 0x1f\n\t" \
 		".set	pop" \
-		: "=&r" (__mod), "=&r" (__tmp), "=&r" (__quot), "=&r" (__cf), \
+		: "=&r" (__mod32), "=&r" (__tmp), \
+		  "=&r" (__quot32), "=&r" (__cf), \
 		  "=&r" (__i), "=&r" (__tmp2) \
 		: "Jr" (base), "0" (high), "1" (low)); \
 	\
-	(res) = __quot; \
-	__mod; })
+	(res) = __quot32; \
+	__mod32; })
 
 #define do_div(n, base) ({ \
 	unsigned long long __quot; \
