Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 14:25:52 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45245 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
	id S1492387AbZKXNZp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Nov 2009 14:25:45 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAODQ2iB028082;
	Tue, 24 Nov 2009 13:26:02 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAODQ1Y3028080;
	Tue, 24 Nov 2009 13:26:01 GMT
Date:	Tue, 24 Nov 2009 13:26:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Imre Kaloz <kaloz@openwrt.org>
Cc:	nbd@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] use __always_inline for __xchg
Message-ID: <20091124132601.GA27951@linux-mips.org>
References: <op.sldiliqr2s3iss@richese>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.sldiliqr2s3iss@richese>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 29, 2005 at 05:54:44PM +0100, Imre Kaloz wrote:

> The following patch changes inline for __xchg to __always_inline in  
> include/asm-mips/system.h, following the changes in git. Without this  
> change linking the kernel fails.
>
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> Signed-off-by: Felix Fietkau <nbd@openwrt.org>

Imre just pointed me at this antique patch again saying it was still needed.
Back then I ditched it because I couldn't see what the problem it was
trying to fix was - but after a little brainstorming it got obvious.

Now I don't like __always_inline which forces the optimizer to do things
which may not really be what we want, for example when building with -Os
so I found a different fix using BUILD_BUG_ON().  Patch below.

Cheers,

  Ralf

From: Ralf Baechle <ralf@linux-mips.org>

MIPS: Fix build error if __xchg() is not getting inlined.

If __xchg() is not getting inlined the outline version of the function
will have a reference to __xchg_called_with_bad_pointer() which does not
exist remaining.  Fixed by using BUILD_BUG_ON() xchg() to check for
allowable operand sizes.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/include/asm/system.h b/arch/mips/include/asm/system.h
index fcf5f98..587a48a 100644
--- a/arch/mips/include/asm/system.h
+++ b/arch/mips/include/asm/system.h
@@ -193,10 +193,6 @@ extern __u64 __xchg_u64_unsupported_on_32bit_kernels(volatile __u64 * m, __u64 v
 #define __xchg_u64 __xchg_u64_unsupported_on_32bit_kernels
 #endif
 
-/* This function doesn't exist, so you'll get a linker error
-   if something tries to do an invalid xchg().  */
-extern void __xchg_called_with_bad_pointer(void);
-
 static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int size)
 {
 	switch (size) {
@@ -205,11 +201,17 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 	case 8:
 		return __xchg_u64(ptr, x);
 	}
-	__xchg_called_with_bad_pointer();
+
 	return x;
 }
 
-#define xchg(ptr, x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x), (ptr), sizeof(*(ptr))))
+#define xchg(ptr, x)							\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) & ~0xc);				\
+									\
+	((__typeof__(*(ptr)))						\
+		__xchg((unsigned long)(x), (ptr), sizeof(*(ptr))));	\
+})
 
 extern void set_handler(unsigned long offset, void *addr, unsigned long len);
 extern void set_uncached_handler(unsigned long offset, void *addr, unsigned long len);
