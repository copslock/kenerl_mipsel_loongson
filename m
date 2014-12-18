Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:16:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35780 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009166AbaLRPL65i3xz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:11:58 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6B11DC59CF3E9
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:11:49 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:11:52 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:11:52 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: [PATCH RFC 22/67] MIPS: asm: futex: Update asm and ISA constrains for MIPS R6 support
Date:   Thu, 18 Dec 2014 15:09:31 +0000
Message-ID: <1418915416-3196-23-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 44756
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
 arch/mips/include/asm/futex.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index 194cda0396a3..8867726b85e2 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -49,12 +49,12 @@
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
-		"	.set	arch=r4000			\n"	\
-		"1:	"user_ll("%1", "%4")" # __futex_atomic_op\n"	\
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
+		"1:	"user_ll("%1", "0(%4)")" # __futex_atomic_op\n"	\
 		"	.set	mips0				\n"	\
 		"	" insn	"				\n"	\
-		"	.set	arch=r4000			\n"	\
-		"2:	"user_sc("$1", "%2")"			\n"	\
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
+		"2:	"user_sc("$1", "0(%4)")"		\n"	\
 		"	beqz	$1, 1b				\n"	\
 		__WEAK_LLSC_MB						\
 		"3:						\n"	\
@@ -68,8 +68,8 @@
 		"	"__UA_ADDR "\t1b, 4b			\n"	\
 		"	"__UA_ADDR "\t2b, 4b			\n"	\
 		"	.previous				\n"	\
-		: "=r" (ret), "=&r" (oldval), "=R" (*uaddr)		\
-		: "0" (0), "R" (*uaddr), "Jr" (oparg), "i" (-EFAULT)	\
+		: "=r" (ret), "=&r" (oldval), "+m" (uaddr)		\
+		: "0" (0), "r" (uaddr), "Jr" (oparg), "i" (-EFAULT)	\
 		: "memory");						\
 	} else								\
 		ret = -ENOSYS;						\
@@ -174,13 +174,13 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"# futex_atomic_cmpxchg_inatomic			\n"
 		"	.set	push					\n"
 		"	.set	noat					\n"
-		"	.set	arch=r4000				\n"
-		"1:	"user_ll("%1", "%3")"				\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
+		"1:	"user_ll("%1", "0(%3)")"			\n"
 		"	bne	%1, %z4, 3f				\n"
 		"	.set	mips0					\n"
 		"	move	$1, %z5					\n"
-		"	.set	arch=r4000				\n"
-		"2:	"user_sc("$1", "%2")"				\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
+		"2:	"user_sc("$1", "0(%3)")"			\n"
 		"	beqz	$1, 1b					\n"
 		__WEAK_LLSC_MB
 		"3:							\n"
@@ -193,8 +193,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"	"__UA_ADDR "\t1b, 4b				\n"
 		"	"__UA_ADDR "\t2b, 4b				\n"
 		"	.previous					\n"
-		: "+r" (ret), "=&r" (val), "=R" (*uaddr)
-		: "R" (*uaddr), "Jr" (oldval), "Jr" (newval), "i" (-EFAULT)
+		: "+r" (ret), "=&r" (val), "+m" (uaddr)
+		: "r" (uaddr), "Jr" (oldval), "Jr" (newval), "i" (-EFAULT)
 		: "memory");
 	} else
 		return -ENOSYS;
-- 
2.2.0
