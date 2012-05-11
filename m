Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 08:35:28 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:34404 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903557Ab2EKGfX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 08:35:23 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SSjRd-0001wj-18; Fri, 11 May 2012 01:35:17 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH] MIPS: Work-around microMIPS GNU assembler bug.
Date:   Fri, 11 May 2012 01:35:13 -0500
Message-Id: <1336718113-1243-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Work-around a microMIPS GNU assembler bug that thinks some
instructions are data, when they actually are not.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/futex.h   |    4 ++++
 arch/mips/include/asm/paccess.h |    2 ++
 arch/mips/include/asm/uaccess.h |   14 ++++++++++++--
 arch/mips/kernel/scall32-o32.S  |    4 ++++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index 6ebf173..007adca 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -31,6 +31,7 @@
 		"	beqzl	$1, 1b				\n"	\
 		__WEAK_LLSC_MB						\
 		"3:						\n"	\
+		"	.insn					\n"	\
 		"	.set	pop				\n"	\
 		"	.set	mips0				\n"	\
 		"	.section .fixup,\"ax\"			\n"	\
@@ -57,6 +58,7 @@
 		"	beqz	$1, 1b				\n"	\
 		__WEAK_LLSC_MB						\
 		"3:						\n"	\
+		"	.insn					\n"	\
 		"	.set	pop				\n"	\
 		"	.set	mips0				\n"	\
 		"	.section .fixup,\"ax\"			\n"	\
@@ -156,6 +158,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"	beqzl	$1, 1b					\n"
 		__WEAK_LLSC_MB
 		"3:							\n"
+		"	.insn						\n"
 		"	.set	pop					\n"
 		"	.section .fixup,\"ax\"				\n"
 		"4:	li	%0, %6					\n"
@@ -183,6 +186,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"	beqz	$1, 1b					\n"
 		__WEAK_LLSC_MB
 		"3:							\n"
+		"	.insn						\n"
 		"	.set	pop					\n"
 		"	.section .fixup,\"ax\"				\n"
 		"4:	li	%0, %6					\n"
diff --git a/arch/mips/include/asm/paccess.h b/arch/mips/include/asm/paccess.h
index 9ce5a1e..f479742 100644
--- a/arch/mips/include/asm/paccess.h
+++ b/arch/mips/include/asm/paccess.h
@@ -56,6 +56,7 @@ struct __large_pstruct { unsigned long buf[100]; };
 	"1:\t" insn "\t%1,%2\n\t"					\
 	"move\t%0,$0\n"							\
 	"2:\n\t"							\
+	".insn\n\t"							\
 	".section\t.fixup,\"ax\"\n"					\
 	"3:\tli\t%0,%3\n\t"						\
 	"move\t%1,$0\n\t"						\
@@ -94,6 +95,7 @@ extern void __get_dbe_unknown(void);
 	"1:\t" insn "\t%1,%2\n\t"					\
 	"move\t%0,$0\n"							\
 	"2:\n\t"							\
+	".insn\n\t"							\
 	".section\t.fixup,\"ax\"\n"					\
 	"3:\tli\t%0,%3\n\t"						\
 	"j\t2b\n\t"							\
diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 653a412..9510015 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -261,6 +261,7 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	" insn "	%1, %3				\n"	\
 	"2:							\n"	\
+	"	.insn						\n"	\
 	"	.section .fixup,\"ax\"				\n"	\
 	"3:	li	%0, %4					\n"	\
 	"	j	2b					\n"	\
@@ -287,7 +288,9 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	lw	%1, (%3)				\n"	\
 	"2:	lw	%D1, 4(%3)				\n"	\
-	"3:	.section	.fixup,\"ax\"			\n"	\
+	"3:							\n"	\
+	"	.insn						\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
 	"4:	li	%0, %4					\n"	\
 	"	move	%1, $0					\n"	\
 	"	move	%D1, $0					\n"	\
@@ -355,6 +358,7 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	" insn "	%z2, %3		# __put_user_asm\n"	\
 	"2:							\n"	\
+	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
 	"3:	li	%0, %4					\n"	\
 	"	j	2b					\n"	\
@@ -373,6 +377,7 @@ do {									\
 	"1:	sw	%2, (%3)	# __put_user_asm_ll32	\n"	\
 	"2:	sw	%D2, 4(%3)				\n"	\
 	"3:							\n"	\
+	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
 	"4:	li	%0, %4					\n"	\
 	"	j	3b					\n"	\
@@ -524,6 +529,7 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	" insn "	%1, %3				\n"	\
 	"2:							\n"	\
+	"	.insn						\n"	\
 	"	.section .fixup,\"ax\"				\n"	\
 	"3:	li	%0, %4					\n"	\
 	"	j	2b					\n"	\
@@ -549,7 +555,9 @@ do {									\
 	"1:	ulw	%1, (%3)				\n"	\
 	"2:	ulw	%D1, 4(%3)				\n"	\
 	"	move	%0, $0					\n"	\
-	"3:	.section	.fixup,\"ax\"			\n"	\
+	"3:							\n"	\
+	"	.insn						\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
 	"4:	li	%0, %4					\n"	\
 	"	move	%1, $0					\n"	\
 	"	move	%D1, $0					\n"	\
@@ -616,6 +624,7 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	" insn "	%z2, %3		# __put_user_unaligned_asm\n" \
 	"2:							\n"	\
+	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
 	"3:	li	%0, %4					\n"	\
 	"	j	2b					\n"	\
@@ -634,6 +643,7 @@ do {									\
 	"1:	sw	%2, (%3)	# __put_user_unaligned_asm_ll32	\n" \
 	"2:	sw	%D2, 4(%3)				\n"	\
 	"3:							\n"	\
+	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
 	"4:	li	%0, %4					\n"	\
 	"	j	3b					\n"	\
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index bcb6982f..62e7cff 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -143,9 +143,13 @@ stackargs:
 	jr	t1
 	 addiu	t1, 6f - 5f
 
+2:	.insn
 	lw	t8, 28(t0)		# argument #8 from usp
+3:	.insn
 	lw	t7, 24(t0)		# argument #7 from usp
+4:	.insn
 	lw	t6, 20(t0)		# argument #6 from usp
+5:	.insn
 	jr	t1
 	 sw	t5, 16(sp)		# argument #5 to ksp
 
-- 
1.7.10
