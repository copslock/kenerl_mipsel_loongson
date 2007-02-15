Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 14:34:48 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:16091 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039324AbXBOOep (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Feb 2007 14:34:45 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1FEYhgC025615;
	Thu, 15 Feb 2007 14:34:44 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1FEYfHu025614;
	Thu, 15 Feb 2007 14:34:41 GMT
Date:	Thu, 15 Feb 2007 14:34:41 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Optimize generic get_unaligned / put_unaligned implementations.
Message-ID: <20070215143441.GA18155@linux-mips.org>
References: <20050830104056.GA4710@linux-mips.org> <20060306.203218.69025300.nemoto@toshiba-tops.co.jp> <20060306170552.0aab29c5.akpm@osdl.org> <20070214214226.GA17899@linux-mips.org> <20070214203903.8d013170.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070214203903.8d013170.akpm@linux-foundation.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 14, 2007 at 08:39:03PM -0800, Andrew Morton wrote:

> Can someone please tell us how this magic works?  (And it does appear to
> work).
> 
> It seems to assuming that the compiler will assume that members of packed
> structures can have arbitrary alignment, even if that alignment is obvious.
> 
> Which makes sense, but I'd like to see chapter-and-verse from the spec or
> from the gcc docs so we can rely upon it working on all architectures and
> compilers from now until ever more.
> 
> IOW: your changlogging sucks ;)

It was my entry for the next edition of the C Puzzle Book ;-)

The whole union thing was only needed to get rid of a warning but Marcel's
solution does the same thing by attaching the packed keyword to the entire
structure instead, so this patch is now using his macros but using __packed
instead.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 09ec447..60d94fc 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -1,122 +1,27 @@
-#ifndef _ASM_GENERIC_UNALIGNED_H_
-#define _ASM_GENERIC_UNALIGNED_H_
-
-/*
- * For the benefit of those who are trying to port Linux to another
- * architecture, here are some C-language equivalents. 
- *
- * This is based almost entirely upon Richard Henderson's
- * asm-alpha/unaligned.h implementation.  Some comments were
- * taken from David Mosberger's asm-ia64/unaligned.h header.
- */
-
-#include <linux/types.h>
-
-/* 
- * The main single-value unaligned transfer routines.
- */
-#define get_unaligned(ptr) \
-	__get_unaligned((ptr), sizeof(*(ptr)))
-#define put_unaligned(x,ptr) \
-	__put_unaligned((__u64)(x), (ptr), sizeof(*(ptr)))
-
 /*
- * This function doesn't actually exist.  The idea is that when
- * someone uses the macros below with an unsupported size (datatype),
- * the linker will alert us to the problem via an unresolved reference
- * error.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  */
-extern void bad_unaligned_access_length(void) __attribute__((noreturn));
-
-struct __una_u64 { __u64 x __attribute__((packed)); };
-struct __una_u32 { __u32 x __attribute__((packed)); };
-struct __una_u16 { __u16 x __attribute__((packed)); };
-
-/*
- * Elemental unaligned loads 
- */
-
-static inline __u64 __uldq(const __u64 *addr)
-{
-	const struct __una_u64 *ptr = (const struct __una_u64 *) addr;
-	return ptr->x;
-}
-
-static inline __u32 __uldl(const __u32 *addr)
-{
-	const struct __una_u32 *ptr = (const struct __una_u32 *) addr;
-	return ptr->x;
-}
-
-static inline __u16 __uldw(const __u16 *addr)
-{
-	const struct __una_u16 *ptr = (const struct __una_u16 *) addr;
-	return ptr->x;
-}
-
-/*
- * Elemental unaligned stores 
- */
-
-static inline void __ustq(__u64 val, __u64 *addr)
-{
-	struct __una_u64 *ptr = (struct __una_u64 *) addr;
-	ptr->x = val;
-}
-
-static inline void __ustl(__u32 val, __u32 *addr)
-{
-	struct __una_u32 *ptr = (struct __una_u32 *) addr;
-	ptr->x = val;
-}
+#ifndef __ASM_GENERIC_UNALIGNED_H
+#define __ASM_GENERIC_UNALIGNED_H
 
-static inline void __ustw(__u16 val, __u16 *addr)
-{
-	struct __una_u16 *ptr = (struct __una_u16 *) addr;
-	ptr->x = val;
-}
+#include <linux/compiler.h>
 
-#define __get_unaligned(ptr, size) ({		\
-	const void *__gu_p = ptr;		\
-	__u64 val;				\
-	switch (size) {				\
-	case 1:					\
-		val = *(const __u8 *)__gu_p;	\
-		break;				\
-	case 2:					\
-		val = __uldw(__gu_p);		\
-		break;				\
-	case 4:					\
-		val = __uldl(__gu_p);		\
-		break;				\
-	case 8:					\
-		val = __uldq(__gu_p);		\
-		break;				\
-	default:				\
-		bad_unaligned_access_length();	\
-	};					\
-	(__typeof__(*(ptr)))val;		\
+#define get_unaligned(ptr)					\
+({								\
+	struct __packed {					\
+		typeof(*(ptr)) __v;				\
+	} *__p = (void *) (ptr);				\
+	__p->__v;						\
 })
 
-#define __put_unaligned(val, ptr, size)		\
-do {						\
-	void *__gu_p = ptr;			\
-	switch (size) {				\
-	case 1:					\
-		*(__u8 *)__gu_p = val;		\
-	        break;				\
-	case 2:					\
-		__ustw(val, __gu_p);		\
-		break;				\
-	case 4:					\
-		__ustl(val, __gu_p);		\
-		break;				\
-	case 8:					\
-		__ustq(val, __gu_p);		\
-		break;				\
-	default:				\
-	    	bad_unaligned_access_length();	\
-	};					\
+#define put_unaligned(val, ptr)					\
+do {								\
+	struct __packed {					\
+		typeof(*(ptr)) __v;				\
+	} *__p = (void *) (ptr);				\
+	__p->__v = (val);					\
 } while(0)
 
-#endif /* _ASM_GENERIC_UNALIGNED_H */
+#endif /* __ASM_GENERIC_UNALIGNED_H */
