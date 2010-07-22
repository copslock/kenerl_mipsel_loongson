Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jul 2010 20:59:43 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7256 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491203Ab0GVS7i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Jul 2010 20:59:38 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c4895320000>; Thu, 22 Jul 2010 12:00:02 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 22 Jul 2010 11:59:35 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 22 Jul 2010 11:59:35 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6MIxUMv023090;
        Thu, 22 Jul 2010 11:59:30 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6MIxU34023080;
        Thu, 22 Jul 2010 11:59:30 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Quit using undefined behavior of ADDU in 64-bit atomic operations.
Date:   Thu, 22 Jul 2010 11:59:27 -0700
Message-Id: <1279825167-23048-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
X-OriginalArrivalTime: 22 Jul 2010 18:59:35.0315 (UTC) FILETIME=[06BC9630:01CB29D0]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

For 64-bit, we must use DADDU and DSUBU.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/atomic.h |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 59dc0c7..c63c56b 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -434,7 +434,7 @@ static __inline__ void atomic64_add(long i, atomic64_t * v)
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	lld	%0, %1		# atomic64_add		\n"
-		"	addu	%0, %2					\n"
+		"	daddu	%0, %2					\n"
 		"	scd	%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
 		"	.set	mips0					\n"
@@ -446,7 +446,7 @@ static __inline__ void atomic64_add(long i, atomic64_t * v)
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	lld	%0, %1		# atomic64_add		\n"
-		"	addu	%0, %2					\n"
+		"	daddu	%0, %2					\n"
 		"	scd	%0, %1					\n"
 		"	beqz	%0, 2f					\n"
 		"	.subsection 2					\n"
@@ -479,7 +479,7 @@ static __inline__ void atomic64_sub(long i, atomic64_t * v)
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	lld	%0, %1		# atomic64_sub		\n"
-		"	subu	%0, %2					\n"
+		"	dsubu	%0, %2					\n"
 		"	scd	%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
 		"	.set	mips0					\n"
@@ -491,7 +491,7 @@ static __inline__ void atomic64_sub(long i, atomic64_t * v)
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	lld	%0, %1		# atomic64_sub		\n"
-		"	subu	%0, %2					\n"
+		"	dsubu	%0, %2					\n"
 		"	scd	%0, %1					\n"
 		"	beqz	%0, 2f					\n"
 		"	.subsection 2					\n"
@@ -524,10 +524,10 @@ static __inline__ long atomic64_add_return(long i, atomic64_t * v)
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	lld	%1, %2		# atomic64_add_return	\n"
-		"	addu	%0, %1, %3				\n"
+		"	daddu	%0, %1, %3				\n"
 		"	scd	%0, %2					\n"
 		"	beqzl	%0, 1b					\n"
-		"	addu	%0, %1, %3				\n"
+		"	daddu	%0, %1, %3				\n"
 		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
@@ -538,10 +538,10 @@ static __inline__ long atomic64_add_return(long i, atomic64_t * v)
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	lld	%1, %2		# atomic64_add_return	\n"
-		"	addu	%0, %1, %3				\n"
+		"	daddu	%0, %1, %3				\n"
 		"	scd	%0, %2					\n"
 		"	beqz	%0, 2f					\n"
-		"	addu	%0, %1, %3				\n"
+		"	daddu	%0, %1, %3				\n"
 		"	.subsection 2					\n"
 		"2:	b	1b					\n"
 		"	.previous					\n"
@@ -576,10 +576,10 @@ static __inline__ long atomic64_sub_return(long i, atomic64_t * v)
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	lld	%1, %2		# atomic64_sub_return	\n"
-		"	subu	%0, %1, %3				\n"
+		"	dsubu	%0, %1, %3				\n"
 		"	scd	%0, %2					\n"
 		"	beqzl	%0, 1b					\n"
-		"	subu	%0, %1, %3				\n"
+		"	dsubu	%0, %1, %3				\n"
 		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
@@ -590,10 +590,10 @@ static __inline__ long atomic64_sub_return(long i, atomic64_t * v)
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	lld	%1, %2		# atomic64_sub_return	\n"
-		"	subu	%0, %1, %3				\n"
+		"	dsubu	%0, %1, %3				\n"
 		"	scd	%0, %2					\n"
 		"	beqz	%0, 2f					\n"
-		"	subu	%0, %1, %3				\n"
+		"	dsubu	%0, %1, %3				\n"
 		"	.subsection 2					\n"
 		"2:	b	1b					\n"
 		"	.previous					\n"
-- 
1.7.1.1
