Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 12:59:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:47554 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822092AbaDHK7Wvo4ZE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 12:59:22 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D09F91D613729
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 11:59:12 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Tue, 8 Apr
 2014 11:59:14 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 8 Apr 2014 11:59:14 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 8 Apr 2014 11:59:14 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/2] MIPS: Remove SMTC Support
Date:   Tue, 8 Apr 2014 11:59:09 +0100
Message-ID: <1396954750-24762-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396954750-24762-1-git-send-email-markos.chandras@imgtec.com>
References: <1396954750-24762-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

It is not maintained anymore

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/Kconfig                                  |   49 +-
 arch/mips/Kconfig.debug                            |    9 -
 arch/mips/configs/maltasmtc_defconfig              |  196 ---
 arch/mips/include/asm/asmmacro.h                   |   22 +-
 arch/mips/include/asm/cpu-info.h                   |   11 +-
 arch/mips/include/asm/fixmap.h                     |    4 -
 arch/mips/include/asm/irq.h                        |   96 --
 arch/mips/include/asm/irqflags.h                   |   31 +-
 .../include/asm/mach-malta/kernel-entry-init.h     |   30 -
 .../include/asm/mach-sead3/kernel-entry-init.h     |   31 -
 arch/mips/include/asm/mips_mt.h                    |    2 +-
 arch/mips/include/asm/mipsregs.h                   |  132 --
 arch/mips/include/asm/mmu_context.h                |  108 +-
 arch/mips/include/asm/module.h                     |    8 +-
 arch/mips/include/asm/ptrace.h                     |    3 -
 arch/mips/include/asm/r4kcache.h                   |    2 +-
 arch/mips/include/asm/smtc.h                       |   78 -
 arch/mips/include/asm/smtc_ipi.h                   |  129 --
 arch/mips/include/asm/smtc_proc.h                  |   23 -
 arch/mips/include/asm/stackframe.h                 |  196 +--
 arch/mips/include/asm/thread_info.h                |   11 +-
 arch/mips/include/asm/time.h                       |    5 +-
 arch/mips/kernel/Makefile                          |    2 -
 arch/mips/kernel/asm-offsets.c                     |    3 -
 arch/mips/kernel/cevt-r4k.c                        |   15 -
 arch/mips/kernel/cevt-smtc.c                       |  324 -----
 arch/mips/kernel/cpu-probe.c                       |    2 +-
 arch/mips/kernel/entry.S                           |   38 -
 arch/mips/kernel/genex.S                           |   55 +-
 arch/mips/kernel/head.S                            |   58 +-
 arch/mips/kernel/i8259.c                           |    4 -
 arch/mips/kernel/idle.c                            |   10 -
 arch/mips/kernel/irq-msc01.c                       |    5 -
 arch/mips/kernel/irq.c                             |   18 -
 arch/mips/kernel/mips-mt-fpaff.c                   |    2 +-
 arch/mips/kernel/mips-mt.c                         |   18 +-
 arch/mips/kernel/proc.c                            |    1 -
 arch/mips/kernel/process.c                         |    7 -
 arch/mips/kernel/r4k_switch.S                      |   33 -
 arch/mips/kernel/rtlx-mt.c                         |    1 -
 arch/mips/kernel/smp-cmp.c                         |    9 +-
 arch/mips/kernel/smp.c                             |   13 -
 arch/mips/kernel/smtc-asm.S                        |  133 --
 arch/mips/kernel/smtc-proc.c                       |  102 --
 arch/mips/kernel/smtc.c                            | 1528 --------------------
 arch/mips/kernel/sync-r4k.c                        |   17 -
 arch/mips/kernel/time.c                            |    1 -
 arch/mips/kernel/traps.c                           |   72 +-
 arch/mips/kernel/vpe-mt.c                          |   14 +-
 arch/mips/lantiq/irq.c                             |    4 +-
 arch/mips/lib/mips-atomic.c                        |   46 +-
 arch/mips/mm/c-r4k.c                               |    4 +-
 arch/mips/mm/init.c                                |   54 +-
 arch/mips/mm/tlb-r4k.c                             |   19 -
 arch/mips/mti-malta/Makefile                       |    3 -
 arch/mips/mti-malta/malta-init.c                   |    5 -
 arch/mips/mti-malta/malta-int.c                    |   19 -
 arch/mips/mti-malta/malta-setup.c                  |    4 -
 arch/mips/mti-malta/malta-smtc.c                   |  162 ---
 arch/mips/pmcs-msp71xx/Makefile                    |    1 -
 arch/mips/pmcs-msp71xx/msp_irq.c                   |   12 +-
 arch/mips/pmcs-msp71xx/msp_irq_cic.c               |   10 +-
 arch/mips/pmcs-msp71xx/msp_irq_per.c               |    6 +-
 arch/mips/pmcs-msp71xx/msp_setup.c                 |    8 -
 arch/mips/pmcs-msp71xx/msp_smtc.c                  |  104 --
 65 files changed, 52 insertions(+), 4070 deletions(-)
 delete mode 100644 arch/mips/configs/maltasmtc_defconfig
 delete mode 100644 arch/mips/include/asm/smtc.h
 delete mode 100644 arch/mips/include/asm/smtc_ipi.h
 delete mode 100644 arch/mips/include/asm/smtc_proc.h
 delete mode 100644 arch/mips/kernel/cevt-smtc.c
 delete mode 100644 arch/mips/kernel/smtc-asm.S
 delete mode 100644 arch/mips/kernel/smtc-proc.c
 delete mode 100644 arch/mips/kernel/smtc.c
 delete mode 100644 arch/mips/mti-malta/malta-smtc.c
 delete mode 100644 arch/mips/pmcs-msp71xx/msp_smtc.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 16d5ab1..918a80f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1842,7 +1842,7 @@ config FORCE_MAX_ZONEORDER
 
 config CEVT_GIC
 	bool "Use GIC global counter for clock events"
-	depends on IRQ_GIC && !(MIPS_SEAD3 || MIPS_MT_SMTC)
+	depends on IRQ_GIC && !MIPS_SEAD3
 	help
 	  Use the GIC global counter for the clock events. The R4K clock
 	  event driver is always present, so if the platform ends up not
@@ -1926,24 +1926,6 @@ config MIPS_MT_SMP
 	  Intel Hyperthreading feature. For further information go to
 	  <http://www.imgtec.com/mips/mips-multithreading.asp>.
 
-config MIPS_MT_SMTC
-	bool "Use all TCs on all VPEs for SMP (DEPRECATED)"
-	depends on CPU_MIPS32_R2
-	depends on SYS_SUPPORTS_MULTITHREADING
-	depends on !MIPS_CPS
-	select CPU_MIPSR2_IRQ_VI
-	select CPU_MIPSR2_IRQ_EI
-	select MIPS_MT
-	select SMP
-	select SMP_UP
-	select SYS_SUPPORTS_SMP
-	select NR_CPUS_DEFAULT_8
-	help
-	  This is a kernel model which is known as SMTC. This is
-	  supported on cores with the MT ASE and presents all TCs
-	  available on all VPEs to support SMP. For further
-	  information see <http://www.linux-mips.org/wiki/34K#SMTC>.
-
 endchoice
 
 config MIPS_MT
@@ -1967,7 +1949,7 @@ config SYS_SUPPORTS_MULTITHREADING
 config MIPS_MT_FPAFF
 	bool "Dynamic FPU affinity for FP-intensive threads"
 	default y
-	depends on MIPS_MT_SMP || MIPS_MT_SMTC
+	depends on MIPS_MT_SMP
 
 config MIPS_VPE_LOADER
 	bool "VPE loader support."
@@ -1989,29 +1971,6 @@ config MIPS_VPE_LOADER_MT
 	default "y"
 	depends on MIPS_VPE_LOADER && !MIPS_CMP
 
