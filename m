Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2008 13:51:16 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:32075 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28587982AbYHVMvH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2008 13:51:07 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 156393ECA; Fri, 22 Aug 2008 05:51:01 -0700 (PDT)
Message-ID: <48AEB644.8010104@ru.mvista.com>
Date:	Fri, 22 Aug 2008 16:51:16 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips <linux-mips@linux-mips.org>, ralf@linux-mips.org
Subject: Re: [PATCH 2/6] rb532: use physical addresses for gpio and device
 controller registers
References: <200808220014.27497.florian@openwrt.org>
In-Reply-To: <200808220014.27497.florian@openwrt.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Florian Fainelli wrote:

> This patch fixes the misuse of virtual address which would lead to
> serious problems while accessing ioremap'd registers in the GPIO
> code.

> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
> index 00a1c78..3d1632c 100644
> --- a/arch/mips/rb532/gpio.c
> +++ b/arch/mips/rb532/gpio.c
> @@ -47,8 +47,8 @@ struct mpmc_device dev3;
>  static struct resource rb532_gpio_reg0_res[] = {
>  	{
>  		.name 	= "gpio_reg0",
> -		.start 	= (u32)(IDT434_REG_BASE + GPIOBASE),
> -		.end 	= (u32)(IDT434_REG_BASE + GPIOBASE + sizeof(struct rb532_gpio_reg)),
> +		.start 	= (REG_BASE + GPIOBASE),
> +		.end 	= (REG_BASE + GPIOBASE + sizeof(struct rb532_gpio_reg)),
>  		.flags 	= IORESOURCE_MEM,
>  	}
>  };
> @@ -56,8 +56,8 @@ static struct resource rb532_gpio_reg0_res[] = {
>  static struct resource rb532_dev3_ctl_res[] = {
>  	{
>  		.name	= "dev3_ctl",
> -		.start	= (u32)(IDT434_REG_BASE + DEV3BASE),
> -		.end	= (u32)(IDT434_REG_BASE + DEV3BASE + sizeof(struct dev_reg)),
> +		.start	= (REG_BASE + DEV3BASE),
> +		.end	= (REG_BASE + DEV3BASE + sizeof(struct dev_reg)),
>  		.flags	= IORESOURCE_MEM,
>  	}
>  };

    Oh, and parens are not needed in the initializers anymore...

WBR, Sergei
