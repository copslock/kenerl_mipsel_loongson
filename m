Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2009 12:59:06 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:37984 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20023672AbZD2L7E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Apr 2009 12:59:04 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3TBx1IM010239;
	Wed, 29 Apr 2009 13:59:02 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3TBwxmj010237;
	Wed, 29 Apr 2009 13:58:59 +0200
Date:	Wed, 29 Apr 2009 13:58:59 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>,
	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix build failures on msp_irq_slp.c
Message-ID: <20090429115859.GA1487@linux-mips.org>
References: <200904271659.48357.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200904271659.48357.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 27, 2009 at 04:59:48PM +0200, Florian Fainelli wrote:

> Trying to build MSP4200 VoIP defconfig also fails on msp_irq_slp.c
> with a non-existing reference to mask_slp_irq, which is in turn
> mask_msp_slp_irq. Passed that, we will also miss a comma when
> calling set_irq_chip_and_handler. This patch fixes both issues.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c b/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
> index f5f1b8d..66f6f85 100644
> --- a/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
> @@ -45,7 +45,7 @@ static inline void mask_msp_slp_irq(unsigned int irq)
>   */
>  static inline void ack_msp_slp_irq(unsigned int irq)
>  {
> -	mask_slp_irq(irq);
> +	mask_msp_slp_irq(irq);
>  
>  	/*
>  	 * only really necessary for 18, 16-14 and sometimes 3:0 (since

The whole irq chip thing in this file is looking suspect as it treats
acknowledging and mask an interrupt as the same thing.  Sure that is the
right thing?

> @@ -79,7 +79,7 @@ void __init msp_slp_irq_init(void)
>  
>  	/* initialize all the IRQ descriptors */
>  	for (i = MSP_SLP_INTBASE; i < MSP_PER_INTBASE + 32; i++)
> -		set_irq_chip_and_handler(i, &msp_slp_irq_controller
> +		set_irq_chip_and_handler(i, &msp_slp_irq_controller,
>  					 handle_level_irq);
>  }
>  

> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c b/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
> index f5f1b8d..66f6f85 100644

Please don't send the patch twice in one email ...

  Ralf
