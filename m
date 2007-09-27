Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2007 12:29:24 +0100 (BST)
Received: from www.osadl.org ([213.239.205.134]:9633 "EHLO mail.tglx.de")
	by ftp.linux-mips.org with ESMTP id S20027254AbXI0L3Q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Sep 2007 12:29:16 +0100
Received: from [127.0.0.1] (debian [213.239.205.147])
	by mail.tglx.de (Postfix) with ESMTP id D737465C292;
	Thu, 27 Sep 2007 13:29:03 +0200 (CEST)
Subject: Re: [PATCH] Compile handle_percpu_irq even for uniprocessor kernels
From:	Thomas Gleixner <tglx@linutronix.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	Molnar Ingo <mingo@elte.hu>, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
In-Reply-To: <20070927112448.GA16909@linux-mips.org>
References: <20070927112448.GA16909@linux-mips.org>
Content-Type: text/plain
Date:	Thu, 27 Sep 2007 13:28:59 +0200
Message-Id: <1190892539.23376.90.camel@chaos>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.0 (2.12.0-3.fc8) 
Content-Transfer-Encoding: 7bit
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips


On Thu, 2007-09-27 at 12:24 +0100, Ralf Baechle wrote:
> Compiling handle_percpu_irq only on uniprocessor generates an artificial
> special case so a typical use like:
> 
>   set_irq_chip_and_handler(irq, &some_irq_type, handle_percpu_irq);
> 
> needs to be conditionally compiled only on SMP systems as well and an
> alternative UP construct is usually needed - for no good reason.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Makes sense.

Acked-by: Thomas Gleixner <tglx@linutronix.de>

> ---
> This fixes uniprocessor configurations for some MIPS SMP systems.
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index f1a73f0..9b5dff6 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -503,7 +503,6 @@ out_unlock:
>  	spin_unlock(&desc->lock);
>  }
>  
> -#ifdef CONFIG_SMP
>  /**
>   *	handle_percpu_IRQ - Per CPU local irq handler
>   *	@irq:	the interrupt number
> @@ -529,8 +528,6 @@ handle_percpu_irq(unsigned int irq, struct irq_desc *desc)
>  		desc->chip->eoi(irq);
>  }
>  
> -#endif /* CONFIG_SMP */
> -
>  void
>  __set_irq_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
>  		  const char *name)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
