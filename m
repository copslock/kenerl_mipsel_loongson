Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jan 2006 17:23:26 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:13284 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133523AbWA1RXG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Jan 2006 17:23:06 +0000
Received: from localhost (p1217-ipad204funabasi.chiba.ocn.ne.jp [222.146.88.217])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EB28885A5; Sun, 29 Jan 2006 02:27:46 +0900 (JST)
Date:	Sun, 29 Jan 2006 02:27:24 +0900 (JST)
Message-Id: <20060129.022724.126574864.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] add __user tag to __get_user_check
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
X-archive-position: 10217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Revert __user tag lost by recent get_user rework.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/uaccess.h b/include/asm-mips/uaccess.h
index 6c1c495..91d813a 100644
--- a/include/asm-mips/uaccess.h
+++ b/include/asm-mips/uaccess.h
@@ -233,7 +233,7 @@ do {									\
 #define __get_user_check(x,ptr,size)					\
 ({									\
 	long __gu_err = -EFAULT;					\
-	const void * __gu_ptr = (ptr);					\
+	const void __user * __gu_ptr = (ptr);				\
 									\
 	if (likely(access_ok(VERIFY_READ,  __gu_ptr, size)))		\
 		__get_user_common((x), size, __gu_ptr);			\
