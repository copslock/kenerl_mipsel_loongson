Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15JUaF30901
	for linux-mips-outgoing; Tue, 5 Feb 2002 11:30:36 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15JUIA30898
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 11:30:18 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 5C5A5125CC; Tue,  5 Feb 2002 11:30:17 -0800 (PST)
Date: Tue, 5 Feb 2002 11:30:17 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Dominic Sweetman <dom@algor.co.uk>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Message-ID: <20020205113017.A6144@lucon.org>
References: <20020201222657.A13339@nevyn.them.org> <1012676003.1563.6.camel@xyzzy.stargate.net> <20020202120354.A1522@lucon.org> <mailpost.1012680250.7159@news-sj1-1> <yov5ofj65elj.fsf@broadcom.com> <15454.22661.855423.532827@gladsmuir.algor.co.uk> <20020204083115.C13384@lucon.org> <15454.47823.837119.847975@gladsmuir.algor.co.uk> <20020204172857.A22337@lucon.org> <20020204215804.A2095@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020204215804.A2095@nevyn.them.org>; from dan@debian.org on Mon, Feb 04, 2002 at 09:58:04PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 04, 2002 at 09:58:04PM -0500, Daniel Jacobowitz wrote:
> On Mon, Feb 04, 2002 at 05:28:57PM -0800, H . J . Lu wrote:
> > On Mon, Feb 04, 2002 at 04:46:07PM +0000, Dominic Sweetman wrote:
> > > 
> > > H . J . Lu (hjl@lucon.org) writes:
> > > 
> > > > I can change glibc not to use branch-likely without using nop. But it
> > > > may require one or two instructions outside of the loop. Should I do
> > > > it given what we know now?
> > > 
> > > I would not recommend using "branch likely" in assembler coding, if
> > > that's what you're asking.
> > > 
> > 
> > Here is a patch to remove branch likely. But I couldn't find a way
> > not to fill the delay slot with nop. BTW, is that safe to remove
> > ".set noreorder"?
> 
> You mean, if there is nothing which can be put there?  Yes, it's safe.
> 

Here is a new patch. I removed the extra "ll" in the delay slot.


H.J.
---
2002-02-05  H.J. Lu  <hjl@gnu.org>

	* sysdeps/mips/pspinlock.c (__pthread_spin_lock): Not use
	branch likely. Remove ".set noreorder".
	* sysdeps/mips/pt-machine.h (testandset): Liekwise.
	(__compare_and_swap): Liekwise.

2002-02-05  H.J. Lu  <hjl@gnu.org>

	* sysdeps/mips/atomicity.h (exchange_and_add): Not use branch
	likely. Remove ".set noreorder".
	(atomic_add): Likewise.
	(compare_and_swap): Likewise.
	* sysdeps/unix/sysv/linux/mips/sys/tas.h (_test_and_set):
	Likewise.

