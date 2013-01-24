Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 13:27:47 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:54461 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6833436Ab3AXM1otlde0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2013 13:27:44 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 1897B25BAA4;
        Thu, 24 Jan 2013 13:27:38 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1H92vHYBbJgS; Thu, 24 Jan 2013 13:27:38 +0100 (CET)
Received: from [127.0.0.1] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPSA id C85E425BAA6;
        Thu, 24 Jan 2013 13:27:37 +0100 (CET)
Message-ID: <510128C5.4050205@openwrt.org>
Date:   Thu, 24 Jan 2013 13:27:49 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC 09/11] MIPS: ralink: adds support for RT305x SoC family
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org> <1358942755-25371-10-git-send-email-blogic@openwrt.org>
In-Reply-To: <1358942755-25371-10-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Antivirus: avast! (VPS 130124-0, 2013.01.24), Outbound message
X-Antivirus-Status: Clean
X-archive-position: 35536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

2013.01.23. 13:05 keltezéssel, John Crispin írta:
> Add support code for rt3050, rt3052, rt3350, rt3352 and rt5350 SOC.
> 
> The code detects the SoC and registers the clk / pinmux settings.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/include/asm/mach-ralink/rt305x.h |  139 +++++++++++++++++
>  arch/mips/ralink/rt305x.c                  |  231 ++++++++++++++++++++++++++++
>  2 files changed, 370 insertions(+)
>  create mode 100644 arch/mips/include/asm/mach-ralink/rt305x.h
>  create mode 100644 arch/mips/ralink/rt305x.c

<...>

> diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
> new file mode 100644
> index 0000000..23ea087
> --- /dev/null
> +++ b/arch/mips/ralink/rt305x.c
> @@ -0,0 +1,231 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + *
> + * Parts of this file are based on Ralink's 2.6.21 BSP
> + *
> + * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
> + * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>

It seems that you forgot to add your copyright notice here.

> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +
> +#include <asm/mipsregs.h>
> +#include <asm/mach-ralink/ralink_regs.h>
> +#include <asm/mach-ralink/rt305x.h>
> +
> +#include "common.h"
> +
> +enum rt305x_soc_type rt305x_soc;
> +
> +struct ralink_pinmux_grp mode_mux[] = {
> +	{
> +		.name = "i2c",
> +		.mask = RT305X_GPIO_MODE_I2C,
> +		.gpio_first = RT305X_GPIO_I2C_SD,
> +		.gpio_last = RT305X_GPIO_I2C_SCLK,
> +	}, {
> +		.name = "spi",
> +		.mask = RT305X_GPIO_MODE_SPI,
> +		.gpio_first = RT305X_GPIO_SPI_EN,
> +		.gpio_last = RT305X_GPIO_SPI_CLK,
> +	}, {
> +		.name = "uartlite",
> +		.mask = RT305X_GPIO_MODE_UART1,
> +		.gpio_first = RT305X_GPIO_UART1_TXD,
> +		.gpio_last = RT305X_GPIO_UART1_RXD,
> +	}, {
> +		.name = "jtag",
> +		.mask = RT305X_GPIO_MODE_JTAG,
> +		.gpio_first = RT305X_GPIO_JTAG_TDO,
> +		.gpio_last = RT305X_GPIO_JTAG_TDI,
> +	}, {
> +		.name = "mdio",
> +		.mask = RT305X_GPIO_MODE_MDIO,
> +		.gpio_first = RT305X_GPIO_MDIO_MDC,
> +		.gpio_last = RT305X_GPIO_MDIO_MDIO,
> +	}, {
> +		.name = "sdram",
> +		.mask = RT305X_GPIO_MODE_SDRAM,
> +		.gpio_first = RT305X_GPIO_SDRAM_MD16,
> +		.gpio_last = RT305X_GPIO_SDRAM_MD31,
> +	}, {
> +		.name = "rgmii",
> +		.mask = RT305X_GPIO_MODE_RGMII,
> +		.gpio_first = RT305X_GPIO_GE0_TXD0,
> +		.gpio_last = RT305X_GPIO_GE0_RXCLK,
> +	}, {0}
> +};
> +
> +struct ralink_pinmux_grp uart_mux[] = {
> +	{
> +		.name = "uartf",
> +		.mask = RT305X_GPIO_MODE_UARTF,
> +		.gpio_first = RT305X_GPIO_7,
> +		.gpio_last = RT305X_GPIO_14,
> +	}, {
> +		.name = "pcm uartf",
> +		.mask = RT305X_GPIO_MODE_PCM_UARTF,
> +		.gpio_first = RT305X_GPIO_7,
> +		.gpio_last = RT305X_GPIO_14,
> +	}, {
> +		.name = "pcm i2s",
> +		.mask = RT305X_GPIO_MODE_PCM_I2S,
> +		.gpio_first = RT305X_GPIO_7,
> +		.gpio_last = RT305X_GPIO_14,
> +	}, {
> +		.name = "i2s uartf",
> +		.mask = RT305X_GPIO_MODE_I2S_UARTF,
> +		.gpio_first = RT305X_GPIO_7,
> +		.gpio_last = RT305X_GPIO_14,
> +	}, {
> +		.name = "pcm gio",

s/gio/gpio/

> +		.mask = RT305X_GPIO_MODE_PCM_GPIO,
> +		.gpio_first = RT305X_GPIO_10,
> +		.gpio_last = RT305X_GPIO_14,
> +	}, {
> +		.name = "gpio uartf",
> +		.mask = RT305X_GPIO_MODE_GPIO_UARTF,
> +		.gpio_first = RT305X_GPIO_7,
> +		.gpio_last = RT305X_GPIO_14,
> +	}, {
> +		.name = "gpio i2s",
> +		.mask = RT305X_GPIO_MODE_GPIO_I2S,
> +		.gpio_first = RT305X_GPIO_7,
> +		.gpio_last = RT305X_GPIO_14,
> +	}, {
> +		.name = "gpio",
> +		.mask = RT305X_GPIO_MODE_GPIO,
> +	}, {0}
> +};
> +

