Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 22:40:23 +0100 (CET)
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34104 "EHLO
        mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008811AbbCYVkVs-hPL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Mar 2015 22:40:21 +0100
Received: by ykfc206 with SMTP id c206so19914528ykf.1;
        Wed, 25 Mar 2015 14:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bUn+1wnUuoNBx+eyUQ8gIMs/t/E2IimJJYDtJuwrxZI=;
        b=nv+Pcjk0Q2/UQuTRadSsZCkNaK2fz2NAEoCBkLf4A6uqlp6UYPnVXzuiIAzuem5Vt3
         elPUUEuSYFNzRjq+72Rlbz4iH2u8gFQlBk7EHvdY+VWyBXQe/H4J9QFfCsRqhbuhQGPd
         Qi/PwYJ5UpLpPqRpY4f8F536lBoJHlsw50CV9dOIr5U1VkSF8tlRhuyvz/NxzCkD4+DN
         f1OwL40AmvHcKV2D7+KqHLJBLqEaZiDaB8uRQpLZpIJjfxFsUUbK3+a6tkjMXKDMkHL1
         e6gWXHgl3NUaqn2ICW3rTDAuHHFK+q5jB9wbnbGw2eDP/piWZKrP8FZmRfAY5vLtH1Np
         cLXg==
MIME-Version: 1.0
X-Received: by 10.170.42.210 with SMTP id 201mr14041754ykk.124.1427319616719;
 Wed, 25 Mar 2015 14:40:16 -0700 (PDT)
Received: by 10.170.120.16 with HTTP; Wed, 25 Mar 2015 14:40:16 -0700 (PDT)
In-Reply-To: <1426853793-24454-2-git-send-email-bert@biot.com>
References: <1426853793-24454-1-git-send-email-bert@biot.com>
        <1426853793-24454-2-git-send-email-bert@biot.com>
Date:   Wed, 25 Mar 2015 23:40:16 +0200
Message-ID: <CAHp75VdE9-4TQP1Fdbb7g0Bzg2GDEvgsYxex7JVxUvxcfT6qdQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: Add SPI driver for Mikrotik RB4xx series boards
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46528
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

On Fri, Mar 20, 2015 at 2:16 PM, Bert Vermeulen <bert@biot.com> wrote:

Besides what Mark told you (I mostly about absence of the commit
message) there are few more comments below.

> Signed-off-by: Bert Vermeulen <bert@biot.com>

