Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 19:16:04 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:40302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992328AbcIARPzfAaU2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Sep 2016 19:15:55 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64EBBD3E;
        Thu,  1 Sep 2016 10:15:48 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D144A3F303;
        Thu,  1 Sep 2016 10:15:46 -0700 (PDT)
Subject: Re: [Patch v4 02/12] irqchip: axi-intc: Clean up irqdomain argument
 and read/write
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        monstr@monstr.eu, ralf@linux-mips.org, tglx@linutronix.de,
        jason@lakedaemon.net
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472748665-47774-3-git-send-email-Zubair.Kakakhel@imgtec.com>
Cc:     soren.brinkmann@xilinx.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, michal.simek@xilinx.com,
        netdev@vger.kernel.org
From:   Marc Zyngier <marc.zyngier@arm.com>
X-Enigmail-Draft-Status: N1110
Organization: ARM Ltd
Message-ID: <57C86241.8000806@arm.com>
Date:   Thu, 1 Sep 2016 18:15:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
MIME-Version: 1.0
In-Reply-To: <1472748665-47774-3-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54951
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
> The drivers read/write function handling is a bit quirky.
> And the irqmask is passed directly to the handler.
> 
> Add a new irqchip struct to pass to the handler and
> cleanup read/write handling.
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> 
> ---
> V3 -> V4
> Better error handling for kzalloc
> Erroring out if the axi intc is probed twice as that isn't
> supported
> 
> V2 -> V3
> New patch. Cleans up driver structure
> ---
>  drivers/irqchip/irq-axi-intc.c | 101 +++++++++++++++++++++++++++--------------
>  1 file changed, 68 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-axi-intc.c b/drivers/irqchip/irq-axi-intc.c
> index 90bec7d..7ab0762 100644
> --- a/drivers/irqchip/irq-axi-intc.c
> +++ b/drivers/irqchip/irq-axi-intc.c
> @@ -16,8 +16,6 @@
>  #include <linux/io.h>
>  #include <linux/bug.h>
>  
> -static void __iomem *intc_baseaddr;
> -
>  /* No one else should require these constants, so define them locally here. */
>  #define ISR 0x00			/* Interrupt Status Register */
>  #define IPR 0x04			/* Interrupt Pending Register */
> @@ -31,8 +29,16 @@ static void __iomem *intc_baseaddr;
>  #define MER_ME (1<<0)
>  #define MER_HIE (1<<1)
>  
> -static unsigned int (*read_fn)(void __iomem *);
> -static void (*write_fn)(u32, void __iomem *);
> +struct xintc_irq_chip {
> +	void __iomem *base;
> +	struct	irq_domain *domain;
> +	struct	irq_chip chip;
> +	u32	intr_mask;
> +	unsigned int (*read)(void __iomem *iomem);
> +	void (*write)(u32 data, void __iomem *iomem);
> +};
> +
> +static struct xintc_irq_chip *xintc_irqc;
>  
>  static void intc_write32(u32 val, void __iomem *addr)
>  {
> @@ -54,6 +60,18 @@ static unsigned int intc_read32_be(void __iomem *addr)
>  	return ioread32be(addr);
>  }
>  
> +static inline unsigned int xintc_read(struct xintc_irq_chip *xintc_irqc,
> +					     int reg)
> +{
> +	return xintc_irqc->read(xintc_irqc->base + reg);
> +}
> +
> +static inline void xintc_write(struct xintc_irq_chip *xintc_irqc,
> +				     int reg, u32 data)
> +{
> +	xintc_irqc->write(data, xintc_irqc->base + reg);
> +}
> +
>  static void intc_enable_or_unmask(struct irq_data *d)
>  {
>  	unsigned long mask = 1 << d->hwirq;
> @@ -65,21 +83,21 @@ static void intc_enable_or_unmask(struct irq_data *d)
>  	 * acks the irq before calling the interrupt handler
>  	 */
>  	if (irqd_is_level_type(d))
> -		write_fn(mask, intc_baseaddr + IAR);
> +		xintc_write(xintc_irqc, IAR, mask);
>  
> -	write_fn(mask, intc_baseaddr + SIE);
> +	xintc_write(xintc_irqc, SIE, mask);
>  }
>  
>  static void intc_disable_or_mask(struct irq_data *d)
>  {
>  	pr_debug("disable: %ld\n", d->hwirq);
> -	write_fn(1 << d->hwirq, intc_baseaddr + CIE);
> +	xintc_write(xintc_irqc, CIE, 1 << d->hwirq);
>  }
>  
>  static void intc_ack(struct irq_data *d)
>  {
>  	pr_debug("ack: %ld\n", d->hwirq);
> -	write_fn(1 << d->hwirq, intc_baseaddr + IAR);
> +	xintc_write(xintc_irqc, IAR, 1 << d->hwirq);
>  }
>  
>  static void intc_mask_ack(struct irq_data *d)
> @@ -87,8 +105,8 @@ static void intc_mask_ack(struct irq_data *d)
>  	unsigned long mask = 1 << d->hwirq;
>  
>  	pr_debug("disable_and_ack: %ld\n", d->hwirq);
> -	write_fn(mask, intc_baseaddr + CIE);
> -	write_fn(mask, intc_baseaddr + IAR);
> +	xintc_write(xintc_irqc, CIE, mask);
> +	xintc_write(xintc_irqc, IAR, mask);
>  }
>  
>  static struct irq_chip intc_dev = {
> @@ -105,7 +123,7 @@ unsigned int get_irq(void)
>  {
>  	unsigned int hwirq, irq = -1;
>  
> -	hwirq = read_fn(intc_baseaddr + IVR);
> +	hwirq = xintc_read(xintc_irqc, IVR);
>  	if (hwirq != -1U)
>  		irq = irq_find_mapping(root_domain, hwirq);
>  
> @@ -116,7 +134,8 @@ unsigned int get_irq(void)
>  
>  static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
>  {
> -	u32 intr_mask = (u32)d->host_data;
> +	struct xintc_irq_chip *irqc = d->host_data;
> +	u32 intr_mask = irqc->intr_mask;
>  
>  	if (intr_mask & (1 << hw)) {
>  		irq_set_chip_and_handler_name(irq, &intc_dev,
> @@ -138,59 +157,75 @@ static const struct irq_domain_ops xintc_irq_domain_ops = {
>  static int __init xilinx_intc_of_init(struct device_node *intc,
>  					     struct device_node *parent)
>  {
> -	u32 nr_irq, intr_mask;
> +	u32 nr_irq;
>  	int ret;
> +	struct xintc_irq_chip *irqc;
> +
> +	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
> +	if (!irqc)
> +		return -ENOMEM;
>  
> -	intc_baseaddr = of_iomap(intc, 0);
> -	BUG_ON(!intc_baseaddr);
> +	if (xintc_irqc) {
> +		pr_err("%s: Multiple instances of axi_intc aren't supported\n");
> +		ret = -EINVAL;
> +		goto err_alloc;

How about testing the variable first and error-ing early, rather than
performing the allocation and undoing it later?

> +	} else {
> +		xintc_irqc = irqc;
> +	}
> +
> +	irqc->base = of_iomap(intc, 0);
> +	BUG_ON(!irqc->base);
>  
>  	ret = of_property_read_u32(intc, "xlnx,num-intr-inputs", &nr_irq);
>  	if (ret < 0) {
>  		pr_err("%s: unable to read xlnx,num-intr-inputs\n", __func__);
> -		return ret;
> +		goto err_alloc;
>  	}
>  
> -	ret = of_property_read_u32(intc, "xlnx,kind-of-intr", &intr_mask);
> +	ret = of_property_read_u32(intc, "xlnx,kind-of-intr", &irqc->intr_mask);
>  	if (ret < 0) {
>  		pr_err("%s: unable to read xlnx,kind-of-intr\n", __func__);
> -		return ret;
> +		goto err_alloc;
>  	}
>  
> -	if (intr_mask >> nr_irq)
> +	if (irqc->intr_mask >> nr_irq)
>  		pr_warn("%s: mismatch in kind-of-intr param\n", __func__);
>  
>  	pr_info("%s: num_irq=%d, edge=0x%x\n",
> -		intc->full_name, nr_irq, intr_mask);
> +		intc->full_name, nr_irq, irqc->intr_mask);
>  
> -	write_fn = intc_write32;
> -	read_fn = intc_read32;
> +	irqc->read = intc_read32;
> +	irqc->write = intc_write32;
>  
>  	/*
>  	 * Disable all external interrupts until they are
>  	 * explicity requested.
>  	 */
> -	write_fn(0, intc_baseaddr + IER);
> +	xintc_write(irqc, IER, 0);
>  
>  	/* Acknowledge any pending interrupts just in case. */
> -	write_fn(0xffffffff, intc_baseaddr + IAR);
> +	xintc_write(irqc, IAR, 0xffffffff);
>  
>  	/* Turn on the Master Enable. */
> -	write_fn(MER_HIE | MER_ME, intc_baseaddr + MER);
> -	if (!(read_fn(intc_baseaddr + MER) & (MER_HIE | MER_ME))) {
> -		write_fn = intc_write32_be;
> -		read_fn = intc_read32_be;
> -		write_fn(MER_HIE | MER_ME, intc_baseaddr + MER);
> +	xintc_write(irqc, MER, MER_HIE | MER_ME);
> +	if (!(xintc_read(irqc, MER) & (MER_HIE | MER_ME))) {
> +		irqc->read = intc_read32_be;
> +		irqc->write = intc_write32_be;
> +		xintc_write(irqc, MER, MER_HIE | MER_ME);
>  	}
>  
> -	/* Yeah, okay, casting the intr_mask to a void* is butt-ugly, but I'm
> -	 * lazy and Michal can clean it up to something nicer when he tests
> -	 * and commits this patch.  ~~gcl */
>  	root_domain = irq_domain_add_linear(intc, nr_irq, &xintc_irq_domain_ops,
> -							(void *)intr_mask);
> +					    irqc);

What if the domain allocation fails? You've now configured the HW for
something you can't use. What are the side effects? Hint: handle
everything that can fail first, and only then poke the HW.

>  
>  	irq_set_default_host(root_domain);
>  
>  	return 0;
> +
> +err_alloc:
> +	xintc_irqc = NULL;
> +	kfree(irqc);
> +	return ret;
> +
>  }
>  
>  IRQCHIP_DECLARE(xilinx_intc, "xlnx,xps-intc-1.00.a", xilinx_intc_of_init);
> 

Instead of posting 3 versions in 3 days, please take the time to
correctly address the comments, and review your own code before
re-posting it. Rushing to get it merged for 4.9 is really not the best
approach.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
