Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11IetR15686
	for linux-mips-outgoing; Fri, 1 Feb 2002 10:40:55 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11IeSd15683
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 10:40:28 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 78793125C3; Fri,  1 Feb 2002 09:40:25 -0800 (PST)
Date: Fri, 1 Feb 2002 09:40:25 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Hiroyuki Machida <machida@sm.sony.co.jp>, libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips
Message-ID: <20020201094025.A10392@lucon.org>
References: <20020201.123523.50041631.machida@sm.sony.co.jp> <Pine.GSO.3.96.1020201124611.26449B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020201124611.26449B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Feb 01, 2002 at 12:50:48PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 01, 2002 at 12:50:48PM +0100, Maciej W. Rozycki wrote:
> On Fri, 1 Feb 2002, Hiroyuki Machida wrote:
> 
> > > It will fail if *p is not same as oldval.
> > 
> > Please note that "sc" may fail even if nobody write the
> > variable. (See P.211 "8.4.2 Load-Linked/Sotre-Conditional" of "See 
> > MIPS RUN" for more detail.) 
> > So, after your patch applied, compare_and_swap() may fail, even if
> > *p is equal to oldval.
> 
>  That's exactly what I meant -- "sc" may fail to execute the store, while
> "cmpxchgl" may not. 
> 

Here is the updated patch.


H.J.
---
2002-01-31  H.J. Lu  <hjl@gnu.org>

	* sysdeps/mips/pspinlock.c (__pthread_spin_lock): Use a
	different register in the delayed slot.

	* sysdeps/mips/pt-machine.h (testandset): Call _test_and_set.
	(__compare_and_swap): Return 0 only when failed to compare.

2002-01-31  H.J. Lu  <hjl@gnu.org>

	* sysdeps/mips/atomicity.h (compare_and_swap): Return 0 only
	when failed to compare.

	* sysdeps/unix/sysv/linux/mips/sys/tas.h (_test_and_set): Fill
	the delay slot.

--- glibc-2.2.4/linuxthreads/sysdeps/mips/pspinlock.c.llsc	Thu Jan 31 10:49:37 2002
+++ glibc-2.2.4/linuxthreads/sysdeps/mips/pspinlock.c	Thu Jan 31 10:49:37 2002
@@ -29,20 +29,21 @@
 int
 __pthread_spin_lock (pthread_spinlock_t *lock)
 {
-  unsigned int tmp;
+  unsigned int tmp1, tmp2;
 
   asm volatile
     ("\t\t\t# spin_lock\n\t"
-     "1:\n\t"
-     "ll	%1,%2\n\t"
      ".set	push\n\t"
-     ".set	noreorder\n\t"
+     ".set	noreorder\n"
+     "1:\n\t"
+     "ll	%1,%3\n\t"
      "bnez	%1,1b\n\t"
-     " li	%1,1\n\t"
-     ".set	pop\n\t"
-     "sc	%1,%0\n\t"
-     "beqz	%1,1b"
-     : "=m" (*lock), "=&r" (tmp)
+     "li	%2,1\n\t"
+     "sc	%2,%0\n\t"
+     "beqz	%2,1b\n\t"
+     "nop\n\t"
+     ".set	pop"
+     : "=m" (*lock), "=&r" (tmp1), "=&r" (tmp2)
      : "m" (*lock)
      : "memory");
 
--- glibc-2.2.4/linuxthreads/sysdeps/mips/pt-machine.h.llsc	Sat Dec  9 08:55:34 2000
+++ glibc-2.2.4/linuxthreads/sysdeps/mips/pt-machine.h	Fri Feb  1 09:19:44 2002
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
-    ("/* Inline compare & swap */\n\t"
+    ("/* Inline compare & swap */\n"
      "1:\n\t"
-     "ll	%0,%4\n\t"
-     ".set	push\n"
+     "ll	%1,%5\n\t"
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
+     "beqz	%0,1b\n\t"
+     "nop\n\t"
+     ".set	pop\n"
      "2:\n\t"
      "/* End compare & swap */"
-     : "=&r" (ret), "=m" (*p)
+     : "=&r" (ret), "=&r" (temp), "=m" (*p)
      : "r" (oldval), "r" (newval), "m" (*p)
      : "memory");
 
--- glibc-2.2.4/sysdeps/mips/atomicity.h.llsc	Mon Jul  9 11:58:19 2001
+++ glibc-2.2.4/sysdeps/mips/atomicity.h	Fri Feb  1 09:21:41 2002
@@ -32,12 +32,16 @@ exchange_and_add (volatile uint32_t *mem
   int result, tmp;
 
   __asm__ __volatile__
-    ("/* Inline exchange & add */\n\t"
+    ("/* Inline exchange & add */\n"
      "1:\n\t"
      "ll	%0,%3\n\t"
      "addu	%1,%4,%0\n\t"
      "sc	%1,%2\n\t"
+     ".set	push\n\t"
+     ".set	noreorder\n\t"
      "beqz	%1,1b\n\t"
+     "nop\n\t"
+     ".set	pop\n\t"
      "/* End exchange & add */"
      : "=&r"(result), "=&r"(tmp), "=m"(*mem)
      : "m" (*mem), "r"(val)
@@ -53,12 +57,16 @@ atomic_add (volatile uint32_t *mem, int 
   int result;
 
   __asm__ __volatile__
-    ("/* Inline atomic add */\n\t"
+    ("/* Inline atomic add */\n"
      "1:\n\t"
      "ll	%0,%2\n\t"
      "addu	%0,%3,%0\n\t"
      "sc	%0,%1\n\t"
+     ".set	push\n\t"
+     ".set	noreorder\n\t"
      "beqz	%0,1b\n\t"
+     "nop\n\t"
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
-    ("/* Inline compare & swap */\n\t"
+    ("/* Inline compare & swap */\n"
      "1:\n\t"
-     "ll	%0,%4\n\t"
-     ".set	push\n"
+     "ll	%1,%5\n\t"
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
+     "beqz	%0,1b\n\t"
+     "nop\n\t"
+     ".set	pop\n"
      "2:\n\t"
      "/* End compare & swap */"
-     : "=&r" (ret), "=m" (*p)
+     : "=&r" (ret), "=&r" (temp), "=m" (*p)
      : "r" (oldval), "r" (newval), "m" (*p)
      : "memory");
 
--- glibc-2.2.4/sysdeps/unix/sysv/linux/mips/sys/tas.h.llsc	Mon Jul  9 11:58:45 2001
+++ glibc-2.2.4/sysdeps/unix/sysv/linux/mips/sys/tas.h	Thu Jan 31 10:49:37 2002
@@ -42,16 +42,17 @@ _test_and_set (int *p, int v) __THROW
   int r, t;
 
   __asm__ __volatile__
-    ("1:\n\t"
+    (".set	push\n\t"
+     ".set	noreorder\n"
+     "1:\n\t"
      "ll	%0,%3\n\t"
-     ".set	push\n\t"
-     ".set	noreorder\n\t"
      "beq	%0,%4,2f\n\t"
-     " move	%1,%4\n\t"
-     ".set	pop\n\t"
+     "move	%1,%4\n\t"
      "sc	%1,%2\n\t"
-     "beqz	%1,1b\n"
-     "2:\n"
+     "beqz	%1,1b\n\t"
+     "nop\n"
+     "2:\n\t"
+     ".set	pop"
      : "=&r" (r), "=&r" (t), "=m" (*p)
      : "m" (*p), "r" (v)
      : "memory");
