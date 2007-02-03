Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Feb 2007 15:05:05 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:65246 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038798AbXBCPFA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 Feb 2007 15:05:00 +0000
Received: from localhost (p3165-ipad210funabasi.chiba.ocn.ne.jp [58.88.122.165])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 732E7B6C5; Sun,  4 Feb 2007 00:03:38 +0900 (JST)
Date:	Sun, 04 Feb 2007 00:03:38 +0900 (JST)
Message-Id: <20070204.000338.21930811.anemo@mba.ocn.ne.jp>
To:	mano@roarinelk.homelinux.net
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.20-rc: au1x irqs broken
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070202095814.GA23967@roarinelk.homelinux.net>
References: <20070202.161857.55145886.nemoto@toshiba-tops.co.jp>
	<20070202075328.GB23737@roarinelk.homelinux.net>
	<20070202095814.GA23967@roarinelk.homelinux.net>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 2 Feb 2007 10:58:14 +0100, Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> Here's what tripped me up. I switched au1x over to use the kernel
> flow handlers, and forgot to undo all of it.
> 
> rediffed against 2.6.20-rc7
> 
> diff -Naurp linux-2.6.20-rc7/arch/mips/au1000/common/irq.c linux-2.6.20-rc7-work/arch/mips/au1000/common/irq.c
...
> @@ -172,20 +170,6 @@ static inline void mask_and_ack_level_ir
>  	return;
>  }
>  
> -
> -static void end_irq(unsigned int irq_nr)
> -{
> -	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))) {
> -		local_enable_irq(irq_nr);
> -	}
> -#if defined(CONFIG_MIPS_PB1000)
> -	if (irq_nr == AU1000_GPIO_15) {
> -		au_writel(0x4000, PB1000_MDR); /* enable int */
> -		au_sync();
> -	}
> -#endif
> -}
> -
>  unsigned long save_local_and_disable(int controller)
>  {
>  	int i;

You are to drop PB1000 support?

> @@ -233,39 +217,31 @@ void restore_local_and_enable(int contro
>  
>  
>  static struct irq_chip rise_edge_irq_type = {
> -	.typename = "Au1000 Rise Edge",
> -	.ack = mask_and_ack_rise_edge_irq,
> +	.name = "Au1000",
>  	.mask = local_disable_irq,
>  	.mask_ack = mask_and_ack_rise_edge_irq,
>  	.unmask = local_enable_irq,
> -	.end = end_irq,
>  };
>  
>  static struct irq_chip fall_edge_irq_type = {
> -	.typename = "Au1000 Fall Edge",
> -	.ack = mask_and_ack_fall_edge_irq,
> +	.name = "Au1000",
>  	.mask = local_disable_irq,
>  	.mask_ack = mask_and_ack_fall_edge_irq,
>  	.unmask = local_enable_irq,
> -	.end = end_irq,
>  };
>  
>  static struct irq_chip either_edge_irq_type = {
> -	.typename = "Au1000 Rise or Fall Edge",
> -	.ack = mask_and_ack_either_edge_irq,
> +	.name = "Au1000",
>  	.mask = local_disable_irq,
>  	.mask_ack = mask_and_ack_either_edge_irq,
>  	.unmask = local_enable_irq,
> -	.end = end_irq,
>  };
>  
>  static struct irq_chip level_irq_type = {
> -	.typename = "Au1000 Level",
> -	.ack = mask_and_ack_level_irq,
> +	.name = "Au1000",
>  	.mask = local_disable_irq,
>  	.mask_ack = mask_and_ack_level_irq,
>  	.unmask = local_enable_irq,
> -	.end = end_irq,
>  };
>  
>  #ifdef CONFIG_PM

.ack entries are required for handle_edge_irq.  And if you wanted to
unregister an irq handler by set_irq_handler(irq, NULL), .ack will be
used even for level flow handler.

Also note that typename to name conversion patch is already in queue
tree.

> diff -Naurp linux-2.6.20-rc7/arch/mips/kernel/irq.c linux-2.6.20-rc7-work/arch/mips/kernel/irq.c
> --- linux-2.6.20-rc7/arch/mips/kernel/irq.c	2007-02-01 15:04:35.831983000 +0100
> +++ linux-2.6.20-rc7-work/arch/mips/kernel/irq.c	2007-02-02 11:15:34.201983000 +0100
> @@ -118,6 +118,7 @@ int show_interrupts(struct seq_file *p, 
>  			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
>  #endif
>  		seq_printf(p, " %14s", irq_desc[i].chip->name);
> +		seq_printf(p, "-%-8s", irq_desc[i].name);
>  		seq_printf(p, "  %s", action->name);
>  
>  		for (action=action->next; action; action = action->next)
> 

irq_desc[i].name might be NULL.

---
Atsushi Nemoto
