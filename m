Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Aug 2009 21:40:02 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51421 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493186AbZHHTj4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Aug 2009 21:39:56 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n78JeXHc001153;
	Sat, 8 Aug 2009 20:40:33 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n78JeXdG001152;
	Sat, 8 Aug 2009 20:40:33 +0100
Date:	Sat, 8 Aug 2009 20:40:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 8/8] bcm63xx: prepare for on-board watchdog support
Message-ID: <20090808194033.GD22761@linux-mips.org>
References: <200908072347.16203.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200908072347.16203.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 07, 2009 at 11:47:15PM +0200, Florian Fainelli wrote:

> This patch registers the watchdog platform_device that
> we are going to use in the watchdog platform_driver in
> a subsequent patch.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
> index 70ba038..a4abc11 100644
> --- a/arch/mips/bcm63xx/Makefile
> +++ b/arch/mips/bcm63xx/Makefile
> @@ -5,6 +5,7 @@ obj-y		+= dev-usb-ohci.o
>  obj-y		+= dev-usb-ehci.o
>  obj-y		+= dev-enet.o
>  obj-y		+= dev-dsp.o
> +obj-y		+= dev-wdt.o
>  obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
>  
>  obj-y		+= boards/
> diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
> index 17a8636..e6a7b4f 100644
> --- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
> +++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
> @@ -28,6 +28,7 @@
>  #include <bcm63xx_dev_usb_ohci.h>
>  #include <bcm63xx_dev_usb_ehci.h>
>  #include <bcm63xx_dev_dsp.h>
> +#include <bcm63xx_dev_wdt.h>
>  #include <board_bcm963xx.h>
>  
>  #define PFX	"board_bcm963xx: "
> @@ -798,6 +799,7 @@ int __init board_register_devices(void)
>  	u32 val;
>  
>  	bcm63xx_uart_register();
> +	bcm63xx_wdt_register();
>  
>  	if (board.has_pccard)
>  		bcm63xx_pcmcia_register();
> diff --git a/arch/mips/bcm63xx/dev-wdt.c b/arch/mips/bcm63xx/dev-wdt.c
> new file mode 100644
> index 0000000..6e18489
> --- /dev/null
> +++ b/arch/mips/bcm63xx/dev-wdt.c
> @@ -0,0 +1,36 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2008 Florian Fainelli <florian@openwrt.org> 
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <bcm63xx_cpu.h>
> +
> +static struct resource wdt_resources[] = {
> +	{
> +		.start		= -1, /* filled at runtime */
> +		.end		= -1, /* filled at runtime */
> +		.flags		= IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct platform_device bcm63xx_wdt_device = {
> +	.name		= "bcm63xx-wdt",
> +	.id		= 0,
> +	.num_resources	= ARRAY_SIZE(wdt_resources),
> +	.resource	= wdt_resources,
> +};
> +
> +int __init bcm63xx_wdt_register(void)
> +{
> +	wdt_resources[0].start = bcm63xx_regset_address(RSET_WDT);
> +	wdt_resources[0].end = wdt_resources[0].start;
> +	wdt_resources[0].end += RSET_WDT_SIZE - 1;
> +
> +	return platform_device_register(&bcm63xx_wdt_device);
> +}
> diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_wdt.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_wdt.h
> new file mode 100644
> index 0000000..4aae2c7
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_wdt.h
> @@ -0,0 +1,6 @@
> +#ifndef BCM63XX_DEV_WDT_H_
> +#define BCM63XX_DEV_WDT_H_
> +
> +int bcm63xx_wdt_register(void);
> +
> +#endif /* BCM63XX_DEV_WDT_H_ */

bcm63xx_dev_wdt.h only really exists to keep checpatch.pl happy - not a
terribly good reason.  I suggest to remove the explicit call to
bcm63xx_wdt_register, make the function static and use some initfunc magic
to call it and bcm63xx_dev_wdt.h can go.

  Ralf
