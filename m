Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f66MD3H18938
	for linux-mips-outgoing; Fri, 6 Jul 2001 15:13:03 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f66MCtV18934;
	Fri, 6 Jul 2001 15:12:55 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA02422; Fri, 6 Jul 2001 15:13:07 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f66M7l004332;
	Fri, 6 Jul 2001 15:07:47 -0700
Message-ID: <3B4635FB.1ED5D222@mvista.com>
Date: Fri, 06 Jul 2001 15:04:43 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Carsten Langgaard <carstenl@mips.com>, ralf@oss.sgi.com
CC: vhouten@kpn.com, linux-mips@oss.sgi.com
Subject: Re: Illegal instruction
References: <3B4573B8.9F89022B@mips.com>
Content-Type: multipart/mixed;
 boundary="------------DC8F502FDCB345276A852AE0"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------DC8F502FDCB345276A852AE0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Carsten Langgaard wrote:
> 
> Hi Karel,
> 
> I have tried the root-images tar-files: mipselroot-rh7-20010606 and
> mipsroot-rh7.
> The mipsroot-rh7 (bigendian) root image seem to work fine, but when
> I use the mipselroot-rh7-20010606 (littleendian) I get an illegal
> instruction.
> [cat:179] Illegal instruction 7c010001 at 2ac8b20c ra=00000000.
> 
> I'm using a 2.4.3 kernel.
> Anyone got an idea ?
> 
> /Carsten
> 

Is the userland compiled with MIPS I option?  I bet this is the same nasty
MIPS_ATOMIC_SET bug.

Currently, there are three fixes.  One is from Florian, which only takes care
of CPUs with ll/sc.  Another is from Maceij, which introduces a new syscall,
and some changes in glibc.  The thrid is mine, a compromising one.  It takes
care of both ll/sc case and non-llsc case, has minimum change, and practically
makes all programs happy.

Ralf, please take at least one of the fixes.  Even a not-so-good fix is better
than no fix.

Jun
--------------DC8F502FDCB345276A852AE0
Content-Type: text/plain; charset=us-ascii;
 name="MIPS_ATOMIC_SET-compromising-fix.010626.010626.pathc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MIPS_ATOMIC_SET-compromising-fix.010626.010626.pathc"


This is a compromising fix for sysmips(MIPS_ATOMIC_SET, ...).  It
forces SIGSYS when the return value is a small negative value.  This
limit is OK for glibc.

Jun

diff -Nru linux/arch/mips/kernel/sysmips.c.orig linux/arch/mips/kernel/sysmips.c
--- linux/arch/mips/kernel/sysmips.c.orig	Mon Apr 23 11:32:54 2001
+++ linux/arch/mips/kernel/sysmips.c	Tue Jun 26 11:50:48 2001
@@ -16,7 +16,7 @@
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/utsname.h>
-
+#include <linux/signal.h>
 #include <asm/cachectl.h>
 #include <asm/pgalloc.h>
 #include <asm/sysmips.h>
