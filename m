Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NNB2Z26799
	for linux-mips-outgoing; Wed, 23 May 2001 16:11:02 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NNAuF26794
	for <linux-mips@oss.sgi.com>; Wed, 23 May 2001 16:10:56 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id BAA64469
	for <linux-mips@oss.sgi.com>; Thu, 24 May 2001 01:10:54 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 152hmH-0004M8-00
	for <linux-mips@oss.sgi.com>; Thu, 24 May 2001 01:10:53 +0200
Date: Thu, 24 May 2001 01:10:53 +0200
To: linux-mips@oss.sgi.com
Subject: [PATCH] mips64 typo and formatting fixes
Message-ID: <20010524011053.J11643@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi All,

here is some fallout from my mips64 development, most of it is
fixing of typos and source code formatting.

Ok to apply?


Thiemo


diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/arc/Makefile linux/arch/mips64/arc/Makefile
--- linux-orig/arch/mips64/arc/Makefile	Tue Mar 20 00:02:37 2001
+++ linux/arch/mips64/arc/Makefile	Wed May 23 23:39:56 2001
@@ -7,6 +7,6 @@
 	   file.o
 
 obj-$(CONFIG_ARC_MEMORY) += memory.o
-obj-$(CONFIG_ARC_CONSOLE)   += arc_con.o
+obj-$(CONFIG_ARC_CONSOLE) += arc_con.o
 
 include $(TOPDIR)/Rules.make
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/kernel/r4k_fpu.S linux/arch/mips64/kernel/r4k_fpu.S
--- linux-orig/arch/mips64/kernel/r4k_fpu.S	Wed Apr 11 23:21:33 2001
+++ linux/arch/mips64/kernel/r4k_fpu.S	Wed May 23 23:39:56 2001
@@ -32,11 +32,11 @@
 	.set	noreorder
 	/* Save floating point context */
 LEAF(save_fp_context)
-	mfc0	t1,CP0_STATUS
-	 sll	t2,t1,5
+	mfc0	t1, CP0_STATUS
+	sll	t2, t1,5
 
-	bgez	t2,1f
-	 cfc1	t1,fcr31
+	bgez	t2, 1f
+	 cfc1	t1, fcr31
 	/* Store the 16 odd double precision registers */
 	EX	sdc1 $f1, SC_FPREGS+8(a0)
 	EX	sdc1 $f3, SC_FPREGS+24(a0)
@@ -74,8 +74,8 @@
 	EX	sdc1 $f28, SC_FPREGS+224(a0)
 	EX	sdc1 $f30, SC_FPREGS+240(a0)
 	EX	sw t1, SC_FPC_CSR(a0)
-	cfc1	t0,$0				# implementation/version
-	EX	sw t0,SC_FPC_EIR(a0)
+	cfc1	t0, $0				# implementation/version
+	EX	sw t0, SC_FPC_EIR(a0)
 
 	jr	ra
 	 li	v0, 0					# success
@@ -92,8 +92,8 @@
  */
 LEAF(restore_fp_context)
 	mfc0	t1, CP0_STATUS
-	sll	t0,t1,5
-	bgez	t0,1f
+	sll	t0, t1,5
+	bgez	t0, 1f
 	 EX	lw t0, SC_FPC_CSR(a0)
 
 	/* Restore the 16 odd double precision registers only
@@ -136,14 +136,13 @@
 	EX	ldc1 $f26, SC_FPREGS+208(a0)
 	EX	ldc1 $f28, SC_FPREGS+224(a0)
 	EX	ldc1 $f30, SC_FPREGS+240(a0)
-	ctc1	t0,fcr31
+	ctc1	t0, fcr31
 	jr	ra
 	 li	v0, 0					# success
 	END(restore_fp_context)
-	.set	reorder
 
 	.type	fault@function
 	.ent	fault
-fault:	li	v0, -EFAULT
-	jr	ra
+fault:	jr	ra
+	 li	v0, -EFAULT				# failure
 	.end	fault
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/kernel/scall_64.S linux/arch/mips64/kernel/scall_64.S
--- linux-orig/arch/mips64/kernel/scall_64.S	Tue Sep  5 03:13:01 2000
+++ linux/arch/mips64/kernel/scall_64.S	Wed May 23 23:39:56 2001
@@ -131,217 +132,217 @@
 	END(handle_sys64)
 
 sys_call_table:
-	PTR	sys_syscall				/* 4000 */
+	PTR	sys_syscall				/* 5000 */
 	PTR	sys_exit
 	PTR	sys_fork
 	PTR	sys_read
 	PTR	sys_write
-	PTR	sys_open				/* 4005 */
+	PTR	sys_open				/* 5005 */
 	PTR	sys_close
 	PTR	sys_waitpid
 	PTR	sys_creat
 	PTR	sys_link
