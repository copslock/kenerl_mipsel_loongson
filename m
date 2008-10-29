Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 00:28:13 +0000 (GMT)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:25299 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S22681870AbYJ2VWA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Oct 2008 21:22:00 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9TLLXHF009835
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 29 Oct 2008 14:21:34 -0700
Received: from localhost.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9TLLWA6019890;
	Wed, 29 Oct 2008 14:21:33 -0700
Message-Id: <200810292121.m9TLLWA6019890@imap1.linux-foundation.org>
Subject: [patch 1/3] mips: use the new byteorder headers
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, akpm@linux-foundation.org,
	harvey.harrison@gmail.com
From:	akpm@linux-foundation.org
Date:	Wed, 29 Oct 2008 14:21:32 -0700
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

From: Harvey Harrison <harvey.harrison@gmail.com>

Acked-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/mips/include/asm/byteorder.h |   40 +++++++++++-----------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff -puN arch/mips/include/asm/byteorder.h~mips-use-the-new-byteorder-headers arch/mips/include/asm/byteorder.h
--- a/arch/mips/include/asm/byteorder.h~mips-use-the-new-byteorder-headers
+++ a/arch/mips/include/asm/byteorder.h
@@ -11,11 +11,19 @@
 #include <linux/compiler.h>
 #include <asm/types.h>
 
-#ifdef __GNUC__
+#if defined(__MIPSEB__)
+# define __BIG_ENDIAN
+#elif defined(__MIPSEL__)
+# define __LITTLE_ENDIAN
+#else
+# error "MIPS, but neither __MIPSEB__, nor __MIPSEL__???"
+#endif
+
+#define __SWAB_64_THRU_32__
 
 #ifdef CONFIG_CPU_MIPSR2
 
-static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 x)
+static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
 {
 	__asm__(
 	"	wsbh	%0, %1			\n"
@@ -24,9 +32,9 @@ static __inline__ __attribute_const__ __
 
 	return x;
 }
-#define __arch__swab16(x)	___arch__swab16(x)
+#define __arch_swab16 __arch_swab16
 
-static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
+static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 {
 	__asm__(
 	"	wsbh	%0, %1			\n"
@@ -36,11 +44,10 @@ static __inline__ __attribute_const__ __
 
 	return x;
 }
-#define __arch__swab32(x)	___arch__swab32(x)
+#define __arch_swab32 __arch_swab32
 
 #ifdef CONFIG_CPU_MIPS64_R2
-
-static __inline__ __attribute_const__ __u64 ___arch__swab64(__u64 x)
+static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
 {
 	__asm__(
 	"	dsbh	%0, %1			\n"
@@ -51,26 +58,11 @@ static __inline__ __attribute_const__ __
 
 	return x;
 }
-
-#define __arch__swab64(x)	___arch__swab64(x)
-
+#define __arch_swab64 __arch_swab64
 #endif /* CONFIG_CPU_MIPS64_R2 */
 
 #endif /* CONFIG_CPU_MIPSR2 */
 
-#if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
-#  define __BYTEORDER_HAS_U64__
-#  define __SWAB_64_THRU_32__
-#endif
-
-#endif /* __GNUC__ */
-
-#if defined(__MIPSEB__)
-#  include <linux/byteorder/big_endian.h>
-#elif defined(__MIPSEL__)
-#  include <linux/byteorder/little_endian.h>
-#else
-#  error "MIPS, but neither __MIPSEB__, nor __MIPSEL__???"
-#endif
+#include <linux/byteorder.h>
 
 #endif /* _ASM_BYTEORDER_H */
_