@@ -75,53 +75,83 @@
 	}
 
 	case MIPS_ATOMIC_SET: {
-#ifdef CONFIG_CPU_HAS_LLSC
-		unsigned int tmp;
+		int *ptr, val, ret, err, tmp;
+		struct siginfo info;
 
-		p = (int *) arg1;
-		errno = verify_area(VERIFY_WRITE, p, sizeof(*p));
-		if (errno)
-			return errno;
-		errno = 0;
-
-		__asm__(".set\tpush\t\t\t# sysmips(MIPS_ATOMIC, ...)\n\t"
-			".set\tmips2\n\t"
-			".set\tnoat\n\t"
-			"1:\tll\t%0, %4\n\t"
-			"move\t$1, %3\n\t"
-			"2:\tsc\t$1, %1\n\t"
-			"beqz\t$1, 1b\n\t"
-			".set\tpop\n\t"
-			".section\t.fixup,\"ax\"\n"
-			"3:\tli\t%2, 1\t\t\t# error\n\t"
-			".previous\n\t"
-			".section\t__ex_table,\"a\"\n\t"
-			".word\t1b, 3b\n\t"
-			".word\t2b, 3b\n\t"
-			".previous\n\t"
-			: "=&r" (tmp), "=o" (* (u32 *) p), "=r" (errno)
-			: "r" (arg2), "o" (* (u32 *) p), "2" (errno)
-			: "$1");
+		ptr = (int *)arg1;
+		val = (int)arg2;
 
-		if (errno)
-			return -EFAULT;
+		/* Don't emulate unaligned accesses. */
+		if ((int)ptr & 3) {
+			info.si_signo = SIGBUS;
+                        info.si_code = BUS_ADRALN;
+			goto fault;
+		}
+
+		/* A zero here saves us three instructions. */
+		err = verify_area(VERIFY_WRITE, ptr, 0);
+		if (err) {
+                        info.si_signo = SIGSEGV;
+			info.si_code = SEGV_ACCERR;
+			goto fault;
+		}
 
-		/* We're skipping error handling etc.  */
-		if (current->ptrace & PT_TRACESYS)
-			syscall_trace();
-
-		((struct pt_regs *)&cmd)->regs[2] = tmp;
-		((struct pt_regs *)&cmd)->regs[7] = 0;
-
-		__asm__ __volatile__(
-			"move\t$29, %0\n\t"
-			"j\to32_ret_from_sys_call"
-			: /* No outputs */
-			: "r" (&cmd));
-		/* Unreached */
+#ifdef CONFIG_CPU_HAS_LLSC
+		__asm__(".set   mips2\n\t"
+			"1:\n\t"
+			"ll     %0,%5\n\t"
+	                ".set   push\n\t"
+	                ".set   noreorder\n\t"
+	                "beq    %0,%4,3f\n\t"
+	                " move  %3,%4\n"
+	                ".set   pop\n\t"
+	                "2:\n\t"
+	                "sc     %3,%1\n\t"
+	                "beqz   %3,1b\n\t"
+	                "3:\n\t"
+	                ".set   mips0\n\t"
+	                ".section .fixup,\"ax\"\n"
+	                "4:\n\t"
+	                "li     %2,%7\n\t"
+	                "j      3b\n\t"
+	                ".previous\n\t"
+	                ".section __ex_table,\"a\"\n\t"
+	                ".word  1b,4b\n\t"
+	                ".word  2b,4b\n\t"
+	                ".previous"
+	                : "=&r" (ret), "=R" (*ptr), "=r" (err), "=&r" (tmp)
+	                : "r" (val), "1" (*ptr), "2" (0), "i" (-EFAULT));
 #else
-	printk("sys_sysmips(MIPS_ATOMIC_SET, ...) not ready for !CONFIG_CPU_HAS_LLSC\n");
+		save_and_cli(tmp);
+		err = __get_user(ret, ptr);
+		if (ret != val)
+		err |= __put_user(val, ptr);    /* No fault
+                                                   unless unwriteable. */
+		restore_flags(tmp);
 #endif
+
+		if (err) {
+                        info.si_signo = SIGSEGV;
+			info.si_code = SEGV_MAPERR;
+			goto fault;
+		}
+			
+		if ( (ret < 0) && (ret >= -EMAXERRNO) ) {
+                        info.si_signo = SIGSYS;
+			info.si_code = 0;
+			goto fault;
+		}
+			
+		return ret;
+
+fault:
+		/* Go back to SYSCALL. */
+		((struct pt_regs *)&cmd)->cp0_epc -= 4;
+
+		info.si_addr = (void *)((struct pt_regs *)&cmd)->cp0_epc;
+		force_sig_info(info.si_signo, &info, current);
+
+		return 0;
 	}
 
 	case MIPS_FIXADE:

--------------DC8F502FDCB345276A852AE0
Content-Type: text/plain; charset=us-ascii;
 name="flo-fast-sysmips.0105X.X.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="flo-fast-sysmips.0105X.X.patch"

diff -Nur linux.orig/arch/mips/kernel/Makefile linux/arch/mips/kernel/Makefile
--- linux.orig/arch/mips/kernel/Makefile        Mon Apr  9 00:23:08 2001
+++ linux/arch/mips/kernel/Makefile     Mon Apr  9 00:23:34 2001
@@ -20,7 +20,7 @@
 obj-y                          += branch.o process.o signal.o entry.o \
                                   traps.o ptrace.o vm86.o ioport.o reset.o \
                                   semaphore.o setup.o syscall.o sysmips.o \
-                                  ipc.o scall_o32.o unaligned.o
+                                  ipc.o scall_o32.o unaligned.o fast-sysmips.o
 obj-$(CONFIG_MODULES)          += mips_ksyms.o

 ifdef CONFIG_CPU_R3000
