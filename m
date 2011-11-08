Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2011 16:56:37 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33240 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903663Ab1KHP4d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Nov 2011 16:56:33 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA8FuV5I009173;
        Tue, 8 Nov 2011 15:56:31 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA8FuV5W009169;
        Tue, 8 Nov 2011 15:56:31 GMT
Date:   Tue, 8 Nov 2011 15:56:31 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 9/9] MIPS: BMIPS: Add SMP support code for
 BMIPS43xx/BMIPS5000
Message-ID: <20111108155630.GA6231@linux-mips.org>
References: <c2c8833593cb8eeef5c102468e105497@localhost>
 <f4cb6680e1e23277045ca5d63e1928d2@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4cb6680e1e23277045ca5d63e1928d2@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6848

On Sat, Nov 05, 2011 at 02:21:18PM -0700, Kevin Cernekee wrote:

> Initial commit of BMIPS SMP support code.  Smoke-tested on a variety of
> BMIPS4350, BMIPS4380, and BMIPS5000 platforms.

How good I'm a fireman ...

> +#if defined(CONFIG_CPU_BMIPS4380)
> +	/* initialize FPU registers */
> +	CLR_FPR	f0 f1 f2 f3
> +	CLR_FPR	f4 f5 f6 f7
> +	CLR_FPR	f8 f9 f10 f11
> +	CLR_FPR	f12 f13 f14 f15
> +	CLR_FPR	f16 f17 f18 f19
> +	CLR_FPR	f20 f21 f22 f23
> +	CLR_FPR	f24 f25 f26 f27
> +	CLR_FPR	f28 f29 f30 f31
> +#endif

Why initialize the FPU registers at all?  The kernel doesn't use the FPU
and before userland gets to play with the FPU the kernel will zero the
registers anyway.

> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2011 by Kevin Cernekee (cernekee@gmail.com)
> + *
> + * SMP support for BMIPS
> + */
> +
> +#include <linux/version.h>
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/mm.h>
> +#include <linux/delay.h>
> +#include <linux/smp.h>
> +#include <linux/interrupt.h>
> +#include <linux/spinlock.h>
> +#include <linux/init.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/reboot.h>
> +#include <linux/io.h>
> +#include <linux/compiler.h>
> +#include <linux/linkage.h>
> +#include <linux/bug.h>
> +
> +#include <asm/time.h>
> +#include <asm/pgtable.h>
> +#include <asm/processor.h>
> +#include <asm/system.h>
> +#include <asm/bootinfo.h>
> +#include <asm/pmon.h>
> +#include <asm/cacheflush.h>
> +#include <asm/tlbflush.h>
> +#include <asm/mipsregs.h>
> +#include <asm/bmips.h>
> +#include <asm/traps.h>
> +#include <asm/barrier.h>
> +
> +static int __maybe_unused max_cpus = 1;
> +
> +cpumask_t bmips_booted_mask;
> +
> +#ifdef CONFIG_SMP
> +
> +/* initial $sp, $gp - used by arch/mips/kernel/bmips_vec.S */
> +unsigned long bmips_smp_boot_sp;
> +unsigned long bmips_smp_boot_gp;
> +
> +static void bmips_send_ipi_single(int cpu, unsigned int action);
> +static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id);
> +
> +/* the platform code may forcibly disable SMP */
> +int bmips_smp_enabled = 1;
> +
> +/* SW interrupts 0,1 are used for interprocessor signaling */
> +#define IPI0_IRQ			(MIPS_CPU_IRQ_BASE + 0)
> +#define IPI1_IRQ			(MIPS_CPU_IRQ_BASE + 1)
> +
> +#define ACTION_CLR_IPI(cpu, ipi)	(0x2000 | ((cpu) << 9) | ((ipi) << 8))
> +#define ACTION_SET_IPI(cpu, ipi)	(0x3000 | ((cpu) << 9) | ((ipi) << 8))
> +#define ACTION_BOOT_THREAD(cpu)		(0x08 | (cpu))
> +
> +static void __init bmips_smp_setup(void)
> +{
> +	int i;
> +
> +#if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
> +	/* arbitration priority */
> +	clear_c0_brcm_cmt_ctrl(0x30);
> +
> +	/* NBK and weak order flags */
> +	set_c0_brcm_config_0(0x30000);
> +
> +	/*
> +	 * MIPS interrupts 0,1 (SW INT 0,1) cross over to the other thread
> +	 * MIPS interrupt 2 (HW INT 0) is the CPU0 L1 controller output
> +	 * MIPS interrupt 3 (HW INT 1) is the CPU1 L1 controller output
> +	 */
> +	change_c0_brcm_cmt_intr(0xf8018000,
> +		(0x02 << 27) | (0x03 << 15));
> +
> +	/* single core, 2 threads (2 pipelines) */
> +	max_cpus = 2;
> +#elif defined(CONFIG_CPU_BMIPS5000)
> +	/* enable raceless SW interrupts */
> +	set_c0_brcm_config(0x03 << 22);
> +
> +	/* route HW interrupt 0 to CPU0, HW interrupt 1 to CPU1 */
> +	change_c0_brcm_mode(0x1f << 27, 0x02 << 27);
> +
> +	/* N cores, 2 threads per core */
> +	max_cpus = (((read_c0_brcm_config() >> 6) & 0x03) + 1) << 1;
> +
> +	/* clear any pending SW interrupts */
> +	for (i = 0; i < max_cpus; i++) {
> +		write_c0_brcm_action(ACTION_CLR_IPI(i, 0));
> +		write_c0_brcm_action(ACTION_CLR_IPI(i, 1));
> +	}
> +#endif
> +
> +	if (!bmips_smp_enabled)
> +		max_cpus = 1;
> +
> +	/* this can be overridden by the BSP */
> +	if (!board_ebase_setup)
> +		board_ebase_setup = &bmips_ebase_setup;
> +
> +	for (i = 0; i < max_cpus; i++) {
> +		__cpu_number_map[i] = 1;
> +		__cpu_logical_map[i] = 1;
> +		set_cpu_possible(i, 1);
> +		set_cpu_present(i, 1);
> +	}
> +}
> +
> +/*
> + * IPI IRQ setup - runs on CPU0
> + */
> +static void bmips_prepare_cpus(unsigned int max_cpus)
> +{
> +	if (request_irq(IPI0_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
> +			"smp_ipi0", NULL))
> +		panic("Can't request IPI0 interrupt\n");
> +	if (request_irq(IPI1_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
> +			"smp_ipi1", NULL))
> +		panic("Can't request IPI1 interrupt\n");
> +}
> +
> +/*
> + * Tell the hardware to boot CPUx - runs on CPU0
> + */
> +static void bmips_boot_secondary(int cpu, struct task_struct *idle)
> +{
> +	bmips_smp_boot_sp = __KSTK_TOS(idle);
> +	bmips_smp_boot_gp = (unsigned long)task_thread_info(idle);
> +	mb();
> +
> +	/*
> +	 * Initial boot sequence for secondary CPU:
> +	 *   bmips_reset_nmi_vec @ a000_0000 ->
> +	 *   bmips_smp_entry ->
> +	 *   plat_wired_tlb_setup (cached function call; optional) ->
> +	 *   start_secondary (cached jump)
> +	 *
> +	 * Warm restart sequence:
> +	 *   play_dead WAIT loop ->
> +	 *   bmips_smp_int_vec @ BMIPS_WARM_RESTART_VEC ->
> +	 *   eret to play_dead ->
> +	 *   bmips_secondary_reentry ->
> +	 *   start_secondary
> +	 */
> +
> +	printk(KERN_INFO "SMP: Booting CPU%d...\n", cpu);

Please use pr_info() instead.

> +
> +	if (cpumask_test_cpu(cpu, &bmips_booted_mask))
> +		bmips_send_ipi_single(cpu, 0);
> +	else {
> +#if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
> +		set_c0_brcm_cmt_ctrl(0x01);
> +#elif defined(CONFIG_CPU_BMIPS5000)
> +		if (cpu & 0x01)
> +			write_c0_brcm_action(ACTION_BOOT_THREAD(cpu));
> +		else {
> +			/*
> +			 * core N thread 0 was already booted; just
> +			 * pulse the NMI line
> +			 */
> +			bmips_write_zscm_reg(0x210, 0xc0000000);
> +			udelay(10);
> +			bmips_write_zscm_reg(0x210, 0x00);
> +		}
> +#endif
> +		cpumask_set_cpu(cpu, &bmips_booted_mask);
> +	}
> +}
> +
> +/*
> + * Early setup - runs on secondary CPU after cache probe
> + */
> +static void bmips_init_secondary(void)
> +{
> +	/* move NMI vector to kseg0, in case XKS01 is enabled */
> +
> +#if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
> +	void __iomem *cbr = BMIPS_GET_CBR();
> +	unsigned long old_vec;
> +
> +	old_vec = __raw_readl(cbr + BMIPS_RELO_VECTOR_CONTROL_1);
> +	__raw_writel(old_vec & ~0x20000000, cbr + BMIPS_RELO_VECTOR_CONTROL_1);
> +
> +	clear_c0_cause(smp_processor_id() ? C_SW1 : C_SW0);
> +#elif defined(CONFIG_CPU_BMIPS5000)
> +	write_c0_brcm_bootvec(read_c0_brcm_bootvec() &
> +		(smp_processor_id() & 0x01 ? ~0x20000000 : ~0x2000));
> +
> +	write_c0_brcm_action(ACTION_CLR_IPI(smp_processor_id(), 0));
> +#endif
> +
> +	/* make sure there won't be a timer interrupt for a little while */
> +	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
> +
> +	irq_enable_hazard();
> +	set_c0_status(IE_SW0 | IE_SW1 | IE_IRQ1 | IE_IRQ5 | ST0_IE);
> +	irq_enable_hazard();
> +}
> +
> +/*
> + * Late setup - runs on secondary CPU before entering the idle loop
> + */
> +static void bmips_smp_finish(void)
> +{
> +	printk(KERN_INFO "SMP: CPU%d is running\n", smp_processor_id());

Please use pr_info() instead.

> +}
> +
> +/*
> + * Runs on CPU0 after all CPUs have been booted
> + */
> +static void bmips_cpus_done(void)
> +{
> +}
> +
> +#if defined(CONFIG_CPU_BMIPS5000)
> +
> +/*
> + * BMIPS5000 raceless IPIs
> + *
> + * Each CPU has two inbound SW IRQs which are independent of all other CPUs.
> + * IPI0 is used for SMP_RESCHEDULE_YOURSELF
> + * IPI1 is used for SMP_CALL_FUNCTION
> + */
> +
> +static void bmips_send_ipi_single(int cpu, unsigned int action)
> +{
> +	write_c0_brcm_action(ACTION_SET_IPI(cpu, action == SMP_CALL_FUNCTION));
> +}
> +
> +static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id)
> +{
> +	int action = irq - IPI0_IRQ;
> +
> +	write_c0_brcm_action(ACTION_CLR_IPI(smp_processor_id(), action));
> +
> +	if (action == 0)
> +		scheduler_ipi();
> +	else
> +		smp_call_function_interrupt();
> +
> +	return IRQ_HANDLED;
> +}
> +
> +#else
> +
> +/*
> + * BMIPS43xx racey IPIs
> + *
> + * We use one inbound SW IRQ for each CPU.
> + *
> + * A spinlock must be held in order to keep CPUx from accidentally clearing
> + * an incoming IPI when it writes CP0 CAUSE to raise an IPI on CPUy.  The
> + * same spinlock is used to protect the action masks.
> + */
> +
> +static DEFINE_SPINLOCK(ipi_lock);
> +static DEFINE_PER_CPU(int, ipi_action_mask);
> +
> +static void bmips_send_ipi_single(int cpu, unsigned int action)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ipi_lock, flags);
> +	set_c0_cause(cpu ? C_SW1 : C_SW0);
> +	per_cpu(ipi_action_mask, cpu) |= action;
> +	irq_enable_hazard();
> +	spin_unlock_irqrestore(&ipi_lock, flags);
> +}
> +
> +static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id)
> +{
> +	unsigned long flags;
> +	int action, cpu = irq - IPI0_IRQ;
> +
> +	spin_lock_irqsave(&ipi_lock, flags);
> +	action = __get_cpu_var(ipi_action_mask);
> +	per_cpu(ipi_action_mask, cpu) = 0;
> +	clear_c0_cause(cpu ? C_SW1 : C_SW0);
> +	spin_unlock_irqrestore(&ipi_lock, flags);
> +
> +	if (action & SMP_RESCHEDULE_YOURSELF)
> +		scheduler_ipi();
> +	if (action & SMP_CALL_FUNCTION)
> +		smp_call_function_interrupt();
> +
> +	return IRQ_HANDLED;
> +}
> +
> +#endif /* BMIPS type */
> +
> +static void bmips_send_ipi_mask(const struct cpumask *mask,
> +	unsigned int action)
> +{
> +	unsigned int i;
> +
> +	for_each_cpu(i, mask)
> +		bmips_send_ipi_single(i, action);
> +}
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +
> +static int bmips_cpu_disable(void)
> +{
> +	unsigned int cpu = smp_processor_id();
> +
> +	if (cpu == 0)
> +		return -EBUSY;
> +
> +	printk(KERN_INFO "SMP: CPU%d is offline\n", cpu);

Please use pr_info() instead.

  Ralf
