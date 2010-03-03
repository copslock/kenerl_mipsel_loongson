Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 12:05:46 +0100 (CET)
Received: from mail-bw0-f226.google.com ([209.85.218.226]:60457 "EHLO
        mail-bw0-f226.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490990Ab0CCLFj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 12:05:39 +0100
Received: by bwz26 with SMTP id 26so1188708bwz.27
        for <multiple recipients>; Wed, 03 Mar 2010 03:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:to:cc:from:subject:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=1nXrqKmR9J2bgDxLGEfEErXxraaXlYosngJRbGtdYXs=;
        b=FQeuz4iwXwH8gvwki/KzrKynhqxs4pKRaQ+BL6CGJvRFUhQGPUGUdPzArBAY0aJFEm
         t2kBz9miywoXrTVwomkqjUj+gWuhWCcMnfn3zcicJhhwTjZYY/bU7ZVbrDV9qosNXao9
         XIMXWi9zbt9qI+sOdikJMSbJUE4tskOETGgdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:from:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=oPht3QpLNdWtRbl2d+v8OrZVtH0hBhvBp1UkKTVFK7nvHp4XK/GWABWeEEzTkE6Z45
         D4LPSc34nR+zMgHGzjbyt2mr6KzkfHWBKMZSdcJf5pRbhAqpiCKkG4f3FPZfeyg4iCH6
         YdNU7lUGBQhPM/hwWeTi0Ct/nTkJeiV5OuHV8=
Received: by 10.204.20.137 with SMTP id f9mr5952648bkb.130.1267614331024;
        Wed, 03 Mar 2010 03:05:31 -0800 (PST)
Received: from ?127.0.1.1? (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id 14sm3569954bwz.10.2010.03.03.03.05.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Mar 2010 03:05:30 -0800 (PST)
To:     linux-mips@linux-mips.org, kexec@lists.infradead.org
Cc:     horms@verge.net.au, ralf@linux-mips.org
From:   Maxim Uvarov <muvarov@gmail.com>
Subject: [PATCH 1/2] MIPS kexec,kdump support
Date:   Wed, 03 Mar 2010 14:05:27 +0300
Message-ID: <20100303110527.11233.20400.stgit@muvarov>
User-Agent: StGIT/0.14.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <muvarov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: muvarov@gmail.com
Precedence: bulk
X-list: linux-mips

Hello folks,

Please find here MIPS crash and kdump patches.
This is patch set of 3 patches:
1. generic MIPS changes (kernel);
2. MIPS Cavium Octeon board kexec/kdump code (kernel);
3. Kexec user space MIPS changes.

Patches were tested on the latest linux-mips@ git kernel and the latest
kexec-tools git on Cavium Octeon 50xx board.

I also made the same code working on RMI XLR/XLS boards for both
mips32 and mips64 kernels.

Best regards,
Maxim Uvarov.


---

 arch/mips/Kconfig                  |   24 ++++++++++
 arch/mips/Makefile                 |    4 ++
 arch/mips/include/asm/kexec.h      |   31 +++++++++++--
 arch/mips/include/asm/smp.h        |    7 +++
 arch/mips/kernel/Makefile          |    3 +
 arch/mips/kernel/crash.c           |   75 +++++++++++++++++++++++++++++++
 arch/mips/kernel/crash_dump.c      |   86 +++++++++++++++++++++++++++++++++++
 arch/mips/kernel/machine_kexec.c   |   30 +++++++++++-
 arch/mips/kernel/relocate_kernel.S |   88 ++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/setup.c           |   55 +++++++++++++++++++++++
 arch/mips/kernel/smp.c             |   18 +++++++
 11 files changed, 413 insertions(+), 8 deletions(-)
 create mode 100644 arch/mips/kernel/crash.c
 create mode 100644 arch/mips/kernel/crash_dump.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 591ca0c..8079260 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2035,6 +2035,30 @@ config KEXEC
 	  support.  As of this writing the exact hardware interface is
 	  strongly in flux, so no good recommendation can be made.
 
+config CRASH_DUMP
+	  bool "kernel crash dumps (EXPERIMENTAL)"
+	  depends on EXPERIMENTAL
+	  help
+	  Generate crash dump after being started by kexec.
+	  This should be normally only set in special crash dump kernels
+	  which are loaded in the main kernel with kexec-tools into
+	  a specially reserved region and then later executed after
+	  a crash by kdump/kexec. The crash dump kernel must be compiled
+	  to a memory address not used by the main kernel or BIOS using
+	  PHYSICAL_START.
+
+config PHYSICAL_START
+	  hex "Physical address where the kernel is loaded"
+	  default "0xffffffff84000000" if 64BIT
+	  default "0x84000000" if 32BIT
+	  depends on CRASH_DUMP
+	  help
+	  This gives the CKSEG0 or KSEG0 address where the kernel is loaded.
+	  If you plan to use kernel for capturing the crash dump change
+	  this value to start of the reserved region (the "X" value as
+			  specified in the "crashkernel=YM@XM" command line boot parameter
+			  passed to the panic-ed kernel).
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 2f2eac2..431283d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -646,6 +646,10 @@ else
 load-$(CONFIG_CPU_CAVIUM_OCTEON) 	+= 0xffffffff81100000
 endif
 
+ifdef CONFIG_PHYSICAL_START
+load-y                                  = $(CONFIG_PHYSICAL_START)
+endif
+
 cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
 
diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index 4314892..e9eba1a 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -9,22 +9,45 @@
 #ifndef _MIPS_KEXEC
 # define _MIPS_KEXEC
 
+#include <asm/stacktrace.h>
+
+extern unsigned long long elfcorehdr_addr;
+
 /* Maximum physical address we can use pages from */
 #define KEXEC_SOURCE_MEMORY_LIMIT (0x20000000)
 /* Maximum address we can reach in physical address mode */
 #define KEXEC_DESTINATION_MEMORY_LIMIT (0x20000000)
  /* Maximum address we can use for the control code buffer */
 #define KEXEC_CONTROL_MEMORY_LIMIT (0x20000000)
-
-#define KEXEC_CONTROL_PAGE_SIZE 4096
+/* Reserve 3*4096 bytes for board-specific info */
+#define KEXEC_CONTROL_PAGE_SIZE (4096 + 3*4096)
 
 /* The native architecture */
 #define KEXEC_ARCH KEXEC_ARCH_MIPS
+#define MAX_NOTE_BYTES 1024
 
 static inline void crash_setup_regs(struct pt_regs *newregs,
-				    struct pt_regs *oldregs)
+					struct pt_regs *oldregs)
 {
-	/* Dummy implementation for now */
+	if (oldregs)
+		memcpy(newregs, oldregs, sizeof(*newregs));
+	else
+		prepare_frametrace(newregs);
 }
 
+#ifdef CONFIG_KEXEC
+struct kimage;
+extern unsigned long kexec_args[4];
+extern int (*_machine_kexec_prepare)(struct kimage *);
+extern void (*_machine_kexec_shutdown)(void);
+extern void (*_machine_crash_shutdown)(struct pt_regs *regs);
+extern void default_machine_crash_shutdown(struct pt_regs *regs);
+#ifdef CONFIG_SMP
+extern const unsigned char kexec_smp_wait[];
+extern unsigned long secondary_kexec_args[4];
+extern void (*relocated_kexec_smp_wait) (void *);
+extern atomic_t kexec_ready_to_reboot;
+#endif
+#endif
+
 #endif /* !_MIPS_KEXEC */
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index af42385..9b50048 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -40,6 +40,8 @@ extern int __cpu_logical_map[NR_CPUS];
 #define SMP_CALL_FUNCTION	0x2
 /* Octeon - Tell another core to flush its icache */
 #define SMP_ICACHE_FLUSH	0x4
+/* Used by kexec crashdump to save all cpu's state */
+#define SMP_DUMP		0x8
 
 extern volatile cpumask_t cpu_callin_map;
 
@@ -91,4 +93,9 @@ static inline void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 	mp_ops->send_ipi_mask(mask, SMP_CALL_FUNCTION);
 }
 
