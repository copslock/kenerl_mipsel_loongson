Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 09:15:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48444 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27024739AbcDDHPmfo0cH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Apr 2016 09:15:42 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u347FdTv014619;
        Mon, 4 Apr 2016 09:15:39 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u347FaEr014618;
        Mon, 4 Apr 2016 09:15:36 +0200
Date:   Mon, 4 Apr 2016 09:15:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Binbin Zhou <zhoubb@lemote.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Chunbo Cui <cuicb@lemote.com>, Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH v3 6/8] MIPS: Loongson-1A: Add IRQ type setting support
Message-ID: <20160404071536.GC13706@linux-mips.org>
References: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
 <1456793296-17120-7-git-send-email-zhoubb@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456793296-17120-7-git-send-email-zhoubb@lemote.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Please consider moving this to drivers/irqchip/.

  Ralf

On Tue, Mar 01, 2016 at 08:48:14AM +0800, Binbin Zhou wrote:
> Date:   Tue,  1 Mar 2016 08:48:14 +0800
> From: Binbin Zhou <zhoubb@lemote.com>
> To: Ralf Baechle <ralf@linux-mips.org>
> Cc: John Crispin <john@phrozen.org>, "Steven J . Hill"
>  <Steven.Hill@imgtec.com>, linux-mips@linux-mips.org, Fuxin Zhang
>  <zhangfx@lemote.com>, Zhangjin Wu <wuzhangjin@gmail.com>, Kelvin Cheung
>  <keguang.zhang@gmail.com>, Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui
>  <cuicb@lemote.com>, Huacai Chen <chenhc@lemote.com>
> Subject: [PATCH v3 6/8] MIPS: Loongson-1A: Add IRQ type setting support
> 
> Loongson 1A's INT controller support two different interrupt trigger mode:
> level trigger and edge trigger.
> 
> Whether the INT controller stores the external interrupts is
> the difference between them.
> The edge trigger should do this, and operate INT_CLR register
> to clear the CPU interrupt state.
> 
> Signed-off-by: Chunbo Cui <cuicb@lemote.com>
> Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/loongson32/common/irq.c | 46 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/mips/loongson32/common/irq.c b/arch/mips/loongson32/common/irq.c
> index 455a770..01e8cb9 100644
> --- a/arch/mips/loongson32/common/irq.c
> +++ b/arch/mips/loongson32/common/irq.c
> @@ -62,12 +62,57 @@ static void ls1x_irq_unmask(struct irq_data *d)
>  			| (1 << bit), LS1X_INTC_INTIEN(n));
>  }
>  
> +static int ls1x_irq_set_type(struct irq_data *data, unsigned int flow_type)
> +{
> +	unsigned int bit = (data->irq - LS1X_IRQ_BASE) & 0x1f;
> +	unsigned int n = (data->irq - LS1X_IRQ_BASE) >> 5;
> +
> +	if (flow_type & IRQ_TYPE_EDGE_BOTH) {
> +		if ((flow_type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) {
> +			pr_info("ls1x irq don't support both rising and falling\n");
> +			return -1;
> +		}
> +		ls1x_writel(ls1x_readl(LS1X_INTC_INTCLR(n))
> +				| (1 << bit), LS1X_INTC_INTCLR(n));
> +		if (flow_type & IRQ_TYPE_EDGE_RISING)
> +			ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n))
> +					| (1 << bit), LS1X_INTC_INTPOL(n));
> +		else
> +			ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n))
> +					& ~(1 << bit), LS1X_INTC_INTPOL(n));
> +
> +		ls1x_writel(ls1x_readl(LS1X_INTC_INTEDGE(n))
> +				| (1 << bit), LS1X_INTC_INTEDGE(n));
> +		ls1x_writel(ls1x_readl(LS1X_INTC_INTIEN(n))
> +				| (1 << bit), LS1X_INTC_INTIEN(n));
> +		irq_set_handler_locked(data, handle_edge_irq);
> +	} else if (flow_type && IRQ_TYPE_LEVEL_MASK) {
> +		ls1x_writel(ls1x_readl(LS1X_INTC_INTCLR(n))
> +				| (1 << bit), LS1X_INTC_INTCLR(n));
> +		if (flow_type & IRQ_TYPE_LEVEL_HIGH)
> +			ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n))
> +					| (1 << bit), LS1X_INTC_INTPOL(n));
> +		else if (flow_type & IRQ_TYPE_LEVEL_LOW)
> +			ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n))
> +					& ~(1 << bit), LS1X_INTC_INTPOL(n));
> +
> +		ls1x_writel(ls1x_readl(LS1X_INTC_INTEDGE(n))
> +				& ~(1 << bit), LS1X_INTC_INTEDGE(n));
> +		ls1x_writel(ls1x_readl(LS1X_INTC_INTIEN(n))
> +				| (1 << bit), LS1X_INTC_INTIEN(n));
> +		irq_set_handler_locked(data, handle_level_irq);
> +	}
> +
> +	return IRQ_SET_MASK_OK;
> +}
> +
>  static struct irq_chip ls1x_irq_chip = {
>  	.name		= "LS1X-INTC",
>  	.irq_ack	= ls1x_irq_ack,
>  	.irq_mask	= ls1x_irq_mask,
>  	.irq_mask_ack	= ls1x_irq_mask_ack,
>  	.irq_unmask	= ls1x_irq_unmask,
> +	.irq_set_type	= ls1x_irq_set_type,
>  };
>  
>  static void ls1x_irq_dispatch(int n)
> @@ -138,6 +183,7 @@ static void __init ls1x_irq_init(int base)
>  	setup_irq(INT1_IRQ, &cascade_irqaction);
>  	setup_irq(INT2_IRQ, &cascade_irqaction);
>  	setup_irq(INT3_IRQ, &cascade_irqaction);
> +	setup_irq(INT4_IRQ, &cascade_irqaction);
>  }
>  
>  void __init arch_init_irq(void)
> -- 
> 1.9.1
> 

  Ralf
