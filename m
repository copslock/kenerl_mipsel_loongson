Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:16:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37552 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009162AbaLRPLycJ6zH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:11:54 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9E2D385BEDD83
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:11:45 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:11:48 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:11:47 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: [PATCH RFC 19/67] MIPS: asm: atomic: Update asm and ISA constrains for MIPS R6 support
Date:   Thu, 18 Dec 2014 15:09:28 +0000
Message-ID: <1418915416-3196-20-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 44754
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
 arch/mips/include/asm/atomic.h | 50 +++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 6dd6bfc607e9..8669e0ec97e3 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -60,13 +60,13 @@ static __inline__ void atomic_##op(int i, atomic_t * v)				\
 										\
 		do {								\
 			__asm__ __volatile__(					\
-			"	.set	arch=r4000			\n"	\
-			"	ll	%0, %1		# atomic_" #op "\n"	\
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
+			"	ll	%0, 0(%3)	# atomic_" #op "\n"	\
 			"	" #asm_op " %0, %2			\n"	\
-			"	sc	%0, %1				\n"	\
+			"	sc	%0, 0(%3)			\n"	\
 			"	.set	mips0				\n"	\
 			: "=&r" (temp), "+m" (v->counter)			\
-			: "Ir" (i));						\
+			: "Ir" (i), "r" (&v->counter));				\
 		} while (unlikely(!temp));					\
 	} else {								\
 		unsigned long flags;						\
@@ -102,13 +102,13 @@ static __inline__ int atomic_##op##_return(int i, atomic_t * v)			\
 										\
 		do {								\
 			__asm__ __volatile__(					\
-			"	.set	arch=r4000			\n"	\
-			"	ll	%1, %2	# atomic_" #op "_return	\n"	\
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
+			"	ll	%1, 0(%4) # atomic_" #op "_return\n"	\
 			"	" #asm_op " %0, %1, %3			\n"	\
-			"	sc	%0, %2				\n"	\
+			"	sc	%0, 0(%4)			\n"	\
 			"	.set	mips0				\n"	\
 			: "=&r" (result), "=&r" (temp), "+m" (v->counter)	\
-			: "Ir" (i));						\
+			: "Ir" (i), "r" (&v->counter));				\
 		} while (unlikely(!result));					\
 										\
 		result = temp; result c_op i;					\
@@ -174,11 +174,11 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 		int temp;
 
 		__asm__ __volatile__(
-		"	.set	arch=r4000				\n"
-		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
+		"1:	ll	%1, 0(%4)	# atomic_sub_if_positive\n"
 		"	subu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
-		"	sc	%0, %2					\n"
+		"	sc	%0, 0(%4)				\n"
 		"	.set	noreorder				\n"
 		"	beqz	%0, 1b					\n"
 		"	 subu	%0, %1, %3				\n"
@@ -186,7 +186,7 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 		"1:							\n"
 		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "+m" (v->counter)
-		: "Ir" (i));
+		: "Ir" (i), "r" (&v->counter));
 	} else {
 		unsigned long flags;
 
@@ -335,13 +335,13 @@ static __inline__ void atomic64_##op(long i, atomic64_t * v)			\
 										\
 		do {								\
 			__asm__ __volatile__(					\
-			"	.set	arch=r4000			\n"	\
-			"	lld	%0, %1		# atomic64_" #op "\n"	\
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
+			"	lld	%0, 0(%3)     # atomic64_" #op "\n"	\
 			"	" #asm_op " %0, %2			\n"	\
-			"	scd	%0, %1				\n"	\
+			"	scd	%0, 0(%3)			\n"	\
 			"	.set	mips0				\n"	\
 			: "=&r" (temp), "+m" (v->counter)			\
-			: "Ir" (i));						\
+			: "Ir" (i), "r" (&v->counter));				\
 		} while (unlikely(!temp));					\
 	} else {								\
 		unsigned long flags;						\
@@ -377,13 +377,13 @@ static __inline__ long atomic64_##op##_return(long i, atomic64_t * v)		\
 										\
 		do {								\
 			__asm__ __volatile__(					\
-			"	.set	arch=r4000			\n"	\
-			"	lld	%1, %2	# atomic64_" #op "_return\n"	\
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
+			"	lld	%1, 0(%4)# atomic64_" #op "_return\n"	\
 			"	" #asm_op " %0, %1, %3			\n"	\
-			"	scd	%0, %2				\n"	\
+			"	scd	%0, 0(%4)			\n"	\
 			"	.set	mips0				\n"	\
-			: "=&r" (result), "=&r" (temp), "=m" (v->counter)	\
-			: "Ir" (i), "m" (v->counter)				\
+			: "=&r" (result), "=&r" (temp), "+m" (v->counter)	\
+			: "Ir" (i), "r" (&v->counter)				\
 			: "memory");						\
 		} while (unlikely(!result));					\
 										\
@@ -450,11 +450,11 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 		long temp;
 
 		__asm__ __volatile__(
-		"	.set	arch=r4000				\n"
-		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
+		"1:	lld	%1, 0(%4)	# atomic64_sub_if_positive\n"
 		"	dsubu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
-		"	scd	%0, %2					\n"
+		"	scd	%0, 0(%4)				\n"
 		"	.set	noreorder				\n"
 		"	beqz	%0, 1b					\n"
 		"	 dsubu	%0, %1, %3				\n"
@@ -462,7 +462,7 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 		"1:							\n"
 		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "+m" (v->counter)
-		: "Ir" (i));
+		: "Ir" (i), "r"(&v->counter));
 	} else {
 		unsigned long flags;
 
-- 
2.2.0