-config MIPS_MT_SMTC_IM_BACKSTOP
-	bool "Use per-TC register bits as backstop for inhibited IM bits"
-	depends on MIPS_MT_SMTC
-	default n
-	help
-	  To support multiple TC microthreads acting as "CPUs" within
-	  a VPE, VPE-wide interrupt mask bits must be specially manipulated
-	  during interrupt handling. To support legacy drivers and interrupt
-	  controller management code, SMTC has a "backstop" to track and
-	  if necessary restore the interrupt mask. This has some performance
-	  impact on interrupt service overhead.
-
-config MIPS_MT_SMTC_IRQAFF
-	bool "Support IRQ affinity API"
-	depends on MIPS_MT_SMTC
-	default n
-	help
-	  Enables SMP IRQ affinity API (/proc/irq/*/smp_affinity, etc.)
-	  for SMTC Linux kernel. Requires platform support, of which
-	  an example can be found in the MIPS kernel i8259 and Malta
-	  platform code.  Adds some overhead to interrupt dispatch, and
-	  should be used only if you know what you are doing.
-
 config MIPS_VPE_LOADER_TOM
 	bool "Load VPE program into memory hidden from linux"
 	depends on MIPS_VPE_LOADER
@@ -2039,7 +1998,7 @@ config MIPS_VPE_APSP_API_MT
 
 config MIPS_CMP
 	bool "MIPS CMP framework support (DEPRECATED)"
-	depends on SYS_SUPPORTS_MIPS_CMP && !MIPS_MT_SMTC
+	depends on SYS_SUPPORTS_MIPS_CMP
 	select MIPS_GIC_IPI
 	select SYNC_R4K
 	select WEAK_ORDERING
@@ -2239,7 +2198,7 @@ config NODES_SHIFT
 
 config HW_PERF_EVENTS
 	bool "Enable hardware performance counter support for perf events"
-	depends on PERF_EVENTS && !MIPS_MT_SMTC && OPROFILE=n && (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1 || CPU_CAVIUM_OCTEON || CPU_XLP)
+	depends on PERF_EVENTS && OPROFILE=n && (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1 || CPU_CAVIUM_OCTEON || CPU_XLP)
 	default y
 	help
 	  Enable hardware performance counter support for perf events. If
diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 25de292..3a2b775 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -79,15 +79,6 @@ config CMDLINE_OVERRIDE
 
 	  Normally, you will choose 'N' here.
 
-config SMTC_IDLE_HOOK_DEBUG
-	bool "Enable additional debug checks before going into CPU idle loop"
-	depends on DEBUG_KERNEL && MIPS_MT_SMTC
-	help
-	  This option enables Enable additional debug checks before going into
-	  CPU idle loop.  For details on these checks, see
-	  arch/mips/kernel/smtc.c.  This debugging option result in significant
-	  overhead so should be disabled in production kernels.
-
 config SB1XXX_CORELIS
 	bool "Corelis Debugger"
 	depends on SIBYTE_SB1xxx_SOC
diff --git a/arch/mips/configs/maltasmtc_defconfig b/arch/mips/configs/maltasmtc_defconfig
deleted file mode 100644
index eb31644..0000000
diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index b464b8b..47a0ed9 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -17,26 +17,8 @@
 #ifdef CONFIG_64BIT
 #include <asm/asmmacro-64.h>
 #endif
-#ifdef CONFIG_MIPS_MT_SMTC
-#include <asm/mipsmtregs.h>
-#endif
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	.macro	local_irq_enable reg=t0
-	mfc0	\reg, CP0_TCSTATUS
-	ori	\reg, \reg, TCSTATUS_IXMT
-	xori	\reg, \reg, TCSTATUS_IXMT
-	mtc0	\reg, CP0_TCSTATUS
-	_ehb
-	.endm
-
-	.macro	local_irq_disable reg=t0
-	mfc0	\reg, CP0_TCSTATUS
-	ori	\reg, \reg, TCSTATUS_IXMT
-	mtc0	\reg, CP0_TCSTATUS
-	_ehb
-	.endm
-#elif defined(CONFIG_CPU_MIPSR2)
+#if defined(CONFIG_CPU_MIPSR2)
 	.macro	local_irq_enable reg=t0
 	ei
 	irq_enable_hazard
@@ -71,7 +53,7 @@
 	sw      \reg, TI_PRE_COUNT($28)
 #endif
 	.endm
-#endif /* CONFIG_MIPS_MT_SMTC */
+#endif
 
 	.macro	fpu_save_16even thread tmp=t0
 	cfc1	\tmp, fcr31
diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index dc2135b..2f6812b 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -65,18 +65,9 @@ struct cpuinfo_mips {
 #ifdef CONFIG_64BIT
 	int			vmbits; /* Virtual memory size in bits */
 #endif
-#if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_MIPS_MT_SMTC)
-	/*
-	 * In the MIPS MT "SMTC" model, each TC is considered
-	 * to be a "CPU" for the purposes of scheduling, but
-	 * exception resources, ASID spaces, etc, are common
-	 * to all TCs within the same VPE.
-	 */
+#ifdef CONFIG_MIPS_MT_SMP
 	int			vpe_id;	 /* Virtual Processor number */
 #endif
-#ifdef CONFIG_MIPS_MT_SMTC
-	int			tc_id;	 /* Thread Context number */
-#endif
 	void			*data;	/* Additional data */
 	unsigned int		watch_reg_count;   /* Number that exist */
 	unsigned int		watch_reg_use_cnt; /* Usable by ptrace */
diff --git a/arch/mips/include/asm/fixmap.h b/arch/mips/include/asm/fixmap.h
index 8c012af..6842ffa 100644
--- a/arch/mips/include/asm/fixmap.h
+++ b/arch/mips/include/asm/fixmap.h
@@ -48,11 +48,7 @@
 enum fixed_addresses {
 #define FIX_N_COLOURS 8
 	FIX_CMAP_BEGIN,
-#ifdef CONFIG_MIPS_MT_SMTC
-	FIX_CMAP_END = FIX_CMAP_BEGIN + (FIX_N_COLOURS * NR_CPUS * 2),
-#else
 	FIX_CMAP_END = FIX_CMAP_BEGIN + (FIX_N_COLOURS * 2),
-#endif
 #ifdef CONFIG_HIGHMEM
 	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_BEGIN = FIX_CMAP_END + 1,
diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index 7bc2cdb..ae1f7b2 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -26,104 +26,8 @@ static inline int irq_canonicalize(int irq)
 #define irq_canonicalize(irq) (irq)	/* Sane hardware, sane code ... */
 #endif
 
-#ifdef CONFIG_MIPS_MT_SMTC
-
-struct irqaction;
-
-extern unsigned long irq_hwmask[];
-extern int setup_irq_smtc(unsigned int irq, struct irqaction * new,
-			  unsigned long hwmask);
-
-static inline void smtc_im_ack_irq(unsigned int irq)
-{
-	if (irq_hwmask[irq] & ST0_IM)
-		set_c0_status(irq_hwmask[irq] & ST0_IM);
-}
-
-#else
-
-static inline void smtc_im_ack_irq(unsigned int irq)
-{
-}
-
-#endif /* CONFIG_MIPS_MT_SMTC */
-
-#ifdef CONFIG_MIPS_MT_SMTC_IRQAFF
-#include <linux/cpumask.h>
-
-extern int plat_set_irq_affinity(struct irq_data *d,
-				 const struct cpumask *affinity, bool force);
-extern void smtc_forward_irq(struct irq_data *d);
-
-/*
- * IRQ affinity hook invoked at the beginning of interrupt dispatch
- * if option is enabled.
- *
- * Up through Linux 2.6.22 (at least) cpumask operations are very
- * inefficient on MIPS.	 Initial prototypes of SMTC IRQ affinity
- * used a "fast path" per-IRQ-descriptor cache of affinity information
- * to reduce latency.  As there is a project afoot to optimize the
- * cpumask implementations, this version is optimistically assuming
- * that cpumask.h macro overhead is reasonable during interrupt dispatch.
- */
-static inline int handle_on_other_cpu(unsigned int irq)
-{
-	struct irq_data *d = irq_get_irq_data(irq);
-
-	if (cpumask_test_cpu(smp_processor_id(), d->affinity))
-		return 0;
-	smtc_forward_irq(d);
-	return 1;
-}
-
-#else /* Not doing SMTC affinity */
-
-static inline int handle_on_other_cpu(unsigned int irq) { return 0; }
-
-#endif /* CONFIG_MIPS_MT_SMTC_IRQAFF */
-
-#ifdef CONFIG_MIPS_MT_SMTC_IM_BACKSTOP
-
-static inline void smtc_im_backstop(unsigned int irq)
-{
-	if (irq_hwmask[irq] & 0x0000ff00)
-		write_c0_tccontext(read_c0_tccontext() &
-				   ~(irq_hwmask[irq] & 0x0000ff00));
-}
-
-/*
- * Clear interrupt mask handling "backstop" if irq_hwmask
- * entry so indicates. This implies that the ack() or end()
- * functions will take over re-enabling the low-level mask.
- * Otherwise it will be done on return from exception.
- */
-static inline int smtc_handle_on_other_cpu(unsigned int irq)
-{
-	int ret = handle_on_other_cpu(irq);
-
-	if (!ret)
-		smtc_im_backstop(irq);
-	return ret;
-}
-
-#else
-
-static inline void smtc_im_backstop(unsigned int irq) { }
-static inline int smtc_handle_on_other_cpu(unsigned int irq)
-{
-	return handle_on_other_cpu(irq);
-}
-
-#endif
-
 extern void do_IRQ(unsigned int irq);
 
-#ifdef CONFIG_MIPS_MT_SMTC_IRQAFF
-
-extern void do_IRQ_no_affinity(unsigned int irq);
-
-#endif /* CONFIG_MIPS_MT_SMTC_IRQAFF */
-
 extern void arch_init_irq(void);
 extern void spurious_interrupt(void);
 
diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
index 45c0095..7a8305c4 100644
--- a/arch/mips/include/asm/irqflags.h
+++ b/arch/mips/include/asm/irqflags.h
@@ -17,7 +17,7 @@
 #include <linux/stringify.h>
 #include <asm/hazards.h>
 
-#if defined(CONFIG_CPU_MIPSR2) && !defined(CONFIG_MIPS_MT_SMTC)
+#ifdef CONFIG_CPU_MIPSR2
 
 static inline void arch_local_irq_disable(void)
 {
@@ -118,30 +118,16 @@ void arch_local_irq_disable(void);
 unsigned long arch_local_irq_save(void);
 void arch_local_irq_restore(unsigned long flags);
 void __arch_local_irq_restore(unsigned long flags);
-#endif /* if defined(CONFIG_CPU_MIPSR2) && !defined(CONFIG_MIPS_MT_SMTC) */
+#endif /* ifdef CONFIG_CPU_MIPSR2 */
 
 
-extern void smtc_ipi_replay(void);
-
 static inline void arch_local_irq_enable(void)
 {
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * SMTC kernel needs to do a software replay of queued
-	 * IPIs, at the cost of call overhead on each local_irq_enable()
-	 */
-	smtc_ipi_replay();
-#endif
 	__asm__ __volatile__(
 	"	.set	push						\n"
 	"	.set	reorder						\n"
 	"	.set	noat						\n"
-#ifdef CONFIG_MIPS_MT_SMTC
-	"	mfc0	$1, $2, 1	# SMTC - clear TCStatus.IXMT	\n"
-	"	ori	$1, 0x400					\n"
-	"	xori	$1, 0x400					\n"
-	"	mtc0	$1, $2, 1					\n"
-#elif defined(CONFIG_CPU_MIPSR2)
+#ifdef CONFIG_CPU_MIPSR2
 	"	ei							\n"
 #else
 	"	mfc0	$1,$12						\n"
@@ -163,11 +149,7 @@ static inline unsigned long arch_local_save_flags(void)
 	asm __volatile__(
 	"	.set	push						\n"
 	"	.set	reorder						\n"
-#ifdef CONFIG_MIPS_MT_SMTC
-	"	mfc0	%[flags], $2, 1					\n"
-#else
 	"	mfc0	%[flags], $12					\n"
-#endif
 	"	.set	pop						\n"
 	: [flags] "=r" (flags));
 
@@ -177,14 +159,7 @@ static inline unsigned long arch_local_save_flags(void)
 
 static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * SMTC model uses TCStatus.IXMT to disable interrupts for a thread/CPU
-	 */
-	return flags & 0x400;
-#else
 	return !(flags & 1);
-#endif
 }
 
 #endif /* #ifndef __ASSEMBLY__ */
diff --git a/arch/mips/include/asm/mach-malta/kernel-entry-init.h b/arch/mips/include/asm/mach-malta/kernel-entry-init.h
index 7c5e17a..77eeda7 100644
--- a/arch/mips/include/asm/mach-malta/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-malta/kernel-entry-init.h
@@ -80,36 +80,6 @@
 	.endm
 
 	.macro	kernel_entry_setup
-#ifdef CONFIG_MIPS_MT_SMTC
-	mfc0	t0, CP0_CONFIG
-	bgez	t0, 9f
-	mfc0	t0, CP0_CONFIG, 1
-	bgez	t0, 9f
-	mfc0	t0, CP0_CONFIG, 2
-	bgez	t0, 9f
-	mfc0	t0, CP0_CONFIG, 3
-	and	t0, 1<<2
-	bnez	t0, 0f
-9:
-	/* Assume we came from YAMON... */
-	PTR_LA	v0, 0x9fc00534	/* YAMON print */
-	lw	v0, (v0)
-	move	a0, zero
-	PTR_LA	a1, nonmt_processor
-	jal	v0
-
-	PTR_LA	v0, 0x9fc00520	/* YAMON exit */
-	lw	v0, (v0)
-	li	a0, 1
-	jal	v0
-
-1:	b	1b
-
-	__INITDATA
-nonmt_processor:
-	.asciz	"SMTC kernel requires the MT ASE to run\n"
-	__FINIT
-#endif
 
 #ifdef CONFIG_EVA
 	sync
diff --git a/arch/mips/include/asm/mach-sead3/kernel-entry-init.h b/arch/mips/include/asm/mach-sead3/kernel-entry-init.h
index 3dfbd8e..6cccd4d 100644
--- a/arch/mips/include/asm/mach-sead3/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-sead3/kernel-entry-init.h
@@ -10,37 +10,6 @@
 #define __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H
 
 	.macro	kernel_entry_setup
-#ifdef CONFIG_MIPS_MT_SMTC
-	mfc0	t0, CP0_CONFIG
-	bgez	t0, 9f
-	mfc0	t0, CP0_CONFIG, 1
-	bgez	t0, 9f
-	mfc0	t0, CP0_CONFIG, 2
-	bgez	t0, 9f
-	mfc0	t0, CP0_CONFIG, 3
-	and	t0, 1<<2
-	bnez	t0, 0f
-9 :
-	/* Assume we came from YAMON... */
-	PTR_LA	v0, 0x9fc00534	/* YAMON print */
-	lw	v0, (v0)
-	move	a0, zero
-	PTR_LA	a1, nonmt_processor
-	jal	v0
-
-	PTR_LA	v0, 0x9fc00520	/* YAMON exit */
-	lw	v0, (v0)
-	li	a0, 1
-	jal	v0
-
-1 :	b	1b
-
-	__INITDATA
-nonmt_processor :
-	.asciz	"SMTC kernel requires the MT ASE to run\n"
-	__FINIT
-0 :
-#endif
 	.endm
 
 /*
diff --git a/arch/mips/include/asm/mips_mt.h b/arch/mips/include/asm/mips_mt.h
index a3df0c3..667c0b0 100644
--- a/arch/mips/include/asm/mips_mt.h
+++ b/arch/mips/include/asm/mips_mt.h
@@ -1,6 +1,6 @@
 /*
  * Definitions and decalrations for MIPS MT support
- * that are common between SMTC, VSMP, and/or AP/SP
+ * that are common between VSMP, and/or AP/SP
  * kernel models.
  */
 #ifndef __ASM_MIPS_MT_H
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 3e025b5..daa7cd6 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1007,19 +1007,7 @@ do {									\
 #define write_c0_compare3(val)	__write_32bit_c0_register($11, 7, val)
 
 #define read_c0_status()	__read_32bit_c0_register($12, 0)
-#ifdef CONFIG_MIPS_MT_SMTC
-#define write_c0_status(val)						\
-do {									\
-	__write_32bit_c0_register($12, 0, val);				\
-	__ehb();							\
-} while (0)
-#else
-/*
- * Legacy non-SMTC code, which may be hazardous
- * but which might not support EHB
- */
 #define write_c0_status(val)	__write_32bit_c0_register($12, 0, val)
-#endif /* CONFIG_MIPS_MT_SMTC */
 
 #define read_c0_cause()		__read_32bit_c0_register($13, 0)
 #define write_c0_cause(val)	__write_32bit_c0_register($13, 0, val)
@@ -1743,11 +1731,6 @@ static inline void tlb_write_random(void)
 /*
  * Manipulate bits in a c0 register.
  */
-#ifndef CONFIG_MIPS_MT_SMTC
-/*
- * SMTC Linux requires shutting-down microthread scheduling
- * during CP0 register read-modify-write sequences.
- */
 #define __BUILD_SET_C0(name)					\
 static inline unsigned int					\
 set_c0_##name(unsigned int set)					\
@@ -1786,121 +1769,6 @@ change_c0_##name(unsigned int change, unsigned int val)		\
 	return res;						\
 }
 
-#else /* SMTC versions that manage MT scheduling */
-
-#include <linux/irqflags.h>
-
-/*
- * This is a duplicate of dmt() in mipsmtregs.h to avoid problems with
- * header file recursion.
- */
-static inline unsigned int __dmt(void)
-{
-	int res;
-
-	__asm__ __volatile__(
-	"	.set	push						\n"
-	"	.set	mips32r2					\n"
-	"	.set	noat						\n"
-	"	.word	0x41610BC1			# dmt $1	\n"
-	"	ehb							\n"
-	"	move	%0, $1						\n"
-	"	.set	pop						\n"
-	: "=r" (res));
-
-	instruction_hazard();
-
-	return res;
-}
-
-#define __VPECONTROL_TE_SHIFT	15
-#define __VPECONTROL_TE		(1UL << __VPECONTROL_TE_SHIFT)
-
-#define __EMT_ENABLE		__VPECONTROL_TE
-
-static inline void __emt(unsigned int previous)
-{
-	if ((previous & __EMT_ENABLE))
-		__asm__ __volatile__(
-		"	.set	mips32r2				\n"
-		"	.word	0x41600be1		# emt		\n"
-		"	ehb						\n"
-		"	.set	mips0					\n");
-}
-
-static inline void __ehb(void)
-{
-	__asm__ __volatile__(
-	"	.set	mips32r2					\n"
-	"	ehb							\n"		"	.set	mips0						\n");
-}
-
-/*
- * Note that local_irq_save/restore affect TC-specific IXMT state,
- * not Status.IE as in non-SMTC kernel.
- */
-
-#define __BUILD_SET_C0(name)					\
-static inline unsigned int					\
-set_c0_##name(unsigned int set)					\
-{								\
-	unsigned int res;					\
-	unsigned int new;					\
-	unsigned int omt;					\
-	unsigned long flags;					\
-								\
-	local_irq_save(flags);					\
-	omt = __dmt();						\
-	res = read_c0_##name();					\
-	new = res | set;					\
-	write_c0_##name(new);					\
-	__emt(omt);						\
-	local_irq_restore(flags);				\
-								\
-	return res;						\
-}								\
-								\
-static inline unsigned int					\
-clear_c0_##name(unsigned int clear)				\
-{								\
-	unsigned int res;					\
-	unsigned int new;					\
-	unsigned int omt;					\
-	unsigned long flags;					\
-								\
-	local_irq_save(flags);					\
-	omt = __dmt();						\
-	res = read_c0_##name();					\
-	new = res & ~clear;					\
-	write_c0_##name(new);					\
-	__emt(omt);						\
-	local_irq_restore(flags);				\
-								\
-	return res;						\
-}								\
-								\
-static inline unsigned int					\
-change_c0_##name(unsigned int change, unsigned int newbits)	\
-{								\
-	unsigned int res;					\
-	unsigned int new;					\
-	unsigned int omt;					\
-	unsigned long flags;					\
-								\
-	local_irq_save(flags);					\
-								\
-	omt = __dmt();						\
-	res = read_c0_##name();					\
-	new = res & ~change;					\
-	new |= (newbits & change);				\
-	write_c0_##name(new);					\
-	__emt(omt);						\
-	local_irq_restore(flags);				\
-								\
-	return res;						\
-}
-#endif
-
 __BUILD_SET_C0(status)
 __BUILD_SET_C0(cause)
 __BUILD_SET_C0(config)
diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index e277bba..bd17f85 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -18,10 +18,6 @@
 #include <asm/cacheflush.h>
 #include <asm/hazards.h>
 #include <asm/tlbflush.h>
-#ifdef CONFIG_MIPS_MT_SMTC
-#include <asm/mipsmtregs.h>
-#include <asm/smtc.h>
-#endif /* SMTC */
 #include <asm-generic/mm_hooks.h>
 
 #define TLBMISS_HANDLER_SETUP_PGD(pgd)					\
@@ -63,13 +59,6 @@ extern unsigned long pgd_current[];
 #define ASID_INC	0x10
 #define ASID_MASK	0xff0
 
-#elif defined(CONFIG_MIPS_MT_SMTC)
-
-#define ASID_INC	0x1
-extern unsigned long smtc_asid_mask;
-#define ASID_MASK	(smtc_asid_mask)
-#define HW_ASID_MASK	0xff
-/* End SMTC/34K debug hack */
 #else /* FIXME: not correct for R6000 */
 
 #define ASID_INC	0x1
@@ -92,7 +81,6 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 #define ASID_VERSION_MASK  ((unsigned long)~(ASID_MASK|(ASID_MASK-1)))
 #define ASID_FIRST_VERSION ((unsigned long)(~ASID_VERSION_MASK) + 1)
 
-#ifndef CONFIG_MIPS_MT_SMTC
 /* Normal, classic MIPS get_new_mmu_context */
 static inline void
 get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
@@ -115,12 +103,6 @@ get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
 }
 
-#else /* CONFIG_MIPS_MT_SMTC */
-
-#define get_new_mmu_context(mm, cpu) smtc_get_new_mmu_context((mm), (cpu))
-
-#endif /* CONFIG_MIPS_MT_SMTC */
-
 /*
  * Initialize the context related info for a new mm_struct
  * instance.
@@ -141,46 +123,13 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 {
 	unsigned int cpu = smp_processor_id();
 	unsigned long flags;
-#ifdef CONFIG_MIPS_MT_SMTC
-	unsigned long oldasid;
-	unsigned long mtflags;
-	int mytlb = (smtc_status & SMTC_TLB_SHARED) ? 0 : cpu_data[cpu].vpe_id;
-	local_irq_save(flags);
-	mtflags = dvpe();
-#else /* Not SMTC */
 	local_irq_save(flags);
-#endif /* CONFIG_MIPS_MT_SMTC */
 
 	/* Check if our ASID is of an older version and thus invalid */
 	if ((cpu_context(cpu, next) ^ asid_cache(cpu)) & ASID_VERSION_MASK)
 		get_new_mmu_context(next, cpu);
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * If the EntryHi ASID being replaced happens to be
-	 * the value flagged at ASID recycling time as having
-	 * an extended life, clear the bit showing it being
-	 * in use by this "CPU", and if that's the last bit,
-	 * free up the ASID value for use and flush any old
-	 * instances of it from the TLB.
-	 */
-	oldasid = (read_c0_entryhi() & ASID_MASK);
-	if(smtc_live_asid[mytlb][oldasid]) {
-		smtc_live_asid[mytlb][oldasid] &= ~(0x1 << cpu);
-		if(smtc_live_asid[mytlb][oldasid] == 0)
-			smtc_flush_tlb_asid(oldasid);
-	}
-	/*
-	 * Tread softly on EntryHi, and so long as we support
-	 * having ASID_MASK smaller than the hardware maximum,
-	 * make sure no "soft" bits become "hard"...
-	 */
-	write_c0_entryhi((read_c0_entryhi() & ~HW_ASID_MASK) |
-			 cpu_asid(cpu, next));
-	ehb(); /* Make sure it propagates to TCStatus */
-	evpe(mtflags);
-#else
+
 	write_c0_entryhi(cpu_asid(cpu, next));
-#endif /* CONFIG_MIPS_MT_SMTC */
 	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
 
 	/*
@@ -213,34 +162,12 @@ activate_mm(struct mm_struct *prev, struct mm_struct *next)
 	unsigned long flags;
 	unsigned int cpu = smp_processor_id();
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	unsigned long oldasid;
-	unsigned long mtflags;
-	int mytlb = (smtc_status & SMTC_TLB_SHARED) ? 0 : cpu_data[cpu].vpe_id;
-#endif /* CONFIG_MIPS_MT_SMTC */
-
 	local_irq_save(flags);
 
 	/* Unconditionally get a new ASID.  */
 	get_new_mmu_context(next, cpu);
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	/* See comments for similar code above */
-	mtflags = dvpe();
-	oldasid = read_c0_entryhi() & ASID_MASK;
-	if(smtc_live_asid[mytlb][oldasid]) {
-		smtc_live_asid[mytlb][oldasid] &= ~(0x1 << cpu);
-		if(smtc_live_asid[mytlb][oldasid] == 0)
-			 smtc_flush_tlb_asid(oldasid);
-	}
-	/* See comments for similar code above */
-	write_c0_entryhi((read_c0_entryhi() & ~HW_ASID_MASK) |
-			 cpu_asid(cpu, next));
-	ehb(); /* Make sure it propagates to TCStatus */
-	evpe(mtflags);
-#else
 	write_c0_entryhi(cpu_asid(cpu, next));
-#endif /* CONFIG_MIPS_MT_SMTC */
 	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
 
 	/* mark mmu ownership change */
@@ -258,48 +185,15 @@ static inline void
 drop_mmu_context(struct mm_struct *mm, unsigned cpu)
 {
 	unsigned long flags;
-#ifdef CONFIG_MIPS_MT_SMTC
-	unsigned long oldasid;
-	/* Can't use spinlock because called from TLB flush within DVPE */
-	unsigned int prevvpe;
-	int mytlb = (smtc_status & SMTC_TLB_SHARED) ? 0 : cpu_data[cpu].vpe_id;
-#endif /* CONFIG_MIPS_MT_SMTC */
 
 	local_irq_save(flags);
 
 	if (cpumask_test_cpu(cpu, mm_cpumask(mm)))  {
 		get_new_mmu_context(mm, cpu);
-#ifdef CONFIG_MIPS_MT_SMTC
-		/* See comments for similar code above */
-		prevvpe = dvpe();
-		oldasid = (read_c0_entryhi() & ASID_MASK);
-		if (smtc_live_asid[mytlb][oldasid]) {
-			smtc_live_asid[mytlb][oldasid] &= ~(0x1 << cpu);
-			if(smtc_live_asid[mytlb][oldasid] == 0)
-				smtc_flush_tlb_asid(oldasid);
-		}
-		/* See comments for similar code above */
-		write_c0_entryhi((read_c0_entryhi() & ~HW_ASID_MASK)
-				| cpu_asid(cpu, mm));
-		ehb(); /* Make sure it propagates to TCStatus */
-		evpe(prevvpe);
-#else /* not CONFIG_MIPS_MT_SMTC */
 		write_c0_entryhi(cpu_asid(cpu, mm));
-#endif /* CONFIG_MIPS_MT_SMTC */
 	} else {
 		/* will get a new context next time */
-#ifndef CONFIG_MIPS_MT_SMTC
 		cpu_context(cpu, mm) = 0;
-#else /* SMTC */
-		int i;
-
-		/* SMTC shares the TLB (and ASIDs) across VPEs */
-		for_each_online_cpu(i) {
-		    if((smtc_status & SMTC_TLB_SHARED)
-		    || (cpu_data[i].vpe_id == cpu_data[cpu].vpe_id))
-			cpu_context(i, mm) = 0;
-		}
-#endif /* CONFIG_MIPS_MT_SMTC */
 	}
 	local_irq_restore(flags);
 }
diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index c2edae3..800fe57 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -144,13 +144,7 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_KERNEL_TYPE "64BIT "
 #endif
 
-#ifdef CONFIG_MIPS_MT_SMTC
-#define MODULE_KERNEL_SMTC "MT_SMTC "
-#else
-#define MODULE_KERNEL_SMTC ""
-#endif
-
 #define MODULE_ARCH_VERMAGIC \
-	MODULE_PROC_FAMILY MODULE_KERNEL_TYPE MODULE_KERNEL_SMTC
+	MODULE_PROC_FAMILY MODULE_KERNEL_TYPE
 
 #endif /* _ASM_MODULE_H */
diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index bf1ac8d3..7e6e682 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -39,9 +39,6 @@ struct pt_regs {
 	unsigned long cp0_badvaddr;
 	unsigned long cp0_cause;
 	unsigned long cp0_epc;
-#ifdef CONFIG_MIPS_MT_SMTC
-	unsigned long cp0_tcstatus;
-#endif /* CONFIG_MIPS_MT_SMTC */
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 	unsigned long long mpl[3];	  /* MTM{0,1,2} */
 	unsigned long long mtp[3];	  /* MTP{0,1,2} */
diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index ca64cbe..82e2a27 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -44,7 +44,7 @@
 
 #ifdef CONFIG_MIPS_MT
 /*
- * Temporary hacks for SMTC debug. Optionally force single-threaded
+ * Temporary hacks for MT debug. Optionally force single-threaded
  * execution during I-cache flushes.
  */
 
diff --git a/arch/mips/include/asm/smtc.h b/arch/mips/include/asm/smtc.h
deleted file mode 100644
index e56b439..0000000
diff --git a/arch/mips/include/asm/smtc_ipi.h b/arch/mips/include/asm/smtc_ipi.h
deleted file mode 100644
index 15278db..0000000
diff --git a/arch/mips/include/asm/smtc_proc.h b/arch/mips/include/asm/smtc_proc.h
deleted file mode 100644
index 25da651..0000000
diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index d301e10..b188c79 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -19,22 +19,12 @@
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 
-/*
- * For SMTC kernel, global IE should be left set, and interrupts
- * controlled exclusively via IXMT.
- */
-#ifdef CONFIG_MIPS_MT_SMTC
-#define STATMASK 0x1e
-#elif defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 #define STATMASK 0x3f
 #else
 #define STATMASK 0x1f
 #endif
 
-#ifdef CONFIG_MIPS_MT_SMTC
-#include <asm/mipsmtregs.h>
-#endif /* CONFIG_MIPS_MT_SMTC */
-
 		.macro	SAVE_AT
 		.set	push
 		.set	noat
@@ -186,16 +176,6 @@
 		mfc0	v1, CP0_STATUS
 		LONG_S	$2, PT_R2(sp)
 		LONG_S	v1, PT_STATUS(sp)
-#ifdef CONFIG_MIPS_MT_SMTC
-		/*
-		 * Ideally, these instructions would be shuffled in
-		 * to cover the pipeline delay.
-		 */
-		.set	mips32
-		mfc0	k0, CP0_TCSTATUS
-		.set	mips0
-		LONG_S	k0, PT_TCSTATUS(sp)
-#endif /* CONFIG_MIPS_MT_SMTC */
 		LONG_S	$4, PT_R4(sp)
 		mfc0	v1, CP0_CAUSE
 		LONG_S	$5, PT_R5(sp)
@@ -321,36 +301,6 @@
 		.set	push
 		.set	reorder
 		.set	noat
-#ifdef CONFIG_MIPS_MT_SMTC
-		.set	mips32r2
-		/*
-		 * We need to make sure the read-modify-write
-		 * of Status below isn't perturbed by an interrupt
-		 * or cross-TC access, so we need to do at least a DMT,
-		 * protected by an interrupt-inhibit. But setting IXMT
-		 * also creates a few-cycle window where an IPI could
-		 * be queued and not be detected before potentially
-		 * returning to a WAIT or user-mode loop. It must be
-		 * replayed.
-		 *
-		 * We're in the middle of a context switch, and
-		 * we can't dispatch it directly without trashing
-		 * some registers, so we'll try to detect this unlikely
-		 * case and program a software interrupt in the VPE,
-		 * as would be done for a cross-VPE IPI.  To accommodate
-		 * the handling of that case, we're doing a DVPE instead
-		 * of just a DMT here to protect against other threads.
-		 * This is a lot of cruft to cover a tiny window.
-		 * If you can find a better design, implement it!
-		 *
-		 */
-		mfc0	v0, CP0_TCSTATUS
-		ori	v0, TCSTATUS_IXMT
-		mtc0	v0, CP0_TCSTATUS
-		_ehb
-		DVPE	5				# dvpe a1
-		jal	mips_ihb
-#endif /* CONFIG_MIPS_MT_SMTC */
 		mfc0	a0, CP0_STATUS
 		ori	a0, STATMASK
 		xori	a0, STATMASK
@@ -362,59 +312,6 @@
 		and	v0, v1
 		or	v0, a0
 		mtc0	v0, CP0_STATUS
-#ifdef CONFIG_MIPS_MT_SMTC
-/*
- * Only after EXL/ERL have been restored to status can we
- * restore TCStatus.IXMT.
- */
-		LONG_L	v1, PT_TCSTATUS(sp)
-		_ehb
-		mfc0	a0, CP0_TCSTATUS
-		andi	v1, TCSTATUS_IXMT
-		bnez	v1, 0f
-
-/*
- * We'd like to detect any IPIs queued in the tiny window
- * above and request an software interrupt to service them
- * when we ERET.
- *
- * Computing the offset into the IPIQ array of the executing
- * TC's IPI queue in-line would be tedious.  We use part of
- * the TCContext register to hold 16 bits of offset that we
- * can add in-line to find the queue head.
- */
-		mfc0	v0, CP0_TCCONTEXT
-		la	a2, IPIQ
-		srl	v0, v0, 16
-		addu	a2, a2, v0
-		LONG_L	v0, 0(a2)
-		beqz	v0, 0f
-/*
- * If we have a queue, provoke dispatch within the VPE by setting C_SW1
- */
-		mfc0	v0, CP0_CAUSE
-		ori	v0, v0, C_SW1
-		mtc0	v0, CP0_CAUSE
-0:
-		/*
-		 * This test should really never branch but
-		 * let's be prudent here.  Having atomized
-		 * the shared register modifications, we can
-		 * now EVPE, and must do so before interrupts
-		 * are potentially re-enabled.
-		 */
-		andi	a1, a1, MVPCONTROL_EVP
-		beqz	a1, 1f
-		evpe
-1:
-		/* We know that TCStatua.IXMT should be set from above */
-		xori	a0, a0, TCSTATUS_IXMT
-		or	a0, a0, v1
-		mtc0	a0, CP0_TCSTATUS
-		_ehb
-
-		.set	mips0
-#endif /* CONFIG_MIPS_MT_SMTC */
 		LONG_L	v1, PT_EPC(sp)
 		MTC0	v1, CP0_EPC
 		LONG_L	$31, PT_R31(sp)
@@ -467,33 +364,11 @@
  * Set cp0 enable bit as sign that we're running on the kernel stack
  */
 		.macro	CLI
-#if !defined(CONFIG_MIPS_MT_SMTC)
 		mfc0	t0, CP0_STATUS
 		li	t1, ST0_CU0 | STATMASK
 		or	t0, t1
 		xori	t0, STATMASK
 		mtc0	t0, CP0_STATUS
-#else /* CONFIG_MIPS_MT_SMTC */
-		/*
-		 * For SMTC, we need to set privilege
-		 * and disable interrupts only for the
-		 * current TC, using the TCStatus register.
-		 */
-		mfc0	t0, CP0_TCSTATUS
-		/* Fortunately CU 0 is in the same place in both registers */
-		/* Set TCU0, TMX, TKSU (for later inversion) and IXMT */
-		li	t1, ST0_CU0 | 0x08001c00
-		or	t0, t1
-		/* Clear TKSU, leave IXMT */
-		xori	t0, 0x00001800
-		mtc0	t0, CP0_TCSTATUS
-		_ehb
-		/* We need to leave the global IE bit set, but clear EXL...*/
-		mfc0	t0, CP0_STATUS
-		ori	t0, ST0_EXL | ST0_ERL
-		xori	t0, ST0_EXL | ST0_ERL
-		mtc0	t0, CP0_STATUS
-#endif /* CONFIG_MIPS_MT_SMTC */
 		irq_disable_hazard
 		.endm
 
@@ -502,35 +377,11 @@
  * Set cp0 enable bit as sign that we're running on the kernel stack
  */
 		.macro	STI
-#if !defined(CONFIG_MIPS_MT_SMTC)
 		mfc0	t0, CP0_STATUS
 		li	t1, ST0_CU0 | STATMASK
 		or	t0, t1
 		xori	t0, STATMASK & ~1
 		mtc0	t0, CP0_STATUS
-#else /* CONFIG_MIPS_MT_SMTC */
-		/*
-		 * For SMTC, we need to set privilege
-		 * and enable interrupts only for the
-		 * current TC, using the TCStatus register.
-		 */
-		_ehb
-		mfc0	t0, CP0_TCSTATUS
-		/* Fortunately CU 0 is in the same place in both registers */
-		/* Set TCU0, TKSU (for later inversion) and IXMT */
-		li	t1, ST0_CU0 | 0x08001c00
-		or	t0, t1
-		/* Clear TKSU *and* IXMT */
-		xori	t0, 0x00001c00
-		mtc0	t0, CP0_TCSTATUS
-		_ehb
-		/* We need to leave the global IE bit set, but clear EXL...*/
-		mfc0	t0, CP0_STATUS
-		ori	t0, ST0_EXL
-		xori	t0, ST0_EXL
-		mtc0	t0, CP0_STATUS
-		/* irq_enable_hazard below should expand to EHB for 24K/34K cpus */
-#endif /* CONFIG_MIPS_MT_SMTC */
 		irq_enable_hazard
 		.endm
 
@@ -540,32 +391,6 @@
  * Set cp0 enable bit as sign that we're running on the kernel stack
  */
 		.macro	KMODE
-#ifdef CONFIG_MIPS_MT_SMTC
-		/*
-		 * This gets baroque in SMTC.  We want to
-		 * protect the non-atomic clearing of EXL
-		 * with DMT/EMT, but we don't want to take
-		 * an interrupt while DMT is still in effect.
-		 */
-
-		/* KMODE gets invoked from both reorder and noreorder code */
-		.set	push
-		.set	mips32r2
-		.set	noreorder
-		mfc0	v0, CP0_TCSTATUS
-		andi	v1, v0, TCSTATUS_IXMT
-		ori	v0, TCSTATUS_IXMT
-		mtc0	v0, CP0_TCSTATUS
-		_ehb
-		DMT	2				# dmt	v0
-		/*
-		 * We don't know a priori if ra is "live"
-		 */
-		move	t0, ra
-		jal	mips_ihb
-		nop	/* delay slot */
-		move	ra, t0
-#endif /* CONFIG_MIPS_MT_SMTC */
 		mfc0	t0, CP0_STATUS
 		li	t1, ST0_CU0 | (STATMASK & ~1)
 #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
@@ -576,25 +401,6 @@
 		or	t0, t1
 		xori	t0, STATMASK & ~1
 		mtc0	t0, CP0_STATUS
-#ifdef CONFIG_MIPS_MT_SMTC
-		_ehb
-		andi	v0, v0, VPECONTROL_TE
-		beqz	v0, 2f
-		nop	/* delay slot */
-		emt
-2:
-		mfc0	v0, CP0_TCSTATUS
-		/* Clear IXMT, then OR in previous value */
-		ori	v0, TCSTATUS_IXMT
-		xori	v0, TCSTATUS_IXMT
-		or	v0, v1, v0
-		mtc0	v0, CP0_TCSTATUS
-		/*
-		 * irq_disable_hazard below should expand to EHB
-		 * on 24K/34K CPUS
-		 */
-		.set pop
-#endif /* CONFIG_MIPS_MT_SMTC */
 		irq_disable_hazard
 		.endm
 
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index d2d961d..1f0733f 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -159,11 +159,7 @@ static inline struct thread_info *current_thread_info(void)
  * We stash processor id into a COP0 register to retrieve it fast
  * at kernel exception entry.
  */
-#if defined(CONFIG_MIPS_MT_SMTC)
-#define SMP_CPUID_REG		2, 2	/* TCBIND */
-#define ASM_SMP_CPUID_REG	$2, 2
-#define SMP_CPUID_PTRSHIFT	19
-#elif defined(CONFIG_MIPS_PGD_C0_CONTEXT)
+#if defined(CONFIG_MIPS_PGD_C0_CONTEXT)
 #define SMP_CPUID_REG		20, 0	/* XCONTEXT */
 #define ASM_SMP_CPUID_REG	$20
 #define SMP_CPUID_PTRSHIFT	48
@@ -179,13 +175,8 @@ static inline struct thread_info *current_thread_info(void)
 #define SMP_CPUID_REGSHIFT	(SMP_CPUID_PTRSHIFT + 2)
 #endif
 
-#ifdef CONFIG_MIPS_MT_SMTC
-#define ASM_CPUID_MFC0		mfc0
-#define UASM_i_CPUID_MFC0	uasm_i_mfc0
-#else
 #define ASM_CPUID_MFC0		MFC0
 #define UASM_i_CPUID_MFC0	UASM_i_MFC0
-#endif
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_THREAD_INFO_H */
diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index 24f534a..715cee3 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -52,14 +52,11 @@ extern int (*perf_irq)(void);
  */
 extern unsigned int __weak get_c0_compare_int(void);
 extern int r4k_clockevent_init(void);
-extern int smtc_clockevent_init(void);
 extern int gic_clockevent_init(void);
 
 static inline int mips_clockevent_init(void)
 {
-#ifdef CONFIG_MIPS_MT_SMTC
-	return smtc_clockevent_init();
-#elif defined(CONFIG_CEVT_GIC)
+#ifdef CONFIG_CEVT_GIC
 	return (gic_clockevent_init() | r4k_clockevent_init());
 #elif defined(CONFIG_CEVT_R4K)
 	return r4k_clockevent_init();
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 277dab3..8f8b531 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -17,7 +17,6 @@ endif
 
 obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
 obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
-obj-$(CONFIG_MIPS_MT_SMTC)	+= cevt-smtc.o
 obj-$(CONFIG_CEVT_DS1287)	+= cevt-ds1287.o
 obj-$(CONFIG_CEVT_GIC)		+= cevt-gic.o
 obj-$(CONFIG_CEVT_GT641XX)	+= cevt-gt641xx.o
@@ -50,7 +49,6 @@ obj-$(CONFIG_CPU_BMIPS)		+= smp-bmips.o bmips_vec.o
 
 obj-$(CONFIG_MIPS_MT)		+= mips-mt.o
 obj-$(CONFIG_MIPS_MT_FPAFF)	+= mips-mt-fpaff.o
-obj-$(CONFIG_MIPS_MT_SMTC)	+= smtc.o smtc-asm.o smtc-proc.o
 obj-$(CONFIG_MIPS_MT_SMP)	+= smp-mt.o
 obj-$(CONFIG_MIPS_CMP)		+= smp-cmp.o
 obj-$(CONFIG_MIPS_CPS)		+= smp-cps.o cps-vec.o
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 0ea75c2..08f897e 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -64,9 +64,6 @@ void output_ptreg_defines(void)
 	OFFSET(PT_BVADDR, pt_regs, cp0_badvaddr);
 	OFFSET(PT_STATUS, pt_regs, cp0_status);
 	OFFSET(PT_CAUSE, pt_regs, cp0_cause);
-#ifdef CONFIG_MIPS_MT_SMTC
-	OFFSET(PT_TCSTATUS, pt_regs, cp0_tcstatus);
-#endif /* CONFIG_MIPS_MT_SMTC */
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 	OFFSET(PT_MPL, pt_regs, mpl);
 	OFFSET(PT_MTP, pt_regs, mtp);
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 50d3f5a..7c1f213 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -12,17 +12,10 @@
 #include <linux/smp.h>
 #include <linux/irq.h>
 
-#include <asm/smtc_ipi.h>
 #include <asm/time.h>
 #include <asm/cevt-r4k.h>
 #include <asm/gic.h>
 
-/*
- * The SMTC Kernel for the 34K, 1004K, et. al. replaces several
- * of these routines with SMTC-specific variants.
- */
-
-#ifndef CONFIG_MIPS_MT_SMTC
 static int mips_next_event(unsigned long delta,
 			   struct clock_event_device *evt)
 {
@@ -36,8 +29,6 @@ static int mips_next_event(unsigned long delta,
 	return res;
 }
 
-#endif /* CONFIG_MIPS_MT_SMTC */
-
 void mips_set_clock_mode(enum clock_event_mode mode,
 				struct clock_event_device *evt)
 {
@@ -47,7 +38,6 @@ void mips_set_clock_mode(enum clock_event_mode mode,
 DEFINE_PER_CPU(struct clock_event_device, mips_clockevent_device);
 int cp0_timer_irq_installed;
 
-#ifndef CONFIG_MIPS_MT_SMTC
 irqreturn_t c0_compare_interrupt(int irq, void *dev_id)
 {
 	const int r2 = cpu_has_mips_r2;
@@ -82,8 +72,6 @@ out:
 	return IRQ_HANDLED;
 }
 
-#endif /* Not CONFIG_MIPS_MT_SMTC */
-
 struct irqaction c0_compare_irqaction = {
 	.handler = c0_compare_interrupt,
 	.flags = IRQF_PERCPU | IRQF_TIMER,
@@ -170,7 +158,6 @@ int c0_compare_int_usable(void)
 	return 1;
 }
 
-#ifndef CONFIG_MIPS_MT_SMTC
 int r4k_clockevent_init(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -224,5 +211,3 @@ int r4k_clockevent_init(void)
 
 	return 0;
 }
-
-#endif /* Not CONFIG_MIPS_MT_SMTC */
diff --git a/arch/mips/kernel/cevt-smtc.c b/arch/mips/kernel/cevt-smtc.c
deleted file mode 100644
index b6cf0a6..0000000
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 6e8fb85..00437ae 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -62,7 +62,7 @@ static inline void check_errata(void)
 	case CPU_34K:
 		/*
 		 * Erratum "RPS May Cause Incorrect Instruction Execution"
-		 * This code only handles VPE0, any SMP/SMTC/RTOS code
+		 * This code only handles VPE0, any SMP/RTOS code
 		 * making use of VPE1 will be responsable for that VPE.
 		 */
 		if ((c->processor_id & PRID_REV_MASK) <= PRID_REV_34K_V1_0_2)
diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index e578685..4353d32 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -16,9 +16,6 @@
 #include <asm/isadep.h>
 #include <asm/thread_info.h>
 #include <asm/war.h>
-#ifdef CONFIG_MIPS_MT_SMTC
-#include <asm/mipsmtregs.h>
-#endif
 
 #ifndef CONFIG_PREEMPT
 #define resume_kernel	restore_all
@@ -89,41 +86,6 @@ FEXPORT(syscall_exit)
 	bnez	t0, syscall_exit_work
 
 restore_all:				# restore full frame
-#ifdef CONFIG_MIPS_MT_SMTC
-#ifdef CONFIG_MIPS_MT_SMTC_IM_BACKSTOP
-/* Re-arm any temporarily masked interrupts not explicitly "acked" */
-	mfc0	v0, CP0_TCSTATUS
-	ori	v1, v0, TCSTATUS_IXMT
-	mtc0	v1, CP0_TCSTATUS
-	andi	v0, TCSTATUS_IXMT
-	_ehb
-	mfc0	t0, CP0_TCCONTEXT
-	DMT	9				# dmt t1
-	jal	mips_ihb
-	mfc0	t2, CP0_STATUS
-	andi	t3, t0, 0xff00
-	or	t2, t2, t3
-	mtc0	t2, CP0_STATUS
-	_ehb
-	andi	t1, t1, VPECONTROL_TE
-	beqz	t1, 1f
-	EMT
-1:
-	mfc0	v1, CP0_TCSTATUS
-	/* We set IXMT above, XOR should clear it here */
-	xori	v1, v1, TCSTATUS_IXMT
-	or	v1, v0, v1
-	mtc0	v1, CP0_TCSTATUS
-	_ehb
-	xor	t0, t0, t3
-	mtc0	t0, CP0_TCCONTEXT
-#endif /* CONFIG_MIPS_MT_SMTC_IM_BACKSTOP */
-/* Detect and execute deferred IPI "interrupts" */
-	LONG_L	s0, TI_REGS($28)
-	LONG_S	sp, TI_REGS($28)
-	jal	deferred_smtc_ipi
-	LONG_S	s0, TI_REGS($28)
-#endif /* CONFIG_MIPS_MT_SMTC */
 	.set	noat
 	RESTORE_TEMP
 	RESTORE_AT
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index a9ce340..9ba1c30 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -21,20 +21,6 @@
 #include <asm/war.h>
 #include <asm/thread_info.h>
 
-#ifdef CONFIG_MIPS_MT_SMTC
-#define PANIC_PIC(msg)					\
-		.set	push;				\
-		.set	nomicromips;			\
-		.set	reorder;			\
-		PTR_LA	a0,8f;				\
-		.set	noat;				\
-		PTR_LA	AT, panic;			\
-		jr	AT;				\
-9:		b	9b;				\
-		.set	pop;				\
-		TEXT(msg)
-#endif
-
 	__INIT
 
 /*
@@ -251,15 +237,6 @@ NESTED(except_vec_vi, 0, sp)
 	SAVE_AT
 	.set	push
 	.set	noreorder
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * To keep from blindly blocking *all* interrupts
-	 * during service by SMTC kernel, we also want to
-	 * pass the IM value to be cleared.
-	 */
-FEXPORT(except_vec_vi_mori)
-	ori	a0, $0, 0
-#endif /* CONFIG_MIPS_MT_SMTC */
 	PTR_LA	v1, except_vec_vi_handler
 FEXPORT(except_vec_vi_lui)
 	lui	v0, 0		/* Patched */
@@ -277,37 +254,10 @@ EXPORT(except_vec_vi_end)
 NESTED(except_vec_vi_handler, 0, sp)
 	SAVE_TEMP
 	SAVE_STATIC
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * SMTC has an interesting problem that interrupts are level-triggered,
-	 * and the CLI macro will clear EXL, potentially causing a duplicate
-	 * interrupt service invocation. So we need to clear the associated
-	 * IM bit of Status prior to doing CLI, and restore it after the
-	 * service routine has been invoked - we must assume that the
-	 * service routine will have cleared the state, and any active
-	 * level represents a new or otherwised unserviced event...
-	 */
-	mfc0	t1, CP0_STATUS
-	and	t0, a0, t1
-#ifdef CONFIG_MIPS_MT_SMTC_IM_BACKSTOP
-	mfc0	t2, CP0_TCCONTEXT
-	or	t2, t0, t2
-	mtc0	t2, CP0_TCCONTEXT
-#endif /* CONFIG_MIPS_MT_SMTC_IM_BACKSTOP */
-	xor	t1, t1, t0
-	mtc0	t1, CP0_STATUS
-	_ehb
-#endif /* CONFIG_MIPS_MT_SMTC */
 	CLI
 #ifdef CONFIG_TRACE_IRQFLAGS
 	move	s0, v0
-#ifdef CONFIG_MIPS_MT_SMTC
-	move	s1, a0
-#endif
 	TRACE_IRQS_OFF
-#ifdef CONFIG_MIPS_MT_SMTC
-	move	a0, s1
-#endif
 	move	v0, s0
 #endif
 
@@ -496,9 +446,6 @@ NESTED(nmi_handler, PT_SIZE, sp)
 
 	.align	5
 	LEAF(handle_ri_rdhwr_vivt)
-#ifdef CONFIG_MIPS_MT_SMTC
-	PANIC_PIC("handle_ri_rdhwr_vivt called")
-#else
 	.set	push
 	.set	noat
 	.set	noreorder
@@ -517,7 +464,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.set	pop
 	bltz	k1, handle_ri	/* slow path */
 	/* fall thru */
-#endif
+
 	END(handle_ri_rdhwr_vivt)
 
 	LEAF(handle_ri_rdhwr)
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index e712dcf..783ab8b 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -35,33 +35,14 @@
 	 */
 	.macro	setup_c0_status set clr
 	.set	push
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * For SMTC, we need to set privilege and disable interrupts only for
-	 * the current TC, using the TCStatus register.
-	 */
-	mfc0	t0, CP0_TCSTATUS
-	/* Fortunately CU 0 is in the same place in both registers */
-	/* Set TCU0, TMX, TKSU (for later inversion) and IXMT */
-	li	t1, ST0_CU0 | 0x08001c00
-	or	t0, t1
-	/* Clear TKSU, leave IXMT */
-	xori	t0, 0x00001800
-	mtc0	t0, CP0_TCSTATUS
-	_ehb
-	/* We need to leave the global IE bit set, but clear EXL...*/
-	mfc0	t0, CP0_STATUS
-	or	t0, ST0_CU0 | ST0_EXL | ST0_ERL | \set | \clr
-	xor	t0, ST0_EXL | ST0_ERL | \clr
-	mtc0	t0, CP0_STATUS
-#else
+
 	mfc0	t0, CP0_STATUS
 	or	t0, ST0_CU0|\set|0x1f|\clr
 	xor	t0, 0x1f|\clr
 	mtc0	t0, CP0_STATUS
 	.set	noreorder
 	sll	zero,3				# ehb
-#endif
+
 	.set	pop
 	.endm
 
@@ -115,24 +96,6 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 	jr	t0
 0:
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * In SMTC kernel, "CLI" is thread-specific, in TCStatus.
-	 * We still need to enable interrupts globally in Status,
-	 * and clear EXL/ERL.
-	 *
-	 * TCContext is used to track interrupt levels under
-	 * service in SMTC kernel. Clear for boot TC before
-	 * allowing any interrupts.
-	 */
-	mtc0	zero, CP0_TCCONTEXT
-
-	mfc0	t0, CP0_STATUS
-	ori	t0, t0, 0xff1f
-	xori	t0, t0, 0x001e
-	mtc0	t0, CP0_STATUS
-#endif /* CONFIG_MIPS_MT_SMTC */
-
 	PTR_LA		t0, __bss_start		# clear .bss
 	LONG_S		zero, (t0)
 	PTR_LA		t1, __bss_stop - LONGSIZE
@@ -164,25 +127,8 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
  * function after setting up the stack and gp registers.
  */
 NESTED(smp_bootstrap, 16, sp)
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * Read-modify-writes of Status must be atomic, and this
-	 * is one case where CLI is invoked without EXL being
-	 * necessarily set. The CLI and setup_c0_status will
-	 * in fact be redundant for all but the first TC of
-	 * each VPE being booted.
-	 */
-	DMT	10	# dmt t2 /* t0, t1 are used by CLI and setup_c0_status() */
-	jal	mips_ihb
-#endif /* CONFIG_MIPS_MT_SMTC */
 	smp_slave_setup
 	setup_c0_status_sec
-#ifdef CONFIG_MIPS_MT_SMTC
-	andi	t2, t2, VPECONTROL_TE
-	beqz	t2, 2f
-	EMT		# emt
-2:
-#endif /* CONFIG_MIPS_MT_SMTC */
 	j	start_secondary
 	END(smp_bootstrap)
 #endif /* CONFIG_SMP */
diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
index 2b91fe8..50b3648 100644
--- a/arch/mips/kernel/i8259.c
+++ b/arch/mips/kernel/i8259.c
@@ -42,9 +42,6 @@ static struct irq_chip i8259A_chip = {
 	.irq_disable		= disable_8259A_irq,
 	.irq_unmask		= enable_8259A_irq,
 	.irq_mask_ack		= mask_and_ack_8259A,
-#ifdef CONFIG_MIPS_MT_SMTC_IRQAFF
-	.irq_set_affinity	= plat_set_irq_affinity,
-#endif /* CONFIG_MIPS_MT_SMTC_IRQAFF */
 };
 
 /*
@@ -180,7 +177,6 @@ handle_real_irq:
 		outb(cached_master_mask, PIC_MASTER_IMR);
 		outb(0x60+irq, PIC_MASTER_CMD); /* 'Specific EOI to master */
 	}
-	smtc_im_ack_irq(irq);
 	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
 	return;
 
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 837ff27..6985abe 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -233,18 +233,8 @@ void __init check_wait(void)
 	}
 }
 
-static void smtc_idle_hook(void)
-{
-#ifdef CONFIG_MIPS_MT_SMTC
-	void smtc_idle_loop_hook(void);
-
-	smtc_idle_loop_hook();
-#endif
-}
-
 void arch_cpu_idle(void)
 {
-	smtc_idle_hook();
 	if (cpu_wait)
 		cpu_wait();
 	else
diff --git a/arch/mips/kernel/irq-msc01.c b/arch/mips/kernel/irq-msc01.c
index fab40f7..4858642 100644
--- a/arch/mips/kernel/irq-msc01.c
+++ b/arch/mips/kernel/irq-msc01.c
@@ -53,13 +53,9 @@ static inline void unmask_msc_irq(struct irq_data *d)
  */
 static void level_mask_and_ack_msc_irq(struct irq_data *d)
 {
-	unsigned int irq = d->irq;
-
 	mask_msc_irq(d);
 	if (!cpu_has_veic)
 		MSCIC_WRITE(MSC01_IC_EOI, 0);
-	/* This actually needs to be a call into platform code */
-	smtc_im_ack_irq(irq);
 }
 
 /*
@@ -78,7 +74,6 @@ static void edge_mask_and_ack_msc_irq(struct irq_data *d)
 		MSCIC_WRITE(MSC01_IC_SUP+irq*8, r | ~MSC01_IC_SUP_EDGE_BIT);
 		MSCIC_WRITE(MSC01_IC_SUP+irq*8, r);
 	}
-	smtc_im_ack_irq(irq);
 }
 
 /*
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index d1fea7a..fbb23a1 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -73,7 +73,6 @@ void free_irqno(unsigned int irq)
  */
 void ack_bad_irq(unsigned int irq)
 {
-	smtc_im_ack_irq(irq);
 	printk("unexpected IRQ # %d\n", irq);
 }
 
@@ -142,23 +141,6 @@ void __irq_entry do_IRQ(unsigned int irq)
 {
 	irq_enter();
 	check_stack_overflow();
-	if (!smtc_handle_on_other_cpu(irq))
-		generic_handle_irq(irq);
-	irq_exit();
-}
-
-#ifdef CONFIG_MIPS_MT_SMTC_IRQAFF
-/*
- * To avoid inefficient and in some cases pathological re-checking of
- * IRQ affinity, we have this variant that skips the affinity check.
- */
-
-void __irq_entry do_IRQ_no_affinity(unsigned int irq)
-{
-	irq_enter();
-	smtc_im_backstop(irq);
 	generic_handle_irq(irq);
 	irq_exit();
 }
-
-#endif /* CONFIG_MIPS_MT_SMTC_IRQAFF */
diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index cb09862..2e8b8ce 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -1,5 +1,5 @@
 /*
- * General MIPS MT support routines, usable in AP/SP, SMVP, or SMTC kernels
+ * General MIPS MT support routines, usable in AP/SP or SMVP kernels
  * Copyright (C) 2005 Mips Technologies, Inc
  */
 #include <linux/cpu.h>
diff --git a/arch/mips/kernel/mips-mt.c b/arch/mips/kernel/mips-mt.c
index 6ded9bd..67ba02c 100644
--- a/arch/mips/kernel/mips-mt.c
+++ b/arch/mips/kernel/mips-mt.c
@@ -1,5 +1,5 @@
 /*
- * General MIPS MT support routines, usable in AP/SP, SMVP, or SMTC kernels
+ * General MIPS MT support routines, usable in AP/SP or SMVP kernels
  * Copyright (C) 2005 Mips Technologies, Inc
  */
 
@@ -57,9 +57,6 @@ void mips_mt_regdump(unsigned long mvpctl)
 	int tc;
 	unsigned long haltval;
 	unsigned long tcstatval;
-#ifdef CONFIG_MIPS_MT_SMTC
-	void smtc_soft_dump(void);
-#endif /* CONFIG_MIPT_MT_SMTC */
 
 	local_irq_save(flags);
 	vpflags = dvpe();
@@ -116,9 +113,6 @@ void mips_mt_regdump(unsigned long mvpctl)
 		if (!haltval)
 			write_tc_c0_tchalt(0);
 	}
-#ifdef CONFIG_MIPS_MT_SMTC
-	smtc_soft_dump();
-#endif /* CONFIG_MIPT_MT_SMTC */
 	printk("===========================\n");
 	evpe(vpflags);
 	local_irq_restore(flags);
@@ -295,21 +289,11 @@ void mips_mt_set_cpuoptions(void)
 
 void mt_cflush_lockdown(void)
 {
-#ifdef CONFIG_MIPS_MT_SMTC
-	void smtc_cflush_lockdown(void);
-
-	smtc_cflush_lockdown();
-#endif /* CONFIG_MIPS_MT_SMTC */
 	/* FILL IN VSMP and AP/SP VERSIONS HERE */
 }
 
 void mt_cflush_release(void)
 {
-#ifdef CONFIG_MIPS_MT_SMTC
-	void smtc_cflush_release(void);
-
-	smtc_cflush_release();
-#endif /* CONFIG_MIPS_MT_SMTC */
 	/* FILL IN VSMP and AP/SP VERSIONS HERE */
 }
 
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 037a44d..e12843a 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -124,7 +124,6 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "kscratch registers\t: %d\n",
 		      hweight8(cpu_data[n].kscratch_mask));
 	seq_printf(m, "core\t\t\t: %d\n", cpu_data[n].core);
-
 	sprintf(fmt, "VCE%%c exceptions\t\t: %s\n",
 		      cpu_has_vce ? "%u" : "not available");
 	seq_printf(m, fmt, 'D', vced_count);
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 60e39dc..0a1ec0f 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -140,13 +140,6 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	 */
 	childregs->cp0_status &= ~(ST0_CU2|ST0_CU1);
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * SMTC restores TCStatus after Status, and the CU bits
-	 * are aliased there.
-	 */
-	childregs->cp0_tcstatus &= ~(ST0_CU2|ST0_CU1);
-#endif
 	clear_tsk_thread_flag(p, TIF_USEDFPU);
 
 #ifdef CONFIG_MIPS_MT_FPAFF
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index abacac7..547c522 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -87,18 +87,6 @@
 
 	PTR_ADDU	t0, $28, _THREAD_SIZE - 32
 	set_saved_sp	t0, t1, t2
-#ifdef CONFIG_MIPS_MT_SMTC
-	/* Read-modify-writes of Status must be atomic on a VPE */
-	mfc0	t2, CP0_TCSTATUS
-	ori	t1, t2, TCSTATUS_IXMT
-	mtc0	t1, CP0_TCSTATUS
-	andi	t2, t2, TCSTATUS_IXMT
-	_ehb
-	DMT	8				# dmt	t0
-	move	t1,ra
-	jal	mips_ihb
-	move	ra,t1
-#endif /* CONFIG_MIPS_MT_SMTC */
 	mfc0	t1, CP0_STATUS		/* Do we really need this? */
 	li	a3, 0xff01
 	and	t1, a3
@@ -107,18 +95,6 @@
 	and	a2, a3
 	or	a2, t1
 	mtc0	a2, CP0_STATUS
-#ifdef CONFIG_MIPS_MT_SMTC
-	_ehb
-	andi	t0, t0, VPECONTROL_TE
-	beqz	t0, 1f
-	emt
-1:
-	mfc0	t1, CP0_TCSTATUS
-	xori	t1, t1, TCSTATUS_IXMT
-	or	t1, t1, t2
-	mtc0	t1, CP0_TCSTATUS
-	_ehb
-#endif /* CONFIG_MIPS_MT_SMTC */
 	move	v0, a0
 	jr	ra
 	END(resume)
@@ -176,19 +152,10 @@ LEAF(_restore_msa)
 #define FPU_DEFAULT  0x00000000
 
 LEAF(_init_fpu)
-#ifdef CONFIG_MIPS_MT_SMTC
-	/* Rather than manipulate per-VPE Status, set per-TC bit in TCStatus */
-	mfc0	t0, CP0_TCSTATUS
-	/* Bit position is the same for Status, TCStatus */
-	li	t1, ST0_CU1
-	or	t0, t1
-	mtc0	t0, CP0_TCSTATUS
-#else /* Normal MIPS CU1 enable */
 	mfc0	t0, CP0_STATUS
 	li	t1, ST0_CU1
 	or	t0, t1
 	mtc0	t0, CP0_STATUS
-#endif /* CONFIG_MIPS_MT_SMTC */
 	enable_fpu_hazard
 
 	li	t1, FPU_DEFAULT
diff --git a/arch/mips/kernel/rtlx-mt.c b/arch/mips/kernel/rtlx-mt.c
index 9c1aca0..5a66b97 100644
--- a/arch/mips/kernel/rtlx-mt.c
+++ b/arch/mips/kernel/rtlx-mt.c
@@ -36,7 +36,6 @@ static irqreturn_t rtlx_interrupt(int irq, void *dev_id)
 	unsigned long flags;
 	int i;
 
-	/* Ought not to be strictly necessary for SMTC builds */
 	local_irq_save(flags);
 	vpeflags = dvpe();
 	set_c0_status(0x100 << MIPS_CPU_RTLX_IRQ);
diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index 3ef55fb7..4b3ecd1 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -49,14 +49,11 @@ static void cmp_init_secondary(void)
 
 	/* Enable per-cpu interrupts: platform specific */
 
-#if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_MIPS_MT_SMTC)
+#if defined(CONFIG_MIPS_MT_SMP)
 	if (cpu_has_mipsmt)
 		c->vpe_id = (read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) &
 			TCBIND_CURVPE;
 #endif
-#ifdef CONFIG_MIPS_MT_SMTC
-	c->tc_id  = (read_c0_tcbind() & TCBIND_CURTC) >> TCBIND_CURTC_SHIFT;
-#endif
 }
 
 static void cmp_smp_finish(void)
@@ -135,10 +132,6 @@ void __init cmp_smp_setup(void)
 		unsigned int mvpconf0 = read_c0_mvpconf0();
 
 		nvpe = ((mvpconf0 & MVPCONF0_PVPE) >> MVPCONF0_PVPE_SHIFT) + 1;
-#elif defined(CONFIG_MIPS_MT_SMTC)
-		unsigned int mvpconf0 = read_c0_mvpconf0();
-
-		nvpe = ((mvpconf0 & MVPCONF0_PTC) >> MVPCONF0_PTC_SHIFT) + 1;
 #endif
 		smp_num_siblings = nvpe;
 	}
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 0a022ee..35bb05a 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -43,10 +43,6 @@
 #include <asm/time.h>
 #include <asm/setup.h>
 
-#ifdef CONFIG_MIPS_MT_SMTC
-#include <asm/mipsmtregs.h>
-#endif /* CONFIG_MIPS_MT_SMTC */
-
 volatile cpumask_t cpu_callin_map;	/* Bitmask of started secondaries */
 
 int __cpu_number_map[NR_CPUS];		/* Map physical to logical */
@@ -102,12 +98,6 @@ asmlinkage void start_secondary(void)
 {
 	unsigned int cpu;
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	/* Only do cpu_probe for first TC of CPU */
-	if ((read_c0_tcbind() & TCBIND_CURTC) != 0)
-		__cpu_name[smp_processor_id()] = __cpu_name[0];
-	else
-#endif /* CONFIG_MIPS_MT_SMTC */
 	cpu_probe();
 	cpu_report();
 	per_cpu_trap_init(false);
@@ -238,13 +228,10 @@ static void flush_tlb_mm_ipi(void *mm)
  *  o collapses to normal function call on UP kernels
  *  o collapses to normal function call on systems with a single shared
  *    primary cache.
- *  o CONFIG_MIPS_MT_SMTC currently implies there is only one physical core.
  */
 static inline void smp_on_other_tlbs(void (*func) (void *info), void *info)
 {
-#ifndef CONFIG_MIPS_MT_SMTC
 	smp_call_function(func, info, 1);
-#endif
 }
 
 static inline void smp_on_each_tlb(void (*func) (void *info), void *info)
diff --git a/arch/mips/kernel/smtc-asm.S b/arch/mips/kernel/smtc-asm.S
deleted file mode 100644
index 2866863..0000000
diff --git a/arch/mips/kernel/smtc-proc.c b/arch/mips/kernel/smtc-proc.c
deleted file mode 100644
index 38635a9..0000000
diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
deleted file mode 100644
index c1681d6..0000000
diff --git a/arch/mips/kernel/sync-r4k.c b/arch/mips/kernel/sync-r4k.c
index c24ad5f..bb56e89 100644
--- a/arch/mips/kernel/sync-r4k.c
+++ b/arch/mips/kernel/sync-r4k.c
@@ -7,7 +7,6 @@
  * enabled briefly - prom_smp_finish() should not be responsible for enabling
  * interrupts...)
  *
- * FIXME: broken for SMTC
  */
 
 #include <linux/kernel.h>
@@ -33,14 +32,6 @@ void synchronise_count_master(int cpu)
 	unsigned long flags;
 	unsigned int initcount;
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * SMTC needs to synchronise per VPE, not per CPU
-	 * ignore for now
-	 */
-	return;
-#endif
-
 	printk(KERN_INFO "Synchronize counters for CPU %u: ", cpu);
 
 	local_irq_save(flags);
@@ -110,14 +101,6 @@ void synchronise_count_slave(int cpu)
 	int i;
 	unsigned int initcount;
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * SMTC needs to synchronise per VPE, not per CPU
-	 * ignore for now
-	 */
-	return;
-#endif
-
 	/*
 	 * Not every cpu is online at the time this gets called,
 	 * so we first wait for the master to say everyone is ready
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index dcb8e5d..8d01709 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -26,7 +26,6 @@
 #include <asm/cpu-features.h>
 #include <asm/cpu-type.h>
 #include <asm/div64.h>
-#include <asm/smtc_ipi.h>
 #include <asm/time.h>
 
 /*
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 074e857..0270ca2 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -370,9 +370,6 @@ void __noreturn die(const char *str, struct pt_regs *regs)
 {
 	static int die_counter;
 	int sig = SIGSEGV;
-#ifdef CONFIG_MIPS_MT_SMTC
-	unsigned long dvpret;
-#endif /* CONFIG_MIPS_MT_SMTC */
 
 	oops_enter();
 
@@ -382,13 +379,7 @@ void __noreturn die(const char *str, struct pt_regs *regs)
 
 	console_verbose();
 	raw_spin_lock_irq(&die_lock);
-#ifdef CONFIG_MIPS_MT_SMTC
-	dvpret = dvpe();
-#endif /* CONFIG_MIPS_MT_SMTC */
 	bust_spinlocks(1);
-#ifdef CONFIG_MIPS_MT_SMTC
-	mips_mt_regdump(dvpret);
-#endif /* CONFIG_MIPS_MT_SMTC */
 
 	printk("%s[#%d]:\n", str, ++die_counter);
 	show_registers(regs);
@@ -1759,19 +1750,6 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 		extern char rollback_except_vec_vi;
 		char *vec_start = using_rollback_handler() ?
 			&rollback_except_vec_vi : &except_vec_vi;
-#ifdef CONFIG_MIPS_MT_SMTC
-		/*
-		 * We need to provide the SMTC vectored interrupt handler
-		 * not only with the address of the handler, but with the
-		 * Status.IM bit to be masked before going there.
-		 */
-		extern char except_vec_vi_mori;
-#if defined(CONFIG_CPU_MICROMIPS) || defined(CONFIG_CPU_BIG_ENDIAN)
-		const int mori_offset = &except_vec_vi_mori - vec_start + 2;
-#else
-		const int mori_offset = &except_vec_vi_mori - vec_start;
-#endif
-#endif /* CONFIG_MIPS_MT_SMTC */
 #if defined(CONFIG_CPU_MICROMIPS) || defined(CONFIG_CPU_BIG_ENDIAN)
 		const int lui_offset = &except_vec_vi_lui - vec_start + 2;
 		const int ori_offset = &except_vec_vi_ori - vec_start + 2;
@@ -1795,12 +1773,6 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 #else
 				handler_len);
 #endif
-#ifdef CONFIG_MIPS_MT_SMTC
-		BUG_ON(n > 7);	/* Vector index %d exceeds SMTC maximum. */
-
-		h = (u16 *)(b + mori_offset);
-		*h = (0x100 << n);
-#endif /* CONFIG_MIPS_MT_SMTC */
 		h = (u16 *)(b + lui_offset);
 		*h = (handler >> 16) & 0xffff;
 		h = (u16 *)(b + ori_offset);
@@ -1870,20 +1842,6 @@ void per_cpu_trap_init(bool is_boot_cpu)
 	unsigned int cpu = smp_processor_id();
 	unsigned int status_set = ST0_CU0;
 	unsigned int hwrena = cpu_hwrena_impl_bits;
-#ifdef CONFIG_MIPS_MT_SMTC
-	int secondaryTC = 0;
-	int bootTC = (cpu == 0);
-
-	/*
-	 * Only do per_cpu_trap_init() for first TC of Each VPE.
-	 * Note that this hack assumes that the SMTC init code
-	 * assigns TCs consecutively and in ascending order.
-	 */
-
-	if (((read_c0_tcbind() & TCBIND_CURTC) != 0) &&
-	    ((read_c0_tcbind() & TCBIND_CURVPE) == cpu_data[cpu - 1].vpe_id))
-		secondaryTC = 1;
-#endif /* CONFIG_MIPS_MT_SMTC */
 
 	/*
 	 * Disable coprocessors and select 32-bit or 64-bit addressing
@@ -1911,10 +1869,6 @@ void per_cpu_trap_init(bool is_boot_cpu)
 	if (hwrena)
 		write_c0_hwrena(hwrena);
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	if (!secondaryTC) {
-#endif /* CONFIG_MIPS_MT_SMTC */
-
 	if (cpu_has_veic || cpu_has_vint) {
 		unsigned long sr = set_c0_status(ST0_BEV);
 		write_c0_ebase(ebase);
@@ -1949,10 +1903,6 @@ void per_cpu_trap_init(bool is_boot_cpu)
 		cp0_perfcount_irq = -1;
 	}
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	}
-#endif /* CONFIG_MIPS_MT_SMTC */
-
 	if (!cpu_data[cpu].asid_cache)
 		cpu_data[cpu].asid_cache = ASID_FIRST_VERSION;
 
@@ -1961,23 +1911,11 @@ void per_cpu_trap_init(bool is_boot_cpu)
 	BUG_ON(current->mm);
 	enter_lazy_tlb(&init_mm, current);
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	if (bootTC) {
-#endif /* CONFIG_MIPS_MT_SMTC */
-		/* Boot CPU's cache setup in setup_arch(). */
-		if (!is_boot_cpu)
-			cpu_cache_init();
-		tlb_init();
-#ifdef CONFIG_MIPS_MT_SMTC
-	} else if (!secondaryTC) {
-		/*
-		 * First TC in non-boot VPE must do subset of tlb_init()
-		 * for MMU countrol registers.
-		 */
-		write_c0_pagemask(PM_DEFAULT_MASK);
-		write_c0_wired(0);
-	}
-#endif /* CONFIG_MIPS_MT_SMTC */
+	/* Boot CPU's cache setup in setup_arch(). */
+	if (!is_boot_cpu)
+		cpu_cache_init();
+	tlb_init();
+
 	TLBMISS_HANDLER_SETUP();
 }
 
