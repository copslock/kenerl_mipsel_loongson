Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Sep 2017 19:38:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62906 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992160AbdIURi2q1WDR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Sep 2017 19:38:28 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 29D5EFD305501;
        Thu, 21 Sep 2017 18:38:15 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 21 Sep
 2017 18:38:18 +0100
Received: from np-p-burton.localnet (10.20.79.123) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 21 Sep
 2017 10:38:16 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Steven J. Hill" <steven.hill@cavium.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: Re: [PATCH 11/11] MIPS: Octeon: Add working hotplug CPU support.
Date:   Thu, 21 Sep 2017 10:38:11 -0700
Message-ID: <20633225.fWaIEAUSlk@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <1505496613-27879-12-git-send-email-steven.hill@cavium.com>
References: <1505496613-27879-1-git-send-email-steven.hill@cavium.com> <1505496613-27879-12-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8099733.ElioabnMon";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.79.123]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart8099733.ElioabnMon
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Steven,

Please find comments interspersed below.

On Friday, 15 September 2017 10:30:13 PDT Steven J. Hill wrote:
> From: David Daney <david.daney@cavium.com>
> 

This could use some explanation - how does this differ from the hotplug code 
that's already there? The subject says "working" which suggests the current 
hotplug code is broken - is it? If so, how? What happens when you try to use 
it? How about with this patch applied - what happens when you offline a CPU? 
What happens when you online it again? Does it require interaction with the 
bootloader? If so what does the bootloader need to provide? What happens if it 
doesn't?

> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
> Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
> Signed-off-by: Carlos Munoz <cmunoz@caviumnetworks.com>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  arch/mips/Kconfig                                  |  10 +-
>  arch/mips/cavium-octeon/setup.c                    |   2 +-
>  arch/mips/cavium-octeon/smp.c                      | 213
> +++++++-------------- .../asm/mach-cavium-octeon/kernel-entry-init.h     |
> 129 ++++++++++++- arch/mips/include/asm/octeon/cvmx-coremask.h       |  26
> ++-
>  arch/mips/include/asm/octeon/cvmx.h                |  17 +-
>  drivers/watchdog/Kconfig                           |   1 +
>  7 files changed, 249 insertions(+), 149 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index ed35fd1..3e19353 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -904,7 +904,7 @@ config CAVIUM_OCTEON_SOC
>  	select EDAC_SUPPORT
>  	select EDAC_ATOMIC_SCRUB
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
> -	select SYS_SUPPORTS_HOTPLUG_CPU if CPU_BIG_ENDIAN
> +	select SYS_SUPPORTS_HOTPLUG_CPU

Why did hotplug depend on big endian before? Why doesn't it now? More things 
the commit message could explain.

>  	select SYS_HAS_EARLY_PRINTK
>  	select SYS_HAS_CPU_CAVIUM_OCTEON
>  	select HW_HAS_PCI
> @@ -2737,6 +2737,14 @@ config NR_CPUS
>  config MIPS_PERF_SHARED_TC_COUNTERS
>  	bool
> 
> +config  MIPS_NR_CPU_NR_MAP_1024
> +	bool
> +
> +config MIPS_NR_CPU_NR_MAP
> +	int
> +	default 1024 if MIPS_NR_CPU_NR_MAP_1024
> +	default NR_CPUS if !MIPS_NR_CPU_NR_MAP_1024
> +

This belongs in patch 1.

