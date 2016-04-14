Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2016 07:53:28 +0200 (CEST)
Received: from devils.ext.ti.com ([198.47.26.153]:51796 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007321AbcDNFxX5TVF6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Apr 2016 07:53:23 +0200
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id u3E5r3iY021733;
        Thu, 14 Apr 2016 00:53:03 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id u3E5r24U027282;
        Thu, 14 Apr 2016 00:53:02 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE72.ent.ti.com
 (128.247.5.109) with Microsoft SMTP Server id 14.3.224.2; Thu, 14 Apr 2016
 00:53:02 -0500
Received: from [172.24.190.114] (ileax41-snat.itg.ti.com [10.172.224.153])      by
 dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id u3E5qwTI005097;        Thu, 14 Apr
 2016 00:52:59 -0500
Subject: Re: [PATCH v2 1/5] phy: Add a driver for simple phy
To:     Alban Bedel <albeu@free.fr>, <linux-mips@linux-mips.org>
References: <1447708924-15076-1-git-send-email-albeu@free.fr>
 <1447708924-15076-2-git-send-email-albeu@free.fr>
CC:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <570F303A.6030605@ti.com>
Date:   Thu, 14 Apr 2016 11:22:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1447708924-15076-2-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <kishon@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kishon@ti.com
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

Hi,

On Tuesday 17 November 2015 02:52 AM, Alban Bedel wrote:
> This driver is meant to take care of all trivial phys that don't need
> any special configuration, it just enable a regulator, a clock and
> deassert a reset. A public API is also included to allow re-using the
> code in other drivers.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  drivers/phy/Kconfig        |  12 +++
>  drivers/phy/Makefile       |   1 +
>  drivers/phy/phy-simple.c   | 204 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/phy/simple.h |  39 +++++++++
>  4 files changed, 256 insertions(+)
>  create mode 100644 drivers/phy/phy-simple.c
>  create mode 100644 include/linux/phy/simple.h
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 7eb5859d..028fb16 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -118,6 +118,18 @@ config PHY_RCAR_GEN2
>  	help
>  	  Support for USB PHY found on Renesas R-Car generation 2 SoCs.
>  
> +config PHY_SIMPLE
> +	tristate
> +	select GENERIC_PHY
> +	help
> +
> +config PHY_SIMPLE_PDEV

Where will this config be used? Why do we need two configs for a single driver?
> +	tristate "Simple PHY driver"
> +	select PHY_SIMPLE
> +	help
> +	  A PHY driver for simple devices that only need a regulator, clock
> +	  and reset for power up and shutdown.
> +
>  config OMAP_CONTROL_PHY
>  	tristate "OMAP CONTROL PHY Driver"
>  	depends on ARCH_OMAP2PLUS || COMPILE_TEST
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 075db1a..1a44362 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
>  obj-$(CONFIG_PHY_EXYNOS5250_SATA)	+= phy-exynos5250-sata.o
>  obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
>  obj-$(CONFIG_PHY_MT65XX_USB3)		+= phy-mt65xx-usb3.o
> +obj-$(CONFIG_PHY_SIMPLE)		+= phy-simple.o
>  obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
>  obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
>  obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
> diff --git a/drivers/phy/phy-simple.c b/drivers/phy/phy-simple.c
> new file mode 100644
> index 0000000..013f846
> --- /dev/null
> +++ b/drivers/phy/phy-simple.c
> @@ -0,0 +1,204 @@
> +/*
> + * Copyright (C) 2015 Alban Bedel <albeu@free.fr>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/simple.h>
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +
> +int simple_phy_power_on(struct phy *phy)
> +{
> +	struct simple_phy *sphy = phy_get_drvdata(phy);
> +	int err;
> +
> +	if (sphy->regulator) {
> +		err = regulator_enable(sphy->regulator);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (sphy->clk) {
> +		err = clk_prepare_enable(sphy->clk);
> +		if (err)
> +			goto regulator_disable;
> +	}
> +
> +	if (sphy->reset) {
> +		err = reset_control_deassert(sphy->reset);
> +		if (err)
> +			goto clock_disable;
> +	}
> +
> +	return 0;
> +
> +clock_disable:
> +	if (sphy->clk)
> +		clk_disable_unprepare(sphy->clk);
> +regulator_disable:
> +	if (sphy->regulator)
> +		WARN_ON(regulator_disable(sphy->regulator));
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(simple_phy_power_on);

IMO simple-phy driver should be an independent driver and shouldn't export
symbols. The dt binding for the simple phy device should be something like
below where all the properties of the simple phy device should be in the
binding documentation.
usbphy {
	compatible = "simple-phy";
	phy-supply = <&supply>;
	clocks = <&clock>;
	reset = <&reset>;
};

Anything that needs more than this shouldn't be a simple phy.

Thanks
Kishon
