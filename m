Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2014 18:20:40 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33148 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6867612AbaCRRUe1CVCt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Mar 2014 18:20:34 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s2IHKOW5031416;
        Tue, 18 Mar 2014 18:20:24 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s2IHKLE1031377;
        Tue, 18 Mar 2014 18:20:21 +0100
Date:   Tue, 18 Mar 2014 18:20:21 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V19 12/13] MIPS: Loongson 3: Add CPU hotplug support
Message-ID: <20140318172021.GG17197@linux-mips.org>
References: <1392537690-5961-1-git-send-email-chenhc@lemote.com>
 <1392537690-5961-13-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392537690-5961-13-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sun, Feb 16, 2014 at 04:01:29PM +0800, Huacai Chen wrote:
> Date:   Sun, 16 Feb 2014 16:01:29 +0800
> From: Huacai Chen <chenhc@lemote.com>
> To: Ralf Baechle <ralf@linux-mips.org>
> Cc: John Crispin <john@phrozen.org>, "Steven J. Hill"
>  <Steven.Hill@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>,
>  linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>, Zhangjin Wu
>  <wuzhangjin@gmail.com>, Huacai Chen <chenhc@lemote.com>, Hongliang Tao
>  <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
> Subject: [PATCH V19 12/13] MIPS: Loongson 3: Add CPU hotplug support
> 
> Tips of Loongson's CPU hotplug:
> 1, To fully shutdown a core in Loongson 3, the target core should go to
>    CKSEG1 and flush all L1 cache entries at first. Then, another core
>    (usually Core 0) can safely disable the clock of the target core. So
>    play_dead() call loongson3_play_dead() via CKSEG1 (both uncached and
>    unmmaped).
> 2, The default clocksource of Loongson is MIPS. Since clock source is a
>    global device, timekeeping need the CP0' Count registers of each core
>    be synchronous. Thus, when a core is up, we use a SMP_ASK_C0COUNT IPI
>    to ask Core-0's Count.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> Tested-by: Alex Smith <alex.smith@imgtec.com>
> Reviewed-by: Alex Smith <alex.smith@imgtec.com>
> ---
>  arch/mips/include/asm/mach-loongson/irq.h      |    1 +
>  arch/mips/include/asm/mach-loongson/loongson.h |    6 +-
>  arch/mips/include/asm/smp.h                    |    1 +
>  arch/mips/loongson/Kconfig                     |    1 +
>  arch/mips/loongson/loongson-3/irq.c            |   10 ++
>  arch/mips/loongson/loongson-3/smp.c            |  171 +++++++++++++++++++++++-
>  6 files changed, 185 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/include/asm/mach-loongson/irq.h b/arch/mips/include/asm/mach-loongson/irq.h
> index e2568d6..e45e4f5 100644
> --- a/arch/mips/include/asm/mach-loongson/irq.h
> +++ b/arch/mips/include/asm/mach-loongson/irq.h
> @@ -37,6 +37,7 @@
>  
>  #endif
>  
> +extern void fixup_irqs(void);
>  extern void loongson3_ipi_interrupt(struct pt_regs *regs);
>  
>  #include_next <irq.h>
> diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
> index f185907..f3fd1eb 100644
> --- a/arch/mips/include/asm/mach-loongson/loongson.h
> +++ b/arch/mips/include/asm/mach-loongson/loongson.h
> @@ -249,6 +249,9 @@ static inline void do_perfcnt_IRQ(void)
>  #define LOONGSON_PXARB_CFG		LOONGSON_REG(LOONGSON_REGBASE + 0x68)
>  #define LOONGSON_PXARB_STATUS		LOONGSON_REG(LOONGSON_REGBASE + 0x6c)
>  
> +/* Chip Config */
> +#define LOONGSON_CHIPCFG0		LOONGSON_REG(LOONGSON_REGBASE + 0x80)
> +
>  /* pcimap */
>  
>  #define LOONGSON_PCIMAP_PCIMAP_LO0	0x0000003f
> @@ -264,9 +267,6 @@ static inline void do_perfcnt_IRQ(void)
>  #ifdef CONFIG_CPU_SUPPORTS_CPUFREQ
>  #include <linux/cpufreq.h>
>  extern struct cpufreq_frequency_table loongson2_clockmod_table[];
> -
> -/* Chip Config */
> -#define LOONGSON_CHIPCFG0		LOONGSON_REG(LOONGSON_REGBASE + 0x80)
>  #endif
>  
>  /*
> diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
> index eb60087..efa02ac 100644
> --- a/arch/mips/include/asm/smp.h
> +++ b/arch/mips/include/asm/smp.h
> @@ -42,6 +42,7 @@ extern int __cpu_logical_map[NR_CPUS];
>  #define SMP_ICACHE_FLUSH	0x4
>  /* Used by kexec crashdump to save all cpu's state */
>  #define SMP_DUMP		0x8
> +#define SMP_ASK_C0COUNT		0x10
>  
>  extern volatile cpumask_t cpu_callin_map;
>  
> diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
> index a5d46f5..7397be2 100644
> --- a/arch/mips/loongson/Kconfig
> +++ b/arch/mips/loongson/Kconfig
> @@ -79,6 +79,7 @@ config LEMOTE_MACH3A
>  	select SYS_HAS_CPU_LOONGSON3
>  	select SYS_HAS_EARLY_PRINTK
>  	select SYS_SUPPORTS_SMP
> +	select SYS_SUPPORTS_HOTPLUG_CPU
>  	select SYS_SUPPORTS_64BIT_KERNEL
>  	select SYS_SUPPORTS_HIGHMEM
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
> diff --git a/arch/mips/loongson/loongson-3/irq.c b/arch/mips/loongson/loongson-3/irq.c
> index f26e68e..c76a740 100644
> --- a/arch/mips/loongson/loongson-3/irq.c
> +++ b/arch/mips/loongson/loongson-3/irq.c
> @@ -113,3 +113,13 @@ void __init mach_init_irq(void)
>  
>  	set_c0_status(STATUSF_IP2 | STATUSF_IP6);
>  }
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +
> +void fixup_irqs(void)
> +{
> +	irq_cpu_offline();
> +	clear_c0_status(ST0_IM);
> +}
> +
> +#endif
> diff --git a/arch/mips/loongson/loongson-3/smp.c b/arch/mips/loongson/loongson-3/smp.c
> index 93483c2..83e6ea5 100644
> --- a/arch/mips/loongson/loongson-3/smp.c
> +++ b/arch/mips/loongson/loongson-3/smp.c
> @@ -23,10 +23,14 @@
>  #include <asm/time.h>
>  #include <asm/clock.h>
>  #include <asm/tlbflush.h>
> +#include <asm/cacheflush.h>
>  #include <loongson.h>
>  
>  #include "smp.h"
>  
> +DEFINE_PER_CPU(int, cpu_state);
> +DEFINE_PER_CPU(uint32_t, core0_c0count);
> +
>  /* read a 32bit value from ipi register */
>  #define loongson3_ipi_read32(addr) readl(addr)
>  /* read a 64bit value from ipi register */
> @@ -158,8 +162,8 @@ loongson3_send_ipi_mask(const struct cpumask *mask, unsigned int action)
>  
>  void loongson3_ipi_interrupt(struct pt_regs *regs)
>  {
> -	int cpu = smp_processor_id();
> -	unsigned int action;
> +	int i, cpu = smp_processor_id();
> +	unsigned int action, c0count;
>  
>  	/* Load the ipi register to figure out what we're supposed to do */
>  	action = loongson3_ipi_read32(ipi_status0_regs[cpu]);
> @@ -172,14 +176,24 @@ void loongson3_ipi_interrupt(struct pt_regs *regs)
>  
>  	if (action & SMP_CALL_FUNCTION)
>  		smp_call_function_interrupt();
> +
> +	if (action & SMP_ASK_C0COUNT) {
> +		BUG_ON(cpu != 0);
> +		c0count = read_c0_count();
> +		for (i = 1; i < loongson_sysconf.nr_cpus; i++)
> +			per_cpu(core0_c0count, i) = c0count;
> +	}
>  }
>  
> +#define MAX_LOOPS 1111
>  /*
>   * SMP init and finish on secondary CPUs
>   */
>  static void loongson3_init_secondary(void)
>  {
>  	int i;
> +	uint32_t initcount;
> +	unsigned int cpu = smp_processor_id();
>  	unsigned int imask = STATUSF_IP7 | STATUSF_IP6 |
>  			     STATUSF_IP3 | STATUSF_IP2;
>  
> @@ -188,6 +202,21 @@ static void loongson3_init_secondary(void)
>  
>  	for (i = 0; i < loongson_sysconf.nr_cpus; i++)
>  		loongson3_ipi_write32(0xffffffff, ipi_en0_regs[i]);
> +
> +	per_cpu(cpu_state, cpu) = CPU_ONLINE;
> +
> +	i = 0;
> +	__get_cpu_var(core0_c0count) = 0;
> +	loongson3_send_ipi_single(0, SMP_ASK_C0COUNT);
> +	while (!__get_cpu_var(core0_c0count)) {
> +		i++;
> +		cpu_relax();
> +	}
> +
> +	if (i > MAX_LOOPS)
> +		i = MAX_LOOPS;
> +	initcount = __get_cpu_var(core0_c0count) + i;
> +	write_c0_count(initcount);
>  }
>  
>  static void loongson3_smp_finish(void)
> @@ -222,6 +251,8 @@ static void __init loongson3_smp_setup(void)
>  
>  static void __init loongson3_prepare_cpus(unsigned int max_cpus)
>  {
> +	init_cpu_present(cpu_possible_mask);
> +	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
>  }
>  
>  /*
> @@ -255,6 +286,138 @@ static void __init loongson3_cpus_done(void)
>  {
>  }
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +
> +static int loongson3_cpu_disable(void)
> +{
> +	unsigned long flags;
> +	unsigned int cpu = smp_processor_id();
> +
> +	if (cpu == 0)
> +		return -EBUSY;
> +
> +	set_cpu_online(cpu, false);
> +	cpu_clear(cpu, cpu_callin_map);
> +	local_irq_save(flags);
> +	fixup_irqs();
> +	local_irq_restore(flags);
> +	flush_cache_all();
> +	local_flush_tlb_all();
> +
> +	return 0;
> +}
> +
> +
> +static void loongson3_cpu_die(unsigned int cpu)
> +{
> +	while (per_cpu(cpu_state, cpu) != CPU_DEAD)
> +		cpu_relax();
> +
> +	mb();
> +}
> +
> +/* To shutdown a core in Loongson 3, the target core should go to CKSEG1 and
> + * flush all L1 entries at first. Then, another core (usually Core 0) can
> + * safely disable the clock of the target core. loongson3_play_dead() is
> + * called via CKSEG1 (uncached and unmmaped) */
> +static void loongson3_play_dead(int *state_addr)
> +{
> +	__asm__ __volatile__(
> +		"   .set push                     \n"
> +		"   .set noreorder                \n"
> +		"   li $t0, 0x80000000            \n" /* KSEG0 */
> +		"   move $t1, %0                  \n" /* num of L1 entries */
> +		"1: cache 0, 0($t0)               \n" /* flush L1 ICache */
> +		"   cache 0, 1($t0)               \n"
> +		"   cache 0, 2($t0)               \n"
> +		"   cache 0, 3($t0)               \n"
> +		"   cache 1, 0($t0)               \n" /* flush L1 DCache */
> +		"   cache 1, 1($t0)               \n"
> +		"   cache 1, 2($t0)               \n"
> +		"   cache 1, 3($t0)               \n"
> +		"   addiu $t0, $t0, 0x20          \n"
> +		"   bnez  $t1, 1b                 \n"
> +		"   addiu $t1, $t1, -1            \n"
> +		"   li    $t0, 0x7                \n" /* *state_addr = CPU_DEAD; */
> +		"   sw    $t0, 0($a0)             \n"
> +		"   sync                          \n"
> +		"   cache 21, 0($a0)              \n" /* flush entry of *state_addr */
> +		"   .set pop                      \n"
> +		: /* No Output */
> +		: "r" (cpu_data[smp_processor_id()].dcache.sets));
> +
> +	__asm__ __volatile__(
> +		"   .set push                     \n"
> +		"   .set noreorder                \n"
> +		"   .set mips64                   \n"
> +		"   mfc0  $t2, $15, 1             \n"
> +		"   andi  $t2, 0x3ff              \n"
> +		"   dli   $t0, 0x900000003ff01000 \n"
> +		"   andi  $t3, $t2, 0x3           \n"
> +		"   sll   $t3, 8                  \n"  /* get cpu id */
> +		"   or    $t0, $t0, $t3           \n"
> +		"   andi  $t1, $t2, 0xc           \n"
> +		"   dsll  $t1, 42                 \n"  /* get node id */
> +		"   or    $t0, $t0, $t1           \n"
> +		"1: li    $a0, 0x100              \n"  /* wait for init loop */
> +		"2: bnez  $a0, 2b                 \n"  /* limit mailbox access */
> +		"   addiu $a0, -1                 \n"
> +		"   lw    $v0, 0x20($t0)          \n"  /* get PC via mailbox */
> +		"   beqz  $v0, 1b                 \n"
> +		"   nop                           \n"
> +		"   ld    $sp, 0x28($t0)          \n"  /* get SP via mailbox */
> +		"   ld    $gp, 0x30($t0)          \n"  /* get GP via mailbox */
> +		"   ld    $a1, 0x38($t0)          \n"
> +		"   jr    $v0                     \n"  /* jump to initial PC */
> +		"   nop                           \n"
> +		"   .set pop                      \n");
> +}

Please don't use the $foo notation to allocate a register for use in this
function - gcc might ruin your day if it allocates the same register for
something else.  Something like:

static void somefunc(int blurb)
{
	int ptr;

	__asm__ __volatile__(
	"	cache	0, 0(%[ptr])		\n"
	"	cache	0, 1(%[ptr])		\n"
	"	cache	0, 2(%[ptr])		\n"
	"	cache	0, 3(%[ptr])		\n"
	: [ptr] "=&r" (ptr));
}

would be bulletproof against evil optimizations by GCC.

Or in plain C something like:

	unsigned long addr;

	for (addr = start; addr < end; addr += 0x20) {
		cache_op(0, ptr    );
		cache_op(0, ptr + 1);
		cache_op(0, ptr + 2);
		cache_op(0, ptr + 3);
		cache_op(1, ptr    );
		cache_op(1, ptr + 1);
		cache_op(1, ptr + 2);
		cache_op(1, ptr + 3);
	}
	...

  Ralf
