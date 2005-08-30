Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2005 11:35:18 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:34070 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225224AbVH3Ke5>; Tue, 30 Aug 2005 11:34:57 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7UAew9s004916;
	Tue, 30 Aug 2005 11:40:58 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7UAeuDp004915;
	Tue, 30 Aug 2005 11:40:56 +0100
Date:	Tue, 30 Aug 2005 11:40:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] 64bit unaligned access on 32bit kernel
Message-ID: <20050830104056.GA4710@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

I've rewriten Atushi's fix for the 64-bit put_unaligned on 32-bit systems
bug to generate more efficient code.

This case has buzilla URL http://bugzilla.kernel.org/show_bug.cgi?id=5138.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff -u -r1.3 unaligned.h
--- suckage/include/asm-generic/unaligned.h 19 May 2005 12:08:41 -0000
+++ suckage/include/asm-generic/unaligned.h 30 Aug 2005 10:28:23 -0000
@@ -16,9 +16,9 @@
  * The main single-value unaligned transfer routines.
  */
 #define get_unaligned(ptr) \
-	((__typeof__(*(ptr)))__get_unaligned((ptr), sizeof(*(ptr))))
+	__get_unaligned((ptr), sizeof(*(ptr)))
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
+static inline __u32 __uldl(const __u32 *addr)
 {
 	const struct __una_u32 *ptr = (const struct __una_u32 *) addr;
 	return ptr->x;
 }
 
-static inline unsigned long __uldw(const __u16 *addr)
+static inline __u16 __uldw(const __u16 *addr)
 {
 	const struct __una_u16 *ptr = (const struct __una_u16 *) addr;
 	return ptr->x;
@@ -78,7 +78,7 @@
 
 #define __get_unaligned(ptr, size) ({		\
 	const void *__gu_p = ptr;		\
-	unsigned long val;			\
+	__typeof__(*(ptr)) val;			\
 	switch (size) {				\
 	case 1:					\
 		val = *(const __u8 *)__gu_p;	\
