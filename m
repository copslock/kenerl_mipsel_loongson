Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 14:01:02 +0200 (CEST)
Received: from fllnx209.ext.ti.com ([198.47.19.16]:52580 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992466AbdHHMAvPba1G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 14:00:51 +0200
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id v78Bx6Vj027686;
        Tue, 8 Aug 2017 06:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ti.com;
        s=ti-com-17Q1; t=1502193546;
        bh=EMmDvRNckVI7C7fm837IoHf4iArdhNTvMZ8Nz95d8gQ=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=XG1qooV9DuY8CCM0FSxA/zYoXgaYjyC9eICa3M+t1chR0569UzXPWFgdmLvGUmaA/
         MPjLMSegVn9AnvHCSTXElSVbCFMgxvvR5A+NOs+nqmz9/rDrQDVV+zinbmPAxsdGLW
         142KXl3sOe8QskMAMRV5oM6JsPQ6p8mXINJE2vWc=
Received: from DLEE71.ent.ti.com (dlee71.ent.ti.com [157.170.170.114])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id v78Bx17U004818;
        Tue, 8 Aug 2017 06:59:01 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE71.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server id 14.3.294.0; Tue, 8 Aug 2017
 06:59:00 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])      by
 dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id v78Bwrqg011447;        Tue, 8 Aug
 2017 06:58:55 -0500
