Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f85K4qF30674
	for linux-mips-outgoing; Wed, 5 Sep 2001 13:04:52 -0700
Received: from dea.linux-mips.net (u-59-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.59])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f85K4ed30670
	for <linux-mips@oss.sgi.com>; Wed, 5 Sep 2001 13:04:41 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f85K30b09920;
	Wed, 5 Sep 2001 22:03:00 +0200
Date: Wed, 5 Sep 2001 22:03:00 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com
Subject: Re: ret_from_sys_call and signal
Message-ID: <20010905220300.A7552@dea.linux-mips.net>
References: <20010831.152310.104026325.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010831.152310.104026325.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Fri, Aug 31, 2001 at 03:23:10PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 31, 2001 at 03:23:10PM +0900, Atsushi Nemoto wrote:

> After merging with 2.4.6 kernel, ret_from_sys_call (and
> o32_ret_from_sys_call) does not check whether it returns to kernel
> mode or not.
> 
> syscall may happen in kernel mode, so we should check KU_USER bits (as
>  done in past code).  Is this right?
> 
> At least, currently DO_FAULT() jumps to ret_from_sys_call and it may
> cause problems.  If page fault happened in kernel code when any
> signals pending, do_signal() is called before returning to kernel and
> it fails to setup sigcontext.

The changes in entry.S and scall_o32.S were correct; they match the
changing in the i386 code.  The idea is to avoid the usermode check if
possible.  I just lost the matching changes to other files.  Untested
patch below.  Tell me if it helps.

  Ralf

Index: arch/mips64/kernel/r4k_tlb_glue.S
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips64/kernel/r4k_tlb_glue.S,v
retrieving revision 1.10
diff -u -r1.10 r4k_tlb_glue.S
--- arch/mips64/kernel/r4k_tlb_glue.S 2001/09/05 19:13:24 1.10  
+++ arch/mips64/kernel/r4k_tlb_glue.S 2001/09/05 19:39:18   
@@ -29,7 +29,7 @@
 	sd	a2, PT_BVADDR(sp)
 	move	a0, sp
 	jal	do_page_fault
-	j	ret_from_sys_call
+	j	ret_from_exception
 	END(__\name)
 	.endm
 
Index: arch/mips/kernel/r2300_misc.S
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/kernel/r2300_misc.S,v
retrieving revision 1.9
diff -u -r1.9 r2300_misc.S
--- arch/mips/kernel/r2300_misc.S 2000/03/07 15:45:28 1.9  
+++ arch/mips/kernel/r2300_misc.S 2001/09/05 19:39:18   
@@ -1,4 +1,4 @@
-/* $Id: r2300_misc.S,v 1.8 1999/12/08 22:05:10 harald Exp $
+/*
  * misc.S: Misc. exception handling code for R3000/R2000.
  *
  * Copyright (C) 1994, 1995, 1996 by Ralf Baechle and Andreas Busse
@@ -9,6 +9,8 @@
  * Further modifications to make this work:
  * Copyright (c) 1998 Harald Koerfgen
  * Copyright (c) 1998, 1999 Gleb Raiko & Vladimir Roganov
+ * Copyright (c) 2001 Ralf Baechle
+ * Copyright (c) 2001 MIPS Technologies, Inc.
  */
 #include <asm/asm.h>
 #include <asm/current.h>
@@ -68,7 +70,7 @@
 	move	a0, sp; \
 	jal	do_page_fault; \
 	 li	a1, write; \
-	j	ret_from_sys_call; \
+	j	ret_from_exception; \
 	 nop; \
 	.set	noat; \
 	.set	nomacro;
Index: arch/mips/kernel/r4k_misc.S
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/kernel/r4k_misc.S,v
retrieving revision 1.11
diff -u -r1.11 r4k_misc.S
--- arch/mips/kernel/r4k_misc.S 2001/03/28 01:35:12 1.11  
+++ arch/mips/kernel/r4k_misc.S 2001/09/05 19:39:18   
@@ -1,5 +1,4 @@
-/* $Id: r4k_misc.S,v 1.8 1999/10/09 00:00:58 ralf Exp $
- *
+/*
  * r4k_misc.S: Misc. exception handling code for r4k.
  *
  * Copyright (C) 1994, 1995, 1996 by Ralf Baechle and Andreas Busse
@@ -86,7 +85,7 @@
 	move	a0, sp; \
 	jal	do_page_fault; \
 	 li	a1, write; \
-	j	ret_from_sys_call; \
+	j	ret_from_exception; \
 	 nop; \
 	.set	noat;
 