--- libc/linuxthreads/sysdeps/mips/pspinlock.c.llsc	Mon Feb  4 13:45:01 2002
+++ libc/linuxthreads/sysdeps/mips/pspinlock.c	Tue Feb  5 11:26:22 2002
@@ -32,17 +32,13 @@ __pthread_spin_lock (pthread_spinlock_t 
   unsigned int tmp1, tmp2;
 
   asm volatile
-    ("\t\t\t# spin_lock\n\t"
-     "ll	%1,%3\n"
+    ("\t\t\t# spin_lock\n"
      "1:\n\t"
-     ".set	push\n\t"
-     ".set	noreorder\n\t"
+     "ll	%1,%3\n"
      "bnez	%1,1b\n\t"
      " li	%2,1\n\t"
      "sc	%2,%0\n\t"
-     "beqzl	%2,1b\n\t"
-     " ll	%1,%3\n\t"
-     ".set	pop"
+     "beqz	%2,1b\n\t"
      : "=m" (*lock), "=&r" (tmp1), "=&r" (tmp2)
      : "m" (*lock)
      : "memory");
--- libc/linuxthreads/sysdeps/mips/pt-machine.h.llsc	Mon Feb  4 13:45:01 2002
+++ libc/linuxthreads/sysdeps/mips/pt-machine.h	Tue Feb  5 11:26:51 2002
@@ -57,18 +57,14 @@ __compare_and_swap (long int *p, long in
   long int ret, temp;
 
   __asm__ __volatile__
-    ("/* Inline compare & swap */\n\t"
-     "ll	%1,%5\n"
+    ("/* Inline compare & swap */\n"
      "1:\n\t"
-     ".set	push\n\t"
-     ".set	noreorder\n\t"
+     "ll	%1,%5\n"
      "bne	%1,%3,2f\n\t"
      " move	%0,$0\n\t"
      "move	%0,%4\n\t"
      "sc	%0,%2\n\t"
-     "beqzl	%0,1b\n\t"
-     " ll	%1,%5\n\t"
-     ".set	pop\n"
+     "beqz	%0,1b\n\t"
      "2:\n\t"
      "/* End compare & swap */"
      : "=&r" (ret), "=&r" (temp), "=m" (*p)
--- libc/sysdeps/mips/atomicity.h.llsc	Mon Feb  4 13:45:18 2002
+++ libc/sysdeps/mips/atomicity.h	Tue Feb  5 11:25:09 2002
@@ -32,16 +32,12 @@ exchange_and_add (volatile uint32_t *mem
   int result, tmp;
 
   __asm__ __volatile__
-    ("/* Inline exchange & add */\n\t"
+    ("/* Inline exchange & add */\n"
+     "1:\n"
      "ll	%0,%3\n"
-     "1:\n\t"
      "addu	%1,%4,%0\n\t"
      "sc	%1,%2\n\t"
-     ".set	push\n\t"
-     ".set	noreorder\n\t"
-     "beqzl	%1,1b\n\t"
-     " ll	%0,%3\n\t"
-     ".set	pop\n\t"
+     "beqz	%1,1b\n\t"
      "/* End exchange & add */"
      : "=&r"(result), "=&r"(tmp), "=m"(*mem)
      : "m" (*mem), "r"(val)
@@ -57,16 +53,12 @@ atomic_add (volatile uint32_t *mem, int 
   int result;
 
   __asm__ __volatile__
-    ("/* Inline atomic add */\n\t"
-     "ll	%0,%2\n"
+    ("/* Inline atomic add */\n"
      "1:\n\t"
+     "ll	%0,%2\n"
      "addu	%0,%3,%0\n\t"
      "sc	%0,%1\n\t"
-     ".set	push\n\t"
-     ".set	noreorder\n\t"
-     "beqzl	%0,1b\n\t"
-     " ll	%0,%2\n\t"
-     ".set	pop\n\t"
+     "beqz	%0,1b\n\t"
      "/* End atomic add */"
      : "=&r"(result), "=m"(*mem)
      : "m" (*mem), "r"(val)
@@ -80,18 +72,14 @@ compare_and_swap (volatile long int *p, 
   long int ret, temp;
 
   __asm__ __volatile__
-    ("/* Inline compare & swap */\n\t"
-     "ll	%1,%5\n"
+    ("/* Inline compare & swap */\n"
      "1:\n\t"
-     ".set	push\n\t"
-     ".set	noreorder\n\t"
+     "ll	%1,%5\n"
      "bne	%1,%3,2f\n\t"
      " move	%0,$0\n\t"
      "move	%0,%4\n\t"
      "sc	%0,%2\n\t"
-     "beqzl	%0,1b\n\t"
-     " ll	%1,%5\n\t"
-     ".set	pop\n"
+     "beqz	%0,1b\n\t"
      "2:\n\t"
      "/* End compare & swap */"
      : "=&r" (ret), "=&r" (temp), "=m" (*p)
--- libc/sysdeps/unix/sysv/linux/mips/sys/tas.h.llsc	Mon Feb  4 13:45:28 2002
+++ libc/sysdeps/unix/sysv/linux/mips/sys/tas.h	Tue Feb  5 11:25:34 2002
@@ -42,17 +42,13 @@ _test_and_set (int *p, int v) __THROW
   int r, t;
 
   __asm__ __volatile__
-    ("/* Inline test and set */\n\t"
-     "ll	%0,%3\n"
+    ("/* Inline test and set */\n"
      "1:\n\t"
-     ".set	push\n\t"
-     ".set	noreorder\n\t"
+     "ll	%0,%3\n"
      "beq	%0,%4,2f\n\t"
      " move	%1,%4\n\t"
      "sc	%1,%2\n\t"
-     "beqzl	%1,1b\n\t"
-     " ll	%0,%3\n\t"
-     ".set	pop\n"
+     "beqz	%1,1b\n\t"
      "2:\n\t"
      "/* End test and set */"
      : "=&r" (r), "=&r" (t), "=m" (*p)
