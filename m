Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 15:42:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31252 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837162AbaEUNmYIuaoX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 15:42:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3B33966837922;
        Wed, 21 May 2014 14:42:14 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 21 May 2014 14:42:16 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 21 May
 2014 14:42:16 +0100
Message-ID: <537CAC74.4030800@imgtec.com>
Date:   Wed, 21 May 2014 14:39:00 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 10/15] MIPS: Add code for new system 'paravirt'.
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1400597236-11352-11-git-send-email-andreas.herrmann@caviumnetworks.com>
In-Reply-To: <1400597236-11352-11-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 20/05/14 15:47, Andreas Herrmann wrote:
> diff --git a/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h b/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h
> new file mode 100644
> index 0000000..c812efa
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h
> @@ -0,0 +1,49 @@

> +/*
> + * Do SMP slave processor setup necessary before we can safely execute
> + * C code.
> + */
> +	.macro  smp_slave_setup
> +	mfc0	t0, CP0_EBASE
> +	andi	t0, t0, 0x3ff		# CPUNum
> +	slti	t1, t0, NR_CPUS
> +	bnez	t1, 1f
> +2:
> +	di
> +	wait
> +	b	2b			# Unknown CPU, loop forever.
> +1:
> +	PTR_LA	t1, paravirt_smp_sp
> +	PTR_SLL	t0, PTR_SCALESHIFT
> +	PTR_ADDU t1, t1, t0
> +3:
> +	PTR_L	sp, 0(t1)
> +	beqz	sp, 3b			# Spin until told to proceed.
> +
> +	PTR_LA	t1, paravirt_smp_gp
> +	PTR_ADDU t1, t1, t0

Usually smp_wmb() at the writer needs to be paired with smp_rmb() at the
reader (i.e. here) to guarantee that the two memory locations become
visible to this CPU in the correct order, so I think you need a sync of
some kind between here to be portable beyond Octeon.

> +	PTR_L	gp, 0(t1)
> +	.endm


> diff --git a/arch/mips/paravirt/paravirt-irq.c b/arch/mips/paravirt/paravirt-irq.c
> new file mode 100644
> index 0000000..e1603dd
> --- /dev/null
> +++ b/arch/mips/paravirt/paravirt-irq.c
> @@ -0,0 +1,388 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2013 Cavium, Inc.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/cpumask.h>
> +#include <linux/kernel.h>
> +#include <linux/mutex.h>
> +
> +#include <asm/io.h>
> +
> +#define MBOX_BITS_PER_CPU 2
> +
> +int cpunum_for_cpu(int cpu)

static?

> +{
> +#ifdef CONFIG_SMP
> +	return cpu_logical_map(cpu);
> +#else
> +	return mips_cpunum();
> +#endif
> +}

> +static void irq_core_set_enable_local(void *arg)
> +{
> +	struct irq_data *data = arg;
> +	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
> +	unsigned int mask = 0x100 << cd->bit;
> +
> +	/*
> +	 * Interrupts are already disabled, so these are atomic.

Really? Even when called directly from irq_core_bus_sync_unlock with
only a single core online?

> +	 */
> +	if (cd->desired_en)
> +		set_c0_status(mask);
> +	else
> +		clear_c0_status(mask);
> +
> +}
> +
> +static void irq_core_disable(struct irq_data *data)
> +{
> +	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
> +	cd->desired_en = false;
> +}
> +
> +static void irq_core_enable(struct irq_data *data)
> +{
> +	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
> +	cd->desired_en = true;
> +}
> +
> +static void irq_core_bus_lock(struct irq_data *data)
> +{
> +	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
> +
> +	mutex_lock(&cd->core_irq_mutex);
> +}
> +
> +static void irq_core_bus_sync_unlock(struct irq_data *data)
> +{
> +	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
> +
> +	if (cd->desired_en != cd->current_en) {
> +		/*
> +		 * Can be called in early init when on_each_cpu() will
> +		 * unconditionally enable irqs, so handle the case
> +		 * where only a single CPU is online specially, and
> +		 * directly call.
> +		 */
> +		if (num_online_cpus() == 1)
> +			irq_core_set_enable_local(data);
> +		else
> +			on_each_cpu(irq_core_set_enable_local, data, 1);
> +
> +		cd->current_en = cd->desired_en;
> +	}
> +
> +	mutex_unlock(&cd->core_irq_mutex);
> +}


> +static int irq_pci_set_affinity(struct irq_data *data, const struct cpumask *dest, bool force)
> +{
> +	return 0;
> +}

Is there any point even providing this callback?

> +
> +static void irq_pci_cpu_offline(struct irq_data *data)
> +{
> +}

Or this one?

> +
> +static struct irq_chip irq_chip_pci = {
> +	.name = "PCI",
> +	.irq_enable = irq_pci_enable,
> +	.irq_disable = irq_pci_disable,
> +	.irq_ack = irq_pci_ack,
> +	.irq_mask = irq_pci_mask,
> +	.irq_unmask = irq_pci_unmask,
> +	.irq_set_affinity = irq_pci_set_affinity,
> +	.irq_cpu_offline = irq_pci_cpu_offline,
> +};


> diff --git a/arch/mips/paravirt/paravirt-smp.c b/arch/mips/paravirt/paravirt-smp.c
> new file mode 100644
> index 0000000..52f86eb
> --- /dev/null
> +++ b/arch/mips/paravirt/paravirt-smp.c

> +static void paravirt_smp_finish(void)
> +{
> +	/* to generate the first CPU timer interrupt */
> +	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);

This strikes me as a bit hacky. Are you sure it's actually necessary? (I
would have expected some generic hotplug notifier somewhere to ensure
that percpu clocksources gets initialised sensibly when a new CPU is
brought up)


> +static void paravirt_boot_secondary(int cpu, struct task_struct *idle)
> +{
> +	paravirt_smp_gp[cpu] = (unsigned long)(task_thread_info(idle));

spurious brackets around task_thread_info(idle)

> +	wmb();

Wouldn't smp_wmb() be more accurate?

> +	paravirt_smp_sp[cpu] = __KSTK_TOS(idle);
> +	mb();

is this barrier necessary?

> diff --git a/arch/mips/paravirt/serial.c b/arch/mips/paravirt/serial.c
> new file mode 100644
> index 0000000..e3f98b2
> --- /dev/null
> +++ b/arch/mips/paravirt/serial.c
> @@ -0,0 +1,38 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2013 Cavium, Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/virtio_console.h>
> +
> +#include <asm/mipsregs.h>
> +
> +/*
> + * Emit one character to the boot console.
> + */
> +int prom_putchar(char c)
> +{
> +	hypcall3(0 /* Console output */, 0 /*  port 0 */, (unsigned long)&c, 1 /* len == 1 */);

I think the hypcall API needs to be clearly specified and Documented
somewhere along with its HYPCALL codes and scope. I.e. is it specific to
kvmtool, or attempting to be a standard API across MIPS hypervisors.

It probably should have nice definitions in a header and wrappers
somewhere to make the arguments explicit and so there's no need for the
comments explaining what the magic values mean.

Cheers
James
