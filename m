Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Nov 2015 13:15:46 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:36208 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009975AbbKGMPoPaoTA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Nov 2015 13:15:44 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Zv2PD-00044L-Gd; Sat, 07 Nov 2015 13:15:39 +0100
Date:   Sat, 7 Nov 2015 13:14:57 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 09/14] genirq: Implement irq_send_ipi() to be used by
 drivers
In-Reply-To: <1446549181-31788-10-git-send-email-qais.yousef@imgtec.com>
Message-ID: <alpine.DEB.2.11.1511071311470.4032@nanos>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com> <1446549181-31788-10-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 49865
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
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -2013,7 +2013,6 @@ EXPORT_SYMBOL_GPL(irq_set_irqchip_state);
>  struct ipi_mapping *irq_alloc_ipi_mapping(unsigned int nr_cpus)
>  {
>  	struct ipi_mapping *map;
> -	int i;

That one wants to be folded back into the patch which adds it.

> +
> +/**
> + *	__irq_desc_send_ipi - send an IPI to target CPU(s)
> + *	@irq_desc: pointer to irq_desc of the IRQ
> + *	@dest: dest CPU(s), must be the same or a subset of the mask passed to
> + *	       irq_reserve_ipi()
> + *
> + *	Sends an IPI to all cpus in dest mask.
> + *	This function is meant to be used from arch code to save the need to do
> + *	desc lookup that happens in the generic irq_send_ipi().
> + *
> + *	Returns zero on success and negative error number on failure.
> + */
> +int __irq_desc_send_ipi(struct irq_desc *desc, const struct ipi_mask *dest)
> +{
> +	struct irq_data *data = irq_desc_get_irq_data(desc);
> +	struct irq_chip *chip = irq_data_get_irq_chip(data);
> +
> +	if (!chip || !chip->irq_send_ipi)
> +		return -EINVAL;
> +
> +	if (dest->nbits > data->common->ipi_mask->nbits)
> +		return -EINVAL;
> +
> +	/*
> +	 * Do not validate the mask for IPIs marked global. These are
> +	 * regular IPIs so we can avoid the operation as their target
> +	 * mask is the cpu_possible_mask.
> +	 */
> +	if (!data->common->ipi_mask->global) {
> +		if (dest->global)
> +			return -EINVAL;
> +
> +		if (!bitmap_subset(dest->cpu_bitmap,
> +				   data->common->ipi_mask->cpu_bitmap,
> +				   dest->nbits))
> +			return -EINVAL;
> +	} else {
> +		if (!dest->global)
> +			return -EINVAL;

We might want to add sanity checks here as well, but you can leave it
as is for now.

This can move to ipi.c as well.

Thanks,

	tglx