> +++ b/drivers/spi/spi-rb4xx.c
> @@ -0,0 +1,419 @@
> +/*
> + * SPI controller driver for the Mikrotik RB4xx boards
> + *
> + * Copyright (C) 2010 Gabor Juhos <juhosg@openwrt.org>

2010, 2015 ?

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
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/spinlock.h>
> +#include <linux/workqueue.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +
> +#include <asm/mach-ath79/ar71xx_regs.h>
> +#include <asm/mach-ath79/ath79.h>
> +
> +#define DRV_NAME       "rb4xx-spi"
> +#define DRV_DESC       "Mikrotik RB4xx SPI controller driver"
> +#define DRV_VERSION    "0.1.0"
> +
> +#define SPI_CTRL_FASTEST       0x40
> +#define SPI_HZ                 33333334
> +
> +#undef RB4XX_SPI_DEBUG

Why is it here?

> +
> +struct rb4xx_spi {
> +       void __iomem            *base;
> +       struct spi_master       *master;
> +
> +       unsigned                spi_ctrl;
> +
> +       struct clk              *ahb_clk;
> +       unsigned long           ahb_freq;
> +
> +       spinlock_t              lock;
> +       struct list_head        queue;
> +       int                     busy:1;
> +       int                     cs_wait;
> +};
> +
> +static unsigned spi_clk_low = AR71XX_SPI_IOC_CS1;
> +
> +#ifdef RB4XX_SPI_DEBUG
> +static inline void do_spi_delay(void)
> +{
> +       ndelay(20000);
> +}
> +#else
> +static inline void do_spi_delay(void) { }
> +#endif
> +
> +static inline void do_spi_init(struct spi_device *spi)
> +{
> +       unsigned cs = AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1;
> +
> +       if (!(spi->mode & SPI_CS_HIGH))
> +               cs ^= (spi->chip_select == 2) ? AR71XX_SPI_IOC_CS1 :
> +                                               AR71XX_SPI_IOC_CS0;

What is the magic CS == 2?

> +
> +       spi_clk_low = cs;
> +}
> +
> +static inline void do_spi_finish(void __iomem *base)
> +{
> +       do_spi_delay();
> +       __raw_writel(AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1,
> +                    base + AR71XX_SPI_REG_IOC);

I highly recommend you to provide pair of inliners to access hardware.
It would be easy to maintain…

> +}
> +
> +static inline void do_spi_clk(void __iomem *base, int bit)
> +{
> +       unsigned bval = spi_clk_low | ((bit & 1) ? AR71XX_SPI_IOC_DO : 0);
> +
> +       do_spi_delay();
> +       __raw_writel(bval, base + AR71XX_SPI_REG_IOC);

…and you may easily provide rb4xx_writel_delayed() as well.

> +       do_spi_delay();
> +       __raw_writel(bval | AR71XX_SPI_IOC_CLK, base + AR71XX_SPI_REG_IOC);
> +}
> +
> +static void do_spi_byte(void __iomem *base, unsigned char byte)
> +{
> +       do_spi_clk(base, byte >> 7);
> +       do_spi_clk(base, byte >> 6);
> +       do_spi_clk(base, byte >> 5);
> +       do_spi_clk(base, byte >> 4);
> +       do_spi_clk(base, byte >> 3);
> +       do_spi_clk(base, byte >> 2);
> +       do_spi_clk(base, byte >> 1);
> +       do_spi_clk(base, byte);
> +
> +       pr_debug("spi_byte sent 0x%02x got 0x%02x\n",
> +                (unsigned)byte,
> +                (unsigned char)__raw_readl(base + AR71XX_SPI_REG_RDS));
> +}
> +
> +static inline void do_spi_clk_fast(void __iomem *base, unsigned bit1,
> +                                  unsigned bit2)
> +{
> +       unsigned bval = (spi_clk_low |
> +                        ((bit1 & 1) ? AR71XX_SPI_IOC_DO : 0) |
> +                        ((bit2 & 1) ? AR71XX_SPI_IOC_CS2 : 0));

Regarding to the usage, why not to provide one variable with two bits?

> +       do_spi_delay();
> +       __raw_writel(bval, base + AR71XX_SPI_REG_IOC);
> +       do_spi_delay();
> +       __raw_writel(bval | AR71XX_SPI_IOC_CLK, base + AR71XX_SPI_REG_IOC);
> +}
> +
> +static void do_spi_byte_fast(void __iomem *base, unsigned char byte)
> +{
> +       do_spi_clk_fast(base, byte >> 7, byte >> 6);
> +       do_spi_clk_fast(base, byte >> 5, byte >> 4);
> +       do_spi_clk_fast(base, byte >> 3, byte >> 2);
> +       do_spi_clk_fast(base, byte >> 1, byte >> 0);
> +
> +       pr_debug("spi_byte_fast sent 0x%02x got 0x%02x\n",
> +                (unsigned)byte,
> +                (unsigned char) __raw_readl(base + AR71XX_SPI_REG_RDS));
> +}
> +
> +static int rb4xx_spi_txrx(void __iomem *base, struct spi_transfer *t)
> +{
> +       const unsigned char *rxv_ptr = NULL;
> +       const unsigned char *tx_ptr = t->tx_buf;
> +       unsigned char *rx_ptr = t->rx_buf;
> +       unsigned i;
> +
> +       pr_debug("spi_txrx len %u tx %u rx %u\n", t->len,
> +                (t->tx_buf ? 1 : 0),

!!t->tx_buf ?
Or personally I prefer to see %p here.

> +                (t->rx_buf ? 1 : 0));

Ditto.

> +
> +       for (i = 0; i < t->len; ++i) {
> +               unsigned char sdata = tx_ptr ? tx_ptr[i] : 0;
> +
> +               if (t->fast_write)
> +                       do_spi_byte_fast(base, sdata);
> +               else
> +                       do_spi_byte(base, sdata);
> +
> +               if (rx_ptr) {
> +                       rx_ptr[i] = __raw_readl(base + AR71XX_SPI_REG_RDS) & 0xff;
> +               } else if (rxv_ptr) {
> +                       unsigned char c = __raw_readl(base + AR71XX_SPI_REG_RDS);
> +
> +                       if (rxv_ptr[i] != c)
> +                               return i;
> +               }
> +       }
> +
> +       return i;
> +}
> +
> +static int rb4xx_spi_msg(struct rb4xx_spi *rbspi, struct spi_message *m)
> +{
> +       struct spi_transfer *t = NULL;
> +       void __iomem *base = rbspi->base;
> +
> +       m->status = 0;
> +       if (list_empty(&m->transfers))
> +               return -1;
> +
> +       __raw_writel(AR71XX_SPI_FS_GPIO, base + AR71XX_SPI_REG_FS);
> +       __raw_writel(SPI_CTRL_FASTEST, base + AR71XX_SPI_REG_CTRL);
> +       do_spi_init(m->spi);
> +
> +       list_for_each_entry(t, &m->transfers, transfer_list) {
> +               int len;
> +
> +               len = rb4xx_spi_txrx(base, t);
> +               if (len != t->len) {
> +                       m->status = -EMSGSIZE;
> +                       break;
> +               }
> +               m->actual_length += len;
> +
> +               if (t->cs_change) {
> +                       if (list_is_last(&t->transfer_list, &m->transfers)) {
> +                               /* wait for continuation */
> +                               return m->spi->chip_select;
> +                       }
> +                       do_spi_finish(base);
> +                       ndelay(100);
> +               }
> +       }
> +
> +       do_spi_finish(base);
> +       __raw_writel(rbspi->spi_ctrl, base + AR71XX_SPI_REG_CTRL);
> +       __raw_writel(0, base + AR71XX_SPI_REG_FS);
> +       return -1;
> +}
> +
> +static void rb4xx_spi_process_queue_locked(struct rb4xx_spi *rbspi,
> +                                          unsigned long *flags)
> +{
> +       int cs = rbspi->cs_wait;
> +
> +       rbspi->busy = 1;
> +       while (!list_empty(&rbspi->queue)) {
> +               struct spi_message *m;
> +
> +               list_for_each_entry(m, &rbspi->queue, queue)
> +                       if (cs < 0 || cs == m->spi->chip_select)
> +                               break;
> +
> +               if (&m->queue == &rbspi->queue)
> +                       break;
> +
> +               list_del_init(&m->queue);
> +               spin_unlock_irqrestore(&rbspi->lock, *flags);
> +
> +               cs = rb4xx_spi_msg(rbspi, m);
> +               m->complete(m->context);
> +
> +               spin_lock_irqsave(&rbspi->lock, *flags);
> +       }
> +
> +       rbspi->cs_wait = cs;
> +       rbspi->busy = 0;
> +
> +       if (cs >= 0) {
> +               /* TODO: add timer to unlock cs after 1s inactivity */
> +       }
> +}
> +
> +static int rb4xx_spi_transfer(struct spi_device *spi,
> +                             struct spi_message *m)
> +{
> +       struct rb4xx_spi *rbspi = spi_master_get_devdata(spi->master);
> +       unsigned long flags;
> +
> +       m->actual_length = 0;
> +       m->status = -EINPROGRESS;
> +
> +       spin_lock_irqsave(&rbspi->lock, flags);
> +       list_add_tail(&m->queue, &rbspi->queue);
> +       if (rbspi->busy ||
> +           (rbspi->cs_wait >= 0 && rbspi->cs_wait != m->spi->chip_select)) {
> +               /* job will be done later */
> +               spin_unlock_irqrestore(&rbspi->lock, flags);
> +               return 0;
> +       }
> +
> +       /* process job in current context */
> +       rb4xx_spi_process_queue_locked(rbspi, &flags);
> +       spin_unlock_irqrestore(&rbspi->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int rb4xx_spi_setup(struct spi_device *spi)
> +{
> +       struct rb4xx_spi *rbspi = spi_master_get_devdata(spi->master);
> +       unsigned long flags;
> +
> +       if (spi->mode & ~(SPI_CS_HIGH)) {
> +               dev_err(&spi->dev, "mode %x not supported\n",
> +                       (unsigned) spi->mode);

Why explicitly casted?

> +               return -EINVAL;
> +       }
> +
> +       if (spi->bits_per_word != 8 && spi->bits_per_word != 0) {
> +               dev_err(&spi->dev, "bits_per_word %u not supported\n",
> +                       (unsigned) spi->bits_per_word);

Ditto.

> +               return -EINVAL;
> +       }
> +
> +       spin_lock_irqsave(&rbspi->lock, flags);
> +       if (rbspi->cs_wait == spi->chip_select && !rbspi->busy) {
> +               rbspi->cs_wait = -1;
> +               rb4xx_spi_process_queue_locked(rbspi, &flags);
> +       }
> +       spin_unlock_irqrestore(&rbspi->lock, flags);
> +
> +       return 0;
> +}
> +
> +static unsigned get_spi_ctrl(struct rb4xx_spi *rbspi)
> +{
> +       unsigned div;
> +
> +       div = (rbspi->ahb_freq - 1) / (2 * SPI_HZ);
> +
> +       /*
> +        * CPU has a bug at (div == 0) - first bit read is random
> +        */

Would it be one line?

> +       if (div == 0)
> +               ++div;

div++ will work as well.

> +
> +       return SPI_CTRL_FASTEST + div;
> +}
> +
> +static int rb4xx_spi_probe(struct platform_device *pdev)
> +{
> +       struct spi_master *master;
> +       struct rb4xx_spi *rbspi;
> +       struct resource *r;
> +       int err = 0;
> +
> +       master = spi_alloc_master(&pdev->dev, sizeof(*rbspi));

What if you set clock, get resources first and then allocate master?

> +       if (!master) {
> +               err = -ENOMEM;
> +               goto err_out;
> +       }
> +
> +       master->bus_num = 0;
> +       master->num_chipselect = 3;
> +       master->setup = rb4xx_spi_setup;
> +       master->transfer = rb4xx_spi_transfer;
> +
> +       rbspi = spi_master_get_devdata(master);
> +
> +       rbspi->ahb_clk = clk_get(&pdev->dev, "ahb");

What about devm_*, here devm_clk_get()?

> +       if (IS_ERR(rbspi->ahb_clk)) {
> +               err = PTR_ERR(rbspi->ahb_clk);
> +               goto err_put_master;
> +       }
> +
> +       err = clk_enable(rbspi->ahb_clk);

Shouldn't be clk_prepare_enable()?

> +       if (err)
> +               goto err_clk_put;
> +
> +       rbspi->ahb_freq = clk_get_rate(rbspi->ahb_clk);
> +       if (!rbspi->ahb_freq) {
> +               err = -EINVAL;
> +               goto err_clk_disable;
> +       }
> +
> +       platform_set_drvdata(pdev, rbspi);
> +
> +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!r) {
> +               err = -ENOENT;
> +               goto err_clk_disable;
> +       }
> +
> +       rbspi->base = ioremap(r->start, r->end - r->start + 1);
> +       if (!rbspi->base) {
> +               err = -ENXIO;
> +               goto err_clk_disable;
> +       }

devm_ioremap_resource()

> +
> +       rbspi->master = master;
> +       rbspi->spi_ctrl = get_spi_ctrl(rbspi);
> +       rbspi->cs_wait = -1;
> +
> +       spin_lock_init(&rbspi->lock);
> +       INIT_LIST_HEAD(&rbspi->queue);
> +
> +       err = spi_register_master(master);
> +       if (err) {
> +               dev_err(&pdev->dev, "failed to register SPI master\n");
> +               goto err_iounmap;
> +       }
> +
> +       return 0;
> +
> +err_iounmap:
> +       iounmap(rbspi->base);

Gone with devm_*

> +err_clk_disable:
> +       clk_disable(rbspi->ahb_clk);

clk_disable_unprepare

> +err_clk_put:
> +       clk_put(rbspi->ahb_clk);

Ditto.

> +err_put_master:
> +       platform_set_drvdata(pdev, NULL);

Not needed.

> +       spi_master_put(master);
> +err_out:
> +       return err;
> +}
> +
> +static int rb4xx_spi_remove(struct platform_device *pdev)
> +{
> +       struct rb4xx_spi *rbspi = platform_get_drvdata(pdev);
> +
> +       iounmap(rbspi->base);

Will gone with devm_*.

> +       clk_disable(rbspi->ahb_clk);

clk_disable_unprepare()

> +       clk_put(rbspi->ahb_clk);

Ditto.

> +       platform_set_drvdata(pdev, NULL);

Not needed.

> +       spi_master_put(rbspi->master);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver rb4xx_spi_drv = {
> +       .probe          = rb4xx_spi_probe,
> +       .remove         = rb4xx_spi_remove,
> +       .driver         = {
> +               .name   = DRV_NAME,
> +               .owner  = THIS_MODULE,

Not needed.

> +       },
> +};
> +
> +static int __init rb4xx_spi_init(void)
> +{
> +       return platform_driver_register(&rb4xx_spi_drv);
> +}
> +subsys_initcall(rb4xx_spi_init);
> +
> +static void __exit rb4xx_spi_exit(void)
> +{
> +       platform_driver_unregister(&rb4xx_spi_drv);
> +}
> +
> +module_exit(rb4xx_spi_exit);
> +
> +MODULE_DESCRIPTION(DRV_DESC);
> +MODULE_VERSION(DRV_VERSION);
> +MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org>");
> +MODULE_LICENSE("GPL v2");

-- 
With Best Regards,
Andy Shevchenko
