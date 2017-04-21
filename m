Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Apr 2017 20:29:11 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:34650
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993892AbdDUS3DQOTsu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Apr 2017 20:29:03 +0200
Received: by mail-wm0-x242.google.com with SMTP id z129so6374978wmb.1;
        Fri, 21 Apr 2017 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wlBkzEQIb66upG73gXDSUdlYh7/RYTv4rj2CksGtsDM=;
        b=YGzBJ/+MwhUpuEnCLSQWjSs6fSYwocpT5VK5kIxxQ6aQBLtSeMaj7zpKoT13fH9a2q
         xyjieon3uszKdeL9+KuYxKrEWW5h70WX9UPl51x3opukgClpVqucknN1FIEVEXGtCSt9
         uGV0GV4cvejHOD6xAx7vjFL2sQn0nlCZBvbXClY2OdXF7lNcutaOWzmiqUuFnG0MwOs4
         gioWvKkaRetDmeC/uI5b6/cWAEzIgYzxrjtnMG+g2s8r6Uwu35g0qn/pG+V4g5yG1f1b
         XxtyLDlcKFHb6R65eXqYMyUE1ttqqZyHnuS4op9EO2jCfHKEfswjmqCxaqqIelZ7KTyy
         Q4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wlBkzEQIb66upG73gXDSUdlYh7/RYTv4rj2CksGtsDM=;
        b=EYs3brYr01SXLutUYi4FqExM3QtMXLerBlbFpZ8UvJAg8GVcnUr4Ai2PI0TZXC9yck
         oNP4jOkb+hi6Ag4I7pV2eAw+cgUjm6jcfy7YaAdwmQ2Ia9dVrV9SJZWaMOgsONNsmMzo
         Gn0uCfbJSpl2PmMM94w17ChECt5vYi1nqK1ZtoyrhjUxL18fNOhiKSY+izxF+R0bqykG
         NLW/P6nE63H6wz4hKYRUoF8lGnXP14PJc+a2kC+hfGQ1xsLMgQt61MjstuvE/WGjnlKq
         HotlwhV5SFk7dpxtoVhe0kYp2HNyj/3f+Q5LDStntp4aYNsi3MKj3E4dbFWgNLJgfDxw
         VMqg==
X-Gm-Message-State: AN3rC/5dQtrAs30k9gDSboh8mrKJN6AOnmPXfA57CflPIMjEt4EdxBok
        TBKG54OiPoslw11VW3jrmIVx2RHRHQ==
X-Received: by 10.28.225.10 with SMTP id y10mr41707wmg.34.1492799337198; Fri,
 21 Apr 2017 11:28:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.166.80 with HTTP; Fri, 21 Apr 2017 11:28:36 -0700 (PDT)
In-Reply-To: <20170417192942.32219-7-hauke@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de> <20170417192942.32219-7-hauke@hauke-m.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 21 Apr 2017 20:28:36 +0200
Message-ID: <CAFBinCCWc5AhYNUmbS-+eV+4dj63Hkf7VWwK+w6pZfnnJ-3ZFw@mail.gmail.com>
Subject: Re: [PATCH 06/13] MIPS: lantiq: Convert the xbar driver to a platform_driver
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <martin.blumenstingl@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.blumenstingl@googlemail.com
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