+extern void core_send_ipi(int cpu, unsigned int action);
+#if defined(CONFIG_KEXEC)
+extern void (*dump_ipi_function_ptr)(void *);
+void dump_send_ipi(void (*dump_ipi_callback)(void *));
+#endif
 #endif /* __ASM_SMP_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index ef20957..7ae634d 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -91,7 +91,8 @@ obj-$(CONFIG_I8253)		+= i8253.o
 
 obj-$(CONFIG_GPIO_TXX9)		+= gpio_txx9.o
 
-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o crash.o
+obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_SPINLOCK_TEST)	+= spinlock_test.o
 
diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
new file mode 100644
index 0000000..24247ea
--- /dev/null
+++ b/arch/mips/kernel/crash.c
@@ -0,0 +1,75 @@
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/reboot.h>
+#include <linux/kexec.h>
+#include <linux/bootmem.h>
+#include <linux/crash_dump.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+
+#ifdef CONFIG_CRASH_DUMP
+unsigned long long elfcorehdr_addr = ELFCORE_ADDR_MAX;
+#endif
+
+/* This keeps a track of which one is crashing cpu. */
+int crashing_cpu = -1;
+static cpumask_t cpus_in_crash = CPU_MASK_NONE;
+
+#ifdef CONFIG_SMP
+void crash_shutdown_secondary(void *ignore)
+{
+	struct pt_regs *regs;
+	int cpu = smp_processor_id();
+
+	regs = task_pt_regs(current);
+
+	if (!cpu_online(cpu))
+		return;
+
+	local_irq_disable();
+	if (!cpu_isset(cpu, cpus_in_crash))
+		crash_save_cpu(regs, cpu);
+	cpu_set(cpu, cpus_in_crash);
+
+	while (!atomic_read(&kexec_ready_to_reboot))
+		cpu_relax();
+	relocated_kexec_smp_wait(NULL);
+	/* NOTREACHED */
+}
+
+static void crash_kexec_prepare_cpus(void)
+{
+	unsigned int msecs;
+
+	unsigned int ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
+
+	dump_send_ipi(crash_shutdown_secondary);
+	smp_wmb();
+
+	/*
+	 * The crash CPU sends an IPI and wait for other CPUs to
+	 * respond. Delay of at least 10 seconds.
+	 */
+	printk(KERN_EMERG "Sending IPI to other cpus...\n");
+	msecs = 10000;
+	while ((cpus_weight(cpus_in_crash) < ncpus) && (--msecs > 0)) {
+		cpu_relax();
+		mdelay(1);
+	}
+}
+
+#else
+static void crash_kexec_prepare_cpus() {}
+#endif
+
+void default_machine_crash_shutdown(struct pt_regs *regs)
+{
+	local_irq_disable();
+	crashing_cpu = smp_processor_id();
+	crash_save_cpu(regs, crashing_cpu);
+	crash_kexec_prepare_cpus();
+	cpu_set(crashing_cpu, cpus_in_crash);
+}
diff --git a/arch/mips/kernel/crash_dump.c b/arch/mips/kernel/crash_dump.c
new file mode 100644
index 0000000..49e5efa
--- /dev/null
+++ b/arch/mips/kernel/crash_dump.c
@@ -0,0 +1,86 @@
+#include <linux/highmem.h>
+#include <linux/bootmem.h>
+#include <linux/crash_dump.h>
+#include <asm/uaccess.h>
+
+#ifdef CONFIG_PROC_VMCORE
+static int __init parse_elfcorehdr(char *p)
+{
+	if (p)
+		elfcorehdr_addr = memparse(p, &p);
+	return 1;
+}
+__setup("elfcorehdr=", parse_elfcorehdr);
+#endif
+
+static int __init parse_savemaxmem(char *p)
+{
+	if (p)
+		saved_max_pfn = (memparse(p, &p) >> PAGE_SHIFT) - 1;
+
+	return 1;
+}
+__setup("savemaxmem=", parse_savemaxmem);
+
+
+static void *kdump_buf_page;
+
+/**
+ * copy_oldmem_page - copy one page from "oldmem"
+ * @pfn: page frame number to be copied
+ * @buf: target memory address for the copy; this can be in kernel address
+ *	space or user address space (see @userbuf)
+ * @csize: number of bytes to copy
+ * @offset: offset in bytes into the page (based on pfn) to begin the copy
+ * @userbuf: if set, @buf is in user address space, use copy_to_user(),
+ *	otherwise @buf is in kernel address space, use memcpy().
+ *
+ * Copy a page from "oldmem". For this page, there is no pte mapped
+ * in the current kernel.
+ *
+ * Calling copy_to_user() in atomic context is not desirable. Hence first
+ * copying the data to a pre-allocated kernel page and then copying to user
+ * space in non-atomic context.
+ */
+ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
+                               size_t csize, unsigned long offset, int userbuf)
+{
+	void  *vaddr;
+
+	if (!csize)
+		return 0;
+
+	vaddr = kmap_atomic_pfn(pfn, KM_PTE0);
+
+	if (!userbuf) {
+		memcpy(buf, (vaddr + offset), csize);
+		kunmap_atomic(vaddr, KM_PTE0);
+	} else {
+		if (!kdump_buf_page) {
+			printk(KERN_WARNING "Kdump: Kdump buffer page not"
+				" allocated\n");
+			return -EFAULT;
+		}
+		copy_page(kdump_buf_page, vaddr);
+		kunmap_atomic(vaddr, KM_PTE0);
+		if (copy_to_user(buf, (kdump_buf_page + offset), csize))
+			return -EFAULT;
+	}
+
+	return csize;
+}
+
+static int __init kdump_buf_page_init(void)
+{
+	int ret = 0;
+
+	kdump_buf_page = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!kdump_buf_page) {
+		printk(KERN_WARNING "Kdump: Failed to allocate kdump buffer"
+			 " page\n");
+		ret = -ENOMEM;
+	}
+
+	return ret;
+}
+arch_initcall(kdump_buf_page_init);
diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 85beb9b..4d25843 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -19,9 +19,19 @@ extern const size_t relocate_new_kernel_size;
 extern unsigned long kexec_start_address;
 extern unsigned long kexec_indirection_page;
 