-	PTR	sys_unlink				/* 4010 */
+	PTR	sys_unlink				/* 5010 */
 	PTR	sys_execve
 	PTR	sys_chdir
 	PTR	sys_time
 	PTR	sys_mknod
-	PTR	sys_chmod				/* 4015 */
+	PTR	sys_chmod				/* 5015 */
 	PTR	sys_lchown
 	PTR	sys_ni_syscall
 	PTR	sys_stat
 	PTR	sys_lseek
-	PTR	sys_getpid				/* 4020 */
+	PTR	sys_getpid				/* 5020 */
 	PTR	sys_mount
 	PTR	sys_oldumount
 	PTR	sys_setuid
 	PTR	sys_getuid
-	PTR	sys_stime				/* 4025 */
+	PTR	sys_stime				/* 5025 */
 	PTR	sys_ni_syscall		/* ptrace */
 	PTR	sys_alarm
 	PTR	sys_fstat
 	PTR	sys_pause
-	PTR	sys_utime				/* 4030 */
+	PTR	sys_utime				/* 5030 */
 	PTR	sys_ni_syscall
 	PTR	sys_ni_syscall
 	PTR	sys_access
 	PTR	sys_nice
-	PTR	sys_ni_syscall				/* 4035 */
+	PTR	sys_ni_syscall				/* 5035 */
 	PTR	sys_sync
 	PTR	sys_kill
 	PTR	sys_rename
 	PTR	sys_mkdir
-	PTR	sys_rmdir				/* 4040 */
+	PTR	sys_rmdir				/* 5040 */
 	PTR	sys_dup
 	PTR	sys_pipe
 	PTR	sys_times
 	PTR	sys_ni_syscall
-	PTR	sys_brk					/* 4045 */
+	PTR	sys_brk					/* 5045 */
 	PTR	sys_setgid
 	PTR	sys_getgid
 	PTR	sys_ni_syscall		/* was signal	2 */
 	PTR	sys_geteuid
-	PTR	sys_getegid				/* 4050 */
+	PTR	sys_getegid				/* 5050 */
 	PTR	sys_acct
 	PTR	sys_umount
 	PTR	sys_ni_syscall
 	PTR	sys_ioctl
-	PTR	sys_fcntl				/* 4055 */
+	PTR	sys_fcntl				/* 5055 */
 	PTR	sys_ni_syscall
 	PTR	sys_setpgid
 	PTR	sys_ni_syscall
 	PTR	sys_ni_syscall
-	PTR	sys_umask				/* 4060 */
+	PTR	sys_umask				/* 5060 */
 	PTR	sys_chroot
 	PTR	sys_ustat
 	PTR	sys_dup2
 	PTR	sys_getppid
-	PTR	sys_getpgrp				/* 4065 */
+	PTR	sys_getpgrp				/* 5065 */
 	PTR	sys_setsid
 	PTR	sys_sigaction
 	PTR	sys_sgetmask
 	PTR	sys_ssetmask
-	PTR	sys_setreuid				/* 4070 */
+	PTR	sys_setreuid				/* 5070 */
 	PTR	sys_setregid
 	PTR	sys_sigsuspend
 	PTR	sys_sigpending
 	PTR	sys_sethostname
-	PTR	sys_setrlimit				/* 4075 */
+	PTR	sys_setrlimit				/* 5075 */
 	PTR	sys_getrlimit
 	PTR	sys_getrusage
 	PTR	sys_gettimeofday
 	PTR	sys_settimeofday
-	PTR	sys_getgroups				/* 4080 */
+	PTR	sys_getgroups				/* 5080 */
 	PTR	sys_setgroups
 	PTR	sys_ni_syscall			/* old_select */
 	PTR	sys_symlink
 	PTR	sys_lstat
-	PTR	sys_readlink				/* 4085 */
+	PTR	sys_readlink				/* 5085 */
 	PTR	sys_uselib
 	PTR	sys_swapon
 	PTR	sys_reboot
 	PTR	sys_ni_syscall			/* old_readdir */
-	PTR	sys_mmap				/* 4090 */
+	PTR	sys_mmap				/* 5090 */
 	PTR	sys_munmap
 	PTR	sys_truncate
 	PTR	sys_ftruncate
 	PTR	sys_fchmod
-	PTR	sys_fchown				/* 4095 */
+	PTR	sys_fchown				/* 5095 */
 	PTR	sys_getpriority
 	PTR	sys_setpriority
 	PTR	sys_ni_syscall
 	PTR	sys_statfs
-	PTR	sys_fstatfs				/* 4100 */
+	PTR	sys_fstatfs				/* 5100 */
 	PTR	sys_ni_syscall		/* sys_ioperm */
 	PTR	sys_socketcall
 	PTR	sys_syslog
 	PTR	sys_setitimer
