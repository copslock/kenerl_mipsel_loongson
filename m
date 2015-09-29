Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Sep 2015 22:48:57 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:48668 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009170AbbI2UszhEigC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Sep 2015 22:48:55 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Zh1pQ-0005fb-2k; Tue, 29 Sep 2015 22:48:48 +0200
Date:   Tue, 29 Sep 2015 22:48:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     Jiang Liu <jiang.liu@linux.intel.com>,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        jason@lakedaemon.net, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/6] Implement generic IPI support mechanism
In-Reply-To: <5603B6CA.7050601@imgtec.com>
Message-ID: <alpine.DEB.2.11.1509292101420.4500@nanos>
References: <1443019758-20620-1-git-send-email-qais.yousef@imgtec.com> <5602D958.6000003@linux.intel.com> <5603B6CA.7050601@imgtec.com>
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
X-archive-position: 49402
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

On Thu, 24 Sep 2015, Qais Yousef wrote:
> On 09/23/2015 05:54 PM, Jiang Liu wrote:
> > 	Thanks for doing this, but the change is a little bigger than
> > my expectation. Could we achieve this by:
> > 1) extend irq_chip to support send_ipi operation
> > 2) reuse existing irqdomain allocation interfaces to allocate IPI IRQ
> > 3) arch code to create an IPI domain for IPI allocations
> > 4) IRQ core provides some helpers to help arch code to implement IPI
> >     irqdomain

That's not sufficient as IPIs are different from normal interrupts
because we need an interface to actually send them.

> Can you be more specific about 2 please? I tried to reuse the hierarchy
> irqdomain alloc function. One major difference when allocating IPI than a
> normal irq is that it's dynamic. The caller doesn't know what hwirq number it
> needs. It actually shouldn't.

Right. But we have the same behaviour with e.g. MSI. The caller does
not know a hardware irq number because it is dynamically assigned.
 
> The idea is for the user to just say 'I want an IPI to a CPUAFFINITY' from DT
> and get a virq in return to send an IPI to the target CPU(s). Also I think we
> need to accommodate the possibility of having more than 1 IPI controller.

Having more than one IPI controller is not a problem. It's going to be
a separate IPI domain, which you select from DT or other means.

These IPI domains are implemented like the MSI domain as child
domains of the underlying irq domain.

     [IPI domain] ---> [GIC domain]

like we have on x86

     [MSI domain] ---> [Vector domain]

