Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2008 10:37:18 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:31546 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20034860AbYHVJhK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2008 10:37:10 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 614763ECA; Fri, 22 Aug 2008 02:37:06 -0700 (PDT)
Message-ID: <48AE88BE.2000004@ru.mvista.com>
Date:	Fri, 22 Aug 2008 13:37:02 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips <linux-mips@linux-mips.org>, ralf@linux-mips.org
Subject: Re: [PATCH 2/6] rb532: use physical addresses for gpio and device
 controller registers
References: <200808220014.27497.florian@openwrt.org>
In-Reply-To: <200808220014.27497.florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Florian Fainelli wrote:

> This patch fixes the misuse of virtual address which would lead to
> serious problems while accessing ioremap'd registers in the GPIO
> code.
>
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
>   

   I think .end initializers are wrong in both cases, you should've 
subtracted one while at it.
   You could aso have used CPHYSADDR(IDT434_REG_BASE) ISO defining 
REG_BASE...

> diff --git a/include/asm-mips/mach-rc32434/rb.h b/include/asm-mips/mach-rc32434/rb.h
> index e0a76e3..f229da4 100644
> --- a/include/asm-mips/mach-rc32434/rb.h
> +++ b/include/asm-mips/mach-rc32434/rb.h
> @@ -18,6 +18,7 @@
>  #include <linux/genhd.h>
>  
>  #define IDT434_REG_BASE	((volatile void *) KSEG1ADDR(0x18000000))
> +#define REG_BASE	0x18000000

   I think you'd better #define IDT434_REG_BASE via REG_BASE.

WBR, Sergei
