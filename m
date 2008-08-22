Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2008 22:42:51 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:26466 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20034933AbYHVVmo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2008 22:42:44 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 4B7053ECB; Fri, 22 Aug 2008 14:42:40 -0700 (PDT)
Message-ID: <48AF32CB.2020108@ru.mvista.com>
Date:	Sat, 23 Aug 2008 01:42:35 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips <linux-mips@linux-mips.org>, ralf@linux-mips.org
Subject: Re: [PATCH 2/5] rb532: use physical addresses for gpio and device
 controller registers
References: <200808221701.03810.florian@openwrt.org>
In-Reply-To: <200808221701.03810.florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Florian Fainelli wrote:

> This patch fixes the misuse of virtual addresses for the GPIO and third
> device controller which would lead to problems while accessing ioremap'd
> registers.
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
> index 00a1c78..0628d8d 100644
> --- a/arch/mips/rb532/gpio.c
> +++ b/arch/mips/rb532/gpio.c
> @@ -47,8 +47,8 @@ struct mpmc_device dev3;
>  static struct resource rb532_gpio_reg0_res[] = {
>  	{
>  		.name 	= "gpio_reg0",
> -		.start 	= (u32)(IDT434_REG_BASE + GPIOBASE),
> -		.end 	= (u32)(IDT434_REG_BASE + GPIOBASE + sizeof(struct rb532_gpio_reg)),
> +		.start 	= REGBASE + GPIOBASE,
> +		.end 	= REGBASE + GPIOBASE + sizeof(struct rb532_gpio_reg) -1,
>  		.flags 	= IORESOURCE_MEM,
>  	}
>  };
> @@ -56,8 +56,8 @@ static struct resource rb532_gpio_reg0_res[] = {
>  static struct resource rb532_dev3_ctl_res[] = {
>  	{
>  		.name	= "dev3_ctl",
> -		.start	= (u32)(IDT434_REG_BASE + DEV3BASE),
> -		.end	= (u32)(IDT434_REG_BASE + DEV3BASE + sizeof(struct dev_reg)),
> +		.start	= REGBASE + DEV3BASE,
> +		.end	= REGBASE + DEV3BASE + sizeof(struct dev_reg) -1,
>   

  Hm, your spacing is inconsistent. Why no space after -?

WBR, Sergei