diff --git a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
index 949ae0e..e149c91 100644
--- a/arch/mips/kernel/vpe-mt.c
+++ b/arch/mips/kernel/vpe-mt.c
@@ -127,7 +127,7 @@ int vpe_run(struct vpe *v)
 	clear_c0_mvpcontrol(MVPCONTROL_VPC);
 
 	/*
-	 * SMTC/SMVP kernels manage VPE enable independently,
+	 * SMVP kernels manage VPE enable independently,
 	 * but uniprocessor kernels need to turn it on, even
 	 * if that wasn't the pre-dvpe() state.
 	 */
@@ -454,12 +454,12 @@ int __init vpe_module_init(void)
 
 			settc(tc);
 
-			/* Any TC that is bound to VPE0 gets left as is - in
-			 * case we are running SMTC on VPE0. A TC that is bound
-			 * to any other VPE gets bound to VPE0, ideally I'd like
-			 * to make it homeless but it doesn't appear to let me
-			 * bind a TC to a non-existent VPE. Which is perfectly
-			 * reasonable.
+			/*
+			 * Any TC that is bound to VPE0 gets left as is. A TC
+			 * that is bound to any other VPE gets bound to VPE0,
+			 * ideally I'd like to make it homeless but it doesn't
+			 * appear to let me bind a TC to a non-existent VPE.
+			 * Which is perfectly reasonable.
 			 *
 			 * The (un)bound state is visible to an EJTAG probe so
 			 * may notify GDB...
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 85685e1..030568a 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -61,7 +61,7 @@
 /* we have a cascade of 8 irqs */
 #define MIPS_CPU_IRQ_CASCADE		8
 
