Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5O94knC022902
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 02:04:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5O94k2e022901
	for linux-mips-outgoing; Mon, 24 Jun 2002 02:04:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5O94DnC022864;
	Mon, 24 Jun 2002 02:04:13 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id CAA10894;
	Mon, 24 Jun 2002 02:07:26 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id CAA28316;
	Mon, 24 Jun 2002 02:07:24 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5O97Pb15419;
	Mon, 24 Jun 2002 11:07:25 +0200 (MEST)
Message-ID: <3D16E14C.5C8D2FAD@mips.com>
Date: Mon, 24 Jun 2002 11:07:24 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: sys_syscall patch.
Content-Type: multipart/mixed;
 boundary="------------58C8EEAD283815526023212C"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------58C8EEAD283815526023212C
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

The 'sys_syscall' syscall isn't properly implemented in the 64-bit
kernel (for o32 as well as n64).
Below is a patch, it seems to work for in the o32 case, but I haven't
tested the n64 version (obviously).

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------58C8EEAD283815526023212C
Content-Type: text/plain; charset=iso-8859-15;
 name="sys_syscall.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sys_syscall.patch"

Index: arch/mips64/kernel//linux32.c
===================================================================
RCS file: /home/repository/sw/linux-2.4.18/arch/mips64/kernel/linux32.c,v
retrieving revision 1.3
diff -u -r1.3 linux32.c
--- arch/mips64/kernel//linux32.c	13 Jun 2002 09:08:02 -0000	1.3
+++ arch/mips64/kernel//linux32.c	24 Jun 2002 08:56:02 -0000
@@ -32,6 +32,7 @@
 #include <asm/uaccess.h>
 #include <asm/mman.h>
 #include <asm/ipc.h>
+#include <asm/unistd.h>
 
 
 #define A(__x) ((unsigned long)(__x))
@@ -872,6 +873,82 @@
 		oldalarm++;
 
 	return oldalarm;
+}
+
+typedef asmlinkage long (*syscall_t)(void *a0,...);
+extern syscall_t sys32_call_table[];
+extern unsigned char sys32_narg_table[];
+
+/*
+ * Do the indirect syscall syscall.
+ * Don't care about kernel locking; the actual syscall will do it.
+ *
+ * XXX This is broken.
+ */
+asmlinkage int sys32_syscall(abi64_no_regargs, struct pt_regs regs)
+{
+	syscall_t syscall;
+	unsigned long syscallnr = regs.regs[4];
+	unsigned long a0, a1, a2, a3, a4, a5, a6;
+	int nargs, errno;
+
+	if ((syscallnr < __NR_Linux32) || 
+	    (syscallnr > __NR_Linux32 + __NR_Linux32_syscalls))
+		return -ENOSYS;
+
+	syscall = sys32_call_table[syscallnr-__NR_Linux32];
+	nargs = sys32_narg_table[syscallnr-__NR_Linux32];
+
+	/*
+	 * Prevent stack overflow by recursive
+	 * syscall(__NR_syscall, __NR_syscall,...);
+	 */
+	if (syscall == (syscall_t) sys32_syscall) {
+		return -EINVAL;
+	}
+
+	if (syscall == NULL) {
+		return -ENOSYS;
+	}
+
+	if(nargs > 3) {
+		unsigned long usp = regs.regs[29];
+		unsigned long *sp = (unsigned long *) usp;
+		if(usp & 3) {
+			printk("unaligned usp -EFAULT\n");
+			force_sig(SIGSEGV, current);
+			return -EFAULT;
+		}
+		errno = verify_area(VERIFY_READ, (void *) (usp + 16),
+		                    (nargs - 3) * sizeof(unsigned long));
+		if(errno) {
+			return -EFAULT;
+		}
+		switch(nargs) {
+		case 7:
+			a3 = sp[4]; a4 = sp[5]; a5 = sp[6]; a6 = sp[7];
+			break;
+		case 6:
+			a3 = sp[4]; a4 = sp[5]; a5 = sp[6]; a6 = 0;
+			break;
+		case 5:
+			a3 = sp[4]; a4 = sp[5]; a5 = a6 = 0;
+			break;
+		case 4:
+			a3 = sp[4]; a4 = a5 = a6 = 0;
+			break;
+
+		default:
+			a3 = a4 = a5 = a6 = 0;
+			break;
+		}
+	} else {
+		a3 = a4 = a5 = a6 = 0;
+	}
+	a0 = regs.regs[5]; a1 = regs.regs[6]; a2 = regs.regs[7];
+	if(nargs == 0)
+		a0 = (unsigned long) &regs;
+	return syscall((void *)a0, a1, a2, a3, a4, a5, a6);
 }
 
 /* Translations due to time_t size differences.  Which affects all
Index: arch/mips64/kernel//scall_64.S
===================================================================
RCS file: /home/repository/sw/linux-2.4.18/arch/mips64/kernel/scall_64.S,v
retrieving revision 1.3
diff -u -r1.3 scall_64.S
--- arch/mips64/kernel//scall_64.S	19 Jun 2002 07:04:08 -0000	1.3
+++ arch/mips64/kernel//scall_64.S	24 Jun 2002 08:10:23 -0000
@@ -132,7 +132,7 @@
 	j	ret_from_sys_call
 	END(handle_sys64)
 
-sys_call_table:
+EXPORT(sys_call_table)
 	PTR	sys_syscall				/* 5000 */
 	PTR	sys_exit
 	PTR	sys_fork
