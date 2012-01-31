Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 18:52:56 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:39221 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904039Ab2AaRwu convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 18:52:50 +0100
Received: by vbbfs19 with SMTP id fs19so286667vbb.36
        for <multiple recipients>; Tue, 31 Jan 2012 09:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KrO1D2DB2ii0EEIjSrnVx6ZTs7uCA3VPpjcxN/o8SOM=;
        b=GdUKEAwtlAoJZkZnSab6xdtMneE9zl8saZhQ7WdLr2L06zskQFB8YJv02gKSgb9avd
         qnMQhud2XvV7+Ll9c1UqullVB9Tmw3II6HM4pVpz6IOF+2dkKVGmKT/TmgY3OtZhYLjF
         8FFGEukYQ1XpEte7AJBCC6PtSX/2d8V7MBwE0=
MIME-Version: 1.0
Received: by 10.52.27.111 with SMTP id s15mr11110731vdg.120.1328032363930;
 Tue, 31 Jan 2012 09:52:43 -0800 (PST)
Received: by 10.220.187.76 with HTTP; Tue, 31 Jan 2012 09:52:43 -0800 (PST)
In-Reply-To: <1328019048-5892-10-git-send-email-florian@openwrt.org>
References: <1328019048-5892-1-git-send-email-florian@openwrt.org>
        <1328019048-5892-10-git-send-email-florian@openwrt.org>
Date:   Tue, 31 Jan 2012 23:22:43 +0530
Message-ID: <CAM=Q2csgc07XrOfTaSFHFQXnZoe2_HHips4x9Ht0j_1EP_1BwA@mail.gmail.com>
Subject: Re: [PATCH 9/9 v3] spi: add Broadcom BCM63xx SPI controller driver
From:   Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>,
        spi-devel-general@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 32375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: omaplinuxkernel@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Florian,

On Tue, Jan 31, 2012 at 7:40 PM, Florian Fainelli <florian@openwrt.org> wrote:
> This patch adds support for the SPI controller found on the Broadcom BCM63xx
> SoCs.
>
> Signed-off-by: Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> Changes since v2:
> - reworked bcm63xx_spi_setup_transfer to choose closest spi transfer
>  frequency
> - removed invalid 25Mhz frequency
> - fixed some minor checkpatch issues
>
> Changes since v1:
> - switched to the devm_* API which frees resources automatically
> - switched to dev_pm_ops
> - use module_platform_driver
> - remove MODULE_VERSION()
> - fixed return value when clock is not present using PTR_ERR()
> - fixed probe() error path to disable clock in case of failure
>
>  drivers/spi/Kconfig       |    6 +
>  drivers/spi/Makefile      |    1 +
>  drivers/spi/spi-bcm63xx.c |  486 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 493 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/spi-bcm63xx.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 3f9a47e..16818ac 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -94,6 +94,12 @@ config SPI_AU1550
>          If you say yes to this option, support will be included for the
>          PSC SPI controller found on Au1550, Au1200 and Au1300 series.
>
> +config SPI_BCM63XX
> +       tristate "Broadcom BCM63xx SPI controller"
> +       depends on BCM63XX
> +       help
> +          Enable support for the SPI controller on the Broadcom BCM63xx SoCs.
> +
>  config SPI_BITBANG
>        tristate "Utilities for Bitbanging SPI masters"
>        help
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 61c3261..be38f73 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_SPI_ALTERA)              += spi-altera.o
>  obj-$(CONFIG_SPI_ATMEL)                        += spi-atmel.o
>  obj-$(CONFIG_SPI_ATH79)                        += spi-ath79.o
>  obj-$(CONFIG_SPI_AU1550)               += spi-au1550.o
> +obj-$(CONFIG_SPI_BCM63XX)              += spi-bcm63xx.o
>  obj-$(CONFIG_SPI_BFIN)                 += spi-bfin5xx.o
>  obj-$(CONFIG_SPI_BFIN_SPORT)           += spi-bfin-sport.o
>  obj-$(CONFIG_SPI_BITBANG)              += spi-bitbang.o
> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
> new file mode 100644
> index 0000000..eba8505
> --- /dev/null
> +++ b/drivers/spi/spi-bcm63xx.c
> @@ -0,0 +1,486 @@
> +/*
> + * Broadcom BCM63xx SPI controller support
> + *
> + * Copyright (C) 2009-2011 Florian Fainelli <florian@openwrt.org>
> + * Copyright (C) 2010 Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the
> + * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/spi/spi.h>
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +
> +#include <bcm63xx_dev_spi.h>
> +
> +#define PFX            KBUILD_MODNAME
> +#define DRV_VER                "0.1.2"
> +
> +struct bcm63xx_spi {
> +       spinlock_t              lock;
> +       int                     stopping;
> +       struct completion       done;
> +
> +       void __iomem            *regs;
> +       int                     irq;
> +
> +       /* Platform data */
> +       u32                     speed_hz;
> +       unsigned                fifo_size;
> +
> +       /* Data buffers */
> +       const unsigned char     *tx_ptr;
> +       unsigned char           *rx_ptr;
> +
> +       /* data iomem */
> +       u8 __iomem              *tx_io;
> +       const u8 __iomem        *rx_io;
> +
> +       int                     remaining_bytes;
> +
> +       struct clk              *clk;
> +       struct platform_device  *pdev;
> +};
> +
> +static inline u8 bcm_spi_readb(struct bcm63xx_spi *bs,
> +                               unsigned int offset)
> +{
> +       return bcm_readw(bs->regs + bcm63xx_spireg(offset));

are you sure it should be bcm_readw

> +}
> +
> +static inline u16 bcm_spi_readw(struct bcm63xx_spi *bs,
> +                               unsigned int offset)
> +{
> +       return bcm_readw(bs->regs + bcm63xx_spireg(offset));
> +}
> +
