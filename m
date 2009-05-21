Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 19:51:32 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:57899 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20025398AbZEUSvZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 May 2009 19:51:25 +0100
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 7F0F93ED0; Thu, 21 May 2009 11:51:20 -0700 (PDT)
Message-ID: <4A15A2DD.2000203@ru.mvista.com>
Date:	Thu, 21 May 2009 22:52:13 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] rb532: check irq number when handling GPIO interrupts
References: <200905211949.47486.florian@openwrt.org>
In-Reply-To: <200905211949.47486.florian@openwrt.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Florian Fainelli wrote:

> This patch makes sure that we are not going to clear
> or change the interrupt status of a GPIO interrupt
> superior to 13 as this is the maximum number of GPIO
> interrupt source (p.232 of the RC32434 reference manual).

> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/rb532/irq.c b/arch/mips/rb532/irq.c
> index 53eeb5e..afdcafc 100644
> --- a/arch/mips/rb532/irq.c
> +++ b/arch/mips/rb532/irq.c
> @@ -151,7 +151,8 @@ static void rb532_disable_irq(unsigned int irq_nr)
>  		mask |= intr_bit;
>  		WRITE_MASK(addr, mask);
>  
> -		if (group == GPIO_MAPPED_IRQ_GROUP)
> +		/* There is a maximum of 13 GPIO interrupts */
> +		if (group == GPIO_MAPPED_IRQ_GROUP && irq_nr <= (GROUP4_IRQ_BASE + 13))

    So, 13 or 14? The code seem to allow 14. Probably it should be <, not <= 
here...

>  			rb532_gpio_set_istat(0, irq_nr - GPIO_MAPPED_IRQ_BASE);
>  
>  		/*
> @@ -174,7 +175,7 @@ static int rb532_set_type(unsigned int irq_nr, unsigned type)
>  	int gpio = irq_nr - GPIO_MAPPED_IRQ_BASE;
>  	int group = irq_to_group(irq_nr);
>  
> -	if (group != GPIO_MAPPED_IRQ_GROUP)
> +	if (group != GPIO_MAPPED_IRQ_GROUP || irq_nr > (GROUP4_IRQ_BASE + 13))

    ... and >= here.

>  		return (type == IRQ_TYPE_LEVEL_HIGH) ? 0 : -EINVAL;
>  
>  	switch (type) {

WBR, Sergei
