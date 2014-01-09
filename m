Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jan 2014 14:20:09 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:56229 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822668AbaAINUFSItC1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jan 2014 14:20:05 +0100
Message-ID: <52CEA1E4.5040406@imgtec.com>
Date:   Thu, 9 Jan 2014 13:19:32 +0000
From:   Alex Smith <alex.smith@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V16 10/12] MIPS: Loongson 3: Add Loongson-3 SMP support
References: <1389149068-24376-1-git-send-email-chenhc@lemote.com> <1389149068-24376-11-git-send-email-chenhc@lemote.com>
In-Reply-To: <1389149068-24376-11-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.62]
X-SEF-Processed: 7_3_0_01192__2014_01_09_13_19_58
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

On 08/01/14 02:44, Huacai Chen wrote:
> IPI registers of Loongson-3 include IPI_SET, IPI_CLEAR, IPI_STATUS,
> IPI_EN and IPI_MAILBOX_BUF. Each bit of IPI_STATUS indicate a type of
> IPI and IPI_EN indicate whether the IPI is enabled. The sender write 1
> to IPI_SET bits generate IPIs in IPI_STATUS, and receiver write 1 to
> bits of IPI_CLEAR to clear IPIs. IPI_MAILBOX_BUF are used to deliver
> more information about IPIs.
>
> Why we change code in arch/mips/loongson/common/setup.c?
>
> If without this change, when SMP configured, system cannot boot since
> it hang at printk() in cgroup_init_early(). The root cause is:
>
> console_trylock()
>    \-->down_trylock(&console_sem)
>      \-->raw_spin_unlock_irqrestore(&sem->lock, flags)
>        \-->_raw_spin_unlock_irqrestore()(SMP/UP have different versions)
>          \-->__raw_spin_unlock_irqrestore()  (following is the SMP case)
>            \-->do_raw_spin_unlock()
>              \-->arch_spin_unlock()
>                \-->nudge_writes()
>                  \-->mb()
>                    \-->wbflush()
>                      \-->__wbflush()
>
> In previous code __wbflush() is initialized in plat_mem_setup(), but
> cgroup_init_early() is called before plat_mem_setup(). Therefore, In
> this patch we make changes to avoid boot failure.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> ---
>   arch/mips/include/asm/mach-loongson/irq.h      |    2 +
>   arch/mips/include/asm/mach-loongson/loongson.h |    1 +
>   arch/mips/loongson/common/init.c               |    3 +
>   arch/mips/loongson/common/setup.c              |    8 +-
>   arch/mips/loongson/loongson-3/Makefile         |    2 +
>   arch/mips/loongson/loongson-3/irq.c            |   20 ++
>   arch/mips/loongson/loongson-3/smp.c            |  279 ++++++++++++++++++++++++
>   arch/mips/loongson/loongson-3/smp.h            |   24 ++
>   8 files changed, 334 insertions(+), 5 deletions(-)
>   create mode 100644 arch/mips/loongson/loongson-3/smp.c
>   create mode 100644 arch/mips/loongson/loongson-3/smp.h
>
> diff --git a/arch/mips/include/asm/mach-loongson/irq.h b/arch/mips/include/asm/mach-loongson/irq.h
> index 5711e3b..d2f0e2a 100644
> --- a/arch/mips/include/asm/mach-loongson/irq.h
> +++ b/arch/mips/include/asm/mach-loongson/irq.h
> @@ -22,5 +22,7 @@
>
>   #endif
>
> +extern void loongson3_ipi_interrupt(struct pt_regs *regs);
> +
>   #include_next <irq.h>
>   #endif /* __ASM_MACH_LOONGSON_IRQ_H_ */
> diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
> index 69e9d9e..f185907 100644
> --- a/arch/mips/include/asm/mach-loongson/loongson.h
> +++ b/arch/mips/include/asm/mach-loongson/loongson.h
> @@ -27,6 +27,7 @@ extern void mach_prepare_shutdown(void);
>   /* environment arguments from bootloader */
>   extern u32 cpu_clock_freq;
>   extern u32 memsize, highmemsize;
> +extern struct plat_smp_ops loongson3_smp_ops;
>
>   /* loongson-specific command line, env and memory initialization */
>   extern void __init prom_init_memory(void);
> diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
> index 81ba3b4..a7c521b 100644
> --- a/arch/mips/loongson/common/init.c
> +++ b/arch/mips/loongson/common/init.c
> @@ -33,6 +33,9 @@ void __init prom_init(void)
>
>   	/*init the uart base address */
>   	prom_init_uart_base();
> +#if defined(CONFIG_SMP)
> +	register_smp_ops(&loongson3_smp_ops);
> +#endif
>   }
>
>   void __init prom_free_prom_memory(void)
> diff --git a/arch/mips/loongson/common/setup.c b/arch/mips/loongson/common/setup.c
> index 8223f8a..bb4ac92 100644
> --- a/arch/mips/loongson/common/setup.c
> +++ b/arch/mips/loongson/common/setup.c
> @@ -18,9 +18,6 @@
>   #include <linux/screen_info.h>
>   #endif
>
> -void (*__wbflush)(void);
> -EXPORT_SYMBOL(__wbflush);
> -
>   static void wbflush_loongson(void)
>   {
>   	asm(".set\tpush\n\t"
> @@ -32,10 +29,11 @@ static void wbflush_loongson(void)
>   	    ".set mips0\n\t");
>   }
>
> +void (*__wbflush)(void) = wbflush_loongson;
> +EXPORT_SYMBOL(__wbflush);
> +
>   void __init plat_mem_setup(void)
>   {
> -	__wbflush = wbflush_loongson;
> -
>   #ifdef CONFIG_VT
>   #if defined(CONFIG_VGA_CONSOLE)
>   	conswitchp = &vga_con;
> diff --git a/arch/mips/loongson/loongson-3/Makefile b/arch/mips/loongson/loongson-3/Makefile
> index b9968cd..70152b2 100644
> --- a/arch/mips/loongson/loongson-3/Makefile
> +++ b/arch/mips/loongson/loongson-3/Makefile
> @@ -2,3 +2,5 @@
>   # Makefile for Loongson-3 family machines
>   #
>   obj-y			+= irq.o
> +
> +obj-$(CONFIG_SMP)	+= smp.o
> diff --git a/arch/mips/loongson/loongson-3/irq.c b/arch/mips/loongson/loongson-3/irq.c
> index 3b52d56..d8920a8 100644
> --- a/arch/mips/loongson/loongson-3/irq.c
> +++ b/arch/mips/loongson/loongson-3/irq.c
> @@ -40,6 +40,10 @@ void mach_irq_dispatch(unsigned int pending)
>   {
>   	if (pending & CAUSEF_IP7)
>   		do_IRQ(LOONGSON_TIMER_IRQ);
> +#if defined(CONFIG_SMP)
> +	else if (pending & CAUSEF_IP6)
> +		loongson3_ipi_interrupt(NULL);
> +#endif
>   	else if (pending & CAUSEF_IP3)
>   		ht_irqdispatch();
>   	else if (pending & CAUSEF_IP2)
> @@ -59,10 +63,26 @@ static inline void mask_loongson_irq(struct irq_data *d)
>   {
>   	clear_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
>   	irq_disable_hazard();
> +
> +	/* Workaround: UART IRQ may deliver to any core */
> +	if (d->irq == LOONGSON_UART_IRQ) {
> +		int cpu = smp_processor_id();
> +
> +		LOONGSON_INT_ROUTER_INTENCLR = 1 << 10;
> +		LOONGSON_INT_ROUTER_LPC = 0x10 + (1<<cpu);
> +	}
>   }
>
>   static inline void unmask_loongson_irq(struct irq_data *d)
>   {
> +	/* Workaround: UART IRQ may deliver to any core */
> +	if (d->irq == LOONGSON_UART_IRQ) {
> +		int cpu = smp_processor_id();
> +
> +		LOONGSON_INT_ROUTER_INTENSET = 1 << 10;
> +		LOONGSON_INT_ROUTER_LPC = 0x10 + (1<<cpu);
> +	}
> +
>   	set_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
>   	irq_enable_hazard();
>   }
> diff --git a/arch/mips/loongson/loongson-3/smp.c b/arch/mips/loongson/loongson-3/smp.c
> new file mode 100644
> index 0000000..a264bcb
> --- /dev/null
> +++ b/arch/mips/loongson/loongson-3/smp.c
> @@ -0,0 +1,279 @@
> +/*
> + * Copyright (C) 2010, 2011, 2012, Lemote, Inc.
> + * Author: Chen Huacai, chenhc@lemote.com
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + */

Don't need the FSF address again, as Aurelien said for patch 5.

> +
> +#include <linux/init.h>
> +#include <linux/cpu.h>
> +#include <linux/sched.h>
> +#include <linux/smp.h>
> +#include <linux/cpufreq.h>
> +#include <asm/processor.h>
> +#include <asm/time.h>
> +#include <asm/clock.h>
> +#include <asm/tlbflush.h>
> +#include <loongson.h>
> +
> +#include "smp.h"
> +
> +/* read a 64bit value from ipi register */
> +uint64_t loongson3_ipi_read64(void *addr)
> +{
> +	return readq(addr);
> +};
> +
> +/* write a 64bit value to ipi register */
> +void loongson3_ipi_write64(uint64_t action, void *addr)
> +{
> +	writeq(action, addr);
> +	__wbflush();
> +};
> +
> +/* read a 32bit value from ipi register */
> +uint32_t loongson3_ipi_read32(void *addr)
> +{
> +	return readl(addr);
> +};
> +
> +/* write a 32bit value to ipi register */
> +void loongson3_ipi_write32(uint32_t action, void *addr)
> +{
> +	writel(action, addr);
> +	__wbflush();
> +};

I don't see these used anywhere else outside this file, so add static. 
Also, remove the semicolons after the final brace on each function.

> +
> +static void *ipi_set0_regs[] = {
> +	(void *)(smp_core_group0_base + smp_core0_offset + SET0),
> +	(void *)(smp_core_group0_base + smp_core1_offset + SET0),
> +	(void *)(smp_core_group0_base + smp_core2_offset + SET0),
> +	(void *)(smp_core_group0_base + smp_core3_offset + SET0),
> +	(void *)(smp_core_group1_base + smp_core0_offset + SET0),
> +	(void *)(smp_core_group1_base + smp_core1_offset + SET0),
> +	(void *)(smp_core_group1_base + smp_core2_offset + SET0),
> +	(void *)(smp_core_group1_base + smp_core3_offset + SET0),
> +	(void *)(smp_core_group2_base + smp_core0_offset + SET0),
> +	(void *)(smp_core_group2_base + smp_core1_offset + SET0),
> +	(void *)(smp_core_group2_base + smp_core2_offset + SET0),
> +	(void *)(smp_core_group2_base + smp_core3_offset + SET0),
> +	(void *)(smp_core_group3_base + smp_core0_offset + SET0),
> +	(void *)(smp_core_group3_base + smp_core1_offset + SET0),
> +	(void *)(smp_core_group3_base + smp_core2_offset + SET0),
> +	(void *)(smp_core_group3_base + smp_core3_offset + SET0),
> +};
> +
> +static void *ipi_clear0_regs[] = {
> +	(void *)(smp_core_group0_base + smp_core0_offset + CLEAR0),
> +	(void *)(smp_core_group0_base + smp_core1_offset + CLEAR0),
> +	(void *)(smp_core_group0_base + smp_core2_offset + CLEAR0),
> +	(void *)(smp_core_group0_base + smp_core3_offset + CLEAR0),
> +	(void *)(smp_core_group1_base + smp_core0_offset + CLEAR0),
> +	(void *)(smp_core_group1_base + smp_core1_offset + CLEAR0),
> +	(void *)(smp_core_group1_base + smp_core2_offset + CLEAR0),
> +	(void *)(smp_core_group1_base + smp_core3_offset + CLEAR0),
> +	(void *)(smp_core_group2_base + smp_core0_offset + CLEAR0),
> +	(void *)(smp_core_group2_base + smp_core1_offset + CLEAR0),
> +	(void *)(smp_core_group2_base + smp_core2_offset + CLEAR0),
> +	(void *)(smp_core_group2_base + smp_core3_offset + CLEAR0),
> +	(void *)(smp_core_group3_base + smp_core0_offset + CLEAR0),
> +	(void *)(smp_core_group3_base + smp_core1_offset + CLEAR0),
> +	(void *)(smp_core_group3_base + smp_core2_offset + CLEAR0),
> +	(void *)(smp_core_group3_base + smp_core3_offset + CLEAR0),
> +};
> +
> +static void *ipi_status0_regs[] = {
> +	(void *)(smp_core_group0_base + smp_core0_offset + STATUS0),
> +	(void *)(smp_core_group0_base + smp_core1_offset + STATUS0),
> +	(void *)(smp_core_group0_base + smp_core2_offset + STATUS0),
> +	(void *)(smp_core_group0_base + smp_core3_offset + STATUS0),
> +	(void *)(smp_core_group1_base + smp_core0_offset + STATUS0),
> +	(void *)(smp_core_group1_base + smp_core1_offset + STATUS0),
> +	(void *)(smp_core_group1_base + smp_core2_offset + STATUS0),
> +	(void *)(smp_core_group1_base + smp_core3_offset + STATUS0),
> +	(void *)(smp_core_group2_base + smp_core0_offset + STATUS0),
> +	(void *)(smp_core_group2_base + smp_core1_offset + STATUS0),
> +	(void *)(smp_core_group2_base + smp_core2_offset + STATUS0),
> +	(void *)(smp_core_group2_base + smp_core3_offset + STATUS0),
> +	(void *)(smp_core_group3_base + smp_core0_offset + STATUS0),
> +	(void *)(smp_core_group3_base + smp_core1_offset + STATUS0),
> +	(void *)(smp_core_group3_base + smp_core2_offset + STATUS0),
> +	(void *)(smp_core_group3_base + smp_core3_offset + STATUS0),
> +};
> +
> +static void *ipi_en0_regs[] = {
> +	(void *)(smp_core_group0_base + smp_core0_offset + EN0),
> +	(void *)(smp_core_group0_base + smp_core1_offset + EN0),
> +	(void *)(smp_core_group0_base + smp_core2_offset + EN0),
> +	(void *)(smp_core_group0_base + smp_core3_offset + EN0),
> +	(void *)(smp_core_group1_base + smp_core0_offset + EN0),
> +	(void *)(smp_core_group1_base + smp_core1_offset + EN0),
> +	(void *)(smp_core_group1_base + smp_core2_offset + EN0),
> +	(void *)(smp_core_group1_base + smp_core3_offset + EN0),
> +	(void *)(smp_core_group2_base + smp_core0_offset + EN0),
> +	(void *)(smp_core_group2_base + smp_core1_offset + EN0),
> +	(void *)(smp_core_group2_base + smp_core2_offset + EN0),
> +	(void *)(smp_core_group2_base + smp_core3_offset + EN0),
> +	(void *)(smp_core_group3_base + smp_core0_offset + EN0),
> +	(void *)(smp_core_group3_base + smp_core1_offset + EN0),
> +	(void *)(smp_core_group3_base + smp_core2_offset + EN0),
> +	(void *)(smp_core_group3_base + smp_core3_offset + EN0),
> +};
> +
> +static void *ipi_mailbox_buf[] = {
> +	(void *)(smp_core_group0_base + smp_core0_offset + BUF),
> +	(void *)(smp_core_group0_base + smp_core1_offset + BUF),
> +	(void *)(smp_core_group0_base + smp_core2_offset + BUF),
> +	(void *)(smp_core_group0_base + smp_core3_offset + BUF),
> +	(void *)(smp_core_group1_base + smp_core0_offset + BUF),
> +	(void *)(smp_core_group1_base + smp_core1_offset + BUF),
> +	(void *)(smp_core_group1_base + smp_core2_offset + BUF),
> +	(void *)(smp_core_group1_base + smp_core3_offset + BUF),
> +	(void *)(smp_core_group2_base + smp_core0_offset + BUF),
> +	(void *)(smp_core_group2_base + smp_core1_offset + BUF),
> +	(void *)(smp_core_group2_base + smp_core2_offset + BUF),
> +	(void *)(smp_core_group2_base + smp_core3_offset + BUF),
> +	(void *)(smp_core_group3_base + smp_core0_offset + BUF),
> +	(void *)(smp_core_group3_base + smp_core1_offset + BUF),
> +	(void *)(smp_core_group3_base + smp_core2_offset + BUF),
> +	(void *)(smp_core_group3_base + smp_core3_offset + BUF),
> +};
> +
> +/*
> + * Simple enough, just poke the appropriate ipi register
> + */
> +static void loongson3_send_ipi_single(int cpu, unsigned int action)
> +{
> +	loongson3_ipi_write32((u32)action, ipi_set0_regs[cpu]);
> +}
> +
> +static void
> +loongson3_send_ipi_mask(const struct cpumask *mask, unsigned int action)
> +{
> +	unsigned int i;
> +
> +	for_each_cpu(i, mask)
> +		loongson3_ipi_write32((u32)action, ipi_set0_regs[i]);
> +}
> +
> +void loongson3_ipi_interrupt(struct pt_regs *regs)
> +{
> +	int cpu = smp_processor_id();
> +	unsigned int action;
> +
> +	/* Load the ipi register to figure out what we're supposed to do */
> +	action = loongson3_ipi_read32(ipi_status0_regs[cpu]);
> +
> +	/* Clear the ipi register to clear the interrupt */
> +	loongson3_ipi_write32((u32)action, ipi_clear0_regs[cpu]);
> +
> +	if (action & SMP_RESCHEDULE_YOURSELF)
> +		scheduler_ipi();
> +
> +	if (action & SMP_CALL_FUNCTION)
> +		smp_call_function_interrupt();
> +}
> +
> +/*
> + * SMP init and finish on secondary CPUs
> + */
> +void loongson3_init_secondary(void)
> +{
> +	int i;
> +	unsigned int imask = STATUSF_IP7 | STATUSF_IP6 |
> +			     STATUSF_IP3 | STATUSF_IP2;
> +
> +	/* Set interrupt mask, but don't enable */
> +	change_c0_status(ST0_IM, imask);
> +
> +	for (i = 0; i < loongson_sysconf.nr_cpus; i++)
> +		loongson3_ipi_write32(0xffffffff, ipi_en0_regs[i]);
> +}
> +
> +void loongson3_smp_finish(void)
> +{
> +	write_c0_compare(read_c0_count() + mips_hpt_frequency/HZ);
> +	local_irq_enable();
> +	loongson3_ipi_write64(0,
> +			(void *)(ipi_mailbox_buf[smp_processor_id()]+0x0));
> +	pr_info("CPU#%d finished, CP0_ST=%x\n",
> +			smp_processor_id(), read_c0_status());
> +}
> +
> +void __init loongson3_smp_setup(void)
> +{
> +	int i, num;
> +
> +	init_cpu_possible(cpu_none_mask);
> +	set_cpu_possible(0, true);
> +
> +	__cpu_number_map[0] = 0;
> +	__cpu_logical_map[0] = 0;
> +
> +	/* For unified kernel, NR_CPUS is the maximum possible value,
> +	 * loongson_sysconf.nr_cpus is the really present value */
> +	for (i = 1, num = 0; i < loongson_sysconf.nr_cpus; i++) {
> +		set_cpu_possible(i, true);
> +		__cpu_number_map[i] = ++num;
> +		__cpu_logical_map[num] = i;
> +	}
> +	pr_info("Detected %i available secondary CPU(s)\n", num);
> +}
> +
> +void __init loongson3_prepare_cpus(unsigned int max_cpus)
> +{
> +}
> +
> +/*
> + * Setup the PC, SP, and GP of a secondary processor and start it runing!
> + */
> +void loongson3_boot_secondary(int cpu, struct task_struct *idle)
> +{
> +	unsigned long startargs[4];
> +
> +	pr_info("Booting CPU#%d...\n", cpu);
> +
> +	/* startargs[] are initial PC, SP and GP for secondary CPU */
> +	startargs[0] = (unsigned long)&smp_bootstrap;
> +	startargs[1] = (unsigned long)__KSTK_TOS(idle);
> +	startargs[2] = (unsigned long)task_thread_info(idle);
> +	startargs[3] = 0;
> +
> +	pr_debug("CPU#%d, func_pc=%lx, sp=%lx, gp=%lx\n",
> +			cpu, startargs[0], startargs[1], startargs[2]);
> +
> +	loongson3_ipi_write64(startargs[3], (void *)(ipi_mailbox_buf[cpu]+0x18));
> +	loongson3_ipi_write64(startargs[2], (void *)(ipi_mailbox_buf[cpu]+0x10));
> +	loongson3_ipi_write64(startargs[1], (void *)(ipi_mailbox_buf[cpu]+0x8));
> +	loongson3_ipi_write64(startargs[0], (void *)(ipi_mailbox_buf[cpu]+0x0));
> +}
> +
> +/*
> + * Final cleanup after all secondaries booted
> + */
> +void __init loongson3_cpus_done(void)
> +{
> +}
> +
> +struct plat_smp_ops loongson3_smp_ops = {
> +	.send_ipi_single = loongson3_send_ipi_single,
> +	.send_ipi_mask = loongson3_send_ipi_mask,
> +	.init_secondary = loongson3_init_secondary,
> +	.smp_finish = loongson3_smp_finish,
> +	.cpus_done = loongson3_cpus_done,
> +	.boot_secondary = loongson3_boot_secondary,
> +	.smp_setup = loongson3_smp_setup,
> +	.prepare_cpus = loongson3_prepare_cpus,
> +};

Add static on all of the functions above referenced in 
loongson3_smp_ops, they aren't referenced outside this file.

> diff --git a/arch/mips/loongson/loongson-3/smp.h b/arch/mips/loongson/loongson-3/smp.h
> new file mode 100644
> index 0000000..dc9ce69
> --- /dev/null
> +++ b/arch/mips/loongson/loongson-3/smp.h
> @@ -0,0 +1,24 @@
> +/* for Loongson-3A smp support */
> +
> +/* 4 groups(nodes) in maximum in numa case */
> +#define  smp_core_group0_base    0x900000003ff01000
> +#define  smp_core_group1_base    0x900010003ff01000
> +#define  smp_core_group2_base    0x900020003ff01000
> +#define  smp_core_group3_base    0x900030003ff01000
> +
> +/* 4 cores in each group(node) */
> +#define  smp_core0_offset  0x000
> +#define  smp_core1_offset  0x100
> +#define  smp_core2_offset  0x200
> +#define  smp_core3_offset  0x300

Macros defining constants should have capitalized names.

> +
> +/* ipi registers offsets */
> +#define  STATUS0  0x00
> +#define  EN0      0x04
> +#define  SET0     0x08
> +#define  CLEAR0   0x0c
> +#define  STATUS1  0x10
> +#define  MASK1    0x14
> +#define  SET1     0x18
> +#define  CLEAR1   0x1c
> +#define  BUF      0x20
>

Even though it's only included from smp.c, headers should probably have 
include guard #ifdefs.

Thanks,
Alex
