Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g16234e05019
	for linux-mips-outgoing; Tue, 5 Feb 2002 18:03:04 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1622jA05015
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 18:02:45 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 81605125C8; Tue,  5 Feb 2002 18:02:43 -0800 (PST)
Date: Tue, 5 Feb 2002 18:02:43 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>
Subject: PATCH: Not use branch likely on mips
Message-ID: <20020205180243.A11993@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This patch removes branch likely.


H.J.
----
2002-02-05  H.J. Lu  <hjl@gnu.org>

	* sysdeps/mips/pspinlock.c (__pthread_spin_lock): Not use
	branch likely.
	* sysdeps/mips/pt-machine.h (testandset): Liekwise.
	(__compare_and_swap): Liekwise.

2002-02-05  H.J. Lu  <hjl@gnu.org>

	* sysdeps/mips/atomicity.h (exchange_and_add): Not use branch
	likely.
	(atomic_add): Likewise.
	(compare_and_swap): Likewise.
	* sysdeps/unix/sysv/linux/mips/sys/tas.h (_test_and_set):
	Likewise.

--- libc/linuxthreads/sysdeps/mips/pspinlock.c.llsc	Mon Feb  4 13:45:01 2002
+++ libc/linuxthreads/sysdeps/mips/pspinlock.c	Tue Feb  5 14:11:01 2002
@@ -32,17 +32,16 @@ __pthread_spin_lock (pthread_spinlock_t 
   unsigned int tmp1, tmp2;
 
   asm volatile
-    ("\t\t\t# spin_lock\n\t"
-     "ll	%1,%3\n"
+    ("\t\t\t# spin_lock\n"
      "1:\n\t"
+     "ll	%1,%3\n\t"
      ".set	push\n\t"
      ".set	noreorder\n\t"
      "bnez	%1,1b\n\t"
      " li	%2,1\n\t"
+     ".set	pop\n\t"
      "sc	%2,%0\n\t"
-     "beqzl	%2,1b\n\t"
-     " ll	%1,%3\n\t"
-     ".set	pop"
+     "beqz	%2,1b"
      : "=m" (*lock), "=&r" (tmp1), "=&r" (tmp2)
      : "m" (*lock)
      : "memory");
--- libc/linuxthreads/sysdeps/mips/pt-machine.h.llsc	Mon Feb  4 13:45:01 2002
+++ libc/linuxthreads/sysdeps/mips/pt-machine.h	Tue Feb  5 14:01:11 2002
@@ -57,18 +57,17 @@ __compare_and_swap (long int *p, long in
   long int ret, temp;
 
   __asm__ __volatile__
-    ("/* Inline compare & swap */\n\t"
-     "ll	%1,%5\n"
+    ("/* Inline compare & swap */\n"
      "1:\n\t"
+     "ll	%1,%5\n\t"
      ".set	push\n\t"
      ".set	noreorder\n\t"
      "bne	%1,%3,2f\n\t"
      " move	%0,$0\n\t"
+     ".set	pop\n\t"
      "move	%0,%4\n\t"
      "sc	%0,%2\n\t"
-     "beqzl	%0,1b\n\t"
-     " ll	%1,%5\n\t"
-     ".set	pop\n"
+     "beqz	%0,1b\n"
      "2:\n\t"
      "/* End compare & swap */"
      : "=&r" (ret), "=&r" (temp), "=m" (*p)
--- libc/sysdeps/mips/atomicity.h.llsc	Mon Feb  4 13:45:18 2002
+++ libc/sysdeps/mips/atomicity.h	Tue Feb  5 13:58:59 2002
@@ -32,16 +32,12 @@ exchange_and_add (volatile uint32_t *mem
   int result, tmp;
 
   __asm__ __volatile__
-    ("/* Inline exchange & add */\n\t"
-     "ll	%0,%3\n"
+    ("/* Inline exchange & add */\n"
      "1:\n\t"
+     "ll	%0,%3\n\t"
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
+     "ll	%0,%2\n\t"
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
@@ -80,18 +72,17 @@ compare_and_swap (volatile long int *p, 
   long int ret, temp;
 
   __asm__ __volatile__
-    ("/* Inline compare & swap */\n\t"
-     "ll	%1,%5\n"
+    ("/* Inline compare & swap */\n"
      "1:\n\t"
+     "ll	%1,%5\n\t"
      ".set	push\n\t"
      ".set	noreorder\n\t"
      "bne	%1,%3,2f\n\t"
      " move	%0,$0\n\t"
+     ".set	pop\n\t"
      "move	%0,%4\n\t"
      "sc	%0,%2\n\t"
-     "beqzl	%0,1b\n\t"
-     " ll	%1,%5\n\t"
-     ".set	pop\n"
+     "beqz	%0,1b\n"
      "2:\n\t"
      "/* End compare & swap */"
      : "=&r" (ret), "=&r" (temp), "=m" (*p)
--- libc/sysdeps/unix/sysv/linux/mips/sys/tas.h.llsc	Mon Feb  4 13:45:28 2002
+++ libc/sysdeps/unix/sysv/linux/mips/sys/tas.h	Tue Feb  5 13:59:52 2002
@@ -42,17 +42,16 @@ _test_and_set (int *p, int v) __THROW
   int r, t;
 
   __asm__ __volatile__
-    ("/* Inline test and set */\n\t"
-     "ll	%0,%3\n"
+    ("/* Inline test and set */\n"
      "1:\n\t"
+     "ll	%0,%3\n\t"
      ".set	push\n\t"
      ".set	noreorder\n\t"
      "beq	%0,%4,2f\n\t"
      " move	%1,%4\n\t"
+     ".set	pop\n\t"
      "sc	%1,%2\n\t"
-     "beqzl	%1,1b\n\t"
-     " ll	%0,%3\n\t"
-     ".set	pop\n"
+     "beqz	%1,1b\n"
      "2:\n\t"
      "/* End test and set */"
      : "=&r" (r), "=&r" (t), "=m" (*p)