@@ -69,5 +69,6 @@

 entry.o: entry.S
 head.o: head.S
+fast-sysmips.o: fast-sysmips.S

 include $(TOPDIR)/Rules.make
diff -Nur linux.orig/arch/mips/kernel/fast-sysmips.S linux/arch/mips/kernel/fast-sysmips.S
--- linux.orig/arch/mips/kernel/fast-sysmips.S  Thu Jan  1 01:00:00 1970
+++ linux/arch/mips/kernel/fast-sysmips.S       Mon Apr  9 00:28:20 2001
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
+       EXPORT(fast_sysmips)
+
+       .set    noreorder
+
+       li      t0, MIPS_ATOMIC_SET
+       beq     a0, t0, 1f
+        nop
+       j       sys_sysmips
+        nop
+
+1:
+
+       # a0 - MIPS_ATOMIC_SET
+       # a1 - mem ptr
+       # a2 - value
+
+       addiu   sp, sp, -8                      # Reserve space
+       sw      a0, (sp)                        # Save arg0
+
+       addiu   a0, a1, 4                       # addr+size
+       ori     v0, a1, 4                       # addr | size
+       lw      v1, THREAD_CURDS(gp)            # current->thread.current_ds
+       or      v0, v0, a0                      # addr | size | (addr+size)
+       and     v1, v1, v0                      # (mask)&(addr | size | (addr+size)
+       bltz    v1, 5f
+        nop
+
+2:
+       ll      v0, (a1)
+       move    t0, a2
+       sc      t0, (a1)
+       beqz    t0, 2b
+        nop
+
+       sw      v0, PT_R2+8(sp)                 # Result value
+       sw      zero, PT_R7+8(sp)               # Success indicator
+
+       lw      t0, TASK_PTRACE(gp)             # syscall tracing enabled?
+       andi    t0, PT_TRACESYS
+       bnez    t0, 3f
+        nop
+
+4:
+       lw      a0, (sp)                        # Restore arg0
+       addiu   sp, sp, 8                       # Restore sp
+
+       j       o32_ret_from_sys_call
+        nop
+
+3:
+       sw      ra, 4(sp)
+       jal     syscall_trace
+        nop
+       lw      ra, 4(sp)
+       j       4b
+        nop
+
+5:
+       lw      a0, (sp)                        # Restore arg0
+       addiu   sp, sp, 8                       # Restore sp
+       j       ra
+        li     v0, -EFAULT
+
diff -Nur linux.orig/arch/mips/kernel/irix5sys.h linux/arch/mips/kernel/irix5sys.h
--- linux.orig/arch/mips/kernel/irix5sys.h      Mon Apr  9 00:16:29 2001
+++ linux/arch/mips/kernel/irix5sys.h   Sun Apr  8 21:21:16 2001
@@ -69,7 +69,7 @@
 SYS(irix_getgid, 0)                    /* 1047  getgid()              V*/
 SYS(irix_unimp, 0)                     /* 1048  (XXX IRIX 4 ssig)     V*/
 SYS(irix_msgsys, 6)                    /* 1049  sys_msgsys            V*/
-SYS(sys_sysmips, 4)                    /* 1050  sysmips()            HV*/
+SYS(fast_sysmips, 4)                   /* 1050  sysmips()            HV*/
 SYS(irix_unimp, 0)                     /* 1051  XXX sysacct()        IV*/
 SYS(irix_shmsys, 5)                    /* 1052  sys_shmsys            V*/
 SYS(irix_semsys, 0)                    /* 1053  sys_semsys            V*/
diff -Nur linux.orig/arch/mips/kernel/syscalls.h linux/arch/mips/kernel/syscalls.h
--- linux.orig/arch/mips/kernel/syscalls.h      Mon Apr  9 00:16:30 2001
+++ linux/arch/mips/kernel/syscalls.h   Sun Apr  8 21:21:43 2001
@@ -163,7 +163,7 @@
 SYS(sys_writev, 3)
 SYS(sys_cacheflush, 3)
 SYS(sys_cachectl, 3)
-SYS(sys_sysmips, 4)
+SYS(fast_sysmips, 4)
 SYS(sys_ni_syscall, 0)                         /* 4150 */
 SYS(sys_getsid, 1)
 SYS(sys_fdatasync, 0)


--------------DC8F502FDCB345276A852AE0--