>  #
>  # Timer Interrupt Frequency Configuration
>  #
> diff --git a/arch/mips/cavium-octeon/setup.c
> b/arch/mips/cavium-octeon/setup.c index 2855d8d..068787d 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -756,7 +756,7 @@ void __init prom_init(void)
>  	if (OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2) ||
>  	    OCTEON_IS_MODEL(OCTEON_CN31XX))
>  		cvmx_write_csr(CVMX_CIU_SOFT_BIST, 0);
> -	else
> +	else if (!OCTEON_IS_MODEL(OCTEON_CN78XX))
>  		cvmx_write_csr(CVMX_CIU_SOFT_BIST, 1);
> 
>  	/* Default to 64MB in the simulator to speed things up */
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index 3de7865..ef6c5ec 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -3,26 +3,26 @@
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
>   *
> - * Copyright (C) 2004-2008, 2009, 2010 Cavium Networks
> + * Copyright (C) 2004-2017 Cavium, Inc.
>   */
>  #include <linux/cpu.h>
>  #include <linux/delay.h>
>  #include <linux/smp.h>
>  #include <linux/interrupt.h>
> -#include <linux/kernel_stat.h>
>  #include <linux/sched.h>
>  #include <linux/sched/hotplug.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/init.h>
>  #include <linux/export.h>
> 
> -#include <asm/mmu_context.h>
>  #include <asm/time.h>
>  #include <asm/setup.h>
> +#include <asm/cacheflush.h>
> +#include <asm/tlbflush.h>
> 
>  #include <asm/octeon/octeon.h>
> -
> -#include "octeon_boot.h"
> +#include <asm/octeon/cvmx-sysinfo.h>
> +#include <asm/octeon/cvmx-boot-vector.h>
> 
>  volatile unsigned long octeon_processor_boot = 0xff;
>  volatile unsigned long octeon_processor_sp;
> @@ -32,10 +32,14 @@ volatile unsigned long
> octeon_processor_relocated_kernel_entry; #endif /* CONFIG_RELOCATABLE */
> 
>  #ifdef CONFIG_HOTPLUG_CPU
> -uint64_t octeon_bootloader_entry_addr;
> -EXPORT_SYMBOL(octeon_bootloader_entry_addr);
> +static struct cvmx_boot_vector_element *octeon_bootvector;
> +static void *octeon_hotplug_entry_raw;
> +extern asmlinkage void octeon_hotplug_entry(void);
>  #endif
> 
> +/* State of each CPU. */
> +DEFINE_PER_CPU(int, cpu_state);
> +
>  extern void kernel_entry(unsigned long arg1, ...);
> 
>  static void octeon_icache_flush(void)
> @@ -108,44 +112,22 @@ void octeon_send_ipi_single(int cpu, unsigned int
> action) static inline void octeon_send_ipi_mask(const struct cpumask *mask,
> unsigned int action)
>  {
> -	unsigned int i;
> -
> -	for_each_cpu(i, mask)
> -		octeon_send_ipi_single(i, action);
> -}
> -
> -/**
> - * Detect available CPUs, populate cpu_possible_mask
> - */
> -static void octeon_smp_hotplug_setup(void)
> -{
> -#ifdef CONFIG_HOTPLUG_CPU
> -	struct linux_app_boot_info *labi;
> +	int cpu;
> 
> -	if (!setup_max_cpus)
> -		return;
> -
> -	labi = (struct linux_app_boot_info
> *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER); -	if (labi-
>labi_signature
> != LABI_SIGNATURE) {
> -		pr_info("The bootloader on this board does not support HOTPLUG_CPU.");
> -		return;
> -	}
> -
> -	octeon_bootloader_entry_addr = labi->InitTLBStart_addr;
> -#endif
> +	for_each_cpu(cpu, mask)
> +		octeon_send_ipi_single(cpu, action);
>  }
> 
> -static void __init octeon_smp_setup(void)
> +static void octeon_smp_setup(void)
>  {
>  	const int coreid = cvmx_get_core_num();
>  	int cpus;
>  	int id;
> -	struct cvmx_sysinfo *sysinfo = cvmx_sysinfo_get();
> -
>  #ifdef CONFIG_HOTPLUG_CPU
> -	int core_mask = octeon_get_boot_coremask();
>  	unsigned int num_cores = cvmx_octeon_num_cores();
> +	unsigned long t;
>  #endif
> +	struct cvmx_sysinfo *sysinfo = cvmx_sysinfo_get();
> 
>  	/* The present CPUs are initially just the boot cpu (CPU 0). */
>  	for (id = 0; id < NR_CPUS; id++) {
> @@ -158,7 +140,7 @@ static void __init octeon_smp_setup(void)
> 
>  	/* The present CPUs get the lowest CPU numbers. */
>  	cpus = 1;
> -	for (id = 0; id < NR_CPUS; id++) {
> +	for (id = 0; id < CONFIG_MIPS_NR_CPU_NR_MAP; id++) {
>  		if ((id != coreid) && cvmx_coremask_is_core_set(&sysinfo->core_mask, 
id))
> { set_cpu_possible(cpus, true);
>  			set_cpu_present(cpus, true);
> @@ -169,14 +151,22 @@ static void __init octeon_smp_setup(void)
>  	}
> 
>  #ifdef CONFIG_HOTPLUG_CPU
> +
> +	octeon_bootvector = cvmx_boot_vector_get();
> +	if (!octeon_bootvector) {
> +		pr_err("Error: Cannot allocate boot vector.\n");
> +		return;
> +	}
> +	t = __pa_symbol(octeon_hotplug_entry);
> +	octeon_hotplug_entry_raw = phys_to_virt(t);
> +
>  	/*
>  	 * The possible CPUs are all those present on the chip.	 We
>  	 * will assign CPU numbers for possible cores as well.	Cores
>  	 * are always consecutively numberd from 0.
>  	 */
> -	for (id = 0; setup_max_cpus && octeon_bootloader_entry_addr &&
> -		     id < num_cores && id < NR_CPUS; id++) {
> -		if (!(core_mask & (1 << id))) {
> +	for (id = 0; id < num_cores && id < NR_CPUS; id++) {
> +		if (!(cvmx_coremask_is_core_set(&sysinfo->core_mask, id))) {
>  			set_cpu_possible(cpus, true);
>  			__cpu_number_map[id] = cpus;
>  			__cpu_logical_map[cpus] = id;
> @@ -184,8 +174,6 @@ static void __init octeon_smp_setup(void)
>  		}
>  	}
>  #endif
> -
> -	octeon_smp_hotplug_setup();
>  }
> 
> 
> @@ -208,13 +196,31 @@ int plat_post_relocation(long offset)
>  static void octeon_boot_secondary(int cpu, struct task_struct *idle)
>  {
>  	int count;
> +	int node;
> +	int coreid = cpu_logical_map(cpu);
> 
> +	per_cpu(cpu_state, smp_processor_id()) = CPU_UP_PREPARE;
> +	octeon_bootvector[coreid].target_ptr = (uint64_t)octeon_hotplug_entry_raw;
> +	mb();
> +	/* Convert coreid to node,core spair and send NMI to target core */
> +	node = cvmx_coremask_core_to_node(coreid);
> +	coreid = cvmx_coremask_core_on_node(coreid);
> +	if (octeon_has_feature(OCTEON_FEATURE_CIU3))
> +		cvmx_write_csr_node(node, CVMX_CIU3_NMI, (1ull << coreid));
> +	else
> +		cvmx_write_csr(CVMX_CIU_NMI, (1 << coreid));
>  	pr_info("SMP: Booting CPU%02d (CoreId %2d)...\n", cpu,
>  		cpu_logical_map(cpu));
> 
>  	octeon_processor_sp = __KSTK_TOS(idle);
>  	octeon_processor_gp = (unsigned long)(task_thread_info(idle));
> -	octeon_processor_boot = cpu_logical_map(cpu);
> +	/* This barrier is needed to guarangee the following is done last */

s/guarangee/guarantee/

> +	mb();
> +
> +	/* Indicate which core is being brought up out of pan */
> +	octeon_processor_boot = coreid;
> +
> +	/* Push the last update out before polling */
>  	mb();
> 
>  	count = 10000;
> @@ -222,9 +228,13 @@ static void octeon_boot_secondary(int cpu, struct
> task_struct *idle) /* Waiting for processor to get the SP and GP */
>  		udelay(1);
>  		count--;
> +		mb();

Why this barrier? I presume it's to cause octeon_processor_sp to be re-read on 
each iteration? If so why not use READ_ONCE()?

There are other uncommented memory barriers too - checkpatch spots 4.

>  	}
>  	if (count == 0)
>  		pr_err("Secondary boot timeout\n");
> +
> +	octeon_processor_boot = ~0ul;
> +	mb();
>  }
> 
>  /**
> @@ -251,11 +261,24 @@ static void octeon_init_secondary(void)
>   */
>  static void __init octeon_prepare_cpus(unsigned int max_cpus)
>  {
> +	u64 mask;
> +	u64 coreid;
> +
>  	/*
>  	 * Only the low order mailbox bits are used for IPIs, leave
>  	 * the other bits alone.
>  	 */
> -	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(cvmx_get_core_num()), 0xffff);
> +	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
> +		mask = 0xff;
> +	else
> +		mask = 0xffff;
> +
> +	coreid = cvmx_get_core_num();
> +
> +	/* Clear pending mailbox interrupts */
> +	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(coreid), mask);
> +
> +	/* Attach mailbox interrupt handler */
>  	if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt,
>  			IRQF_PERCPU | IRQF_NO_THREAD, "SMP-IPI",
>  			mailbox_interrupt)) {
> @@ -270,6 +293,8 @@ static void __init octeon_prepare_cpus(unsigned int
> max_cpus) static void octeon_smp_finish(void)
>  {
>  	octeon_user_io_init();
> +	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
> +	mb();
> 
>  	/* to generate the first CPU timer interrupt */
>  	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
> @@ -278,9 +303,6 @@ static void octeon_smp_finish(void)
> 
>  #ifdef CONFIG_HOTPLUG_CPU
> 
> -/* State of each CPU. */
> -DEFINE_PER_CPU(int, cpu_state);
> -
>  static int octeon_cpu_disable(void)
>  {
>  	unsigned int cpu = smp_processor_id();
> @@ -288,9 +310,6 @@ static int octeon_cpu_disable(void)
>  	if (cpu == 0)
>  		return -EBUSY;
> 
> -	if (!octeon_bootloader_entry_addr)
> -		return -ENOTSUPP;
> -
>  	set_cpu_online(cpu, false);
>  	calculate_cpu_foreign_map();
>  	octeon_fixup_irqs();
> @@ -303,40 +322,8 @@ static int octeon_cpu_disable(void)
> 
>  static void octeon_cpu_die(unsigned int cpu)
>  {
> -	int coreid = cpu_logical_map(cpu);
> -	uint32_t mask, new_mask;
> -	const struct cvmx_bootmem_named_block_desc *block_desc;
> -
>  	while (per_cpu(cpu_state, cpu) != CPU_DEAD)
>  		cpu_relax();
> -
> -	/*
> -	 * This is a bit complicated strategics of getting/settig available
> -	 * cores mask, copied from bootloader
> -	 */
> -
> -	mask = 1 << coreid;
> -	/* LINUX_APP_BOOT_BLOCK is initialized in bootoct binary */
> -	block_desc = cvmx_bootmem_find_named_block(LINUX_APP_BOOT_BLOCK_NAME);
> -
> -	if (!block_desc) {
> -		struct linux_app_boot_info *labi;
> -
> -		labi = (struct linux_app_boot_info
> *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER); -
> -		labi->avail_coremask |= mask;
> -		new_mask = labi->avail_coremask;
> -	} else {		       /* alternative, already initialized */
> -		uint32_t *p = (uint32_t *)PHYS_TO_XKSEG_CACHED(block_desc->base_addr +
> -							       
AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK);
> -		*p |= mask;
> -		new_mask = *p;
> -	}
> -
> -	pr_info("Reset core %d. Available Coremask = 0x%x \n", coreid, new_mask);
> -	mb();
> -	cvmx_write_csr(CVMX_CIU_PP_RST, 1 << coreid);
> -	cvmx_write_csr(CVMX_CIU_PP_RST, 0);
>  }
> 
>  void play_dead(void)
> @@ -344,71 +331,19 @@ void play_dead(void)
>  	int cpu = cpu_number_map(cvmx_get_core_num());
> 
>  	idle_task_exit();
> -	octeon_processor_boot = 0xff;
>  	per_cpu(cpu_state, cpu) = CPU_DEAD;
> -
>  	mb();
> -
> -	while (1)	/* core will be reset here */
> -		;
> -}
> -
> -static void start_after_reset(void)
> -{
> -	kernel_entry(0, 0, 0);	/* set a2 = 0 for secondary core */
> -}
> -
> -static int octeon_update_boot_vector(unsigned int cpu)
> -{
> -
> -	int coreid = cpu_logical_map(cpu);
> -	uint32_t avail_coremask;
> -	const struct cvmx_bootmem_named_block_desc *block_desc;
> -	struct boot_init_vector *boot_vect =
> -		(struct boot_init_vector 
*)PHYS_TO_XKSEG_CACHED(BOOTLOADER_BOOT_VECTOR);
> -
> -	block_desc = cvmx_bootmem_find_named_block(LINUX_APP_BOOT_BLOCK_NAME);
> -
> -	if (!block_desc) {
> -		struct linux_app_boot_info *labi;
> -
> -		labi = (struct linux_app_boot_info
> *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER); -
> -		avail_coremask = labi->avail_coremask;
> -		labi->avail_coremask &= ~(1 << coreid);
> -	} else {		       /* alternative, already initialized */
> -		avail_coremask = *(uint32_t *)PHYS_TO_XKSEG_CACHED(
> -			block_desc->base_addr + 
AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK);
> +	local_irq_disable();
> +	while (1) {	/* core will be reset here */
> +		asm volatile ("nop\n"
> +			      "	wait\n"
> +			      "	nop\n");

Are the nops necessary? If so could you add a comment saying why?

>  	}
> -
> -	if (!(avail_coremask & (1 << coreid))) {
> -		/* core not available, assume, that caught by simple-executive */
> -		cvmx_write_csr(CVMX_CIU_PP_RST, 1 << coreid);
> -		cvmx_write_csr(CVMX_CIU_PP_RST, 0);
> -	}
> -
> -	boot_vect[coreid].app_start_func_addr =
> -		(uint32_t) (unsigned long) start_after_reset;
> -	boot_vect[coreid].code_addr = octeon_bootloader_entry_addr;
> -
> -	mb();
> -
> -	cvmx_write_csr(CVMX_CIU_NMI, (1 << coreid) & avail_coremask);
> -
> -	return 0;
> -}
> -
> -static int register_cavium_notifier(void)
> -{
> -	return cpuhp_setup_state_nocalls(CPUHP_MIPS_SOC_PREPARE,
> -					 "mips/cavium:prepare",
> -					 octeon_update_boot_vector, NULL);
>  }
> -late_initcall(register_cavium_notifier);
> 
>  #endif	/* CONFIG_HOTPLUG_CPU */
> 
> -struct plat_smp_ops octeon_smp_ops = {
> +static struct plat_smp_ops octeon_smp_ops = {
>  	.send_ipi_single	= octeon_send_ipi_single,
>  	.send_ipi_mask		= octeon_send_ipi_mask,
>  	.init_secondary		= octeon_init_secondary,
> diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h index
> c38b38c..5093a2f 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> @@ -3,11 +3,13 @@
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
>   *
> - * Copyright (C) 2005-2008 Cavium Networks, Inc
> + * Copyright (C) 2005-2017 Cavium, Inc
>   */
>  #ifndef __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
>  #define __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
> 
> +#include <asm/octeon/cvmx-asm.h>
> +
>  #define CP0_CVMCTL_REG $9, 7
>  #define CP0_CVMMEMCTL_REG $11,7
>  #define CP0_PRID_REG $15, 0
> @@ -26,6 +28,131 @@
>  	# a3 = address of boot descriptor block
>  	.set push
>  	.set arch=octeon
> +#ifdef CONFIG_HOTPLUG_CPU
> +	b	7f
> +FEXPORT(octeon_hotplug_entry)
> +	move	a0, zero
> +	move	a1, zero
> +	move	a2, zero
> +	move	a3, zero
> +7:
> +#endif	/* CONFIG_HOTPLUG_CPU */
> +	mfc0	v0, CP0_STATUS
> +	/* Force 64-bit addressing enabled */
> +	ori	v0, v0, (ST0_UX | ST0_SX | ST0_KX)
> +	/* Clear NMI and SR as they are sometimes restored and 0 -> 1
> +	 * transitions are not allowed
> +	 */
> +	li	v1, ~(ST0_NMI | ST0_SR)
> +	and	v0, v1
> +	mtc0	v0, CP0_STATUS
> +
> +	# Clear the TLB.
> +	mfc0	v0, $16, 1	# Config1

s/$16/CP0_CONFIG/ ? Below too.

> +	dsrl	v0, v0, 25
> +	andi	v0, v0, 0x3f

ext v0, v0, MIPS_CONF1_TLBS_SHIFT, MIPS_CONF1_TLBS_SIZE?

Or at least use the field macros with your shift & and.

> +	mfc0	v1, $16, 3	# Config3
> +	bgez	v1, 1f
> +	mfc0	v1, $16, 4	# Config4
> +	andi	v1, 0x7f

Is this reading MMUSizeExt? Note that's 8 bits, not 7. Why not:

andi v1, v1, MIPS_CONF4_MMUSIZEEXT

> +	dsll	v1, 6
> +	or	v0, v0, v1

ins v0, v1, MIPS_CONF1_TLBS_SIZE, MIPS_CONF4_MMUSIZEEXT_SIZE?

Would need to add MIPS_CONF4_MMUSIZEEXT_SIZE for that.

> +1:				# Number of TLBs in v0
> +
> +	dmtc0	zero, $2, 0	# EntryLo0
> +	dmtc0	zero, $3, 0	# EntryLo1
> +	dmtc0	zero, $5, 0	# PageMask
> +	dla	t0, 0xffffffff90000000
> +10:
> +	dmtc0	t0, $10, 0	# EntryHi
> +	tlbp
> +	mfc0	t1, $0, 0	# Index
> +	bltz	t1, 1f
> +	tlbr
> +	dmtc0	zero, $2, 0	# EntryLo0
> +	dmtc0	zero, $3, 0	# EntryLo1
> +	dmtc0	zero, $5, 0	# PageMask
> +	tlbwi			# Make it a 'normal' sized page
> +	daddiu	t0, t0, 8192
> +	b	10b
> +1:
> +	mtc0	v0, $0, 0	# Index
> +	tlbwi
> +	.set	noreorder
> +	bne	v0, zero, 10b
> +	 addiu	v0, v0, -1
> +	.set	reorder
> +
> +	mtc0	zero, $0, 0	# Index
> +	dmtc0	zero, $10, 0	# EntryHi
> +
> +#ifdef CONFIG_MAPPED_KERNEL

Octeon doesn't support CONFIG_MAPPED_KERNEL, at least not upstream. Please 
remove this - it can be added later if you submit CONFIG_MAPPED_KERNEL support 
upstream.

> +	# Set up the TLB index 0 for wired access to kernel.
> +	# Assume we were loaded with sufficient alignment so that we
> +	# can cover the image with two pages.
> +	dla	v0, _end
> +	dla	s0, _text
> +	dsubu	v0, v0, s0	# size of image
> +	move	v1, zero
> +	li	t1, -1		# shift count.
> +1:	dsrl	v0, v0, 1	# mask into v1
> +	dsll	v1, v1, 1
> +	daddiu	t1, t1, 1
> +	ori	v1, v1, 1
> +	bne	v0, zero, 1b
> +	daddiu	t2, t1, -6
> +	mtc0	v1, $5, 0	# PageMask
> +	dla	t3, 0xffffffffc0000000 # kernel address
> +	dmtc0	t3, $10, 0	# EntryHi
> +	.set push
> +	.set noreorder
> +	.set nomacro
> +	bal	1f
> +	nop
> +1:
> +	.set pop
> +
> +	dsra	v0, ra, 31
> +	daddiu	v0, v0, 1	# if it were a ckseg0 address v0 will be zero.
> +	beqz	v0, 3f
> +	dli	v0, 0x07ffffffffffffff	# Otherwise assume xkphys.
> +	b	2f
> +3:
> +	dli	v0, 0x7fffffff
> +
> +2:	and	ra, ra, v0	# physical address of pc in ra
> +	dla	v0, 1b
> +	dsubu	v0, v0, s0	# distance from _text to 1: in v0
> +	dsubu	ra, ra, v0	# ra is physical address of _text
> +	dsrl	v1, v1, 1
> +	nor	v1, v1, zero
> +	and	ra, ra, v1	# mask it with the page mask
> +	dsubu	v1, t3, ra	# virtual to physical offset into v1
> +	dsrlv	v0, ra, t1
> +	dsllv	v0, v0, t2
> +	ori	v0, v0, 0x1f
> +	dmtc0	v0, $2, 0  # EntryLo1
> +	dsrlv	v0, ra, t1
> +	daddiu	v0, v0, 1
> +	dsllv	v0, v0, t2
> +	ori	v0, v0, 0x1f
> +	dmtc0	v0, $3, 0  # EntryLo2
> +	mtc0	$0, $0, 0  # Set index to zero
> +	tlbwi
> +	li	v0, 1
> +	mtc0	v0, $6, 0  # Wired
> +	dla	v0, phys_to_kernel_offset
> +	sd	v1, 0(v0)
> +	dla	v0, kernel_image_end
> +	li	v1, 2
> +	dsllv	v1, v1, t1
> +	daddu	v1, v1, t3
> +	sd	v1, 0(v0)
> +#endif
> +	dla	v0, continue_in_mapped_space
> +	jr	v0
> +
> +continue_in_mapped_space:
>  	# Read the cavium mem control register
>  	dmfc0	v0, CP0_CVMMEMCTL_REG
>  	# Clear the lower 6 bits, the CVMSEG size
> diff --git a/arch/mips/include/asm/octeon/cvmx-coremask.h
> b/arch/mips/include/asm/octeon/cvmx-coremask.h index 097dc09..a4de3c2
> 100644
> --- a/arch/mips/include/asm/octeon/cvmx-coremask.h
> +++ b/arch/mips/include/asm/octeon/cvmx-coremask.h
> @@ -29,7 +29,6 @@
>  #ifndef __CVMX_COREMASK_H__
>  #define __CVMX_COREMASK_H__
> 
> -#define CVMX_MIPS_MAX_CORES 1024
>  /* bits per holder */
>  #define CVMX_COREMASK_ELTSZ 64
> 
> @@ -86,4 +85,29 @@ static inline void cvmx_coremask_clear_core(struct
> cvmx_coremask *pcm, int core) pcm->coremask_bitmap[i] &= ~(1ull << n);
>  }
> 
> +/**
> + * For multi-node systems, return the node a core belongs to.
> + *
> + * @param core - core number (0-1023)
> + *
> + * @return node number core belongs to
> + */
> +static inline int cvmx_coremask_core_to_node(int core)
> +{
> +	return (core >> CVMX_NODE_NO_SHIFT) & CVMX_NODE_MASK;
> +}
> +
> +/**
> + * Given a core number on a multi-node system, return the core number for a
> + * particular node.
> + *
> + * @param core - global core number
> + *
> + * @returns core number local to the node.
> + */
> +static inline int cvmx_coremask_core_on_node(int core)
> +{
> +	return (core & ((1 << CVMX_NODE_NO_SHIFT) - 1));

core & GENMASK(CVMX_NODE_NO_SHIFT - 1, 0) ?

> +}
> +
>  #endif /* __CVMX_COREMASK_H__ */
> diff --git a/arch/mips/include/asm/octeon/cvmx.h
> b/arch/mips/include/asm/octeon/cvmx.h index 1c0a929..455d4f54 100644
> --- a/arch/mips/include/asm/octeon/cvmx.h
> +++ b/arch/mips/include/asm/octeon/cvmx.h
> @@ -53,6 +53,17 @@ enum cvmx_mips_space {
>  #define CVMX_ADD_IO_SEG(add) CVMX_ADD_SEG(CVMX_IO_SEG, (add))
>  #endif
> 
> +#define CVMX_MAX_CORES		(48)
> +#define CVMX_MIPS_MAX_CORE_BITS	(10)    /** Maximum # of bits to define
> cores */ +#define CVMX_MIPS_MAX_CORES	(1 << CVMX_MIPS_MAX_CORE_BITS)
> +#define CVMX_NODE_NO_SHIFT	(7)     /* Maximum # of bits to define core in
> node */ +#define CVMX_NODE_BITS		(2)     /* Number of bits to define a 
node
> */ +#define CVMX_NODE_MASK		(CVMX_MAX_NODES - 1)
> +#define CVMX_MAX_NODES		(1 << CVMX_NODE_BITS)
> +#define CVMX_NODE_IO_SHIFT	(36)
> +#define CVMX_NODE_MEM_SHIFT	(40)
> +#define CVMX_NODE_IO_MASK	((uint64_t)CVMX_NODE_MASK << 
CVMX_NODE_IO_SHIFT)
> +
>  #include <asm/octeon/cvmx-asm.h>
>  #include <asm/octeon/octeon-model.h>
> 
> @@ -83,7 +94,6 @@ enum cvmx_mips_space {
>  #define cvmx_dprintf(...)   {}
>  #endif
> 
> -#define CVMX_MAX_CORES		(16)
>  #define CVMX_CACHE_LINE_SIZE	(128)	/* In bytes */
>  #define CVMX_CACHE_LINE_MASK	(CVMX_CACHE_LINE_SIZE - 1)	/* In bytes */
>  #define CVMX_CACHE_LINE_ALIGNED __attribute__
> ((aligned(CVMX_CACHE_LINE_SIZE))) @@ -361,16 +371,11 @@ static inline
> unsigned int cvmx_get_core_num(void) return core_num;
>  }
> 
> -/* Maximum # of bits to define core in node */
> -#define CVMX_NODE_NO_SHIFT	7
> -#define CVMX_NODE_MASK		0x3
>  static inline unsigned int cvmx_get_node_num(void)
>  {
>  	unsigned int core_num = cvmx_get_core_num();
> -
>  	return (core_num >> CVMX_NODE_NO_SHIFT) & CVMX_NODE_MASK;
>  }
> -
>  static inline unsigned int cvmx_get_local_core_num(void)
>  {
>  	return cvmx_get_core_num() & ((1 << CVMX_NODE_NO_SHIFT) - 1);
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c722cbf..b68708e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1511,6 +1511,7 @@ config TXX9_WDT
>  config OCTEON_WDT
>  	tristate "Cavium OCTEON SOC family Watchdog Timer"
>  	depends on CAVIUM_OCTEON_SOC
> +	depends on CPU_BIG_ENDIAN || !HOTPLUG_CPU

This could at least use a mention in the commit message explaining why the 
watchdog doesn't work with little endian & hotplug.

>  	default y
>  	select WATCHDOG_CORE
>  	select EXPORT_UASM if OCTEON_WDT = m

Thanks,
    Paul
--nextPart8099733.ElioabnMon
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlnD+QMACgkQgiDZ+mk8
HGXp3A//cRdA2KQwdiF0s0L+zsAhVaaujnI1RiDh9LQsMuDbS1UsAV8itPgSk6Ip
PKszPsq3wGAg5zt5a+CX2DO8/UqSXLaoKRH6dv+Eh1AcI41QdS8qWJq/VrOQ5Aby
NjzJoJ7fiDuCuXjCJNDzF3CpSwOBn+HMpiKCISZzNZQpT4VLvPtxFNsKWroLBCjp
3wUAtthnCdhb++KaLlnA85/DKvbMHYe1/OdqvALIVWuEbWVmbujvk/Hx3azwkzqo
PBCT2zA8NMD2MduZIT95dekl5xtcrA10fAlTuaUoc8N90dUIWOwvUtNi2KlBon4J
IInukb1xV823QiMkLRdTKtJVPeVQMDuFDB1qmoqE2zkI6bWCkZX+BsamPIenBSNy
FvWBUIeGxvAhmW4rISY9+17k4oF2IwSixBByJ520Rw0ZW2UEDbh4dQjtuoBAfkgD
YcTV5ohKKECbISn4Dwi0Pu4aJvv5jFn8SpdrkO+BR/dNLox+n12sgPdhueLFf89q
Hlp0ckhIKoLkjuQEkzQExyLA92F9QitnJ71zK6Vzc/TgehwvaWvp8OJeWXc3QvAZ
orfu4sxma54gzsF6vHPveQ2dvSqqW+IjMgw92iW8dJc7a2aqqfgZOPyqOt3hxpa6
7qCqFAR3KFrvjEPoevIdttXmSDAnxmGQ1OSqtrMd+HjOeD9ZbSU=
=KDt4
-----END PGP SIGNATURE-----

--nextPart8099733.ElioabnMon--
