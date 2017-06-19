Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 01:36:48 +0200 (CEST)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:35161
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992036AbdFSXglFU2FQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2017 01:36:41 +0200
Received: by mail-wm0-x243.google.com with SMTP id d64so19662572wmf.2;
        Mon, 19 Jun 2017 16:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xad16ieK7FZMWOw8xknqQIy6OtDLN9Y1fWvn/ao7Q0o=;
        b=BJcNwXEHfK/E5bHeCv+mSANd7al6nTpKX5FOrC+VLayUY20lVf/g4KqMmMRGRn2Ewl
         ZPs1kXg0+QU9eYbTnwpwkWD1878JZ5Ww6qGV3oj2SI61Y20ddC3u9UjzcOyhnFx281W3
         GOoRYA+8ZXooJgTNFDEtMfKrSalps/GYPJBOXI+TF7gafgZekDguePR/59c+AF7BhCiQ
         pRNmt99Eh3m2+Lt5KtPfW/UMe0Vla/Mmu/mk9hGu+RL2NDiApbfnXL7pawd5RT8UBgAI
         wg0jqg+FDkCKkr92CeSx7ShChUQGl13uilE6rQmLnfzZiVxeW8QyL8xPqgAp/+7TtWkW
         ZpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xad16ieK7FZMWOw8xknqQIy6OtDLN9Y1fWvn/ao7Q0o=;
        b=hM8f2a+D6CUKMqDw7XtDUyrP58VQhZ13emC5L2A7CWJeOAPoIfnUW2RMWCluAvji2v
         +mdwzOEkwrTQB1VJ9XdMiok29SlEbizQA7IjX00/MsxXHlHJxFrJ0hjqn3Pl3/gjvzCw
         cyeEaDsYH/+SyBJQw6rSf4heHTbeFZmHvRWviy8ttVqzTJGBNB28dDpvGLgUFYoDcuGi
         1Ya351v6dofFvXlyvj+BSpQgoM3y1b1lZ07jgjP9XRlNOQ7eEVToI1JQomKf+jNHWdEM
         mWcnQ3DVWg/7o1CpY9B1f0rj6vkOgmAPyVSU69FjMht6mQjHUA4vJSf6CCXX4H65t+DH
         55qg==
X-Gm-Message-State: AKS2vOy+oNm/64GgMieocK++PjsKcR24uX6z9CTqQdVG749t3EOYK7r5
        E3GnMvNNzOZdzx8L0IlDWeiwXqvsig==
X-Received: by 10.28.22.4 with SMTP id 4mr687641wmw.68.1497915395576; Mon, 19
 Jun 2017 16:36:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.172.246 with HTTP; Mon, 19 Jun 2017 16:36:35 -0700 (PDT)
In-Reply-To: <20170619222608.13344-13-hauke@hauke-m.de>
References: <20170619222608.13344-1-hauke@hauke-m.de> <20170619222608.13344-13-hauke@hauke-m.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Jun 2017 02:36:35 +0300
Message-ID: <CAHp75VcDgC7n3FVig0r0RBg=B655sv_jWQt7RWXU9uPx9QGvqA@mail.gmail.com>
Subject: Re: [PATCH v4 12/16] MIPS: lantiq: Add a GPHY driver which uses the
 RCU syscon-mfd
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58656
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

On Tue, Jun 20, 2017 at 1:26 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Compared to the old xrx200_phy_fw driver the new version has multiple
> enhancements. The name of the firmware files does not have to be added
> to all .dts files anymore - one now configures the GPHY mode (FE or GE)
> instead. Each GPHY can now also boot separate firmware (thus mixing of
> GE and FE GPHYs is now possible).
> The new implementation is based on the RCU syscon-mfd and uses the
> reeset_controller framework instead of raw RCU register reads/writes.
>

