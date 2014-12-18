Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:17:04 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4398 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009165AbaLRPL64w4Ex (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:11:58 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E22F2108509E7
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:11:48 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:11:51 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:11:50 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: [PATCH RFC 21/67] MIPS: asm: bitops: Update asm and ISA constrains for MIPS R6 support
Date:   Thu, 18 Dec 2014 15:09:30 +0000
Message-ID: <1418915416-3196-22-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

MIPS R6 changed the opcodes for LL/SC instructions and reduced the
offset field to 9-bits. This has some undesired effects with the "m"
constrain since it implies a 16-bit immediate. As a result of which,
add a register ("r") constrain as well to make sure the entire address
is loaded to a register before the LL/SC operations. Also use macro
to set the appropriate ISA for the asm blocks

Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/bitops.h | 91 +++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index bae6b0fa8ab5..7036a228b6cb 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -15,6 +15,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <asm/asm.h>
 #include <asm/barrier.h>
 #include <asm/byteorder.h>		/* sigh ... */
 #include <asm/cpu-features.h>
@@ -80,27 +81,27 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (1UL << bit), "m" (*m));
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
 		do {
 			__asm__ __volatile__(
-			"	" __LL "%0, %1		# set_bit	\n"
+			"	" __LL "%0, 0(%4)	# set_bit	\n"
 			"	" __INS "%0, %3, %2, 1			\n"
-			"	" __SC "%0, %1				\n"
+			"	" __SC "%0, 0(%4)			\n"
 			: "=&r" (temp), "+m" (*m)
-			: "ir" (bit), "r" (~0));
+			: "ir" (bit), "r" (~0), "r" (m));
 		} while (unlikely(!temp));
-#endif /* CONFIG_CPU_MIPSR2 */
+#endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 	} else if (kernel_uses_llsc) {
 		do {
 			__asm__ __volatile__(
-			"	.set	arch=r4000			\n"
-			"	" __LL "%0, %1		# set_bit	\n"
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			"	" __LL "%0, 0(%3)	# set_bit	\n"
 			"	or	%0, %2				\n"
-			"	" __SC	"%0, %1				\n"
+			"	" __SC	"%0, 0(%3)			\n"
 			"	.set	mips0				\n"
 			: "=&r" (temp), "+m" (*m)
-			: "ir" (1UL << bit));
+			: "ir" (1UL << bit), "r" (m));
 		} while (unlikely(!temp));
 	} else
 		__mips_set_bit(nr, addr);
@@ -132,27 +133,27 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 		"	.set	mips0					\n"
 		: "=&r" (temp), "+m" (*m)
 		: "ir" (~(1UL << bit)));
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
 		do {
 			__asm__ __volatile__(
-			"	" __LL "%0, %1		# clear_bit	\n"
+			"	" __LL "%0, 0(%3)	# clear_bit	\n"
 			"	" __INS "%0, $0, %2, 1			\n"
-			"	" __SC "%0, %1				\n"
+			"	" __SC "%0, 0(%3)			\n"
 			: "=&r" (temp), "+m" (*m)
-			: "ir" (bit));
+			: "ir" (bit), "r" (m));
 		} while (unlikely(!temp));
-#endif /* CONFIG_CPU_MIPSR2 */
+#endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 	} else if (kernel_uses_llsc) {
 		do {
 			__asm__ __volatile__(
-			"	.set	arch=r4000			\n"
-			"	" __LL "%0, %1		# clear_bit	\n"
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			"	" __LL "%0, 0(%3)	# clear_bit	\n"
 			"	and	%0, %2				\n"
-			"	" __SC "%0, %1				\n"
+			"	" __SC "%0, 0(%3)			\n"
 			"	.set	mips0				\n"
 			: "=&r" (temp), "+m" (*m)
-			: "ir" (~(1UL << bit)));
+			: "ir" (~(1UL << bit)), "r" (m));
 		} while (unlikely(!temp));
 	} else
 		__mips_clear_bit(nr, addr);
@@ -204,13 +205,13 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 
 		do {
 			__asm__ __volatile__(
-			"	.set	arch=r4000			\n"
-			"	" __LL "%0, %1		# change_bit	\n"
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			"	" __LL "%0, 0(%3)	# change_bit	\n"
 			"	xor	%0, %2				\n"
-			"	" __SC	"%0, %1				\n"
+			"	" __SC	"%0, 0(%3)			\n"
 			"	.set	mips0				\n"
 			: "=&r" (temp), "+m" (*m)
-			: "ir" (1UL << bit));
+			: "ir" (1UL << bit), "r" (m));
 		} while (unlikely(!temp));
 	} else
 		__mips_change_bit(nr, addr);
