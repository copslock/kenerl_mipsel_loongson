Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jun 2017 02:29:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56697 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993958AbdFJA2fQbN5t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jun 2017 02:28:35 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTP id 8D091618713D0;
        Sat, 10 Jun 2017 01:28:27 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 10 Jun 2017 01:28:29
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 05/11] MIPS: cmpxchg: Drop __xchg_u{32,64} functions
Date:   Fri, 9 Jun 2017 17:26:37 -0700
Message-ID: <20170610002644.8434-6-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170610002644.8434-1-paul.burton@imgtec.com>
References: <20170610002644.8434-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The __xchg_u32() & __xchg_u64() functions now add very little value.
This patch therefore removes them, by:

  - Moving memory barriers out of them & into xchg(), which also removes
    the duplication & readies us to support xchg_relaxed() if we wish to.

  - Calling __xchg_asm() directly from __xchg().

  - Performing the check for CONFIG_64BIT being enabled in the size=8
    case of __xchg().

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/cmpxchg.h | 48 +++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 31 deletions(-)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index fe652c3e5d8c..e9c1e97bc29d 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -70,40 +70,18 @@ extern unsigned long __xchg_called_with_bad_pointer(void)
 	__ret;								\
 })
 
-static inline unsigned long __xchg_u32(volatile int * m, unsigned int val)
-{
-	__u32 retval;
-
-	smp_mb__before_llsc();
-	retval = __xchg_asm("ll", "sc", m, val);
-	smp_llsc_mb();
-
-	return retval;
-}
-
-#ifdef CONFIG_64BIT
-static inline __u64 __xchg_u64(volatile __u64 * m, __u64 val)
-{
-	__u64 retval;
-
-	smp_mb__before_llsc();
-	retval = __xchg_asm("lld", "scd", m, val);
-	smp_llsc_mb();
-
-	return retval;
-}
-#else
-extern __u64 __xchg_u64_unsupported_on_32bit_kernels(volatile __u64 * m, __u64 val);
-#define __xchg_u64 __xchg_u64_unsupported_on_32bit_kernels
-#endif
-
 static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int size)
 {
 	switch (size) {
 	case 4:
-		return __xchg_u32(ptr, x);
+		return __xchg_asm("ll", "sc", (volatile u32 *)ptr, x);
+
 	case 8:
-		return __xchg_u64(ptr, x);
+		if (!IS_ENABLED(CONFIG_64BIT))
+			return __xchg_called_with_bad_pointer();
+
+		return __xchg_asm("lld", "scd", (volatile u64 *)ptr, x);
+
 	default:
 		return __xchg_called_with_bad_pointer();
 	}
@@ -111,10 +89,18 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 
 #define xchg(ptr, x)							\
 ({									\
+	__typeof__(*(ptr)) __res;					\
+									\
 	BUILD_BUG_ON(sizeof(*(ptr)) & ~0xc);				\
 									\
-	((__typeof__(*(ptr)))						\
-		__xchg((unsigned long)(x), (ptr), sizeof(*(ptr))));	\
+	smp_mb__before_llsc();						\
+									\
+	__res = (__typeof__(*(ptr)))					\
+		__xchg((unsigned long)(x), (ptr), sizeof(*(ptr)));	\
+									\
+	smp_llsc_mb();							\
+									\
+	__res;								\
 })
 
 #define __cmpxchg_asm(ld, st, m, old, new)				\
-- 
2.13.1
