Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2016 17:49:32 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8079 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993299AbcKXQtZOml3b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Nov 2016 17:49:25 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9514D63C0AD8B;
        Thu, 24 Nov 2016 16:49:14 +0000 (GMT)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 24 Nov
 2016 16:49:17 +0000
Subject: Re: [PATCH v2 5/5] MIPS: OCTEON: Enable KASLR
To:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>
References: <d760ef90-ad22-dff7-14b6-2bc6af5a6745@cavium.com>
CC:     <ralf@linux-mips.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <da9ddbee-2e23-6ff3-6b9e-8dd23d7dd70e@imgtec.com>
Date:   Thu, 24 Nov 2016 16:49:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <d760ef90-ad22-dff7-14b6-2bc6af5a6745@cavium.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi Steven,


On 23/11/16 12:26, Steven J. Hill wrote:
> Add KASLR to be selected on OCTEON systems.
>
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> ---
>   arch/mips/Kconfig                                  |  3 +-
>   arch/mips/cavium-octeon/smp.c                      | 42 ++++++++++++++++++++++
>   .../asm/mach-cavium-octeon/kernel-entry-init.h     |  7 ++--
>   arch/mips/kernel/relocate.c                        | 17 +++++++++
>   arch/mips/kernel/setup.c                           |  4 ++-
>   5 files changed, 69 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 2638856..323d51c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -892,6 +892,7 @@ config CAVIUM_OCTEON_SOC
>   	select NR_CPUS_DEFAULT_16
>   	select BUILTIN_DTB
>   	select MTD_COMPLEX_MAPPINGS
> +	select SYS_SUPPORTS_RELOCATABLE
>   	help
>   	  This option supports all of the Octeon reference boards from Cavium
>   	  Networks. It builds a kernel that dynamically determines the Octeon
> @@ -2535,7 +2536,7 @@ config SYS_SUPPORTS_NUMA
>
>   config RELOCATABLE
>   	bool "Relocatable kernel"
> -	depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6)
> +	depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6 || CAVIUM_OCTEON_SOC)
>   	help
>   	  This builds a kernel image that retains relocation information
>   	  so it can be loaded someplace besides the default 1MB.
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index 4d457d60..4ac97a3 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -12,10 +12,12 @@
>   #include <linux/kernel_stat.h>
>   #include <linux/sched.h>
>   #include <linux/module.h>
> +#include <linux/bootmem.h>
>
>   #include <asm/mmu_context.h>
>   #include <asm/time.h>
>   #include <asm/setup.h>
> +#include <asm/sections.h>
>
>   #include <asm/octeon/octeon.h>
>
> @@ -24,6 +26,7 @@
>   volatile unsigned long octeon_processor_boot = 0xff;
>   volatile unsigned long octeon_processor_sp;
>   volatile unsigned long octeon_processor_gp;
> +volatile unsigned long octeon_processor_smpentry;
>
>   #ifdef CONFIG_HOTPLUG_CPU
>   uint64_t octeon_bootloader_entry_addr;
> @@ -180,6 +183,23 @@ static void __init octeon_smp_setup(void)
>   	octeon_smp_hotplug_setup();
>   }
>
> +#ifdef CONFIG_RELOCATABLE
> +static long relocation_offset __initdata;
> +
> +void __init plat_save_relocation(long offset)
> +{
> +	relocation_offset = offset;
> +}
> +
> +void __init RELOCATE(volatile unsigned long *addr, unsigned long val)
> +{
> +	unsigned long *p;
> +
> +	p = (unsigned long *) ((unsigned long)addr - relocation_offset);
> +	*p = val;
> +}
> +#endif
> +
>   /**
>    * Firmware CPU startup hook
>    *
> @@ -191,9 +211,17 @@ static void octeon_boot_secondary(int cpu, struct task_struct *idle)
>   	pr_info("SMP: Booting CPU%02d (CoreId %2d)...\n", cpu,
>   		cpu_logical_map(cpu));
>
> +#ifndef CONFIG_RELOCATABLE
>   	octeon_processor_sp = __KSTK_TOS(idle);
>   	octeon_processor_gp = (unsigned long)(task_thread_info(idle));
>   	octeon_processor_boot = cpu_logical_map(cpu);
> +	octeon_processor_smpentry = (unsigned long)&smp_bootstrap;

I think you should probably set octeon_processor_boot last, otherwise 
this CPU is racing with the secondary CPU to see it's entry point.

> +#else
> +	RELOCATE(&octeon_processor_sp, __KSTK_TOS(idle));
> +	RELOCATE(&octeon_processor_gp, (unsigned long)(task_thread_info(idle)));
> +	RELOCATE(&octeon_processor_boot, cpu_logical_map(cpu));
> +	RELOCATE(&octeon_processor_smpentry, (unsigned long)&smp_bootstrap);
> +#endif

This is a bit kludgy, to have the secondaries spinning in the initial 
kernel, then have the boot cpu, running the relocated kernel, work out 
the address those cpus are monitoring in the original kernel such that 
they can be switched to the new one.
I think it would be better to set up some indirection such that the boot 
cpu, having relocated the kernel, can update the address that the 
secondary cpus are monitoring. That way you avoid most of the changes to 
the generic relocation code and just add a platform hook once relocation 
has completed successfully. In the Octeon case you'd use it to update 
the memory address that the secondary CPUs monitor to find their startup 
information.

>   	mb();
>
>   	count = 10000;
> @@ -204,6 +232,20 @@ static void octeon_boot_secondary(int cpu, struct task_struct *idle)
>   	}
>   	if (count == 0)
>   		pr_err("Secondary boot timeout\n");
> +
> +#ifdef CONFIG_RELOCATABLE
> +	/*
> +	 * The last present CPU is now running in the relocated
> +	 * kernel code. We can free up the bootmem pages.
> +	 */
> +	if ((num_present_cpus() - 1) == cpu) {
> +		unsigned long offset;
> +
> +		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
> +		free_bootmem_late(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
> +		relocation_offset = 0;
> +	}
> +#endif

I see why this has to be done, but what if one boots with "nosmp"? Since 
the secondaries are not started all memory between the original and 
relocated kernel will be leaked.

>   }
>
>   /**
> diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> index c4873e8..981d072 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> @@ -113,6 +113,9 @@ octeon_spin_wait_boot:
>   	# Get my SP from the global variable
>   	PTR_LA	t0, octeon_processor_sp
>   	LONG_L	sp, (t0)
> +	# Get my SMPENTRY target from the global variable
> +	PTR_LA	t0, octeon_processor_smpentry
> +	LONG_L	t1, (t0)
>   	# Set the SP global variable to zero so the master knows we've started
>   	LONG_S	zero, (t0)
>   #ifdef __OCTEON__
> @@ -121,8 +124,8 @@ octeon_spin_wait_boot:
>   #else
>   	sync
>   #endif
> -	# Jump to the normal Linux SMP entry point
> -	j   smp_bootstrap
> +	# Jump to the normal Linux SMP entry point (smp_bootstrap)
> +	jr	t1
>   	nop
>   #else /* CONFIG_SMP */
>
> diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
> index ca1cc30..250ff9c 100644
> --- a/arch/mips/kernel/relocate.c
> +++ b/arch/mips/kernel/relocate.c
> @@ -31,6 +31,20 @@ extern u32 _relocation_end[];	/* End relocation table */
>   extern long __start___ex_table;	/* Start exception table */
>   extern long __stop___ex_table;	/* End exception table */
>
> +
> +/*
> + * Declare this function weak so the platform can choose if they
> + * want the kernel relocation offset.
> + *
> + * WARNING!!!	This is a potential security risk if the platform
> + *		function does not zero out the value before getting
> + *		to userspace!
> + */
> +void __weak plat_save_relocation(long offset)
> +{
> +	/* Do nothing... */
> +}
> +
>   static inline u32 __init get_synci_step(void)
>   {
>   	u32 res;
> @@ -316,6 +330,9 @@ void *__init relocate_kernel(void)
>   	arcs_cmdline[0] = '\0';
>
>   	if (offset) {
> +		/* Save the relocation offset value. */
> +		plat_save_relocation(offset);

So you save the relocation offset here into a variable located in the 
.bss, such that when the .bss is copied a few lines further on, the 
offset will be present for the new kernel.
There is an issue with this - if relocation fails for any reason, the 
boot CPU will go on to execute the original kernel, but when starting 
the secondaries it will apply the now invalid offset and access some 
invalid location.

I don't see why the new kernel could figure out the offset for itself by 
with

offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);

eliminating the need for plat_save_relocation().

> +
>   		/* Copy the kernel to it's new location */
>   		memcpy(loc_new, &_text, kernel_length);
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 36cf8d6..582c711 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -501,11 +501,13 @@ static void __init bootmem_init(void)
>   	 * between the original and new locations may be returned to the system.
>   	 */
>   	if (__pa_symbol(_text) > __pa_symbol(VMLINUX_LOAD_ADDRESS)) {
> -		unsigned long offset;
>   		extern void show_kernel_relocation(const char *level);
> +#ifndef CONFIG_CAVIUM_OCTEON_SOC
> +		unsigned long offset;
>
>   		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
>   		free_bootmem(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
> +#endif

Rather than add ifdeffery here, I'd rather see a function something like 
plat_free_original_kernel() with a weak default implementation that does 
this. In an ideal world though you'd have a different mechanism of 
starting secondaries such that you didn't have to delay freeing the 
original kernel until all cpus have started (as I said earlier, there 
are circumstances in which all of this memory would leak).

>
>   #if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
>   		/*

If you added the indirection to the secondary boot process, most of 
these changes would not be necessary. I think the only generic change 
would be adding a post relocation platform hook.

Thanks,
Matt
