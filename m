Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jun 2017 02:29:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35173 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993949AbdFJA2xaUOdt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jun 2017 02:28:53 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6716E642E877D;
        Sat, 10 Jun 2017 01:28:45 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 10 Jun 2017 01:28:46
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 06/11] MIPS: cmpxchg: Implement __cmpxchg() as a function
Date:   Fri, 9 Jun 2017 17:26:38 -0700
Message-ID: <20170610002644.8434-7-paul.burton@imgtec.com>
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
X-archive-position: 58395
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

Replace the macro definition of __cmpxchg() with an inline function,
which is easier to read & modify. The cmpxchg() & cmpxchg_local() macros
are adjusted to call the new __cmpxchg() function.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/cmpxchg.h | 59 ++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index e9c1e97bc29d..516cb66f066b 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -34,7 +34,7 @@
  *
  * - Get an error at link-time due to the call to the missing function.
  */
-extern void __cmpxchg_called_with_bad_pointer(void)
+extern unsigned long __cmpxchg_called_with_bad_pointer(void)
 	__compiletime_error("Bad argument size for cmpxchg");
 extern unsigned long __xchg_called_with_bad_pointer(void)
 	__compiletime_error("Bad argument size for xchg");
@@ -137,38 +137,43 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 	__ret;								\
 })
 
-#define __cmpxchg(ptr, old, new, pre_barrier, post_barrier)		\
+static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
+				      unsigned long new, unsigned int size)
+{
+	switch (size) {
+	case 4:
+		return __cmpxchg_asm("ll", "sc", (volatile u32 *)ptr, old, new);
+
+	case 8:
+		/* lld/scd are only available for MIPS64 */
+		if (!IS_ENABLED(CONFIG_64BIT))
+			return __cmpxchg_called_with_bad_pointer();
+
+		return __cmpxchg_asm("lld", "scd", (volatile u64 *)ptr, old, new);
+
+	default:
+		return __cmpxchg_called_with_bad_pointer();
+	}
+}
+
+#define cmpxchg_local(ptr, old, new)					\
+	((__typeof__(*(ptr)))						\
+		__cmpxchg((ptr),					\
+			  (unsigned long)(__typeof__(*(ptr)))(old),	\
+			  (unsigned long)(__typeof__(*(ptr)))(new),	\
+			  sizeof(*(ptr))))
+
+#define cmpxchg(ptr, old, new)						\
 ({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(*(ptr)) __old = (old);				\
-	__typeof__(*(ptr)) __new = (new);				\
-	__typeof__(*(ptr)) __res = 0;					\
-									\
-	pre_barrier;							\
-									\
-	switch (sizeof(*(__ptr))) {					\
-	case 4:								\
-		__res = __cmpxchg_asm("ll", "sc", __ptr, __old, __new); \
-		break;							\
-	case 8:								\
-		if (sizeof(long) == 8) {				\
-			__res = __cmpxchg_asm("lld", "scd", __ptr,	\
-					   __old, __new);		\
-			break;						\
-		}							\
-	default:							\
-		__cmpxchg_called_with_bad_pointer();			\
-		break;							\
-	}								\
+	__typeof__(*(ptr)) __res;					\
 									\
-	post_barrier;							\
+	smp_mb__before_llsc();						\
+	__res = cmpxchg_local((ptr), (old), (new));			\
+	smp_llsc_mb();							\
 									\
 	__res;								\
 })
 
-#define cmpxchg(ptr, old, new)		__cmpxchg(ptr, old, new, smp_mb__before_llsc(), smp_llsc_mb())
-#define cmpxchg_local(ptr, old, new)	__cmpxchg(ptr, old, new, , )
-
 #ifdef CONFIG_64BIT
 #define cmpxchg64_local(ptr, o, n)					\
   ({									\
-- 
2.13.1
