Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Oct 2017 09:00:32 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53346 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990391AbdJ3IAVMdMyL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Oct 2017 09:00:21 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B969780D;
        Mon, 30 Oct 2017 01:00:13 -0700 (PDT)
Received: from zomby-woof (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B3DC3F3E1;
        Mon, 30 Oct 2017 01:00:12 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] irqchip: mips-gic: Use irq_cpu_online to (un)mask all-VP(E) IRQs
In-Reply-To: <20171025233730.22225-3-paul.burton@mips.com> (Paul Burton's
        message of "Wed, 25 Oct 2017 16:37:24 -0700")
Organization: ARM Ltd
References: <20171025233730.22225-1-paul.burton@mips.com>
        <20171025233730.22225-3-paul.burton@mips.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Mon, 30 Oct 2017 08:00:08 +0000
Message-ID: <86mv495alz.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

On Wed, Oct 25 2017 at  5:37:24 pm BST, Paul Burton <paul.burton@mips.com> wrote:
> The gic_all_vpes_local_irq_controller chip currently attempts to operate
> on all CPUs/VPs in the system when masking or unmasking an interrupt.
> This has a few drawbacks:
>
>  - In multi-cluster systems we may not always have access to all CPUs in
>    the system. When all CPUs in a cluster are powered down that
>    cluster's GIC may also power down, in which case we cannot configure
>    its state.
>
>  - Relatedly, if we power down a cluster after having configured
>    interrupts for CPUs within it then the cluster's GIC may lose state &
>    we need to reconfigure it. The current approach doesn't take this
>    into account.
>
>  - It's wasteful if we run Linux on fewer VPs than are present in the
>    system. For example if we run a uniprocessor kernel on CPU0 of a
>    system with 16 CPUs then there's no point in us configuring CPUs
>    1-15.
>
>  - The implementation is also lacking in that it expects the range
>    0..gic_vpes-1 to represent valid Linux CPU numbers which may not
>    always be the case - for example if we run on a system with more VPs
>    than the kernel is configured to support.
>
> Fix all of these issues by only configuring the affected interrupts for
> CPUs which are online at the time, and recording the configuration in a
> new struct gic_all_vpes_chip_data for later use by CPUs being brought
> online. We register a CPU hotplug state (reusing
> CPUHP_AP_IRQ_GIC_STARTING which the ARM GIC driver uses, and which seems
> suitably generic for reuse with the MIPS GIC) and execute
> irq_cpu_online() in order to configure the interrupts on the newly
> onlined CPU.
>
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mips@linux-mips.org
> ---
>
>  drivers/irqchip/irq-mips-gic.c | 72 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 56 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index 6fdcc1552fab..dd9da773db90 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c

[...]

> @@ -622,6 +653,13 @@ static const struct irq_domain_ops gic_ipi_domain_ops = {
>  	.match = gic_ipi_domain_match,
>  };
>  
> +static int gic_cpu_startup(unsigned int cpu)
> +{
> +	/* Invoke irq_cpu_online callbacks to enable desired interrupts */
> +	irq_cpu_online();
> +
> +	return 0;
> +}
>  
>  static int __init gic_of_init(struct device_node *node,
>  			      struct device_node *parent)
> @@ -768,6 +806,8 @@ static int __init gic_of_init(struct device_node *node,
>  		}
>  	}
>  
> -	return 0;
> +	return cpuhp_setup_state(CPUHP_AP_IRQ_GIC_STARTING,
> +				 "irqchip/mips/gic:starting",
> +				 gic_cpu_startup, NULL);

I'm wondering about this. CPUHP_AP_IRQ_GIC_STARTING is a symbol that is
used on ARM platforms. You're very welcome to use it (as long as nobody
builds a system with both an ARM GIC and a MIPS GIC...), but I'm a bit
worried that we could end-up breaking things if one of us decides to
reorder it in enum cpuhp_state.

The safest option would be for you to add your own state value, which
would allow the two architecture to evolve independently.

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny.