-#if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_MIPS_MT_SMTC)
+#ifdef CONFIG_MIPS_MT_SMP
 int gic_present;
 #endif
 
@@ -440,7 +440,7 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 	arch_init_ipiirq(MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_CALL_IRQ, &irq_call);
 #endif
 
-#if !defined(CONFIG_MIPS_MT_SMP) && !defined(CONFIG_MIPS_MT_SMTC)
+#ifndef CONFIG_MIPS_MT_SMP
 	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 |
 		IE_IRQ3 | IE_IRQ4 | IE_IRQ5);
 #else
diff --git a/arch/mips/lib/mips-atomic.c b/arch/mips/lib/mips-atomic.c
index 6807f71..094693f 100644
--- a/arch/mips/lib/mips-atomic.c
+++ b/arch/mips/lib/mips-atomic.c
@@ -15,7 +15,7 @@
 #include <linux/export.h>
 #include <linux/stringify.h>
 
-#if !defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_MIPS_MT_SMTC)
+#ifndef CONFIG_CPU_MIPSR2
 
 /*
  * For cli() we have to insert nops to make sure that the new value
@@ -42,12 +42,7 @@ notrace void arch_local_irq_disable(void)
 	__asm__ __volatile__(
 	"	.set	push						\n"
 	"	.set	noat						\n"
-#ifdef CONFIG_MIPS_MT_SMTC
-	"	mfc0	$1, $2, 1					\n"
-	"	ori	$1, 0x400					\n"
-	"	.set	noreorder					\n"
-	"	mtc0	$1, $2, 1					\n"
-#elif defined(CONFIG_CPU_MIPSR2)
+#ifdef CONFIG_CPU_MIPSR2
 	/* see irqflags.h for inline function */
 #else
 	"	mfc0	$1,$12						\n"