+int (*_machine_kexec_prepare)(struct kimage *) = NULL;
+void (*_machine_kexec_shutdown)(void) = NULL;
+void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
+#ifdef CONFIG_SMP
+void (*relocated_kexec_smp_wait) (void *);
+atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
+#endif
+
 int
 machine_kexec_prepare(struct kimage *kimage)
 {
+	if (_machine_kexec_prepare)
+		return _machine_kexec_prepare(kimage);
 	return 0;
 }
 
@@ -33,11 +43,17 @@ machine_kexec_cleanup(struct kimage *kimage)
 void
 machine_shutdown(void)
 {
+	if (_machine_kexec_shutdown)
+		_machine_kexec_shutdown();
 }
 
 void
 machine_crash_shutdown(struct pt_regs *regs)
 {
+	if (_machine_crash_shutdown)
+		_machine_crash_shutdown(regs);
+	else
+		default_machine_crash_shutdown(regs);
 }
 
 typedef void (*noretfun_t)(void) __attribute__((noreturn));
@@ -52,7 +68,9 @@ machine_kexec(struct kimage *image)
 	reboot_code_buffer =
 	  (unsigned long)page_address(image->control_code_page);
 
-	kexec_start_address = image->start;
+	kexec_start_address =
+		(unsigned long) phys_to_virt(image->start);
+
 	kexec_indirection_page =
 		(unsigned long) phys_to_virt(image->head & PAGE_MASK);
 
