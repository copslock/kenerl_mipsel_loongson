Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2015 12:11:02 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35468 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013035AbbKILK75T7VG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2015 12:10:59 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 6200D6DC11CBF;
        Mon,  9 Nov 2015 11:10:51 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 9 Nov 2015 11:10:53 +0000
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 9 Nov
 2015 11:10:52 +0000
Subject: Re: [PATCH 10/14] irqchip/mips-gic: Add a IPI hierarchy domain
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com>
 <1446549181-31788-11-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1511071323471.4032@nanos>
CC:     <linux-kernel@vger.kernel.org>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <56407F3C.4060404@imgtec.com>
Date:   Mon, 9 Nov 2015 11:10:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1511071323471.4032@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

On 11/07/2015 02:51 PM, Thomas Gleixner wrote:
> On Tue, 3 Nov 2015, Qais Yousef wrote:
>
>> Add a new ipi domain on top of the normal domain.
>>
>> MIPS GIC now supports dynamic allocation of an IPI.
> I don't think you make use of the power of hierarchical irq
> domains. You just whacked the current code into submission.
>
> Let me explain it to you how that should look like and how that's
> going to make the code way simpler.
>
> The root domain is the GIC itself. It provides an allocation mechanism
> for all GIC interrupts, global, ipi and per cpu plus the basic
> management of them.
>
> So the GIC domain looks at the complete hardware irq space. Now that
> irq space is first partioned into local and shared interrupts.
>
>     ------------- hwirq MAX
>
>     Shared interrupts
>
>     ------------- hwirq 6
>
>     Local interrupts
>
>     ------------- hwirq 0
>
> So that shared interrupt space is where your device interrupts and the
> ipi interrupts come from. That local interrupt space seems to be
> hardwired, so it'd be overkill to handle that in an extra domain.
>
> I assume that that shared interrupt space is partitioned as well
> because the potential device interrupts on the SoC are hardwired. So
> the picture looks like this:
>
>     ------------- hwirq MAX
>
>     Shared assignable interrupts
>
>     ------------- hwirq X
>
>     Shared device interrupts
>
>     ------------- hwirq 6
>
>     Local interrupts
>
>     ------------- hwirq 0
>
>
> So if we look at the resulting hierarchy it looks like this:
>
>                   |----- [IPI domain]
>    [ GIC domain] -
>                   |----- [device domain]
>
> The GIC domain manages a bitmap of the full irq space. The IPI domain
> and the device domain request N interrupts from the GIC domain at
> allocation time.
>
> So when you allocate from the device domain, you tell the parent
> domain, that this is actually a device interrupt, and from the IPI
> domain you tell it it's an IPI.
>
> So the allocator in the root domain can decide from which space of the
> bitmap to allocate.
>
>         if (device) {
>         	      hwirq = translate_from_dt(arg);
> 	      if (test_and_set_bit(&allocated_irqs, hwirq))
> 	      	     return -EBUSY;
>         } else {
>         	      start = first_ipi_irq;
> 	      end = last_ipi_irq + 1;
> 	      hwirq = bitmap_find_next_zero_area(allocated_irqs, start, end,
>         	       				  	 nrirqs, 0);
>         }
>         ....
>
> So that gives you a consecutive hw irq space for your IPI.


This is potentially dangerous. If a device allocation happens after an 
IPI allocation, and that device wants the hwirq at the region that IPI 
just allocated because it thought it's free, it'd fail.

Generally it's hard to know whether a real device is connected to a 
hwirq or not. I am saving a patch where we get a set of free hwirqs from 
DT as only the SoC designer knows what hwirq are actually free and safe 
to use for IPI. I'll send this patch with the DT IPI changes or the 
rproc driver that I will be send once these changes are merged.

The current code assumes that the last 2 * NR_CPUs hwirqs are always 
free to use for Linux SMP.

>
> That makes a lot of things simpler. You don't have to keep a mapping
> of the hwirq to the target cpu. You just can use the base hwirq and
> calculate the destination hwirq from there when sending an IPI
> (general Linux ones). The coprocessor one will just be a natural
> fallout.

Are you suggesting here to remove the whole new mapping API from the 
generic code or just that it's not necessary to use it in my case?

>
> So if you have the following in the generic ipi code:
>
> void ipi_send_single(unsigned int irq, unsigned int cpu)
> {
> 	struct irq_desc *desc = irq_to_desc(irq);
> 	struct irq_data *data = irq_desc_get_irq_data(desc);
> 	struct irq_chip *chip = irq_data_get_irq_chip(data);
> 	
> 	if (chip->ipi_send_single)
> 		chip->ipi_send_single(data, cpu);
> 	else
> 		chip->ipi_send_mask(data, cpumask_of(cpu));
> }
>
> void ipi_send_mask(unsigned int irq, const struct cpumask *dest)
> {
> 	struct irq_desc *desc = irq_to_desc(irq);
> 	struct irq_data *data = irq_desc_get_irq_data(desc);
> 	struct irq_chip *chip = irq_data_get_irq_chip(data);
> 	int cpu;
>
> 	if (!chip->ipi_send_mask) {
> 		for_each_cpu(cpu, dest)
> 			chip->ipi_send_single(data, cpu);
> 	} else {
> 		chip->ipi_send_mask(data, dest);
> 	}
> }
>
> void ipi_send_coproc_mask(unsigned int irq, const struct ipi_mask *dest)
> {
>          Fill in the obvious code.
> }
>
> And your ipi_send_single() callback just boils down to:
> {
>      	target = data->hw_irq + cpu;
>
> 	tweak_chip_regs(target);
> }
>
> Sanity checks omitted for brevity.

I'm confused here as well. Is this a complementary API or are you 
suggesting replacing the one this patch introduces?

>
> And that whole thing works for your case and for the case where we
> only have a single per cpu interrupt descriptor allocated. The irq
> descriptor based variants are exactly the same thing.
>
> So now for the irq chips of your device and IPI domains. You can
> either set the proper GIC chip variant or in case you need some extra
> magic for one of the domains, you implement your own special chip
> which can have some of its callback implemented by the existing
> irq_***_parent() variants.
>
> That gets rid of all your extra mappings, bitmaps and whatever add ons
> you have duct taped into the existing GIC code.

This is all new territory for me. I thought I did it the correct way and 
it seemed simple to me.

I'll follow your idea through and see what I come up with. I'm getting a 
bit confused about how the generic API should look like now though. I'll 
keep what I added and add any new needed stuff and hopefully once I 
start doing the work and when the next series is ready it'd be more 
obvious what's needed and what's not.

Thanks,
Qais
