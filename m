Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Oct 2011 15:49:25 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:3557 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491049Ab1JWNoP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Oct 2011 15:44:15 +0200
X-TM-IMSS-Message-ID: <b96879840004e565@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id b96879840004e565 ; Sun, 23 Oct 2011 06:44:06 -0700
Date:   Sun, 23 Oct 2011 19:12:25 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 10/12] MIPS: Netlogic: Merge some of XLR/XLP wakup code
Message-ID: <20111023134218.GA28227@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 23 Oct 2011 13:40:23.0643 (UTC) FILETIME=[50A4DAB0:01CC9189]
X-archive-position: 31282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16589

Create a common NMI and reset handler in smpboot.S and use this for
both XLR and XLP.  In the earlier code, the woken up CPUs would
busy wait until released, switch this to wakeup by NMI.

The initial wakeup code or XLR and XLP are differ since they are
started from different bootloaders (XLP from u-boot and XLR from
netlogic bootloader). But in both platforms the woken up CPUs wait
and are released by sending an NMI.

Add support for starting XLR and XLP in 1/2/4 threads per core.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/netlogic/common.h      |   26 +++-
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h |    7 +-
 arch/mips/include/asm/netlogic/xlr/xlr.h     |    2 +
 arch/mips/netlogic/common/Makefile           |    2 +-
 arch/mips/netlogic/common/smp.c              |   75 +++++++-
 arch/mips/netlogic/common/smpboot.S          |  272 ++++++++++++++++++++++++++
 arch/mips/netlogic/xlp/Makefile              |    2 +-
 arch/mips/netlogic/xlp/setup.c               |    4 +
 arch/mips/netlogic/xlp/smpboot.S             |  217 --------------------
 arch/mips/netlogic/xlp/wakeup.c              |   93 +++-------
 arch/mips/netlogic/xlr/Makefile              |    2 +-
 arch/mips/netlogic/xlr/setup.c               |    7 +-
 arch/mips/netlogic/xlr/smpboot.S             |  100 ----------
 arch/mips/netlogic/xlr/wakeup.c              |   17 +-
 14 files changed, 415 insertions(+), 411 deletions(-)
 create mode 100644 arch/mips/netlogic/common/smpboot.S
 delete mode 100644 arch/mips/netlogic/xlp/smpboot.S
 delete mode 100644 arch/mips/netlogic/xlr/smpboot.S

diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index e5bdf8c..fdd2f44 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -38,19 +38,39 @@
 /*
  * Common SMP definitions
  */
+#define	RESET_VEC_PHYS		0x1fc00000
+#define	RESET_DATA_PHYS		(RESET_VEC_PHYS + (1<<10))
+#define	BOOT_THREAD_MODE	0
+#define	BOOT_NMI_LOCK		4
+#define	BOOT_NMI_HANDLER	8
+
+#ifndef __ASSEMBLY__
 struct irq_desc;
 extern struct plat_smp_ops nlm_smp_ops;
 extern char nlm_reset_entry[], nlm_reset_entry_end[];
 void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc);
 void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc);
 void nlm_smp_irq_init(void);
-void prom_pre_boot_secondary_cpus(void);
+void nlm_boot_secondary_cpus(void);
 int nlm_wakeup_secondary_cpus(u32 wakeup_mask);
-void nlm_boot_smp_nmi(void);
+void nlm_rmiboot_preboot(void);
+
+static inline void
+nlm_set_nmi_handler(void *handler)
+{
+	char *reset_data;
+
+	reset_data = (char *)CKSEG1ADDR(RESET_DATA_PHYS);
+	*(int64_t *)(reset_data + BOOT_NMI_HANDLER) = (long)handler;
+}
 
 /*
  * Misc.
  */
+unsigned int nlm_get_cpu_frequency(void);
+
 extern unsigned long nlm_common_ebase;
-unsigned int	 nlm_get_cpu_frequency(void);
+extern int nlm_threads_per_core;
+extern uint32_t nlm_cpumask, nlm_coremask;
+#endif
 #endif /* _NETLOGIC_COMMON_H_ */
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index aae23f1..1540588 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -35,17 +35,14 @@
 #ifndef _NLM_HAL_XLP_H
 #define _NLM_HAL_XLP_H
 
-#define	RESET_VEC_PHYS		0x1fc00000
-#define	RESET_DATA_PHYS		(RESET_VEC_PHYS + (1<<10))
-#define	BOOT_THREAD_MODE	0
-
 #define PIC_UART_0_IRQ           17
 #define PIC_UART_1_IRQ           18
 
 #ifndef __ASSEMBLY__
 
 /* SMP support functions */