@@ -77,13 +72,7 @@ notrace unsigned long arch_local_irq_save(void)
 	"	.set	push						\n"
 	"	.set	reorder						\n"
 	"	.set	noat						\n"
-#ifdef CONFIG_MIPS_MT_SMTC
-	"	mfc0	%[flags], $2, 1				\n"
-	"	ori	$1, %[flags], 0x400				\n"
-	"	.set	noreorder					\n"
-	"	mtc0	$1, $2, 1					\n"
-	"	andi	%[flags], %[flags], 0x400			\n"
-#elif defined(CONFIG_CPU_MIPSR2)
+#ifdef CONFIG_CPU_MIPSR2
 	/* see irqflags.h for inline function */
 #else
 	"	mfc0	%[flags], $12					\n"
@@ -108,29 +97,13 @@ notrace void arch_local_irq_restore(unsigned long flags)
 {
 	unsigned long __tmp1;
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * SMTC kernel needs to do a software replay of queued
-	 * IPIs, at the cost of branch and call overhead on each
-	 * local_irq_restore()
-	 */
-	if (unlikely(!(flags & 0x0400)))
-		smtc_ipi_replay();
-#endif
 	preempt_disable();
 
 	__asm__ __volatile__(
 	"	.set	push						\n"
 	"	.set	noreorder					\n"
 	"	.set	noat						\n"
-#ifdef CONFIG_MIPS_MT_SMTC
-	"	mfc0	$1, $2, 1					\n"
-	"	andi	%[flags], 0x400					\n"
-	"	ori	$1, 0x400					\n"
-	"	xori	$1, 0x400					\n"
-	"	or	%[flags], $1					\n"
-	"	mtc0	%[flags], $2, 1					\n"
-#elif defined(CONFIG_CPU_MIPSR2) && defined(CONFIG_IRQ_CPU)
+#if defined(CONFIG_CPU_MIPSR2) && defined(CONFIG_IRQ_CPU)
 	/* see irqflags.h for inline function */
 #elif defined(CONFIG_CPU_MIPSR2)
 	/* see irqflags.h for inline function */
@@ -163,14 +136,7 @@ notrace void __arch_local_irq_restore(unsigned long flags)
 	"	.set	push						\n"
 	"	.set	noreorder					\n"
 	"	.set	noat						\n"
-#ifdef CONFIG_MIPS_MT_SMTC
-	"	mfc0	$1, $2, 1					\n"
-	"	andi	%[flags], 0x400					\n"
-	"	ori	$1, 0x400					\n"
-	"	xori	$1, 0x400					\n"
-	"	or	%[flags], $1					\n"
-	"	mtc0	%[flags], $2, 1					\n"
-#elif defined(CONFIG_CPU_MIPSR2) && defined(CONFIG_IRQ_CPU)
+#if defined(CONFIG_CPU_MIPSR2) && defined(CONFIG_IRQ_CPU)
 	/* see irqflags.h for inline function */
 #elif defined(CONFIG_CPU_MIPSR2)
 	/* see irqflags.h for inline function */
@@ -192,4 +158,4 @@ notrace void __arch_local_irq_restore(unsigned long flags)
 }
 EXPORT_SYMBOL(__arch_local_irq_restore);
 
-#endif /* !defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_MIPS_MT_SMTC) */
+#endif /* !defined(CONFIG_CPU_MIPSR2) */
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 1c74a6a..7986a3a 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -50,7 +50,7 @@ static inline void r4k_on_each_cpu(void (*func) (void *info), void *info)
 {
 	preempt_disable();
 
-#if !defined(CONFIG_MIPS_MT_SMP) && !defined(CONFIG_MIPS_MT_SMTC)
+#ifndef CONFIG_MIPS_MT_SMP
 	smp_call_function(func, info, 1);
 #endif
 	func(info);
@@ -428,7 +428,7 @@ static void r4k___flush_cache_all(void)
 
 static inline int has_valid_asid(const struct mm_struct *mm)
 {
-#if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_MIPS_MT_SMTC)
+#ifdef CONFIG_MIPS_MT_SMP
 	int i;
 
 	for_each_online_cpu(i)
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 4fc74c7..e35f97a 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -45,26 +45,10 @@
 #include <asm/fixmap.h>
 
 /* Atomicity and interruptability */
-#ifdef CONFIG_MIPS_MT_SMTC
-
-#include <asm/mipsmtregs.h>
-
-#define ENTER_CRITICAL(flags) \
-	{ \
-	unsigned int mvpflags; \
-	local_irq_save(flags);\
-	mvpflags = dvpe()
-#define EXIT_CRITICAL(flags) \
-	evpe(mvpflags); \
-	local_irq_restore(flags); \
-	}
-#else
 
 #define ENTER_CRITICAL(flags) local_irq_save(flags)
 #define EXIT_CRITICAL(flags) local_irq_restore(flags)
 
-#endif /* CONFIG_MIPS_MT_SMTC */
-
 /*
  * We have up to 8 empty zeroed pages so we can map one of the right colour
  * when needed.	 This is necessary only on R4000 / R4400 SC and MC versions
@@ -100,20 +84,6 @@ void setup_zero_pages(void)
 	zero_page_mask = ((PAGE_SIZE << order) - 1) & PAGE_MASK;
 }
 
-#ifdef CONFIG_MIPS_MT_SMTC
-static pte_t *kmap_coherent_pte;
-static void __init kmap_coherent_init(void)
-{
-	unsigned long vaddr;
-
-	/* cache the first coherent kmap pte */
-	vaddr = __fix_to_virt(FIX_CMAP_BEGIN);
-	kmap_coherent_pte = kmap_get_fixmap_pte(vaddr);
-}
-#else
-static inline void kmap_coherent_init(void) {}
-#endif
-
 void *kmap_coherent(struct page *page, unsigned long addr)
 {
 	enum fixed_addresses idx;
@@ -126,12 +96,7 @@ void *kmap_coherent(struct page *page, unsigned long addr)
 
 	pagefault_disable();
 	idx = (addr >> PAGE_SHIFT) & (FIX_N_COLOURS - 1);
-#ifdef CONFIG_MIPS_MT_SMTC
-	idx += FIX_N_COLOURS * smp_processor_id() +
-		(in_interrupt() ? (FIX_N_COLOURS * NR_CPUS) : 0);
-#else
 	idx += in_interrupt() ? FIX_N_COLOURS : 0;
-#endif
 	vaddr = __fix_to_virt(FIX_CMAP_END - idx);
 	pte = mk_pte(page, PAGE_KERNEL);
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
@@ -145,25 +110,11 @@ void *kmap_coherent(struct page *page, unsigned long addr)
 	write_c0_entryhi(vaddr & (PAGE_MASK << 1));
 	write_c0_entrylo0(entrylo);
 	write_c0_entrylo1(entrylo);
-#ifdef CONFIG_MIPS_MT_SMTC
-	set_pte(kmap_coherent_pte - (FIX_CMAP_END - idx), pte);
-	/* preload TLB instead of local_flush_tlb_one() */
-	mtc0_tlbw_hazard();
-	tlb_probe();
-	tlb_probe_hazard();
-	tlbidx = read_c0_index();
-	mtc0_tlbw_hazard();
-	if (tlbidx < 0)
-		tlb_write_random();
-	else
-		tlb_write_indexed();
-#else
 	tlbidx = read_c0_wired();
 	write_c0_wired(tlbidx + 1);
 	write_c0_index(tlbidx);
 	mtc0_tlbw_hazard();
 	tlb_write_indexed();
-#endif
 	tlbw_use_hazard();
 	write_c0_entryhi(old_ctx);
 	EXIT_CRITICAL(flags);
@@ -173,7 +124,6 @@ void *kmap_coherent(struct page *page, unsigned long addr)
 
 void kunmap_coherent(void)
 {
-#ifndef CONFIG_MIPS_MT_SMTC
 	unsigned int wired;
 	unsigned long flags, old_ctx;
 
@@ -190,7 +140,6 @@ void kunmap_coherent(void)
 	tlbw_use_hazard();
 	write_c0_entryhi(old_ctx);
 	EXIT_CRITICAL(flags);
-#endif
 	pagefault_enable();
 }
 
@@ -256,7 +205,7 @@ EXPORT_SYMBOL_GPL(copy_from_user_page);
 void __init fixrange_init(unsigned long start, unsigned long end,
 	pgd_t *pgd_base)
 {
-#if defined(CONFIG_HIGHMEM) || defined(CONFIG_MIPS_MT_SMTC)
+#ifdef CONFIG_HIGHMEM
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
@@ -327,7 +276,6 @@ void __init paging_init(void)
 #ifdef CONFIG_HIGHMEM
 	kmap_init();
 #endif
-	kmap_coherent_init();
 
 #ifdef CONFIG_ZONE_DMA
 	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index eeaf50f..57374f0 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -25,28 +25,9 @@
 
 extern void build_tlb_refill_handler(void);
 
-/* Atomicity and interruptability */
-#ifdef CONFIG_MIPS_MT_SMTC
-
-#include <asm/smtc.h>
-#include <asm/mipsmtregs.h>
-
-#define ENTER_CRITICAL(flags) \
-	{ \
-	unsigned int mvpflags; \
-	local_irq_save(flags);\
-	mvpflags = dvpe()
-#define EXIT_CRITICAL(flags) \
-	evpe(mvpflags); \
-	local_irq_restore(flags); \
-	}
-#else
-
 #define ENTER_CRITICAL(flags) local_irq_save(flags)
 #define EXIT_CRITICAL(flags) local_irq_restore(flags)
 
-#endif /* CONFIG_MIPS_MT_SMTC */
-
 /*
  * LOONGSON2/3 has a 4 entry itlb which is a subset of dtlb,
  * unfortunately, itlb is not totally transparent to software.
diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
index eae0ba3..a851601 100644
--- a/arch/mips/mti-malta/Makefile
+++ b/arch/mips/mti-malta/Makefile
@@ -8,6 +8,3 @@
 obj-y				:= malta-amon.o malta-display.o malta-init.o \
 				   malta-int.o malta-memory.o malta-platform.o \
 				   malta-reset.o malta-setup.o malta-time.o
-
-# FIXME FIXME FIXME
-obj-$(CONFIG_MIPS_MT_SMTC)	+= malta-smtc.o
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index 4f9e44d..2985536 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -116,8 +116,6 @@ phys_t mips_cpc_default_phys_base(void)
 	return CPC_BASE_ADDR;
 }
 
-extern struct plat_smp_ops msmtc_smp_ops;
-
 void __init prom_init(void)
 {
 	mips_display_message("LINUX");
@@ -305,7 +303,4 @@ mips_pci_controller:
 	if (!register_vsmp_smp_ops())
 		return;
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	register_smp_ops(&msmtc_smp_ops);
-#endif
 }
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index b71ee80..ecc2785 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -504,28 +504,9 @@ void __init arch_init_irq(void)
 	} else if (cpu_has_vint) {
 		set_vi_handler(MIPSCPU_INT_I8259A, malta_hw0_irqdispatch);
 		set_vi_handler(MIPSCPU_INT_COREHI, corehi_irqdispatch);
-#ifdef CONFIG_MIPS_MT_SMTC
-		setup_irq_smtc(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_I8259A, &i8259irq,
-			(0x100 << MIPSCPU_INT_I8259A));
-		setup_irq_smtc(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_COREHI,
-			&corehi_irqaction, (0x100 << MIPSCPU_INT_COREHI));
-		/*
-		 * Temporary hack to ensure that the subsidiary device
-		 * interrupts coing in via the i8259A, but associated
-		 * with low IRQ numbers, will restore the Status.IM
-		 * value associated with the i8259A.
-		 */
-		{
-			int i;
-
-			for (i = 0; i < 16; i++)
-				irq_hwmask[i] = (0x100 << MIPSCPU_INT_I8259A);
-		}
-#else /* Not SMTC */
 		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_I8259A, &i8259irq);
 		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_COREHI,
 						&corehi_irqaction);
-#endif /* CONFIG_MIPS_MT_SMTC */
 	} else {
 		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_I8259A, &i8259irq);
 		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_COREHI,
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index bf62151..db7c9e5 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -77,11 +77,7 @@ const char *get_system_type(void)
 	return "MIPS Malta";
 }
 
