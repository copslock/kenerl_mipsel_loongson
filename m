Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 11:56:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44813 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010626AbbAPKwTBZJR4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:52:19 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 34B2139152E5B
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:52:11 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:52:13 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:52:12 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: [PATCH RFC v2 20/70] MIPS: asm: cmpxchg: Update ISA constraints for MIPS R6 support
Date:   Fri, 16 Jan 2015 10:48:59 +0000
Message-ID: <1421405389-15512-21-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45164
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

MIPS R6 changed the opcodes for LL/SC instructions so we need to set
the correct ISA.

Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cmpxchg.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 28b1edf19501..1ff5e5da8c8e 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -11,6 +11,7 @@
 #include <linux/bug.h>
 #include <linux/irqflags.h>
 #include <asm/compiler.h>
+#include <asm/asm.h>
 #include <asm/war.h>
 
 static inline unsigned long __xchg_u32(volatile int * m, unsigned int val)
@@ -39,11 +40,11 @@ static inline unsigned long __xchg_u32(volatile int * m, unsigned int val)
 
 		do {
 			__asm__ __volatile__(
-			"	.set	arch=r4000			\n"
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 			"	ll	%0, %3		# xchg_u32	\n"
 			"	.set	mips0				\n"
 			"	move	%2, %z4				\n"
-			"	.set	arch=r4000			\n"
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 			"	sc	%2, %1				\n"
 			"	.set	mips0				\n"
 			: "=&r" (retval), "=" GCC_OFF12_ASM() (*m),
@@ -90,7 +91,7 @@ static inline __u64 __xchg_u64(volatile __u64 * m, __u64 val)
 
 		do {
 			__asm__ __volatile__(
-			"	.set	arch=r4000			\n"
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 			"	lld	%0, %3		# xchg_u64	\n"
 			"	move	%2, %z4				\n"
 			"	scd	%2, %1				\n"
@@ -165,12 +166,12 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
-		"	.set	arch=r4000			\n"	\
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
 		"1:	" ld "	%0, %2		# __cmpxchg_asm \n"	\
 		"	bne	%0, %z3, 2f			\n"	\
 		"	.set	mips0				\n"	\
 		"	move	$1, %z4				\n"	\
-		"	.set	arch=r4000			\n"	\
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
 		"	" st "	$1, %1				\n"	\
 		"	beqz	$1, 1b				\n"	\
 		"	.set	pop				\n"	\
-- 
2.2.1
