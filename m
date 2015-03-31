Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 17:00:52 +0200 (CEST)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34541 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008743AbbCaPAuCaeRh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 17:00:50 +0200
Received: by lboc7 with SMTP id c7so14534451lbo.1;
        Tue, 31 Mar 2015 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YwUAkQngL5Kmqcfqj5wUeOC233QtwFJo6j60WRX6FrM=;
        b=SxNc1ISjZDVtsez6GlrCnzbtyACjwhShYTzkotJaQmM7vZQntFN9Euy74nRtYg5Op8
         zLBI2TBxCA2b+0GhutsaibIkF5AjAmVvTtBPFwj9eWbmhhD5tG5IhH0gTHOmmXt6fabB
         ygsDDKsCJpSQ9JnIgKKXDvtA8ztvg0inCOdaGbFqK9x6GRs00HJfq/wuu/DogyUJIpNM
         7ljL/Pq5a5AIJAJ4T3LtiDTowkfIX4gfWtv6f7U6UXRXadhpYj9OvWGlcCf/dhf5T3bh
         /WlLM1iDrsldJ27psaUDswF9Iz5yGY5f44P8S8sXZv4eTcQgmyAoBjvajtCwUyQ0remx
         cCKw==
MIME-Version: 1.0
X-Received: by 10.112.133.2 with SMTP id oy2mr4786799lbb.124.1427814045671;
 Tue, 31 Mar 2015 08:00:45 -0700 (PDT)
Received: by 10.25.23.157 with HTTP; Tue, 31 Mar 2015 08:00:45 -0700 (PDT)
In-Reply-To: <1427811090-17276-1-git-send-email-bert@biot.com>
References: <1427811090-17276-1-git-send-email-bert@biot.com>
Date:   Tue, 31 Mar 2015 18:00:45 +0300
Message-ID: <CAHp75Vdu==oJC=daF-eri1otBN3GveQxVA66mHfNyAgit8XkXA@mail.gmail.com>
Subject: Re: [PATCH v3] spi: Add SPI driver for Mikrotik RB4xx series boards
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46653
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

On Tue, Mar 31, 2015 at 5:11 PM, Bert Vermeulen <bert@biot.com> wrote:
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
> Signed-off-by: Bert Vermeulen <bert@biot.com>

Couple of minor comments below.

After addressing them
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> ---
>  drivers/spi/Kconfig     |   6 ++
>  drivers/spi/Makefile    |   1 +
>  drivers/spi/spi-rb4xx.c | 244 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 251 insertions(+)
>  create mode 100644 drivers/spi/spi-rb4xx.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index ab8dfbe..aa76ce5 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -429,6 +429,12 @@ config SPI_ROCKCHIP
>           The main usecase of this controller is to use spi flash as boot
>           device.
>
> +config SPI_RB4XX
> +       tristate "Mikrotik RB4XX SPI master"
> +       depends on SPI_MASTER && ATH79_MACH_RB4XX
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
> index 0000000..aa0a1bf
> --- /dev/null
> +++ b/drivers/spi/spi-rb4xx.c
> @@ -0,0 +1,244 @@
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
> +static void set_cs(struct spi_device *spi, bool enable)
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
> +static int unprep(struct spi_master *master)
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
> +       if (spi->mode & ~SPI_CS_HIGH) {
> +               dev_err(&spi->dev, "mode %x not supported\n", spi->mode);
> +               return -EINVAL;
> +       }
> +
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
> +       int err = 0;

Redundant assignment.

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
> +       master->unprepare_transfer_hardware = unprep;

Shouldn't it be named like others, i.e.
rb4xx_unprepare_transfer_hardware() ?

> +       master->set_cs = set_cs;

Ditto.

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
> +       .probe          = rb4xx_spi_probe,
> +       .remove         = rb4xx_spi_remove,
> +       .driver         = {
> +               .name   = "rb4xx-spi",
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