<...>

> +
> +void prom_soc_init(struct ralink_soc_info *soc_info)
> +{
> +	void __iomem *sysc = (void __iomem *) KSEG1ADDR(RT305X_SYSC_BASE);
> +	u32 n0;
> +	u32 n1;
> +	u32 id;
> +
> +	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
> +	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
> +
> +	if (n0 == RT3052_CHIP_NAME0 && n1 == RT3052_CHIP_NAME1) {
> +		unsigned long icache_sets;
> +
> +		icache_sets = (read_c0_config1() >> 22) & 7;
> +		if (icache_sets == 1) {
> +			rt305x_soc = RT305X_SOC_RT3050;
> +			soc_info->name = "RT3050";
> +			soc_info->compatible = "ralink,rt3050";
> +		} else {
> +			rt305x_soc = RT305X_SOC_RT3052;
> +			soc_info->name = "RT3052";
> +			soc_info->compatible = "ralink,rt3052";
> +		}
> +	} else if (n0 == RT3350_CHIP_NAME0 && n1 == RT3350_CHIP_NAME1) {
> +		rt305x_soc = RT305X_SOC_RT3350;
> +		soc_info->name = "RT3350";
> +		soc_info->compatible = "ralink,rt3250";

I guess that the compatible strig should be "ralink,rt3350"?

> +	} else if (n0 == RT3352_CHIP_NAME0 && n1 == RT3352_CHIP_NAME1) {
> +		rt305x_soc = RT305X_SOC_RT3352;
> +		soc_info->name = "RT3352";
> +		soc_info->compatible = "ralink,rt3352";
> +	} else if (n0 == RT5350_CHIP_NAME0 && n1 == RT5350_CHIP_NAME1) {
> +		rt305x_soc = RT305X_SOC_RT5350;
> +		soc_info->name = "RT5350";
> +		soc_info->compatible = "ralink,rt5350";
> +	} else {
> +		panic("rt305x: unknown SoC, n0:%08x n1:%08x\n", n0, n1);
> +	}
> +
> +	id = __raw_readl(sysc + SYSC_REG_CHIP_ID);
> +
> +	snprintf(soc_info->sys_type, RAMIPS_SYS_TYPE_LEN,
> +		"Ralink %s id:%u rev:%u",
> +		soc_info->name,

I might be wrong, but it seems that the soc_info->name field is only used by
this code. If that is the case, it should be removed from the structure and you
can use a local variable here instead.

> +		(id >> CHIP_ID_ID_SHIFT) & CHIP_ID_ID_MASK,
> +		(id & CHIP_ID_REV_MASK));
> +}
> 

-Gabor
