Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 13:59:50 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:36824 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20030624AbYHZM7s (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Aug 2008 13:59:48 +0100
Received: (qmail 1551 invoked by uid 1000); 26 Aug 2008 14:59:47 +0200
Date:	Tue, 26 Aug 2008 14:59:47 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips <linux-mips@linux-mips.org>, ralf@linux-mips.org,
	Kevin Hickey <khickey@rmicorp.com>
Subject: Re: [PATCH][RFT] au1000: convert to gpiolib
Message-ID: <20080826125947.GA1515@roarinelk.homelinux.net>
References: <200808232349.28277.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200808232349.28277.florian@openwrt.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello Florian,

On Sat, Aug 23, 2008 at 11:49:27PM +0200, Florian Fainelli wrote:
> This patch converts Au1000 to use gpiolib. Testers
> welcome !
> 
> Manuel, Kevin, could you test this on your boards ? Thanks

No problems on my end.

 
> diff --git a/arch/mips/au1000/common/gpio.c b/arch/mips/au1000/common/gpio.c
> index b485d94..67b3a6b 100644
> --- a/arch/mips/au1000/common/gpio.c
> +++ b/arch/mips/au1000/common/gpio.c
> @@ -1,5 +1,5 @@
  
> -int au1xxx_gpio_direction_output(unsigned gpio, int value)
> +int __init au1000_gpio_init(void)

make that one static please.


>  {
> -	if (gpio >= AU1XXX_GPIO_BASE)
> -#if defined(CONFIG_SOC_AU1000)
> -		return -ENODEV;
> -#else
> -		return au1xxx_gpio2_direction_output(gpio, value);
> -#endif
> -
> -	return au1xxx_gpio1_direction_output(gpio, value);
> +	gpiochip_add(&au1000_gpio_chip[0].chip);
> +#if !defined(CONFIG_SOC_AU1000)
> +	gpiochip_add(&au1000_gpio_chip[1].chip);
> +#endif	
> +	return 0;
>  }
> -EXPORT_SYMBOL(au1xxx_gpio_direction_output);
> +arch_initcall(au1000_gpio_init);


Thanks,
	Manuel Lauss
