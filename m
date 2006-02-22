Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Feb 2006 20:18:42 +0000 (GMT)
Received: from mail.baslerweb.com ([145.253.187.130]:38533 "EHLO
	mail.baslerweb.com") by ftp.linux-mips.org with ESMTP
	id S8133726AbWBVUSc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Feb 2006 20:18:32 +0000
Received: (from mail@localhost)
	by mail.baslerweb.com (8.12.10/8.12.10) id k1MKO3W9002351
	for <linux-mips@linux-mips.org>; Wed, 22 Feb 2006 21:24:03 +0100
Received: from unknown by gateway id /processing/kwXQEIae; Wed Feb 22 21:24:01 2006
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 18J3BJNC; Wed, 22 Feb 2006 21:25:40 +0100
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To:	linux-mips@linux-mips.org
Date:	Wed, 22 Feb 2006 21:25:39 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Message-Id: <200602222125.39999.thomas.koeller@baslerweb.com>
Subject: [PATCH] atomic functions broken
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

The ll/sc versions of atomic_sub_if_positive(), and the corresponding 64-bit functions,
are broken. The value returned by those functions is always one, no matter what.


Signed-off-by: Thomas Koeller  <thomas.koeller@baslerweb.com>




diff --git a/include/asm-mips/atomic.h b/include/asm-mips/atomic.h
index 654b97d..472e855 100644
--- a/include/asm-mips/atomic.h
+++ b/include/asm-mips/atomic.h
@@ -247,15 +247,16 @@ static __inline__ int atomic_sub_if_posi
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
-		"	subu	%0, %1, %3				\n"
-		"	bltz	%0, 1f					\n"
-		"	sc	%0, %2					\n"
-		"	beqzl	%0, 1b					\n"
+		"	subu	%1, %1, %3				\n"
+		"	addi	%0, %1, 0				\n"
+		"	bltz	%1, 1f					\n"
+		"	sc	%1, %2					\n"
+		"	beqzl	%1, 1b					\n"
 		"	sync						\n"
 		"1:							\n"
 		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp), "+m" (v->counter)
+		: "Ir" (i)
 		: "memory");
 	} else if (cpu_has_llsc) {
 		unsigned long temp;
@@ -263,15 +264,16 @@ static __inline__ int atomic_sub_if_posi
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
-		"	subu	%0, %1, %3				\n"
-		"	bltz	%0, 1f					\n"
-		"	sc	%0, %2					\n"
-		"	beqz	%0, 1b					\n"
+		"	subu	%1, %1, %3				\n"
+		"	addi	%0, %1, 0				\n"
+		"	bltz	%1, 1f					\n"
+		"	sc	%1, %2					\n"
+		"	beqz	%1, 1b					\n"
 		"	sync						\n"
 		"1:							\n"
 		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp), "+m" (v->counter)
+		: "Ir" (i)
 		: "memory");
 	} else {
 		unsigned long flags;
@@ -595,15 +597,16 @@ static __inline__ long atomic64_sub_if_p
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
-		"	dsubu	%0, %1, %3				\n"
-		"	bltz	%0, 1f					\n"
-		"	scd	%0, %2					\n"
-		"	beqzl	%0, 1b					\n"
+		"	dsubu	%1, %1, %3				\n"
+		"	daddi	%0, %1, 0				\n"
+		"	bltz	%1, 1f					\n"
+		"	scd	%1, %2					\n"
+		"	beqzl	%1, 1b					\n"
 		"	sync						\n"
 		"1:							\n"
 		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp), "+m" (v->counter)
+		: "Ir" (i)
 		: "memory");
 	} else if (cpu_has_llsc) {
 		unsigned long temp;
@@ -611,15 +614,16 @@ static __inline__ long atomic64_sub_if_p
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
-		"	dsubu	%0, %1, %3				\n"
-		"	bltz	%0, 1f					\n"
-		"	scd	%0, %2					\n"
-		"	beqz	%0, 1b					\n"
+		"	dsubu	%1, %1, %3				\n"
+		"	daddi	%0, %1, 0				\n"
+		"	bltz	%1, 1f					\n"
+		"	scd	%1, %2					\n"
+		"	beqz	%1, 1b					\n"
 		"	sync						\n"
 		"1:							\n"
 		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp), "+m" (v->counter)
+		: "Ir" (i)
 		: "memory");
 	} else {
 		unsigned long flags;

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
