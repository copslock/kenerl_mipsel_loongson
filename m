Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Mar 2011 21:51:25 +0100 (CET)
Received: from www.tglx.de ([62.245.132.106]:46461 "EHLO www.tglx.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491827Ab1CSUvX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Mar 2011 21:51:23 +0100
Received: from localhost (www.tglx.de [127.0.0.1])
        by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id p2JKpDW5027010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 19 Mar 2011 21:51:14 +0100
Date:   Sat, 19 Mar 2011 21:51:13 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Daney <ddaney@caviumnetworks.com>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] genirq: Add chip hooks for taking CPUs on/off
 line.
In-Reply-To: <1300484916-11133-2-git-send-email-ddaney@caviumnetworks.com>
Message-ID: <alpine.LFD.2.00.1103192050400.2787@localhost6.localdomain6>
References: <1300484916-11133-1-git-send-email-ddaney@caviumnetworks.com> <1300484916-11133-2-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: clamav-milter 0.95.3 at www.tglx.de
X-Virus-Status: Clean
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Fri, 18 Mar 2011, David Daney wrote:
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -178,6 +178,12 @@ static inline int irq_has_action(unsigned int irq)
>  	return desc->action != NULL;
>  }
>  
> +/* Test to see if the irq is currently enabled */
> +static inline int irq_desc_is_enabled(struct irq_desc *desc)
> +{
> +	return desc->depth == 0;
> +}

That want's to go into kernel/irq/internal.h

>  #ifndef CONFIG_GENERIC_HARDIRQS_NO_COMPAT
>  static inline int irq_balancing_disabled(unsigned int irq)
>  {
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index c9c0601..40736f7 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -689,3 +689,38 @@ void irq_modify_status(unsigned int irq, unsigned long clr, unsigned long set)
>  
>  	irq_put_desc_unlock(desc, flags);
>  }
> +
> +void irq_cpu_online(unsigned int irq)

Odd function name. It does not reflect that this is for per cpu
interrupts. So something like irq_xxx_per_cpu_irq(irq)
might be a bit more descriptive.

> +{

So that's called on the cpu which goes online, right?

I wonder whether we can add any sanity check to verify this.

Though I would not worry too much about it. Calling that from a cpu
which is not going offline should have enough nasty side effects that
it's noticed during development. :)

> +	unsigned long flags;
> +	struct irq_chip *chip;
> +	struct irq_desc *desc = irq_to_desc(irq);

Needs to check !desc

> +	raw_spin_lock_irqsave(&desc->lock, flags);
> +
> +	chip = irq_data_get_irq_chip(&desc->irq_data);
> +
> +	if (chip && chip->irq_cpu_online)
> +		chip->irq_cpu_online(&desc->irq_data,
> +				     irq_desc_is_enabled(desc));
> +
> +	raw_spin_unlock_irqrestore(&desc->lock, flags);
> +}
> +
> +void irq_cpu_offline(unsigned int irq)
> +{
> +	unsigned long flags;
> +	struct irq_chip *chip;
> +	struct irq_desc *desc = irq_to_desc(irq);

See above. 

Style nit: I prefer ordering:

+	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_chip *chip;
+	unsigned long flags;

For some reason, probably because I'm used to it, that's easier to
parse. But don't worry about that, I'll turn it around before sticking
it into git. :)

Otherwise I'm fine with the approach itself. 

Though one question remains: should we just iterate over the irq space
and call the online/offline callbacks when available instead of having
the arch code do the iteration.

Thanks,

	tglx