-void nlm_boot_core0_siblings(void);
+void xlp_boot_core0_siblings(void);
+void xlp_wakeup_secondary_cpus(void);
 
 void xlp_mmu_init(void);
 void nlm_hal_init(void);
diff --git a/arch/mips/include/asm/netlogic/xlr/xlr.h b/arch/mips/include/asm/netlogic/xlr/xlr.h
index f4d3f7c..ff4a17b 100644
--- a/arch/mips/include/asm/netlogic/xlr/xlr.h
+++ b/arch/mips/include/asm/netlogic/xlr/xlr.h
@@ -40,6 +40,8 @@ struct uart_port;
 unsigned int nlm_xlr_uart_in(struct uart_port *, int);
 void nlm_xlr_uart_out(struct uart_port *, int, int);
 
+/* SMP helpers */
+void xlr_wakeup_secondary_cpus(void);
 
 /* XLS B silicon "Rook" */
 static inline unsigned int nlm_chip_is_xls_b(void)
diff --git a/arch/mips/netlogic/common/Makefile b/arch/mips/netlogic/common/Makefile
index d421578..291372a 100644
--- a/arch/mips/netlogic/common/Makefile
+++ b/arch/mips/netlogic/common/Makefile
@@ -1,3 +1,3 @@
 obj-y				+= irq.o time.o
-obj-$(CONFIG_SMP)		+= smp.o
+obj-$(CONFIG_SMP)		+= smp.o smpboot.o
 obj-$(CONFIG_EARLY_PRINTK)	+= earlycons.o
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index ff368c6..4657fe8 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -47,10 +47,12 @@
 
 #if defined(CONFIG_CPU_XLP)
 #include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
 #include <asm/netlogic/xlp-hal/pic.h>
 #elif defined(CONFIG_CPU_XLR)
 #include <asm/netlogic/xlr/iomap.h>
 #include <asm/netlogic/xlr/pic.h>
+#include <asm/netlogic/xlr/xlr.h>
 #else
 #error "Unknown CPU"
 #endif
@@ -125,10 +127,10 @@ void nlm_cpus_done(void)
  * Boot all other cpus in the system, initialize them, and bring them into
  * the boot function
  */
-int nlm_cpu_unblock[NR_CPUS];
 int nlm_cpu_ready[NR_CPUS];
 unsigned long nlm_next_gp;
 unsigned long nlm_next_sp;
+
 cpumask_t phys_cpu_present_map;
 
 void nlm_boot_secondary(int logical_cpu, struct task_struct *idle)
@@ -142,7 +144,7 @@ void nlm_boot_secondary(int logical_cpu, struct task_struct *idle)
 
 	/* barrier */
 	__sync();
-	nlm_cpu_unblock[cpu] = 1;
+	nlm_pic_send_ipi(nlm_pic_base, cpu, 1, 1);
 }
 
 void __init nlm_smp_setup(void)
@@ -174,12 +176,81 @@ void __init nlm_smp_setup(void)
 		(unsigned long)cpu_possible_map.bits[0]);
 
 	pr_info("Detected %i Slave CPU(s)\n", num_cpus);
+	nlm_set_nmi_handler(nlm_boot_secondary_cpus);
 }
 
 void nlm_prepare_cpus(unsigned int max_cpus)
 {
 }
 
