Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:16:29 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44975 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009163AbaLRPLzyFkGa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:11:55 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D01A7F3BD0BA6
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:11:46 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:11:50 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:11:49 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: [PATCH RFC 20/67] MIPS: asm: cmpxchg: Update asm and ISA constrains for MIPS R6 support
Date:   Thu, 18 Dec 2014 15:09:29 +0000
Message-ID: <1418915416-3196-21-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 44755
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
 arch/mips/include/asm/cmpxchg.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index eefcaa363a87..86a76f125bc8 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -38,15 +38,15 @@ static inline unsigned long __xchg_u32(volatile int * m, unsigned int val)
 
 		do {
 			__asm__ __volatile__(
-			"	.set	arch=r4000			\n"
-			"	ll	%0, %3		# xchg_u32	\n"
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			"	ll	%0, 0(%3)	# xchg_u32	\n"
 			"	.set	mips0				\n"
 			"	move	%2, %z4				\n"
-			"	.set	arch=r4000			\n"
-			"	sc	%2, %1				\n"
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			"	sc	%2, 0(%3)			\n"
 			"	.set	mips0				\n"
 			: "=&r" (retval), "=m" (*m), "=&r" (dummy)
-			: "R" (*m), "Jr" (val)
+			: "r" (m), "Jr" (val)
 			: "memory");
 		} while (unlikely(!dummy));
 	} else {
@@ -88,13 +88,13 @@ static inline __u64 __xchg_u64(volatile __u64 * m, __u64 val)
 
 		do {
 			__asm__ __volatile__(
-			"	.set	arch=r4000			\n"
-			"	lld	%0, %3		# xchg_u64	\n"
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			"	lld	%0, 0(%3)	# xchg_u64	\n"
 			"	move	%2, %z4				\n"
-			"	scd	%2, %1				\n"
+			"	scd	%2, 0(%3)			\n"
 			"	.set	mips0				\n"
 			: "=&r" (retval), "=m" (*m), "=&r" (dummy)
-			: "R" (*m), "Jr" (val)
+			: "r" (m), "Jr" (val)
 			: "memory");
 		} while (unlikely(!dummy));
 	} else {
@@ -162,18 +162,18 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
-		"	.set	arch=r4000			\n"	\
-		"1:	" ld "	%0, %2		# __cmpxchg_asm \n"	\
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
+		"1:	" ld "	%0, 0(%2)	# __cmpxchg_asm \n"	\
 		"	bne	%0, %z3, 2f			\n"	\
 		"	.set	mips0				\n"	\
 		"	move	$1, %z4				\n"	\
-		"	.set	arch=r4000			\n"	\
-		"	" st "	$1, %1				\n"	\
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
+		"	" st "	$1, 0(%2)			\n"	\
 		"	beqz	$1, 1b				\n"	\
 		"	.set	pop				\n"	\
 		"2:						\n"	\
 		: "=&r" (__ret), "=R" (*m)				\
-		: "R" (*m), "Jr" (old), "Jr" (new)			\
+		: "r" (m), "Jr" (old), "Jr" (new)			\
 		: "memory");						\
 	} else {							\
 		unsigned long __flags;					\
-- 
2.2.0