-	PTR	sys_getitimer				/* 4105 */
+	PTR	sys_getitimer				/* 5105 */
 	PTR	sys_newstat
 	PTR	sys_newlstat
 	PTR	sys_newfstat
 	PTR	sys_ni_syscall
-	PTR	sys_ni_syscall		/* sys_ioperm  *//* 4110 */
+	PTR	sys_ni_syscall		/* sys_ioperm  *//* 5110 */
 	PTR	sys_vhangup
 	PTR	sys_ni_syscall		/* was sys_idle	 */
 	PTR	sys_ni_syscall		/* sys_vm86 */
 	PTR	sys_wait4
-	PTR	sys_swapoff				/* 4115 */
+	PTR	sys_swapoff				/* 5115 */
 	PTR	sys_sysinfo
 	PTR	sys_ipc
 	PTR	sys_fsync
 	PTR	sys_sigreturn
-	PTR	sys_clone				/* 4120 */
+	PTR	sys_clone				/* 5120 */
 	PTR	sys_setdomainname
 	PTR	sys_newuname
 	PTR	sys_ni_syscall		/* sys_modify_ldt */
 	PTR	sys_adjtimex
-	PTR	sys_mprotect				/* 4125 */
+	PTR	sys_mprotect				/* 5125 */
 	PTR	sys_sigprocmask
 	PTR	sys_create_module
 	PTR	sys_init_module
 	PTR	sys_delete_module
-	PTR	sys_get_kernel_syms 			/* 4130 */
+	PTR	sys_get_kernel_syms 			/* 5130 */
 	PTR	sys_quotactl
 	PTR	sys_getpgid
 	PTR	sys_fchdir
 	PTR	sys_bdflush
-	PTR	sys_sysfs				/* 4135 */
+	PTR	sys_sysfs				/* 5135 */
 	PTR	sys_personality
 	PTR	sys_ni_syscall		/* for afs_syscall */
 	PTR	sys_setfsuid
 	PTR	sys_setfsgid
-	PTR	sys_llseek				/* 4140 */
+	PTR	sys_llseek				/* 5140 */
 	PTR	sys_getdents
 	PTR	sys_select
 	PTR	sys_flock
 	PTR	sys_msync
-	PTR	sys_readv				/* 4145 */
+	PTR	sys_readv				/* 5145 */
 	PTR	sys_writev
 	PTR	sys_cacheflush
 	PTR	sys_cachectl
 	PTR	sys_sysmips
-	PTR	sys_ni_syscall				/* 4150 */
+	PTR	sys_ni_syscall				/* 5150 */
 	PTR	sys_getsid
 	PTR	sys_fdatasync
 	PTR	sys_sysctl
 	PTR	sys_mlock
-	PTR	sys_munlock				/* 4155 */
+	PTR	sys_munlock				/* 5155 */
 	PTR	sys_mlockall
 	PTR	sys_munlockall
 	PTR	sys_sched_setparam
 	PTR	sys_sched_getparam
-	PTR	sys_sched_setscheduler			/* 4160 */
+	PTR	sys_sched_setscheduler			/* 5160 */
 	PTR	sys_sched_getscheduler
 	PTR	sys_sched_yield
 	PTR	sys_sched_get_priority_max
 	PTR	sys_sched_get_priority_min
-	PTR	sys_sched_rr_get_interval		/* 4165 */
+	PTR	sys_sched_rr_get_interval		/* 5165 */
 	PTR	sys_nanosleep
 	PTR	sys_mremap
 	PTR	sys_accept
 	PTR	sys_bind
-	PTR	sys_connect				/* 4170 */
+	PTR	sys_connect				/* 5170 */
 	PTR	sys_getpeername
 	PTR	sys_getsockname
 	PTR	sys_getsockopt
 	PTR	sys_listen
-	PTR	sys_recv				/* 4175 */
+	PTR	sys_recv				/* 5175 */
 	PTR	sys_recvfrom
 	PTR	sys_recvmsg
 	PTR	sys_send
 	PTR	sys_sendmsg
-	PTR	sys_sendto				/* 4180 */
+	PTR	sys_sendto				/* 5180 */
 	PTR	sys_setsockopt
 	PTR	sys_shutdown
 	PTR	sys_socket
 	PTR	sys_socketpair
-	PTR	sys_setresuid				/* 4185 */
+	PTR	sys_setresuid				/* 5185 */
 	PTR	sys_getresuid
 	PTR	sys_query_module
 	PTR	sys_poll
 	PTR	sys_nfsservctl
-	PTR	sys_setresgid				/* 4190 */
+	PTR	sys_setresgid				/* 5190 */
 	PTR	sys_getresgid
 	PTR	sys_prctl
 	PTR	sys_rt_sigreturn
 	PTR	sys_rt_sigaction
