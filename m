Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 10:59:12 +0100 (CET)
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34078 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009837AbcBHJ7IgC-nC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 10:59:08 +0100
Received: by mail-yw0-f175.google.com with SMTP id h129so98271267ywb.1
        for <linux-mips@linux-mips.org>; Mon, 08 Feb 2016 01:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gWcIqR8RBFCgrdcgij45szojsnpzeQtdjhEGZ/3+WHU=;
        b=E+7Bj8VHCGCot+V8REuaaVkjhYWapX7kAHEmT72usXAWngY5voPjP/OGiydhyu4HoD
         JUrrpohubjFjLlJSz5JjQlwxdYpq/IDC/FykfZDYIAhl132FxCiQLwqcYsgCFK0PFlK5
         Xg9q/+wlF4JlELieoat/VxjIO0gIhGM/jGW8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gWcIqR8RBFCgrdcgij45szojsnpzeQtdjhEGZ/3+WHU=;
        b=QN/lUCu/pgqpiTzDZ1ujptqdMZ36P5/Rk6leX4jagrnbuuFOVzEKtkbl2M2pVuW2oF
         SBwqwukUxuNwrMXvScL/HTEeCGtw1gzjcPAnzSgTrezx0BD7sJUtI/Q/x502QuZE5RTs
         +bJwsjNvC2h3heeeuov2TEez9jx+J+A1d2ABdXt2Sz3CRWQ6bF4MsoTemilE/bt2WjpR
         epeuNFrVUqS0OIOOE5u00ORKtep4FX5/YRnu5JsPtNDy1Z5Rdv6ZCSHbL4K1QaDXEcaA
         nrQ0ICybPoZZ6p0qBr7f1FQTOLrKQuilFplJt4P+YfQOStD+hFAP/UVue5ig3tZDVw/c
         shlQ==
X-Gm-Message-State: AG10YOQQrhIDobGDoqBB8oI+PLSy2EM2wjJt2/ULsGiMK4isEWV3sHQWTqhZszX1B+f4ug+waPBoOECS9IEgRveN
MIME-Version: 1.0
X-Received: by 10.129.0.198 with SMTP id 189mr15158054ywa.329.1454925541342;
 Mon, 08 Feb 2016 01:59:01 -0800 (PST)
Received: by 10.129.114.84 with HTTP; Mon, 8 Feb 2016 01:59:01 -0800 (PST)
In-Reply-To: <1452734299-460-13-git-send-email-joshua.henderson@microchip.com>
References: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
        <1452734299-460-13-git-send-email-joshua.henderson@microchip.com>
Date:   Mon, 8 Feb 2016 10:59:01 +0100
Message-ID: <CAPDyKFovwmFBXp2nf=UU=cHbBLrsBF5Yjfj0H49w-SdzGn_PJA@mail.gmail.com>
Subject: Re: [PATCH v5 12/14] mmc: sdhci-pic32: Add PIC32 SDHCI host
 controller driver
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Jean Delvare <jdelvare@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Corneliu Doban <cdoban@broadcom.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Luis de Bethencourt <luisbg@osg.samsung.com>,
        Weijun Yang <Weijun.Yang@csr.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Scott Branden <sbranden@broadcom.com>,
        Vincent Yang <vincent.yang.fujitsu@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        yangbo lu <yangbo.lu@freescale.com>,
        Kevin Hao <haokexin@gmail.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Andy Green <andy.green@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

+ Adrian

On 14 January 2016 at 02:15, Joshua Henderson
<joshua.henderson@microchip.com> wrote:
> From: Andrei Pistirica <andrei.pistirica@microchip.com>
>
> This driver supports the SDHCI host controller found on a PIC32.
>
> Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>

I have queued this up for next via my mmc tree.

Adrian, please tell me if you have any objections.

Thanks and kind regards!
Uffe

