Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2006 19:06:57 +0100 (BST)
Received: from ms-smtp-01.rdc-nyc.rr.com ([24.29.109.5]:45559 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by ftp.linux-mips.org with ESMTP
	id S20038585AbWJRSGu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Oct 2006 19:06:50 +0100
Received: from amiga (cpe-74-68-39-174.nj.res.rr.com [74.68.39.174])
	by ms-smtp-01.rdc-nyc.rr.com (8.13.6/8.13.6) with ESMTP id k9II6iPm016665;
	Wed, 18 Oct 2006 14:06:48 -0400 (EDT)
Date:	Wed, 18 Oct 2006 14:08:18 -0400
From:	Antonio SJ Musumeci <bile@landofbile.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: patch: include/asm-mips/system.h __cmpxchg64 bugfix and cleanup
Message-ID: <20061018140818.3e40b0a4@amiga>
In-Reply-To: <20061015184226.GA3259@linux-mips.org>
References: <200610121802.k9CI26I5017308@ms-smtp-01.rdc-nyc.rr.com>
 <20061013104250.GA16820@linux-mips.org>
 <452F9A41.4020505@landofbile.com>
 <20061013141101.GA19260@linux-mips.org>
 <20061013151841.3a902627@amiga>
 <20061015184226.GA3259@linux-mips.org>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.10.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <bile@landofbile.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bile@landofbile.com
Precedence: bulk
X-list: linux-mips

I'm not talking about that. This patch explains it. Moving
the conditional compilation from the optimizer to the preprocessor.
I see no reason to be using hard coded 1's and 0's in runtime logic.
And one could go all the way and check cpu_has_llsc to see if it's
hardcoded or not.

Signed-off-by: Antonio SJ Musumeci <bile@landofbile.com>

--- clean.linux.mips.git/include/asm-mips/system.h	2006-10-15 17:58:08.000000000 -0400
+++ linux.mips.git/include/asm-mips/system.h	2006-10-14 18:21:16.000000000 -0400
@@ -206,9 +206,9 @@ static inline unsigned long __xchg_u32(v
 {
 	__u32 retval;
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (cpu_has_llsc) {
 		unsigned long dummy;
-
+#if R10000_LLSC_WAR
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	ll	%0, %3			# xchg_u32	\n"
@@ -217,16 +217,14 @@ static inline unsigned long __xchg_u32(v
 		"	.set	mips3					\n"
 		"	sc	%2, %1					\n"
 		"	beqzl	%2, 1b					\n"
-#ifdef CONFIG_SMP
+# ifdef CONFIG_SMP
 		"	sync						\n"
-#endif
+# endif
 		"	.set	mips0					\n"
 		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
 		: "R" (*m), "Jr" (val)
 		: "memory");
-	} else if (cpu_has_llsc) {
-		unsigned long dummy;
-
+#else /* !R10000_LLSC_WAR */              
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	ll	%0, %3			# xchg_u32	\n"
@@ -235,9 +233,9 @@ static inline unsigned long __xchg_u32(v
 		"	.set	mips3					\n"
 		"	sc	%2, %1					\n"
 		"	beqz	%2, 2f					\n"
-#ifdef CONFIG_SMP
+# ifdef CONFIG_SMP
 		"	sync						\n"
-#endif
+# endif
 		"	.subsection 2					\n"
 		"2:	b	1b					\n"
 		"	.previous					\n"
@@ -245,8 +243,9 @@ static inline unsigned long __xchg_u32(v
 		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
 		: "R" (*m), "Jr" (val)
 		: "memory");
+#endif /* R10000_LLSC_WAR */                
 	} else {
-		unsigned long flags;
+                unsigned long flags;
 
 		local_irq_save(flags);
 		retval = *m;
@@ -262,34 +261,32 @@ static inline __u64 __xchg_u64(volatile 
 {
 	__u64 retval;
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (cpu_has_llsc) {
 		unsigned long dummy;
-
+#if R10000_LLSC_WAR
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	lld	%0, %3			# xchg_u64	\n"
 		"	move	%2, %z4					\n"
 		"	scd	%2, %1					\n"
 		"	beqzl	%2, 1b					\n"
-#ifdef CONFIG_SMP
+# ifdef CONFIG_SMP
 		"	sync						\n"
-#endif
+# endif
 		"	.set	mips0					\n"
 		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
 		: "R" (*m), "Jr" (val)
 		: "memory");
-	} else if (cpu_has_llsc) {
-		unsigned long dummy;
-
-		__asm__ __volatile__(
+#else /* !R10000_LLSC_WAR */              
+      		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	lld	%0, %3			# xchg_u64	\n"
 		"	move	%2, %z4					\n"
 		"	scd	%2, %1					\n"
 		"	beqz	%2, 2f					\n"
-#ifdef CONFIG_SMP
+# ifdef CONFIG_SMP
 		"	sync						\n"
-#endif
+# endif
 		"	.subsection 2					\n"
 		"2:	b	1b					\n"
 		"	.previous					\n"
@@ -297,6 +294,8 @@ static inline __u64 __xchg_u64(volatile 
 		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
 		: "R" (*m), "Jr" (val)
 		: "memory");
+
+#endif /* R10000_LLSC_WAR */                
 	} else {
 		unsigned long flags;
 
@@ -339,7 +338,8 @@ static inline unsigned long __cmpxchg_u3
 {
 	__u32 retval;
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (cpu_has_llsc) {
+#if R10000_LLSC_WAR        
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	noat					\n"
@@ -351,15 +351,15 @@ static inline unsigned long __cmpxchg_u3
 		"	.set	mips3					\n"
 		"	sc	$1, %1					\n"
 		"	beqzl	$1, 1b					\n"
-#ifdef CONFIG_SMP
+# ifdef CONFIG_SMP
 		"	sync						\n"
-#endif
+# endif
 		"2:							\n"
 		"	.set	pop					\n"
 		: "=&r" (retval), "=R" (*m)
 		: "R" (*m), "Jr" (old), "Jr" (new)
 		: "memory");
-	} else if (cpu_has_llsc) {
+#else /* !R10000_LLSC_WAR */
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	noat					\n"
@@ -371,9 +371,9 @@ static inline unsigned long __cmpxchg_u3
 		"	.set	mips3					\n"
 		"	sc	$1, %1					\n"
 		"	beqz	$1, 3f					\n"
-#ifdef CONFIG_SMP
+# ifdef CONFIG_SMP
 		"	sync						\n"
-#endif
+# endif
 		"2:							\n"
 		"	.subsection 2					\n"
 		"3:	b	1b					\n"
@@ -382,6 +382,7 @@ static inline unsigned long __cmpxchg_u3
 		: "=&r" (retval), "=R" (*m)
 		: "R" (*m), "Jr" (old), "Jr" (new)
 		: "memory");
+#endif /* R10000_LLSC_WAR */                
 	} else {
 		unsigned long flags;
 
@@ -401,8 +402,9 @@ static inline unsigned long __cmpxchg_u6
 {
 	__u64 retval;
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		__asm__ __volatile__(
+	if (cpu_has_llsc) {
+#if R10000_LLSC_WAR
+                __asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	noat					\n"
 		"	.set	mips3					\n"
@@ -411,15 +413,15 @@ static inline unsigned long __cmpxchg_u6
 		"	move	$1, %z4					\n"
 		"	scd	$1, %1					\n"
 		"	beqzl	$1, 1b					\n"
-#ifdef CONFIG_SMP
+# ifdef CONFIG_SMP
 		"	sync						\n"
-#endif
+# endif
 		"2:							\n"
 		"	.set	pop					\n"
 		: "=&r" (retval), "=R" (*m)
 		: "R" (*m), "Jr" (old), "Jr" (new)
 		: "memory");
-	} else if (cpu_has_llsc) {
+#else /* !R10000_LLSC_WAR */              
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	noat					\n"
@@ -429,9 +431,9 @@ static inline unsigned long __cmpxchg_u6
 		"	move	$1, %z4					\n"
 		"	scd	$1, %1					\n"
 		"	beqz	$1, 3f					\n"
-#ifdef CONFIG_SMP
+# ifdef CONFIG_SMP
 		"	sync						\n"
-#endif
+# endif
 		"2:							\n"
 		"	.subsection 2					\n"
 		"3:	b	1b					\n"
@@ -440,6 +442,7 @@ static inline unsigned long __cmpxchg_u6
 		: "=&r" (retval), "=R" (*m)
 		: "R" (*m), "Jr" (old), "Jr" (new)
 		: "memory");
+#endif /* R10000_LLSC_WAR */                
 	} else {
 		unsigned long flags;
 


On Sun, 15 Oct 2006 19:42:26 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Oct 13, 2006 at 03:18:41PM -0400, Antonio SJ Musumeci wrote:
> 
> > Wouldn't it be better to check the macro in the preprocessor
> > instead of runtime? And why are those defined to 0 instead of
> > explicitly undef'ed? I've found one bug because it was assumed to
> > be undefined instead of 0. If no one objects I'll post a patch
> > undefing those and fix any bugs I've found because of them.
> 
> Any reasonable system configuration will define cpu_has_llsc to 1 in
> order to override the default.  R10000_LLSC_WAR is a constant as well.
> So only one of the three if blocks will remain.  If that's not the
> case you either don't have a cpu-feature-overrides.h file for your
> platform or it doesn't define cpu_has_llsc to a constant expression.
> 
>   Ralf
> 
> 
