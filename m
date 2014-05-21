Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 18:31:28 +0200 (CEST)
Received: from mail-bl2lp0208.outbound.protection.outlook.com ([207.46.163.208]:30397
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822112AbaEUQb0fESx6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 May 2014 18:31:26 +0200
Received: from BY2PRD0711HT002.namprd07.prod.outlook.com (10.255.88.165) by
 DM2PR07MB509.namprd07.prod.outlook.com (10.141.156.143) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Wed, 21 May 2014 16:31:06 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.88.165) with Microsoft SMTP Server (TLS) id 14.16.459.0; Wed, 21 May
 2014 16:31:03 +0000
Message-ID: <537CD4C6.5080905@caviumnetworks.com>
Date:   Wed, 21 May 2014 09:31:02 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <linux-mips@linux-mips.org>, David Daney <ddaney.cavm@gmail.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 10/15] MIPS: Add code for new system 'paravirt'.
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1400597236-11352-11-git-send-email-andreas.herrmann@caviumnetworks.com> <537CAC74.4030800@imgtec.com>
In-Reply-To: <537CAC74.4030800@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(22564002)(51704005)(377454003)(479174003)(24454002)(189002)(199002)(87266999)(83506001)(54356999)(50986999)(81542001)(76176999)(36756003)(65816999)(4396001)(23756003)(80316001)(102836001)(81342001)(83072002)(74662001)(50466002)(101416001)(92726001)(46102001)(21056001)(59896001)(31966008)(20776003)(64126003)(64706001)(99396002)(76482001)(79102001)(85852003)(47776003)(77982001)(65956001)(87936001)(92566001)(80022001)(53416003)(74502001)(66066001)(33656002);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB509;H:BY2PRD0711HT002.namprd07.prod.outlook.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 05/21/2014 06:39 AM, James Hogan wrote:
[...]
>> diff --git a/arch/mips/paravirt/paravirt-irq.c b/arch/mips/paravirt/paravirt-irq.c
>> new file mode 100644
>> index 0000000..e1603dd
>> --- /dev/null
>> +++ b/arch/mips/paravirt/paravirt-irq.c
[...]
>
>> +static void irq_core_set_enable_local(void *arg)
>> +{
>> +	struct irq_data *data = arg;
>> +	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
>> +	unsigned int mask = 0x100 << cd->bit;
>> +
>> +	/*
>> +	 * Interrupts are already disabled, so these are atomic.
>
> Really? Even when called directly from irq_core_bus_sync_unlock with
> only a single core online?
>

Yes, but...


>> +	 */
>> +	if (cd->desired_en)
>> +		set_c0_status(mask);
>> +	else
>> +		clear_c0_status(mask);
>> +
>> +}
>> +
>> +static void irq_core_disable(struct irq_data *data)
>> +{
>> +	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
>> +	cd->desired_en = false;
>> +}
>> +
>> +static void irq_core_enable(struct irq_data *data)
>> +{
>> +	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
>> +	cd->desired_en = true;
>> +}
>> +
>> +static void irq_core_bus_lock(struct irq_data *data)
>> +{
>> +	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
>> +
>> +	mutex_lock(&cd->core_irq_mutex);
>> +}
>> +
>> +static void irq_core_bus_sync_unlock(struct irq_data *data)
>> +{
>> +	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
>> +
>> +	if (cd->desired_en != cd->current_en) {
>> +		/*
>> +		 * Can be called in early init when on_each_cpu() will
>> +		 * unconditionally enable irqs, so handle the case
>> +		 * where only a single CPU is online specially, and
>> +		 * directly call.
>> +		 */
>> +		if (num_online_cpus() == 1)
>> +			irq_core_set_enable_local(data);
>> +		else
>> +			on_each_cpu(irq_core_set_enable_local, data, 1);
>> +


...  This code is not correct.  It was initially done as a workaround 
for the issues fixed in commit 202da4005.

Now that on_each_cpu() is less buggy, we can unconditionally use it and 
the assertion above about "Interrupts are already disabled" will be true.


>> +		cd->current_en = cd->desired_en;
>> +	}
>> +
>> +	mutex_unlock(&cd->core_irq_mutex);
>> +}
>
>
>> +static int irq_pci_set_affinity(struct irq_data *data, const struct cpumask *dest, bool force)
>> +{
>> +	return 0;
>> +}
>
> Is there any point even providing this callback?

