Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4LNDXZ23525
	for linux-mips-outgoing; Mon, 21 May 2001 16:13:33 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4LNDVF23522
	for <linux-mips@oss.sgi.com>; Mon, 21 May 2001 16:13:31 -0700
Received: from mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4LNDM017628;
	Mon, 21 May 2001 16:13:22 -0700
Message-ID: <3B09A074.2010809@mvista.com>
Date: Mon, 21 May 2001 16:10:44 -0700
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i586; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: en
MIME-Version: 1.0
To: George Gensure <werkt@csh.rit.edu>
CC: linux-mips@oss.sgi.com
Subject: Re: newest kernel
References: <3B099A91.5030300@csh.rit.edu>
Content-Type: multipart/mixed;
 boundary="------------070109020602010607080208"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------070109020602010607080208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

George Gensure wrote:

> I build the 2.4.3 #5 kernel from the CVS source, and have had some  
> trouble with specific programs.  I get illegal instruction errors on  
> find and tar.  Is there anything I can do to correct this?

I'm guessing you're running into the sys_sysmips problem. A patch has 
not yet been applied to the oss.sgi.com kernel.  I've attached a patch 
from Florian that seems to work well and should apply cleanly.

Pete

--------------070109020602010607080208
Content-Type: text/plain;
 name="sysmips_02.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysmips_02.patch"

diff -Nur linux.orig/arch/mips/kernel/Makefile linux/arch/mips/kernel/Makefile
--- linux.orig/arch/mips/kernel/Makefile	Mon Apr  9 00:23:08 2001
+++ linux/arch/mips/kernel/Makefile	Mon Apr  9 00:23:34 2001
@@ -20,7 +20,7 @@
 obj-y				+= branch.o process.o signal.o entry.o \
 				   traps.o ptrace.o vm86.o ioport.o reset.o \
 				   semaphore.o setup.o syscall.o sysmips.o \
-				   ipc.o scall_o32.o unaligned.o
+				   ipc.o scall_o32.o unaligned.o fast-sysmips.o
 obj-$(CONFIG_MODULES)		+= mips_ksyms.o
 
 ifdef CONFIG_CPU_R3000
@@ -69,5 +69,6 @@
 
 entry.o: entry.S
 head.o: head.S
+fast-sysmips.o: fast-sysmips.S
 
 include $(TOPDIR)/Rules.make
diff -Nur linux.orig/arch/mips/kernel/fast-sysmips.S linux/arch/mips/kernel/fast-sysmips.S
--- linux.orig/arch/mips/kernel/fast-sysmips.S	Thu Jan  1 01:00:00 1970
+++ linux/arch/mips/kernel/fast-sysmips.S	Mon Apr  9 00:28:20 2001
@@ -0,0 +1,85 @@
+/*
+ * MIPS_ATOMIC_SET asm implementation for ll/sc capable cpus
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2001 Florian Lohoff <flo@rfc822.org>
+ *
+ */
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include <asm/isadep.h>
+#include <asm/unistd.h>
+#include <asm/sysmips.h>
+#include <asm/offset.h>
+#include <asm/errno.h>
+
+#define PT_TRACESYS     0x00000002
+
+	EXPORT(fast_sysmips)
+
+	.set	noreorder
+
+	li	t0, MIPS_ATOMIC_SET
+	beq	a0, t0, 1f
+	 nop
+	j	sys_sysmips
+	 nop
+
+1:
+
+	# a0 - MIPS_ATOMIC_SET
+	# a1 - mem ptr
+	# a2 - value
+
+	addiu	sp, sp, -8			# Reserve space
+	sw	a0, (sp)			# Save arg0
+
+	addiu	a0, a1, 4			# addr+size
+	ori	v0, a1, 4			# addr | size
+	lw	v1, THREAD_CURDS(gp)		# current->thread.current_ds
+	or	v0, v0, a0			# addr | size | (addr+size)
+	and	v1, v1, v0			# (mask)&(addr | size | (addr+size)
+	bltz	v1, 5f
+	 nop
+
+2:
+	ll	v0, (a1)
+	move	t0, a2
+	sc	t0, (a1)
+	beqz	t0, 2b
+	 nop
+
+	sw	v0, PT_R2+8(sp)			# Result value
+	sw	zero, PT_R7+8(sp)		# Success indicator
+
+	lw      t0, TASK_PTRACE(gp)		# syscall tracing enabled?
+	andi    t0, PT_TRACESYS
+	bnez    t0, 3f
+	 nop
+
+4:
+	lw	a0, (sp)			# Restore arg0
+	addiu	sp, sp, 8			# Restore sp
+
+	j	o32_ret_from_sys_call
+	 nop
+
+3:
+	sw	ra, 4(sp)
+	jal	syscall_trace
+	 nop
+	lw	ra, 4(sp)
+	j	4b
+	 nop
+
+5:
+	lw	a0, (sp)			# Restore arg0
+	addiu	sp, sp, 8			# Restore sp
+	j	ra
+	 li	v0, -EFAULT
+
diff -Nur linux.orig/arch/mips/kernel/irix5sys.h linux/arch/mips/kernel/irix5sys.h
--- linux.orig/arch/mips/kernel/irix5sys.h	Mon Apr  9 00:16:29 2001
+++ linux/arch/mips/kernel/irix5sys.h	Sun Apr  8 21:21:16 2001
@@ -69,7 +69,7 @@
 SYS(irix_getgid, 0)			/* 1047  getgid()	       V*/
 SYS(irix_unimp, 0)			/* 1048  (XXX IRIX 4 ssig)     V*/
 SYS(irix_msgsys, 6)			/* 1049  sys_msgsys	       V*/
-SYS(sys_sysmips, 4)			/* 1050  sysmips()	      HV*/
+SYS(fast_sysmips, 4)			/* 1050  sysmips()	      HV*/
 SYS(irix_unimp, 0)			/* 1051	 XXX sysacct()	      IV*/
 SYS(irix_shmsys, 5)			/* 1052  sys_shmsys	       V*/
 SYS(irix_semsys, 0)			/* 1053  sys_semsys	       V*/
diff -Nur linux.orig/arch/mips/kernel/syscalls.h linux/arch/mips/kernel/syscalls.h
--- linux.orig/arch/mips/kernel/syscalls.h	Mon Apr  9 00:16:30 2001
+++ linux/arch/mips/kernel/syscalls.h	Sun Apr  8 21:21:43 2001
@@ -163,7 +163,7 @@
 SYS(sys_writev, 3)
 SYS(sys_cacheflush, 3)
 SYS(sys_cachectl, 3)
-SYS(sys_sysmips, 4)
+SYS(fast_sysmips, 4)
 SYS(sys_ni_syscall, 0)				/* 4150 */
 SYS(sys_getsid, 1)
 SYS(sys_fdatasync, 0)

--------------070109020602010607080208--
