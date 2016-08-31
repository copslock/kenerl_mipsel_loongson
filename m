Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 18:57:39 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:42086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992110AbcHaQ5a3QX9q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Aug 2016 18:57:30 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 439C5433;
        Wed, 31 Aug 2016 09:57:24 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEE373F303;
        Wed, 31 Aug 2016 09:57:22 -0700 (PDT)
Subject: Re: [Patch v3 03/11] irqchip: axi-intc: Add support for parent intc
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        monstr@monstr.eu, ralf@linux-mips.org, tglx@linutronix.de,
        jason@lakedaemon.net
References: <1472661352-11983-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472661352-11983-4-git-send-email-Zubair.Kakakhel@imgtec.com>
Cc:     soren.brinkmann@xilinx.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, michal.simek@xilinx.com,
        netdev@vger.kernel.org
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <57C70C71.3060603@arm.com>
Date:   Wed, 31 Aug 2016 17:57:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
MIME-Version: 1.0
In-Reply-To: <1472661352-11983-4-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54913
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

On 31/08/16 17:35, Zubair Lutfullah Kakakhel wrote:
> The MIPS based xilfpga platform has the following IRQ structure
> 
> Peripherals --> xilinx_intcontroller -> mips_cpu_int controller
> 
> Add support for the driver to chain the irq handler
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> 
> ---
> V2 -> V3
> Reused existing parent node instead of finding again.
> Cleanup up handler based on review
> 
> V1 -> V2
> 
> No change
> ---
>  drivers/irqchip/irq-axi-intc.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-axi-intc.c b/drivers/irqchip/irq-axi-intc.c
> index cb69241..30bb084 100644
> --- a/drivers/irqchip/irq-axi-intc.c
> +++ b/drivers/irqchip/irq-axi-intc.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_address.h>
>  #include <linux/io.h>
>  #include <linux/bug.h>
> +#include <linux/of_irq.h>
>  
>  /* No one else should require these constants, so define them locally here. */
>  #define ISR 0x00			/* Interrupt Status Register */
> @@ -154,11 +155,23 @@ static const struct irq_domain_ops xintc_irq_domain_ops = {
>  	.map = xintc_map,
>  };
>  
> +static void xil_intc_irq_handler(struct irq_desc *desc)
> +{
> +	u32 pending;
> +
> +	do {
> +		pending = get_irq();
> +		if (pending == -1U)
> +			break;
> +		generic_handle_irq(pending);
> +	} while (true);
> +}
> +
>  static int __init xilinx_intc_of_init(struct device_node *intc,
>  					     struct device_node *parent)
>  {
>  	u32 nr_irq;
> -	int ret;
> +	int ret, irq;
>  	struct xintc_irq_chip *irqc;
>  
>  	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
> @@ -211,6 +224,15 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
>  	root_domain = irq_domain_add_linear(intc, nr_irq, &xintc_irq_domain_ops,
>  					    irqc);
>  
> +	if (parent) {
> +		irq = irq_of_parse_and_map(intc, 0);
> +		if (irq)
> +			irq_set_chained_handler_and_data(irq,
> +							 xil_intc_irq_handler,
> +							 root_domain);
> +
> +	}
> +
>  	irq_set_default_host(root_domain);
>  
>  	return 0;
> 

This doesn't seem right. You've now overridden the xintc_irqc pointer,
so I don't know how you can still process interrupts once you've
discovered a secondary interrupt controller. You've also allocated a
second root_domain, changed the default domain to point to the secondary
controller...

Have you tested this code? Or am I missing something obvious?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
