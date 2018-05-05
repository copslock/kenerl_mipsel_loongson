Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 May 2018 15:27:12 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:33322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990432AbeEEN1EVffKw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 May 2018 15:27:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Tj/+5VFlHp1jcAyjamNFFwAeQ8FVAiY5/nhY+VN8Zwg=; b=NgY7u2hAkyFvMCKAQlkEXv4p2
        7C5xBchqsdxZlb/AUv3Lrtzf16Qdi44G+hgt11J9IYZTsn1n4fga9zxYjXEtWC459R0LODgCEU8JU
        +yLbU/PbUSFemvpoDHWJ6m+0voO1cOXdxhdTFJe2/nO4uD7fmhHSYRtgYFjJg+tDd+HHnPfmEllvX
        kQye53qudX5AN53pWH4xKOTRwgWSZpKk8gGW5MlGjJxZdTh3nvn0M/FFMCdwQ76RYYrAIaV5JjEJu
        f9Grv3GYEPR6ghqaYUNnGKqYdixHQvzV4jShZYujSL5akIEMk5GKgBHDyrTFGEXXuvL5N0v3z2KUa
        6/eriASLQ==;
Received: from [177.159.250.117] (helo=vento.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fExD2-0008UR-0M; Sat, 05 May 2018 13:26:44 +0000
Date:   Sat, 5 May 2018 10:26:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>,
        Russell King <linux@armlinux.org.uk>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mips@linux-mips.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 1/7] i2c: i2c-gpio: move header to platform_data
Message-ID: <20180505102637.76ab7c41@vento.lan>
In-Reply-To: <20180419200015.15095-2-wsa@the-dreams.de>
References: <20180419200015.15095-1-wsa@the-dreams.de>
        <20180419200015.15095-2-wsa@the-dreams.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mchehab+samsung@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mchehab+samsung@kernel.org
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

Em Thu, 19 Apr 2018 22:00:07 +0200
Wolfram Sang <wsa@the-dreams.de> escreveu:

> This header only contains platform_data. Move it to the proper directory.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  MAINTAINERS                                      | 2 +-
>  arch/arm/mach-ks8695/board-acs5k.c               | 2 +-
>  arch/arm/mach-omap1/board-htcherald.c            | 2 +-
>  arch/arm/mach-pxa/palmz72.c                      | 2 +-
>  arch/arm/mach-pxa/viper.c                        | 2 +-
>  arch/arm/mach-sa1100/simpad.c                    | 2 +-
>  arch/mips/alchemy/board-gpr.c                    | 2 +-
>  drivers/i2c/busses/i2c-gpio.c                    | 2 +-

>  drivers/media/platform/marvell-ccic/mmp-driver.c | 2 +-
Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

