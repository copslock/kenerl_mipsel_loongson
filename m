Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2017 12:48:45 +0200 (CEST)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47014 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993868AbdH3Ksghz8xP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Aug 2017 12:48:36 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F001E80D;
        Wed, 30 Aug 2017 03:48:29 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C6E43F483;
        Wed, 30 Aug 2017 03:48:28 -0700 (PDT)
Subject: Re: [PATCH] irqchip: irq-bcm7120-l2: Use correct I/O accessors for
 irq_fwd_mask
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     opendmb@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "open list:BROADCOM BMIPS MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>
References: <1504032187-53035-1-git-send-email-f.fainelli@gmail.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <2c52e192-9cb2-0e53-ddc2-23e25d1ae5bc@arm.com>
Date:   Wed, 30 Aug 2017 11:48:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1504032187-53035-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59890
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

On 29/08/17 19:43, Florian Fainelli wrote:
> Initialization of irq_fwd_mask was done using __raw_readl() which
> happens to work for all cases except when using ARM BE8 which requires
> readl() (with the proper swapping). Move the initialization of the

s/readl/writel/, I presume?

> irq_fwd_mask till later when we have correctly defined our I/O
> accessors.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/irqchip/irq-bcm7120-l2.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
> index 64c2692070ef..983640eba418 100644
> --- a/drivers/irqchip/irq-bcm7120-l2.c
> +++ b/drivers/irqchip/irq-bcm7120-l2.c
> @@ -250,12 +250,6 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
>  	if (ret < 0)
>  		goto out_free_l1_data;
>  
> -	for (idx = 0; idx < data->n_words; idx++) {
> -		__raw_writel(data->irq_fwd_mask[idx],
> -			     data->pair_base[idx] +
> -			     data->en_offset[idx]);
> -	}
> -
>  	for (irq = 0; irq < data->num_parent_irqs; irq++) {
>  		ret = bcm7120_l2_intc_init_one(dn, data, irq, valid_mask);
>  		if (ret)
> @@ -297,6 +291,10 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
>  		gc->reg_base = data->pair_base[idx];
>  		ct->regs.mask = data->en_offset[idx];
>  
> +		/* gc->reg_base is defined and so is gc->writel */
> +		irq_reg_writel(gc, data->irq_fwd_mask[idx],
> +			       data->en_offset[idx]);
> +
>  		ct->chip.irq_mask = irq_gc_mask_clr_bit;
>  		ct->chip.irq_unmask = irq_gc_mask_set_bit;
>  		ct->chip.irq_ack = irq_gc_noop;
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
