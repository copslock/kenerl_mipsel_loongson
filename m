Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0U3fHJ10439
	for linux-mips-outgoing; Tue, 29 Jan 2002 19:41:17 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0U3f8d10435
	for <linux-mips@oss.sgi.com>; Tue, 29 Jan 2002 19:41:08 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id CC6F3125C3; Tue, 29 Jan 2002 18:41:05 -0800 (PST)
Date: Tue, 29 Jan 2002 18:41:05 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: A linuxthreads bug on mips?
Message-ID: <20020129184105.A18386@lucon.org>
References: <20020125234542.A31028@lucon.org> <m3zo2x35bi.fsf@myware.mynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3zo2x35bi.fsf@myware.mynet>; from drepper@redhat.com on Tue, Jan 29, 2002 at 12:54:41AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jan 29, 2002 at 12:54:41AM -0800, Ulrich Drepper wrote:
> "H . J . Lu" <hjl@lucon.org> writes:
> 
> > Here is a modified ex2.c which only uses one conditional variable. It
> > works fine on x86. But it leads to dead lock on mips where both
> > producer and consumer are suspended. Is this testcase correct?
> 
> 
> Therefore your revised code is not acceptable although it probably
> will almost always work.
> 

It seems that the usage of ll/sc in glibc is wrong when they are used
to implement the compare/set operations. With this patch, the testcase
works now on mips when glibc is compiled with -mips2. Could someone
please double check my changes? If they are really correct, I will
verify other ll/sc usages in glibc.

Thanks.


H.J.
-----. 
2002-01-29  H.J. Lu  <hjl@gnu.org>

	* sysdeps/mips/pt-machine.h (testandset): Return 1 when failed
	to set.
	(__compare_and_swap): Return 0 when failed to compare or swap.

--- linuxthreads/sysdeps/mips/pt-machine.h.llsc	Mon Jan 28 18:02:45 2002
+++ linuxthreads/sysdeps/mips/pt-machine.h	Tue Jan 29 16:59:46 2002
@@ -42,16 +42,12 @@ testandset (int *spinlock)
 
   __asm__ __volatile__
     ("/* Inline spinlock test & set */\n\t"
-     "1:\n\t"
      "ll	%0,%3\n\t"
-     ".set	push\n\t"
-     ".set	noreorder\n\t"
-     "bnez	%0,2f\n\t"
-     " li	%1,1\n\t"
-     ".set	pop\n\t"
+     "bnez	%0,1f\n\t"
+     "li	%1,1\n\t"
      "sc	%1,%2\n\t"
-     "beqz	%1,1b\n"
-     "2:\n\t"
+     "sltu	%0,%1,1\n"
+     "1:\n\t"
      "/* End spinlock test & set */"
      : "=&r" (ret), "=&r" (temp), "=m" (*spinlock)
      : "m" (*spinlock)
@@ -84,22 +80,18 @@ register char * stack_pointer __asm__ ("
 PT_EI int
 __compare_and_swap (long int *p, long int oldval, long int newval)
 {
-  long int ret;
+  long int ret, temp;
 
   __asm__ __volatile__
     ("/* Inline compare & swap */\n\t"
+     "move	%0,$0\n\t"
+     "ll	%1,%5\n\t"
+     "bne	%1,%3,1f\n\t"
+     "move	%0,%4\n\t"
+     "sc	%0,%2\n"
      "1:\n\t"
-     "ll	%0,%4\n\t"
-     ".set	push\n"
-     ".set	noreorder\n\t"
-     "bne	%0,%2,2f\n\t"
-     " move	%0,%3\n\t"
-     ".set	pop\n\t"
-     "sc	%0,%1\n\t"
-     "beqz	%0,1b\n"
-     "2:\n\t"
      "/* End compare & swap */"
-     : "=&r" (ret), "=m" (*p)
+     : "=&r" (ret), "=&r" (temp), "=m" (*p)
      : "r" (oldval), "r" (newval), "m" (*p)
      : "memory");
 
