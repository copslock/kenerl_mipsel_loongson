Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Nov 2006 15:30:15 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:60128 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039054AbWKUPaK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Nov 2006 15:30:10 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 82E3B3EBE; Tue, 21 Nov 2006 07:29:51 -0800 (PST)
Message-ID: <45631BD2.4090509@ru.mvista.com>
Date:	Tue, 21 Nov 2006 18:31:30 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] use generic_handle_irq, handle_level_irq, handle_percpu_irq
References: <20061114.011318.99611303.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061114.011318.99611303.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> Note: This patch can be applied after the patch titled:
> "[PATCH] mips irq cleanups"
> in lmo linux-queue tree (or 2.6.19-rc5-mm1) and the patch titled:
> "[PATCH] do_IRQ cleanup"
> (http://www.linux-mips.org/archives/linux-mips/2006-10/msg00348.html)

> Further incorporation of generic irq framework.  Replacing __do_IRQ()
> by proper flow handler would make the irq handling path a bit simpler
> and faster.

> * use generic_handle_irq() instead of __do_IRQ().
> * use handle_level_irq for obvious level-type irq chips.
> * use handle_percpu_irq for irqs marked as IRQ_PER_CPU.
> * setup .eoi routine for irq chips possibly used with handle_percpu_irq.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

[...]

> diff --git a/arch/mips/kernel/irq-msc01.c b/arch/mips/kernel/irq-msc01.c
> index e1880b2..bcaad66 100644
> --- a/arch/mips/kernel/irq-msc01.c
> +++ b/arch/mips/kernel/irq-msc01.c
> @@ -117,6 +117,7 @@ struct irq_chip msc_levelirq_type = {
>  	.mask = mask_msc_irq,
>  	.mask_ack = level_mask_and_ack_msc_irq,
>  	.unmask = unmask_msc_irq,
> +	.eoi = unmask_msc_irq,
>  	.end = end_msc_irq,
>  };

    You don't have to define eoi() method for the level flow. And you don't 
need end() method anymore.

> @@ -126,6 +127,7 @@ struct irq_chip msc_edgeirq_type = {
>  	.mask = mask_msc_irq,
>  	.mask_ack = edge_mask_and_ack_msc_irq,
>  	.unmask = unmask_msc_irq,
> +	.eoi = unmask_msc_irq,
>  	.end = end_msc_irq,
>  };

    The same about the edge flow...

> diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
> index 3b7cfa4..be5ac23 100644
> --- a/arch/mips/kernel/irq_cpu.c
> +++ b/arch/mips/kernel/irq_cpu.c
> @@ -62,6 +62,7 @@ static struct irq_chip mips_cpu_irq_cont
>  	.mask		= mask_mips_irq,
>  	.mask_ack	= mask_mips_irq,
>  	.unmask		= unmask_mips_irq,
> +	.eoi		= unmask_mips_irq,
>  	.end		= mips_cpu_irq_end,
>  };

    The same about the level flow and eoi() and end() here...

> @@ -104,6 +105,7 @@ static struct irq_chip mips_mt_cpu_irq_c
>  	.mask		= mask_mips_mt_irq,
>  	.mask_ack	= mips_mt_cpu_irq_ack,
>  	.unmask		= unmask_mips_mt_irq,
> +	.eoi		= unmask_mips_mt_irq,
>  	.end		= mips_mt_cpu_irq_end,
>  };
>  
> @@ -124,7 +126,8 @@ void __init mips_cpu_irq_init(int irq_ba
>  			set_irq_chip(i, &mips_mt_cpu_irq_controller);
>  
>  	for (i = irq_base + 2; i < irq_base + 8; i++)
> -		set_irq_chip(i, &mips_cpu_irq_controller);
> +		set_irq_chip_and_handler(i, &mips_cpu_irq_controller,
> +					 handle_level_irq);

    BTW, isn't IRQ7 per-CPU?

>  	mips_cpu_irq_base = irq_base;
>  }
> diff --git a/arch/mips/mips-boards/atlas/atlas_int.c b/arch/mips/mips-boards/atlas/atlas_int.c
> index 7c71004..43dba6c 100644
> --- a/arch/mips/mips-boards/atlas/atlas_int.c
> +++ b/arch/mips/mips-boards/atlas/atlas_int.c
> @@ -74,6 +74,7 @@ static struct irq_chip atlas_irq_type = 
>  	.mask = disable_atlas_irq,
>  	.mask_ack = disable_atlas_irq,
>  	.unmask = enable_atlas_irq,
> +	.eoi = enable_atlas_irq,
>  	.end = end_atlas_irq,
>  };

    The same about the level flow and eoi() and end() here too...

> @@ -207,7 +208,7 @@ static inline void init_atlas_irqs (int 
>  	atlas_hw0_icregs->intrsten = 0xffffffff;
>  
>  	for (i = ATLAS_INT_BASE; i <= ATLAS_INT_END; i++)
> -		set_irq_chip(i, &atlas_irq_type);
> +		set_irq_chip_and_handler(i, &atlas_irq_type, handle_level_irq);
>  }
>  
>  static struct irqaction atlasirq = {

WBR, Sergei