+static int nlm_parse_cpumask(u32 cpu_mask)
+{
+	uint32_t core0_thr_mask, core_thr_mask;
+	int threadmode, i;
+
+	core0_thr_mask = cpu_mask & 0xf;
+	switch (core0_thr_mask) {
+	case 1:
+		nlm_threads_per_core = 1;
+		threadmode = 0;
+		break;
+	case 3:
+		nlm_threads_per_core = 2;
+		threadmode = 2;
+		break;
+	case 0xf:
+		nlm_threads_per_core = 4;
+		threadmode = 3;
+		break;
+	default:
+		goto unsupp;
+	}
+
+	/* Verify other cores CPU masks */
+	nlm_coremask = 1;
+	nlm_cpumask = core0_thr_mask;
+	for (i = 1; i < 8; i++) {
+		core_thr_mask = (cpu_mask >> (i * 4)) & 0xf;
+		if (core_thr_mask) {
+			if (core_thr_mask != core0_thr_mask)
+				goto unsupp;
+			nlm_coremask |= 1 << i;
+			nlm_cpumask |= core0_thr_mask << (4 * i);
+		}
+	}
+	return threadmode;
+
+unsupp:
+	panic("Unsupported CPU mask %x\n", cpu_mask);
+	return 0;
+}
+
+int __cpuinit nlm_wakeup_secondary_cpus(u32 wakeup_mask)
+{
+	unsigned long reset_vec;
+	char *reset_data;
+	int threadmode;
+
+	/* Update reset entry point with CPU init code */
+	reset_vec = CKSEG1ADDR(RESET_VEC_PHYS);
+	memcpy((void *)reset_vec, (void *)nlm_reset_entry,
+			(nlm_reset_entry_end - nlm_reset_entry));
+
+	/* verify the mask and setup core config variables */
+	threadmode = nlm_parse_cpumask(wakeup_mask);
+
+	/* Setup CPU init parameters */
+	reset_data = (char *)CKSEG1ADDR(RESET_DATA_PHYS);
+	*(int *)(reset_data + BOOT_THREAD_MODE) = threadmode;
+
+#ifdef CONFIG_CPU_XLP
+	xlp_wakeup_secondary_cpus();
+#else
+	xlr_wakeup_secondary_cpus();
+#endif
+	return 0;
+}
+
 struct plat_smp_ops nlm_smp_ops = {
 	.send_ipi_single	= nlm_send_ipi_single,
 	.send_ipi_mask		= nlm_send_ipi_mask,
diff --git a/arch/mips/netlogic/common/smpboot.S b/arch/mips/netlogic/common/smpboot.S
new file mode 100644
index 0000000..c138b1a
--- /dev/null
+++ b/arch/mips/netlogic/common/smpboot.S
@@ -0,0 +1,272 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
+ * license below:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/init.h>
+
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/regdef.h>
+#include <asm/mipsregs.h>
+#include <asm/stackframe.h>
+#include <asm/asmmacro.h>
+#include <asm/addrspace.h>
+
+#include <asm/netlogic/common.h>
+
+#include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/sys.h>
+#include <asm/netlogic/xlp-hal/cpucontrol.h>
+
+#define	CP0_EBASE	$15
+#define SYS_CPU_COHERENT_BASE(node)	CKSEG1ADDR(XLP_DEFAULT_IO_BASE) + \
+			XLP_IO_SYS_OFFSET(node) + XLP_IO_PCI_HDRSZ + \
+			SYS_CPU_NONCOHERENT_MODE * 4
+
+.macro __config_lsu
+	li      t0, LSU_DEFEATURE
+	mfcr    t1, t0
+
+	lui     t2, 0x4080  /* Enable Unaligned Access, L2HPE */
+	or      t1, t1, t2
+	li	t2, ~0xe    /* S1RCM */
+	and	t1, t1, t2
+	mtcr    t1, t0
+
+	li      t0, SCHED_DEFEATURE
+	lui     t1, 0x0100  /* Experimental: Disable BRU accepting ALU ops */
+	mtcr    t1, t0
+.endm
+
+/*
+ * The cores can come start when they are woken up. This is also the NMI
+ * entry, so check that first.
+ *
+ * The data corresponding to reset is stored at RESET_DATA_PHYS location,
+ * this will have the thread mask (used when core is woken up) and the
+ * current NMI handler in case we reached here for an NMI.
+ *
+ * When a core or thread is newly woken up, it loops in a 'wait'. When
+ * the CPU really needs waking up, we send an NMI to it, with the NMI
+ * handler set to prom_boot_secondary_cpus
+ */
+
+	.set	noreorder
+	.set	noat
+	.set	arch=xlr	/* for mfcr/mtcr, XLR is sufficient */
+
+FEXPORT(nlm_reset_entry)
+	dmtc0	k0, $22, 6
+	dmtc0	k1, $22, 7
+	mfc0    k0, CP0_STATUS
+	li      k1, 0x80000
+	and     k1, k0, k1
+	beqz    k1, 1f         /* go to real reset entry */
+	nop
+	li	k1, CKSEG1ADDR(RESET_DATA_PHYS)   /* NMI */
+	ld	k0, BOOT_NMI_HANDLER(k1)
+	jr	k0
+	nop
+
+1:	/* Entry point on core wakeup */
+	mfc0	t0, CP0_EBASE, 1
+	mfc0	t1, CP0_EBASE, 1
+	srl	t1, 5
+	andi	t1, 0x3			/* t1 <- node */
+	li	t2, 0x40000
+	mul	t3, t2, t1		/* t3 = node * 0x40000 */
+	srl	t0, t0, 2
+	and	t0, t0, 0x7		/* t0 <- core */
+	li	t1, 0x1
+	sll	t0, t1, t0
+	nor	t0, t0, zero		/* t0 <- ~(1 << core) */
+	li	t2, SYS_CPU_COHERENT_BASE(0)
+	add	t2, t2, t3		/* t2 <- SYS offset for node */
+	lw	t1, 0(t2)
+	and     t1, t1, t0
+	sw      t1, 0(t2)
+
+	/* read back to ensure complete */
+	lw      t1, 0(t2)
+	sync
+
+	/* Configure LSU on Non-0 Cores. */
+	__config_lsu
+
+/*
+ * Wake up sibling threads from the initial thread in
+ * a core.
+ */
+EXPORT(nlm_boot_siblings)
+	li	t0, CKSEG1ADDR(RESET_DATA_PHYS)
+	lw	t1, BOOT_THREAD_MODE(t0)	/* t1 <- thread mode */
+	li	t0, ((CPU_BLOCKID_MAP << 8) | MAP_THREADMODE)
+	mfcr	t2, t0
+	or	t2, t2, t1
+	mtcr	t2, t0
+
+	/*
+	 * The new hardware thread starts at the next instruction
+	 * For all the cases other than core 0 thread 0, we will
+         * jump to the secondary wait function.
+         */
+	mfc0	v0, CP0_EBASE, 1
+	andi	v0, 0x7f		/* v0 <- node/core */
+
+#if 1
+	/* A0 errata - Write MMU_SETUP after changing thread mode register. */
+	andi	v1, v0, 0x3		/* v1 <- thread id */
+	bnez	v1, 2f
+	nop
+
+        li	t0, MMU_SETUP
+        li	t1, 0
+        mtcr	t1, t0
+	ehb
+#endif
+
+2:	beqz	v0, 4f
+	nop
+
+	/* setup status reg */
+	mfc0	t1, CP0_STATUS
+	li	t0, ST0_BEV
+	or	t1, t0
+	xor	t1, t0
+#ifdef CONFIG_64BIT
+	ori	t1, ST0_KX
+#endif
+	mtc0	t1, CP0_STATUS
+	/* mark CPU ready */
+	PTR_LA	t1, nlm_cpu_ready
+	sll	v1, v0, 2
+	PTR_ADDU t1, v1
+	li	t2, 1
+	sw	t2, 0(t1)
+	/* Wait until NMI hits */
+3:	wait
+	j	3b
+	nop
+
+	/*
+	 * For the boot CPU, we have to restore registers and
+	 * return
+	 */
+4:	dmfc0	t0, $4, 2       /* restore SP from UserLocal */
+	li	t1, 0xfadebeef
+	dmtc0	t1, $4, 2       /* restore SP from UserLocal */
+	PTR_SUBU sp, t0, PT_SIZE
+	RESTORE_ALL
+	jr   ra
+	nop
+EXPORT(nlm_reset_entry_end)
+
+FEXPORT(xlp_boot_core0_siblings)	/* "Master" cpu starts from here */
+	__config_lsu
+	dmtc0   sp, $4, 2		/* SP saved in UserLocal */
+	SAVE_ALL
+	sync
+	/* find the location to which nlm_boot_siblings was relocated */
+	li	t0, CKSEG1ADDR(RESET_VEC_PHYS)
+	dla	t1, nlm_reset_entry
+	dla	t2, nlm_boot_siblings
+	dsubu	t2, t1
+	daddu	t2, t0
+	/* call it */
+	jr	t2
+	nop
+	/* not reached */
+
+	__CPUINIT
+NESTED(nlm_boot_secondary_cpus, 16, sp)
+	PTR_LA	t1, nlm_next_sp
+	PTR_L	sp, 0(t1)
+	PTR_LA	t1, nlm_next_gp
+	PTR_L	gp, 0(t1)
+
+	/* a0 has the processor id */
+	PTR_LA	t0, nlm_early_init_secondary
+	jalr	t0
+	nop
+
+	PTR_LA	t0, smp_bootstrap
+	jr	t0
+	nop
+END(nlm_boot_secondary_cpus)
+	__FINIT
+
+/*
+ * In case of RMIboot bootloader which is used on XLR boards, the CPUs
+ * be already woken up and waiting in bootloader code.
+ * This will get them out of the bootloader code and into linux. Needed
+ *  because the bootloader area will be taken and initialized by linux.
+ */
+	__CPUINIT
+NESTED(nlm_rmiboot_preboot, 16, sp)
+	mfc0	t0, $15, 1	# read ebase
+	andi	t0, 0x1f	# t0 has the processor_id()
+	andi	t2, t0, 0x3	# thread no
+	sll	t0, 2		# offset in cpu array
+
+	PTR_LA	t1, nlm_cpu_ready # mark CPU ready
+	PTR_ADDU t1, t0
+	li	t3, 1
+	sw	t3, 0(t1)
+
+	bnez	t2, 1f		# skip thread programming
+	nop			# for non zero hw threads
+
+	/*
+	 * MMU setup only for first thread in core
+	 */
+	li	t0, 0x400
+	mfcr	t1, t0
+	li	t2, 6 		# XLR thread mode mask
+	nor	t3, t2, zero
+	and	t2, t1, t2	# t2 - current thread mode
+	li	v0, CKSEG1ADDR(RESET_DATA_PHYS)
+	lw	v1, BOOT_THREAD_MODE(v0) # v1 - new thread mode
+	sll	v1, 1
+	beq	v1, t2, 1f 	# same as request value
+	nop			# nothing to do */
+
+	and	t2, t1, t3	# mask out old thread mode
+	or	t1, t2, v1	# put in new value
+	mtcr	t1, t0		# update core control
+
+1:	wait
+	j	1b
+	nop
+END(nlm_rmiboot_preboot)
+	__FINIT
diff --git a/arch/mips/netlogic/xlp/Makefile b/arch/mips/netlogic/xlp/Makefile
index 1940d1c..b93ed83 100644
--- a/arch/mips/netlogic/xlp/Makefile
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -1,2 +1,2 @@
 obj-y				+= setup.o platform.o nlm_hal.o
-obj-$(CONFIG_SMP)		+= smpboot.o wakeup.o
+obj-$(CONFIG_SMP)		+= wakeup.o
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index f40a0e7..acb677a 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -51,6 +51,10 @@
 
 unsigned long nlm_common_ebase = 0x0;
 
+/* default to uniprocessor */
+uint32_t nlm_coremask = 1, nlm_cpumask  = 1;
+int  nlm_threads_per_core = 1;
+
 static void nlm_linux_exit(void)
 {
 	nlm_write_sys_reg(nlm_sys_base, SYS_CHIP_RESET, 1);
diff --git a/arch/mips/netlogic/xlp/smpboot.S b/arch/mips/netlogic/xlp/smpboot.S
deleted file mode 100644
index 7dd3232..0000000
--- a/arch/mips/netlogic/xlp/smpboot.S
+++ /dev/null
@@ -1,217 +0,0 @@
-/*
- * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
- * reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the NetLogic
- * license below:
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
- * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
- * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
- * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#include <linux/init.h>
-
-#include <asm/asm.h>
-#include <asm/asm-offsets.h>
-#include <asm/regdef.h>
-#include <asm/mipsregs.h>
-#include <asm/stackframe.h>
-#include <asm/asmmacro.h>
-#include <asm/addrspace.h>
-
-#include <asm/netlogic/xlp-hal/iomap.h>
-#include <asm/netlogic/xlp-hal/xlp.h>
-#include <asm/netlogic/xlp-hal/sys.h>
-#include <asm/netlogic/xlp-hal/cpucontrol.h>
-
-#define	CP0_EBASE	$15
-#define SYS_CPU_COHERENT_BASE(node)	CKSEG1ADDR(XLP_DEFAULT_IO_BASE) + \
-			XLP_IO_SYS_OFFSET(node) + XLP_IO_PCI_HDRSZ + \
-			SYS_CPU_NONCOHERENT_MODE * 4
-
-.macro __config_lsu
-	li      t0, LSU_DEFEATURE
-	mfcr    t1, t0
-
-	lui     t2, 0x4080  /* Enable Unaligned Access, L2HPE */
-	or      t1, t1, t2
-	li	t2, ~0xe    /* S1RCM */
-	and	t1, t1, t2
-	mtcr    t1, t0
-
-	li      t0, SCHED_DEFEATURE
-	lui     t1, 0x0100  /* Experimental: Disable BRU accepting ALU ops */
-	mtcr    t1, t0
-.endm
-
-	.set	noreorder
-	.set	arch=xlr	/* for mfcr/mtcr, XLR is sufficient */
-
-	__CPUINIT
-EXPORT(nlm_reset_entry)
-	mfc0	t0, CP0_EBASE, 1
-	mfc0	t1, CP0_EBASE, 1
-	srl	t1, 5
-	andi	t1, 0x3			/* t1 <- node */
-	li	t2, 0x40000
-	mul	t3, t2, t1		/* t3 = node * 0x40000 */
-	srl	t0, t0, 2
-	and	t0, t0, 0x7		/* t0 <- core */
-	li	t1, 0x1
-	sll	t0, t1, t0
-	nor	t0, t0, zero		/* t0 <- ~(1 << core) */
-	li	t2, SYS_CPU_COHERENT_BASE(0)
-	add	t2, t2, t3		/* t2 <- SYS offset for node */
-	lw	t1, 0(t2)
-	and     t1, t1, t0
-	sw      t1, 0(t2)
-
-	/* read back to ensure complete */
-	lw      t1, 0(t2)
-	sync
-
-	/* Configure LSU on Non-0 Cores. */
-	__config_lsu
-
-/*
- * Wake up sibling threads from the initial thread in
- * a core.
- */
-EXPORT(nlm_boot_siblings)
-	li	t0, CKSEG1ADDR(RESET_DATA_PHYS)
-	lw	t1, BOOT_THREAD_MODE(t0)	/* t1 <- thread mode */
-	li	t0, ((CPU_BLOCKID_MAP << 8) | MAP_THREADMODE)
-	mfcr	t2, t0
-	or	t2, t2, t1
-	mtcr	t2, t0
-
-	/*
-	 * The new hardware thread starts at the next instruction
-	 * For all the cases other than core 0 thread 0, we will
-         * jump to the secondary wait function.
-         */
-	mfc0	v0, CP0_EBASE, 1
-	andi	v0, 0x7f		/* v0 <- node/core */
-
-#if 1
-	/* A0 errata - Write MMU_SETUP after changing thread mode register. */
-	andi	v1, v0, 0x3		/* v1 <- thread id */
-	bnez	v1, 2f
-	nop
-
-        li	t0, MMU_SETUP
-        li	t1, 0
-        mtcr	t1, t0
-	ehb
-#endif
-
-2:	beqz	v0, 3f
-	nop
-
-	/* setup status reg */
-	mfc0	t1, CP0_STATUS
-	li	t0, ST0_BEV
-	or	t1, t0
-	xor	t1, t0
-#ifdef CONFIG_64BIT
-	ori	t1, ST0_KX
-#endif
-	mtc0	t1, CP0_STATUS
-
-	/* SETUP TLBs for a mapped kernel here */
-	PTR_LA	t0, prom_pre_boot_secondary_cpus
-	jalr	t0
-	nop
-
-	/*
-	 * For the boot CPU, we have to restore registers and
-	 * return
-	 */
-3:	dmfc0	t0, $4, 2       /* restore SP from UserLocal */
-	li	t1, 0xfadebeef
-	dmtc0	t1, $4, 2       /* restore SP from UserLocal */
-	PTR_SUBU sp, t0, PT_SIZE
-	RESTORE_ALL
-	jr   ra
-	nop
-EXPORT(nlm_reset_entry_end)
-
-EXPORT(nlm_boot_core0_siblings)	/* "Master" (n0c0t0) cpu starts from here */
-	__config_lsu
-	dmtc0   sp, $4, 2		/* SP saved in UserLocal */
-	SAVE_ALL
-	sync
-	/* find the location to which nlm_boot_siblings was relocated */
-	li	t0, CKSEG1ADDR(RESET_VEC_PHYS)
-	dla	t1, nlm_reset_entry
-	dla	t2, nlm_boot_siblings
-	dsubu	t2, t1
-	daddu	t2, t0
-	/* call it */
-	jr	t2
-	nop
-	__FINIT
-
-	__CPUINIT
-NESTED(prom_pre_boot_secondary_cpus, 16, sp)
-	.set	mips64
-	mfc0	a0, CP0_EBASE, 1	/* read ebase */
-	andi	a0, 0x3ff		/* a0 has the processor_id() */
-	sll	t0, a0, 2		/* offset in cpu array */
-
-	PTR_LA	t1, nlm_cpu_ready	/* mark CPU ready */
-	PTR_ADDU t1, t0
-	li	t2, 1
-	sw	t2, 0(t1)
-
-	PTR_LA	t1, nlm_cpu_unblock
-	PTR_ADDU t1, t0
-1:	lw	t2, 0(t1)		/* wait till unblocked */
-	bnez	t2, 2f
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	j	1b
-	nop
-
-2:	PTR_LA	t1, nlm_next_sp
-	PTR_L	sp, 0(t1)
-	PTR_LA	t1, nlm_next_gp
-	PTR_L	gp, 0(t1)
-
-	/* a0 has the processor id */
-	PTR_LA	t0, nlm_early_init_secondary
-	jalr	t0
-	nop
-
-	PTR_LA	t0, smp_bootstrap
-	jr	t0
-	nop
-END(prom_pre_boot_secondary_cpus)
-	__FINIT
diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index e081a77..44d923f 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -51,18 +51,20 @@
 #include <asm/netlogic/xlp-hal/xlp.h>
 #include <asm/netlogic/xlp-hal/sys.h>
 
-unsigned long secondary_entry;
-uint32_t nlm_coremask;
-unsigned int nlm_threads_per_core;
-unsigned int nlm_threadmode;
-
-static void nlm_enable_secondary_cores(unsigned int cores_bitmap)
+static void xlp_enable_secondary_cores(void)
 {
-	uint32_t core, value, coremask;
+	uint32_t core, value, coremask, syscoremask;
+	int count;
+
+	/* read cores in reset from SYS block */
+	syscoremask = nlm_read_sys_reg(nlm_sys_base, SYS_CPU_RESET);
+
+	/* update user specified */
+	nlm_coremask = nlm_coremask & (syscoremask | 1);
 
 	for (core = 1; core < 8; core++) {
 		coremask = 1 << core;
-		if ((cores_bitmap & coremask) == 0)
+		if ((nlm_coremask & coremask) == 0)
 			continue;
 
 		/* Enable CPU clock */
@@ -76,74 +78,25 @@ static void nlm_enable_secondary_cores(unsigned int cores_bitmap)
 		nlm_write_sys_reg(nlm_sys_base, SYS_CPU_RESET, value);
 
 		/* Poll for CPU to mark itself coherent */
+		count = 100000;
 		do {
 			value = nlm_read_sys_reg(nlm_sys_base,
 			    SYS_CPU_NONCOHERENT_MODE);
-		} while ((value & coremask) != 0);
-	}
-}
-
-
-static void nlm_parse_cpumask(u32 cpu_mask)
-{
-	uint32_t core0_thr_mask, core_thr_mask;
-	int i;
+		} while ((value & coremask) != 0 && count-- > 0);
 
-	core0_thr_mask = cpu_mask & 0xf;
-	switch (core0_thr_mask) {
-	case 1:
-		nlm_threads_per_core = 1;
-		nlm_threadmode = 0;
-		break;
-	case 3:
-		nlm_threads_per_core = 2;
-		nlm_threadmode = 2;
-		break;
-	case 0xf:
-		nlm_threads_per_core = 4;
-		nlm_threadmode = 3;
-		break;
-	default:
-		goto unsupp;
+		if (count == 0)
+			pr_err("Failed to enable core %d\n", core);
 	}
-
-	/* Verify other cores CPU masks */
-	nlm_coremask = 1;
-	for (i = 1; i < 8; i++) {
-		core_thr_mask = (cpu_mask >> (i * 4)) & 0xf;
-		if (core_thr_mask) {
-			if (core_thr_mask != core0_thr_mask)
-				goto unsupp;
-			nlm_coremask |= 1 << i;
-		}
-	}
-	return;
-
-unsupp:
-	panic("Unsupported CPU mask %x\n", cpu_mask);
 }
 
-int __cpuinit nlm_wakeup_secondary_cpus(u32 wakeup_mask)
+void xlp_wakeup_secondary_cpus(void)
 {
-	unsigned long reset_vec;
-	unsigned int *reset_data;
-
-	/* Update reset entry point with CPU init code */
-	reset_vec = CKSEG1ADDR(RESET_VEC_PHYS);
-	memcpy((void *)reset_vec, (void *)nlm_reset_entry,
-			(nlm_reset_entry_end - nlm_reset_entry));
-
-	/* verify the mask and setup core config variables */
-	nlm_parse_cpumask(wakeup_mask);
-
-	/* Setup CPU init parameters */
-	reset_data = (unsigned int *)CKSEG1ADDR(RESET_DATA_PHYS);
-	reset_data[BOOT_THREAD_MODE] = nlm_threadmode;
-
-	/* first wakeup core 0 siblings */
-	nlm_boot_core0_siblings();
-
-	/* enable the reset of the cores */
-	nlm_enable_secondary_cores(nlm_coremask);
-	return 0;
+	/*
+	 * In case of u-boot, the secondaries are in reset
+	 * first wakeup core 0 threads
+	 */
+	xlp_boot_core0_siblings();
+
+	/* now get other cores out of reset */
+	xlp_enable_secondary_cores();
 }
diff --git a/arch/mips/netlogic/xlr/Makefile b/arch/mips/netlogic/xlr/Makefile
index df245c6..f01e4d7 100644
--- a/arch/mips/netlogic/xlr/Makefile
+++ b/arch/mips/netlogic/xlr/Makefile
@@ -1,2 +1,2 @@
 obj-y				+= setup.o platform.o
-obj-$(CONFIG_SMP)		+= smpboot.o wakeup.o
+obj-$(CONFIG_SMP)		+= wakeup.o
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index 20c280a..c9d066d 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -52,9 +52,14 @@
 
 uint64_t nlm_io_base = DEFAULT_NETLOGIC_IO_BASE;
 uint64_t nlm_pic_base;
-unsigned long nlm_common_ebase = 0x0;
 struct psb_info nlm_prom_info;
 
+unsigned long nlm_common_ebase = 0x0;
+
+/* default to uniprocessor */
+uint32_t nlm_coremask = 1, nlm_cpumask  = 1;
+int  nlm_threads_per_core = 1;
+
 static void __init nlm_early_serial_setup(void)
 {
 	struct uart_port s;
diff --git a/arch/mips/netlogic/xlr/smpboot.S b/arch/mips/netlogic/xlr/smpboot.S
deleted file mode 100644
index 7f1f6e6..0000000
--- a/arch/mips/netlogic/xlr/smpboot.S
+++ /dev/null
@@ -1,100 +0,0 @@
-/*
- * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
- * reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the NetLogic
- * license below:
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
- * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
- * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
- * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#include <linux/init.h>
-
-#include <asm/asm.h>
-#include <asm/asm-offsets.h>
-#include <asm/regdef.h>
-#include <asm/mipsregs.h>
-
-/*
- * Early code for secondary CPUs. This will get them out of the bootloader
- * code and into linux. Needed because the bootloader area will be taken
- * and initialized by linux.
- */
-	__CPUINIT
-NESTED(prom_pre_boot_secondary_cpus, 16, sp)
-	.set	mips64
-	mfc0	t0, $15, 1	# read ebase
-	andi	t0, 0x1f	# t0 has the processor_id()
-	sll	t0, 2		# offset in cpu array
-
-	PTR_LA	t1, nlm_cpu_ready # mark CPU ready
-	PTR_ADDU t1, t0
-	li	t2, 1
-	sw	t2, 0(t1)
-
-	PTR_LA	t1, nlm_cpu_unblock
-	PTR_ADDU t1, t0
-1:	lw	t2, 0(t1)	# wait till unblocked
-	beqz	t2, 1b
-	nop
-
-	PTR_LA	t1, nlm_next_sp
-	PTR_L	sp, 0(t1)
-	PTR_LA	t1, nlm_next_gp
-	PTR_L	gp, 0(t1)
-
-	PTR_LA	t0, nlm_early_init_secondary
-	jalr	t0
-	nop
-
-	PTR_LA	t0, smp_bootstrap
-	jr	t0
-	nop
-END(prom_pre_boot_secondary_cpus)
-
-/*
- * NMI code, used for CPU wakeup, copied to reset entry
- */
-EXPORT(nlm_reset_entry)
-	.set push
-	.set noat
-	.set mips64
-	.set noreorder
-
-	/* Clear the  NMI and BEV bits */
-	MFC0	k0, CP0_STATUS
-	li 	k1, 0xffb7ffff
-	and	k0, k0, k1
-	MTC0	k0, CP0_STATUS
-
-	PTR_LA  k1, secondary_entry_point
-	PTR_L	k0, 0(k1)
-	jr	k0
-	nop
-	.set pop
-EXPORT(nlm_reset_entry_end)
-	__FINIT
diff --git a/arch/mips/netlogic/xlr/wakeup.c b/arch/mips/netlogic/xlr/wakeup.c
index 69143bb..db5d987 100644
--- a/arch/mips/netlogic/xlr/wakeup.c
+++ b/arch/mips/netlogic/xlr/wakeup.c
@@ -48,21 +48,18 @@
 #include <asm/netlogic/xlr/iomap.h>
 #include <asm/netlogic/xlr/pic.h>
 
-unsigned long secondary_entry_point;
-
-int __cpuinit nlm_wakeup_secondary_cpus(u32 wakeup_mask)
+int __cpuinit xlr_wakeup_secondary_cpus(void)
 {
 	unsigned int i, boot_cpu;
-	void *reset_vec;
 
-	secondary_entry_point = (unsigned long)prom_pre_boot_secondary_cpus;
-	reset_vec = (void *)CKSEG1ADDR(0x1fc00000);
-	memcpy(reset_vec, (void *)nlm_reset_entry,
-			(nlm_reset_entry_end - nlm_reset_entry));
+	/*
+	 *  In case of RMI boot, hit with NMI to get the cores
+	 *  from bootloader to linux code.
+	 */
 	boot_cpu = hard_smp_processor_id();
-
+	nlm_set_nmi_handler(nlm_rmiboot_preboot);
 	for (i = 0; i < NR_CPUS; i++) {
-		if (i == boot_cpu || (wakeup_mask & (1u << i)) == 0)
+		if (i == boot_cpu || (nlm_cpumask & (1u << i)) == 0)
 			continue;
 		nlm_pic_send_ipi(nlm_pic_base, i, 1, 1); /* send NMI */
 	}
-- 
1.7.4.1