Subject: Re: [PATCH v8 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
To:     Hauke Mehrtens <hauke@hauke-m.de>, <ralf@linux-mips.org>
References: <20170802225717.24408-1-hauke@hauke-m.de>
 <20170802225717.24408-15-hauke@hauke-m.de>
CC:     <linux-mips@linux-mips.org>, <linux-mtd@lists.infradead.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <martin.blumenstingl@googlemail.com>, <john@phrozen.org>,
        <linux-spi@vger.kernel.org>, <hauke.mehrtens@intel.com>,
        <robh@kernel.org>, <andy.shevchenko@gmail.com>,
        <p.zabel@pengutronix.de>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <85db1866-9d8d-e7af-b193-bc329db9129b@ti.com>
Date:   Tue, 8 Aug 2017 17:28:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170802225717.24408-15-hauke@hauke-m.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <kishon@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59417
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

On Thursday 03 August 2017 04:27 AM, Hauke Mehrtens wrote:
> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
> the PHY interfaces for each core. The phy instances can be passed to the
> dwc2 driver, which already supports the generic phy interface.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  43 +++
>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>  drivers/phy/Kconfig                                |   1 +
>  drivers/phy/Makefile                               |   2 +-
>  drivers/phy/lantiq/Kconfig                         |  10 +
>  drivers/phy/lantiq/Makefile                        |   1 +
>  drivers/phy/lantiq/phy-lantiq-rcu-usb2.c           | 290 +++++++++++++++++++++
>  7 files changed, 358 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>  create mode 100644 drivers/phy/lantiq/Kconfig
>  create mode 100644 drivers/phy/lantiq/Makefile
>  create mode 100644 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> new file mode 100644
> index 000000000000..76036c5c5d11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> @@ -0,0 +1,43 @@
> +Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
> +===========================================
> +
> +This binding describes the USB PHY hardware provided by the RCU module on the
> +Lantiq XWAY SoCs.
> +
> +This driver has to be a sub node of the Lantiq RCU block.
> +
> +-------------------------------------------------------------------------------
> +Required properties (controller (parent) node):
> +- compatible	: Should be one of
> +			"lantiq,ase-usb2-phy"
> +			"lantiq,danube-usb2-phy"
> +			"lantiq,xrx100-usb2-phy"
> +			"lantiq,xrx200-usb2-phy"
> +			"lantiq,xrx300-usb2-phy"
> +- reg		: Defines the following sets of registers in the parent
> +		  syscon device
> +			- Offset of the USB PHY configuration register
> +			- Offset of the USB Analog configuration
> +			  register (only for xrx200 and xrx200)
> +- clocks	: References to the (PMU) "ctrl" and "phy" clk gates.
> +- clock-names	: Must be one of the following:
> +			"ctrl"
> +			"phy"
> +- resets	: References to the RCU USB configuration reset bits.
> +- reset-names	: Must be one of the following:
> +			"phy" (optional)
> +			"ctrl" (shared)
> +
> +-------------------------------------------------------------------------------
> +Example for the USB PHYs on an xRX200 SoC:
> +	usb_phy0: usb2-phy@18 {
> +		compatible = "lantiq,xrx200-usb2-phy";
> +		reg = <0x18 4>, <0x38 4>;
> +
> +		clocks = <&pmu PMU_GATE_USB0_CTRL>,
> +			 <&pmu PMU_GATE_USB0_PHY>;
> +		clock-names = "ctrl", "phy";
> +		resets = <&reset1 4 4>, <&reset0 4 4>;
> +		reset-names = "phy", "ctrl";
> +		#phy-cells = <0>;
> +	};

Please CC device tree list and get Ack from devicetree maintainers for this
binding. Preferable send this as a separate patch.
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index 87eab4d288e5..f76978e4da32 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
> @@ -469,8 +469,8 @@ void __init ltq_soc_init(void)
>  
>  	if (of_machine_is_compatible("lantiq,grx390") ||
>  	    of_machine_is_compatible("lantiq,ar10")) {
> -		clkdev_add_pmu("1e101000.usb", "phy", 1, 2, PMU_ANALOG_USB0_P);
> -		clkdev_add_pmu("1e106000.usb", "phy", 1, 2, PMU_ANALOG_USB1_P);
> +		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 2, PMU_ANALOG_USB0_P);
> +		clkdev_add_pmu("1f203034.usb2-phy", "phy", 1, 2, PMU_ANALOG_USB1_P);
>  		/* rc 0 */
>  		clkdev_add_pmu("1d900000.pcie", "phy", 1, 2, PMU_ANALOG_PCIE0_P);
>  		clkdev_add_pmu("1d900000.pcie", "msi", 1, 1, PMU1_PCIE_MSI);
> @@ -490,8 +490,8 @@ void __init ltq_soc_init(void)
>  		else
>  			clkdev_add_static(CLOCK_133M, CLOCK_133M,
>  						CLOCK_133M, CLOCK_133M);
> -		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
> -		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
> +		clkdev_add_pmu("1f203018.usb2-phy", "ctrl", 1, 0, PMU_USB0);
> +		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
>  		clkdev_add_pmu("1e180000.etop", "ppe", 1, 0, PMU_PPE);
>  		clkdev_add_cgu("1e180000.etop", "ephycgu", CGU_EPHY);
>  		clkdev_add_pmu("1e180000.etop", "ephy", 1, 0, PMU_EPHY);
> @@ -526,10 +526,10 @@ void __init ltq_soc_init(void)
>  	} else if (of_machine_is_compatible("lantiq,vr9")) {
>  		clkdev_add_static(ltq_vr9_cpu_hz(), ltq_vr9_fpi_hz(),
>  				ltq_vr9_fpi_hz(), ltq_vr9_pp32_hz());
> -		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
> -		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0 | PMU_AHBM);
> -		clkdev_add_pmu("1e106000.usb", "phy", 1, 0, PMU_USB1_P);
> -		clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1 | PMU_AHBM);
> +		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
> +		clkdev_add_pmu("1f203018.usb2-phy", "ctrl", 1, 0, PMU_USB0 | PMU_AHBM);
> +		clkdev_add_pmu("1f203034.usb2-phy", "phy", 1, 0, PMU_USB1_P);
> +		clkdev_add_pmu("1f203034.usb2-phy", "ctrl", 1, 0, PMU_USB1 | PMU_AHBM);
>  		clkdev_add_pmu("1d900000.pcie", "phy", 1, 1, PMU1_PCIE_PHY);
>  		clkdev_add_pmu("1d900000.pcie", "bus", 1, 0, PMU_PCIE_CLK);
>  		clkdev_add_pmu("1d900000.pcie", "msi", 1, 1, PMU1_PCIE_MSI);
> @@ -550,8 +550,8 @@ void __init ltq_soc_init(void)
>  	} else if (of_machine_is_compatible("lantiq,ar9")) {
>  		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
>  				ltq_ar9_fpi_hz(), CLOCK_250M);
> -		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
> -		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
> +		clkdev_add_pmu("1f203018.usb2-phy", "ctrl", 1, 0, PMU_USB0);
> +		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
>  		clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1);
>  		clkdev_add_pmu("1e106000.usb", "phy", 1, 0, PMU_USB1_P);
>  		clkdev_add_pmu("1e180000.etop", "switch", 1, 0, PMU_SWITCH);
> @@ -562,8 +562,8 @@ void __init ltq_soc_init(void)
>  	} else {
>  		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
>  				ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
> -		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
> -		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
> +		clkdev_add_pmu("1f203018.usb2-phy", "ctrl", 1, 0, PMU_USB0);
> +		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
>  		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
>  		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
>  		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index c1807d4a0079..968088ceaeb3 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -52,6 +52,7 @@ source "drivers/phy/allwinner/Kconfig"
>  source "drivers/phy/amlogic/Kconfig"
>  source "drivers/phy/broadcom/Kconfig"
>  source "drivers/phy/hisilicon/Kconfig"
> +source "drivers/phy/lantiq/Kconfig"
>  source "drivers/phy/marvell/Kconfig"
>  source "drivers/phy/motorola/Kconfig"
>  source "drivers/phy/qualcomm/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index f252201e0ec9..a8b9439a5d8e 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -7,9 +7,9 @@ obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
>  obj-$(CONFIG_PHY_MT65XX_USB3)		+= phy-mt65xx-usb3.o
>  obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
>  obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
> -
>  obj-$(CONFIG_ARCH_SUNXI)		+= allwinner/
>  obj-$(CONFIG_ARCH_MESON)		+= amlogic/
> +obj-$(CONFIG_LANTIQ)			+= lantiq/
>  obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
>  obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
>  obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
> diff --git a/drivers/phy/lantiq/Kconfig b/drivers/phy/lantiq/Kconfig
> new file mode 100644
> index 000000000000..a2d5006b3dc7
> --- /dev/null
> +++ b/drivers/phy/lantiq/Kconfig
> @@ -0,0 +1,10 @@
> +#
> +# Phy drivers for Lantiq / Intel platforms
> +#
> +config PHY_LANTIQ_RCU_USB2
> +	tristate "Lantiq XWAY SoC RCU based USB PHY"
> +	depends on SOC_TYPE_XWAY

depends on COMPILE_TEST..
> +	depends on OF
> +	select GENERIC_PHY
> +	help
> +	  Support for the USB PHY(s) on the Lantiq / Intel XWAY family SoCs.
> diff --git a/drivers/phy/lantiq/Makefile b/drivers/phy/lantiq/Makefile
> new file mode 100644
> index 000000000000..f73eb56a5416
> --- /dev/null
> +++ b/drivers/phy/lantiq/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_PHY_LANTIQ_RCU_USB2)	+= phy-lantiq-rcu-usb2.o
> diff --git a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
> new file mode 100644
> index 000000000000..8f5687737b50
> --- /dev/null
> +++ b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
> @@ -0,0 +1,290 @@
> +/*
> + * Lantiq XWAY SoC RCU module based USB 1.1/2.0 PHY driver
> + *
> + * Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> + * Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +/* Transmitter HS Pre-Emphasis Enable */
> +#define RCU_CFG1_TX_PEE		BIT(0)
> +/* Disconnect Threshold */
> +#define RCU_CFG1_DIS_THR_MASK	0x00038000
> +#define RCU_CFG1_DIS_THR_SHIFT	15
> +
> +struct ltq_rcu_usb2_bits {
> +	u8 hostmode;
> +	u8 slave_endianness;
> +	u8 host_endianness;
> +	bool have_ana_cfg;
> +};
> +
> +struct ltq_rcu_usb2_priv {
> +	struct regmap			*regmap;
> +	unsigned int			phy_reg_offset;
> +	unsigned int			ana_cfg1_reg_offset;
> +	const struct ltq_rcu_usb2_bits	*reg_bits;
> +	struct device			*dev;
> +	struct phy			*phy;
> +	struct clk			*ctrl_gate_clk;
> +	struct clk			*phy_gate_clk;
> +	struct reset_control		*ctrl_reset;
> +	struct reset_control		*phy_reset;
> +};
> +
> +static const struct ltq_rcu_usb2_bits xway_rcu_usb2_reg_bits = {
> +	.hostmode = 11,
> +	.slave_endianness = 9,
> +	.host_endianness = 10,
> +	.have_ana_cfg = false,
> +};
> +
> +static const struct ltq_rcu_usb2_bits xrx100_rcu_usb2_reg_bits = {
> +	.hostmode = 11,
> +	.slave_endianness = 17,
> +	.host_endianness = 10,
> +	.have_ana_cfg = false,
> +};
> +
> +static const struct ltq_rcu_usb2_bits xrx200_rcu_usb2_reg_bits = {
> +	.hostmode = 11,
> +	.slave_endianness = 9,
> +	.host_endianness = 10,
> +	.have_ana_cfg = true,
> +};
> +
> +static const struct of_device_id ltq_rcu_usb2_phy_of_match[] = {
> +	{
> +		.compatible = "lantiq,ase-usb2-phy",
> +		.data = &xway_rcu_usb2_reg_bits,
> +	},
> +	{
> +		.compatible = "lantiq,danube-usb2-phy",
> +		.data = &xway_rcu_usb2_reg_bits,
> +	},
> +	{
> +		.compatible = "lantiq,xrx100-usb2-phy",
> +		.data = &xrx100_rcu_usb2_reg_bits,
> +	},
> +	{
> +		.compatible = "lantiq,xrx200-usb2-phy",
> +		.data = &xrx200_rcu_usb2_reg_bits,
> +	},
> +	{
> +		.compatible = "lantiq,xrx300-usb2-phy",
> +		.data = &xrx200_rcu_usb2_reg_bits,
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ltq_rcu_usb2_phy_of_match);
> +
> +
spurious blank line..
> +static int ltq_rcu_usb2_phy_power_on(struct phy *phy)
> +{
> +	struct ltq_rcu_usb2_priv *priv = phy_get_drvdata(phy);
> +
> +	reset_control_deassert(priv->phy_reset);
> +
> +	return 0;
> +}
> +
> +static int ltq_rcu_usb2_phy_power_off(struct phy *phy)
> +{
> +	struct ltq_rcu_usb2_priv *priv = phy_get_drvdata(phy);
> +
> +	reset_control_assert(priv->phy_reset);
> +
> +	return 0;
> +}
> +
> +static struct phy_ops ltq_rcu_usb2_phy_ops = {
> +	.power_on	= ltq_rcu_usb2_phy_power_on,
> +	.power_off	= ltq_rcu_usb2_phy_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int ltq_rcu_usb2_start_cores(struct ltq_rcu_usb2_priv *priv)
> +{
> +	struct device *dev = priv->dev;
> +	int ret;
> +
> +	/* Power on the USB core. */
> +	ret = clk_prepare_enable(priv->ctrl_gate_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable CTRL gate\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Power on the USB PHY. We have to do it early because
> +	 * otherwise the second core won't turn on properly.
> +	 */
> +	ret = clk_prepare_enable(priv->phy_gate_clk);
> +	if (ret) {
> +		clk_disable_unprepare(priv->ctrl_gate_clk);
> +		dev_err(dev, "failed to enable PHY gate\n");
> +		return ret;
> +	}

why are these not part of power_on callback?
> +
> +	if (priv->reg_bits->have_ana_cfg) {
> +		regmap_update_bits(priv->regmap, priv->ana_cfg1_reg_offset,
> +			RCU_CFG1_TX_PEE, RCU_CFG1_TX_PEE);
> +		regmap_update_bits(priv->regmap, priv->ana_cfg1_reg_offset,
> +			RCU_CFG1_DIS_THR_MASK, 7 << RCU_CFG1_DIS_THR_SHIFT);
> +	}
> +
> +	/* Configure core to host mode */
> +	regmap_update_bits(priv->regmap, priv->phy_reg_offset,
> +			   BIT(priv->reg_bits->hostmode), 0);
> +
> +	/* Select DMA endianness (Host-endian: big-endian) */
> +	regmap_update_bits(priv->regmap, priv->phy_reg_offset,
> +		BIT(priv->reg_bits->slave_endianness), 0);
> +	regmap_update_bits(priv->regmap, priv->phy_reg_offset,
> +		BIT(priv->reg_bits->host_endianness),
> +		BIT(priv->reg_bits->host_endianness));

All this can be phy_init?
> +
> +	/* Reset USB core throgh reset controller */
> +	reset_control_deassert(priv->ctrl_reset);
> +
> +	reset_control_assert(priv->phy_reset);
> +
> +	return 0;
> +}
> +
> +static int ltq_rcu_usb2_of_probe(struct ltq_rcu_usb2_priv *priv,
> +				 struct platform_device *pdev)

%s/ltq_rcu_usb2_of_probe/ltq_rcu_usb2_of_parse
> +{
> +	struct device *dev = priv->dev;
> +	struct resource *res;
> +	struct resource res_parent;
> +	int ret;
> +
> +	priv->reg_bits = of_device_get_match_data(dev);
> +
> +	priv->regmap = syscon_node_to_regmap(dev->of_node->parent);
> +	if (IS_ERR(priv->regmap)) {
> +		dev_err(dev, "Failed to lookup RCU regmap\n");
> +		return PTR_ERR(priv->regmap);
> +	}
> +
> +	ret = of_address_to_resource(dev->of_node->parent, 0, &res_parent);
> +	if (ret)
> +		return ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "Failed to get RCU PHY reg offset\n");
> +		return ret;
> +	}
> +
> +	if (res->start < res_parent.start)
> +		return -ENOENT;
> +	priv->phy_reg_offset = res->start - res_parent.start;

I think you can simple use of_get_address() to get the offset.

Thanks
Kishon
