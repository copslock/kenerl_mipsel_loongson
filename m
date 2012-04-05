Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Apr 2012 21:01:00 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:33565 "EHLO
        guruplug.inter.net" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1904016Ab2DETAq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Apr 2012 21:00:46 +0200
Received: from solomon.inter.net ([10.0.0.2])
        by guruplug.inter.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SFrvB-0002Hn-8R; Thu, 05 Apr 2012 14:00:37 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, sjhill@realitydiluted.com
Subject: [PATCH] Update core files for the MALTA platform.
Date:   Thu,  5 Apr 2012 14:00:24 -0500
Message-Id: <1333652424-9298-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
X-archive-position: 32861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

fad
fadsfdassadfdfa

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/Kconfig                                  |   34 +-
 arch/mips/include/asm/cpu.h                        |    3 +-
 arch/mips/include/asm/gic.h                        |   15 +-
 arch/mips/include/asm/irq.h                        |    1 +
 arch/mips/include/asm/mach-generic/dma-coherence.h |    4 +-
 arch/mips/include/asm/mips-boards/maltaint.h       |   10 +
 arch/mips/include/asm/mips_mt.h                    |    1 +
 arch/mips/include/asm/topology.h                   |    3 +
 arch/mips/include/asm/vpe.h                        |   30 +-
 arch/mips/kernel/cpu-probe.c                       |    5 +
 arch/mips/kernel/rtlx.c                            |   21 +-
 arch/mips/kernel/smp-mt.c                          |   39 +-
 arch/mips/kernel/spram.c                           |    1 +
 arch/mips/kernel/syscall.c                         |    5 +-
 arch/mips/kernel/vpe.c                             |  844 ++++++++++++++++++--
 arch/mips/mm/c-r4k.c                               |   49 +-
 arch/mips/mm/dma-default.c                         |    8 +-
 arch/mips/mti-malta/malta-memory.c                 |    2 +-
 arch/mips/mti-malta/malta-pci.c                    |    5 +-
 arch/mips/mti-malta/malta-setup.c                  |  113 +++
 arch/mips/oprofile/common.c                        |    1 +
 arch/mips/oprofile/op_model_mipsxx.c               |    7 +-
 22 files changed, 1048 insertions(+), 153 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index edbbae1..0c7fb5d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1862,14 +1862,14 @@ config MIPS_MT_SMP
 	select SYS_SUPPORTS_SMP
 	select SMP_UP
 	help
-	  This is a kernel model which is known a VSMP but lately has been
-	  marketesed into SMVP.
-	  Virtual SMP uses the processor's VPEs  to implement virtual
-	  processors. In currently available configuration of the 34K processor
-	  this allows for a dual processor. Both processors will share the same
-	  primary caches; each will obtain the half of the TLB for it's own
-	  exclusive use. For a layman this model can be described as similar to
-	  what Intel calls Hyperthreading.
+	  Virtual SMP uses the processor's VPEs to implement virtual
+	  processors. In currently available configurations of the 34K
+	  processor this allows for a dual processor. Both processors will
+	  share the same primary caches and each will obtain the half of
+	  the TLB for its own exclusive use. For a layman this model can
+	  be described as similar to what Intel calls Hyperthreading. At
+	  some point MIPS marketing decided to renamed to SMVP but the
+	  renaming hasn't caught on as of yet. 
 
 	  For further information see http://www.linux-mips.org/wiki/34K#VSMP
 
@@ -1886,14 +1886,16 @@ config MIPS_MT_SMTC
 	select SYS_SUPPORTS_SMP
 	select SMP_UP
 	help
-	  This is a kernel model which is known a SMTC or lately has been
-	  marketesed into SMVP.
-	  is presenting the available TC's of the core as processors to Linux.
-	  On currently available 34K processors this means a Linux system will
-	  see up to 5 processors. The implementation of the SMTC kernel differs
-	  significantly from VSMP and cannot efficiently coexist in the same
-	  kernel binary so the choice between VSMP and SMTC is a compile time
-	  decision.
+	  SMTC is presenting the available TCs of the core as processors to
+	  Linux. On currently available 34K processors this means a Linux
+	  system will see up to 5 processors. The implementation of the SMTC
+	  kernel differs significantly from VSMP. It was found that SMTC cannot
+	  efficiently coexist in the same kernel binary with other modes of
+	  multiprocessor support, so enabling SMTC is a compile time decision.
+	  The choice between VSMP and SMTC is a bit delicate as it is affected
+	  by clockspeed, memory speed, the specific workload and other factors.
+	  As such the choice should not be made on an evaluation board such as
+	  the Malta but preferably on final target hardware.
 
 	  For further information see http://www.linux-mips.org/wiki/34K#SMTC
 
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index f9fa2a4..ddd8b4a 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -94,6 +94,7 @@
 #define PRID_IMP_24KE		0x9600
 #define PRID_IMP_74K		0x9700
 #define PRID_IMP_1004K		0x9900
+#define PRID_IMP_1074K		0x9a00
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_SIBYTE
@@ -260,7 +261,7 @@ enum cpu_type_enum {
 	 */
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
 	CPU_ALCHEMY, CPU_PR4450, CPU_BMIPS32, CPU_BMIPS3300, CPU_BMIPS4350,
-	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC,
+	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_1074K,
 
 	/*
 	 * MIPS64 class processors
diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 86548da..991b659 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -206,7 +206,7 @@
 
 #define GIC_VPE_EIC_SHADOW_SET_BASE	0x0100
 #define GIC_VPE_EIC_SS(intr) \
-	(GIC_EIC_SHADOW_SET_BASE + (4 * intr))
+	(GIC_VPE_EIC_SHADOW_SET_BASE + (4 * intr))
 
 #define GIC_VPE_EIC_VEC_BASE		0x0800
 #define GIC_VPE_EIC_VEC(intr) \
@@ -330,6 +330,17 @@ struct gic_intr_map {
 #define GIC_FLAG_TRANSPARENT   0x02
 };
 
+/*
+ * This is only used in EIC mode. This helps to figure out which
+ * shared interrupts we need to process when we get a vector interrupt.
+ */
+#define GIC_MAX_SHARED_INTR  0x5
+struct gic_shared_intr_map {
+	unsigned int num_shared_intr;
+	unsigned int intr_list[GIC_MAX_SHARED_INTR];
+	unsigned int local_intr_mask;
+};
+
 extern void gic_init(unsigned long gic_base_addr,
 	unsigned long gic_addrspace_size, struct gic_intr_map *intrmap,
 	unsigned int intrmap_size, unsigned int irqbase);
@@ -338,5 +349,7 @@ extern unsigned int gic_get_int(void);
 extern void gic_send_ipi(unsigned int intr);
 extern unsigned int plat_ipi_call_int_xlate(unsigned int);
 extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
+extern void gic_bind_eic_interrupt(int irq, int set);
+extern unsigned int gic_get_timer_pending(void);
 
 #endif /* _ASM_GICREGS_H */
diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index fb698dc..78dbb8a 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -136,6 +136,7 @@ extern void free_irqno(unsigned int irq);
  * IE7.  Since R2 their number has to be read from the c0_intctl register.
  */
 #define CP0_LEGACY_COMPARE_IRQ 7
+#define CP0_LEGACY_PERFCNT_IRQ 7
 
 extern int cp0_compare_irq;
 extern int cp0_compare_irq_shift;
diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index 9c95177..9f1cd31 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -63,7 +63,9 @@ static inline int plat_device_is_coherent(struct device *dev)
 	return 1;
 #endif
 #ifdef CONFIG_DMA_NONCOHERENT
-	return 0;
+	extern int coherentio;
+
+	return coherentio;
 #endif
 }
 
diff --git a/arch/mips/include/asm/mips-boards/maltaint.h b/arch/mips/include/asm/mips-boards/maltaint.h
index d11aa02..5447d9f 100644
--- a/arch/mips/include/asm/mips-boards/maltaint.h
+++ b/arch/mips/include/asm/mips-boards/maltaint.h
@@ -86,6 +86,16 @@
 #define GIC_CPU_INT4		4 /* .			*/
 #define GIC_CPU_INT5		5 /* Core Interrupt 5   */
 
+/* MALTA GIC local interrupts */
+#define GIC_INT_TMR             (GIC_CPU_INT5)
+#define GIC_INT_PERFCTR         (GIC_CPU_INT5)
+
+/* GIC constants */
+/* Add 2 to convert non-eic hw int # to eic vector # */
+#define GIC_CPU_TO_VEC_OFFSET   (2)
+/* If we map an intr to pin X, GIC will actually generate vector X+1 */
+#define GIC_PIN_TO_VEC_OFFSET   (1)
+
 #define GIC_EXT_INTR(x)		x
 
 /* External Interrupts used for IPI */
diff --git a/arch/mips/include/asm/mips_mt.h b/arch/mips/include/asm/mips_mt.h
index ac79352..3177c83 100644
--- a/arch/mips/include/asm/mips_mt.h
+++ b/arch/mips/include/asm/mips_mt.h
@@ -19,6 +19,7 @@ extern unsigned long mt_fpemul_threshold;
 
 extern void mips_mt_regdump(unsigned long previous_mvpcontrol_value);
 extern void mips_mt_set_cpuoptions(void);
