Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Dec 2004 03:14:27 +0000 (GMT)
Received: from adsl-67-116-42-149.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.149]:42811
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8225410AbULCDOV>;
	Fri, 3 Dec 2004 03:14:21 +0000
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 2 Dec 2004 19:14:14 -0800
Message-ID: <41AFDA18.2010906@avtrex.com>
Date: Thu, 02 Dec 2004 19:14:32 -0800
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: [Patch] make 2.4 compile with GCC-3.4.3...
Content-Type: multipart/mixed;
 boundary="------------090103050205020004030400"
X-OriginalArrivalTime: 03 Dec 2004 03:14:14.0239 (UTC) FILETIME=[2A9F7EF0:01C4D8E6]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090103050205020004030400
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I just upgraded to the most recent 2.4.29-pre1 sources from the CVS archive
 with the intent of being able to compile with gcc-3.4.3.

It turns out that the compiler is splitting:

 save_static_function(sys_fork);
 static_unused int _sys_fork(struct pt_regs regs)

The result being an unusable kernel.

I think that this issue has been discussed before, but I couldn't find the
solution in the mail group.  So I applied this small hack.  The
modifications to syscall.c and signal.c may not be necessary, but I
borrowed them from the 2.6 tree in hopes of fixing the problem and then
moved to the Makefile change.

It may be that only the Makefile change is necessary (I suspect so), but I
have not tried it alone.

The CVS versions in the diff are from my local cvs and do not correspond to
the linux-mips.org CVS.

David Daney.

--------------090103050205020004030400
Content-Type: text/plain;
 name="uat.d"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uat.d"

Index: kernel/Makefile
===================================================================
RCS file: /linux/linux/arch/mips/kernel/Makefile,v
retrieving revision 1.2
diff -c -p -r1.2 Makefile
*** kernel/Makefile	2 Dec 2004 19:50:05 -0000	1.2
--- kernel/Makefile	3 Dec 2004 03:00:44 -0000
*************** obj-y		+= branch.o cpu-probe.o irq.o pro
*** 18,23 ****
--- 18,27 ----
  		   traps.o ptrace.o reset.o semaphore.o setup.o syscall.o \
  		   sysmips.o ipc.o scall_o32.o time.o unaligned.o
  
+ check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+ 
+ syscall.o signal.o : override CFLAGS += $(call check_gcc, -fno-unit-at-a-time,)
+ 
  obj-$(CONFIG_MODULES)		+= mips_ksyms.o
  
  obj-$(CONFIG_CPU_R3000)		+= r2300_fpu.o r2300_switch.o
Index: kernel/signal.c
===================================================================
RCS file: /linux/linux/arch/mips/kernel/signal.c,v
retrieving revision 1.1.1.2
diff -c -p -r1.1.1.2 signal.c
*** kernel/signal.c	1 Dec 2004 21:50:39 -0000	1.1.1.2
--- kernel/signal.c	3 Dec 2004 03:00:44 -0000
***************
*** 18,23 ****
--- 18,24 ----
  #include <linux/errno.h>
  #include <linux/wait.h>
  #include <linux/unistd.h>
+ #include <linux/compiler.h>
  
  #include <asm/asm.h>
  #include <asm/bitops.h>
*************** int copy_siginfo_to_user(siginfo_t *to, 
*** 76,82 ****
   * Atomically swap in the new signal mask, and wait for a signal.
   */
  save_static_function(sys_sigsuspend);
! static_unused int _sys_sigsuspend(struct pt_regs regs)
  {
  	sigset_t *uset, saveset, newset;
  
--- 77,84 ----
   * Atomically swap in the new signal mask, and wait for a signal.
   */
  save_static_function(sys_sigsuspend);
! __attribute_used__ static int
! _sys_sigsuspend(struct pt_regs regs)
  {
  	sigset_t *uset, saveset, newset;
  
*************** static_unused int _sys_sigsuspend(struct
*** 102,108 ****
  }
  
  save_static_function(sys_rt_sigsuspend);
! static_unused int _sys_rt_sigsuspend(struct pt_regs regs)
  {
  	sigset_t *unewset, saveset, newset;
          size_t sigsetsize;
--- 104,111 ----
  }
  
  save_static_function(sys_rt_sigsuspend);
! __attribute_used__ static int
! _sys_rt_sigsuspend(struct pt_regs regs)
  {
  	sigset_t *unewset, saveset, newset;
          size_t sigsetsize;
Index: kernel/syscall.c
===================================================================
RCS file: /linux/linux/arch/mips/kernel/syscall.c,v
retrieving revision 1.1.1.2
diff -c -p -r1.1.1.2 syscall.c
*** kernel/syscall.c	1 Dec 2004 21:50:39 -0000	1.1.1.2
--- kernel/syscall.c	3 Dec 2004 03:00:44 -0000
***************
*** 25,30 ****
--- 25,31 ----
  #include <linux/slab.h>
  #include <linux/utsname.h>
  #include <linux/unistd.h>
+ #include <linux/compiler.h>
  #include <asm/branch.h>
  #include <asm/offset.h>
  #include <asm/ptrace.h>
*************** sys_mmap2(unsigned long addr, unsigned l
*** 158,164 ****
  }
  
  save_static_function(sys_fork);
! static_unused int _sys_fork(struct pt_regs regs)
  {
  	int res;
  
--- 159,166 ----
  }
  
  save_static_function(sys_fork);
! __attribute_used__ static int
! _sys_fork(struct pt_regs regs)
  {
  	int res;
  
*************** static_unused int _sys_fork(struct pt_re
*** 168,174 ****
  
  
  save_static_function(sys_clone);
! static_unused int _sys_clone(struct pt_regs regs)
  {
  	unsigned long clone_flags;
  	unsigned long newsp;
--- 170,177 ----
  
  
  save_static_function(sys_clone);
! __attribute_used__ static int
! _sys_clone(struct pt_regs regs)
  {
  	unsigned long clone_flags;
  	unsigned long newsp;

--------------090103050205020004030400--