-#if defined(CONFIG_MIPS_MT_SMTC)
-const char display_string[] = "	      SMTC LINUX ON MALTA	";
-#else
 const char display_string[] = "	       LINUX ON MALTA	    ";
-#endif /* CONFIG_MIPS_MT_SMTC */
 
 #ifdef CONFIG_BLK_DEV_FD
 static void __init fd_activate(void)
diff --git a/arch/mips/mti-malta/malta-smtc.c b/arch/mips/mti-malta/malta-smtc.c
deleted file mode 100644
index c484990..0000000
diff --git a/arch/mips/pmcs-msp71xx/Makefile b/arch/mips/pmcs-msp71xx/Makefile
index 9201c8b..d4f7220 100644
--- a/arch/mips/pmcs-msp71xx/Makefile
+++ b/arch/mips/pmcs-msp71xx/Makefile
@@ -10,4 +10,3 @@ obj-$(CONFIG_PCI) += msp_pci.o
 obj-$(CONFIG_MSP_HAS_MAC) += msp_eth.o
 obj-$(CONFIG_MSP_HAS_USB) += msp_usb.o
 obj-$(CONFIG_MIPS_MT_SMP) += msp_smp.o
-obj-$(CONFIG_MIPS_MT_SMTC) += msp_smtc.o
diff --git a/arch/mips/pmcs-msp71xx/msp_irq.c b/arch/mips/pmcs-msp71xx/msp_irq.c
index 9da5619..85fb529 100644
--- a/arch/mips/pmcs-msp71xx/msp_irq.c
+++ b/arch/mips/pmcs-msp71xx/msp_irq.c
@@ -32,7 +32,7 @@ extern void msp_vsmp_int_init(void);
 
 /* vectored interrupt implementation */
 
