Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6KGQLP14617
	for linux-mips-outgoing; Fri, 20 Jul 2001 09:26:21 -0700
Received: from snfc21.pbi.net (mta6.snfc21.pbi.net [206.13.28.240])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6KGQJV14614
	for <linux-mips@oss.sgi.com>; Fri, 20 Jul 2001 09:26:19 -0700
Received: from pacbell.net ([63.194.214.47])
 by mta6.snfc21.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GGS004DR5NKOZ@mta6.snfc21.pbi.net> for linux-mips@oss.sgi.com;
 Fri, 20 Jul 2001 09:26:09 -0700 (PDT)
Date: Fri, 20 Jul 2001 09:26:14 -0700
From: Pete Popov <ppopov@pacbell.net>
Subject: Re: hard hat linux 2.0
Cc: "'linux-mips-kernel@lists.sourceforge.net '"
 <linux-mips-kernel@lists.sourceforge.net>,
   "'linux-mips@oss.sgi.com '" <linux-mips@oss.sgi.com>
Reply-to: ppopov@pacbell.net
Message-id: <3B585BA6.1080507@pacbell.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------060708080104040003040608
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
References: <25369470B6F0D41194820002B328BDD27D2B@ATLOPS>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------060708080104040003040608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marc Karasek wrote:

>  Is there somewhere I can grab the patch from Florian?  


Yes, somewhere in the mail archives. If you use the 2.4.2 based kernel 
in HHL2.0, that patch and others have been applied. I've attached 
Florian's patch.

Pete


> 
> -----Original Message-----
> From: Pete Popov
> To: linux-mips-kernel@lists.sourceforge.net; linux-mips@oss.sgi.com
> Sent: 7/19/01 3:03 PM
> Subject: hard hat linux 2.0
> 
> Looks like ftp.mvista.com was updated last night to include the mips 
> journeyman edition. The images of interest would be 
> ftp.mvista.com:/pub/Journeyman/cdimages/{je-d1-hhl2.0.cdimage, 
> je-src-hhl2.0.cdimage}.  They are rather large so it takes a while to 
> download them.
> 
> In addition to the userland packages, there is an up to date cross 
> toolchain which can build the kernel as well as useland apps. There is 
> also a native toolchain.  The toolchain is 2.95.3 based; glibc is 2.2.3.
> 
>   Since there was some perl interest recently, perl is included. 
> Rebuilding any of the userland packages, for those interested in doing 
> that, is pretty trivial (cross based building!).
> 
> This is an embedded linux distribution so it's not as large as a RedHat 
> desktop system. For embedded work though, I think it's more than 
> sufficient.  One note, to anyone trying it.  A number of binaries are 
> linked with pthreads, so you'll need either the new sysmips fix that 
> Ralf is working on, when he completes it, or the patch from Florian. 
> Otherwise binaries like ls, tar, and many others will seg fault.
> 
> Pete
> 
> 



--------------060708080104040003040608
Content-Type: text/plain;
 name="florian_sysmips.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="florian_sysmips.patch"

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

--------------060708080104040003040608--