+extern void cmp_send_ipi_single(int cpu, unsigned int action);
 
 struct class;
 extern struct class *mt_class;
diff --git a/arch/mips/include/asm/topology.h b/arch/mips/include/asm/topology.h
index 259145e..709e78a 100644
--- a/arch/mips/include/asm/topology.h
+++ b/arch/mips/include/asm/topology.h
@@ -12,6 +12,9 @@
 
 #ifdef CONFIG_SMP
 #define smt_capable()   (smp_num_siblings > 1)
+/* FIXME: cpu_sibling_map is not a per_cpu variable */
+/*#define topology_thread_cpumask(cpu)    (&per_cpu(cpu_sibling_map, cpu)) */
+#define topology_thread_cpumask(cpu)    (&cpu_sibling_map[cpu])
 #endif
 
 #endif /* __ASM_TOPOLOGY_H */
diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
index c6e1b96..e5e4033 100644
--- a/arch/mips/include/asm/vpe.h
+++ b/arch/mips/include/asm/vpe.h
@@ -26,12 +26,40 @@ struct vpe_notifications {
 	struct list_head list;
 };
 
-
+extern unsigned long physical_memsize;
 extern int vpe_notify(int index, struct vpe_notifications *notify);
+extern void save_gp_address(unsigned int secbase, unsigned int rel);
+
+/*
+ * libc style I/O support hooks
+ */
 
 extern void *vpe_get_shared(int index);
 extern int vpe_getuid(int index);
 extern int vpe_getgid(int index);
 extern char *vpe_getcwd(int index);
 
+/*
+ * Kernel/Kernel message passing support hooks
+ */
+
+extern void *vpe_get_shared_area(int index, int type);
+
+/* "Well-Known" Area Types */
+
+#define VPE_SHARED_NULL 0
+#define VPE_SHARED_RESERVED -1
+
+struct vpe_shared_area {
+	int type;
+	void *addr;
+};
+
+/*
+ * IRQ assignment and initialization hook for RP services.
+ */
+
+int arch_get_xcpu_irq(void);
+
+int vpe_send_interrupt(int v, int i);
 #endif /* _ASM_VPE_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 5099201..cb1e2e9 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -207,6 +207,7 @@ void __init check_wait(void)
 			cpu_wait = r4k_wait_irqoff;
 		break;
 
+	case CPU_1074K:
 	case CPU_74K:
 		cpu_wait = r4k_wait;
 		if ((c->processor_id & 0xff) >= PRID_REV_ENCODE_332(2, 1, 0))
@@ -835,6 +836,10 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_1004K;
 		__cpu_name[cpu] = "MIPS 1004Kc";
 		break;
+	case PRID_IMP_1074K:
+		c->cputype = CPU_1074K;
+		__cpu_name[cpu] = "MIPS 1074Kc";
+		break;
 	}
 
 	spram_config();
diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index b8c18dc..25278d0 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -57,12 +57,6 @@ static int sp_stopping;
 
 extern void *vpe_get_shared(int index);
 
-static void rtlx_dispatch(void)
-{
-	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ);
-}
-
-
 /* Interrupt handler may be called before rtlx_init has otherwise had
    a chance to run.
 */