@@ -63,7 +81,7 @@ machine_kexec(struct kimage *image)
 	 * The generic kexec code builds a page list with physical
 	 * addresses. they are directly accessible through KSEG0 (or
 	 * CKSEG0 or XPHYS if on 64bit system), hence the
-	 * pys_to_virt() call.
+	 * phys_to_virt() call.
 	 */
 	for (ptr = &image->head; (entry = *ptr) && !(entry &IND_DONE);
 	     ptr = (entry & IND_INDIRECTION) ?
@@ -81,5 +99,13 @@ machine_kexec(struct kimage *image)
 	printk("Will call new kernel at %08lx\n", image->start);
 	printk("Bye ...\n");
 	__flush_cache_all();
+#ifdef CONFIG_SMP
+	/* All secondary cpus now may jump to kexec_wait cycle */
+	relocated_kexec_smp_wait = reboot_code_buffer +
+		(void *)(kexec_smp_wait - relocate_new_kernel);
+	smp_wmb();
+	atomic_set(&kexec_ready_to_reboot, 1);
+#endif
 	((noretfun_t) reboot_code_buffer)();
 }
+
diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/relocate_kernel.S
index 87481f9..0abaf7a 100644
--- a/arch/mips/kernel/relocate_kernel.S
+++ b/arch/mips/kernel/relocate_kernel.S
@@ -15,6 +15,11 @@
 #include <asm/addrspace.h>
 
 LEAF(relocate_new_kernel)
