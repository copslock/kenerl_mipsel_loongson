Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Nov 2015 15:52:41 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:36398 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007496AbbKGOwjxTMzf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Nov 2015 15:52:39 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Zv4r3-0004Vu-1z; Sat, 07 Nov 2015 15:52:33 +0100
Date:   Sat, 7 Nov 2015 15:51:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 10/14] irqchip/mips-gic: Add a IPI hierarchy domain
In-Reply-To: <1446549181-31788-11-git-send-email-qais.yousef@imgtec.com>
Message-ID: <alpine.DEB.2.11.1511071323471.4032@nanos>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com> <1446549181-31788-11-git-send-email-qais.yousef@imgtec.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Tue, 3 Nov 2015, Qais Yousef wrote:

> Add a new ipi domain on top of the normal domain.
> 
> MIPS GIC now supports dynamic allocation of an IPI.

I don't think you make use of the power of hierarchical irq
domains. You just whacked the current code into submission.

Let me explain it to you how that should look like and how that's
going to make the code way simpler.

The root domain is the GIC itself. It provides an allocation mechanism
for all GIC interrupts, global, ipi and per cpu plus the basic
management of them.

So the GIC domain looks at the complete hardware irq space. Now that
irq space is first partioned into local and shared interrupts.

   ------------- hwirq MAX

   Shared interrupts   

   ------------- hwirq 6

   Local interrupts

   ------------- hwirq 0

So that shared interrupt space is where your device interrupts and the
ipi interrupts come from. That local interrupt space seems to be
hardwired, so it'd be overkill to handle that in an extra domain.

I assume that that shared interrupt space is partitioned as well
because the potential device interrupts on the SoC are hardwired. So
the picture looks like this:

   ------------- hwirq MAX

   Shared assignable interrupts

   ------------- hwirq X

   Shared device interrupts   

   ------------- hwirq 6

   Local interrupts

   ------------- hwirq 0


So if we look at the resulting hierarchy it looks like this:

                 |----- [IPI domain]
  [ GIC domain] -
                 |----- [device domain]

The GIC domain manages a bitmap of the full irq space. The IPI domain
and the device domain request N interrupts from the GIC domain at
allocation time.

So when you allocate from the device domain, you tell the parent
domain, that this is actually a device interrupt, and from the IPI
domain you tell it it's an IPI.

So the allocator in the root domain can decide from which space of the
bitmap to allocate.

       if (device) {
       	      hwirq = translate_from_dt(arg);
	      if (test_and_set_bit(&allocated_irqs, hwirq))
	      	     return -EBUSY;
       } else {
       	      start = first_ipi_irq;
	      end = last_ipi_irq + 1;
	      hwirq = bitmap_find_next_zero_area(allocated_irqs, start, end,
       	       				  	 nrirqs, 0);
       }
       ....

So that gives you a consecutive hw irq space for your IPI.

That makes a lot of things simpler. You don't have to keep a mapping
of the hwirq to the target cpu. You just can use the base hwirq and
calculate the destination hwirq from there when sending an IPI
(general Linux ones). The coprocessor one will just be a natural
fallout.

So if you have the following in the generic ipi code:

void ipi_send_single(unsigned int irq, unsigned int cpu)
{
	struct irq_desc *desc = irq_to_desc(irq);
	struct irq_data *data = irq_desc_get_irq_data(desc);
	struct irq_chip *chip = irq_data_get_irq_chip(data);
	
	if (chip->ipi_send_single)
		chip->ipi_send_single(data, cpu);
	else
		chip->ipi_send_mask(data, cpumask_of(cpu));
}

void ipi_send_mask(unsigned int irq, const struct cpumask *dest)
{
	struct irq_desc *desc = irq_to_desc(irq);
	struct irq_data *data = irq_desc_get_irq_data(desc);
	struct irq_chip *chip = irq_data_get_irq_chip(data);
	int cpu;

	if (!chip->ipi_send_mask) {
		for_each_cpu(cpu, dest)
			chip->ipi_send_single(data, cpu);
	} else {
		chip->ipi_send_mask(data, dest);
	}
}

void ipi_send_coproc_mask(unsigned int irq, const struct ipi_mask *dest)
{
        Fill in the obvious code.
}

And your ipi_send_single() callback just boils down to:
{
    	target = data->hw_irq + cpu;

	tweak_chip_regs(target);
}

Sanity checks omitted for brevity.

And that whole thing works for your case and for the case where we
only have a single per cpu interrupt descriptor allocated. The irq
descriptor based variants are exactly the same thing.

So now for the irq chips of your device and IPI domains. You can
either set the proper GIC chip variant or in case you need some extra
magic for one of the domains, you implement your own special chip
which can have some of its callback implemented by the existing
irq_***_parent() variants.

That gets rid of all your extra mappings, bitmaps and whatever add ons
you have duct taped into the existing GIC code.

Thanks,

	tglx
