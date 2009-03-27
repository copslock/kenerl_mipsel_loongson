Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Mar 2009 17:08:36 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:59842 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20024925AbZC0RIa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Mar 2009 17:08:30 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49cd07ba0000>; Fri, 27 Mar 2009 13:07:11 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 27 Mar 2009 10:07:06 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 27 Mar 2009 10:07:05 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n2RH73AX012611;
	Fri, 27 Mar 2009 10:07:03 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n2RH72Pr012609;
	Fri, 27 Mar 2009 10:07:02 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: __raw_spin_lock() spins forever on ticket wrap.
Date:	Fri, 27 Mar 2009 10:07:02 -0700
Message-Id: <1238173622-12585-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 27 Mar 2009 17:07:05.0941 (UTC) FILETIME=[74B05850:01C9AEFE]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

If the lock is not acquired and has to spin *and* the second attempt
to acquire the lock fails, the delay time is not masked by the ticket
range mask.  If the ticket number wraps around to zero, the result is
that the lock sampling delay is essentially infinite (due to casting
-1 to an unsigned int).

The fix: Always mask the difference between my_ticket and the current
ticket value before calculating the delay.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/spinlock.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index 0884947..10e8244 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -76,7 +76,7 @@ static inline void __raw_spin_lock(raw_spinlock_t *lock)
 		"2:							\n"
 		"	.subsection 2					\n"
 		"4:	andi	%[ticket], %[ticket], 0x1fff		\n"
-		"5:	sll	%[ticket], 5				\n"
+		"	sll	%[ticket], 5				\n"
 		"							\n"
 		"6:	bnez	%[ticket], 6b				\n"
 		"	 subu	%[ticket], 1				\n"
@@ -85,7 +85,7 @@ static inline void __raw_spin_lock(raw_spinlock_t *lock)
 		"	andi	%[ticket], %[ticket], 0x1fff		\n"
 		"	beq	%[ticket], %[my_ticket], 2b		\n"
 		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
-		"	b	5b					\n"
+		"	b	4b					\n"
 		"	 subu	%[ticket], %[ticket], 1			\n"
 		"	.previous					\n"
 		"	.set pop					\n"
@@ -113,7 +113,7 @@ static inline void __raw_spin_lock(raw_spinlock_t *lock)
 		"	 ll	%[ticket], %[ticket_ptr]		\n"
 		"							\n"
 		"4:	andi	%[ticket], %[ticket], 0x1fff		\n"
-		"5:	sll	%[ticket], 5				\n"
+		"	sll	%[ticket], 5				\n"
 		"							\n"
 		"6:	bnez	%[ticket], 6b				\n"
 		"	 subu	%[ticket], 1				\n"
@@ -122,7 +122,7 @@ static inline void __raw_spin_lock(raw_spinlock_t *lock)
 		"	andi	%[ticket], %[ticket], 0x1fff		\n"
 		"	beq	%[ticket], %[my_ticket], 2b		\n"
 		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
-		"	b	5b					\n"
+		"	b	4b					\n"
 		"	 subu	%[ticket], %[ticket], 1			\n"
 		"	.previous					\n"
 		"	.set pop					\n"
-- 
1.6.0.6
