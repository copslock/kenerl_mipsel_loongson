Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 11:00:41 +0100 (WEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41721 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021926AbZFBKAd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Jun 2009 11:00:33 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n52A09vR009495;
	Tue, 2 Jun 2009 11:00:09 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n52A09xh009487;
	Tue, 2 Jun 2009 11:00:09 +0100
Date:	Tue, 2 Jun 2009 11:00:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 3/3] bcm63xx: early registering of gpiochip
Message-ID: <20090602100009.GD3527@linux-mips.org>
References: <200906012018.20972.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200906012018.20972.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 01, 2009 at 08:18:20PM +0200, Florian Fainelli wrote:

> This patch makes the gpiochip be registered
> earlier in the prom code. This allows GPIO-based
> board detection to be made earlier.
> 
> Tested-by: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/bcm63xx/gpio.c b/arch/mips/bcm63xx/gpio.c
> index b78d3fd..997fcaa 100644
> --- a/arch/mips/bcm63xx/gpio.c
> +++ b/arch/mips/bcm63xx/gpio.c
> @@ -120,9 +120,8 @@ static struct gpio_chip bcm63xx_gpio_chip = {
>  	.ngpio			= BCM63XX_GPIO_COUNT,
>  };
>  
> -static int __init bcm63xx_gpio_init(void)
> +int __init bcm63xx_gpio_init(void)
>  {
>  	printk(KERN_INFO "registering %d GPIOs\n", BCM63XX_GPIO_COUNT);
>  	return gpiochip_add(&bcm63xx_gpio_chip);
>  }
> -arch_initcall(bcm63xx_gpio_init);
> diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
> index d97ceed..1e5bb15 100644
> --- a/arch/mips/bcm63xx/prom.c
> +++ b/arch/mips/bcm63xx/prom.c
> @@ -13,6 +13,7 @@
>  #include <bcm63xx_cpu.h>
>  #include <bcm63xx_io.h>
>  #include <bcm63xx_regs.h>
> +#include <bcm63xx_gpio.h>
>  
>  void __init prom_init(void)
>  {
> @@ -40,6 +41,9 @@ void __init prom_init(void)
>  
>  	/* do low level board init */
>  	board_prom_init();
> +
> +	/* early register gpio */

That word order sounds odd ...

> +	bcm63xx_gpio_init();
>  }
>  
>  void __init prom_free_prom_memory(void)
> diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
> index 72cee75..8bc812f 100644
> --- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
> +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
> @@ -1,6 +1,8 @@
>  #ifndef BCM63XX_GPIO_H
>  #define BCM63XX_GPIO_H
>  
> +int __init bcm63xx_gpio_init(void);

It is not necessary to declare a function as __init.  But if you do you
better include <linux/init.h> first.  With this patch you'd rely on init.h
having previously included which eventually when the context changes will
blow up.

And not last, the patch seems to reject ...

  Ralf
