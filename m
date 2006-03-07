Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2006 18:00:51 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:50382 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133625AbWCGSAm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2006 18:00:42 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k27I988H016405;
	Tue, 7 Mar 2006 18:09:08 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k27I97vs016404;
	Tue, 7 Mar 2006 18:09:07 GMT
Date:	Tue, 7 Mar 2006 18:09:07 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64bit unaligned access on 32bit kernel
Message-ID: <20060307180907.GA13577@linux-mips.org>
References: <20050830104056.GA4710@linux-mips.org> <20060306.203218.69025300.nemoto@toshiba-tops.co.jp> <20060306170552.0aab29c5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306170552.0aab29c5.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 06, 2006 at 05:05:52PM -0800, Andrew Morton wrote:

> I worry about what impact that change might have on code generation. 
> Hopefully none, if gcc is good enough.
> 
> But I cannot think of a better fix.

Below's fix results in exactly the same code size on all compilers and
configurations I've tested it.

I also have another more elegant fix which as a side effect makes
get_unaligned work for arbitrary data types but it that one results in a
slight code bloat:

gcc 4.1.0 ip22 64-bit
   text    data     bss     dec     hex filename
2717213  337920  167968 3223101  312e3d vmlinux
2717277  337920  167968 3223165  312e7d vmlinux         unaligned-4.patch

  Ralf


Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 4dc8ddb..9a63564 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -26,35 +26,13 @@
  * the linker will alert us to the problem via an unresolved reference
  * error.
  */
-extern void bad_unaligned_access_length(void) __attribute__((noreturn));
+extern int bad_unaligned_access_length(void) __attribute__((noreturn));
 
 struct __una_u64 { __u64 x __attribute__((packed)); };
 struct __una_u32 { __u32 x __attribute__((packed)); };
 struct __una_u16 { __u16 x __attribute__((packed)); };
 
 /*
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
  * Elemental unaligned stores 
  */
 
@@ -76,26 +54,16 @@ static inline void __ustw(__u16 val, __u
 	ptr->x = val;
 }
 
-#define __get_unaligned(ptr, size) ({		\
-	const void *__gu_p = ptr;		\
-	__typeof__(*(ptr)) val;			\
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
-	val;					\
+#define __get_unaligned(ptr, size)						\
+({										\
+	const void *__gu_p = ptr;						\
+	int __sz = size;							\
+										\
+	((__sz == 1) ? (__typeof__(*(ptr)))*(const __u8 *)__gu_p		\
+	: ((__sz == 2) ? (__typeof__(*(ptr)))((struct __una_u16 *)__gu_p)->x	\
+	: ((__sz == 4) ? (__typeof__(*(ptr)))((struct __una_u32 *)__gu_p)->x	\
+	: ((__sz == 8) ? (__typeof__(*(ptr)))((struct __una_u64 *)__gu_p)->x	\
+	: bad_unaligned_access_length()))));					\
 })
 
 #define __put_unaligned(val, ptr, size)		\
