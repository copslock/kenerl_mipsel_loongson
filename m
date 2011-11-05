Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Nov 2011 22:36:52 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:41302 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904171Ab1KEVdv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Nov 2011 22:33:51 +0100
Received: (qmail 28094 invoked from network); 5 Nov 2011 17:28:51 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Nov 2011 17:28:51 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 05 Nov 2011 10:28:51 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 9/9] MIPS: BMIPS: Add SMP support code for
 BMIPS43xx/BMIPS5000
Date:   Sat, 05 Nov 2011 14:21:18 -0700
Message-Id: <f4cb6680e1e23277045ca5d63e1928d2@localhost>
In-Reply-To: <c2c8833593cb8eeef5c102468e105497@localhost>
References: <c2c8833593cb8eeef5c102468e105497@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 31411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4406

Initial commit of BMIPS SMP support code.  Smoke-tested on a variety of
BMIPS4350, BMIPS4380, and BMIPS5000 platforms.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/Makefile    |    1 +
 arch/mips/kernel/bmips_vec.S |  273 +++++++++++++++++++++++++
 arch/mips/kernel/smp-bmips.c |  458 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 732 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/kernel/bmips_vec.S
 create mode 100644 arch/mips/kernel/smp-bmips.c

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 1a96618..0198321 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_CPU_XLR)		+= r4k_fpu.o r4k_switch.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP_UP)		+= smp-up.o
+obj-$(CONFIG_CPU_BMIPS)		+= smp-bmips.o bmips_vec.o
 
 obj-$(CONFIG_MIPS_MT)		+= mips-mt.o
 obj-$(CONFIG_MIPS_MT_FPAFF)	+= mips-mt-fpaff.o
