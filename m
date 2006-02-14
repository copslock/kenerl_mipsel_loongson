Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 06:51:47 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:54662 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133421AbWBNGvf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 06:51:35 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 14 Feb 2006 15:57:54 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 41862203DE;
	Tue, 14 Feb 2006 15:57:52 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 3400F203D8;
	Tue, 14 Feb 2006 15:57:52 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k1E6vp4D075145;
	Tue, 14 Feb 2006 15:57:51 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 14 Feb 2006 15:57:50 +0900 (JST)
Message-Id: <20060214.155750.93206425.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	tbm@cyrius.com, linux-mips@linux-mips.org, anderson@netsweng.com,
	ddaney@avtrex.com, richard@codesourcery.com
Subject: Re: Fixes for uaccess.h with gcc >= 4.0.1
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060211.224420.25910222.anemo@mba.ocn.ne.jp>
References: <87wtg6c43s.fsf@talisman.home>
	<20060210013440.GA5436@linux-mips.org>
	<20060211.224420.25910222.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sat, 11 Feb 2006 22:44:20 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> Please add this cast to fix compiler/sparse warnings?

Sorry, please ignore this patch.  It would be wrong.


It seems current get_user() incorrectly sign-extend an unsigned int
value on 64bit kernel.  I think this is because '(__typeof__(val))'
cast in final assignment.  I suppose the cast should be
'(__typeof__(*(addr))'.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/uaccess.h b/include/asm-mips/uaccess.h
index 7a553e9..b96f3e0 100644
--- a/include/asm-mips/uaccess.h
+++ b/include/asm-mips/uaccess.h
@@ -233,7 +233,7 @@ do {									\
 #define __get_user_check(x,ptr,size)					\
 ({									\
 	long __gu_err = -EFAULT;					\
-	const void __user * __gu_ptr = (ptr);				\
+	const __typeof__(*(ptr)) __user * __gu_ptr = (ptr);		\
 									\
 	if (likely(access_ok(VERIFY_READ,  __gu_ptr, size)))		\
 		__get_user_common((x), size, __gu_ptr);			\
@@ -258,7 +258,7 @@ do {									\
 	: "=r" (__gu_err), "=r" (__gu_tmp)				\
 	: "0" (0), "o" (__m(addr)), "i" (-EFAULT));			\
 									\
-	(val) = (__typeof__(val)) __gu_tmp;				\
+	(val) = (__typeof__(*(addr))) __gu_tmp;				\
 }
 
 /*
@@ -284,7 +284,7 @@ do {									\
 	"	.previous					\n"	\
 	: "=r" (__gu_err), "=&r" (__gu_tmp)				\
 	: "0" (0), "r" (addr), "i" (-EFAULT));				\
-	(val) = __gu_tmp;						\
+	(val) = (__typeof__(*(addr))) __gu_tmp;				\
 }
 
 /*