>  drivers/mfd/sm501.c                              | 2 +-
>  include/linux/{ => platform_data}/i2c-gpio.h     | 0
>  11 files changed, 10 insertions(+), 10 deletions(-)
>  rename include/linux/{ => platform_data}/i2c-gpio.h (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a1410d5a621..7aad64b62102 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5872,7 +5872,7 @@ GENERIC GPIO I2C DRIVER
>  M:	Haavard Skinnemoen <hskinnemoen@gmail.com>
>  S:	Supported
>  F:	drivers/i2c/busses/i2c-gpio.c
> -F:	include/linux/i2c-gpio.h
> +F:	include/linux/platform_data/i2c-gpio.h
>  
>  GENERIC GPIO I2C MULTIPLEXER DRIVER
>  M:	Peter Korsgaard <peter.korsgaard@barco.com>
> diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/board-acs5k.c
> index 937eb1d47e7b..ef835d82cdb9 100644
> --- a/arch/arm/mach-ks8695/board-acs5k.c
> +++ b/arch/arm/mach-ks8695/board-acs5k.c
> @@ -19,7 +19,7 @@
>  #include <linux/gpio/machine.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-algo-bit.h>
> -#include <linux/i2c-gpio.h>
> +#include <linux/platform_data/i2c-gpio.h>
>  #include <linux/platform_data/pca953x.h>
>  
>  #include <linux/mtd/mtd.h>
> diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
> index 67d46690a56e..da8f3fc3180f 100644
> --- a/arch/arm/mach-omap1/board-htcherald.c
> +++ b/arch/arm/mach-omap1/board-htcherald.c
> @@ -31,7 +31,7 @@
>  #include <linux/gpio.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c-gpio.h>
> +#include <linux/platform_data/i2c-gpio.h>
>  #include <linux/htcpld.h>
>  #include <linux/leds.h>
>  #include <linux/spi/spi.h>
> diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
> index 5877e547cecd..c053c8ce1586 100644
> --- a/arch/arm/mach-pxa/palmz72.c
> +++ b/arch/arm/mach-pxa/palmz72.c
> @@ -30,7 +30,7 @@
>  #include <linux/wm97xx.h>
>  #include <linux/power_supply.h>
>  #include <linux/usb/gpio_vbus.h>
> -#include <linux/i2c-gpio.h>
> +#include <linux/platform_data/i2c-gpio.h>
>  #include <linux/gpio/machine.h>
>  
>  #include <asm/mach-types.h>
> diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
> index 90d0f277de55..39e05b7008d8 100644
> --- a/arch/arm/mach-pxa/viper.c
> +++ b/arch/arm/mach-pxa/viper.c
> @@ -35,7 +35,7 @@
>  #include <linux/sched.h>
>  #include <linux/gpio.h>
>  #include <linux/jiffies.h>
> -#include <linux/i2c-gpio.h>
> +#include <linux/platform_data/i2c-gpio.h>
>  #include <linux/gpio/machine.h>
>  #include <linux/platform_data/i2c-pxa.h>
>  #include <linux/serial_8250.h>
> diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
> index ace010479eb6..49a61e6f3c5f 100644
> --- a/arch/arm/mach-sa1100/simpad.c
> +++ b/arch/arm/mach-sa1100/simpad.c
> @@ -37,7 +37,7 @@
>  #include <linux/input.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/leds.h>
> -#include <linux/i2c-gpio.h>
> +#include <linux/platform_data/i2c-gpio.h>
>  
>  #include "generic.h"
>  
> diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
> index 4e79dbd54a33..fa75d75b5ba9 100644
> --- a/arch/mips/alchemy/board-gpr.c
> +++ b/arch/mips/alchemy/board-gpr.c
> @@ -29,7 +29,7 @@
>  #include <linux/leds.h>
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c-gpio.h>
> +#include <linux/platform_data/i2c-gpio.h>
>  #include <linux/gpio/machine.h>
>  #include <asm/bootinfo.h>
>  #include <asm/idle.h>
> diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
> index 58abb3eced58..005e6e0330c2 100644
> --- a/drivers/i2c/busses/i2c-gpio.c
> +++ b/drivers/i2c/busses/i2c-gpio.c
> @@ -11,7 +11,7 @@
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-algo-bit.h>
> -#include <linux/i2c-gpio.h>
> +#include <linux/platform_data/i2c-gpio.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> diff --git a/drivers/media/platform/marvell-ccic/mmp-driver.c b/drivers/media/platform/marvell-ccic/mmp-driver.c
> index 816f4b6a7b8e..d9f0dd0d3525 100644
> --- a/drivers/media/platform/marvell-ccic/mmp-driver.c
> +++ b/drivers/media/platform/marvell-ccic/mmp-driver.c
> @@ -12,7 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c-gpio.h>
> +#include <linux/platform_data/i2c-gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
> diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
> index ad774161a22d..66af659b01b2 100644
> --- a/drivers/mfd/sm501.c
> +++ b/drivers/mfd/sm501.c
> @@ -19,7 +19,7 @@
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pci.h>
> -#include <linux/i2c-gpio.h>
> +#include <linux/platform_data/i2c-gpio.h>
>  #include <linux/gpio/machine.h>
>  #include <linux/slab.h>
>  
> diff --git a/include/linux/i2c-gpio.h b/include/linux/platform_data/i2c-gpio.h
> similarity index 100%
> rename from include/linux/i2c-gpio.h
> rename to include/linux/platform_data/i2c-gpio.h



Thanks,
Mauro
