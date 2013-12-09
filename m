Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Dec 2013 14:33:50 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45194 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816841Ab3LINdrDxnLt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Dec 2013 14:33:47 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 9A53B85EA;
        Mon,  9 Dec 2013 14:33:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Kv7pP77Q45pS; Mon,  9 Dec 2013 14:33:39 +0100 (CET)
Received: from [IPv6:2001:638:708:30da:cca6:d93d:ae72:1ec8] (unknown [IPv6:2001:638:708:30da:cca6:d93d:ae72:1ec8])
        by hauke-m.de (Postfix) with ESMTPSA id E8AF4857F;
        Mon,  9 Dec 2013 14:33:38 +0100 (CET)
Message-ID: <52A5C6B0.7070307@hauke-m.de>
Date:   Mon, 09 Dec 2013 14:33:36 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH V2 2/2] MIPS: BCM47XX: Prepare support for GPIO buttons
References: <1385741397-32740-1-git-send-email-zajec5@gmail.com> <1385741397-32740-2-git-send-email-zajec5@gmail.com>
In-Reply-To: <1385741397-32740-2-git-send-email-zajec5@gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 11/29/2013 05:09 PM, Rafał Miłecki wrote:
> So far this adds support for one Netgear model only, but it's designed
> and ready to add many more device. We could hopefully import database
> from OpenWrt.
> Support for SSB is currently disabled, because SSB doesn't implement IRQ
> domain yet.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
>  arch/mips/bcm47xx/Makefile          |    2 +-
>  arch/mips/bcm47xx/bcm47xx_private.h |    3 ++
>  arch/mips/bcm47xx/buttons.c         |   81 +++++++++++++++++++++++++++++++++++
>  arch/mips/bcm47xx/setup.c           |    1 +
>  4 files changed, 86 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/bcm47xx/buttons.c
> 
> diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
> index 84e9aed..006a05e 100644
> --- a/arch/mips/bcm47xx/Makefile
> +++ b/arch/mips/bcm47xx/Makefile
> @@ -4,5 +4,5 @@
>  #
>  
>  obj-y				+= irq.o nvram.o prom.o serial.o setup.o time.o sprom.o
> -obj-y				+= board.o leds.o
> +obj-y				+= board.o buttons.o leds.o
>  obj-$(CONFIG_BCM47XX_SSB)	+= wgt634u.o
> diff --git a/arch/mips/bcm47xx/bcm47xx_private.h b/arch/mips/bcm47xx/bcm47xx_private.h
> index 1a1e600..5c94ace 100644
> --- a/arch/mips/bcm47xx/bcm47xx_private.h
> +++ b/arch/mips/bcm47xx/bcm47xx_private.h
> @@ -3,6 +3,9 @@
>  
>  #include <linux/kernel.h>
>  
> +/* buttons.c */
> +int __init bcm47xx_buttons_register(void);
> +
>  /* leds.c */
>  void __init bcm47xx_leds_register(void);
>  
> diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
> new file mode 100644
> index 0000000..ecd6b1b
> --- /dev/null
> +++ b/arch/mips/bcm47xx/buttons.c
> @@ -0,0 +1,81 @@
> +#include "bcm47xx_private.h"
> +
> +#include <linux/input.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/interrupt.h>
> +#include <linux/ssb/ssb_embedded.h>
> +#include <bcm47xx_board.h>
> +#include <bcm47xx.h>
> +
> +struct input_dev *input;

This is unused please remove it.

> +
> +/**************************************************
> + * Database
> + **************************************************/
> +
> +static struct gpio_keys_button
> +bcm47xx_buttons_netgear_wndr4500_v1[] = {

Could you make this __initconst so it will be freed after the kernel
booted. Then you have to make sure it gets copied into a different non
init memory region if it will be used after the kernel booted. This
should scale to ~100 devices so this memory gets significant.

> +	{
> +		.code		= KEY_WPS_BUTTON,
> +		.gpio		= 4,
> +		.active_low	= 1,
> +	},
> +	{
> +		.code		= KEY_RFKILL,
> +		.gpio		= 5,
> +		.active_low	= 1,
> +	},
> +	{
> +		.code		= KEY_RESTART,
> +		.gpio		= 6,
> +		.active_low	= 1,
> +	},
> +};
> +
> +/**************************************************
> + * Init
> + **************************************************/
> +
> +static struct gpio_keys_platform_data bcm47xx_button_pdata;
> +
> +static struct platform_device bcm47xx_buttons_gpio_keys = {
> +	.name = "gpio-keys",
> +	.dev = {
> +		.platform_data = &bcm47xx_button_pdata,
> +	}
> +};
> +
> +#define bcm47xx_set_bdata(dev_buttons) do {				\
> +	bcm47xx_button_pdata.buttons = dev_buttons;			\
> +	bcm47xx_button_pdata.nbuttons = ARRAY_SIZE(dev_buttons);	\
> +} while (0)
> +
> +int __init bcm47xx_buttons_register(void)
> +{
> +	enum bcm47xx_board board = bcm47xx_board_get();
> +	int err;
> +
> +#ifdef CONFIG_BCM47XX_SSB
> +	if (bcm47xx_bus_type == BCM47XX_BUS_TYPE_SSB) {
> +		pr_debug("Buttons on SSB are not supported yet.\n");
> +		return -ENOTSUPP;
> +	}
> +#endif
> +
> +	switch (board) {
> +	case BCM47XX_BOARD_NETGEAR_WNDR4500V1:
> +		bcm47xx_set_bdata(bcm47xx_buttons_netgear_wndr4500_v1);
> +		break;
> +	default:
> +		pr_debug("No buttons configuration found for this device\n");
> +		return -ENOTSUPP;
> +	}
> +
> +	err = platform_device_register(&bcm47xx_buttons_gpio_keys);
> +	if (err) {
> +		pr_err("Failed to register platform device: %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
> index 7e61c0b..a791124 100644
> --- a/arch/mips/bcm47xx/setup.c
> +++ b/arch/mips/bcm47xx/setup.c
> @@ -242,6 +242,7 @@ static int __init bcm47xx_register_bus_complete(void)
>  #endif
>  	}
>  
> +	bcm47xx_buttons_register();
>  	bcm47xx_leds_register();
>  
>  	return 0;
> 