+	PTR_L a0,	arg0
+	PTR_L a1,	arg1
+	PTR_L a2,	arg2
+	PTR_L a3,	arg3
+
 	PTR_L		s0, kexec_indirection_page
 	PTR_L		s1, kexec_start_address
 
@@ -26,7 +31,6 @@ process_entry:
 	and		s3, s2, 0x1
 	beq		s3, zero, 1f
 	and		s4, s2, ~0x1	/* store destination addr in s4 */
-	move		a0, s4
 	b		process_entry
 
 1:
@@ -60,10 +64,92 @@ copy_word:
 	b		process_entry
 
 done:
+#ifdef CONFIG_SMP
+	/* kexec_flag reset is signal to other CPUs what kernel
+ 	   was moved to it's location. Note - we need relocated address
+ 	   of kexec_flag.  */
+
+ 	bal		1f
+ 1: 	move		t1,ra;
+ 	PTR_LA		t2,1b
+ 	PTR_LA		t0,kexec_flag
+ 	PTR_SUB		t0,t0,t2;
+ 	PTR_ADD		t0,t1,t0;
+ 	LONG_S		zero,(t0)
+#endif
+
+	sync
 	/* jump to kexec_start_address */
 	j		s1
 	END(relocate_new_kernel)
 
+#ifdef CONFIG_SMP
+/*
+ * Other CPUs should wait until code is relocated and
+ * then start at entry (?) point.
+ */
+LEAF(kexec_smp_wait)
+	PTR_L		a0, s_arg0
+	PTR_L		a1, s_arg1
+	PTR_L		a2, s_arg2
+	PTR_L		a3, s_arg3
+	PTR_L		s1, kexec_start_address
+
+	/* Non-relocated address works for args and kexec_start_address ( old
+	 * kernel is not overwritten). But we need relocated address of
+	 * kexec_flag.
+	 */
+
+	bal		1f
+1:	move		t1,ra;
+	PTR_LA		t2,1b
+	PTR_LA		t0,kexec_flag
+	PTR_SUB		t0,t0,t2;
+	PTR_ADD		t0,t1,t0;
+
+1:	LONG_L		s0, (t0)
+	bne		s0, zero,1b
+
+	sync
+	j		s1
+	END(kexec_smp_wait)
+#endif
+
+#ifdef __mips64
+       /* all PTR's must be aligned to 8 byte in 64-bit mode */
+       .align  3
+#endif
+
+/* All parameters to new kernel are passed in registers a0-a3.
+ * kexec_args[0..3] are uses to prepare register values.
+ */
+
+kexec_args:
+	EXPORT(kexec_args)
+arg0:	PTR		0x0
+arg1:	PTR		0x0
+arg2:	PTR		0x0
+arg3:	PTR		0x0
+	.size	kexec_args,PTRSIZE*4
+
+#ifdef CONFIG_SMP
+/*
+ * Secondary CPUs may have different kernel parameters in
+ * their registers a0-a3. secondary_kexec_args[0..3] are used
+ * to prepare register values.
+ */
+secondary_kexec_args:
+	EXPORT(secondary_kexec_args)
+s_arg0:	PTR		0x0
+s_arg1:	PTR		0x0
+s_arg2:	PTR		0x0
+s_arg3:	PTR		0x0
+	.size	secondary_kexec_args,PTRSIZE*4
+kexec_flag:
+	LONG		0x1
+
+#endif
+
 kexec_start_address:
 	EXPORT(kexec_start_address)
 	PTR		0x0
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f9513f9..d706bd9 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -21,6 +21,7 @@
 #include <linux/console.h>
 #include <linux/pfn.h>
 #include <linux/debugfs.h>
