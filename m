Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g17HDdQ27274
	for linux-mips-outgoing; Thu, 7 Feb 2002 09:13:39 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g17HDSA27271
	for <linux-mips@oss.sgi.com>; Thu, 7 Feb 2002 09:13:28 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id DC9E0125C8; Thu,  7 Feb 2002 09:13:27 -0800 (PST)
Date: Thu, 7 Feb 2002 09:13:27 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Andreas Jaeger <aj@suse.de>
Cc: linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Not use branch likely on mips
Message-ID: <20020207091327.B15331@lucon.org>
References: <20020205180243.A11993@lucon.org> <hoadulk25q.fsf@gee.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <hoadulk25q.fsf@gee.suse.de>; from aj@suse.de on Thu, Feb 07, 2002 at 11:38:09AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Feb 07, 2002 at 11:38:09AM +0100, Andreas Jaeger wrote:
> "H . J . Lu" <hjl@lucon.org> writes:
> 
> > This patch removes branch likely.
> 
> Please update the copyright years next time.
> 
> I've committed the patch,
> 

Here is a new patch. I have checked in a gcc patch which makes
".set noreorder" unnecessary even with "gcc -g".

Thanks.


H.J.
----
2002-02-07  H.J. Lu  <hjl@gnu.org>

	* sysdeps/mips/pspinlock.c (__pthread_spin_lock): Silence the
	gcc warning.
	(__pthread_spin_lock): Remove ".set noreorder".
	* sysdeps/mips/pt-machine.h (__compare_and_swap): Liekwise.

2002-02-07  H.J. Lu  <hjl@gnu.org>

	* sysdeps/mips/atomicity.h (compare_and_swap): Remove
	".set noreorder".
	* sysdeps/unix/sysv/linux/mips/sys/tas.h (_test_and_set):
	Likewise.

--- libc/linuxthreads/sysdeps/mips/pspinlock.c.llsc	Thu Feb  7 08:48:57 2002
+++ libc/linuxthreads/sysdeps/mips/pspinlock.c	Wed Feb  6 12:12:50 2002
@@ -35,11 +35,8 @@ __pthread_spin_lock (pthread_spinlock_t 
     ("\t\t\t# spin_lock\n"
      "1:\n\t"
      "ll	%1,%3\n\t"
-     ".set	push\n\t"
-     ".set	noreorder\n\t"
+     "li	%2,1\n\t"
      "bnez	%1,1b\n\t"
-     " li	%2,1\n\t"
-     ".set	pop\n\t"
      "sc	%2,%0\n\t"
      "beqz	%2,1b"
      : "=m" (*lock), "=&r" (tmp1), "=&r" (tmp2)
@@ -54,7 +51,7 @@ __pthread_spin_lock (pthread_spinlock_t 
 int
 __pthread_spin_lock (pthread_spinlock_t *lock)
 {
-  while (_test_and_set (lock, 1));
+  while (_test_and_set ((int *) lock, 1));
   return 0;
 }
 
--- libc/linuxthreads/sysdeps/mips/pt-machine.h.llsc	Thu Feb  7 08:48:57 2002
+++ libc/linuxthreads/sysdeps/mips/pt-machine.h	Wed Feb  6 12:12:50 2002
@@ -60,11 +60,8 @@ __compare_and_swap (long int *p, long in
     ("/* Inline compare & swap */\n"
      "1:\n\t"
      "ll	%1,%5\n\t"
-     ".set	push\n\t"
-     ".set	noreorder\n\t"
+     "move	%0,$0\n\t"
      "bne	%1,%3,2f\n\t"
-     " move	%0,$0\n\t"
-     ".set	pop\n\t"
      "move	%0,%4\n\t"
      "sc	%0,%2\n\t"
      "beqz	%0,1b\n"
--- libc/sysdeps/mips/atomicity.h.llsc	Thu Feb  7 08:50:14 2002
+++ libc/sysdeps/mips/atomicity.h	Wed Feb  6 12:12:50 2002
@@ -75,11 +75,8 @@ compare_and_swap (volatile long int *p, 
     ("/* Inline compare & swap */\n"
      "1:\n\t"
      "ll	%1,%5\n\t"
-     ".set	push\n\t"
-     ".set	noreorder\n\t"
+     "move	%0,$0\n\t"
      "bne	%1,%3,2f\n\t"
-     " move	%0,$0\n\t"
-     ".set	pop\n\t"
      "move	%0,%4\n\t"
      "sc	%0,%2\n\t"
      "beqz	%0,1b\n"
--- libc/sysdeps/unix/sysv/linux/mips/sys/tas.h.llsc	Thu Feb  7 08:50:15 2002
+++ libc/sysdeps/unix/sysv/linux/mips/sys/tas.h	Wed Feb  6 12:12:50 2002
@@ -45,11 +45,8 @@ _test_and_set (int *p, int v) __THROW
     ("/* Inline test and set */\n"
      "1:\n\t"
      "ll	%0,%3\n\t"
-     ".set	push\n\t"
-     ".set	noreorder\n\t"
+     "move	%1,%4\n\t"
      "beq	%0,%4,2f\n\t"
-     " move	%1,%4\n\t"
-     ".set	pop\n\t"
      "sc	%1,%2\n\t"
      "beqz	%1,1b\n"
      "2:\n\t"
