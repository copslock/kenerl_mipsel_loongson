Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2005 16:22:23 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:63982 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225256AbVHXPWH>; Wed, 24 Aug 2005 16:22:07 +0100
Received: from localhost (p8216-ipad209funabasi.chiba.ocn.ne.jp [58.88.119.216])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id ECD2C2362; Thu, 25 Aug 2005 00:27:36 +0900 (JST)
Date:	Thu, 25 Aug 2005 00:35:48 +0900 (JST)
Message-Id: <20050825.003548.41199755.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: 64bit unaligned access on 32bit kernel
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
X-archive-position: 8794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

MIPS kernel has been using asm-generic/unaligned.h since 2.6.12-rc2.
But the generic unaligned.h is not suitable for 32bit kernel because
it uses 'unsigned long' for 64bit values.

How about this fix?

diff -u linux-mips/include/asm-generic/unaligned.h linux/include/asm-generic/unaligned.h
--- linux-mips/include/asm-generic/unaligned.h	2005-05-28 00:40:52.000000000 +0900
+++ linux/include/asm-generic/unaligned.h	2005-08-25 00:26:14.359013720 +0900
@@ -18,7 +18,7 @@
 #define get_unaligned(ptr) \
 	((__typeof__(*(ptr)))__get_unaligned((ptr), sizeof(*(ptr))))
 #define put_unaligned(x,ptr) \
-	__put_unaligned((unsigned long)(x), (ptr), sizeof(*(ptr)))
+	__put_unaligned((__u64)(x), (ptr), sizeof(*(ptr)))
 
 /*
  * This function doesn't actually exist.  The idea is that when
@@ -36,19 +36,19 @@
  * Elemental unaligned loads 
  */
 
-static inline unsigned long __uldq(const __u64 *addr)
+static inline __u64 __uldq(const __u64 *addr)
 {
 	const struct __una_u64 *ptr = (const struct __una_u64 *) addr;
 	return ptr->x;
 }
 
-static inline unsigned long __uldl(const __u32 *addr)
+static inline __u64 __uldl(const __u32 *addr)
 {
 	const struct __una_u32 *ptr = (const struct __una_u32 *) addr;
 	return ptr->x;
 }
 
-static inline unsigned long __uldw(const __u16 *addr)
+static inline __u64 __uldw(const __u16 *addr)
 {
 	const struct __una_u16 *ptr = (const struct __una_u16 *) addr;
 	return ptr->x;
@@ -78,7 +78,7 @@
 
 #define __get_unaligned(ptr, size) ({		\
 	const void *__gu_p = ptr;		\
-	unsigned long val;			\
+	__u64 val;				\
 	switch (size) {				\
 	case 1:					\
 		val = *(const __u8 *)__gu_p;	\