-	PTR	sys_rt_sigprocmask 			/* 4195 */
+	PTR	sys_rt_sigprocmask 			/* 5195 */
 	PTR	sys_rt_sigpending
 	PTR	sys_rt_sigtimedwait
 	PTR	sys_rt_sigqueueinfo
 	PTR	sys_rt_sigsuspend
-	PTR	sys_pread				/* 4200 */
+	PTR	sys_pread				/* 5200 */
 	PTR	sys_pwrite
 	PTR	sys_chown
 	PTR	sys_getcwd
 	PTR	sys_capget
-	PTR	sys_capset				/* 4205 */
+	PTR	sys_capset				/* 5205 */
 	PTR	sys_sigaltstack
 	PTR	sys_sendfile
 	PTR	sys_ni_syscall
 	PTR	sys_ni_syscall
-	PTR	sys_pivot_root				/* 4210 */
+	PTR	sys_pivot_root				/* 5210 */
 	PTR	sys_mincore
 	PTR	sys_madvise
 	PTR	sys_getdents64
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/kernel/setup.c linux/arch/mips64/kernel/setup.c
--- linux-orig/arch/mips64/kernel/setup.c	Tue Mar 20 00:02:37 2001
+++ linux/arch/mips64/kernel/setup.c	Wed May 23 23:39:56 2001
@@ -150,7 +154,7 @@
 	bootmem_init ();
 #endif
 
-	strncpy (command_line, arcs_cmdline, CL_SIZE);
+	strncpy(command_line, arcs_cmdline, CL_SIZE);
 	memcpy(saved_command_line, command_line, CL_SIZE);
 	saved_command_line[CL_SIZE-1] = '\0';
 
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/mm/andes.c linux/arch/mips64/mm/andes.c
--- linux-orig/arch/mips64/mm/andes.c	Thu Nov 30 22:09:18 2000
+++ linux/arch/mips64/mm/andes.c	Wed May 23 23:39:56 2001
@@ -284,8 +284,8 @@
 
 	if((pid != (CPU_CONTEXT(smp_processor_id(), vma->vm_mm) & 0xff)) ||
 	   (CPU_CONTEXT(smp_processor_id(), vma->vm_mm) == 0)) {
-		printk("update_mmu_cache: Wheee, bogus tlbpid mmpid=%d 
-			tlbpid=%d\n", (int) (CPU_CONTEXT(smp_processor_id(), 
+		printk("update_mmu_cache: Wheee, bogus tlbpid mmpid=%d "
+			"tlbpid=%d\n", (int) (CPU_CONTEXT(smp_processor_id(),
 			vma->vm_mm) & 0xff), pid);
 	}
 
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/mm/init.c linux/arch/mips64/mm/init.c
--- linux-orig/arch/mips64/mm/init.c	Thu Apr  5 20:25:43 2001
+++ linux/arch/mips64/mm/init.c	Wed May 23 23:39:56 2001
@@ -119,7 +119,7 @@
 }
 
 /*
- * We have upto 8 empty zeroed pages so we can map one of the right colour
+ * We have up to 8 empty zeroed pages so we can map one of the right colour
  * when needed.  This is necessary only on R4000 / R4400 SC and MC versions
  * where we have to avoid VCED / VECI exceptions for good performance at
  * any price.  Since page is never written to after the initialization we
@@ -201,7 +201,7 @@
         }
 }
 
-void bootmem_init (void) {
+void bootmem_init(void) {
 #ifdef CONFIG_BLK_DEV_INITRD
 	unsigned long tmp;
 	unsigned long *initrd_header;
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/sgi-ip22/ip22-mc.c linux/arch/mips64/sgi-ip22/ip22-mc.c
--- linux-orig/arch/mips64/sgi-ip22/ip22-mc.c	Tue Mar 20 00:02:37 2001
+++ linux/arch/mips64/sgi-ip22/ip22-mc.c	Wed May 23 23:39:56 2001
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * indy_mc.c: Routines for manipulating the INDY memory controller.
+ * ip22-mc.c: Routines for manipulating the INDY memory controller.
  *
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
  * Copyright (C) 2001 Ralf Baechle (ralf@gnu.org)
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/sgi-ip22/ip22-sc.c linux/arch/mips64/sgi-ip22/ip22-sc.c
--- linux-orig/arch/mips64/sgi-ip22/ip22-sc.c	Tue Mar 20 00:02:37 2001
+++ linux/arch/mips64/sgi-ip22/ip22-sc.c	Wed May 23 23:39:56 2001
@@ -29,14 +29,14 @@
 
 static inline void indy_sc_wipe(unsigned long first, unsigned long last)
 {
-	__asm__ __volatile__("
-		.set	noreorder
-		or	%0, %4		# first line to flush
-		or	%1, %4		# last line to flush
-1:		sw	$0, 0(%0)
-		bne	%0, %1, 1b
-		daddu	%0, 32
-		.set reorder"
+	__asm__ __volatile__(
+		"\t.set	noreorder\n\t"
+		"or	%0, %4		# first line to flush\n\t"
+		"or	%1, %4		# last line to flush\n"
+	"1:	sw	$0, 0(%0)\n\t"
+		"bne	%0, %1, 1b\n\t"
+		"daddu	%0, 32\n\t"
+		".set reorder"
 		: "=r" (first), "=r" (last)
 		: "0" (first), "1" (last), "r" (0x9000000080000000)
 		: "$1");
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips/sgialib.h linux/include/asm-mips/sgialib.h
--- linux-orig/include/asm-mips/sgialib.h	Tue Mar 20 00:03:16 2001
+++ linux/include/asm-mips/sgialib.h	Wed May 23 23:39:56 2001
@@ -64,9 +64,9 @@
  */
 extern void prom_identify_arch(void);
 