diff --git a/arch/mips/kernel/bmips_vec.S b/arch/mips/kernel/bmips_vec.S
new file mode 100644
index 0000000..ddabc82d
--- /dev/null
+++ b/arch/mips/kernel/bmips_vec.S
@@ -0,0 +1,273 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011 by Kevin Cernekee (cernekee@gmail.com)
+ *
+ * Reset/NMI/re-entry vectors for BMIPS processors
+ */
+
+#include <linux/init.h>
+
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/cacheops.h>
+#include <asm/regdef.h>
+#include <asm/mipsregs.h>
+#include <asm/stackframe.h>
+#include <asm/addrspace.h>
+#include <asm/bmips.h>
+
+	.macro	CLR_FPR a b c d
+	mtc1	$0, $\a
+	mtc1	$0, $\b
+	mtc1	$0, $\c
+	mtc1	$0, $\d
+	.endm
+
+	.macro	BARRIER
+	.set	mips32
+	ssnop
+	ssnop
+	ssnop
+	.set	mips0
+	.endm
+
+	__CPUINIT
+
+/***********************************************************************
+ * Alternate CPU1 startup vector for BMIPS4350
+ *
+ * On some systems the bootloader has already started CPU1 and configured
+ * it to resume execution at 0x8000_0200 (!BEV IV vector) when it is
+ * triggered by the SW1 interrupt.  If that is the case we try to move
+ * it to a more convenient place: BMIPS_WARM_RESTART_VEC @ 0x8000_0380.
+ ***********************************************************************/
+
+LEAF(bmips_smp_movevec)
+	la	k0, 1f
+	li	k1, CKSEG1
+	or	k0, k1
+	jr	k0
+
+1:
+	/* clear IV, pending IPIs */
+	mtc0	zero, CP0_CAUSE
+
+	/* re-enable IRQs to wait for SW1 */
+	li	k0, ST0_IE | ST0_BEV | STATUSF_IP1
+	mtc0	k0, CP0_STATUS
+
+	/* set up CPU1 CBR; move BASE to 0xa000_0000 */
+	li	k0, 0xff400000
+	mtc0	k0, $22, 6
+	li	k1, CKSEG1 | BMIPS_RELO_VECTOR_CONTROL_1
+	or	k0, k1
+	li	k1, 0xa0080000
+	sw	k1, 0(k0)
+
+	/* wait here for SW1 interrupt from bmips_boot_secondary() */
+	wait
+
+	la	k0, bmips_reset_nmi_vec
+	li	k1, CKSEG1
+	or	k0, k1
+	jr	k0
+END(bmips_smp_movevec)
+
+/***********************************************************************
+ * Reset/NMI vector
+ * For BMIPS processors that can relocate their exception vectors, this
+ * entire function gets copied to 0x8000_0000.
+ ***********************************************************************/
+
+NESTED(bmips_reset_nmi_vec, PT_SIZE, sp)
+	.set	push
+	.set	noat
+	.align	4
+
+#ifdef CONFIG_SMP
+	/* if the NMI bit is clear, assume this is a CPU1 reset instead */
+	li	k1, (1 << 19)
+	mfc0	k0, CP0_STATUS
+	and	k0, k1
+	beqz	k0, bmips_smp_entry
+
+#if defined(CONFIG_CPU_BMIPS5000)
+	/* if we're not on core 0, this must be the SMP boot signal */
+	li	k1, (3 << 25)
+	mfc0	k0, $22
+	and	k0, k1
+	bnez	k0, bmips_smp_entry
+#endif
+#endif /* CONFIG_SMP */
+
+	/* nope, it's just a regular NMI */
+	SAVE_ALL
+	move	a0, sp
+
+	/* clear EXL, ERL, BEV so that TLB refills still work */
+	mfc0	k0, CP0_STATUS
+	li	k1, ST0_ERL | ST0_EXL | ST0_BEV | ST0_IE
+	or	k0, k1
+	xor	k0, k1
+	mtc0	k0, CP0_STATUS
+	BARRIER
+
+	/* call the NMI handler function (probably doesn't return) */
+	la	k0, nmi_exception_handler
+	jalr	k0
+
+	RESTORE_ALL
+	.set	mips3
+	eret
+
+/***********************************************************************
+ * CPU1 reset vector (used for the initial boot only)
+ * This is still part of bmips_reset_nmi_vec().
+ ***********************************************************************/
+
+#ifdef CONFIG_SMP
+
+bmips_smp_entry:
+
+	/* set up CP0 STATUS; enable FPU */
+	li	k0, 0x30000000
+	mtc0	k0, CP0_STATUS
+	BARRIER
+
+	/* set local CP0 CONFIG to make kseg0 cacheable, write-back */
+	mfc0	k0, CP0_CONFIG
+	ori	k0, 0x07
+	xori	k0, 0x04
+	mtc0	k0, CP0_CONFIG
+
+#if defined(CONFIG_CPU_BMIPS4380)
+	/* initialize FPU registers */
+	CLR_FPR	f0 f1 f2 f3
+	CLR_FPR	f4 f5 f6 f7
+	CLR_FPR	f8 f9 f10 f11
+	CLR_FPR	f12 f13 f14 f15
+	CLR_FPR	f16 f17 f18 f19
+	CLR_FPR	f20 f21 f22 f23
+	CLR_FPR	f24 f25 f26 f27
+	CLR_FPR	f28 f29 f30 f31
+#endif
+
+#if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
+	/* initialize CPU1's local I-cache */
+	li	k0, 0x80000000
+	li	k1, 0x80010000
+	mtc0	zero, $28
+	mtc0	zero, $28, 1
+	BARRIER
+
+1:	cache	Index_Store_Tag_I, 0(k0)
+	addiu	k0, 16
+	bne	k0, k1, 1b
+#elif defined(CONFIG_CPU_BMIPS5000)
+	/* set exception vector base */
+	la	k0, ebase
+	lw	k0, 0(k0)
+	mtc0	k0, $15, 1
+	BARRIER
+#endif
+
+	/* jump back to kseg0 in case we need to remap the kseg1 area */
+	la	k0, 1f
+	jr	k0
+1:
+	la	k0, bmips_enable_xks01
+	jalr	k0
+
+	/* use temporary stack to set up upper memory TLB */
+	li	sp, BMIPS_WARM_RESTART_VEC
+	la	k0, plat_wired_tlb_setup
+	jalr	k0
+
+	/* switch to permanent stack and continue booting */
+
+	.global	bmips_secondary_reentry
+bmips_secondary_reentry:
+	la	k0, bmips_smp_boot_sp
+	lw	sp, 0(k0)
+	la	k0, bmips_smp_boot_gp
+	lw	gp, 0(k0)
+	la	k0, start_secondary
+	jr	k0
+
+#endif /* CONFIG_SMP */
+
+	.align	4
+	.global	bmips_reset_nmi_vec_end
+bmips_reset_nmi_vec_end:
+
+END(bmips_reset_nmi_vec)
+
+	.set	pop
+	.previous
+
+/***********************************************************************
+ * CPU1 warm restart vector (used for second and subsequent boots).
+ * Also used for S2 standby recovery (PM).
+ * This entire function gets copied to (BMIPS_WARM_RESTART_VEC)
+ ***********************************************************************/
+
+LEAF(bmips_smp_int_vec)
+
+	.align	4
+	mfc0	k0, CP0_STATUS
+	ori	k0, 0x01
+	xori	k0, 0x01
+	mtc0	k0, CP0_STATUS
+	eret
+
+	.align	4
+	.global	bmips_smp_int_vec_end
+bmips_smp_int_vec_end:
+
+END(bmips_smp_int_vec)
+
+/***********************************************************************
+ * XKS01 support
+ * Certain CPUs support extending kseg0 to 1024MB.
+ ***********************************************************************/
+
+	__CPUINIT
+
+LEAF(bmips_enable_xks01)
+
+#if defined(CONFIG_XKS01)
+
+#if defined(CONFIG_CPU_BMIPS4380)
+	mfc0	t0, $22, 3
+	li	t1, 0x1ff0
+	li	t2, (1 << 12) | (1 << 9)
+	or	t0, t1
+	xor	t0, t1
+	or	t0, t2
+	mtc0	t0, $22, 3
+	BARRIER
+#elif defined(CONFIG_CPU_BMIPS5000)
+	mfc0	t0, $22, 5
+	li	t1, 0x01ff
+	li	t2, (1 << 8) | (1 << 5)
+	or	t0, t1
+	xor	t0, t1
+	or	t0, t2
+	mtc0	t0, $22, 5
+	BARRIER
+#else
+
+#error Missing XKS01 setup
+
+#endif
+
+#endif /* defined(CONFIG_XKS01) */
+
+	jr	ra
+
+END(bmips_enable_xks01)
+
+	.previous
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
new file mode 100644
index 0000000..31c46ae
--- /dev/null
+++ b/arch/mips/kernel/smp-bmips.c
@@ -0,0 +1,458 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011 by Kevin Cernekee (cernekee@gmail.com)
+ *
+ * SMP support for BMIPS
+ */
+
+#include <linux/version.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/init.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/reboot.h>
+#include <linux/io.h>
+#include <linux/compiler.h>
+#include <linux/linkage.h>
+#include <linux/bug.h>
+
+#include <asm/time.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/bootinfo.h>
+#include <asm/pmon.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+#include <asm/mipsregs.h>
+#include <asm/bmips.h>
+#include <asm/traps.h>
+#include <asm/barrier.h>
+
+static int __maybe_unused max_cpus = 1;
+
+cpumask_t bmips_booted_mask;
+
+#ifdef CONFIG_SMP
+
+/* initial $sp, $gp - used by arch/mips/kernel/bmips_vec.S */
+unsigned long bmips_smp_boot_sp;
+unsigned long bmips_smp_boot_gp;
+
+static void bmips_send_ipi_single(int cpu, unsigned int action);
+static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id);
+
+/* the platform code may forcibly disable SMP */
+int bmips_smp_enabled = 1;
+
+/* SW interrupts 0,1 are used for interprocessor signaling */
+#define IPI0_IRQ			(MIPS_CPU_IRQ_BASE + 0)
+#define IPI1_IRQ			(MIPS_CPU_IRQ_BASE + 1)
+
+#define ACTION_CLR_IPI(cpu, ipi)	(0x2000 | ((cpu) << 9) | ((ipi) << 8))
+#define ACTION_SET_IPI(cpu, ipi)	(0x3000 | ((cpu) << 9) | ((ipi) << 8))
+#define ACTION_BOOT_THREAD(cpu)		(0x08 | (cpu))
+
+static void __init bmips_smp_setup(void)
+{
+	int i;
+
+#if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
+	/* arbitration priority */
+	clear_c0_brcm_cmt_ctrl(0x30);
+
+	/* NBK and weak order flags */
+	set_c0_brcm_config_0(0x30000);
+
+	/*
+	 * MIPS interrupts 0,1 (SW INT 0,1) cross over to the other thread
+	 * MIPS interrupt 2 (HW INT 0) is the CPU0 L1 controller output
+	 * MIPS interrupt 3 (HW INT 1) is the CPU1 L1 controller output
+	 */
+	change_c0_brcm_cmt_intr(0xf8018000,
+		(0x02 << 27) | (0x03 << 15));
+
+	/* single core, 2 threads (2 pipelines) */
+	max_cpus = 2;
+#elif defined(CONFIG_CPU_BMIPS5000)
+	/* enable raceless SW interrupts */
+	set_c0_brcm_config(0x03 << 22);
+
+	/* route HW interrupt 0 to CPU0, HW interrupt 1 to CPU1 */
+	change_c0_brcm_mode(0x1f << 27, 0x02 << 27);
+
+	/* N cores, 2 threads per core */
+	max_cpus = (((read_c0_brcm_config() >> 6) & 0x03) + 1) << 1;
+
+	/* clear any pending SW interrupts */
+	for (i = 0; i < max_cpus; i++) {
+		write_c0_brcm_action(ACTION_CLR_IPI(i, 0));
+		write_c0_brcm_action(ACTION_CLR_IPI(i, 1));
+	}
+#endif
+
+	if (!bmips_smp_enabled)
+		max_cpus = 1;
+
+	/* this can be overridden by the BSP */
+	if (!board_ebase_setup)
+		board_ebase_setup = &bmips_ebase_setup;
+
+	for (i = 0; i < max_cpus; i++) {
+		__cpu_number_map[i] = 1;
+		__cpu_logical_map[i] = 1;
+		set_cpu_possible(i, 1);
+		set_cpu_present(i, 1);
+	}
+}
+
+/*
+ * IPI IRQ setup - runs on CPU0
+ */
+static void bmips_prepare_cpus(unsigned int max_cpus)
+{
+	if (request_irq(IPI0_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
+			"smp_ipi0", NULL))
+		panic("Can't request IPI0 interrupt\n");
+	if (request_irq(IPI1_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
+			"smp_ipi1", NULL))
+		panic("Can't request IPI1 interrupt\n");
+}
+
+/*
+ * Tell the hardware to boot CPUx - runs on CPU0
+ */
+static void bmips_boot_secondary(int cpu, struct task_struct *idle)
+{
+	bmips_smp_boot_sp = __KSTK_TOS(idle);
+	bmips_smp_boot_gp = (unsigned long)task_thread_info(idle);
+	mb();
+
+	/*
+	 * Initial boot sequence for secondary CPU:
+	 *   bmips_reset_nmi_vec @ a000_0000 ->
+	 *   bmips_smp_entry ->
+	 *   plat_wired_tlb_setup (cached function call; optional) ->
+	 *   start_secondary (cached jump)
+	 *
+	 * Warm restart sequence:
+	 *   play_dead WAIT loop ->
+	 *   bmips_smp_int_vec @ BMIPS_WARM_RESTART_VEC ->
+	 *   eret to play_dead ->
+	 *   bmips_secondary_reentry ->
+	 *   start_secondary
+	 */
+
+	printk(KERN_INFO "SMP: Booting CPU%d...\n", cpu);
+
+	if (cpumask_test_cpu(cpu, &bmips_booted_mask))
+		bmips_send_ipi_single(cpu, 0);
+	else {
+#if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
+		set_c0_brcm_cmt_ctrl(0x01);
+#elif defined(CONFIG_CPU_BMIPS5000)
+		if (cpu & 0x01)
+			write_c0_brcm_action(ACTION_BOOT_THREAD(cpu));
+		else {
+			/*
+			 * core N thread 0 was already booted; just
+			 * pulse the NMI line
+			 */
+			bmips_write_zscm_reg(0x210, 0xc0000000);
+			udelay(10);
+			bmips_write_zscm_reg(0x210, 0x00);
+		}
+#endif
+		cpumask_set_cpu(cpu, &bmips_booted_mask);
+	}
+}
+
+/*
+ * Early setup - runs on secondary CPU after cache probe
+ */
+static void bmips_init_secondary(void)
+{
+	/* move NMI vector to kseg0, in case XKS01 is enabled */
+
+#if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
+	void __iomem *cbr = BMIPS_GET_CBR();
+	unsigned long old_vec;
+
+	old_vec = __raw_readl(cbr + BMIPS_RELO_VECTOR_CONTROL_1);
+	__raw_writel(old_vec & ~0x20000000, cbr + BMIPS_RELO_VECTOR_CONTROL_1);
+
+	clear_c0_cause(smp_processor_id() ? C_SW1 : C_SW0);
+#elif defined(CONFIG_CPU_BMIPS5000)
+	write_c0_brcm_bootvec(read_c0_brcm_bootvec() &
+		(smp_processor_id() & 0x01 ? ~0x20000000 : ~0x2000));
+
+	write_c0_brcm_action(ACTION_CLR_IPI(smp_processor_id(), 0));
+#endif
+
+	/* make sure there won't be a timer interrupt for a little while */
+	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
+
+	irq_enable_hazard();
+	set_c0_status(IE_SW0 | IE_SW1 | IE_IRQ1 | IE_IRQ5 | ST0_IE);
+	irq_enable_hazard();
+}
+
+/*
+ * Late setup - runs on secondary CPU before entering the idle loop
+ */
+static void bmips_smp_finish(void)
+{
+	printk(KERN_INFO "SMP: CPU%d is running\n", smp_processor_id());
+}
+
+/*
+ * Runs on CPU0 after all CPUs have been booted
+ */
+static void bmips_cpus_done(void)
+{
+}
+
+#if defined(CONFIG_CPU_BMIPS5000)
+
+/*
+ * BMIPS5000 raceless IPIs
+ *
+ * Each CPU has two inbound SW IRQs which are independent of all other CPUs.
+ * IPI0 is used for SMP_RESCHEDULE_YOURSELF
+ * IPI1 is used for SMP_CALL_FUNCTION
+ */
+
+static void bmips_send_ipi_single(int cpu, unsigned int action)
+{
+	write_c0_brcm_action(ACTION_SET_IPI(cpu, action == SMP_CALL_FUNCTION));
+}
+
+static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id)
+{
+	int action = irq - IPI0_IRQ;
+
+	write_c0_brcm_action(ACTION_CLR_IPI(smp_processor_id(), action));
+
+	if (action == 0)
+		scheduler_ipi();
+	else
+		smp_call_function_interrupt();
+
+	return IRQ_HANDLED;
+}
+
+#else
+
+/*
+ * BMIPS43xx racey IPIs
+ *
+ * We use one inbound SW IRQ for each CPU.
+ *
+ * A spinlock must be held in order to keep CPUx from accidentally clearing
+ * an incoming IPI when it writes CP0 CAUSE to raise an IPI on CPUy.  The
+ * same spinlock is used to protect the action masks.
+ */
+
+static DEFINE_SPINLOCK(ipi_lock);
+static DEFINE_PER_CPU(int, ipi_action_mask);
+
+static void bmips_send_ipi_single(int cpu, unsigned int action)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ipi_lock, flags);
+	set_c0_cause(cpu ? C_SW1 : C_SW0);
+	per_cpu(ipi_action_mask, cpu) |= action;
+	irq_enable_hazard();
+	spin_unlock_irqrestore(&ipi_lock, flags);
+}
+
+static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id)
+{
+	unsigned long flags;
+	int action, cpu = irq - IPI0_IRQ;
+
+	spin_lock_irqsave(&ipi_lock, flags);
+	action = __get_cpu_var(ipi_action_mask);
+	per_cpu(ipi_action_mask, cpu) = 0;
+	clear_c0_cause(cpu ? C_SW1 : C_SW0);
+	spin_unlock_irqrestore(&ipi_lock, flags);
+
+	if (action & SMP_RESCHEDULE_YOURSELF)
+		scheduler_ipi();
+	if (action & SMP_CALL_FUNCTION)
+		smp_call_function_interrupt();
+
+	return IRQ_HANDLED;
+}
+
+#endif /* BMIPS type */
+
+static void bmips_send_ipi_mask(const struct cpumask *mask,
+	unsigned int action)
+{
+	unsigned int i;
+
+	for_each_cpu(i, mask)
+		bmips_send_ipi_single(i, action);
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+static int bmips_cpu_disable(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	if (cpu == 0)
+		return -EBUSY;
+
+	printk(KERN_INFO "SMP: CPU%d is offline\n", cpu);
+
+	cpu_clear(cpu, cpu_online_map);
+	cpu_clear(cpu, cpu_callin_map);
+
+	local_flush_tlb_all();
+	local_flush_icache_range(0, ~0);
+
+	return 0;
+}
+
+static void bmips_cpu_die(unsigned int cpu)
+{
+}
+
+void __ref play_dead(void)
+{
+	idle_task_exit();
+
+	/* Drop all mm context TLB entries on this cpu */
+	local_flush_tlb_all_mm();
+	/* flush data cache */
+	_dma_cache_wback_inv(0, ~0);
+
+	/*
+	 * Wakeup is on SW0 or SW1; disable everything else
+	 * Use BEV !IV (BMIPS_WARM_RESTART_VEC) to avoid the regular Linux
+	 * IRQ handlers; this clears ST0_IE and returns immediately.
+	 */
+	clear_c0_cause(CAUSEF_IV | C_SW0 | C_SW1);
+	change_c0_status(IE_IRQ5 | IE_IRQ1 | IE_SW0 | IE_SW1 | ST0_IE | ST0_BEV,
+		IE_SW0 | IE_SW1 | ST0_IE | ST0_BEV);
+	irq_disable_hazard();
+
+	/*
+	 * wait for SW interrupt from bmips_boot_secondary(), then jump
+	 * back to start_secondary()
+	 */
+	__asm__ __volatile__(
+	"	wait\n"
+	"	j	bmips_secondary_reentry\n"
+	: : : "memory");
+}
+
+#endif /* CONFIG_HOTPLUG_CPU */
+
+struct plat_smp_ops bmips_smp_ops = {
+	.smp_setup		= bmips_smp_setup,
+	.prepare_cpus		= bmips_prepare_cpus,
+	.boot_secondary		= bmips_boot_secondary,
+	.smp_finish		= bmips_smp_finish,
+	.init_secondary		= bmips_init_secondary,
+	.cpus_done		= bmips_cpus_done,
+	.send_ipi_single	= bmips_send_ipi_single,
+	.send_ipi_mask		= bmips_send_ipi_mask,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable		= bmips_cpu_disable,
+	.cpu_die		= bmips_cpu_die,
+#endif
+};
+
+#endif /* CONFIG_SMP */
+
+/***********************************************************************
+ * BMIPS vector relocation
+ * This is primarily used for SMP boot, but it is applicable to some
+ * UP BMIPS systems as well.
+ ***********************************************************************/
+
+static void __cpuinit bmips_wr_vec(unsigned long dst, char *start, char *end)
+{
+	memcpy((void *)dst, start, end - start);
+	dma_cache_wback((unsigned long)start, end - start);
+	local_flush_icache_range(dst, dst + (end - start));
+	instruction_hazard();
+}
+
+static inline void __cpuinit bmips_nmi_handler_setup(void)
+{
+	bmips_wr_vec(BMIPS_NMI_RESET_VEC, &bmips_reset_nmi_vec,
+		&bmips_reset_nmi_vec_end);
+	bmips_wr_vec(BMIPS_WARM_RESTART_VEC, &bmips_smp_int_vec,
+		&bmips_smp_int_vec_end);
+}
+
+void __cpuinit bmips_ebase_setup(void)
+{
+	unsigned long new_ebase = ebase;
+	void __iomem __maybe_unused *cbr;
+
+	BUG_ON(ebase != CKSEG0);
+
+#if defined(CONFIG_CPU_BMIPS4350)
+	/*
+	 * BMIPS4350 cannot relocate the normal vectors, but it
+	 * can relocate the BEV=1 vectors.  So CPU1 starts up at
+	 * the relocated BEV=1, IV=0 general exception vector @
+	 * 0xa000_0380.
+	 *
+	 * set_uncached_handler() is used here because:
+	 *  - CPU1 will run this from uncached space
+	 *  - None of the cacheflush functions are set up yet
+	 */
+	set_uncached_handler(BMIPS_WARM_RESTART_VEC - CKSEG0,
+		&bmips_smp_int_vec, 0x80);
+	__sync();
+	return;
+#elif defined(CONFIG_CPU_BMIPS4380)
+	/*
+	 * 0x8000_0000: reset/NMI (initially in kseg1)
+	 * 0x8000_0400: normal vectors
+	 */
+	new_ebase = 0x80000400;
+	cbr = BMIPS_GET_CBR();
+	__raw_writel(0x80080800, cbr + BMIPS_RELO_VECTOR_CONTROL_0);
+	__raw_writel(0xa0080800, cbr + BMIPS_RELO_VECTOR_CONTROL_1);
+#elif defined(CONFIG_CPU_BMIPS5000)
+	/*
+	 * 0x8000_0000: reset/NMI (initially in kseg1)
+	 * 0x8000_1000: normal vectors
+	 */
+	new_ebase = 0x80001000;
+	write_c0_brcm_bootvec(0xa0088008);
+	write_c0_ebase(new_ebase);
+	if (max_cpus > 2)
+		bmips_write_zscm_reg(0xa0, 0xa008a008);
+#else
+	return;
+#endif
+	board_nmi_handler_setup = &bmips_nmi_handler_setup;
+	ebase = new_ebase;
+}
+
+asmlinkage void __weak plat_wired_tlb_setup(void)
+{
+	/*
+	 * Called when starting/restarting a secondary CPU.
+	 * Kernel stacks and other important data might only be accessible
+	 * once the wired entries are present.
+	 */
+}
-- 
1.7.6.3
