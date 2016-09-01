Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 19:18:15 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:40320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992328AbcIARSHrsw02 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Sep 2016 19:18:07 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A30C1D67;
        Thu,  1 Sep 2016 10:18:01 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FBEB3F303;
        Thu,  1 Sep 2016 10:17:59 -0700 (PDT)
Subject: Re: [Patch v4 04/12] irqchip: axi-intc: Add support for parent intc
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        monstr@monstr.eu, ralf@linux-mips.org, tglx@linutronix.de,
        jason@lakedaemon.net
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472748665-47774-5-git-send-email-Zubair.Kakakhel@imgtec.com>
Cc:     soren.brinkmann@xilinx.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, michal.simek@xilinx.com,
        netdev@vger.kernel.org
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <57C862C6.7070703@arm.com>
Date:   Thu, 1 Sep 2016 18:17:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
MIME-Version: 1.0
In-Reply-To: <1472748665-47774-5-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54952
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

On 01/09/16 17:50, Zubair Lutfullah Kakakhel wrote:
> The MIPS based xilfpga platform has the following IRQ structure
> 
> Peripherals --> xilinx_intcontroller -> mips_cpu_int controller
> 
> Add support for the driver to chain the irq handler
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> 
> ---
> V3 -> V4
> Clean up if/else when a parent is found
> Pass irqchip structure to handler as data
> 
> V2 -> V3
> Reused existing parent node instead of finding again.
> Cleanup up handler based on review
> 
> V1 -> V2
> 
> No change
> ---
>  drivers/irqchip/irq-axi-intc.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-axi-intc.c b/drivers/irqchip/irq-axi-intc.c
> index ac31548..683b1f7 100644
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
> +		pending = xintc_get_irq();
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
> @@ -217,7 +230,15 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
>  	root_domain = irq_domain_add_linear(intc, nr_irq, &xintc_irq_domain_ops,
>  					    irqc);
>  
> -	irq_set_default_host(root_domain);
> +	if (parent) {
> +		irq = irq_of_parse_and_map(intc, 0);
> +		if (irq)
> +			irq_set_chained_handler_and_data(irq,
> +							 xil_intc_irq_handler,
> +							 irqc);
> +
> +	} else
> +		irq_set_default_host(root_domain);

Coding style, please.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
