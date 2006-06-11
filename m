Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jun 2006 15:25:00 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:2282 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133783AbWFKOYu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 11 Jun 2006 15:24:50 +0100
Received: from localhost (p4129-ipad28funabasi.chiba.ocn.ne.jp [220.107.203.129])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6C9489472; Sun, 11 Jun 2006 23:24:44 +0900 (JST)
Date:	Sun, 11 Jun 2006 23:25:43 +0900 (JST)
Message-Id: <20060611.232543.59465208.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix futex_atomic_op_inuser
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I found that NPTL's pthread_cond_signal() does not work properly on
kernels compiled by gcc 4.1.x.  I suppose inline asm for
__futex_atomic_op() was wrong.  I suppose:

1. "=&r" constraint should be used for oldval.
2. Instead of "r" (uaddr), "=R" (*uaddr) for output and "R" (*uaddr)
   for input should be used.
3. "memory" should be added to the clobber list.

This patch solved the problem.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/futex.h b/include/asm-mips/futex.h
index 12d118f..1f94640 100644
--- a/include/asm-mips/futex.h
+++ b/include/asm-mips/futex.h
@@ -22,51 +22,53 @@
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
 		"	.set	mips3				\n"	\
-		"1:	ll	%1, (%3)	# __futex_atomic_op	\n" \
+		"1:	ll	%1, %4	# __futex_atomic_op	\n"	\
 		"	.set	mips0				\n"	\
 		"	" insn	"				\n"	\
 		"	.set	mips3				\n"	\
-		"2:	sc	$1, (%3)			\n"	\
+		"2:	sc	$1, %2				\n"	\
 		"	beqzl	$1, 1b				\n"	\
 		__FUTEX_SMP_SYNC					\
 		"3:						\n"	\
 		"	.set	pop				\n"	\
 		"	.set	mips0				\n"	\
 		"	.section .fixup,\"ax\"			\n"	\
-		"4:	li	%0, %5				\n"	\
+		"4:	li	%0, %6				\n"	\
 		"	j	2b				\n"	\
 		"	.previous				\n"	\
 		"	.section __ex_table,\"a\"		\n"	\
 		"	"__UA_ADDR "\t1b, 4b			\n"	\
 		"	"__UA_ADDR "\t2b, 4b			\n"	\
 		"	.previous				\n"	\
-		: "=r" (ret), "=r" (oldval)				\
-		: "0" (0), "r" (uaddr), "Jr" (oparg), "i" (-EFAULT));	\
+		: "=r" (ret), "=&r" (oldval), "=R" (*uaddr)		\
+		: "0" (0), "R" (*uaddr), "Jr" (oparg), "i" (-EFAULT)	\
+		: "memory");						\
 	} else if (cpu_has_llsc) {					\
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
 		"	.set	mips3				\n"	\
-		"1:	ll	%1, (%3)	# __futex_atomic_op	\n" \
+		"1:	ll	%1, %4	# __futex_atomic_op	\n"	\
 		"	.set	mips0				\n"	\
 		"	" insn	"				\n"	\
 		"	.set	mips3				\n"	\
-		"2:	sc	$1, (%3)			\n"	\
+		"2:	sc	$1, %2				\n"	\
 		"	beqz	$1, 1b				\n"	\
 		__FUTEX_SMP_SYNC					\
 		"3:						\n"	\
 		"	.set	pop				\n"	\
 		"	.set	mips0				\n"	\
 		"	.section .fixup,\"ax\"			\n"	\
-		"4:	li	%0, %5				\n"	\
+		"4:	li	%0, %6				\n"	\
 		"	j	2b				\n"	\
 		"	.previous				\n"	\
 		"	.section __ex_table,\"a\"		\n"	\
 		"	"__UA_ADDR "\t1b, 4b			\n"	\
 		"	"__UA_ADDR "\t2b, 4b			\n"	\
 		"	.previous				\n"	\
-		: "=r" (ret), "=r" (oldval)				\
-		: "0" (0), "r" (uaddr), "Jr" (oparg), "i" (-EFAULT));	\
+		: "=r" (ret), "=&r" (oldval), "=R" (*uaddr)		\
+		: "0" (0), "R" (*uaddr), "Jr" (oparg), "i" (-EFAULT)	\
+		: "memory");						\
 	} else								\
 		ret = -ENOSYS;						\
 }
@@ -89,23 +91,23 @@ futex_atomic_op_inuser (int encoded_op, 
 
 	switch (op) {
 	case FUTEX_OP_SET:
-		__futex_atomic_op("move	$1, %z4", ret, oldval, uaddr, oparg);
+		__futex_atomic_op("move	$1, %z5", ret, oldval, uaddr, oparg);
 		break;
 
 	case FUTEX_OP_ADD:
-		__futex_atomic_op("addu	$1, %1, %z4",
+		__futex_atomic_op("addu	$1, %1, %z5",
 		                  ret, oldval, uaddr, oparg);
 		break;
 	case FUTEX_OP_OR:
-		__futex_atomic_op("or	$1, %1, %z4",
+		__futex_atomic_op("or	$1, %1, %z5",
 		                  ret, oldval, uaddr, oparg);
 		break;
 	case FUTEX_OP_ANDN:
-		__futex_atomic_op("and	$1, %1, %z4",
+		__futex_atomic_op("and	$1, %1, %z5",
 		                  ret, oldval, uaddr, ~oparg);
 		break;
 	case FUTEX_OP_XOR:
-		__futex_atomic_op("xor	$1, %1, %z4",
+		__futex_atomic_op("xor	$1, %1, %z5",
 		                  ret, oldval, uaddr, oparg);
 		break;
 	default:
