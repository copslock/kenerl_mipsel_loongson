Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jul 2004 23:57:03 +0100 (BST)
Received: from p508B70D0.dip.t-dialin.net ([IPv6:::ffff:80.139.112.208]:58661
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224949AbUGOW47>; Thu, 15 Jul 2004 23:56:59 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i6FMuwVH032434;
	Fri, 16 Jul 2004 00:56:58 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i6FMuvf4032433;
	Fri, 16 Jul 2004 00:56:57 +0200
Date: Fri, 16 Jul 2004 00:56:57 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Song Wang <wsonguci@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: asm-mips/processor.h breaks compiling user applications such as iptables
Message-ID: <20040715225657.GA17585@linux-mips.org>
References: <20040715222234.16094.qmail@web40007.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040715222234.16094.qmail@web40007.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 15, 2004 at 03:22:34PM -0700, Song Wang wrote:

> I think the error is due to the line 146
> 
> typedef u64 fpureg_t;
> 
> The type 'u64' is defined in asm-mips/types.h, but
> wrapped by #ifdef __KERNEL__, so when the compiler
> compiles the user-level application, it cannot
> recognize u64.

Correct.  In general the policy is to avoid the use of kernel header
files in user space and copy it but there are still a few crucial tools
that don't follow this rule of Linus, so try below patch.  It also
removes the __KERNEL__ things left.

Cleaning up the use of kernel header to make them more usable for
userspace is one of the things on the agenda for 2.7.  It'll be alot of
hard and boring work but MIPS will be one of the architectures that will
greatly benefit from this.

  Ralf

Index: include/asm-mips/processor.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/processor.h,v
retrieving revision 1.94
diff -u -r1.94 processor.h
--- include/asm-mips/processor.h	28 Jun 2004 21:04:16 -0000	1.94
+++ include/asm-mips/processor.h	15 Jul 2004 22:42:29 -0000
@@ -143,7 +143,7 @@
 
 #define NUM_FPU_REGS	32
 
-typedef u64 fpureg_t;
+typedef __u64 fpureg_t;
 
 struct mips_fpu_hard_struct {
 	fpureg_t	fpr[NUM_FPU_REGS];
@@ -235,8 +235,6 @@
 	MF_FIXADE, 0, 0 \
 }
 
-#ifdef __KERNEL__
-
 struct task_struct;
 
 /* Free all resources held by a thread. */
@@ -264,8 +262,6 @@
 
 #define cpu_relax()	barrier()
 
-#endif /* __KERNEL__ */
-
 /*
  * Return_address is a replacement for __builtin_return_address(count)
  * which on certain architectures cannot reasonably be implemented in GCC
