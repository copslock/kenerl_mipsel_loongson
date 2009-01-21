Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2009 00:47:28 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:1222 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S21366243AbZAUAr0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Jan 2009 00:47:26 +0000
Received: from 10.8.0.24 ([10.8.0.24]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Wed, 21 Jan 2009 00:47:17 +0000
Received: from kh-d820 by webmail.razamicroelectronics.com; 20 Jan 2009 18:47:18 -0600
Subject: Re: [PATCH] Alchemy: fix edge irq handling
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <20090120100353.GA18971@roarinelk.homelinux.net>
References: <20090120100353.GA18971@roarinelk.homelinux.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Tue, 20 Jan 2009 18:47:18 -0600
Message-Id: <1232498838.3678.17.camel@kh-d820>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

Manuel,

Have you actually seen this happen (outside of inducing it manually)?  I
have some concern that by doing this we may either miss interrupts on
devices that send a lot (by design) or miss a design bug in a system
because we are masking out some interrupts.  I know that system
stability is important, but I don't like hiding problems.

=Kevin

On Tue, 2009-01-20 at 11:03 +0100, Manuel Lauss wrote:
> Introduce separate mack_ack callbacks which really do shut up the
> edge-triggered irqs when called.  Without this change, high-frequency
> edge interrupts can result in an endless irq storm, hanging the system.
> 
> This can be easily triggered for example by setting an irq to falling
> edge type and manually connecting the associated pin to ground.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
>  arch/mips/alchemy/common/irq.c |   32 ++++++++++++++++++++++++--------
>  1 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
> index c88c821..60da581 100644
> --- a/arch/mips/alchemy/common/irq.c
> +++ b/arch/mips/alchemy/common/irq.c
> @@ -320,6 +320,16 @@ static void au1x_ic0_mask(unsigned int irq_nr)
>  	au_sync();
>  }
>  
> +static void au1x_ic0_maskack(unsigned int irq_nr)
> +{
> +	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
> +	au_writel(1 << bit, IC0_MASKCLR);
> +	au_writel(1 << bit, IC0_WAKECLR);
> +	au_writel(1 << bit, IC0_FALLINGCLR);
> +	au_writel(1 << bit, IC0_RISINGCLR);
> +	au_sync();
> +}
> +
>  static void au1x_ic1_mask(unsigned int irq_nr)
>  {
>  	unsigned int bit = irq_nr - AU1000_INTC1_INT_BASE;
> @@ -328,6 +338,16 @@ static void au1x_ic1_mask(unsigned int irq_nr)
>  	au_sync();
>  }
>  
> +static void au1x_ic1_maskack(unsigned int irq_nr)
> +{
> +	unsigned int bit = irq_nr - AU1000_INTC1_INT_BASE;
> +	au_writel(1 << bit, IC1_MASKCLR);
> +	au_writel(1 << bit, IC1_WAKECLR);
> +	au_writel(1 << bit, IC1_FALLINGCLR);
> +	au_writel(1 << bit, IC1_RISINGCLR);
> +	au_sync();
> +}
> +
>  static void au1x_ic0_ack(unsigned int irq_nr)
>  {
>  	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
> @@ -379,25 +399,21 @@ static int au1x_ic1_setwake(unsigned int irq, unsigned int on)
>  /*
>   * irq_chips for both ICs; this way the mask handlers can be
>   * as short as possible.
> - *
> - * NOTE: the ->ack() callback is used by the handle_edge_irq
> - *	 flowhandler only, the ->mask_ack() one by handle_level_irq,
> - *	 so no need for an irq_chip for each type of irq (level/edge).
>   */
>  static struct irq_chip au1x_ic0_chip = {
>  	.name		= "Alchemy-IC0",
> -	.ack		= au1x_ic0_ack,		/* edge */
> +	.ack		= au1x_ic0_ack,
>  	.mask		= au1x_ic0_mask,
> -	.mask_ack	= au1x_ic0_mask,	/* level */
> +	.mask_ack	= au1x_ic0_maskack,
>  	.unmask		= au1x_ic0_unmask,
>  	.set_type	= au1x_ic_settype,
>  };
>  
>  static struct irq_chip au1x_ic1_chip = {
>  	.name		= "Alchemy-IC1",
> -	.ack		= au1x_ic1_ack,		/* edge */
> +	.ack		= au1x_ic1_ack,
>  	.mask		= au1x_ic1_mask,
> -	.mask_ack	= au1x_ic1_mask,	/* level */
> +	.mask_ack	= au1x_ic1_maskack,
>  	.unmask		= au1x_ic1_unmask,
>  	.set_type	= au1x_ic_settype,
>  	.set_wake	= au1x_ic1_setwake,
-- 
=Kevin
