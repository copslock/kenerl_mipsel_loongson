Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Mar 2006 11:24:27 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:11207 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133371AbWCFLYN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Mar 2006 11:24:13 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 6 Mar 2006 20:32:28 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 12BE1204EF;
	Mon,  6 Mar 2006 20:32:19 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 0529C20006;
	Mon,  6 Mar 2006 20:32:19 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k26BWI4D077675;
	Mon, 6 Mar 2006 20:32:18 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 06 Mar 2006 20:32:18 +0900 (JST)
Message-Id: <20060306.203218.69025300.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	akpm@osdl.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] 64bit unaligned access on 32bit kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050830104056.GA4710@linux-mips.org>
References: <20050830104056.GA4710@linux-mips.org>
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
X-archive-position: 10733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 30 Aug 2005 11:40:56 +0100, Ralf Baechle <ralf@linux-mips.org> said:
> I've rewriten Atushi's fix for the 64-bit put_unaligned on 32-bit
> systems bug to generate more efficient code.

> This case has buzilla URL http://bugzilla.kernel.org/show_bug.cgi?id=5138.

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
...
>  #define __get_unaligned(ptr, size) ({		\
>  	const void *__gu_p = ptr;		\
> -	unsigned long val;			\
> +	__typeof__(*(ptr)) val;			\
>  	switch (size) {				\
>  	case 1:					\
>  		val = *(const __u8 *)__gu_p;	\

It looks gcc 4.x strike back.  If the 'ptr' is a const, this code
cause "assignment of read-only variable" error on gcc 4.x.  Let's step
a back, or do you have any other good idea?


Use __u64 instead of __typeof__(*(ptr)) for temporary variable to get
rid of errors on gcc 4.x.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 4dc8ddb..09ec447 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -78,7 +78,7 @@ static inline void __ustw(__u16 val, __u
 
 #define __get_unaligned(ptr, size) ({		\
 	const void *__gu_p = ptr;		\
-	__typeof__(*(ptr)) val;			\
+	__u64 val;				\
 	switch (size) {				\
 	case 1:					\
 		val = *(const __u8 *)__gu_p;	\
@@ -95,7 +95,7 @@ static inline void __ustw(__u16 val, __u
 	default:				\
 		bad_unaligned_access_length();	\
 	};					\
-	val;					\
+	(__typeof__(*(ptr)))val;		\
 })
 
 #define __put_unaligned(val, ptr, size)		\