So you need some infrastructure, which allows you to:

 - allocate IPI(s)

     Requests IPI(s) from a IPI domain. That might be the default IPI
     domain or one that is matched via OF against a list of registered
     domains or one which is known to the caller by other means.

     Now that allocation interface does:

      1) Allocate irq descriptor

         This is required even for IPIs which are targeted to
         coprocessors and cannot be requested from Linux. In that case
         the only purpose is to store the irq chip and the irq domain
         specific data for that virq/hwirq mapping and the irq is
         marked as NOREQUEST.

      2) Allocate the vector/hwirq number block from the IPI domain
      	 
	 Part of the allocation request info is a pointer to the
	 target cpu mask. The weight of the target cpu mask is the
	 number of hwirqs you need to allocate from the underlying
	 domain.

	 For a normal Linux IPI, this will be the number of possible
	 CPUs. For a coprocessor IPI, this will be a single hwirq.

	 We also store that target cpu mask for runtime validation and
	 other usage in the irq descriptor data. We can actually reuse
	 the existing affinity mask for that.

	 Now how these hwirqs are allocated is a domain/architecture
	 specific issue.

	 x86 will just find a vector which is available on all target
	 cpus and mark it as used. That's a single hw irq number.

	 mips and others, which implement IPIs as regular hw interrupt
	 numbers, will allocate a these (consecutive) hw interrupt
	 numbers either from a reserved region or just from the
	 regular space. That's a bunch of hw irq numbers and we need
	 to come up with a proper storage format in the irqdata for
	 that. That might be

	       struct ipi_mapping {
		      unsigned int	nr_hwirqs;
		      unsigned int	cpumap[NR_CPUS];
	       };

	 or some other appropriate storage format like:

	       struct ipi_mapping {
	       	      unsigned int	hwirq_base;
		      unsigned int	cpu_offset;
		      unsigned int	nr_hwirqs;
	       };

	 which is less space consuming, but restricted to consecutive
	 hwirqs which can be mapped to the cpu number linearly:

	 	hwirq = hwirq_base + cpu - cpu_offset;
	 
       The result of this is a single virq number, which has all the
       necessary information stored in the associated irq descriptor
       and the domain specific hierarchical irq_data.

       For normal Linux IPIs that irq is marked as per cpu irq and can
       be requested via request_percpu_irq() and enabled/disabled via
       enable_percpu_irq/disable_percpu_irq on CPU hot[un]plug.

 - A function to send an IPI to a virq number

     That function takes the virq number and a target cpumask as
     argument.

     Actually we want two functions where the one which takes an virq
     number is a wrapper around the other which takes a irq descriptor
     pointer.

     The one which takes the virq number can be exported to drivers,
     the other one is a core/arch code only interface. The reason for
     this is that we want to avoid the irq descriptor lookup for
     regular IPIs, but for drivers this is a NONO.

     int irq_send_ipi(int virq, const struct cpumask *mask)
     {
	struct irq_desc *desc = irq_to_desc(virq);

	if (!desc)
		return -EINVAL;

	return irq_desc_send_ipi(desc, mask);
     }

     Along with a version which sends an IPI to all cpus in the target
     mask:

     int irq_send_ipi_all(int virq)
     {
	struct irq_desc *desc = irq_to_desc(virq);
	struct irq_data *data;

	if (!desc)
		return -EINVAL;

	data = irq_desc_get_irq_data(desc);
	return irq_desc_send_ipi(desc, irq_data_get_affinity_mask(data));
     }
     
     And the internal function:

     int irq_desc_send_ipi(struct irq_desc *desc, const struct cpumask *mask)
     {
	struct irq_data *data = irq_desc_get_irq_data(desc);
	struct irq_chip *chip = irq_data_get_irq_chip(data);

	if (!chip || !chip->send_ipi)
	   	  return -EINVAL;

	/*
	 * Do not validate the mask for IPIs marked global. These are
	 * regular IPIs so we can avoid the operation as their target
	 * mask is the cpu_possible_mask.
	 */
	if (!irqd_is_global_ipi(data)) {
	   if (!cpumask_subset(mask, irq_data_get_affinity_mask(data))
	      	  return -EINVAL;
	}

	chip->send_ipi(data, mask);
	return 0;
     }

     So now the chip specific send_ipi function will deal with the
     underlying implementation details.

     on x86 it uses the selected APIC implementation and sends
     the IPI to the vector stored in the hw irq number to all CPUs
     which are in the mask.

     on mips and others it's a bit different as you need to figure out
     the effective hwirq number for the cpus set in the target mask
     from the stored mapping in the hierarchical irq data. We
     certainly can create common helpers for this. Assume the simple
     mapping format:

     	       struct ipi_mapping {
		      unsigned int	nr_hwirqs;
		      unsigned int	cpumap[];
	       };
     
     then a helper function for the IPI domain irq chip would be:

     void irq_chip_send_ipi(struct irq_data *data, const struct cpumask *mask)
     {
	struct ipi_mapping *map = irq_data_get_irq_chip_data(data);
	struct irq_data *parent = data->parent;
	unsigned int cpu, hwirq;

	for_each_cpu(cpu, mask) {
		hwirq = map->cpumap[cpu];
		/* Deal with gaps */
		if (hwirq == INVALID_HWIRQ)
		   continue;
		parent->chip->send_ipi(parent, cpumask_of(cpu));
	}
     }
     
No linked lists, no magic other stuff. Just a natural extension to the
existing hierarchical irq domain code, which can be reused by all
architectures.

Thanks,

	tglx