-/* Environemt variable routines. */
+/* Environment variable routines. */
 extern PCHAR ArcGetEnvironmentVariable(CHAR *name);
-extern LONG SetEnvironmentVariable(PCHAR name, PCHAR value);
+extern LONG ArcSetEnvironmentVariable(PCHAR name, PCHAR value);
 
 /* ARCS command line acquisition and parsing. */
 extern char *prom_getcmdline(void);
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips64/asm.h linux/include/asm-mips64/asm.h
--- linux-orig/include/asm-mips64/asm.h	Tue Jan 18 00:32:47 2000
+++ linux/include/asm-mips64/asm.h	Wed May 23 23:39:56 2001
@@ -94,7 +94,7 @@
 		TEXT(msg)
 
 /*
- * Print formated string
+ * Print formatted string
  */
 #define PRINT(string)                                   \
 		.set	push;				\
@@ -105,7 +105,7 @@
 		TEXT(string)
 
 /*
- * Print formated string
+ * Print formatted string
  */
 #define PROM_PRINT(string)                              \
 		.set	push;				\
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips64/bootinfo.h linux/include/asm-mips64/bootinfo.h
--- linux-orig/include/asm-mips64/bootinfo.h	Tue Mar 20 00:03:16 2001
+++ linux/include/asm-mips64/bootinfo.h	Wed May 23 23:39:56 2001
@@ -88,7 +88,7 @@
 /*
  * Valid machtype for group SGI
  */
