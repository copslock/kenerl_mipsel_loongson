Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11JUFP16570
	for linux-mips-outgoing; Fri, 1 Feb 2002 11:30:15 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11JTkd16548
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 11:29:46 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 4BEE5125C3; Fri,  1 Feb 2002 10:29:43 -0800 (PST)
Date: Fri, 1 Feb 2002 10:29:43 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Hiroyuki Machida <machida@sm.sony.co.jp>, libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: PATCH: Fix ll/sc for mips (take 3)
Message-ID: <20020201102943.A11146@lucon.org>
References: <20020131231714.E32690@lucon.org> <Pine.GSO.3.96.1020201124328.26449A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020201124328.26449A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Feb 01, 2002 at 12:45:02PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 01, 2002 at 12:45:02PM +0100, Maciej W. Rozycki wrote:
> On Thu, 31 Jan 2002, H . J . Lu wrote:
> 
> > > Gas will fill delay slots. Same object codes will be produced, so I
> > > think you don't have to do that by hand. 
> > 
> > It will make the code more readable. We don't have to guess what
> > the assembler will do. 
> 
>  But you lose a chance for something useful being reordered to the slot.
> That might not necessarily be a "nop".  Please don't forget of indents
> anyway.
> 

Here is a new patch. I use branch likely to get rid of nops. Please
tell me which indents I may have missed.

Thanks.


H.J.
----
2002-02-01  H.J. Lu  <hjl@gnu.org>

	* sysdeps/mips/pspinlock.c (__pthread_spin_lock): Use a
	different register in the delayed slot. Use branch likely.

	* sysdeps/mips/pt-machine.h (testandset): Call _test_and_set.
	(__compare_and_swap): Return 0 only when failed to compare. Use
	branch likely.

2002-02-01  H.J. Lu  <hjl@gnu.org>

	* sysdeps/mips/atomicity.h (exchange_and_add): Use branch
	likely.
	(atomic_add): Likewise.
	(compare_and_swap): Return 0 only when failed to compare. Use
	branch likely.

	* sysdeps/unix/sysv/linux/mips/sys/tas.h (_test_and_set): Use
	branch likely.

--- glibc-2.2.4/linuxthreads/sysdeps/mips/pspinlock.c.llsc	Thu Jan 31 10:49:37 2002
+++ glibc-2.2.4/linuxthreads/sysdeps/mips/pspinlock.c	Fri Feb  1 10:17:47 2002
@@ -29,20 +29,21 @@
 int
 __pthread_spin_lock (pthread_spinlock_t *lock)
 {
-  unsigned int tmp;
+  unsigned int tmp1, tmp2;
 
   asm volatile
     ("\t\t\t# spin_lock\n\t"
+     "ll	%1,%3\n"
      "1:\n\t"
-     "ll	%1,%2\n\t"
      ".set	push\n\t"
      ".set	noreorder\n\t"
      "bnez	%1,1b\n\t"
-     " li	%1,1\n\t"
-     ".set	pop\n\t"
-     "sc	%1,%0\n\t"
-     "beqz	%1,1b"
-     : "=m" (*lock), "=&r" (tmp)
+     "li	%2,1\n\t"
+     "sc	%2,%0\n\t"
+     "beqzl	%2,1b\n\t"
+     "ll	%1,%3\n\t"
+     ".set	pop"
+     : "=m" (*lock), "=&r" (tmp1), "=&r" (tmp2)
      : "m" (*lock)
      : "memory");
 
--- glibc-2.2.4/linuxthreads/sysdeps/mips/pt-machine.h.llsc	Sat Dec  9 08:55:34 2000
+++ glibc-2.2.4/linuxthreads/sysdeps/mips/pt-machine.h	Fri Feb  1 10:14:18 2002
@@ -33,41 +33,11 @@
 
 /* Spinlock implementation; required.  */
 
-#if (_MIPS_ISA >= _MIPS_ISA_MIPS2)
-
-PT_EI long int
-testandset (int *spinlock)
-{
-  long int ret, temp;
-
-  __asm__ __volatile__
-    ("/* Inline spinlock test & set */\n\t"
-     "1:\n\t"
-     "ll	%0,%3\n\t"
-     ".set	push\n\t"
-     ".set	noreorder\n\t"
-     "bnez	%0,2f\n\t"
-     " li	%1,1\n\t"
-     ".set	pop\n\t"
-     "sc	%1,%2\n\t"
-     "beqz	%1,1b\n"
-     "2:\n\t"
-     "/* End spinlock test & set */"
-     : "=&r" (ret), "=&r" (temp), "=m" (*spinlock)
-     : "m" (*spinlock)
-     : "memory");
-
-  return ret;
-}
-
-#else /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
-
 PT_EI long int
 testandset (int *spinlock)
 {
   return _test_and_set (spinlock, 1);
 }
-#endif /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
 
 
 /* Get some notion of the current stack.  Need not be exactly the top
@@ -84,22 +54,24 @@ register char * stack_pointer __asm__ ("
 PT_EI int
 __compare_and_swap (long int *p, long int oldval, long int newval)
 {
-  long int ret;
+  long int ret, temp;
 
   __asm__ __volatile__
     ("/* Inline compare & swap */\n\t"
+     "ll	%1,%5\n"
      "1:\n\t"
-     "ll	%0,%4\n\t"
-     ".set	push\n"
+     ".set	push\n\t"
      ".set	noreorder\n\t"
-     "bne	%0,%2,2f\n\t"
-     " move	%0,%3\n\t"
-     ".set	pop\n\t"
-     "sc	%0,%1\n\t"
-     "beqz	%0,1b\n"
+     "bne	%1,%3,2f\n\t"
+     "move	%0,$0\n\t"
+     "move	%0,%4\n\t"
+     "sc	%0,%2\n\t"
+     "beqzl	%0,1b\n\t"
+     "ll	%1,%5\n\t"
+     ".set	pop\n"
      "2:\n\t"
      "/* End compare & swap */"
-     : "=&r" (ret), "=m" (*p)
+     : "=&r" (ret), "=&r" (temp), "=m" (*p)
      : "r" (oldval), "r" (newval), "m" (*p)
      : "memory");
 