I guess we can add them only when they are implemented.

>
>> +
>> +static void irq_pci_cpu_offline(struct irq_data *data)
>> +{
>> +}
>
> Or this one?

Same.

>
>> +
>> +static struct irq_chip irq_chip_pci = {
>> +	.name = "PCI",
>> +	.irq_enable = irq_pci_enable,
>> +	.irq_disable = irq_pci_disable,
>> +	.irq_ack = irq_pci_ack,
>> +	.irq_mask = irq_pci_mask,
>> +	.irq_unmask = irq_pci_unmask,
>> +	.irq_set_affinity = irq_pci_set_affinity,
>> +	.irq_cpu_offline = irq_pci_cpu_offline,
>> +};
>
>
>> diff --git a/arch/mips/paravirt/paravirt-smp.c b/arch/mips/paravirt/paravirt-smp.c
>> new file mode 100644
>> index 0000000..52f86eb
>> --- /dev/null
>> +++ b/arch/mips/paravirt/paravirt-smp.c
>
>> +static void paravirt_smp_finish(void)
>> +{
>> +	/* to generate the first CPU timer interrupt */
>> +	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
>
> This strikes me as a bit hacky. Are you sure it's actually necessary? (I
> would have expected some generic hotplug notifier somewhere to ensure
> that percpu clocksources gets initialised sensibly when a new CPU is
> brought up)
>
>
>> +static void paravirt_boot_secondary(int cpu, struct task_struct *idle)
>> +{
>> +	paravirt_smp_gp[cpu] = (unsigned long)(task_thread_info(idle));
>
> spurious brackets around task_thread_info(idle)
>
>> +	wmb();
>
> Wouldn't smp_wmb() be more accurate?

Probably.

>
>> +	paravirt_smp_sp[cpu] = __KSTK_TOS(idle);
>> +	mb();
>
> is this barrier necessary?

Really it is just make_writes_visible_asap(), but for OCTEON mb() or 
smp_wmb() is the closest that the kernel has.

It may not be necessary, but it doesn't really harm anything.


>
>> diff --git a/arch/mips/paravirt/serial.c b/arch/mips/paravirt/serial.c
>> new file mode 100644
>> index 0000000..e3f98b2
>> --- /dev/null
>> +++ b/arch/mips/paravirt/serial.c
>> @@ -0,0 +1,38 @@
>> +/*
>> + * This file is subject to the terms and conditions of the GNU General Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.
>> + *
>> + * Copyright (C) 2013 Cavium, Inc.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/virtio_console.h>
>> +
>> +#include <asm/mipsregs.h>
>> +
>> +/*
>> + * Emit one character to the boot console.
>> + */
>> +int prom_putchar(char c)
>> +{
>> +	hypcall3(0 /* Console output */, 0 /*  port 0 */, (unsigned long)&c, 1 /* len == 1 */);
>
> I think the hypcall API needs to be clearly specified and Documented
> somewhere along with its HYPCALL codes and scope. I.e. is it specific to
> kvmtool, or attempting to be a standard API across MIPS hypervisors.
>

I was intending it to be the later.  (standard API across MIPS hypervisors.)

The idea being that the first argument would be broken up into several 
ranges.

0..x : Globally available HYPCALL provided by all hypervisors.

m..n : MIPS KVM specific.

y..z : Reserved for the vendor.


For some values of x, m, n, y and z.

But perhaps it should just be MIPS KVM specific. If making it global is 
too much trouble.


> It probably should have nice definitions in a header and wrappers
> somewhere to make the arguments explicit and so there's no need for the
> comments explaining what the magic values mean.
>
> Cheers
> James
>