Couple of comments, otherwise FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/mips/lantiq/rcu-gphy.txt   |  36 +++
>  arch/mips/lantiq/xway/sysctrl.c                    |   6 +-
>  drivers/soc/lantiq/Makefile                        |   1 +
>  drivers/soc/lantiq/gphy.c                          | 261 +++++++++++++++++++++
>  include/dt-bindings/mips/lantiq_rcu_gphy.h         |  15 ++
>  5 files changed, 317 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
>  create mode 100644 drivers/soc/lantiq/gphy.c
>  create mode 100644 include/dt-bindings/mips/lantiq_rcu_gphy.h
>
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
> new file mode 100644
> index 000000000000..ec09783da9b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
> @@ -0,0 +1,36 @@
> +Lantiq XWAY SoC GPHY binding
> +============================
> +
> +This binding describes a software-defined ethernet PHY, provided by the RCU
> +module on newer Lantiq XWAY SoCs (xRX200 and newer).
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible           : Should be one of
> +                               "lantiq,xrx200a1x-gphy"
> +                               "lantiq,xrx200a2x-gphy"
> +                               "lantiq,xrx300-gphy"
> +                               "lantiq,xrx330-gphy"
> +- reg                  : Addrress of the GPHY FW load address register
> +- resets               : Must reference the RCU GPHY reset bit
> +- reset-names          : One entry, value must be "gphy" or optional "gphy2"
> +- clocks               : A reference to the (PMU) GPHY clock gate
> +
> +Optional properties:
> +- lantiq,gphy-mode     : GPHY_MODE_GE (default) or GPHY_MODE_FE as defined in
> +                         <dt-bindings/mips/lantiq_xway_gphy.h>
> +
> +
> +-------------------------------------------------------------------------------
> +Example for the GPHys on the xRX200 SoCs:
> +
> +#include <dt-bindings/mips/lantiq_rcu_gphy.h>
> +       gphy0: gphy@0 {
> +               compatible = "lantiq,xrx200a2x-gphy";
> +               reg = <0x20 0x4>
> +
> +               resets = <&reset0 31 30>, <&reset1 7 7>;
> +               reset-names = "gphy", "gphy2";
> +               clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
> +               lantiq,gphy-mode = <GPHY_MODE_GE>
> +       };
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index 706639a343bc..87eab4d288e5 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
> @@ -518,7 +518,8 @@ void __init ltq_soc_init(void)
>                 clkdev_add_pmu("1e108000.eth", NULL, 0, 0, PMU_SWITCH |
>                                PMU_PPE_DP | PMU_PPE_TC);
>                 clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
> -               clkdev_add_pmu("1f203000.rcu", "gphy", 1, 0, PMU_GPHY);
> +               clkdev_add_pmu("1f203020.gphy", NULL, 1, 0, PMU_GPHY);
> +               clkdev_add_pmu("1f203068.gphy", NULL, 1, 0, PMU_GPHY);
>                 clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
>                 clkdev_add_pmu("1e116000.mei", "afe", 1, 2, PMU_ANALOG_DSL_AFE);
>                 clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
> @@ -541,7 +542,8 @@ void __init ltq_soc_init(void)
>                                 PMU_SWITCH | PMU_PPE_DPLUS | PMU_PPE_DPLUM |
>                                 PMU_PPE_EMA | PMU_PPE_TC | PMU_PPE_SLL01 |
>                                 PMU_PPE_QSB | PMU_PPE_TOP);
> -               clkdev_add_pmu("1f203000.rcu", "gphy", 0, 0, PMU_GPHY);
> +               clkdev_add_pmu("1f203020.gphy", NULL, 0, 0, PMU_GPHY);
> +               clkdev_add_pmu("1f203068.gphy", NULL, 0, 0, PMU_GPHY);
>                 clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
>                 clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
>                 clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
> diff --git a/drivers/soc/lantiq/Makefile b/drivers/soc/lantiq/Makefile
> index 35aa86bd1023..be9e866d53e5 100644
> --- a/drivers/soc/lantiq/Makefile
> +++ b/drivers/soc/lantiq/Makefile
> @@ -1 +1,2 @@
>  obj-y                          += fpi-bus.o
> +obj-$(CONFIG_XRX200_PHY_FW)    += gphy.o
> diff --git a/drivers/soc/lantiq/gphy.c b/drivers/soc/lantiq/gphy.c
> new file mode 100644
> index 000000000000..4c84447b0a84
> --- /dev/null
> +++ b/drivers/soc/lantiq/gphy.c
> @@ -0,0 +1,261 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + *  Copyright (C) 2012 John Crispin <blogic@phrozen.org>
> + *  Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> + *  Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/firmware.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/property.h>
> +#include <dt-bindings/mips/lantiq_rcu_gphy.h>
> +
> +#include <lantiq_soc.h>
> +
> +#define XRX200_GPHY_FW_ALIGN   (16 * 1024)
> +
> +struct xway_gphy_priv {
> +       struct clk *gphy_clk_gate;
> +       struct reset_control *gphy_reset;
> +       struct reset_control *gphy_reset2;
> +       struct notifier_block gphy_reboot_nb;
> +       void __iomem *membase;
> +       char *fw_name;
> +       dma_addr_t dma_addr;
> +       void *fw_addr;
> +       size_t size;
> +};
> +
> +struct xway_gphy_match_data {
> +       char *fe_firmware_name;
> +       char *ge_firmware_name;
> +};
> +
> +static const struct xway_gphy_match_data xrx200a1x_gphy_data = {
> +       .fe_firmware_name = "lantiq/xrx200_phy22f_a14.bin",
> +       .ge_firmware_name = "lantiq/xrx200_phy11g_a14.bin",
> +};
> +
> +static const struct xway_gphy_match_data xrx200a2x_gphy_data = {
> +       .fe_firmware_name = "lantiq/xrx200_phy22f_a22.bin",
> +       .ge_firmware_name = "lantiq/xrx200_phy11g_a22.bin",
> +};
> +
> +static const struct xway_gphy_match_data xrx300_gphy_data = {
> +       .fe_firmware_name = "lantiq/xrx300_phy22f_a21.bin",
> +       .ge_firmware_name = "lantiq/xrx300_phy11g_a21.bin",
> +};
> +
> +static const struct of_device_id xway_gphy_match[] = {
> +       { .compatible = "lantiq,xrx200a1x-gphy", .data = &xrx200a1x_gphy_data },
> +       { .compatible = "lantiq,xrx200a2x-gphy", .data = &xrx200a2x_gphy_data },
> +       { .compatible = "lantiq,xrx300-gphy", .data = &xrx300_gphy_data },
> +       { .compatible = "lantiq,xrx330-gphy", .data = &xrx300_gphy_data },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, xway_gphy_match);
> +
> +static struct xway_gphy_priv *to_xway_gphy_priv(struct notifier_block *nb)
> +{
> +       return container_of(nb, struct xway_gphy_priv, gphy_reboot_nb);
> +}
> +
> +static int xway_gphy_reboot_notify(struct notifier_block *reboot_nb,
> +                                  unsigned long code, void *unused)
> +{
> +       struct xway_gphy_priv *priv = to_xway_gphy_priv(reboot_nb);
> +
> +       if (priv) {
> +               reset_control_assert(priv->gphy_reset);
> +               reset_control_assert(priv->gphy_reset2);
> +       }
> +
> +       return NOTIFY_DONE;
> +}
> +
> +static int xway_gphy_load(struct device *dev, struct xway_gphy_priv *priv,
> +                         dma_addr_t *dev_addr)
> +{
> +       const struct firmware *fw;
> +       void *fw_addr_align;
> +       int ret;
> +
> +       ret = request_firmware(&fw, priv->fw_name, dev);
> +       if (ret) {
> +               dev_err(dev, "failed to load firmware: %s, error: %i\n",
> +                       priv->fw_name, ret);
> +               return ret;
> +       }
> +
> +       /*
> +        * GPHY cores need the firmware code in a persistent and contiguous
> +        * memory area with a 16 kB boundary aligned start address.
> +        */
> +       priv->size = fw->size + XRX200_GPHY_FW_ALIGN;
> +
> +       priv->fw_addr = dma_alloc_coherent(dev, priv->size,
> +                                          &priv->dma_addr, GFP_KERNEL);

dmam_ ?

> +       if (priv->fw_addr) {
> +               fw_addr_align = PTR_ALIGN(priv->fw_addr, XRX200_GPHY_FW_ALIGN);
> +               *dev_addr = ALIGN(priv->dma_addr, XRX200_GPHY_FW_ALIGN);
> +               memcpy(fw_addr_align, fw->data, fw->size);
> +       } else {
> +               dev_err(dev, "failed to alloc firmware memory\n");
> +               ret = -ENOMEM;
> +       }
> +
> +       release_firmware(fw);
> +
> +       return ret;
> +}
> +
> +static int xway_gphy_of_probe(struct platform_device *pdev, struct xway_gphy_priv *priv)
> +{
> +       struct device *dev = &pdev->dev;
> +       const struct xway_gphy_match_data *gphy_fw_name_cfg;
> +       u32 gphy_mode;
> +       int ret;
> +       struct resource *res_gphy;
> +
> +       gphy_fw_name_cfg = of_device_get_match_data(dev);
> +
> +       priv->gphy_clk_gate = devm_clk_get(dev, NULL);
> +       if (IS_ERR(priv->gphy_clk_gate)) {
> +               dev_err(dev, "Failed to lookup gate clock\n");
> +               return PTR_ERR(priv->gphy_clk_gate);
> +       }
> +
> +       res_gphy = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       priv->membase = devm_ioremap_resource(dev, res_gphy);
> +       if (IS_ERR(priv->membase))
> +               return PTR_ERR(priv->membase);
> +
> +       priv->gphy_reset = devm_reset_control_get(dev, "gphy");
> +       if (IS_ERR(priv->gphy_reset)) {
> +               if (PTR_ERR(priv->gphy_reset) != -EPROBE_DEFER)
> +                       dev_err(dev, "Failed to lookup gphy reset\n");
> +               return PTR_ERR(priv->gphy_reset);
> +       }
> +
> +       priv->gphy_reset2 = devm_reset_control_get_optional(dev, "gphy2");
> +       if (IS_ERR(priv->gphy_reset2))
> +               return PTR_ERR(priv->gphy_reset2);
> +
> +       ret = device_property_read_u32(dev, "lantiq,gphy-mode", &gphy_mode);
> +       /* Default to GE mode */
> +       if (ret)
> +               gphy_mode = GPHY_MODE_GE;
> +
> +       switch (gphy_mode) {
> +       case GPHY_MODE_FE:
> +               priv->fw_name = gphy_fw_name_cfg->fe_firmware_name;
> +               break;
> +       case GPHY_MODE_GE:
> +               priv->fw_name = gphy_fw_name_cfg->ge_firmware_name;
> +               break;
> +       default:
> +               dev_err(dev, "Unknown GPHY mode %d\n", gphy_mode);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int xway_gphy_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct xway_gphy_priv *priv;
> +       dma_addr_t fw_addr = 0;
> +       int ret;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       ret = xway_gphy_of_probe(pdev, priv);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_prepare_enable(priv->gphy_clk_gate);
> +       if (ret)
> +               return ret;
> +
> +       ret = xway_gphy_load(dev, priv, &fw_addr);
> +       if (ret)

You need to disable and unprepare a clock.

> +               return ret;
> +
> +       reset_control_assert(priv->gphy_reset);
> +       reset_control_assert(priv->gphy_reset2);
> +
> +       iowrite32be(fw_addr, priv->membase);
> +
> +       reset_control_deassert(priv->gphy_reset);
> +       reset_control_deassert(priv->gphy_reset2);
> +
> +       /* assert the gphy reset because it can hang after a reboot: */
> +       priv->gphy_reboot_nb.notifier_call = xway_gphy_reboot_notify;
> +       priv->gphy_reboot_nb.priority = -1;
> +
> +       ret = register_reboot_notifier(&priv->gphy_reboot_nb);
> +       if (ret)
> +               dev_warn(dev, "Failed to register reboot notifier\n");
> +
> +       platform_set_drvdata(pdev, priv);
> +
> +       return ret;
> +}
> +
> +static int xway_gphy_remove(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct xway_gphy_priv *priv = platform_get_drvdata(pdev);
> +       int ret;
> +
> +       reset_control_assert(priv->gphy_reset);
> +       reset_control_assert(priv->gphy_reset2);
> +
> +       iowrite32be(0, priv->membase);
> +
> +       clk_disable_unprepare(priv->gphy_clk_gate);
> +

> +       dma_free_coherent(dev, priv->size, priv->fw_addr, priv->dma_addr);

It will go away if dmam_ variant is in use.

> +
> +       ret = unregister_reboot_notifier(&priv->gphy_reboot_nb);
> +       if (ret)
> +               dev_warn(dev, "Failed to unregister reboot notifier\n");
> +
> +       return 0;
> +}
> +
> +static struct platform_driver xway_gphy_driver = {
> +       .probe = xway_gphy_probe,
> +       .remove = xway_gphy_remove,
> +       .driver = {
> +               .name = "xway-rcu-gphy",
> +               .of_match_table = xway_gphy_match,
> +       },
> +};
> +
> +module_platform_driver(xway_gphy_driver);
> +
> +MODULE_FIRMWARE("lantiq/xrx300_phy11g_a21.bin");
> +MODULE_FIRMWARE("lantiq/xrx300_phy22f_a21.bin");
> +MODULE_FIRMWARE("lantiq/xrx200_phy11g_a14.bin");
> +MODULE_FIRMWARE("lantiq/xrx200_phy11g_a22.bin");
> +MODULE_FIRMWARE("lantiq/xrx200_phy22f_a14.bin");
> +MODULE_FIRMWARE("lantiq/xrx200_phy22f_a22.bin");
> +MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
> +MODULE_DESCRIPTION("Lantiq XWAY GPHY Firmware Loader");
> +MODULE_LICENSE("GPL");
> diff --git a/include/dt-bindings/mips/lantiq_rcu_gphy.h b/include/dt-bindings/mips/lantiq_rcu_gphy.h
> new file mode 100644
> index 000000000000..fa1a63773342
> --- /dev/null
> +++ b/include/dt-bindings/mips/lantiq_rcu_gphy.h
> @@ -0,0 +1,15 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + *  Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> + *  Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
> + */
> +#ifndef _DT_BINDINGS_MIPS_LANTIQ_RCU_GPHY_H
> +#define _DT_BINDINGS_MIPS_LANTIQ_RCU_GPHY_H
> +
> +#define GPHY_MODE_GE   1
> +#define GPHY_MODE_FE   2
> +
> +#endif /* _DT_BINDINGS_MIPS_LANTIQ_RCU_GPHY_H */
> --
> 2.11.0
>



-- 
With Best Regards,
Andy Shevchenko