--- glibc-2.2.4/sysdeps/mips/atomicity.h.llsc	Mon Jul  9 11:58:19 2001
+++ glibc-2.2.4/sysdeps/mips/atomicity.h	Fri Feb  1 09:55:05 2002
@@ -33,11 +33,15 @@ exchange_and_add (volatile uint32_t *mem
 
   __asm__ __volatile__
     ("/* Inline exchange & add */\n\t"
+     "ll	%0,%3\n"
      "1:\n\t"
-     "ll	%0,%3\n\t"
      "addu	%1,%4,%0\n\t"
      "sc	%1,%2\n\t"
-     "beqz	%1,1b\n\t"
+     ".set	push\n\t"
+     ".set	noreorder\n\t"
+     "beqzl	%1,1b\n\t"
+     "ll	%0,%3\n\t"
+     ".set	pop\n\t"
      "/* End exchange & add */"
      : "=&r"(result), "=&r"(tmp), "=m"(*mem)
      : "m" (*mem), "r"(val)
@@ -54,11 +58,15 @@ atomic_add (volatile uint32_t *mem, int 
 
   __asm__ __volatile__
     ("/* Inline atomic add */\n\t"
+     "ll	%0,%2\n"
      "1:\n\t"
-     "ll	%0,%2\n\t"
      "addu	%0,%3,%0\n\t"
      "sc	%0,%1\n\t"
-     "beqz	%0,1b\n\t"
+     ".set	push\n\t"
+     ".set	noreorder\n\t"
+     "beqzl	%0,1b\n\t"
+     "ll	%0,%2\n\t"
+     ".set	pop\n\t"
      "/* End atomic add */"
      : "=&r"(result), "=m"(*mem)
      : "m" (*mem), "r"(val)
@@ -69,22 +77,24 @@ static inline int
 __attribute__ ((unused))
 compare_and_swap (volatile long int *p, long int oldval, long int newval)
 {
-  long int ret;
+  long int ret, temp;
 
   __asm__ __volatile__
     ("/* Inline compare & swap */\n\t"
+     "ll	%1,%5\n"
      "1:\n\t"
-     "ll	%0,%4\n\t"
-     ".set	push\n"
+     ".set	push\n\t"
      ".set	noreorder\n\t"
-     "bne	%0,%2,2f\n\t"
-     "move	%0,%3\n\t"
-     ".set	pop\n\t"
-     "sc	%0,%1\n\t"
-     "beqz	%0,1b\n"
+     "bne	%1,%3,2f\n\t"
+     "move	%0,$0\n\t"
+     "move	%0,%4\n\t"
+     "sc	%0,%2\n\t"
+     "beqzl	%0,1b\n\t"
+     "ll	%1,%5\n\t"
+     ".set	pop\n"
      "2:\n\t"
      "/* End compare & swap */"
-     : "=&r" (ret), "=m" (*p)
+     : "=&r" (ret), "=&r" (temp), "=m" (*p)
      : "r" (oldval), "r" (newval), "m" (*p)
      : "memory");
 
--- glibc-2.2.4/sysdeps/unix/sysv/linux/mips/sys/tas.h.llsc	Mon Jul  9 11:58:45 2001
+++ glibc-2.2.4/sysdeps/unix/sysv/linux/mips/sys/tas.h	Fri Feb  1 09:56:47 2002
@@ -42,16 +42,19 @@ _test_and_set (int *p, int v) __THROW
   int r, t;
 
   __asm__ __volatile__
-    ("1:\n\t"
-     "ll	%0,%3\n\t"
+    ("/* Inline test and set */\n\t"
+     "ll	%0,%3\n"
+     "1:\n\t"
      ".set	push\n\t"
      ".set	noreorder\n\t"
      "beq	%0,%4,2f\n\t"
-     " move	%1,%4\n\t"
-     ".set	pop\n\t"
+     "move	%1,%4\n\t"
      "sc	%1,%2\n\t"
-     "beqz	%1,1b\n"
-     "2:\n"
+     "beqzl	%1,1b\n\t"
+     "ll	%0,%3\n\t"
+     ".set	pop\n"
+     "2:\n\t"
+     "/* End test and set */"
      : "=&r" (r), "=&r" (t), "=m" (*p)
      : "m" (*p), "r" (v)
      : "memory");