-/* SW0/1 interrupts are used for SMP/SMTC */
+/* SW0/1 interrupts are used for SMP */
 static inline void mac0_int_dispatch(void) { do_IRQ(MSP_INT_MAC0); }
 static inline void mac1_int_dispatch(void) { do_IRQ(MSP_INT_MAC1); }
 static inline void mac2_int_dispatch(void) { do_IRQ(MSP_INT_SAR); }
@@ -138,14 +138,6 @@ void __init arch_init_irq(void)
 	set_vi_handler(MSP_INT_SEC, sec_int_dispatch);
 #ifdef CONFIG_MIPS_MT_SMP
 	msp_vsmp_int_init();
-#elif defined CONFIG_MIPS_MT_SMTC
-	/*Set hwmask for all platform devices */
-	irq_hwmask[MSP_INT_MAC0] = C_IRQ0;
-	irq_hwmask[MSP_INT_MAC1] = C_IRQ1;
-	irq_hwmask[MSP_INT_USB] = C_IRQ2;
-	irq_hwmask[MSP_INT_SAR] = C_IRQ3;
-	irq_hwmask[MSP_INT_SEC] = C_IRQ5;
-
 #endif	/* CONFIG_MIPS_MT_SMP */
 #endif	/* CONFIG_MIPS_MT */
 	/* setup the cascaded interrupts */