On Mon, Apr 17, 2017 at 9:29 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> This allows using the xbar driver on ARX300 based SoCs which require the
> same xbar setup as the xRX200 chipsets because the xbar driver
> initialization is not guarded by an xRX200 specific
> of_machine_is_compatible condition anymore. Additionally the new driver
> takes a syscon phandle to configure the XBAR endianness bits in RCU
> (before this was done in arch/mips/lantiq/xway/reset.c and also
> guarded by an xRX200 specific if-statement).
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/mips/lantiq/xbar.txt       |  22 +++++
>  MAINTAINERS                                        |   1 +
>  arch/mips/lantiq/xway/reset.c                      |   4 -
>  arch/mips/lantiq/xway/sysctrl.c                    |  41 ---------
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/lantiq/Makefile                        |   1 +
>  drivers/soc/lantiq/xbar.c                          | 100 +++++++++++++++++++++
>  7 files changed, 125 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>  create mode 100644 drivers/soc/lantiq/Makefile
>  create mode 100644 drivers/soc/lantiq/xbar.c
>
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/xbar.txt b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
> new file mode 100644
> index 000000000000..86e53ff3b0d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
> @@ -0,0 +1,22 @@
> +Lantiq XWAY SoC XBAR binding
> +============================
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible   : Should be "lantiq,xbar-xway"
> +- reg          : The address and length of the XBAR registers
> +
> +Optional properties:
> +- lantiq,rcu-syscon    : A phandle and offset to the endianness configuration
> +                         registers in the RCU module
is the xbar module really coupled with the RCU mdoule? if it is then:

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> +
> +
> +-------------------------------------------------------------------------------
> +Example for the XBAR on the xRX200 SoCs:
> +       xbar0: xbar@400000 {
> +               compatible = "lantiq,xbar-xway";
> +               reg = <0x400000 0x1000>;
> +               big-endian;
> +               lantiq,rcu-syscon = <&rcu0 0x4c>;
> +       };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 676c139bc883..7c03776a56e9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7321,6 +7321,7 @@ M:        John Crispin <john@phrozen.org>
>  L:     linux-mips@linux-mips.org
>  S:     Maintained
>  F:     arch/mips/lantiq
> +F:     drivers/soc/lantiq
>
>  LAPB module
>  L:     linux-x25@vger.kernel.org
> diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
> index 83fd65d76e81..b6752c95a600 100644
> --- a/arch/mips/lantiq/xway/reset.c
> +++ b/arch/mips/lantiq/xway/reset.c
> @@ -373,10 +373,6 @@ static int __init mips_reboot_setup(void)
>             of_machine_is_compatible("lantiq,vr9"))
>                 ltq_usb_init();
>
> -       if (of_machine_is_compatible("lantiq,vr9"))
> -               ltq_rcu_w32(ltq_rcu_r32(RCU_AHB_ENDIAN) | RCU_VR9_BE_AHB1S,
> -                           RCU_AHB_ENDIAN);
> -
>         _machine_restart = ltq_machine_restart;
>         _machine_halt = ltq_machine_halt;
>         pm_power_off = ltq_machine_power_off;
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index 95bec460b651..706639a343bc 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
> @@ -145,15 +145,7 @@ static u32 pmu_clk_cr_b[] = {
>  #define pmu_w32(x, y)  ltq_w32((x), pmu_membase + (y))
>  #define pmu_r32(x)     ltq_r32(pmu_membase + (x))
>
> -#define XBAR_ALWAYS_LAST       0x430
> -#define XBAR_FPI_BURST_EN      BIT(1)
> -#define XBAR_AHB_BURST_EN      BIT(2)
> -
> -#define xbar_w32(x, y) ltq_w32((x), ltq_xbar_membase + (y))
> -#define xbar_r32(x)    ltq_r32(ltq_xbar_membase + (x))
> -
>  static void __iomem *pmu_membase;
> -static void __iomem *ltq_xbar_membase;
>  void __iomem *ltq_cgu_membase;
>  void __iomem *ltq_ebu_membase;
>
> @@ -293,16 +285,6 @@ static void pci_ext_disable(struct clk *clk)
>         ltq_cgu_w32((1 << 31) | (1 << 30), pcicr);
>  }
>
> -static void xbar_fpi_burst_disable(void)
> -{
> -       u32 reg;
> -
> -       /* bit 1 as 1 --burst; bit 1 as 0 -- single */
> -       reg = xbar_r32(XBAR_ALWAYS_LAST);
> -       reg &= ~XBAR_FPI_BURST_EN;
> -       xbar_w32(reg, XBAR_ALWAYS_LAST);
> -}
> -
>  /* enable a clockout source */
>  static int clkout_enable(struct clk *clk)
>  {
> @@ -459,26 +441,6 @@ void __init ltq_soc_init(void)
>         if (!pmu_membase || !ltq_cgu_membase || !ltq_ebu_membase)
>                 panic("Failed to remap core resources");
>
> -       if (of_machine_is_compatible("lantiq,vr9")) {
> -               struct resource res_xbar;
> -               struct device_node *np_xbar =
> -                               of_find_compatible_node(NULL, NULL,
> -                                                       "lantiq,xbar-xway");
> -
> -               if (!np_xbar)
> -                       panic("Failed to load xbar nodes from devicetree");
> -               if (of_address_to_resource(np_xbar, 0, &res_xbar))
> -                       panic("Failed to get xbar resources");
> -               if (!request_mem_region(res_xbar.start, resource_size(&res_xbar),
> -                       res_xbar.name))
> -                       panic("Failed to get xbar resources");
> -
> -               ltq_xbar_membase = ioremap_nocache(res_xbar.start,
> -                                                  resource_size(&res_xbar));
> -               if (!ltq_xbar_membase)
> -                       panic("Failed to remap xbar resources");
> -       }
> -
>         /* make sure to unprotect the memory region where flash is located */
>         ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_BUSCON0) & ~EBU_WRDIS, LTQ_EBU_BUSCON0);
>
> @@ -605,7 +567,4 @@ void __init ltq_soc_init(void)
>                 clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
>                 clkdev_add_pmu("1e100400.serial", NULL, 1, 0, PMU_ASC0);
>         }
> -
> -       if (of_machine_is_compatible("lantiq,vr9"))
> -               xbar_fpi_burst_disable();
>  }
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 05eae52a30b4..8775d37ac158 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -6,6 +6,7 @@ obj-y                           += bcm/
>  obj-$(CONFIG_ARCH_DOVE)                += dove/
>  obj-$(CONFIG_MACH_DOVE)                += dove/
>  obj-y                          += fsl/
> +obj-$(CONFIG_SOC_XWAY)         += lantiq/
>  obj-$(CONFIG_ARCH_MEDIATEK)    += mediatek/
>  obj-$(CONFIG_ARCH_QCOM)                += qcom/
>  obj-$(CONFIG_ARCH_RENESAS)     += renesas/
> diff --git a/drivers/soc/lantiq/Makefile b/drivers/soc/lantiq/Makefile
> new file mode 100644
> index 000000000000..7411bd23d58e
> --- /dev/null
> +++ b/drivers/soc/lantiq/Makefile
> @@ -0,0 +1 @@
> +obj-y                          += xbar.o
> diff --git a/drivers/soc/lantiq/xbar.c b/drivers/soc/lantiq/xbar.c
> new file mode 100644
> index 000000000000..dcd087817435
> --- /dev/null
> +++ b/drivers/soc/lantiq/xbar.c
> @@ -0,0 +1,100 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + *  Copyright (C) 2011-2015 John Crispin <blogic@openwrt.org>
> + *  Copyright (C) 2015 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> + */
> +
> +#include <linux/ioport.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>
> +
> +#include <lantiq_soc.h>
> +
> +#define XBAR_ALWAYS_LAST       0x430
> +#define XBAR_FPI_BURST_EN      BIT(1)
> +#define XBAR_AHB_BURST_EN      BIT(2)
> +
> +#define RCU_VR9_BE_AHB1S       0x00000008
> +
> +static int ltq_xbar_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct resource res_xbar;
> +       struct regmap *rcu_regmap;
> +       void __iomem *xbar_membase;
> +       u32 rcu_ahb_endianness_reg_offset;
> +       u32 rcu_ahb_endianness_val;
> +       int ret;
> +
> +       ret = of_address_to_resource(np, 0, &res_xbar);
> +       if (ret) {
> +               dev_err(dev, "Failed to get xbar resources");
> +               return ret;
> +       }
> +
> +       if (!devm_request_mem_region(dev, res_xbar.start,
> +                                    resource_size(&res_xbar),
> +               res_xbar.name)) {
> +               dev_err(dev, "Failed to get xbar resources");
> +               return -ENODEV;
> +       }
> +
> +       xbar_membase = devm_ioremap_nocache(dev, res_xbar.start,
> +                                               resource_size(&res_xbar));
> +       if (!xbar_membase) {
> +               dev_err(dev, "Failed to remap xbar resources");
> +               return -ENODEV;
> +       }
> +
> +       /* RCU configuration is optional */
> +       rcu_regmap = syscon_regmap_lookup_by_phandle(np, "lantiq,rcu-syscon");
> +       if (!IS_ERR_OR_NULL(rcu_regmap)) {
> +               if (of_property_read_u32_index(np, "lantiq,rcu-syscon", 1,
> +                       &rcu_ahb_endianness_reg_offset)) {
> +                       dev_err(&pdev->dev, "Failed to get RCU reg offset\n");
> +                       return -EINVAL;
> +               }
> +
> +               if (of_device_is_big_endian(np))
> +                       rcu_ahb_endianness_val = RCU_VR9_BE_AHB1S;
> +               else
> +                       rcu_ahb_endianness_val = 0;
> +
> +               if (regmap_update_bits(rcu_regmap,
> +                                       rcu_ahb_endianness_reg_offset,
> +                                       RCU_VR9_BE_AHB1S,
> +                                       rcu_ahb_endianness_val))
> +                       dev_warn(&pdev->dev,
> +                               "Failed to configure RCU AHB endianness\n");
> +       }
> +
> +       /* disable fpi burst */
> +       ltq_w32_mask(XBAR_FPI_BURST_EN, 0,
> +                    xbar_membase + XBAR_ALWAYS_LAST);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id xbar_match[] = {
> +       { .compatible = "lantiq,xbar-xway" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, xbar_match);
> +
> +static struct platform_driver xbar_driver = {
> +       .probe = ltq_xbar_probe,
> +       .driver = {
> +               .name = "xbar-xway",
> +               .of_match_table = xbar_match,
> +       },
> +};
> +
> +builtin_platform_driver(xbar_driver);
> --
> 2.11.0
>
