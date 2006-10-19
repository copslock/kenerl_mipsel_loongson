Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 15:16:51 +0100 (BST)
Received: from bobafett.staff.proxad.net ([213.228.1.121]:30918 "EHLO
	bobafett.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S20038486AbWJSOQq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 15:16:46 +0100
Received: from localhost (localhost [127.0.0.1])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 5E49641D91;
	Thu, 19 Oct 2006 16:16:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at staff.proxad.net
Received: from bobafett.staff.proxad.net ([127.0.0.1])
	by localhost (bobafett.staff.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 9t-bk1uFutpv; Thu, 19 Oct 2006 16:16:40 +0200 (CEST)
Received: from nschichan.priv.staff.proxad.net (nschichan.priv.staff.proxad.net [172.18.3.120])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 3BFC73536;
	Thu, 19 Oct 2006 16:16:40 +0200 (CEST)
From:	Nicolas Schichan <nschichan@freebox.fr>
Organization: Freebox
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [patch] [RFC] Kexec on MIPS
Date:	Thu, 19 Oct 2006 16:16:39 +0200
User-Agent: KMail/1.9.1
References: <200610181514.56081.nschichan@freebox.fr> <200610182321.21299.nschichan@freebox.fr> <20061018223839.GA11263@linux-mips.org>
In-Reply-To: <20061018223839.GA11263@linux-mips.org>
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191616.40127.nschichan@freebox.fr>
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
Precedence: bulk
X-list: linux-mips

On Thursday 19 October 2006 00:38, you wrote:
> On Wed, Oct 18, 2006 at 11:21:21PM +0200, Nicolas Schichan wrote:
> +       sys     sys_kexec_load          1
> 
> The last column is the number of arguments slots of the syscall as counted
> by the MIPS argument passing conventions, so this should actually be 4.
> Not this was actually a harmless bug; it does hurt for syscalls that need
> more than 4 slots.

This is fixed in the patch following.

> diff -Nru linux-orig/arch/mips/kernel/scall64-n32.S
> linux-work/arch/mips/kernel/scall64-n32.S ---
> linux-orig/arch/mips/kernel/scall64-n32.S   2006-10-14 05:34:03.000000000
> +0200 +++ linux-work/arch/mips/kernel/scall64-n32.S   2006-10-17
> 15:58:59.000000000 +0200 @@ -392,3 +392,4 @@
>         PTR     sys_tee
>         PTR     sys_vmsplice                    /* 6271 */
>         PTR     sys_move_pages
> +       PTR     sys_kexec_load
> diff -Nru linux-orig/arch/mips/kernel/scall64-o32.S
> linux-work/arch/mips/kernel/scall64-o32.S ---
> linux-orig/arch/mips/kernel/scall64-o32.S   2006-10-14 05:34:03.000000000
> +0200 +++ linux-work/arch/mips/kernel/scall64-o32.S   2006-10-17
> 15:59:23.000000000 +0200 @@ -514,4 +514,5 @@
>         PTR     sys_tee
>         PTR     sys_vmsplice
>         PTR     compat_sys_move_pages
> +       PTR     sys_kexec_load
>         .size   sys_call_table,.-sys_call_table
>
> That is these two being 32-bit syscalls on a 64-bit kernel need to use the
> compat_sys_kexec_load syscall wrapper to work right.

This is fixed too in the patch following.

> And finally there are the syscall numbers.  The ones you've picked are
> already taken, so I've choosen:
>
> 	O32 ABI: 4311
> 	N64 ABI: 5270
> 	N32 ABI: 6270

The patch following updates scall*.S files accordingly. however as the patch 
is against 2.6.18 kernel I had to pad the holes in the syscall table with 
sys_ni_syscall.

> Note I'll allocate these syscalls immediately to give ABI stability - it's
> a standard Linux syscall afterall.  So you can drop the unistd.h bits from
> your patch.

ok, the unistd.h changes are dropped in the attached patch.

I also made CONFIG_KEXEC depend on !CONFIG_SMP.

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>

diff -Nrup linux-orig/arch/mips/Kconfig linux-work/arch/mips/Kconfig
--- linux-orig/arch/mips/Kconfig	2006-10-14 05:34:03.000000000 +0200
+++ linux-work/arch/mips/Kconfig	2006-10-19 15:18:18.000000000 +0200
@@ -820,6 +820,23 @@ config TOSHIBA_RBTX4938
 
 endchoice
 
+config KEXEC
+ 	bool "Kexec system call (EXPERIMENTAL)"
+ 	depends on EXPERIMENTAL && !SMP
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
diff -Nrup linux-orig/arch/mips/kernel/machine_kexec.c linux-work/arch/mips/kernel/machine_kexec.c
--- linux-orig/arch/mips/kernel/machine_kexec.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-work/arch/mips/kernel/machine_kexec.c	2006-10-19 15:38:01.000000000 +0200
@@ -0,0 +1,79 @@
+/*
+ * machine_kexec.c for kexec
+ * Created by <nschichan@freebox.fr> on Thu Oct 12 15:15:06 2006
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
+	kexec_indirection_page =
+	  (unsigned long)phys_to_virt(image->head & PAGE_MASK);
+
+	memcpy((void*)reboot_code_buffer, relocate_new_kernel,
+	       relocate_new_kernel_size);
+
+	/*
+	 * The generic kexec code builds a page list with physical
+	 * addresses. they are directly accessible through KSEG0 (or
+	 * XKSEG0 or XPHYS if on 64bit system), hence the
+	 * pys_to_virt() call.
+	 */
+	for (ptr = &image->head; (entry = *ptr) && !(entry &IND_DONE);
+	     ptr = (entry & IND_INDIRECTION) ?
+	       phys_to_virt(entry & PAGE_MASK) : ptr + 1) {
+		if (*ptr & IND_SOURCE || *ptr & IND_INDIRECTION ||
+		    *ptr & IND_DESTINATION)
+			*ptr = (unsigned long)phys_to_virt(*ptr);
+	}
+
+	printk("Will call new kernel at %08lx\n", image->start);
+	printk("Bye ...\n");
+	flush_cache_all();
+	local_irq_disable();
+	((void (*)(void))reboot_code_buffer)();
+}
diff -Nrup linux-orig/arch/mips/kernel/Makefile linux-work/arch/mips/kernel/Makefile
--- linux-orig/arch/mips/kernel/Makefile	2006-10-14 05:34:03.000000000 +0200
+++ linux-work/arch/mips/kernel/Makefile	2006-10-17 15:55:11.000000000 +0200
@@ -66,6 +66,8 @@ obj-$(CONFIG_64BIT)		+= cpu-bugs64.o
 
 obj-$(CONFIG_I8253)		+= i8253.o
 
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
+
 CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -Nrup linux-orig/arch/mips/kernel/relocate_kernel.S linux-work/arch/mips/kernel/relocate_kernel.S
--- linux-orig/arch/mips/kernel/relocate_kernel.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-work/arch/mips/kernel/relocate_kernel.S	2006-10-19 15:37:53.000000000 +0200
@@ -0,0 +1,80 @@
+/*
+ * relocate_kernel.S for kexec
+ * Created by <nschichan@freebox.fr> on Thu Oct 12 17:49:57 2006
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
diff -Nrup linux-orig/arch/mips/kernel/scall32-o32.S linux-work/arch/mips/kernel/scall32-o32.S
--- linux-orig/arch/mips/kernel/scall32-o32.S	2006-10-14 05:34:03.000000000 +0200
+++ linux-work/arch/mips/kernel/scall32-o32.S	2006-10-19 15:10:39.000000000 +0200
@@ -662,6 +662,9 @@ einval:	li	v0, -EINVAL
 	sys	sys_tee			4
 	sys	sys_vmsplice		4
 	sys	sys_move_pages		6
+	sys	sys_ni_syscall		0
+	sys	sys_ni_syscall		0	/* 4310 */
+	sys	sys_kexec_load		4
 	.endm
 
 	/* We pre-compute the number of _instruction_ bytes needed to
diff -Nrup linux-orig/arch/mips/kernel/scall64-64.S linux-work/arch/mips/kernel/scall64-64.S
--- linux-orig/arch/mips/kernel/scall64-64.S	2006-10-14 05:34:03.000000000 +0200
+++ linux-work/arch/mips/kernel/scall64-64.S	2006-10-19 15:14:27.000000000 +0200
@@ -466,3 +466,6 @@ sys_call_table:
 	PTR	sys_tee				/* 5265 */
 	PTR	sys_vmsplice
 	PTR	sys_move_pages
+	PTR	sys_ni_syscall
+	PTR	sys_ni_syscall
+	PTR	sys_kexec_load			/* 5270 */
diff -Nrup linux-orig/arch/mips/kernel/scall64-n32.S linux-work/arch/mips/kernel/scall64-n32.S
--- linux-orig/arch/mips/kernel/scall64-n32.S	2006-10-14 05:34:03.000000000 +0200
+++ linux-work/arch/mips/kernel/scall64-n32.S	2006-10-19 15:17:44.000000000 +0200
@@ -390,5 +390,8 @@ EXPORT(sysn32_call_table)
 	PTR	sys_splice
 	PTR	sys_sync_file_range
 	PTR	sys_tee
-	PTR	sys_vmsplice			/* 6271 */
+	PTR	sys_vmsplice			/* 6270 */
 	PTR	sys_move_pages
+	PTR	sys_ni_syscall
+	PTR	sys_ni_syscall
+	PTR	compat_sys_kexec_load
diff -Nrup linux-orig/arch/mips/kernel/scall64-o32.S linux-work/arch/mips/kernel/scall64-o32.S
--- linux-orig/arch/mips/kernel/scall64-o32.S	2006-10-14 05:34:03.000000000 +0200
+++ linux-work/arch/mips/kernel/scall64-o32.S	2006-10-19 15:17:54.000000000 +0200
@@ -514,4 +514,7 @@ sys_call_table:
 	PTR	sys_tee
 	PTR	sys_vmsplice
 	PTR	compat_sys_move_pages
+	PTR	sys_ni_syscall
+	PTR	sys_ni_syscall			/* 4310 */
+	PTR	compat_sys_kexec_load
 	.size	sys_call_table,.-sys_call_table
diff -Nrup linux-orig/include/asm-mips/kexec.h linux-work/include/asm-mips/kexec.h
--- linux-orig/include/asm-mips/kexec.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-work/include/asm-mips/kexec.h	2006-10-19 15:38:15.000000000 +0200
@@ -0,0 +1,32 @@
+/*
+ * kexec.h for kexec
+ * Created by <nschichan@freebox.fr> on Thu Oct 12 14:59:34 2006
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#ifndef _MIPS_KEXEC
+# define _MIPS_KEXEC
+
+/* Maximum physical address we can use pages from */
+#define KEXEC_SOURCE_MEMORY_LIMIT (HIGHMEM_START)
+/* Maximum address we can reach in physical address mode */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (HIGHMEM_START)
+ /* Maximum address we can use for the control code buffer */
+#define KEXEC_CONTROL_MEMORY_LIMIT (HIGHMEM_START)
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
diff -Nrup linux-orig/include/linux/kexec.h linux-work/include/linux/kexec.h
--- linux-orig/include/linux/kexec.h	2006-10-14 05:34:03.000000000 +0200
+++ linux-work/include/linux/kexec.h	2006-10-17 16:21:49.000000000 +0200
@@ -122,6 +122,8 @@ extern struct kimage *kexec_crash_image;
 #define KEXEC_ARCH_IA_64   (50 << 16)
 #define KEXEC_ARCH_S390    (22 << 16)
 #define KEXEC_ARCH_SH      (42 << 16)
+#define KEXEC_ARCH_MIPS_LE (10 << 16)
+#define KEXEC_ARCH_MIPS    ( 8 << 16)
 
 #define KEXEC_FLAGS    (KEXEC_ON_CRASH)  /* List of defined/legal kexec flags */
 
-- 
Nicolas Schichan