@@ -154,7 +146,7 @@ void __init arch_init_irq(void)
 
 #else
 	/* setup the 2nd-level SLP register based interrupt controller */
-	/* VSMP /SMTC support support is not enabled for SLP */
+	/* VSMP support support is not enabled for SLP */
 	msp_slp_irq_init();
 
 	/* setup the cascaded SLP/PER interrupts */
diff --git a/arch/mips/pmcs-msp71xx/msp_irq_cic.c b/arch/mips/pmcs-msp71xx/msp_irq_cic.c
index e49b499..c95c1bff 100644
--- a/arch/mips/pmcs-msp71xx/msp_irq_cic.c
+++ b/arch/mips/pmcs-msp71xx/msp_irq_cic.c
@@ -120,10 +120,9 @@ static void msp_cic_irq_ack(struct irq_data *d)
 	* hurt for the others
 	*/
 	*CIC_STS_REG = (1 << (d->irq - MSP_CIC_INTBASE));
-	smtc_im_ack_irq(d->irq);
 }
 
-/*Note: Limiting to VSMP . Not tested in SMTC */
+/* Note: Limiting to VSMP . */
 
 #ifdef CONFIG_MIPS_MT_SMP
 static int msp_cic_irq_set_affinity(struct irq_data *d,
@@ -180,14 +179,9 @@ void __init msp_cic_irq_init(void)
 	*CIC_EXT_CFG_REG &= 0xFFFF8F8F;
 
 	/* initialize all the IRQ descriptors */
-	for (i = MSP_CIC_INTBASE ; i < MSP_CIC_INTBASE + 32 ; i++) {
+	for (i = MSP_CIC_INTBASE ; i < MSP_CIC_INTBASE + 32 ; i++)
 		irq_set_chip_and_handler(i, &msp_cic_irq_controller,
 					 handle_level_irq);
-#ifdef CONFIG_MIPS_MT_SMTC
-		/* Mask of CIC interrupt */
-		irq_hwmask[i] = C_IRQ4;
-#endif
-	}
 
 	/* Initialize the PER interrupt sub-system */
 	 msp_per_irq_init();
diff --git a/arch/mips/pmcs-msp71xx/msp_irq_per.c b/arch/mips/pmcs-msp71xx/msp_irq_per.c
index d1fd530..2ab8e80 100644
--- a/arch/mips/pmcs-msp71xx/msp_irq_per.c
+++ b/arch/mips/pmcs-msp71xx/msp_irq_per.c
@@ -111,12 +111,8 @@ void __init msp_per_irq_init(void)
 	*PER_INT_MSK_REG  = 0x00000000;
 	*PER_INT_STS_REG  = 0xFFFFFFFF;
 	/* initialize all the IRQ descriptors */
-	for (i = MSP_PER_INTBASE; i < MSP_PER_INTBASE + 32; i++) {
+	for (i = MSP_PER_INTBASE; i < MSP_PER_INTBASE + 32; i++)
 		irq_set_chip(i, &msp_per_irq_controller);
-#ifdef CONFIG_MIPS_MT_SMTC
-		irq_hwmask[i] = C_IRQ4;
-#endif
-	}
 }
 
 void msp_per_irq_dispatch(void)
diff --git a/arch/mips/pmcs-msp71xx/msp_setup.c b/arch/mips/pmcs-msp71xx/msp_setup.c
index 7e98076..0da91cd 100644
--- a/arch/mips/pmcs-msp71xx/msp_setup.c
+++ b/arch/mips/pmcs-msp71xx/msp_setup.c
@@ -148,8 +148,6 @@ void __init plat_mem_setup(void)
 	pm_power_off = msp_power_off;
 }
 
-extern struct plat_smp_ops msp_smtc_smp_ops;
-
 void __init prom_init(void)
 {
 	unsigned long family;
@@ -230,12 +228,6 @@ void __init prom_init(void)
 	 */
 	msp_serial_setup();
 
-	if (register_vsmp_smp_ops()) {
-#ifdef CONFIG_MIPS_MT_SMTC
-		register_smp_ops(&msp_smtc_smp_ops);
-#endif
-	}
-
 #ifdef CONFIG_PMCTWILED
 	/*
 	 * Setup LED states before the subsys_initcall loads other
diff --git a/arch/mips/pmcs-msp71xx/msp_smtc.c b/arch/mips/pmcs-msp71xx/msp_smtc.c
deleted file mode 100644
index 6b5607f..0000000
-- 
1.9.1
