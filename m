Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 00:09:03 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:33481 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823024Ab3KFXJBdfB3m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Nov 2013 00:09:01 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id A9D1F8F61;
        Thu,  7 Nov 2013 00:09:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QglL3XU36oei; Thu,  7 Nov 2013 00:08:54 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:d56:3d67:959b:8cd5] (unknown [IPv6:2001:470:1f0b:447:d56:3d67:959b:8cd5])
        by hauke-m.de (Postfix) with ESMTPSA id A53BD857F;
        Thu,  7 Nov 2013 00:08:54 +0100 (CET)
Message-ID: <527ACC04.9060803@hauke-m.de>
Date:   Thu, 07 Nov 2013 00:08:52 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH V3] MIPS: BCM47XX: Prepare support for LEDs
References: <1383771746-31119-1-git-send-email-zajec5@gmail.com> <1383772274-12571-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1383772274-12571-1-git-send-email-zajec5@gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38467
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

On 11/06/2013 10:11 PM, Rafał Miłecki wrote:
> So far this is mostly just a proof of concept, database consists of a
> single device. Creating a nice iterateable array wasn't an option
> because devices have different amount of LEDs. And we don't want to
> waste memory just because of support for a device with dozens on LEDs.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
> V2: use bcm47xx_private.h instead of ugly define in setup.c
> V3: don't add #include <bcm47xx_data.h> in setup.c. No need to.
> ---
>  arch/mips/bcm47xx/Kconfig           |    2 +
>  arch/mips/bcm47xx/Makefile          |    2 +-
>  arch/mips/bcm47xx/bcm47xx_private.h |    9 +++++
>  arch/mips/bcm47xx/leds.c            |   73 +++++++++++++++++++++++++++++++++++
>  arch/mips/bcm47xx/setup.c           |    5 +++
>  5 files changed, 90 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/bcm47xx/bcm47xx_private.h
>  create mode 100644 arch/mips/bcm47xx/leds.c
> 
> diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
> index ba61192..81a3d28 100644
> --- a/arch/mips/bcm47xx/Kconfig
> +++ b/arch/mips/bcm47xx/Kconfig
> @@ -12,6 +12,7 @@ config BCM47XX_SSB
>  	select SSB_PCICORE_HOSTMODE if PCI
>  	select SSB_DRIVER_GPIO
>  	select GPIOLIB
> +	select LEDS_GPIO_REGISTER
>  	default y
>  	help
>  	 Add support for old Broadcom BCM47xx boards with Sonics Silicon Backplane support.
> @@ -28,6 +29,7 @@ config BCM47XX_BCMA
>  	select BCMA_DRIVER_PCI_HOSTMODE if PCI
>  	select BCMA_DRIVER_GPIO
>  	select GPIOLIB
> +	select LEDS_GPIO_REGISTER
>  	default y
>  	help
>  	 Add support for new Broadcom BCM47xx boards with Broadcom specific Advanced Microcontroller Bus.
> diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
> index 571c15e..8d4a66c 100644
> --- a/arch/mips/bcm47xx/Makefile
> +++ b/arch/mips/bcm47xx/Makefile
> @@ -4,6 +4,6 @@
>  #
>  
>  obj-y				+= irq.o nvram.o prom.o serial.o setup.o time.o sprom.o
> -obj-y				+= board.o
> +obj-y				+= board.o leds.o
>  obj-y				+= gpio.o
>  obj-y				+= cfe_env.o
> diff --git a/arch/mips/bcm47xx/bcm47xx_private.h b/arch/mips/bcm47xx/bcm47xx_private.h
> new file mode 100644
> index 0000000..1a1e600
> --- /dev/null
> +++ b/arch/mips/bcm47xx/bcm47xx_private.h
> @@ -0,0 +1,9 @@
> +#ifndef LINUX_BCM47XX_PRIVATE_H_
> +#define LINUX_BCM47XX_PRIVATE_H_
> +
> +#include <linux/kernel.h>
> +
> +/* leds.c */
> +void __init bcm47xx_leds_register(void);
> +
> +#endif
> diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
> new file mode 100644
> index 0000000..6a49d4c
> --- /dev/null
> +++ b/arch/mips/bcm47xx/leds.c
> @@ -0,0 +1,73 @@
> +#include "bcm47xx_private.h"
> +
> +#include <linux/leds.h>
> +#include <bcm47xx_board.h>
> +
> +static const struct gpio_led
> +bcm47xx_leds_netgear_wndr4500_v1_leds[] __initconst = {
> +	{
> +		.name		= "bcm47xx:green:wps",
> +		.gpio		= 1,
> +		.active_low	= 1,
> +		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
> +	},
> +	{
> +		.name		= "bcm47xx:green:power",
> +		.gpio		= 2,
> +		.active_low	= 1,
> +		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
> +	},
> +	{
> +		.name		= "bcm47xx:orange:power",
> +		.gpio		= 3,
> +		.active_low	= 1,
> +		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
> +	},
> +	{
> +		.name		= "bcm47xx:green:usb1",
> +		.gpio		= 8,
> +		.active_low	= 1,
> +		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
> +	},
> +	{
> +		.name		= "bcm47xx:green:2ghz",
> +		.gpio		= 9,
> +		.active_low	= 1,
> +		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
> +	},
> +	{
> +		.name		= "bcm47xx:blue:5ghz",
> +		.gpio		= 11,
> +		.active_low	= 1,
> +		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
> +	},
> +	{
> +		.name		= "bcm47xx:green:usb2",
> +		.gpio		= 14,
> +		.active_low	= 1,
> +		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
> +	},
> +};
> +
> +static struct gpio_led_platform_data bcm47xx_leds_pdata;
> +
> +#define bcm47xx_set_pdata(dev_leds) do {				\
> +	bcm47xx_leds_pdata.leds = dev_leds;				\
> +	bcm47xx_leds_pdata.num_leds = ARRAY_SIZE(dev_leds);		\
> +} while (0)
> +
> +void __init bcm47xx_leds_register(void)
> +{
> +	enum bcm47xx_board board = bcm47xx_board_get();
> +
> +	switch (board) {
> +	case BCM47XX_BOARD_NETGEAR_WNDR4500V1:
> +		bcm47xx_set_pdata(bcm47xx_leds_netgear_wndr4500_v1_leds);
> +		break;
> +	default:
> +		pr_debug("No LEDs configuration found for this device\n");
> +		return;
> +	}
> +
> +	gpio_led_register_device(-1, &bcm47xx_leds_pdata);
> +}
> diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
> index 4b1e229..5291bda 100644
> --- a/arch/mips/bcm47xx/setup.c
> +++ b/arch/mips/bcm47xx/setup.c
> @@ -26,6 +26,8 @@
>   *  675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  
> +#include "bcm47xx_private.h"
> +
>  #include <linux/export.h>
>  #include <linux/types.h>
>  #include <linux/ssb/ssb.h>
> @@ -272,6 +274,9 @@ static int __init bcm47xx_register_bus_complete(void)
>  		break;
>  #endif
>  	}
> +
> +	bcm47xx_leds_register();
> +
>  	return 0;
>  }
>  device_initcall(bcm47xx_register_bus_complete);
> 