-#define MACH_SGI_INDY		0	/* R4?K and R5K Indy workstaions */
+#define MACH_SGI_INDY		0	/* R4?K and R5K Indy workstations */
 #define MACH_SGI_CHALLENGE_S	1       /* The Challenge S server */
 #define MACH_SGI_INDIGO2	2	/* The Indigo2 system */
 #define MACH_SGI_IP27		3	/* Origin 200, Origin 2000, Onyx 2 */
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips64/checksum.h linux/include/asm-mips64/checksum.h
--- linux-orig/include/asm-mips64/checksum.h	Tue Mar  7 16:45:42 2000
+++ linux/include/asm-mips64/checksum.h	Wed May 23 23:39:56 2001
@@ -70,15 +70,15 @@
 static inline unsigned short int
 csum_fold(unsigned int sum)
 {
-	__asm__("
-	.set	noat            
-	sll	$1, %0, 16
-	addu	%0, $1
-	sltu	$1, %0, $1
-	srl	%0, %0, 16
-	addu	%0, $1
-	xori	%0, 0xffff
-	.set	at"
+	__asm__(
+"	.set	noat\n"
+"	sll	$1, %0, 16\n"
+"	addu	%0, $1\n"
+"	sltu	$1, %0, $1\n"
+"	srl	%0, %0, 16\n"
+"	addu	%0, $1\n"
+"	xori	%0, 0xffff\n"
+"	.set	at"
 	: "=r" (sum)
 	: "0" (sum)
 	: "$1");
@@ -103,36 +103,36 @@
 	 * This is for 32-bit processors ...  but works just fine for 64-bit
 	 * processors for now ...  XXX
 	 */
-	__asm__ __volatile__("
-	.set	noreorder
-	.set	noat
-	lw	%0, (%1)
-	subu	%2, 4
-	dsll	%2, 2
-
-	lw	%3, 4(%1)
-	daddu	%2, %1
-	addu	%0, %3
-	sltu	$1, %0, %3
-	lw	%3, 8(%1)
-	addu	%0, $1
-	addu	%0, %3
-	sltu	$1, %0, %3
-	lw	%3, 12(%1)
-	addu	%0, $1
-	addu	%0, %3
-	sltu	$1, %0, %3
-	addu	%0, $1
-
-1:	lw	%3, 16(%1)
-	daddiu	%1, 4
-	addu	%0, %3
-	sltu	$1, %0, %3
-	bne	%2, %1, 1b
-	 addu	%0, $1
-
-2:	.set	at
-	.set	reorder"
+	__asm__ __volatile__(
+"	.set	noreorder\n"
+"	.set	noat\n"
+"	lw	%0, (%1)\n"
+"	subu	%2, 4\n"
+"	dsll	%2, 2\n"
+"\n"
+"	lw	%3, 4(%1)\n"
+"	daddu	%2, %1\n"
+"	addu	%0, %3\n"
+"	sltu	$1, %0, %3\n"
+"	lw	%3, 8(%1)\n"
+"	addu	%0, $1\n"
+"	addu	%0, %3\n"
+"	sltu	$1, %0, %3\n"
+"	lw	%3, 12(%1)\n"
+"	addu	%0, $1\n"
+"	addu	%0, %3\n"
+"	sltu	$1, %0, %3\n"
+"	addu	%0, $1\n"
+"\n"
+"1:	lw	%3, 16(%1)\n"
+"	daddiu	%1, 4\n"
+"	addu	%0, %3\n"
+"	sltu	$1, %0, %3\n"
+"	bne	%2, %1, 1b\n"
+"	 addu	%0, $1\n"
+"\n"
+"2:	.set	at\n"
+"	.set	reorder"
 	: "=&r" (sum), "=&r" (iph), "=&r" (ihl), "=&r" (dummy)
 	: "1" (iph), "2" (ihl)
 	: "$1");
@@ -148,15 +148,15 @@
 csum_tcpudp_nofold(unsigned long saddr, unsigned long daddr,
                    unsigned short len, unsigned short proto, unsigned int sum)
 {
-    __asm__("
-	.set	noat
-	daddu	%0, %2
-	daddu	%0, %3
-	daddu	%0, %4
-	dsll32	$1, %0, 0
-	daddu	%0, $1		# never results in an overflow
-	dsrl32	%0, %0, 0
-	.set	at"
+    __asm__(
+"	.set	noat\n"
+"	daddu	%0, %2\n"
+"	daddu	%0, %3\n"
+"	daddu	%0, %4\n"
+"	dsll32	$1, %0, 0\n"
+"	daddu	%0, $1		# never results in an overflow\n"
+"	dsrl32	%0, %0, 0\n"
+"	.set	at"
 	: "=r" (sum)
 	: "0" (sum), "r"(saddr), "r" (daddr),
 #ifdef __MIPSEL__
@@ -195,56 +195,56 @@
 csum_ipv6_magic(struct in6_addr *saddr, struct in6_addr *daddr, __u32 len,
                 unsigned short proto, unsigned int sum) 
 {
-	__asm__("
-		.set	noreorder
-		.set	noat
-		addu	%0, %5		# proto (long in network byte order)
-		sltu	$1, %0, %5
-		addu	%0, $1
-
-		addu	%0, %6		# csum
-		sltu	$1, %0, %6
-		lw	%1, 0(%2)	# four words source address
-		addu	%0, $1
-		addu	%0, %1
-		sltu	$1, %0, $1
-
-		lw	%1, 4(%2)
-		addu	%0, $1
-		addu	%0, %1
-		sltu	$1, %0, $1
-
-		lw	%1, 8(%2)
-		addu	%0, $1
-		addu	%0, %1
-		sltu	$1, %0, $1
-
-		lw	%1, 12(%2)
-		addu	%0, $1
-		addu	%0, %1
-		sltu	$1, %0, $1
-
-		lw	%1, 0(%3)
-		addu	%0, $1
-		addu	%0, %1
-		sltu	$1, %0, $1
-
-		lw	%1, 4(%3)
-		addu	%0, $1
-		addu	%0, %1
-		sltu	$1, %0, $1
-
-		lw	%1, 8(%3)
-		addu	%0, $1
-		addu	%0, %1
-		sltu	$1, %0, $1
-
-		lw	%1, 12(%3)
-		addu	%0, $1
-		addu	%0, %1
-		sltu	$1, %0, $1
-		.set	noat
-		.set	noreorder"
+	__asm__(
+"		.set	noreorder\n"
+"		.set	noat\n"
+"		addu	%0, %5		# proto (long in network byte order)\n"
+"		sltu	$1, %0, %5\n"
+"		addu	%0, $1\n"
+"\n"
+"		addu	%0, %6		# csum\n"
+"		sltu	$1, %0, %6\n"
+"		lw	%1, 0(%2)	# four words source address\n"
+"		addu	%0, $1\n"
+"		addu	%0, %1\n"
+"		sltu	$1, %0, $1\n"
+"\n"
+"		lw	%1, 4(%2)\n"
+"		addu	%0, $1\n"
+"		addu	%0, %1\n"
+"		sltu	$1, %0, $1\n"
+"\n"
+"		lw	%1, 8(%2)\n"
+"		addu	%0, $1\n"
+"		addu	%0, %1\n"
+"		sltu	$1, %0, $1\n"
+"\n"
+"		lw	%1, 12(%2)\n"
+"		addu	%0, $1\n"
+"		addu	%0, %1\n"
+"		sltu	$1, %0, $1\n"
+"\n"
+"		lw	%1, 0(%3)\n"
+"		addu	%0, $1\n"
+"		addu	%0, %1\n"
+"		sltu	$1, %0, $1\n"
+"\n"
+"		lw	%1, 4(%3)\n"
+"		addu	%0, $1\n"
+"		addu	%0, %1\n"
+"		sltu	$1, %0, $1\n"
+"\n"
+"		lw	%1, 8(%3)\n"
+"		addu	%0, $1\n"
+"		addu	%0, %1\n"
+"		sltu	$1, %0, $1\n"
+"\n"
+"		lw	%1, 12(%3)\n"
+"		addu	%0, $1\n"
+"		addu	%0, %1\n"
+"		sltu	$1, %0, $1\n"
+"		.set	noat\n"
+"		.set	noreorder"
 		: "=r" (sum), "=r" (proto)
 		: "r" (saddr), "r" (daddr),
 		  "0" (htonl(len)), "1" (htonl(proto)), "r"(sum)
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips64/cpu.h linux/include/asm-mips64/cpu.h
--- linux-orig/include/asm-mips64/cpu.h	Mon Mar  5 00:56:30 2001
+++ linux/include/asm-mips64/cpu.h	Wed May 23 23:39:56 2001
@@ -22,14 +22,13 @@
 #define PRID_IMP_R4000    0x0400
 #define PRID_IMP_R6000A   0x0600
 #define PRID_IMP_R10000   0x0900
-#define PRID_IMP_R12000   0x0e00
 #define PRID_IMP_R4300    0x0b00
 #define PRID_IMP_R12000   0x0e00
 #define PRID_IMP_R8000    0x1000
 #define PRID_IMP_R4600    0x2000
 #define PRID_IMP_R4700    0x2100
 #define PRID_IMP_R4640    0x2200
-#define PRID_IMP_R4650    0x2200		/* Same as R4640 */
+#define PRID_IMP_R4650    0x2200	/* Same as R4640 */
 #define PRID_IMP_R5000    0x2300
 #define PRID_IMP_SONIC    0x2400
 #define PRID_IMP_MAGIC    0x2500
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips64/mipsregs.h linux/include/asm-mips64/mipsregs.h
--- linux-orig/include/asm-mips64/mipsregs.h	Mon Oct  2 22:44:46 2000
+++ linux/include/asm-mips64/mipsregs.h	Wed May 23 23:39:56 2001
@@ -246,7 +246,7 @@
 #define  CAUSEF_BD		(1   << 31)
 
 /*
- * Bits in the coprozessor 0 config register.
+ * Bits in the coprocessor 0 config register.
  */
 #define CONF_CM_CACHABLE_NO_WA		0
 #define CONF_CM_CACHABLE_WA		1
@@ -265,7 +265,7 @@
  * R10000 performance counter definitions.
  *
  * FIXME: The R10000 performance counter opens a nice way to implement CPU
- *        time accounting with a precission of one cycle.  I don't have
+ *        time accounting with a precision of one cycle.  I don't have
  *        R10000 silicon but just a manual, so ...
  */
 
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips64/sgi/sgint23.h linux/include/asm-mips64/sgi/sgint23.h
--- linux-orig/include/asm-mips64/sgi/sgint23.h	Mon Nov 27 00:52:51 2000
+++ linux/include/asm-mips64/sgi/sgint23.h	Wed May 23 23:39:56 2001
@@ -170,7 +170,7 @@
 #endif
 #define INT2_TCLEAR_T0CLR      0x1        /* Clear timer0 IRQ */
 #define INT2_TCLEAR_T1CLR      0x2        /* Clear timer1 IRQ */
-/* I am guesing there are only two unused registers here 
+/* I am guessing there are only two unused registers here 
  * but I could be wrong...			- andrewb
  */
 /*	u32 _unused[3]; */
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips64/sgialib.h linux/include/asm-mips64/sgialib.h
--- linux-orig/include/asm-mips64/sgialib.h	Tue Mar 20 00:03:16 2001
+++ linux/include/asm-mips64/sgialib.h	Wed May 23 23:45:29 2001
@@ -90,9 +89,9 @@
  */
 extern void prom_identify_arch(void);
 
-/* Environemt variable routines. */
+/* Environment variable routines. */
 extern PCHAR ArcGetEnvironmentVariable(PCHAR name);
-extern LONG SetEnvironmentVariable(PCHAR name, PCHAR value);
+extern LONG ArcSetEnvironmentVariable(PCHAR name, PCHAR value);
 
 /* ARCS command line acquisition and parsing. */
 extern char *prom_getcmdline(void);
@@ -120,11 +119,11 @@
 extern long prom_exec(char *name, long argc, char **argv, char **envp);
 
 /* Misc. routines. */
-extern void prom_halt(VOID) __attribute__((noreturn));
-extern void prom_powerdown(VOID) __attribute__((noreturn));
-extern void prom_restart(VOID) __attribute__((noreturn));
+extern VOID prom_halt(VOID) __attribute__((noreturn));
+extern VOID prom_powerdown(VOID) __attribute__((noreturn));
+extern VOID prom_restart(VOID) __attribute__((noreturn));
 extern VOID ArcReboot(VOID) __attribute__((noreturn));
-extern VOID ArcEnterInteractiveMode(void) __attribute__((noreturn));
+extern VOID ArcEnterInteractiveMode(VOID) __attribute__((noreturn));
 extern long prom_cfgsave(VOID);
 extern struct linux_sysid *prom_getsysid(VOID);
 extern VOID ArcFlushAllCaches(VOID);
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips64/sgiarcs.h linux/include/asm-mips64/sgiarcs.h
--- linux-orig/include/asm-mips64/sgiarcs.h	Tue Jan 18 00:32:47 2000
+++ linux/include/asm-mips64/sgiarcs.h	Wed May 23 23:45:29 2001
@@ -143,7 +143,7 @@
 
 /* ARCS virtual dirents. */
 struct linux_vdirent {
-	unsigned long namelen;
+	ULONG namelen;
 	unsigned char attr;
 	char fname[32]; /* XXX imperical, should be a define */
 };
@@ -177,38 +177,38 @@
 	struct linux_bigint   begin;
 	struct linux_bigint   end;
 	struct linux_bigint   cur;
-	enum linux_devtypes dtype;
+	enum linux_devtypes   dtype;
 	unsigned long         namelen;
 	unsigned char         attr;
 	char                  name[32]; /* XXX imperical, should be define */
 };
 
-/* This describes the vector containing fuction pointers to the ARC
+/* This describes the vector containing function pointers to the ARC
    firmware functions.  */
 struct linux_romvec {
-	LONG load;			/* Load an executable image. */
-	LONG invoke;			/* Invoke a standalong image. */
-	LONG exec;			/* Load and begin execution of a
+	LONG	load;			/* Load an executable image. */
+	LONG	invoke;			/* Invoke a standalong image. */
+	LONG	exec;			/* Load and begin execution of a
 					   standalone image. */
-	LONG halt;			/* Halt the machine. */
-	LONG pdown;			/* Power down the machine. */
-	LONG restart;			/* XXX soft reset??? */
-	LONG reboot;			/* Reboot the machine. */
-	LONG imode;			/* Enter PROM interactive mode. */
-	LONG _unused1;			/* Was ReturnFromMain(). */
+	LONG	halt;			/* Halt the machine. */
+	LONG	pdown;			/* Power down the machine. */
+	LONG	restart;		/* XXX soft reset??? */
+	LONG	reboot;			/* Reboot the machine. */
+	LONG	imode;			/* Enter PROM interactive mode. */
+	LONG	_unused1;		/* Was ReturnFromMain(). */
 
 	/* PROM device tree interface. */
-	LONG next_component;
-	LONG child_component;
-	LONG parent_component;
-	LONG component_data;
-	LONG child_add;
-	LONG comp_del;
-	LONG component_by_path;
+	LONG	next_component;
+	LONG	child_component;
+	LONG	parent_component;
+	LONG	component_data;
+	LONG	child_add;
+	LONG	comp_del;
+	LONG	component_by_path;
 
 	/* Misc. stuff. */
-	LONG cfg_save;
-	LONG get_sysid;
+	LONG	cfg_save;
+	LONG	get_sysid;
 
 	/* Probing for memory. */
 	LONG	get_mdesc;
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips64/system.h linux/include/asm-mips64/system.h
--- linux-orig/include/asm-mips64/system.h	Thu Oct 26 03:18:01 2000
+++ linux/include/asm-mips64/system.h	Wed May 23 23:39:57 2001
@@ -33,7 +33,7 @@
 }
 
 /*
- * For cli() we have to insert nops to make shure that the new value
+ * For cli() we have to insert nops to make sure that the new value
  * has actually arrived in the status register before the end of this
  * macro.
  * R4000/R4400 need three nops, the R4600 two nops and the R10000 needs
Binary files linux-orig/vmlinux.64 and linux/vmlinux.64 differ