> ---
> Changes since v4: None
> Changes since v3: None
> Changes since v2:
>         - Use 'sdhci_pltfm_*' instead of 'sdhci_*_host' and other cleanup
> Changes since v1:
>         - Be consistent and use only "SDHCI" when referring to SD host
>           controller
>         - Remove unnecessary PIC32 sdhci_ops min clock function.
>         - Drop usage of piomode and no-1-8-v DT properties
>         - Formatting
>         - Fix use of devm_iounmap
>         - Address code comment
> ---
>  drivers/mmc/host/Kconfig       |   11 ++
>  drivers/mmc/host/Makefile      |    1 +
>  drivers/mmc/host/sdhci-pic32.c |  257 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 269 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-pic32.c
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1dee533..c6a8916 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -785,3 +785,14 @@ config MMC_MTK
>           If you have a machine with a integrated SD/MMC card reader, say Y or M here.
>           This is needed if support for any SD/SDIO/MMC devices is required.
>           If unsure, say N.
> +
> +config MMC_SDHCI_MICROCHIP_PIC32
> +        tristate "Microchip PIC32MZDA SDHCI support"
> +        depends on MMC_SDHCI && PIC32MZDA && MMC_SDHCI_PLTFM
> +        help
> +          This selects the Secure Digital Host Controller Interface (SDHCI)
> +          for PIC32MZDA platform.
> +
> +          If you have a controller with this interface, say Y or M here.
> +
> +          If unsure, say N.
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 3595f83..af918d2 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_MMC_SDHCI_BCM2835)               += sdhci-bcm2835.o
>  obj-$(CONFIG_MMC_SDHCI_IPROC)          += sdhci-iproc.o
>  obj-$(CONFIG_MMC_SDHCI_MSM)            += sdhci-msm.o
>  obj-$(CONFIG_MMC_SDHCI_ST)             += sdhci-st.o
> +obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)        += sdhci-pic32.o
>
>  ifeq ($(CONFIG_CB710_DEBUG),y)
>         CFLAGS-cb710-mmc        += -DDEBUG
> diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
> new file mode 100644
> index 0000000..059df70
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-pic32.c
> @@ -0,0 +1,257 @@
> +/*
> + * Support of SDHCI platform devices for Microchip PIC32.
> + *
> + * Copyright (C) 2015 Microchip
> + * Andrei Pistirica, Paul Thacker
> + *
> + * Inspired by sdhci-pltfm.c
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/highmem.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/slab.h>
> +#include <linux/mmc/host.h>
> +#include <linux/io.h>
> +#include "sdhci.h"
> +#include "sdhci-pltfm.h"
> +#include <linux/platform_data/sdhci-pic32.h>
> +
> +#define SDH_SHARED_BUS_CTRL            0x000000E0
> +#define SDH_SHARED_BUS_NR_CLK_PINS_MASK        0x7
> +#define SDH_SHARED_BUS_NR_IRQ_PINS_MASK        0x30
> +#define SDH_SHARED_BUS_CLK_PINS                0x10
> +#define SDH_SHARED_BUS_IRQ_PINS                0x14
> +#define SDH_CAPS_SDH_SLOT_TYPE_MASK    0xC0000000
> +#define SDH_SLOT_TYPE_REMOVABLE                0x0
> +#define SDH_SLOT_TYPE_EMBEDDED         0x1
> +#define SDH_SLOT_TYPE_SHARED_BUS       0x2
> +#define SDHCI_CTRL_CDSSEL              0x80
> +#define SDHCI_CTRL_CDTLVL              0x40
> +
> +#define ADMA_FIFO_RD_THSHLD    512
> +#define ADMA_FIFO_WR_THSHLD    512
> +
> +struct pic32_sdhci_priv {
> +       struct platform_device  *pdev;
> +       struct clk *sys_clk;
> +       struct clk *base_clk;
> +};
> +
> +static unsigned int pic32_sdhci_get_max_clock(struct sdhci_host *host)
> +{
> +       struct pic32_sdhci_priv *sdhci_pdata = sdhci_priv(host);
> +
> +       return clk_get_rate(sdhci_pdata->base_clk);
> +}
> +
> +static void pic32_sdhci_set_bus_width(struct sdhci_host *host, int width)
> +{
> +       u8 ctrl;
> +
> +       ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +       if (width == MMC_BUS_WIDTH_8) {
> +               ctrl &= ~SDHCI_CTRL_4BITBUS;
> +               if (host->version >= SDHCI_SPEC_300)
> +                       ctrl |= SDHCI_CTRL_8BITBUS;
> +       } else {
> +               if (host->version >= SDHCI_SPEC_300)
> +                       ctrl &= ~SDHCI_CTRL_8BITBUS;
> +               if (width == MMC_BUS_WIDTH_4)
> +                       ctrl |= SDHCI_CTRL_4BITBUS;
> +               else
> +                       ctrl &= ~SDHCI_CTRL_4BITBUS;
> +       }
> +
> +       /* CD select and test bits must be set for errata workaround. */
> +       ctrl &= ~SDHCI_CTRL_CDTLVL;
> +       ctrl |= SDHCI_CTRL_CDSSEL;
> +       sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +}
> +
> +static unsigned int pic32_sdhci_get_ro(struct sdhci_host *host)
> +{
> +       /*
> +        * The SDHCI_WRITE_PROTECT bit is unstable on current hardware so we
> +        * can't depend on its value in any way.
> +        */
> +       return 0;
> +}
> +
> +static const struct sdhci_ops pic32_sdhci_ops = {
> +       .get_max_clock = pic32_sdhci_get_max_clock,
> +       .set_clock = sdhci_set_clock,
> +       .set_bus_width = pic32_sdhci_set_bus_width,
> +       .reset = sdhci_reset,
> +       .set_uhs_signaling = sdhci_set_uhs_signaling,
> +       .get_ro = pic32_sdhci_get_ro,
> +};
> +
> +static struct sdhci_pltfm_data sdhci_pic32_pdata = {
> +       .ops = &pic32_sdhci_ops,
> +       .quirks = SDHCI_QUIRK_NO_HISPD_BIT,
> +       .quirks2 = SDHCI_QUIRK2_NO_1_8_V,
> +};
> +
> +static void pic32_sdhci_shared_bus(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       u32 bus = readl(host->ioaddr + SDH_SHARED_BUS_CTRL);
> +       u32 clk_pins = (bus & SDH_SHARED_BUS_NR_CLK_PINS_MASK) >> 0;
> +       u32 irq_pins = (bus & SDH_SHARED_BUS_NR_IRQ_PINS_MASK) >> 4;
> +
> +       /* select first clock */
> +       if (clk_pins & 1)
> +               bus |= (1 << SDH_SHARED_BUS_CLK_PINS);
> +
> +       /* select first interrupt */
> +       if (irq_pins & 1)
> +               bus |= (1 << SDH_SHARED_BUS_IRQ_PINS);
> +
> +       writel(bus, host->ioaddr + SDH_SHARED_BUS_CTRL);
> +}
> +
> +static int pic32_sdhci_probe_platform(struct platform_device *pdev,
> +                                     struct pic32_sdhci_priv *pdata)
> +{
> +       int ret = 0;
> +       u32 caps_slot_type;
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +
> +       /* Check card slot connected on shared bus. */
> +       host->caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
> +       caps_slot_type = (host->caps & SDH_CAPS_SDH_SLOT_TYPE_MASK) >> 30;
> +       if (caps_slot_type == SDH_SLOT_TYPE_SHARED_BUS)
> +               pic32_sdhci_shared_bus(pdev);
> +
> +       return ret;
> +}
> +
> +static int pic32_sdhci_probe(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host;
> +       struct sdhci_pltfm_host *pltfm_host;
> +       struct pic32_sdhci_priv *sdhci_pdata;
> +       struct pic32_sdhci_platform_data *plat_data;
> +       int ret;
> +
> +       host = sdhci_pltfm_init(pdev, &sdhci_pic32_pdata,
> +                               sizeof(struct pic32_sdhci_priv));
> +       if (IS_ERR(host)) {
> +               ret = PTR_ERR(host);
> +               goto err;
> +       }
> +
> +       pltfm_host = sdhci_priv(host);
> +       sdhci_pdata = sdhci_pltfm_priv(pltfm_host);
> +
> +       plat_data = pdev->dev.platform_data;
> +       if (plat_data && plat_data->setup_dma) {
> +               ret = plat_data->setup_dma(ADMA_FIFO_RD_THSHLD,
> +                                          ADMA_FIFO_WR_THSHLD);
> +               if (ret)
> +                       goto err_host;
> +       }
> +
> +       sdhci_pdata->sys_clk = devm_clk_get(&pdev->dev, "sys_clk");
> +       if (IS_ERR(sdhci_pdata->sys_clk)) {
> +               ret = PTR_ERR(sdhci_pdata->sys_clk);
> +               dev_err(&pdev->dev, "Error getting clock\n");
> +               goto err_host;
> +       }
> +
> +       ret = clk_prepare_enable(sdhci_pdata->sys_clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Error enabling clock\n");
> +               goto err_host;
> +       }
> +
> +       sdhci_pdata->base_clk = devm_clk_get(&pdev->dev, "base_clk");
> +       if (IS_ERR(sdhci_pdata->base_clk)) {
> +               ret = PTR_ERR(sdhci_pdata->base_clk);
> +               dev_err(&pdev->dev, "Error getting clock\n");
> +               goto err_sys_clk;
> +       }
> +
> +       ret = clk_prepare_enable(sdhci_pdata->base_clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Error enabling clock\n");
> +               goto err_base_clk;
> +       }
> +
> +       ret = mmc_of_parse(host->mmc);
> +       if (ret)
> +               goto err_base_clk;
> +
> +       ret = pic32_sdhci_probe_platform(pdev, sdhci_pdata);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to probe platform!\n");
> +               goto err_base_clk;
> +       }
> +
> +       ret = sdhci_add_host(host);
> +       if (ret) {
> +               dev_err(&pdev->dev, "error adding host\n");
> +               goto err_base_clk;
> +       }
> +
> +       dev_info(&pdev->dev, "Successfully added sdhci host\n");
> +       return 0;
> +
> +err_base_clk:
> +       clk_disable_unprepare(sdhci_pdata->base_clk);
> +err_sys_clk:
> +       clk_disable_unprepare(sdhci_pdata->sys_clk);
> +err_host:
> +       sdhci_pltfm_free(pdev);
> +err:
> +       dev_err(&pdev->dev, "pic32-sdhci probe failed: %d\n", ret);
> +       return ret;
> +}
> +
> +static int pic32_sdhci_remove(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct pic32_sdhci_priv *sdhci_pdata = sdhci_priv(host);
> +       u32 scratch;
> +
> +       scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
> +       sdhci_remove_host(host, scratch == (u32)~0);
> +       clk_disable_unprepare(sdhci_pdata->base_clk);
> +       clk_disable_unprepare(sdhci_pdata->sys_clk);
> +       sdhci_pltfm_free(pdev);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id pic32_sdhci_id_table[] = {
> +       { .compatible = "microchip,pic32mzda-sdhci" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, pic32_sdhci_id_table);
> +
> +static struct platform_driver pic32_sdhci_driver = {
> +       .driver = {
> +               .name   = "pic32-sdhci",
> +               .owner  = THIS_MODULE,
> +               .of_match_table = of_match_ptr(pic32_sdhci_id_table),
> +       },
> +       .probe          = pic32_sdhci_probe,
> +       .remove         = pic32_sdhci_remove,
> +};
> +
> +module_platform_driver(pic32_sdhci_driver);
> +
> +MODULE_DESCRIPTION("Microchip PIC32 SDHCI driver");
> +MODULE_AUTHOR("Pistirica Sorin Andrei & Sandeep Sheriker");
> +MODULE_LICENSE("GPL v2");
> --
> 1.7.9.5
>
