Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2006 14:15:03 +0100 (BST)
Received: from bobafett.staff.proxad.net ([213.228.1.121]:215 "EHLO
	bobafett.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S20038490AbWJRNO7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Oct 2006 14:14:59 +0100
Received: from localhost (localhost [127.0.0.1])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 45D8641CA9
	for <linux-mips@linux-mips.org>; Wed, 18 Oct 2006 15:14:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at staff.proxad.net
Received: from bobafett.staff.proxad.net ([127.0.0.1])
	by localhost (bobafett.staff.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QPTFvBpilyLE for <linux-mips@linux-mips.org>;
	Wed, 18 Oct 2006 15:14:56 +0200 (CEST)
Received: from nschichan.priv.staff.proxad.net (nschichan.priv.staff.proxad.net [172.18.3.120])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 2C2312F0AB
	for <linux-mips@linux-mips.org>; Wed, 18 Oct 2006 15:14:56 +0200 (CEST)
From:	Nicolas Schichan <nschichan@freebox.fr>
Organization: Freebox
Subject: [patch] [RFC] Kexec on MIPS
Date:	Wed, 18 Oct 2006 15:14:55 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
To:	linux-mips@linux-mips.org
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QjiNFCi6JndWGNG"
Message-Id: <200610181514.56081.nschichan@freebox.fr>
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
Precedence: bulk
X-list: linux-mips

--Boundary-00=_QjiNFCi6JndWGNG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hello,

I have implemented kexec support for the mips architecture, the code is 
available in the attached patch (for 2.6.18 kernel). This code works fine on 
the mips boards I use at work (one in big endian and one in little endian) and 
on qemu.

However it has not been tested on 64 bit mips and it may not work on
those architectures.

It may also not work on machines with more than 512 megabytes as the kexec 
generic code may fill the page list with adresses over the 512 megabytes 
limit (the mips boards I use only have 16mbytes and 32mbytes ram).

A tiny userland application loading the kernel and invoking kexec_load for 
mips is available here:

http://chac.le-poulpe.net/~nico/kexec/kexec-2006-10-18.tar.gz

Do not hesitate to comment on this patch,

Regards,

-- 
Nicolas Schichan

--Boundary-00=_QjiNFCi6JndWGNG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="kexec-mips"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kexec-mips"

diff -Nru linux-orig/arch/mips/Kconfig linux-work/arch/mips/Kconfig
--- linux-orig/arch/mips/Kconfig	2006-10-14 05:34:03.000000000 +0200
+++ linux-work/arch/mips/Kconfig	2006-10-17 16:12:04.000000000 +0200
@@ -820,6 +820,23 @@
 
 endchoice
 
+config KEXEC
+ 	bool "Kexec system call (EXPERIMENTAL)"
+ 	depends on EXPERIMENTAL
+ 	help
+ 	  kexec is a system call that implements the ability to shutdown your
+ 	  current kernel, and to start another kernel.  It is like a reboot
+ 	  but it is indepedent of the system firmware.   And like a reboot
+ 	  you can start any kernel with it, not just Linux.
+
+ 	  The name comes from the similiarity to the exec system call.
+
+ 	  It is an ongoing process to be certain the hardware in a machine
+ 	  is properly shutdown, so do not be surprised if this code does not
+ 	  initially work for you.  It may help to enable device hotplugging
+ 	  support.  As of this writing the exact hardware interface is
+ 	  strongly in flux, so no good recommendation can be made.
+
 source "arch/mips/ddb5xxx/Kconfig"
 source "arch/mips/gt64120/ev64120/Kconfig"
 source "arch/mips/jazz/Kconfig"
diff -Nru linux-orig/arch/mips/kernel/machine_kexec.c linux-work/arch/mips/kernel/machine_kexec.c
--- linux-orig/arch/mips/kernel/machine_kexec.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-work/arch/mips/kernel/machine_kexec.c	2006-10-18 14:03:59.000000000 +0200
@@ -0,0 +1,84 @@
+/*
+ * machine_kexec.c for kexec
+ * Created by <nschichan@corp.free.fr> on Thu Oct 12 15:15:06 2006
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <linux/kexec.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+
+#include <asm/cacheflush.h>
+#include <asm/page.h>
+
+const extern unsigned char relocate_new_kernel[];
+const extern unsigned int relocate_new_kernel_size;
+
+extern unsigned long kexec_start_address;
+extern unsigned long kexec_indirection_page;
+
+int
+machine_kexec_prepare(struct kimage *kimage)
+{
+	return 0;
+}
+
+void
+machine_kexec_cleanup(struct kimage *kimage)
+{
+}
+
+void
+machine_shutdown(void)
+{
+}
+
+void
+machine_crash_shutdown(struct pt_regs *regs)
+{
+}
+
+void
+machine_kexec(struct kimage *image)
+{
+	unsigned long reboot_code_buffer;
+	unsigned long entry;
+	unsigned long *ptr;
+
+	reboot_code_buffer =
+	  (unsigned long)page_address(image->control_code_page);
+
+	kexec_start_address = image->start;
+	kexec_indirection_page = phys_to_virt(image->head & PAGE_MASK);
+
+	memcpy((void*)reboot_code_buffer, relocate_new_kernel,
+	       relocate_new_kernel_size);
+
+	/*
+	 * The generic kexec code builds a page list with physical
+	 * addresses. they are directly accessible through KSEG0,
+	 * hence the pys_to_virt() call.
+	 */
+	for (ptr = &image->head; (entry = *ptr) && !(entry &IND_DONE);
+	     ptr = (entry & IND_INDIRECTION) ?
+	       phys_to_virt(entry & PAGE_MASK) : ptr + 1) {
+		if (*ptr & IND_SOURCE || *ptr & IND_INDIRECTION ||
+		    *ptr & IND_DESTINATION)
+			*ptr = phys_to_virt(*ptr);
+	}
+
+	/*
+	 * we do not want to be bothered.
+	 */
+	local_irq_disable();
+
+	flush_icache_range(reboot_code_buffer,
+			   reboot_code_buffer + KEXEC_CONTROL_CODE_SIZE);
+
+	printk("Will call new kernel at %08x\n", image->start);
+	printk("Bye ...\n");
+	flush_cache_all();
+	((void (*)(void))reboot_code_buffer)();
+}
diff -Nru linux-orig/arch/mips/kernel/Makefile linux-work/arch/mips/kernel/Makefile
--- linux-orig/arch/mips/kernel/Makefile	2006-10-14 05:34:03.000000000 +0200
+++ linux-work/arch/mips/kernel/Makefile	2006-10-17 15:55:11.000000000 +0200
@@ -66,6 +66,8 @@
 
 obj-$(CONFIG_I8253)		+= i8253.o
 
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
+
 CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -Nru linux-orig/arch/mips/kernel/relocate_kernel.S linux-work/arch/mips/kernel/relocate_kernel.S
--- linux-orig/arch/mips/kernel/relocate_kernel.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-work/arch/mips/kernel/relocate_kernel.S	2006-10-17 20:01:06.000000000 +0200
@@ -0,0 +1,80 @@
+/*
+ * relocate_kernel.S for kexec
+ * Created by <nschichan@corp.free.fr> on Thu Oct 12 17:49:57 2006
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/regdef.h>
+#include <asm/page.h>
+#include <asm/mipsregs.h>
+#include <asm/stackframe.h>
+#include <asm/addrspace.h>
+
+	.globl relocate_new_kernel
+relocate_new_kernel:
+
+	PTR_L	s0, kexec_indirection_page
+	PTR_L	s1, kexec_start_address
+
+process_entry:
+	PTR_L	s2, (s0)
+	PTR_ADD	s0, s0, SZREG
+
+	/* destination page */
+	and	s3, s2, 0x1
+	beq	s3, zero, 1f
+	and	s4, s2, ~0x1	/* store destination addr in s4 */
+	move	a0, s4
+	b	process_entry
+
+1:
+	/* indirection page, update s0  */
+	and	s3, s2, 0x2
+	beq	s3, zero, 1f
+	and	s0, s2, ~0x2
+	b	process_entry
+
+1:
+	/* done page */
+	and	s3, s2, 0x4
+	beq	s3, zero, 1f
+	b	done
+1:
+	/* source page */
+	and	s3, s2, 0x8
+	beq	s3, zero, process_entry
+	and	s2, s2, ~0x8
+	li	s6, (1 << PAGE_SHIFT) / SZREG
+
+copy_word:
+	/* copy page word by word */
+	REG_L	s5, (s2)
+	REG_S	s5, (s4)
+	INT_ADD	s4, s4, SZREG
+	INT_ADD	s2, s2, SZREG
+	INT_SUB	s6, s6, 1
+	beq	s6, zero, process_entry
+	b	copy_word
+	b	process_entry
+
+done:
+	/* jump to kexec_start_address */
+	j	s1
+
+	.globl kexec_start_address
+kexec_start_address:
+	.long	0x0
+
+	.globl kexec_indirection_page
+kexec_indirection_page:
+	.long	0x0
+
+relocate_new_kernel_end:
+
+	.globl relocate_new_kernel_size
+relocate_new_kernel_size:
+	.long relocate_new_kernel_end - relocate_new_kernel
diff -Nru linux-orig/arch/mips/kernel/scall32-o32.S linux-work/arch/mips/kernel/scall32-o32.S
--- linux-orig/arch/mips/kernel/scall32-o32.S	2006-10-14 05:34:03.000000000 +0200
+++ linux-work/arch/mips/kernel/scall32-o32.S	2006-10-17 16:23:21.000000000 +0200
@@ -662,6 +662,7 @@
 	sys	sys_tee			4
 	sys	sys_vmsplice		4
 	sys	sys_move_pages		6
+	sys	sys_kexec_load		1
 	.endm
 
 	/* We pre-compute the number of _instruction_ bytes needed to
diff -Nru linux-orig/arch/mips/kernel/scall64-64.S linux-work/arch/mips/kernel/scall64-64.S
--- linux-orig/arch/mips/kernel/scall64-64.S	2006-10-14 05:34:03.000000000 +0200
+++ linux-work/arch/mips/kernel/scall64-64.S	2006-10-17 15:57:15.000000000 +0200
@@ -466,3 +466,4 @@
 	PTR	sys_tee				/* 5265 */
 	PTR	sys_vmsplice
 	PTR	sys_move_pages
+	PTR	sys_kexec_load
diff -Nru linux-orig/arch/mips/kernel/scall64-n32.S linux-work/arch/mips/kernel/scall64-n32.S
--- linux-orig/arch/mips/kernel/scall64-n32.S	2006-10-14 05:34:03.000000000 +0200
+++ linux-work/arch/mips/kernel/scall64-n32.S	2006-10-17 15:58:59.000000000 +0200
@@ -392,3 +392,4 @@
 	PTR	sys_tee
 	PTR	sys_vmsplice			/* 6271 */
 	PTR	sys_move_pages
+	PTR	sys_kexec_load
diff -Nru linux-orig/arch/mips/kernel/scall64-o32.S linux-work/arch/mips/kernel/scall64-o32.S
--- linux-orig/arch/mips/kernel/scall64-o32.S	2006-10-14 05:34:03.000000000 +0200
+++ linux-work/arch/mips/kernel/scall64-o32.S	2006-10-17 15:59:23.000000000 +0200
@@ -514,4 +514,5 @@
 	PTR	sys_tee
 	PTR	sys_vmsplice
 	PTR	compat_sys_move_pages
+	PTR	sys_kexec_load
 	.size	sys_call_table,.-sys_call_table
diff -Nru linux-orig/include/asm-mips/kexec.h linux-work/include/asm-mips/kexec.h
--- linux-orig/include/asm-mips/kexec.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-work/include/asm-mips/kexec.h	2006-10-18 12:29:12.000000000 +0200
@@ -0,0 +1,32 @@
+/*
+ * kexec.h for kexec
+ * Created by <nschichan@corp.free.fr> on Thu Oct 12 14:59:34 2006
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#ifndef _MIPS_KEXEC
+# define _MIPS_KEXEC
+
+/* Maximum physical address we can use pages from */
+#define KEXEC_SOURCE_MEMORY_LIMIT (0x20000000)
+/* Maximum address we can reach in physical address mode */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (0x20000000)
+ /* Maximum address we can use for the control code buffer */
+#define KEXEC_CONTROL_MEMORY_LIMIT (0x20000000)
+
+#define KEXEC_CONTROL_CODE_SIZE 4096
+
+/* The native architecture */
+#define KEXEC_ARCH KEXEC_ARCH_MIPS
+
+#define MAX_NOTE_BYTES 1024
+
+static inline void crash_setup_regs(struct pt_regs *newregs,
+				    struct pt_regs *oldregs)
+{
+	/* Dummy implementation for now */
+}
+
+#endif /* !_MIPS_KEXEC */
diff -Nru linux-orig/include/asm-mips/unistd.h linux-work/include/asm-mips/unistd.h
--- linux-orig/include/asm-mips/unistd.h	2006-10-14 05:34:03.000000000 +0200
+++ linux-work/include/asm-mips/unistd.h	2006-10-17 16:07:57.000000000 +0200
@@ -329,16 +329,17 @@
 #define __NR_tee			(__NR_Linux + 306)
 #define __NR_vmsplice			(__NR_Linux + 307)
 #define __NR_move_pages			(__NR_Linux + 308)
+#define __NR_kexec_load			(__NR_Linux + 309)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		308
+#define __NR_Linux_syscalls		309
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		308
+#define __NR_O32_Linux_syscalls		309
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -614,16 +615,17 @@
 #define __NR_tee			(__NR_Linux + 265)
 #define __NR_vmsplice			(__NR_Linux + 266)
 #define __NR_move_pages			(__NR_Linux + 267)
+#define __NR_kexec_load			(__NR_Linux + 268)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		267
+#define __NR_Linux_syscalls		268
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		267
+#define __NR_64_Linux_syscalls		268
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -903,16 +905,16 @@
 #define __NR_tee			(__NR_Linux + 269)
 #define __NR_vmsplice			(__NR_Linux + 270)
 #define __NR_move_pages			(__NR_Linux + 271)
-
+#define __NR_kexec_load			(__Nr_Linux + 272)
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		271
+#define __NR_Linux_syscalls		272
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		271
+#define __NR_N32_Linux_syscalls		272
 
 #ifdef __KERNEL__
 
diff -Nru linux-orig/include/linux/kexec.h linux-work/include/linux/kexec.h
--- linux-orig/include/linux/kexec.h	2006-10-14 05:34:03.000000000 +0200
+++ linux-work/include/linux/kexec.h	2006-10-17 16:21:49.000000000 +0200
@@ -122,6 +122,8 @@
 #define KEXEC_ARCH_IA_64   (50 << 16)
 #define KEXEC_ARCH_S390    (22 << 16)
 #define KEXEC_ARCH_SH      (42 << 16)
+#define KEXEC_ARCH_MIPS_LE (10 << 16)
+#define KEXEC_ARCH_MIPS    ( 8 << 16)
 
 #define KEXEC_FLAGS    (KEXEC_ON_CRASH)  /* List of defined/legal kexec flags */
 
diff -Nru linux-orig/Makefile linux-work/Makefile
--- linux-orig/Makefile	2006-10-14 05:34:03.000000000 +0200
+++ linux-work/Makefile	2006-10-17 16:09:02.000000000 +0200
@@ -149,10 +149,11 @@
 # then ARCH is assigned, getting whatever value it gets normally, and 
 # SUBARCH is subsequently ignored.
 
-SUBARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ \
-				  -e s/arm.*/arm/ -e s/sa110/arm/ \
-				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
-				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ )
+SUBARCH := mips
+# $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ \
+#				  -e s/arm.*/arm/ -e s/sa110/arm/ \
+#				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
+#				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ )
 
 # Cross compiling and selecting different set of gcc/bin-utils
 # ---------------------------------------------------------------------------

--Boundary-00=_QjiNFCi6JndWGNG--
