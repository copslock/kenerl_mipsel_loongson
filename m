Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2013 22:56:42 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:33411 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6867240Ab3LKV4infG31 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Dec 2013 22:56:38 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id EBA9E85EA;
        Wed, 11 Dec 2013 22:56:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CO3HB4TseSCj; Wed, 11 Dec 2013 22:56:31 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:9985:896f:79da:e61] (unknown [IPv6:2001:470:1f0b:447:9985:896f:79da:e61])
        by hauke-m.de (Postfix) with ESMTPSA id 0702F857F;
        Wed, 11 Dec 2013 22:56:30 +0100 (CET)
Message-ID: <52A8DF8C.50105@hauke-m.de>
Date:   Wed, 11 Dec 2013 22:56:28 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH V3 2/2] MIPS: BCM47XX: Prepare support for GPIO buttons
References: <1385741397-32740-2-git-send-email-zajec5@gmail.com> <1386689071-13170-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1386689071-13170-1-git-send-email-zajec5@gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38696
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

On 12/10/2013 04:24 PM, Rafał Miłecki wrote:
> So far this adds support for one Netgear model only, but it's designed
> and ready to add many more device. We could hopefully import database
> from OpenWrt.
> Support for SSB is currently disabled, because SSB doesn't implement IRQ
> domain yet.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
> V3: Use __initconst and copy data for detected device. This will allow
>     us to free some memory after init.
> ---
>  arch/mips/bcm47xx/Makefile          |    2 +-
>  arch/mips/bcm47xx/bcm47xx_private.h |    3 ++
>  arch/mips/bcm47xx/buttons.c         |   95 +++++++++++++++++++++++++++++++++++
>  arch/mips/bcm47xx/setup.c           |    1 +
>  4 files changed, 100 insertions(+), 1 deletion(-)
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
> index 0000000..3138f03
> --- /dev/null
> +++ b/arch/mips/bcm47xx/buttons.c
> @@ -0,0 +1,95 @@
> +#include "bcm47xx_private.h"
> +
> +#include <linux/input.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/interrupt.h>
> +#include <linux/ssb/ssb_embedded.h>
> +#include <bcm47xx_board.h>
> +#include <bcm47xx.h>
> +
> +/**************************************************
> + * Database
> + **************************************************/
> +
> +static struct gpio_keys_button
> +bcm47xx_buttons_netgear_wndr4500_v1[] __initconst = {
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
> +/* Copy data from __initconst */
> +static int __init bcm47xx_buttons_copy(struct gpio_keys_button *buttons,
> +					size_t nbuttons)
> +{
> +	size_t size = nbuttons * sizeof(*buttons);
> +
> +	bcm47xx_button_pdata.buttons = kmalloc(size, GFP_KERNEL);
> +	if (!bcm47xx_button_pdata.buttons)
> +		return -ENOMEM;
> +	memcpy(bcm47xx_button_pdata.buttons, buttons, size);
> +	bcm47xx_button_pdata.nbuttons = nbuttons;
> +
> +	return 0;
> +}
> +
> +#define bcm47xx_copy_bdata(dev_buttons)					\
> +	bcm47xx_buttons_copy(dev_buttons, ARRAY_SIZE(dev_buttons));
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
> +		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr4500_v1);
> +		break;
> +	default:
> +		pr_debug("No buttons configuration found for this device\n");
> +		return -ENOTSUPP;
> +	}
> +
> +	if (err)
> +		return -ENOMEM;
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