Index: arch/mips64/kernel//scall_o32.S
===================================================================
RCS file: /home/repository/sw/linux-2.4.18/arch/mips64/kernel/scall_o32.S,v
retrieving revision 1.3
diff -u -r1.3 scall_o32.S
--- arch/mips64/kernel//scall_o32.S	19 Jun 2002 07:04:08 -0000	1.3
+++ arch/mips64/kernel//scall_o32.S	24 Jun 2002 08:53:48 -0000
@@ -52,8 +52,8 @@
 
 	/* XXX Put both in one cacheline, should save a bit. */
 	dsll	t0, v0, 3		# offset into table
-	ld	t2, (sys_call_table - (__NR_Linux32 * 8))(t0) # syscall routine
-	lbu	t3, (sys_narg_table - __NR_Linux32)(v0)	# number of arguments
+	ld	t2, (sys32_call_table - (__NR_Linux32 * 8))(t0) # syscall routine
+	lbu	t3, (sys32_narg_table - __NR_Linux32)(v0)	# number of arguments
 
 	subu	t0, t3, 5		# 5 or more arguments?
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
@@ -246,7 +246,7 @@
 	END(sys_sysmips)
 
 	.macro	syscalltable
-	sys	sys_syscall	0			/* 4000 */
+	sys	sys32_syscall	0			/* 4000 */
 	sys	sys_exit	1
 	sys	sys_fork	0
 	sys	sys_read	3
@@ -489,12 +489,12 @@
 	PTR	\function
 	.endm
 
-sys_call_table:
+EXPORT(sys32_call_table)
 	syscalltable
 
 	.macro	sys function, nargs
 	.byte	\nargs
 	.endm
-
-sys_narg_table:
+	
+EXPORT(sys32_narg_table)
 	syscalltable
Index: arch/mips64/kernel//syscall.c
===================================================================
RCS file: /home/repository/sw/linux-2.4.18/arch/mips64/kernel/syscall.c,v
retrieving revision 1.2
diff -u -r1.2 syscall.c
--- arch/mips64/kernel//syscall.c	13 Jun 2002 09:08:02 -0000	1.2
+++ arch/mips64/kernel//syscall.c	24 Jun 2002 08:38:55 -0000
@@ -123,14 +123,41 @@
 	return error;
 }
 
+typedef asmlinkage long (*syscall_t)(void *a0,...);
+extern syscall_t sys_call_table[];
+
 /*
  * Do the indirect syscall syscall.
- *
- * XXX This is borken.
+ * Don't care about kernel locking; the actual syscall will do it.
  */
 asmlinkage int sys_syscall(abi64_no_regargs, struct pt_regs regs)
 {
-	return -ENOSYS;
+	syscall_t syscall;
+	unsigned long syscallnr = regs.regs[4];
+	unsigned long a0, a1, a2, a3, a4, a5, a6;
+
+	if ((syscallnr < __NR_Linux) || 
+	    (syscallnr > __NR_Linux + __NR_Linux_syscalls))
+		return -ENOSYS;
+
+	syscall = sys_call_table[syscallnr-__NR_Linux];
+
+	/*
+	 * Prevent stack overflow by recursive
+	 * syscall(__NR_syscall, __NR_syscall,...);
+	 */
+	if (syscall == (syscall_t) sys_syscall) {
+		return -EINVAL;
+	}
+
+	if (syscall == NULL) {
+		return -ENOSYS;
+	}
+
+	a0 = regs.regs[5]; a1 = regs.regs[6]; a2 = regs.regs[7];
+	a3 = regs.regs[8]; a4 = regs.regs[9]; a5 = regs.regs[10];
+	a6 = regs.regs[11];
+	return syscall((void *)a0, a1, a2, a3, a4, a5, a6);
 }
 
 asmlinkage int

--------------58C8EEAD283815526023212C--
