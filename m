Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 21:00:11 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:51682 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21365976AbZAOVAH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Jan 2009 21:00:07 +0000
Received: (qmail 9689 invoked by uid 1000); 15 Jan 2009 21:58:51 +0100
Date:	Thu, 15 Jan 2009 21:58:51 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	ralf@linux-mips.org, Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] au1000: convert to using gpiolib
Message-ID: <20090115205851.GD8656@roarinelk.homelinux.net>
References: <200901151646.49591.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200901151646.49591.florian@openwrt.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Florian,

On Thu, Jan 15, 2009 at 04:46:48PM +0100, Florian Fainelli wrote:
> This patch converts the GPIO board code to use gpiolib

Very nice; a few minor things though:

> --- a/arch/mips/alchemy/common/gpio.c
> +++ b/arch/mips/alchemy/common/gpio.c
> -static void au1xxx_gpio2_write(unsigned gpio, int value)
> +static void au1000_gpio2_set(struct gpio_chip *chip,
> +				unsigned offset, int value)
>  {
> -	gpio -= AU1XXX_GPIO_BASE;
> +	u32 mask = ((GPIO2_OUT_EN_MASK << offset) | (!!value << offset));
> +	struct au1000_gpio_chip *gpch;
> +	unsigned long flags;
> +
> +	gpch = container_of(chip, struct au1000_gpio_chip, chip);
>  
> -	gpio2->output = (GPIO2_OUTPUT_ENABLE_MASK << gpio) | ((!!value) << gpio);
> +	local_irq_save(flags);
> +	writel(mask, gpch->regbase + AU1000_GPIO2_OUT);
> +	local_irq_restore(flags);

Because of the 'enable | value' scheme I believe you don't require any
locking here.


> +struct au1000_gpio_chip au1000_gpio_chip[] = {
> +	[0] = {
> +		.regbase			= (void __iomem *)SYS_BASE,
> +		.chip = {
> +			.label			= "au1000-gpio1",
> +			.direction_input	= au1000_gpio1_direction_input,
> +			.direction_output	= au1000_gpio1_direction_output,
> +			.get			= au1000_gpio1_get,
> +			.set			= au1000_gpio1_set,
> +			.base			= 0,
> +			.ngpio			= 32,
> +		},
> +	},
> +#if !defined(CONFIG_SOC_AU1000)
> +	[1] = {
> +		.regbase                        = (void __iomem *)GPIO2_BASE,
> +		.chip = {
> +			.label                  = "au1000-gpio2",
> +			.direction_input        = au1000_gpio2_direction_input,
> +			.direction_output       = au1000_gpio2_direction_output,
> +			.get                    = au1000_gpio2_get,
> +			.set                    = au1000_gpio2_set,
> +			.base                   = AU1XXX_GPIO_BASE,
> +			.ngpio                  = 32,
> +		},
> +	},
>  #endif
> -	else
> -		return au1xxx_gpio1_read(gpio);
> -}
> -EXPORT_SYMBOL(au1xxx_gpio_get_value);
> +};
[...]  
> +static int __init au1000_gpio_init(void)
>  {
> -	if (gpio >= AU1XXX_GPIO_BASE)
> -#if defined(CONFIG_SOC_AU1000)
> -		;
> -#else
> -		au1xxx_gpio2_write(gpio, value);
> -#endif
> -	else
> -		au1xxx_gpio1_write(gpio, value);
> -}
> -EXPORT_SYMBOL(au1xxx_gpio_set_value);
> +	gpiochip_add(&au1000_gpio_chip[0].chip);
> +#if !defined(CONFIG_SOC_AU1000)
> +	gpiochip_add(&au1000_gpio_chip[1].chip);
>  
[...]
> +arch_initcall(au1000_gpio_init);

Can you please make the gpiolib registration dependent on a
CONFIG symbol?  I.e. make the au1000_gpio{,2}_direction() and
friends calls globally visible but let the individual boards
decide whether they want to use the gpio numbering imposed by
this patch.

Long explanation:  I maintain a number of modules with a common connector
interface, based on different architectures (sh, mips and arm so far).
I also maintain a few baseboards which can carry theese modules.  Modules
provide 16 gpios numbered 0-15, which are used by the baseboards.  Since
I need to keep the baseboard code free of arch-specific hacks, every module
provides its own gpio-chip which distributes the gpio-lib calls to various
on- and off-chip peripherals.  On my alchemy board in particular, those 16
gpios are provided by a mixture of gpio1, gpio2 and FPGA based pins (yes
I repeatedly moanoed to the hw guys about this but pin multiplexing and
required features make a sane implementation difficult; but at least I was
allowed to write the VHDL for the fpga-based gpios).

If this explanation doesn't make sense I'll gladly whip up an addon patch.


> diff --git a/arch/mips/include/asm/mach-au1x00/gpio.h b/arch/mips/include/asm/mach-au1x00/gpio.h
> index 2dc61e0..34d9b72 100644
> --- a/arch/mips/include/asm/mach-au1x00/gpio.h
> +++ b/arch/mips/include/asm/mach-au1x00/gpio.h
> @@ -5,65 +5,29 @@
>  
>  #define AU1XXX_GPIO_BASE	200

please change this to AU1XXX_GPIO2_BASE (it's the base number
of the GPIO2 block pins after all)


Thanks!
	Manuel Lauss
