Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2006 19:02:14 +0100 (BST)
Received: from ms-smtp-01.rdc-nyc.rr.com ([24.29.109.5]:10893 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by ftp.linux-mips.org with ESMTP
	id S20038513AbWJLSCJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Oct 2006 19:02:09 +0100
Received: from landofbile.com (cpe-74-68-39-174.nj.res.rr.com [74.68.39.174])
	by ms-smtp-01.rdc-nyc.rr.com (8.13.6/8.13.6) with SMTP id k9CI26I5017308
	for <linux-mips@linux-mips.org>; Thu, 12 Oct 2006 14:02:06 -0400 (EDT)
Message-Id: <200610121802.k9CI26I5017308@ms-smtp-01.rdc-nyc.rr.com>
Received: by landofbile.com (sSMTP sendmail emulation); Thu, 12 Oct 2006 14:03:39 -0400
From:	bile@landofbile.com
Date:	Thu, 12 Oct 2006 14:03:39 -0400
To:	linux-mips@linux-mips.org
Subject: patch: include/asm-mips/system.h __cmpxchg64 bugfix and cleanup
User-Agent: Heirloom mailx 12.1 6/15/06
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <bile@landofbile.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bile@landofbile.com
Precedence: bulk
X-list: linux-mips

In include/asm-mips/system.h __cmpxchg_u64 is doing

if(cpu_has_llsc) {
} else if(cpu_has_llsc) {

the first should be (cpu_has_llsc && R10000_LLSC_WAR).

While this probably gets cleaned up during optimization I took
the liberty of cleaning up the code along with the fix so it's
not doing the double check and only includes the R10000 workaround
at compile time.

diff --git a/include/asm-mips/system.h b/include/asm-mips/system.h
index dcb4701..bfae6ff 100644
--- a/include/asm-mips/system.h
+++ b/include/asm-mips/system.h
@@ -206,7 +206,7 @@ static inline unsigned long __xchg_u32(v
 {
 	__u32 retval;
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (cpu_has_llsc) {
 		unsigned long dummy;
 
 		__asm__ __volatile__(
@@ -216,25 +216,11 @@ static inline unsigned long __xchg_u32(v
 		"	move	%2, %z4					\n"
 		"	.set	mips3					\n"
 		"	sc	%2, %1					\n"
+#ifdef R10000_LLSC_WAR
 		"	beqzl	%2, 1b					\n"
-#ifdef CONFIG_SMP
-		"	sync						\n"
-#endif
-		"	.set	mips0					\n"
-		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
-		: "R" (*m), "Jr" (val)
-		: "memory");
-	} else if (cpu_has_llsc) {
-		unsigned long dummy;
-
-		__asm__ __volatile__(
-		"	.set	mips3					\n"
-		"1:	ll	%0, %3			# xchg_u32	\n"
-		"	.set	mips0					\n"
-		"	move	%2, %z4					\n"
-		"	.set	mips3					\n"
-		"	sc	%2, %1					\n"
+#else
 		"	beqz	%2, 1b					\n"
+#endif                
 #ifdef CONFIG_SMP
 		"	sync						\n"
 #endif
@@ -259,7 +245,7 @@ static inline __u64 __xchg_u64(volatile 
 {
 	__u64 retval;
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (cpu_has_llsc) {
 		unsigned long dummy;
 
 		__asm__ __volatile__(
@@ -267,23 +253,11 @@ static inline __u64 __xchg_u64(volatile 
 		"1:	lld	%0, %3			# xchg_u64	\n"
 		"	move	%2, %z4					\n"
 		"	scd	%2, %1					\n"
+#ifdef R10000_LLSC_WAR
 		"	beqzl	%2, 1b					\n"
-#ifdef CONFIG_SMP
-		"	sync						\n"
-#endif
-		"	.set	mips0					\n"
-		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
-		: "R" (*m), "Jr" (val)
-		: "memory");
-	} else if (cpu_has_llsc) {
-		unsigned long dummy;
-
-		__asm__ __volatile__(
-		"	.set	mips3					\n"
-		"1:	lld	%0, %3			# xchg_u64	\n"
-		"	move	%2, %z4					\n"
-		"	scd	%2, %1					\n"
+#else
 		"	beqz	%2, 1b					\n"
+#endif                
 #ifdef CONFIG_SMP
 		"	sync						\n"
 #endif
@@ -333,7 +307,7 @@ static inline unsigned long __cmpxchg_u3
 {
 	__u32 retval;
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (cpu_has_llsc) {
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	noat					\n"
@@ -344,27 +318,11 @@ static inline unsigned long __cmpxchg_u3
 		"	move	$1, %z4					\n"
 		"	.set	mips3					\n"
 		"	sc	$1, %1					\n"
+#ifdef R10000_LLSC_WAR                
 		"	beqzl	$1, 1b					\n"
-#ifdef CONFIG_SMP
-		"	sync						\n"
-#endif
-		"2:							\n"
-		"	.set	pop					\n"
-		: "=&r" (retval), "=R" (*m)
-		: "R" (*m), "Jr" (old), "Jr" (new)
-		: "memory");
-	} else if (cpu_has_llsc) {
-		__asm__ __volatile__(
-		"	.set	push					\n"
-		"	.set	noat					\n"
-		"	.set	mips3					\n"
-		"1:	ll	%0, %2			# __cmpxchg_u32	\n"
-		"	bne	%0, %z3, 2f				\n"
-		"	.set	mips0					\n"
-		"	move	$1, %z4					\n"
-		"	.set	mips3					\n"
-		"	sc	$1, %1					\n"
-		"	beqz	$1, 1b					\n"
+#else
+                "       beqz    $1, 1b                                  \n"
+#endif                
 #ifdef CONFIG_SMP
 		"	sync						\n"
 #endif
@@ -401,25 +359,11 @@ static inline unsigned long __cmpxchg_u6
 		"	bne	%0, %z3, 2f				\n"
 		"	move	$1, %z4					\n"
 		"	scd	$1, %1					\n"
+#ifdef R10000_LLSC_WAR
 		"	beqzl	$1, 1b					\n"
-#ifdef CONFIG_SMP
-		"	sync						\n"
-#endif
-		"2:							\n"
-		"	.set	pop					\n"
-		: "=&r" (retval), "=R" (*m)
-		: "R" (*m), "Jr" (old), "Jr" (new)
-		: "memory");
-	} else if (cpu_has_llsc) {
-		__asm__ __volatile__(
-		"	.set	push					\n"
-		"	.set	noat					\n"
-		"	.set	mips3					\n"
-		"1:	lld	%0, %2			# __cmpxchg_u64	\n"
-		"	bne	%0, %z3, 2f				\n"
-		"	move	$1, %z4					\n"
-		"	scd	$1, %1					\n"
+#else
 		"	beqz	$1, 1b					\n"
+#endif                
 #ifdef CONFIG_SMP
 		"	sync						\n"
 #endif
