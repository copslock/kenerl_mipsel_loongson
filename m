Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Apr 2015 11:56:29 +0200 (CEST)
Received: from mail-la0-f46.google.com ([209.85.215.46]:36652 "EHLO
        mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010033AbbDFJ41nGEHf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Apr 2015 11:56:27 +0200
Received: by lagv1 with SMTP id v1so16575428lag.3;
        Mon, 06 Apr 2015 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eQtG/fCW5s6jFE7sZG07cvJyU/gHt/fLL2pScYIEzwI=;
        b=yOCZf6lbxPgPQKHTP5La+u7WQkbFOoF4LOM1uUn+iM/Ij3n0q8N8r4qdsG3Br5IyDC
         Ydav17I+KbZ/RrKB5bTVVSu1l+qerjqXlbDuGkWs4hG+E7f0OsQ23l21fySC+5PoXNDb
         J4uvPYsyQa61pb+7QIlC/Ujau5t/haY1BA8HIdP7d1LquiUfXTJOIw6Hx6CidMMT+6CY
         4Tm7PER9hu8V6oaLu66ITjr90DV8sqM7sSx9g6BgGwluBAok/ThpgCM1kN7IvcGd5pMc
         ySRba8MSr5F53NhUnqXcM8MlUsJvaJi1RWKqWaZXmO7FFhyqfXMyDxNgHlkIhrUDt/bo
         YVlw==
MIME-Version: 1.0
X-Received: by 10.152.27.97 with SMTP id s1mr12321517lag.53.1428314182544;
 Mon, 06 Apr 2015 02:56:22 -0700 (PDT)
Received: by 10.25.23.157 with HTTP; Mon, 6 Apr 2015 02:56:22 -0700 (PDT)
In-Reply-To: <1428285263-15135-1-git-send-email-bert@biot.com>
References: <1428285263-15135-1-git-send-email-bert@biot.com>
Date:   Mon, 6 Apr 2015 12:56:22 +0300
Message-ID: <CAHp75VeL62iMCP_+72CA7Kj-m4-g23u7Wt9oZwYm69kyr=RPyw@mail.gmail.com>
Subject: Re: [PATCH v6] spi: Add SPI driver for Mikrotik RB4xx series boards
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org, jogo@openwrt.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Mon, Apr 6, 2015 at 4:54 AM, Bert Vermeulen <bert@biot.com> wrote:
> This driver mediates access between the connected CPLD and other devices
> on the bus.
>
> The m25p80-compatible boot flash and (some models) MMC use regular SPI,
> bitbanged as required by the SoC. However the SPI-connected CPLD has
> a "fast write" mode, in which two bits are transferred by SPI clock
> cycle. The second bit is transmitted with the SoC's CS2 pin.
>
> Protocol drivers using this fast write facility signal this by setting
> the cs_change flag on transfers.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

(If someone gives you a tag, please, keep it in the sequential
version(s) if there are only cosmetic changes)

> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
> Changes in v6:
> - removed unnecessary SPI mode check
> - whitespace fixes
>
>
>  drivers/spi/Kconfig     |   6 ++
>  drivers/spi/Makefile    |   1 +
>  drivers/spi/spi-rb4xx.c | 239 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 246 insertions(+)
>  create mode 100644 drivers/spi/spi-rb4xx.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index ab8dfbe..8b1beaf6 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -429,6 +429,12 @@ config SPI_ROCKCHIP
>           The main usecase of this controller is to use spi flash as boot
>           device.
>
> +config SPI_RB4XX
> +       tristate "Mikrotik RB4XX SPI master"
> +       depends on SPI_MASTER && ATH79
> +       help
> +         SPI controller driver for the Mikrotik RB4xx series boards.
> +
>  config SPI_RSPI
>         tristate "Renesas RSPI/QSPI controller"
>         depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index d8cbf65..0218f39 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_SPI_PXA2XX)              += spi-pxa2xx-platform.o
>  obj-$(CONFIG_SPI_PXA2XX_PCI)           += spi-pxa2xx-pci.o
>  obj-$(CONFIG_SPI_QUP)                  += spi-qup.o
>  obj-$(CONFIG_SPI_ROCKCHIP)             += spi-rockchip.o
> +obj-$(CONFIG_SPI_RB4XX)                        += spi-rb4xx.o
>  obj-$(CONFIG_SPI_RSPI)                 += spi-rspi.o
>  obj-$(CONFIG_SPI_S3C24XX)              += spi-s3c24xx-hw.o
>  spi-s3c24xx-hw-y                       := spi-s3c24xx.o
> diff --git a/drivers/spi/spi-rb4xx.c b/drivers/spi/spi-rb4xx.c
> new file mode 100644
> index 0000000..0cead2e
> --- /dev/null
> +++ b/drivers/spi/spi-rb4xx.c
> @@ -0,0 +1,239 @@
> +/*
> + * SPI controller driver for the Mikrotik RB4xx boards
> + *
> + * Copyright (C) 2010 Gabor Juhos <juhosg@openwrt.org>
> + * Copyright (C) 2015 Bert Vermeulen <bert@biot.com>
> + *
> + * This file was based on the patches for Linux 2.6.27.39 published by
> + * MikroTik for their RouterBoard 4xx series devices.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/spi/spi.h>
> +
> +#include <asm/mach-ath79/ar71xx_regs.h>
> +
> +#define SPI_CLOCK_FASTEST      0x40
> +#define SPI_HZ                 33333334
> +#define CPLD_CMD_WRITE_NAND    0x08 /* bulk write mode */
> +
> +struct rb4xx_spi {
> +       void __iomem            *base;
> +       struct spi_master       *master;
> +};
> +
> +static inline u32 rb4xx_read(struct rb4xx_spi *rbspi, u32 reg)
> +{
> +       return __raw_readl(rbspi->base + reg);
> +}
> +
> +static inline void rb4xx_write(struct rb4xx_spi *rbspi, u32 reg, u32 value)
> +{
> +       __raw_writel(value, rbspi->base + reg);
> +}
> +
> +static inline void do_spi_clk(struct rb4xx_spi *rbspi, u32 spi_ioc, int value)
> +{
> +       u32 regval;
> +
> +       regval = spi_ioc;
> +       if (value & BIT(0))
> +               regval |= AR71XX_SPI_IOC_DO;
> +
> +       rb4xx_write(rbspi, AR71XX_SPI_REG_IOC, regval);
> +       rb4xx_write(rbspi, AR71XX_SPI_REG_IOC, regval | AR71XX_SPI_IOC_CLK);
> +}
> +
> +static void do_spi_byte(struct rb4xx_spi *rbspi, u32 spi_ioc, u8 byte)
> +{
> +       int i;
> +
> +       for (i = 7; i >= 0; i--)
> +               do_spi_clk(rbspi, spi_ioc, byte >> i);
> +}
> +
> +static inline void do_spi_clk_fast(struct rb4xx_spi *rbspi, u32 spi_ioc,
> +                                  u8 value)
> +{
> +       u32 regval;
> +
> +       regval = spi_ioc;
> +       if (value & BIT(1))
> +               regval |= AR71XX_SPI_IOC_DO;
> +       if (value & BIT(0))
> +               regval |= AR71XX_SPI_IOC_CS2;
> +
> +       rb4xx_write(rbspi, AR71XX_SPI_REG_IOC, regval);
> +       rb4xx_write(rbspi, AR71XX_SPI_REG_IOC, regval | AR71XX_SPI_IOC_CLK);
> +}
> +
> +/* Two bits at a time, msb first */
> +static void do_spi_byte_fast(struct rb4xx_spi *rbspi, u32 spi_ioc, u8 byte)
> +{
> +       do_spi_clk_fast(rbspi, spi_ioc, byte >> 6);
> +       do_spi_clk_fast(rbspi, spi_ioc, byte >> 4);
> +       do_spi_clk_fast(rbspi, spi_ioc, byte >> 2);
> +       do_spi_clk_fast(rbspi, spi_ioc, byte >> 0);
> +}
> +
> +static void rb4xx_set_cs(struct spi_device *spi, bool enable)
> +{
> +       struct rb4xx_spi *rbspi = spi_master_get_devdata(spi->master);
> +
> +       /*
> +        * Setting CS is done along with bitbanging the actual values,
> +        * since it's all on the same hardware register. However the
> +        * CPLD needs CS deselected after every command.
> +        */
> +       if (!enable)
> +               rb4xx_write(rbspi, AR71XX_SPI_REG_IOC,
> +                           AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1);
> +}
> +
> +/* Deselect CS0 and CS1. */
> +static int rb4xx_unprepare_transfer_hardware(struct spi_master *master)
> +{
> +       struct rb4xx_spi *rbspi = spi_master_get_devdata(master);
> +
> +       rb4xx_write(rbspi, AR71XX_SPI_REG_IOC,
> +                   AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1);
> +
> +       return 0;
> +}
> +
> +static int rb4xx_transfer_one(struct spi_master *master,
> +                             struct spi_device *spi, struct spi_transfer *t)
> +{
> +       struct rb4xx_spi *rbspi = spi_master_get_devdata(master);
> +       int i;
> +       u32 spi_ioc;
> +       u8 *rx_buf;
> +       const u8 *tx_buf;
> +       unsigned char out;
> +
> +       /*
> +        * Prime the SPI register with the SPI device selected. The m25p80 boot
> +        * flash and CPLD share the CS0 pin. This works because the CPLD's
> +        * command set was designed to almost not clash with that of the
> +        * boot flash.
> +        */
> +       if (spi->chip_select == 2)
> +               spi_ioc = AR71XX_SPI_IOC_CS0;
> +       else
> +               spi_ioc = AR71XX_SPI_IOC_CS1;
> +
> +       tx_buf = t->tx_buf;
> +       rx_buf = t->rx_buf;
> +       for (i = 0; i < t->len; ++i) {
> +               out = tx_buf ? tx_buf[i] : 0x00;
> +               if (spi->chip_select == 1 && t->cs_change) {
> +                       /* CPLD in bulk write mode gets two bits per clock */
> +                       do_spi_byte_fast(rbspi, spi_ioc, out);
> +                       /* Don't want the real CS toggled */
> +                       t->cs_change = 0;
> +               } else {
> +                       do_spi_byte(rbspi, spi_ioc, out);
> +               }
> +               if (!rx_buf)
> +                       continue;
> +               rx_buf[i] = rb4xx_read(rbspi, AR71XX_SPI_REG_RDS);
> +       }
> +       spi_finalize_current_transfer(master);
> +
> +       return 0;
> +}
> +
> +static int rb4xx_spi_setup(struct spi_device *spi)
> +{
> +       if (spi->bits_per_word != 8 && spi->bits_per_word != 0) {
> +               dev_err(&spi->dev, "bits_per_word %u not supported\n",
> +                       spi->bits_per_word);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int rb4xx_spi_probe(struct platform_device *pdev)
> +{
> +       struct spi_master *master;
> +       struct clk *ahb_clk;
> +       struct rb4xx_spi *rbspi;
> +       struct resource *r;
> +       int err;
> +       void __iomem *spi_base;
> +
> +       ahb_clk = devm_clk_get(&pdev->dev, "ahb");
> +       if (IS_ERR(ahb_clk))
> +               return PTR_ERR(ahb_clk);
> +
> +       err = clk_prepare_enable(ahb_clk);
> +       if (err)
> +               return err;
> +
> +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       spi_base = devm_ioremap_resource(&pdev->dev, r);
> +       if (!spi_base)
> +               return PTR_ERR(spi_base);
> +
> +       master = spi_alloc_master(&pdev->dev, sizeof(*rbspi));
> +       if (!master)
> +               return -ENOMEM;
> +
> +       master->bus_num = 0;
> +       master->num_chipselect = 3;
> +       master->setup = rb4xx_spi_setup;
> +       master->transfer_one = rb4xx_transfer_one;
> +       master->unprepare_transfer_hardware = rb4xx_unprepare_transfer_hardware;
> +       master->set_cs = rb4xx_set_cs;
> +
> +       rbspi = spi_master_get_devdata(master);
> +       rbspi->master = master;
> +       rbspi->base = spi_base;
> +
> +       platform_set_drvdata(pdev, rbspi);
> +
> +       err = spi_register_master(master);
> +       if (err) {
> +               dev_err(&pdev->dev, "failed to register SPI master\n");
> +               spi_master_put(master);
> +               return err;
> +       }
> +
> +       /* Enable SPI */
> +       rb4xx_write(rbspi, AR71XX_SPI_REG_FS, AR71XX_SPI_FS_GPIO);
> +
> +       return 0;
> +}
> +
> +static int rb4xx_spi_remove(struct platform_device *pdev)
> +{
> +       struct rb4xx_spi *rbspi = platform_get_drvdata(pdev);
> +
> +       spi_master_put(rbspi->master);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver rb4xx_spi_drv = {
> +       .probe = rb4xx_spi_probe,
> +       .remove = rb4xx_spi_remove,
> +       .driver = {
> +               .name = "rb4xx-spi",
> +       },
> +};
> +
> +module_platform_driver(rb4xx_spi_drv);
> +
> +MODULE_DESCRIPTION("Mikrotik RB4xx SPI controller driver");
> +MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org>");
> +MODULE_AUTHOR("Bert Vermeulen <bert@biot.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 1.9.1
>



-- 
With Best Regards,
Andy Shevchenko