+#include <linux/kexec.h>
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -487,10 +488,61 @@ static void __init arch_mem_init(char **cmdline_p)
 	}
 
 	bootmem_init();
+#ifdef CONFIG_KEXEC
+	if (crashk_res.start != crashk_res.end)
+		reserve_bootmem(crashk_res.start,
+			crashk_res.end - crashk_res.start + 1,
+			BOOTMEM_DEFAULT);
+#endif
 	sparse_init();
 	paging_init();
 }
 
+#ifdef CONFIG_KEXEC
+static inline unsigned long long get_total_mem(void)
+{
+	unsigned long long total;
+
+	total = max_pfn - min_low_pfn;
+	return total << PAGE_SHIFT;
+}
+
+static void __init mips_parse_crashkernel(void)
+{
+	unsigned long long total_mem;
+	unsigned long long crash_size, crash_base;
+	int ret;
+
+	total_mem = get_total_mem();
+	ret = parse_crashkernel(boot_command_line, total_mem,
+			&crash_size, &crash_base);
+	if (ret != 0 || crash_size <= 0)
+		return;
+
+	crashk_res.start = crash_base;
+	crashk_res.end   = crash_base + crash_size - 1;
+}
+static void __init request_crashkernel(struct resource *res)
+{
+	int ret;
+
+	ret = request_resource(res, &crashk_res);
+	if (!ret)
+		printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
+			"for crashkernel\n",
+			(unsigned long)((crashk_res.end -
+				crashk_res.start + 1) >> 20),
+			(unsigned long)(crashk_res.start  >> 20));
+}
+#else
+static void __init mips_parse_crashkernel(void)
+{
+}
+static void __init request_crashkernel(struct resource *res)
+{
+}
+#endif
+
 static void __init resource_init(void)
 {
 	int i;
@@ -506,6 +558,8 @@ static void __init resource_init(void)
 	/*
 	 * Request address space for all standard RAM.
 	 */
+	mips_parse_crashkernel();
+
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		struct resource *res;
 		unsigned long start, end;
@@ -541,6 +595,7 @@ static void __init resource_init(void)
 		 */
 		request_resource(res, &code_resource);
 		request_resource(res, &data_resource);
+		request_crashkernel(res);
 	}
 }
 
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 6cdca19..e2f4d53 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -402,3 +402,21 @@ void flush_tlb_one(unsigned long vaddr)
 
 EXPORT_SYMBOL(flush_tlb_page);
 EXPORT_SYMBOL(flush_tlb_one);
+
+#if defined(CONFIG_KEXEC)
+void (*dump_ipi_function_ptr)(void *) = NULL;
+void dump_send_ipi(void (*dump_ipi_callback)(void *))
+{
+	int i;
+	int cpu = smp_processor_id();
+
+	dump_ipi_function_ptr = dump_ipi_callback;
+	smp_mb();
+	for_each_online_cpu(i)
+		if (i != cpu)
+			core_send_ipi(i, SMP_DUMP);
+
+}
+EXPORT_SYMBOL(dump_send_ipi);
+#endif
+


Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