@@ -483,7 +477,7 @@ static char register_chrdev_failed[] __initdata =
 static int __init rtlx_module_init(void)
 {
 	struct device *dev;
-	int i, err;
+	int i, err, irq;
 
 	if (!cpu_has_mipsmt) {
 		printk("VPE loader: not a MIPS MT capable processor\n");
@@ -523,18 +517,17 @@ static int __init rtlx_module_init(void)
 	notify.start = starting;
 	notify.stop = stopping;
 	vpe_notify(tclimit, &notify);
-
-	if (cpu_has_vint)
-		set_vi_handler(MIPS_CPU_RTLX_IRQ, rtlx_dispatch);
-	else {
+	irq = arch_get_xcpu_irq();
+	if (irq < 0) {
 		pr_err("APRP RTLX init on non-vectored-interrupt processor\n");
 		err = -ENODEV;
 		goto out_chrdev;
 	}
 
-	rtlx_irq.dev_id = rtlx;
-	setup_irq(rtlx_irq_num, &rtlx_irq);
-
+	err = request_irq(irq, &rtlx_interrupt, IRQF_SHARED,
+		module_name, (void *)dev);
+	if (err)
+		goto out_chrdev;
 	return 0;
 
 out_chrdev:
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index ff17868..4f54cea 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -34,7 +34,9 @@
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
 #include <asm/mips_mt.h>
+#include <asm/gic.h>
 
+extern int gic_present;
 static void __init smvp_copy_vpe_config(void)
 {
 	write_vpe_c0_status(
@@ -111,12 +113,35 @@ static void __init smvp_tc_init(unsigned int tc, unsigned int mvpconf0)
 	write_tc_c0_tchalt(TCHALT_H);
 }
 
+static void mp_send_ipi_single(int cpu, unsigned int action)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	switch (action) {
+	case SMP_CALL_FUNCTION:
+		gic_send_ipi(plat_ipi_call_int_xlate(cpu));
+		break;
+
+	case SMP_RESCHEDULE_YOURSELF:
+		gic_send_ipi(plat_ipi_resched_int_xlate(cpu));
+		break;
+	}
+
+	local_irq_restore(flags);
+}
+
 static void vsmp_send_ipi_single(int cpu, unsigned int action)
 {
 	int i;
 	unsigned long flags;
 	int vpflags;
 
+	if (gic_present) {
+		mp_send_ipi_single(cpu, action);
+		return;
+	}
 	local_irq_save(flags);
 
 	vpflags = dvpe();	/* can't access the other CPU's registers whilst MVPE enabled */
@@ -150,9 +175,8 @@ static void vsmp_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 
 static void __cpuinit vsmp_init_secondary(void)
 {
-	extern int gic_present;
-
-	/* This is Malta specific: IPI,performance and timer interrupts */
+	pr_debug("SMPMT: CPU%d: vsmp_init_secondary\n", smp_processor_id());
+	/* This is Malta specific: IPI,performance and timer inetrrupts */
 	if (gic_present)
 		change_c0_status(ST0_IM, STATUSF_IP3 | STATUSF_IP4 |
 					 STATUSF_IP6 | STATUSF_IP7);
@@ -163,6 +187,8 @@ static void __cpuinit vsmp_init_secondary(void)
 
 static void __cpuinit vsmp_smp_finish(void)
 {
+	pr_debug("SMPMT: CPU%d: vsmp_smp_finish\n", smp_processor_id());
+
 	/* CDFIXME: remove this? */
 	write_c0_compare(read_c0_count() + (8* mips_hpt_frequency/HZ));
 
@@ -177,6 +203,7 @@ static void __cpuinit vsmp_smp_finish(void)
 
 static void vsmp_cpus_done(void)
 {
+	pr_debug("SMPMT: CPU%d: vsmp_cpus_done\n", smp_processor_id());
 }
 
 /*
@@ -190,6 +217,8 @@ static void vsmp_cpus_done(void)
 static void __cpuinit vsmp_boot_secondary(int cpu, struct task_struct *idle)
 {
 	struct thread_info *gp = task_thread_info(idle);
+	pr_debug("SMPMT: CPU%d: vsmp_boot_secondary cpu %d\n",
+		smp_processor_id(), cpu);
 	dvpe();
 	set_c0_mvpcontrol(MVPCONTROL_VPC);
 
@@ -231,6 +260,7 @@ static void __init vsmp_smp_setup(void)
 	unsigned int mvpconf0, ntc, tc, ncpu = 0;
 	unsigned int nvpe;
 
+	pr_debug("SMPMT: CPU%d: vsmp_smp_setup\n", smp_processor_id());
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
 	if (cpu_has_fpu)
@@ -260,6 +290,7 @@ static void __init vsmp_smp_setup(void)
 		smvp_tc_init(tc, mvpconf0);
 		ncpu = smvp_vpe_init(tc, mvpconf0, ncpu);
 	}
+	cpu_present_map = cpu_possible_map;
 
 	/* Release config state */
 	clear_c0_mvpcontrol(MVPCONTROL_VPC);
@@ -271,6 +302,8 @@ static void __init vsmp_smp_setup(void)
 
 static void __init vsmp_prepare_cpus(unsigned int max_cpus)
 {
+	pr_debug("SMPMT: CPU%d: vsmp_prepare_cpus %d\n",
+		smp_processor_id(), max_cpus);
 	mips_mt_set_cpuoptions();
 }
 
diff --git a/arch/mips/kernel/spram.c b/arch/mips/kernel/spram.c
index 6af08d8..5781dbf 100644
--- a/arch/mips/kernel/spram.c
+++ b/arch/mips/kernel/spram.c
@@ -205,6 +205,7 @@ void __cpuinit spram_config(void)
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_74K:
+	case CPU_1074K:
 	case CPU_1004K:
 		config0 = read_c0_config();
 		/* FIXME: addresses are Malta specific */
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index b08220c..bacd9bf 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -124,7 +124,7 @@ _sys_clone(nabi_no_regargs struct pt_regs regs)
 	child_tidptr = (int __user *) regs.regs[8];
 #endif
 	return do_fork(clone_flags, newsp, &regs, 0,
-	               parent_tidptr, child_tidptr);
+		       parent_tidptr, child_tidptr);
 }
 
 /*
@@ -264,11 +264,12 @@ save_static_function(sys_sysmips);
 static int __used noinline
 _sys_sysmips(nabi_no_regargs struct pt_regs regs)
 {
-	long cmd, arg1, arg2;
+	long cmd, arg1, arg2, arg3;
 
 	cmd = regs.regs[4];
 	arg1 = regs.regs[5];
 	arg2 = regs.regs[6];
+	arg3 = regs.regs[7];
 
 	switch (cmd) {
 	case MIPS_ATOMIC_SET:
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index f6f9152..e8c99a4 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -73,17 +73,14 @@ static const int minor = 1;	/* fixed for now  */
 static struct kspd_notifications kspd_events;
 static int kspd_events_reqd;
 #endif
-
-/* grab the likely amount of memory we will need. */
-#ifdef CONFIG_MIPS_VPE_LOADER_TOM
-#define P_SIZE (2 * 1024 * 1024)
-#else
-/* add an overhead to the max kmalloc size for non-striped symbols/etc */
+/*
+ * Size of private kernel buffer for ELF headers and sections
+ */
 #define P_SIZE (256 * 1024)
-#endif
-
-extern unsigned long physical_memsize;
 
+/*
+ * Size of private kernel buffer for ELF headers and sections
+ */
 #define MAX_VPES 16
 #define VPE_PATH_MAX 256
 
@@ -100,6 +97,16 @@ enum tc_state {
 	TC_STATE_DYNAMIC
 };
 
+enum load_state {
+	LOAD_STATE_EHDR,
+	LOAD_STATE_PHDR,
+	LOAD_STATE_SHDR,
+	LOAD_STATE_PIMAGE,
+	LOAD_STATE_TRAILER,
+	LOAD_STATE_DONE,
+	LOAD_STATE_ERROR
+};
+
 struct vpe {
 	enum vpe_state state;
 
@@ -107,10 +114,25 @@ struct vpe {
 	int minor;
 
 	/* elfloader stuff */
+	unsigned long offset; /* File offset into input stream */
 	void *load_addr;
-	unsigned long len;
+	unsigned long copied;
 	char *pbuffer;
-	unsigned long plen;
+	unsigned long pbsize;
+	/* Program loading state */
+	enum load_state l_state;
+	Elf_Ehdr *l_ehdr;
+	struct elf_phdr *l_phdr;
+	unsigned int l_phlen;
+	Elf_Shdr *l_shdr;
+	unsigned int l_shlen;
+	int *l_phsort;  /* Sorted index list of program headers */
+	int l_segoff;   /* Offset into current program segment */
+	int l_cur_seg;  /* Indirect index of segment currently being loaded */
+	unsigned int l_progminad;
+	unsigned int l_progmaxad;
+	unsigned int l_trailer;
+
 	unsigned int uid, gid;
 	char cwd[VPE_PATH_MAX];
 
@@ -122,9 +144,12 @@ struct vpe {
 	/* The list of vpe's */
 	struct list_head list;
 
-	/* shared symbol address */
+	/* legacy shared symbol address */
 	void *shared_ptr;
 
+	 /* shared area descriptor array address */
+	struct vpe_shared_area *shared_areas;
+
 	/* the list of who wants to know when something major happens */
 	struct list_head notify;
 
@@ -146,13 +171,24 @@ struct {
 	spinlock_t tc_list_lock;
 	struct list_head tc_list;	/* Thread contexts */
 } vpecontrol = {
-	.vpe_list_lock	= __SPIN_LOCK_UNLOCKED(vpe_list_lock),
+	.vpe_list_lock	= SPIN_LOCK_UNLOCKED,
 	.vpe_list	= LIST_HEAD_INIT(vpecontrol.vpe_list),
-	.tc_list_lock	= __SPIN_LOCK_UNLOCKED(tc_list_lock),
+	.tc_list_lock	= SPIN_LOCK_UNLOCKED,
 	.tc_list	= LIST_HEAD_INIT(vpecontrol.tc_list)
 };
 
 static void release_progmem(void *ptr);
+/*
+ * Values and state associated with publishing shared memory areas
+ */
+
+#define N_PUB_AREAS 4
+
+static struct vpe_shared_area published_vpe_area[N_PUB_AREAS] = {
+	{VPE_SHARED_RESERVED, 0},
+	{VPE_SHARED_RESERVED, 0},
+	{VPE_SHARED_RESERVED, 0},
+	{VPE_SHARED_RESERVED, 0} };
 
 /* get the vpe associated with this minor */
 static struct vpe *get_vpe(int minor)
@@ -175,7 +211,7 @@ static struct vpe *get_vpe(int minor)
 	return res;
 }
 
-/* get the vpe associated with this minor */
+/* get the tc associated with this minor */
 static struct tc *get_tc(int index)
 {
 	struct tc *res, *t;
@@ -200,7 +236,8 @@ static struct vpe *alloc_vpe(int minor)
 
 	if ((v = kzalloc(sizeof(struct vpe), GFP_KERNEL)) == NULL)
 		return NULL;
-
+	printk(KERN_DEBUG "Used kzalloc to allocate %d bytes at %x\n",
+		sizeof(struct vpe), (unsigned int)v);
 	INIT_LIST_HEAD(&v->tc);
 	spin_lock(&vpecontrol.vpe_list_lock);
 	list_add_tail(&v->list, &vpecontrol.vpe_list);
@@ -219,7 +256,8 @@ static struct tc *alloc_tc(int index)
 
 	if ((tc = kzalloc(sizeof(struct tc), GFP_KERNEL)) == NULL)
 		goto out;
-
+	printk(KERN_DEBUG "Used kzalloc to allocate %d bytes at %x\n",
+		sizeof(struct tc), (unsigned int)tc);
 	INIT_LIST_HEAD(&tc->tc);
 	tc->index = index;
 
@@ -237,6 +275,11 @@ static void release_vpe(struct vpe *v)
 	list_del(&v->list);
 	if (v->load_addr)
 		release_progmem(v);
+	printk(KERN_DEBUG "Used kfree to free memory at %x\n",
+		(unsigned int)v->l_phsort);
+	kfree(v->l_phsort);
+	printk(KERN_DEBUG "Used kfree to free memory at %x\n",
+		(unsigned int)v);
 	kfree(v);
 }
 
@@ -260,8 +303,88 @@ static void __maybe_unused dump_mtregs(void)
 	       val & MVPCONF0_PTC, (val & MVPCONF0_M) >> MVPCONF0_M_SHIFT);
 }
 
+/*
+ * The original APRP prototype assumed a single, unshared IRQ for
+ * cross-VPE interrupts, used by the RTLX code.  But M3P networking
+ * and other future functions may need to share an IRQ, particularly
+ * in 34K/Malta configurations without an external interrupt controller.
+ * All cross-VPE insterrupt users need to coordinate through shared
+ * functions here.
+ */
+
+/*
+ * It would be nice if I could just have this initialized to zero,
+ * but the patchcheck police won't hear of it...
+ */
+
+static int xvpe_vector_set;
+
+#define XVPE_INTR_OFFSET 0
+
+static int xvpe_irq = MIPS_CPU_IRQ_BASE + XVPE_INTR_OFFSET;
+
+static void xvpe_dispatch(void)
+{
+	do_IRQ(xvpe_irq);
+}
+
+/* Name here is generic, as m3pnet.c could in principle be used by non-MIPS */
+int arch_get_xcpu_irq()
+{
+	/*
+	 * Some of this will ultimately become platform code,
+	 * but for now, we're only targeting 34K/FPGA/Malta,
+	 * and there's only one generic mechanism.
+	 */
+	if (!xvpe_vector_set) {
+		/*
+		 * A more elaborate shared variable shouldn't be needed.
+		 * Two initializations back-to-back should be harmless.
+		 */
+		if (cpu_has_vint) {
+			set_vi_handler(XVPE_INTR_OFFSET, xvpe_dispatch);
+			xvpe_vector_set = 1;
+		} else {
+			printk(KERN_ERR "APRP requires vectored interrupts\n");
+			return -1;
+		}
+	}
+
+	return xvpe_irq;
+}
+EXPORT_SYMBOL(arch_get_xcpu_irq);
+
+int vpe_send_interrupt(int vpe, int inter)
+{
+	unsigned long flags;
+	unsigned int vpeflags;
+
+	local_irq_save(flags);
+	vpeflags = dvpe();
+
+	/*
+	 * Initial version makes same simple-minded assumption
+	 * as is implicit elsewhere in this module, that the
+	 * only RP of interest is using the first non-Linux TC.
+	 * We ignore the parameters provided by the caller!
+	 */
+	settc(tclimit);
+	/*
+	 * In 34K/Malta, the only cross-VPE interrupts possible
+	 * are done by setting SWINT bits in Cause, of which there
+	 * are two.  SMTC uses SW1 for a multiplexed class of IPIs,
+	 * and this mechanism should be generalized to APRP and use
+	 * the same protocol.  Until that's implemented, send only
+	 * SW0 here, regardless of requested type.
+	 */
+	write_vpe_c0_cause(read_vpe_c0_cause() | C_SW0);
+	evpe(vpeflags);
+	local_irq_restore(flags);
+	return 1;
+}
+EXPORT_SYMBOL(vpe_send_interrupt);
 /* Find some VPE program space  */
-static void *alloc_progmem(unsigned long len)
+static void *alloc_progmem(void *requested, unsigned long len)
 {
 	void *addr;
 
@@ -271,10 +394,28 @@ static void *alloc_progmem(unsigned long len)
 	 * physically have, for example by passing a mem= boot argument.
 	 */
 	addr = pfn_to_kaddr(max_low_pfn);
-	memset(addr, 0, len);
+	if (requested != 0) {
+		if (requested >= addr)
+			addr = requested;
+		else
+			addr = 0;
+	}
+	if (addr != 0)
+		memset(addr, 0, len);
+	printk(KERN_DEBUG "pfn_to_kaddr returns %lu bytes of memory at %x\n",
+	       len, (unsigned int)addr);
 #else
-	/* simple grab some mem for now */
-	addr = kzalloc(len, GFP_KERNEL);
+	if (requested != 0) {
+		/* If we have a target in mind, grab a 2x slice and hope... */
+		addr = kzalloc(len*2, GFP_KERNEL);
+		if ((requested >= addr) && (requested < (addr + len)))
+			addr = requested;
+		else
+			addr = 0;
+	} else {
+		/* simply grab some mem for now */
+		addr = kzalloc(len, GFP_KERNEL);
+	}
 #endif
 
 	return addr;
@@ -446,6 +587,8 @@ static int apply_r_mips_hi16(struct module *me, uint32_t *location,
 	 * actual relocation.
 	 */
 	n = kmalloc(sizeof *n, GFP_KERNEL);
+	printk(KERN_DEBUG "Used kmalloc to allocate %d bytes at %x\n",
+	       sizeof(struct mips_hi16), (unsigned int)n);
 	if (!n)
 		return -ENOMEM;
 
@@ -503,6 +646,8 @@ static int apply_r_mips_lo16(struct module *me, uint32_t *location,
 			*l->addr = insn;
 
 			next = l->next;
+			printk(KERN_DEBUG "Used kfree to free memory at %x\n",
+			       (unsigned int)l);
 			kfree(l);
 			l = next;
 		}
@@ -596,7 +741,7 @@ static int apply_relocations(Elf32_Shdr *sechdrs,
 	return 0;
 }
 
-static inline void save_gp_address(unsigned int secbase, unsigned int rel)
+void save_gp_address(unsigned int secbase, unsigned int rel)
 {
 	gp_addr = secbase + rel;
 	gp_offs = gp_addr - (secbase & 0xffff0000);
@@ -816,16 +961,41 @@ static int find_vpe_symbols(struct vpe * v, Elf_Shdr * sechdrs,
 				      struct module *mod)
 {
 	Elf_Sym *sym = (void *)sechdrs[symindex].sh_addr;
-	unsigned int i, n = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
+	unsigned int i, j, n = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
 
 	for (i = 1; i < n; i++) {
-		if (strcmp(strtab + sym[i].st_name, "__start") == 0) {
-			v->__start = sym[i].st_value;
+	    if (strcmp(strtab + sym[i].st_name, "__start") == 0)
+		v->__start = sym[i].st_value;
+
+	    if (strcmp(strtab + sym[i].st_name, "vpe_shared") == 0)
+		v->shared_ptr = (void *)sym[i].st_value;
+
+	    if (strcmp(strtab + sym[i].st_name, "_vpe_shared_areas") == 0) {
+		struct vpe_shared_area *psa
+		    = (struct vpe_shared_area *)sym[i].st_value;
+		struct vpe_shared_area *tpsa;
+		v->shared_areas = psa;
+		printk(KERN_INFO"_vpe_shared_areas found, 0x%x\n",
+		    (unsigned int)v->shared_areas);
+		/*
+		 * Copy any "published" areas to the descriptor
+		 */
+		for (j = 0; j < N_PUB_AREAS; j++) {
+		    if (published_vpe_area[j].type != VPE_SHARED_RESERVED) {
+			tpsa = psa;
+			while (tpsa->type != VPE_SHARED_NULL) {
+			    if ((tpsa->type == VPE_SHARED_RESERVED)
+			    || (tpsa->type == published_vpe_area[j].type)) {
+				tpsa->type = published_vpe_area[j].type;
+				tpsa->addr = published_vpe_area[j].addr;
+				break;
+			    }
+			    tpsa++;
+			}
+		    }
 		}
+	    }
 
-		if (strcmp(strtab + sym[i].st_name, "vpe_shared") == 0) {
-			v->shared_ptr = (void *)sym[i].st_value;
-		}
 	}
 
 	if ( (v->__start == 0) || (v->shared_ptr == NULL))
@@ -850,14 +1020,12 @@ static int vpe_elfload(struct vpe * v)
 
 	memset(&mod, 0, sizeof(struct module));
 	strcpy(mod.name, "VPE loader");
-
-	hdr = (Elf_Ehdr *) v->pbuffer;
-	len = v->plen;
+	hdr = v->l_ehdr;
+	len = v->pbsize;
 
 	/* Sanity checks against insmoding binaries or wrong arch,
 	   weird elf version */
-	if (memcmp(hdr->e_ident, ELFMAG, SELFMAG) != 0
-	    || (hdr->e_type != ET_REL && hdr->e_type != ET_EXEC)
+	if ((hdr->e_type != ET_REL && hdr->e_type != ET_EXEC)
 	    || !elf_check_arch(hdr)
 	    || hdr->e_shentsize != sizeof(*sechdrs)) {
 		printk(KERN_WARNING
@@ -869,9 +1037,8 @@ static int vpe_elfload(struct vpe * v)
 	if (hdr->e_type == ET_REL)
 		relocate = 1;
 
-	if (len < hdr->e_shoff + hdr->e_shnum * sizeof(Elf_Shdr)) {
-		printk(KERN_ERR "VPE loader: program length %u truncated\n",
-		       len);
+	if (len < v->l_phlen + v->l_shlen) {
+		printk(KERN_ERR "VPE loader: Headers exceed %u bytes\n", len);
 
 		return -ENOEXEC;
 	}
@@ -905,9 +1072,13 @@ static int vpe_elfload(struct vpe * v)
 			}
 		}
 		layout_sections(&mod, hdr, sechdrs, secstrings);
+		/*
+		 * Non-relocatable loads should have already done their
+		 * allocates, based on program header table.
+		 */
 	}
 
-	v->load_addr = alloc_progmem(mod.core_size);
+	memset(v->load_addr, 0, mod.core_size);
 	if (!v->load_addr)
 		return -ENOMEM;
 
@@ -960,19 +1131,10 @@ static int vpe_elfload(struct vpe * v)
 
   		}
   	} else {
-		struct elf_phdr *phdr = (struct elf_phdr *) ((char *)hdr + hdr->e_phoff);
-
-		for (i = 0; i < hdr->e_phnum; i++) {
-			if (phdr->p_type == PT_LOAD) {
-				memcpy((void *)phdr->p_paddr,
-				       (char *)hdr + phdr->p_offset,
-				       phdr->p_filesz);
-				memset((void *)phdr->p_paddr + phdr->p_filesz,
-				       0, phdr->p_memsz - phdr->p_filesz);
-		    }
-		    phdr++;
-		}
 
+		/*
+		 * Program image is already in memory.
+		 */
 		for (i = 0; i < hdr->e_shnum; i++) {
  			/* Internal symbols and strings. */
  			if (sechdrs[i].sh_type == SHT_SYMTAB) {
@@ -989,7 +1151,7 @@ static int vpe_elfload(struct vpe * v)
 
 	/* make sure it's physically written out */
 	flush_icache_range((unsigned long)v->load_addr,
-			   (unsigned long)v->load_addr + v->len);
+			   (unsigned long)v->load_addr + v->copied);
 
 	if ((find_vpe_symbols(v, sechdrs, symindex, strtab, &mod)) < 0) {
 		if (v->__start == 0) {
@@ -1003,8 +1165,8 @@ static int vpe_elfload(struct vpe * v)
 			       "program does not contain vpe_shared symbol.\n"
 			       " Unable to use AMVP (AP/SP) facilities.\n");
 	}
+	pr_info("APRP VPE loader: elf loaded\n");
 
-	printk(" elf loaded\n");
 	return 0;
 }
 
@@ -1069,6 +1231,10 @@ static int vpe_open(struct inode *inode, struct file *filp)
 
 		return -ENODEV;
 	}
+	/*
+	 * This treats the tclimit command line configuration input
+	 * as a minor device indication, which is probably unwholesome.
+	 */
 
 	if ((v = get_vpe(tclimit)) == NULL) {
 		pr_warning("VPE loader: unable to get vpe\n");
@@ -1085,18 +1251,20 @@ static int vpe_open(struct inode *inode, struct file *filp)
 		}
 
 		release_progmem(v->load_addr);
+		kfree(v->l_phsort);
 		cleanup_tc(get_tc(tclimit));
 	}
 
 	/* this of-course trashes what was there before... */
 	v->pbuffer = vmalloc(P_SIZE);
-	if (!v->pbuffer) {
-		pr_warning("VPE loader: unable to allocate memory\n");
-		return -ENOMEM;
-	}
-	v->plen = P_SIZE;
 	v->load_addr = NULL;
-	v->len = 0;
+	v->copied = 0;
+	v->offset = 0;
+	v->l_state = LOAD_STATE_EHDR;
+	v->l_ehdr = NULL;
+	v->l_phdr = NULL;
+	v->l_phsort = NULL;
+	v->l_shdr = NULL;
 
 	v->uid = filp->f_cred->fsuid;
 	v->gid = filp->f_cred->fsgid;
@@ -1115,6 +1283,7 @@ static int vpe_open(struct inode *inode, struct file *filp)
 		printk(KERN_WARNING "VPE loader: open, getcwd returned %d\n", ret);
 
 	v->shared_ptr = NULL;
+	v->shared_areas = NULL;
 	v->__start = 0;
 
 	return 0;
@@ -1123,26 +1292,39 @@ static int vpe_open(struct inode *inode, struct file *filp)
 static int vpe_release(struct inode *inode, struct file *filp)
 {
 	struct vpe *v;
-	Elf_Ehdr *hdr;
 	int ret = 0;
 
 	v = get_vpe(tclimit);
 	if (v == NULL)
 		return -ENODEV;
+	/*
+	 * If image load had no errors, massage program/section tables
+	 * to reflect movement of program/section data into VPE program
+	 * memory.
+	 */
+	if (v->l_state != LOAD_STATE_DONE) {
+		printk(KERN_WARNING "VPE Release after incomplete load\n");
+		printk(KERN_DEBUG "Used vfree to free memory at "
+				  "%x after failed load attempt\n",
+		       (unsigned int)v->pbuffer);
+		if (v->pbuffer != NULL)
+			vfree(v->pbuffer);
+		return -ENOEXEC;
+	}
 
-	hdr = (Elf_Ehdr *) v->pbuffer;
-	if (memcmp(hdr->e_ident, ELFMAG, SELFMAG) == 0) {
-		if (vpe_elfload(v) >= 0) {
-			vpe_run(v);
-		} else {
- 			printk(KERN_WARNING "VPE loader: ELF load failed.\n");
-			ret = -ENOEXEC;
-		}
+	if (vpe_elfload(v) >= 0) {
+		vpe_run(v);
 	} else {
- 		printk(KERN_WARNING "VPE loader: only elf files are supported\n");
+		printk(KERN_WARNING "VPE loader: ELF load failed.\n");
+		printk(KERN_DEBUG "Used vfree to free memory at "
+				  "%x after failed load attempt\n",
+		       (unsigned int)v->pbuffer);
+		if (v->pbuffer != NULL)
+			vfree(v->pbuffer);
 		ret = -ENOEXEC;
 	}
 
+
 	/* It's good to be able to run the SP and if it chokes have a look at
 	   the /dev/rt?. But if we reset the pointer to the shared struct we
 	   lose what has happened. So perhaps if garbage is sent to the vpe
@@ -1151,17 +1333,68 @@ static int vpe_release(struct inode *inode, struct file *filp)
 	if (ret < 0)
 		v->shared_ptr = NULL;
 
-	vfree(v->pbuffer);
-	v->plen = 0;
-
+	// cleanup any temp buffers
+	if (v->pbuffer) {
+		printk(KERN_DEBUG "Used vfree to free memory at %x\n",
+		       (unsigned int)v->pbuffer);
+		vfree(v->pbuffer);
+	}
+	v->pbsize = 0;
 	return ret;
 }
 
+/*
+ * A sort of insertion sort to generate list of program header indices
+ * in order of their file offsets.
+ */
+
+static void indexort(struct elf_phdr *phdr, int nph, int *index)
+{
+	int i, j, t;
+	unsigned int toff;
+
+	/* Create initial mapping */
+	for (i = 0; i < nph; i++)
+		index[i] = i;
+	/* Do the indexed insert sort */
+	for (i = 1; i < nph; i++) {
+		j = i;
+		t = index[j];
+		toff = phdr[t].p_offset;
+		while ((j > 0) && (phdr[index[j-1]].p_offset > toff)) {
+			index[j] = index[j-1];
+			j--;
+		}
+		index[j] = t;
+	}
+}
+
+
+/*
+ * This function has to convert the ELF file image being sequentially
+ * streamed to the pseudo-device into the binary image, symbol, and
+ * string information, which the ELF format allows to be in some degree
+ * of disorder.
+ *
+ * The ELF header and, if present, program header table, are copied into
+ * a temporary buffer.  Loadable program segments, if present, are copied
+ * into the RP program memory at the addresses specified by the program
+ * header table.
+ *
+ * Sections not specified by the program header table are loaded into
+ * memory following the program segments if they are "allocated", or
+ * into the temporary buffer if they are not. The section header
+ * table is loaded into the temporary buffer.???
+ */
+#define CURPHDR (v->l_phdr[v->l_phsort[v->l_cur_seg]])
 static ssize_t vpe_write(struct file *file, const char __user * buffer,
 			 size_t count, loff_t * ppos)
 {
 	size_t ret = count;
 	struct vpe *v;
+	int tocopy, uncopied;
+	int i;
+	unsigned int progmemlen;
 
 	if (iminor(file->f_path.dentry->d_inode) != minor)
 		return -ENODEV;
@@ -1170,17 +1403,357 @@ static ssize_t vpe_write(struct file *file, const char __user * buffer,
 	if (v == NULL)
 		return -ENODEV;
 
-	if ((count + v->len) > v->plen) {
-		printk(KERN_WARNING
-		       "VPE loader: elf size too big. Perhaps strip uneeded symbols\n");
+	if (v->pbuffer == NULL) {
+		printk(KERN_ERR "VPE loader: no buffer for program\n");
 		return -ENOMEM;
 	}
 
-	count -= copy_from_user(v->pbuffer + v->len, buffer, count);
-	if (!count)
-		return -EFAULT;
+	while (count) {
+		switch (v->l_state) {
+		case LOAD_STATE_EHDR:
+			/* Loading ELF Header into scratch buffer */
+			tocopy = min((unsigned long)count,
+				     sizeof(Elf_Ehdr) - v->offset);
+			uncopied = copy_from_user(v->pbuffer + v->copied,
+						  buffer, tocopy);
+			count -= tocopy - uncopied;
+			v->copied += tocopy - uncopied;
+			v->offset += tocopy - uncopied;
+			buffer += tocopy - uncopied;
+			if (v->copied == sizeof(Elf_Ehdr)) {
+			    v->l_ehdr = (Elf_Ehdr *)v->pbuffer;
+			    if (memcmp(v->l_ehdr->e_ident, ELFMAG, 4) != 0) {
+				printk(KERN_WARNING "VPE loader: %s\n",
+					"non-ELF file image");
+				ret = -ENOEXEC;
+				v->l_state = LOAD_STATE_ERROR;
+				break;
+			    }
+			    if (v->l_ehdr->e_phoff != 0) {
+				v->l_phdr = (struct elf_phdr *)
+					(v->pbuffer + v->l_ehdr->e_phoff);
+				v->l_phlen = v->l_ehdr->e_phentsize
+					* v->l_ehdr->e_phnum;
+				/* Check against buffer overflow */
+				if ((v->copied + v->l_phlen) > v->pbsize) {
+					printk(KERN_WARNING
+		       "VPE loader: elf program header table size too big\n");
+					v->l_state = LOAD_STATE_ERROR;
+					return -ENOMEM;
+				}
+				v->l_state = LOAD_STATE_PHDR;
+				/*
+				 * Program headers generally indicate
+				 * linked executable with possibly
+				 * valid entry point.
+				 */
+				v->__start = v->l_ehdr->e_entry;
+			    } else  if (v->l_ehdr->e_shoff != 0) {
+				/*
+				 * No program headers, but a section
+				 * header table.  A relocatable binary.
+				 * We need to load the works into the
+				 * kernel temp buffer to compute the
+				 * RP program image.  That limits our
+				 * binary size, but at least we're no
+				 * worse off than the original APRP
+				 * prototype.
+				 */
+				v->l_shlen = v->l_ehdr->e_shentsize
+					* v->l_ehdr->e_shnum;
+				if ((v->l_ehdr->e_shoff + v->l_shlen
+				     - v->offset) > v->pbsize) {
+					printk(KERN_WARNING
+			 "VPE loader: elf sections/section table too big.\n");
+					v->l_state = LOAD_STATE_ERROR;
+					return -ENOMEM;
+				}
+				v->l_state = LOAD_STATE_SHDR;
+			    } else {
+				/*
+				 * If neither program nor section tables,
+				 * we don't know what to do.
+				 */
+				v->l_state = LOAD_STATE_ERROR;
+				return -ENOEXEC;
+			    }
+			}
+			break;
+		case LOAD_STATE_PHDR:
+			/* Loading Program Headers into scratch */
+			tocopy = min((unsigned long)count,
+			    v->l_ehdr->e_phoff + v->l_phlen - v->copied);
+			uncopied = copy_from_user(v->pbuffer + v->copied,
+			    buffer, tocopy);
+			count -= tocopy - uncopied;
+			v->copied += tocopy - uncopied;
+			v->offset += tocopy - uncopied;
+			buffer += tocopy - uncopied;
+
+			if (v->copied == v->l_ehdr->e_phoff + v->l_phlen) {
+			    /*
+			     * It's legal for the program headers to be
+			     * out of order with respect to the file layout.
+			     * Generate a list of indices, sorted by file
+			     * offset.
+			     */
+			    v->l_phsort = kmalloc(v->l_ehdr->e_phnum
+				* sizeof(int), GFP_KERNEL);
+			    printk(KERN_DEBUG
+		   "Used kmalloc to allocate %d bytes of memory at %x\n",
+				   v->l_ehdr->e_phnum*sizeof(int),
+				   (unsigned int)v->l_phsort);
+			    if (!v->l_phsort)
+				    return -ENOMEM; /* Preposterous, but... */
+			    indexort(v->l_phdr, v->l_ehdr->e_phnum,
+				     v->l_phsort);
+
+			    v->l_progminad = (unsigned int)-1;
+			    v->l_progmaxad = 0;
+			    progmemlen = 0;
+			    for (i = 0; i < v->l_ehdr->e_phnum; i++) {
+				if (v->l_phdr[v->l_phsort[i]].p_type
+				    == PT_LOAD) {
+				    /* Unstripped .reginfo sections are bad */
+				    if (v->l_phdr[v->l_phsort[i]].p_vaddr
+					< __UA_LIMIT) {
+					printk(KERN_WARNING "%s%s%s\n",
+					    "VPE loader: ",
+					    "User-mode p_vaddr, ",
+					    "skipping program segment,");
+					printk(KERN_WARNING "%s%s%s\n",
+					    "VPE loader: ",
+					    "strip .reginfo from binary ",
+					    "if necessary.");
+					continue;
+				    }
+				    if (v->l_phdr[v->l_phsort[i]].p_vaddr
+					< v->l_progminad)
+					    v->l_progminad =
+					      v->l_phdr[v->l_phsort[i]].p_vaddr;
+				    if ((v->l_phdr[v->l_phsort[i]].p_vaddr
+					+ v->l_phdr[v->l_phsort[i]].p_memsz)
+					> v->l_progmaxad)
+					    v->l_progmaxad =
+					     v->l_phdr[v->l_phsort[i]].p_vaddr +
+					     v->l_phdr[v->l_phsort[i]].p_memsz;
+				}
+			    }
+			    printk(KERN_INFO "APRP RP program 0x%x to 0x%x\n",
+				v->l_progminad, v->l_progmaxad);
+			    /*
+			     * Do a simple sanity check of the memory being
+			     * allocated. Abort if greater than an arbitrary
+			     * value of 32MB
+			     */
+			    if (v->l_progmaxad - v->l_progminad >
+				32*1024*1024) {
+				printk(KERN_WARNING
+	      "RP program failed to allocate %d kbytes - limit is 32,768 KB\n",
+				       (v->l_progmaxad - v->l_progminad)/1024);
+				return -ENOMEM;
+			      }
+
+			    v->load_addr = alloc_progmem((void *)v->l_progminad,
+				v->l_progmaxad - v->l_progminad);
+			    if (!v->load_addr)
+				return -ENOMEM;
+			    if ((unsigned int)v->load_addr
+				> v->l_progminad) {
+				release_progmem(v->load_addr);
+				return -ENOMEM;
+			    }
+			    /* Find first segment with loadable content */
+			    for (i = 0; i < v->l_ehdr->e_phnum; i++) {
+				if (v->l_phdr[v->l_phsort[i]].p_type
+				    == PT_LOAD) {
+				    if (v->l_phdr[v->l_phsort[i]].p_vaddr
+					< __UA_LIMIT) {
+					/* Skip userspace segments */
+					continue;
+				    }
+				    v->l_cur_seg = i;
+				    break;
+				}
+			    }
+			    if (i == v->l_ehdr->e_phnum) {
+				/* No loadable program segment?  Bogus file. */
+				printk(KERN_WARNING "Bad ELF file for APRP\n");
+				return -ENOEXEC;
+			    }
+			    v->l_segoff = 0;
+			    v->l_state = LOAD_STATE_PIMAGE;
+			}
+			break;
+		case LOAD_STATE_PIMAGE:
+			/*
+			 * Skip through input stream until
+			 * first program segment. Would be
+			 * better to have loaded up to here
+			 * into the temp buffer, but for now
+			 * we simply rule out "interesting"
+			 * sections prior to the last program
+			 * segment in an executable file.
+			 */
+			if (v->offset < CURPHDR.p_offset) {
+			    uncopied = CURPHDR.p_offset - v->offset;
+			    if (uncopied > count)
+				uncopied = count;
+			    count -= uncopied;
+			    buffer += uncopied;
+			    v->offset += uncopied;
+			    /* Go back through the "while" */
+			    break;
+			}
+			/*
+			 * Having dispensed with any unlikely fluff,
+			 * copy from user I/O buffer to program segment.
+			 */
+			tocopy = min(count, CURPHDR.p_filesz - v->l_segoff);
+
+			/* Loading image into RP memory */
+			uncopied = copy_from_user((char *)CURPHDR.p_vaddr
+			    + v->l_segoff, buffer, tocopy);
+			count -= tocopy - uncopied;
+			v->offset += tocopy - uncopied;
+			v->l_segoff += tocopy - uncopied;
+			buffer += tocopy - uncopied;
+			if (v->l_segoff >= CURPHDR.p_filesz) {
+			    /* Finished current segment load */
+			    /* Zero out non-file-sourced image */
+			    uncopied = CURPHDR.p_memsz - CURPHDR.p_filesz;
+			    if (uncopied > 0)
+				memset((char *)CURPHDR.p_vaddr + v->l_segoff,
+				    0, uncopied);
+			    /* Advance to next segment */
+			    for (i = v->l_cur_seg + 1;
+				i < v->l_ehdr->e_phnum; i++) {
+				if (v->l_phdr[v->l_phsort[i]].p_type
+				    == PT_LOAD) {
+				    if (v->l_phdr[v->l_phsort[i]].p_vaddr
+					< __UA_LIMIT) {
+					/* Skip userspace segments */
+					continue;
+				    }
+				    v->l_cur_seg = i;
+				    break;
+				}
+			    }
+			    /* If none left, prepare to load section headers */
+			    if (i == v->l_ehdr->e_phnum) {
+				if (v->l_ehdr->e_shoff != 0) {
+				/* Copy to where we left off in temp buffer */
+				    v->l_shlen = v->l_ehdr->e_shentsize
+					* v->l_ehdr->e_shnum;
+				    if ((v->l_ehdr->e_shoff + v->l_shlen
+					- v->offset) > v->pbsize) {
+					printk(KERN_WARNING
+			   "VPE loader: elf sections/section table too big\n");
+					v->l_state = LOAD_STATE_ERROR;
+					return -ENOMEM;
+				    }
+				    v->l_state = LOAD_STATE_SHDR;
+				    break;
+				}
+			    } else {
+				/* reset offset for new program segment */
+				v->l_segoff = 0;
+			    }
+			}
+			break;
+		case LOAD_STATE_SHDR:
+			/*
+			 * Read stream into private buffer up
+			 * through and including the section header
+			 * table.
+			 */
 
-	v->len += count;
+			tocopy = min((unsigned long)count,
+			    v->l_ehdr->e_shoff + v->l_shlen - v->offset);
+			if (tocopy) {
+			    uncopied = copy_from_user(v->pbuffer + v->copied,
+			    buffer, tocopy);
+			    count -= tocopy - uncopied;
+			    v->copied += tocopy - uncopied;
+			    v->offset += tocopy - uncopied;
+			    buffer += tocopy - uncopied;
+			}
+			/* Finished? */
+			if (v->offset == v->l_ehdr->e_shoff + v->l_shlen) {
+			    unsigned int offset_delta = v->offset - v->copied;
+
+			    v->l_shdr = (Elf_Shdr *)(v->pbuffer
+				+ v->l_ehdr->e_shoff - offset_delta);
+			    /*
+			     * Check for sections after the section table,
+			     * which for gcc MIPS binaries includes
+			     * the symbol table. Do any other processing
+			     * that requires value within stream, and
+			     * normalize offsets to be relative to
+			     * the header-only layout of temp buffer.
+			     */
+
+			    /* Assume no trailer until we detect one */
+			    v->l_trailer = 0;
+			    v->l_state = LOAD_STATE_DONE;
+			    for (i = 0; i < v->l_ehdr->e_shnum; i++) {
+				   if (v->l_shdr[i].sh_offset
+					> v->l_ehdr->e_shoff) {
+					v->l_state = LOAD_STATE_TRAILER;
+					/* Track trailing data length */
+					if (v->l_trailer
+					    < (v->l_shdr[i].sh_offset
+					    + v->l_shdr[i].sh_size)
+					    - (v->l_ehdr->e_shoff
+					    + v->l_shlen))
+						v->l_trailer =
+						    (v->l_shdr[i].sh_offset
+						    + v->l_shdr[i].sh_size)
+						    - (v->l_ehdr->e_shoff
+						    + v->l_shlen);
+				    }
+				    /* Adjust section offset if necessary */
+				    v->l_shdr[i].sh_offset -= offset_delta;
+			    }
+			    if ((v->copied + v->l_trailer) > v->pbsize) {
+				printk(KERN_WARNING
+	      "VPE loader: elf size too big. Perhaps strip uneeded symbols\n");
+				v->l_state = LOAD_STATE_ERROR;
+				return -ENOMEM;
+			    }
+
+			    /* Fix up offsets in ELF header */
+			    v->l_ehdr->e_shoff = (unsigned int)v->l_shdr
+				- (unsigned int)v->pbuffer;
+			}
+			break;
+		case LOAD_STATE_TRAILER:
+			/*
+			 * Symbol and string tables follow section headers
+			 * in gcc binaries for MIPS. Copy into temp buffer.
+			 */
+			if (v->l_trailer) {
+			    tocopy = min(count, v->l_trailer);
+			    uncopied = copy_from_user(v->pbuffer + v->copied,
+			    buffer, tocopy);
+			    count -= tocopy - uncopied;
+			    v->l_trailer -= tocopy - uncopied;
+			    v->copied += tocopy - uncopied;
+			    v->offset += tocopy - uncopied;
+			    buffer += tocopy - uncopied;
+			}
+			if (!v->l_trailer)
+			    v->l_state = LOAD_STATE_DONE;
+			break;
+		case LOAD_STATE_DONE:
+			if (count)
+				count = 0;
+			break;
+		case LOAD_STATE_ERROR:
+		default:
+			return -EINVAL;
+		}
+	}
 	return ret;
 }
 
@@ -1216,7 +1789,9 @@ int vpe_start(vpe_handle vpe, unsigned long start)
 {
 	struct vpe *v = vpe;
 
-	v->__start = start;
+	/* Null start address means use value from ELF file */
+	if (start)
+		v->__start = start;
 	return vpe_run(v);
 }
 
@@ -1341,6 +1916,99 @@ char *vpe_getcwd(int index)
 
 EXPORT_SYMBOL(vpe_getcwd);
 
+/*
+ * RP applications may contain a _vpe_shared_area descriptor
+ * array to allow for data sharing with Linux kernel functions
+ * that's slightly more abstracted and extensible than the
+ * fixed binding used by the rtlx support.  Indeed, the rtlx
+ * support should ideally be converted to use the generic
+ * shared area descriptor scheme at some point.
+ *
+ * mips_get_vpe_shared_area() can be used by AP kernel
+ * modules to get an area pointer of a given type, if
+ * it exists.
+ *
+ * mips_publish_vpe_area() is used by AP kernel modules
+ * to share kseg0 kernel memory with the RP.  It maintains
+ * a private table, so that publishing can be done before
+ * the RP program is launched.  Making this table dynamically
+ * allocated and extensible would be good scalable OS design.
+ * however, until there's more than one user of the mechanism,
+ * it should be an acceptable simplification to allow a static
+ * maximum of 4 published areas.
+ */
+
+void *mips_get_vpe_shared_area(int index, int type)
+{
+	struct vpe *v;
+	struct vpe_shared_area *vsa;
+
+	v = get_vpe(index);
+	if (v == NULL)
+		return NULL;
+
+	if (v->shared_areas == NULL)
+		return NULL;
+
+	vsa = v->shared_areas;
+
+	while (vsa->type != VPE_SHARED_NULL) {
+		if (vsa->type == type)
+			return vsa->addr;
+		else
+			vsa++;
+	}
+	/* Fell through without finding type */
+
+	return NULL;
+}
+EXPORT_SYMBOL(mips_get_vpe_shared_area);
+
+int  mips_publish_vpe_area(int type, void *ptr)
+{
+	int i;
+	int retval = 0;
+	struct vpe *v;
+	unsigned long flags;
+	unsigned int vpflags;
+
+	printk(KERN_INFO "mips_publish_vpe_area(0x%x, 0x%x)\n", type, (int)ptr);
+	if ((unsigned int)ptr >= KSEG2) {
+	    printk(KERN_ERR "VPE area pubish of invalid address 0x%x\n",
+		(int)ptr);
+	    return 0;
+	}
+	for (i = 0; i < N_PUB_AREAS; i++) {
+	    if (published_vpe_area[i].type == VPE_SHARED_RESERVED) {
+		published_vpe_area[i].type = type;
+		published_vpe_area[i].addr = ptr;
+		retval = type;
+		break;
+	    }
+	}
+	/*
+	 * If we've already got a VPE up and running, try to
+	 * update the shared descriptor with the new data.
+	 */
+	list_for_each_entry(v, &vpecontrol.vpe_list, list) {
+	    if (v->shared_areas != NULL) {
+		local_irq_save(flags);
+		vpflags = dvpe();
+		for (i = 0; v->shared_areas[i].type != VPE_SHARED_NULL; i++) {
+		    if ((v->shared_areas[i].type == type)
+		    || (v->shared_areas[i].type == VPE_SHARED_RESERVED)) {
+			v->shared_areas[i].type = type;
+			v->shared_areas[i].addr = ptr;
+		    }
+		}
+		evpe(vpflags);
+		local_irq_restore(flags);
+	    }
+	}
+	return retval;
+}
+EXPORT_SYMBOL(mips_publish_vpe_area);
+
 #ifdef CONFIG_MIPS_APSP_KSPD
 static void kspd_sp_exit( int sp_id)
 {
@@ -1359,6 +2027,7 @@ static ssize_t store_kill(struct device *dev, struct device_attribute *attr,
 	}
 
 	release_progmem(vpe->load_addr);
+	kfree(vpe->l_phsort);
 	cleanup_tc(get_tc(tclimit));
 	vpe_stop(vpe);
 	vpe_free(vpe);
@@ -1404,6 +2073,8 @@ static struct device_attribute vpe_class_attributes[] = {
 
 static void vpe_device_release(struct device *cd)
 {
+	printk(KERN_DEBUG "Using kfree to free vpe class device at %x\n",
+	       (unsigned int)cd);
 	kfree(cd);
 }
 
@@ -1430,19 +2101,24 @@ static int __init vpe_module_init(void)
 	}
 
 	if (vpelimit == 0) {
-		printk(KERN_WARNING "No VPEs reserved for AP/SP, not "
-		       "initializing VPE loader.\nPass maxvpes=<n> argument as "
-		       "kernel argument\n");
-
+#if defined(CONFIG_MIPS_MT_SMTC) || defined(MIPS_MT_SMP)
+		printk(KERN_WARNING "No VPEs reserved for VPE loader.\n"
+			"Pass maxvpes=<n> argument as kernel argument\n");
 		return -ENODEV;
+#else
+		vpelimit = 1;
+#endif
 	}
 
 	if (tclimit == 0) {
+#if defined(CONFIG_MIPS_MT_SMTC) || defined(MIPS_MT_SMP)
 		printk(KERN_WARNING "No TCs reserved for AP/SP, not "
 		       "initializing VPE loader.\nPass maxtcs=<n> argument as "
 		       "kernel argument\n");
-
 		return -ENODEV;
+#else
+		tclimit = 1;
+#endif
 	}
 
 	major = register_chrdev(0, module_name, &vpe_fops);
@@ -1456,7 +2132,7 @@ static int __init vpe_module_init(void)
 		printk(KERN_ERR "vpe_class registration failed\n");
 		goto out_chrdev;
 	}
-
+	xvpe_vector_set = 0;
 	device_initialize(&vpe_device);
 	vpe_device.class	= &vpe_class,
 	vpe_device.parent	= NULL,
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index bda8eb2..efcf385 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -977,7 +977,7 @@ static void __cpuinit probe_pcache(void)
 			c->icache.linesz = 2 << lsize;
 		else
 			c->icache.linesz = lsize;
-		c->icache.sets = 64 << ((config1 >> 22) & 7);
+		c->icache.sets = 32 << (((config1 >> 22) + 1) & 7);
 		c->icache.ways = 1 + ((config1 >> 16) & 7);
 
 		icache_size = c->icache.sets *
@@ -997,7 +997,7 @@ static void __cpuinit probe_pcache(void)
 			c->dcache.linesz = 2 << lsize;
 		else
 			c->dcache.linesz= lsize;
-		c->dcache.sets = 64 << ((config1 >> 13) & 7);
+		c->dcache.sets = 32 << (((config1 >> 13) + 1) & 7);
 		c->dcache.ways = 1 + ((config1 >> 7) & 7);
 
 		dcache_size = c->dcache.sets *
@@ -1051,9 +1051,30 @@ static void __cpuinit probe_pcache(void)
 	case CPU_R14000:
 		break;
 
+	case CPU_74K:
+		/*
+		 * Early versions of the 74k do not update
+		 * the cache tags on a vtag miss/ptag hit
+		 * which can occur in the case of KSEG0/KUSEG aliases
+		 * In this case it is better to treat the cache as always
+		 * having aliases
+		 */
+		if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(2, 4, 0))
+			c->dcache.flags |= MIPS_CACHE_VTAG;
+		if ((c->processor_id & 0xff) == PRID_REV_ENCODE_332(2, 4, 0))
+			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
+		goto bypass1074;
+
+	case CPU_1074K:
+		if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(1, 1, 0)) {
+			c->dcache.flags |= MIPS_CACHE_VTAG;
+			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
+		}
+		/* fall through */
+bypass1074:
+		;
 	case CPU_24K:
 	case CPU_34K:
-	case CPU_74K:
 	case CPU_1004K:
 		if ((read_c0_config7() & (1 << 16))) {
 			/* effectively physically indexed dcache,
@@ -1061,6 +1082,7 @@ static void __cpuinit probe_pcache(void)
 			c->dcache.flags |= MIPS_CACHE_PINDEX;
 			break;
 		}
+		/* fall through */
 	default:
 		if (c->dcache.waysize > PAGE_SIZE)
 			c->dcache.flags |= MIPS_CACHE_ALIASES;
@@ -1371,26 +1393,13 @@ static void __cpuinit coherency_setup(void)
 	}
 }
 
-#if defined(CONFIG_DMA_NONCOHERENT)
-
-static int __cpuinitdata coherentio;
-
-static int __init setcoherentio(char *str)
-{
-	coherentio = 1;
-
-	return 1;
-}
-
-__setup("coherentio", setcoherentio);
-#endif
-
 void __cpuinit r4k_cache_init(void)
 {
 	extern void build_clear_page(void);
 	extern void build_copy_page(void);
 	extern char __weak except_vec2_generic;
 	extern char __weak except_vec2_sb1;
+	extern int coherentio;
 	struct cpuinfo_mips *c = &current_cpu_data;
 
 	switch (c->cputype) {
@@ -1461,8 +1470,10 @@ void __cpuinit r4k_cache_init(void)
 
 	build_clear_page();
 	build_copy_page();
-#if !defined(CONFIG_MIPS_CMP)
+
+	/* We want to run CMP kernels on core(s) with and without coherent caches */
+	/* Therefore can't use CONFIG_MIPS_CMP to decide to flush cache */
 	local_r4k___flush_cache_all(NULL);
-#endif
+
 	coherency_setup();
 }
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 4608491..669995a 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -100,6 +100,7 @@ EXPORT_SYMBOL(dma_alloc_noncoherent);
 static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
 	dma_addr_t * dma_handle, gfp_t gfp)
 {
+	extern int hw_coherentio;
 	void *ret;
 
 	if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
@@ -115,7 +116,8 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
 
 		if (!plat_device_is_coherent(dev)) {
 			dma_cache_wback_inv((unsigned long) ret, size);
-			ret = UNCAC_ADDR(ret);
+			if (!hw_coherentio)
+				ret = UNCAC_ADDR(ret);
 		}
 	}
 
@@ -134,6 +136,7 @@ EXPORT_SYMBOL(dma_free_noncoherent);
 static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 	dma_addr_t dma_handle)
 {
+	extern int hw_coherentio;
 	unsigned long addr = (unsigned long) vaddr;
 	int order = get_order(size);
 
@@ -143,7 +146,8 @@ static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 	plat_unmap_dma_mem(dev, dma_handle, size, DMA_BIDIRECTIONAL);
 
 	if (!plat_device_is_coherent(dev))
-		addr = CAC_ADDR(addr);
+		if (!hw_coherentio)
+			addr = CAC_ADDR(addr);
 
 	free_pages(addr, get_order(size));
 }
diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index a96d281..d57a233 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -158,7 +158,7 @@ void __init prom_meminit(void)
 		size = p->size;
 
 		add_memory_region(base, size, type);
-                p++;
+		p++;
 	}
 }
 
diff --git a/arch/mips/mti-malta/malta-pci.c b/arch/mips/mti-malta/malta-pci.c
index bf80921..afeb619 100644
--- a/arch/mips/mti-malta/malta-pci.c
+++ b/arch/mips/mti-malta/malta-pci.c
@@ -241,8 +241,9 @@ void __init mips_pcibios_init(void)
 		return;
 	}
 
-	if (controller->io_resource->start < 0x00001000UL)	/* FIXME */
-		controller->io_resource->start = 0x00001000UL;
+	/* Change start address to avoid conflicts with ACPI and SMB devices */
+	if (controller->io_resource->start < 0x00002000UL)	/* FIXME */
+		controller->io_resource->start = 0x00002000UL;
 
 	iomem_resource.end &= 0xfffffffffULL;			/* 64 GB */
 	ioport_resource.end = controller->io_resource->end;
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index b7f37d4..618f503 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -32,6 +32,7 @@
 #include <asm/mips-boards/maltaint.h>
 #include <asm/dma.h>
 #include <asm/traps.h>
+#include <asm/gcmpregs.h>
 #ifdef CONFIG_VT
 #include <linux/console.h>
 #endif
@@ -105,6 +106,105 @@ static void __init fd_activate(void)
 }
 #endif
 
+int coherentio = -1;	/* no DMA cache coherency (may be set by user) */
+int hw_coherentio;	/* init to 0 => no HW DMA cache coherency (reflects real HW) */
+static int __init setcoherentio(char *str)
+{
+	if (coherentio < 0)
+		pr_info("Command line checking done before"
+				" plat_setup_iocoherency!!\n");
+	if (coherentio == 0)
+		pr_info("Command line enabling coherentio"
+				" (this will break...)!!\n");
+
+	coherentio = 1;
+	pr_info("Hardware DMA cache coherency (command line)\n");
+	return 1;
+}
+__setup("coherentio", setcoherentio);
+
+static int __init setnocoherentio(char *str)
+{
+	if (coherentio < 0)
+		pr_info("Command line checking done before"
+				" plat_setup_iocoherency!!\n");
+	if (coherentio == 1)
+		pr_info("Command line disabling coherentio\n");
+
+	coherentio = 0;
+	pr_info("Software DMA cache coherency (command line)\n");
+	return 1;
+}
+__setup("nocoherentio", setnocoherentio);
+
+static int __init
+plat_enable_iocoherency(void)
+{
+	int supported = 0;
+	if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO) {
+		if (BONITO_PCICACHECTRL & BONITO_PCICACHECTRL_CPUCOH_PRES) {
+			BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_CPUCOH_EN;
+			pr_info("Enabled Bonito CPU coherency\n");
+			supported = 1;
+		}
+		if (strstr(prom_getcmdline(), "iobcuncached")) {
+			BONITO_PCICACHECTRL &= ~BONITO_PCICACHECTRL_IOBCCOH_EN;
+			BONITO_PCIMEMBASECFG = BONITO_PCIMEMBASECFG &
+				~(BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
+				  BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
+			pr_info("Disabled Bonito IOBC coherency\n");
+		} else {
+			BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_IOBCCOH_EN;
+			BONITO_PCIMEMBASECFG |=
+				(BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
+				 BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
+			pr_info("Enabled Bonito IOBC coherency\n");
+		}
+	} else if (gcmp_niocu() != 0) {
+		/* Nothing special needs to be done to enable coherency */
+		pr_info("CMP IOCU detected\n");
+		if ((*(unsigned int *)0xbf403000 & 0x81) != 0x81) {
+			pr_crit("IOCU OPERATION DISABLED BY SWITCH"
+				" - DEFAULTING TO SW IO COHERENCY\n");
+			return 0;
+		}
+		supported = 1;
+	}
+	hw_coherentio = supported;
+	return supported;
+}
+
+static void __init
+plat_setup_iocoherency(void)
+{
+#ifdef CONFIG_DMA_NONCOHERENT
+	/*
+	 * Kernel has been configured with software coherency
+	 * but we might choose to turn it off
+	 */
+	if (plat_enable_iocoherency()) {
+		if (coherentio == 0)
+			pr_info("Hardware DMA cache coherency supported"
+					" but disabled from command line\n");
+		else {
+			coherentio = 1;
+			printk(KERN_INFO "Hardware DMA cache coherency\n");
+		}
+	} else {
+		if (coherentio == 1)
+			pr_info("Hardware DMA cache coherency not supported"
+				" but enabled from command line\n");
+		else {
+			coherentio = 0;
+			pr_info("Software DMA cache coherency\n");
+		}
+	}
+#else
+	if (!plat_enable_iocoherency())
+		panic("Hardware DMA cache coherency not supported");
+#endif
+}
+
 #ifdef CONFIG_BLK_DEV_IDE
 static void __init pci_clock_check(void)
 {
@@ -207,6 +307,8 @@ void __init plat_mem_setup(void)
 	if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO)
 		bonito_quirks_setup();
 
+	plat_setup_iocoherency();
+
 #ifdef CONFIG_BLK_DEV_IDE
 	pci_clock_check();
 #endif
@@ -222,3 +324,14 @@ void __init plat_mem_setup(void)
 	board_be_init = malta_be_init;
 	board_be_handler = malta_be_handler;
 }
+/* Enable PCI 2.1 compatibility in PIIX4 */
+static void __init quirk_dlcsetup(struct pci_dev *dev)
+{
+	u8 odlc, ndlc;
+	(void) pci_read_config_byte(dev, 0x82, &odlc);
+	/* Enable passive releases and delayed transaction */
+	ndlc = odlc | 7;
+	(void) pci_write_config_byte(dev, 0x82, ndlc);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0,
+		quirk_dlcsetup);
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index d1f2d4c..846faf7 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -83,6 +83,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	case CPU_25KF:
 	case CPU_34K:
 	case CPU_1004K:
+	case CPU_1074K:
 	case CPU_74K:
 	case CPU_SB1:
 	case CPU_SB1A:
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 54759f1..13487a9 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -330,16 +330,11 @@ static int __init mipsxx_init(void)
 		break;
 
 	case CPU_1004K:
-#if 0
-		/* FIXME: report as 34K for now */
-		op_model_mipsxx_ops.cpu_type = "mips/1004K";
-		break;
-#endif
-
 	case CPU_34K:
 		op_model_mipsxx_ops.cpu_type = "mips/34K";
 		break;
 
+	case CPU_1074K:
 	case CPU_74K:
 		op_model_mipsxx_ops.cpu_type = "mips/74K";
 		break;
-- 
1.7.9.6