@@ -253,13 +254,13 @@ static inline int test_and_set_bit(unsigned long nr,
 
 		do {
 			__asm__ __volatile__(
-			"	.set	arch=r4000			\n"
-			"	" __LL "%0, %1	# test_and_set_bit	\n"
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			"	" __LL "%0, 0(%4)# test_and_set_bit	\n"
 			"	or	%2, %0, %3			\n"
-			"	" __SC	"%2, %1				\n"
+			"	" __SC	"%2, 0(%4)			\n"
 			"	.set	mips0				\n"
 			: "=&r" (temp), "+m" (*m), "=&r" (res)
-			: "r" (1UL << bit)
+			: "r" (1UL << bit), "r" (m)
 			: "memory");
 		} while (unlikely(!res));
 
@@ -307,13 +308,13 @@ static inline int test_and_set_bit_lock(unsigned long nr,
 
 		do {
 			__asm__ __volatile__(
-			"	.set	arch=r4000			\n"
-			"	" __LL "%0, %1	# test_and_set_bit	\n"
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			"	" __LL "%0, 0(%4)# test_and_set_bit	\n"
 			"	or	%2, %0, %3			\n"
-			"	" __SC	"%2, %1				\n"
+			"	" __SC	"%2, 0(%4)			\n"
 			"	.set	mips0				\n"
 			: "=&r" (temp), "+m" (*m), "=&r" (res)
-			: "r" (1UL << bit)
+			: "r" (1UL << bit), "r" (m)
 			: "memory");
 		} while (unlikely(!res));
 
@@ -357,19 +358,19 @@ static inline int test_and_clear_bit(unsigned long nr,
 		: "=&r" (temp), "+m" (*m), "=&r" (res)
 		: "r" (1UL << bit)
 		: "memory");
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	} else if (kernel_uses_llsc && __builtin_constant_p(nr)) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
 		do {
 			__asm__ __volatile__(
-			"	" __LL	"%0, %1 # test_and_clear_bit	\n"
+			"	" __LL	"%0, 0(%4)# test_and_clear_bit	\n"
 			"	" __EXT "%2, %0, %3, 1			\n"
 			"	" __INS "%0, $0, %3, 1			\n"
-			"	" __SC	"%0, %1				\n"
+			"	" __SC	"%0, 0(%4)			\n"
 			: "=&r" (temp), "+m" (*m), "=&r" (res)
-			: "ir" (bit)
+			: "ir" (bit), "r" (m)
 			: "memory");
 		} while (unlikely(!temp));
 #endif
@@ -379,14 +380,14 @@ static inline int test_and_clear_bit(unsigned long nr,
 
 		do {
 			__asm__ __volatile__(
-			"	.set	arch=r4000			\n"
-			"	" __LL	"%0, %1 # test_and_clear_bit	\n"
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			"	" __LL	"%0, 0(%4) # test_and_clear_bit	\n"
 			"	or	%2, %0, %3			\n"
 			"	xor	%2, %3				\n"
-			"	" __SC	"%2, %1				\n"
+			"	" __SC	"%2, 0(%4)			\n"
 			"	.set	mips0				\n"
 			: "=&r" (temp), "+m" (*m), "=&r" (res)
-			: "r" (1UL << bit)
+			: "r" (1UL << bit), "r" (m)
 			: "memory");
 		} while (unlikely(!res));
 
@@ -436,13 +437,13 @@ static inline int test_and_change_bit(unsigned long nr,
 
 		do {
 			__asm__ __volatile__(
-			"	.set	arch=r4000			\n"
-			"	" __LL	"%0, %1 # test_and_change_bit	\n"
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			"	" __LL	"%0, 0(%4)# test_and_change_bit	\n"
 			"	xor	%2, %0, %3			\n"
-			"	" __SC	"\t%2, %1			\n"
+			"	" __SC	"%2, 0(%4)			\n"
 			"	.set	mips0				\n"
 			: "=&r" (temp), "+m" (*m), "=&r" (res)
-			: "r" (1UL << bit)
+			: "r" (1UL << bit), "r" (m)
 			: "memory");
 		} while (unlikely(!res));
 
@@ -484,7 +485,7 @@ static inline unsigned long __fls(unsigned long word)
 	    __builtin_constant_p(cpu_has_clo_clz) && cpu_has_clo_clz) {
 		__asm__(
 		"	.set	push					\n"
-		"	.set	mips32					\n"
+		"	.set	"MIPS_ISA_LEVEL"			\n"
 		"	clz	%0, %1					\n"
 		"	.set	pop					\n"
 		: "=r" (num)
@@ -497,7 +498,7 @@ static inline unsigned long __fls(unsigned long word)
 	    __builtin_constant_p(cpu_has_mips64) && cpu_has_mips64) {
 		__asm__(
 		"	.set	push					\n"
-		"	.set	mips64					\n"
+		"	.set	"MIPS_ISA_LEVEL"			\n"
 		"	dclz	%0, %1					\n"
 		"	.set	pop					\n"
 		: "=r" (num)
@@ -561,7 +562,7 @@ static inline int fls(int x)
 	if (__builtin_constant_p(cpu_has_clo_clz) && cpu_has_clo_clz) {
 		__asm__(
 		"	.set	push					\n"
-		"	.set	mips32					\n"
+		"	.set	"MIPS_ISA_LEVEL"			\n"
 		"	clz	%0, %1					\n"
 		"	.set	pop					\n"
 		: "=r" (x)
-- 
2.2.0
