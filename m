Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2008 13:34:38 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:49328 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037423AbYHMMe2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Aug 2008 13:34:28 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id DC0D63EC9; Wed, 13 Aug 2008 05:34:22 -0700 (PDT)
Message-ID: <48A2D4CB.1030901@ru.mvista.com>
Date:	Wed, 13 Aug 2008 16:34:19 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Kevin Hickey <khickey@rmicorp.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: modernize Pb1200 IRQ cascade handling code.
References: <1218568881-3544-2-git-send-email-mano@roarinelk.homelinux.net>
In-Reply-To: <1218568881-3544-2-git-send-email-mano@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:

> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>   
[...]
> diff --git a/arch/mips/au1000/pb1200/irqmap.c b/arch/mips/au1000/pb1200/irqmap.c
> index 2a505ad..7229f30 100644
> --- a/arch/mips/au1000/pb1200/irqmap.c
> +++ b/arch/mips/au1000/pb1200/irqmap.c
> @@ -48,62 +48,26 @@ int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
>  /*
>   * Support for External interrupts on the Pb1200 Development platform.
>   */
> -static volatile int pb1200_cascade_en;
>  
> -irqreturn_t pb1200_cascade_handler(int irq, void *dev_id)
> +static void pb1200_cascade_handler(unsigned int irq, struct irq_desc *desc)
>  {
>  	unsigned short bisr = bcsr->int_status;
> -	int extirq_nr = 0;
> -
> -	/* Clear all the edge interrupts. This has no effect on level. */
>   

   Note this comment...

> -	bcsr->int_status = bisr;
> -	for ( ; bisr; bisr &= bisr - 1) {
> -		extirq_nr = PB1200_INT_BEGIN + __ffs(bisr);
> -		/* Ack and dispatch IRQ */
> -		do_IRQ(extirq_nr);
> -	}
>  
> -	return IRQ_RETVAL(1);
> +	for ( ; bisr; bisr &= bisr - 1)
> +		generic_handle_irq(PB1200_INT_BEGIN + __ffs(bisr));
>  }
>  
> -inline void pb1200_enable_irq(unsigned int irq_nr)
> +static void pb1200_unmask_irq(unsigned int irq_nr)
>  {
>  	bcsr->intset_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
>  	bcsr->intset = 1 << (irq_nr - PB1200_INT_BEGIN);
>  }
>  
> -inline void pb1200_disable_irq(unsigned int irq_nr)
> +static void pb1200_maskack_irq(unsigned int irq_nr)
>  {
>  	bcsr->intclr_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
>  	bcsr->intclr = 1 << (irq_nr - PB1200_INT_BEGIN);
>   

   I wonder what's the difference between int{clr|set} and 
int{clr|set}_mask registers...

[...]
> +	bcsr->int_status = 1 << (irq_nr - PB1200_INT_BEGIN);	/* ack */
>   

   The above comment said that writing to this register has no effect on 
the level-triggered interrupts, so this statement doesn't seem to make 
sense since you're treating all interrupts as level-triggered below.

> @@ -113,12 +77,9 @@ static struct irq_chip external_irq_type = {
>  #ifdef CONFIG_MIPS_DB1200
>  	.name = "Db1200 Ext",
>  #endif
> -	.startup  = pb1200_startup_irq,
> -	.shutdown = pb1200_shutdown_irq,
> -	.ack      = pb1200_disable_irq,
> -	.mask     = pb1200_disable_irq,
> -	.mask_ack = pb1200_disable_irq,
> -	.unmask   = pb1200_enable_irq,
> +	.mask		= pb1200_maskack_irq,
> +	.mask_ack	= pb1200_maskack_irq,
>   

   You can use the same function for the mask() and mask_ack() methods 
but it only should be masking IRQ, as clearing it doesn't make sense...

> @@ -147,14 +108,14 @@ void _board_init_irq(void)
>  	}
>  #endif
>  
> -	for (irq = PB1200_INT_BEGIN; irq <= PB1200_INT_END; irq++) {
> -		set_irq_chip_and_handler(irq, &external_irq_type,
> -					 handle_level_irq);
> -		pb1200_disable_irq(irq);
> -	}
> +	/* mask & disable & ack all */
> +	bcsr->intclr_mask = 0xffff;
> +	bcsr->intclr = 0xffff;
> +	bcsr->int_status = 0xffff;
> +
> +	for (irq = PB1200_INT_BEGIN; irq <= PB1200_INT_END; irq++)
> +		set_irq_chip_and_handler_name(irq, &external_irq_type,
> +					 handle_level_irq, "level");
>   

   Are all those IRQs indeed level-triggered?

WBR, Sergei
