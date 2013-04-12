Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 13:11:45 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:35132 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816206Ab3DLLLnhDm3p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 13:11:43 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pxfHfNAMAq67; Fri, 12 Apr 2013 13:10:55 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id A2CE3280520;
        Fri, 12 Apr 2013 13:10:55 +0200 (CEST)
Message-ID: <5167EC0A.8020003@openwrt.org>
Date:   Fri, 12 Apr 2013 13:12:10 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 09/16] MIPS: ralink: adds support for RT2880 SoC family
References: <1365751663-5725-1-git-send-email-blogic@openwrt.org> <1365751663-5725-9-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365751663-5725-9-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36110
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

2013.04.12. 9:27 keltezéssel, John Crispin írta:
> Add support code for rt2880 SOC.
> 
> The code detects the SoC and registers the clk / pinmux settings.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/Kconfig                          |    2 +-
>  arch/mips/include/asm/mach-ralink/rt288x.h |   49 ++++++++++
>  arch/mips/ralink/Kconfig                   |    3 +
>  arch/mips/ralink/Makefile                  |    1 +
>  arch/mips/ralink/Platform                  |    5 +
>  arch/mips/ralink/rt288x.c                  |  143 ++++++++++++++++++++++++++++
>  6 files changed, 202 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/include/asm/mach-ralink/rt288x.h
>  create mode 100644 arch/mips/ralink/rt288x.c
> 

<...>

> diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
> new file mode 100644
> index 0000000..8f3a0fa
> --- /dev/null
> +++ b/arch/mips/ralink/rt288x.c
> @@ -0,0 +1,143 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + *
> + * Parts of this file are based on Ralink's 2.6.21 BSP
> + *
> + * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
> + * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
> + * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +
> +#include <asm/mipsregs.h>
> +#include <asm/mach-ralink/ralink_regs.h>
> +#include <asm/mach-ralink/rt288x.h>
> +
> +#include "common.h"
> +
> +struct ralink_pinmux_grp mode_mux[] = {
> +	{
> +		.name = "i2c",
> +		.mask = RT2880_GPIO_MODE_I2C,
> +		.gpio_first = 1,
> +		.gpio_last = 2,
> +	}, {
> +		.name = "spi",
> +		.mask = RT2880_GPIO_MODE_SPI,
> +		.gpio_first = 3,
> +		.gpio_last = 6,
> +	}, {
> +		.name = "uartlite",
> +		.mask = RT2880_GPIO_MODE_UART0,
> +		.gpio_first = 7,
> +		.gpio_last = 14,
> +	}, {
> +		.name = "jtag",
> +		.mask = RT2880_GPIO_MODE_JTAG,
> +		.gpio_first = 17,
> +		.gpio_last = 21,
> +	}, {
> +		.name = "mdio",
> +		.mask = RT2880_GPIO_MODE_MDIO,
> +		.gpio_first = 22,
> +		.gpio_last = 23,
> +	}, {
> +		.name = "sdram",
> +		.mask = RT2880_GPIO_MODE_SDRAM,
> +		.gpio_first = 24,
> +		.gpio_last = 39,
> +	}, {
> +		.name = "pci",
> +		.mask = RT2880_GPIO_MODE_PCI,
> +		.gpio_first = 40,
> +		.gpio_last = 71,
> +	}, {0}
> +};
> +
> +void rt288x_wdt_reset(void)
> +{
> +	u32 t;
> +
> +	/* enable WDT reset output on pin SRAM_CS_N */
> +	t = rt_sysc_r32(SYSC_REG_CLKCFG);
> +	t |= CLKCFG_SRAM_CS_N_WDT;
> +	rt_sysc_w32(t, SYSC_REG_CLKCFG);
> +}
> +
> +struct ralink_pinmux rt_pinmux = {
> +	.mode = mode_mux,
> +	.wdt_reset = rt288x_wdt_reset,
> +};

The commit log says that the code registers the pinmux settings. However the
patch only contains the definitions of the pinmux groups without doing anything
with those. Additionally, the structures and the 'rt288x_wdt_reset' function
should be static.

However converting them to static would cause compiler warnings about unused
variables/functions. So it would be simpler to remove these. You have removed
the pinmux driver from the series anyway, and this part can't be used without that.

> +void ralink_usb_platform(void)
> +{
> +}

This is also an unused function.

> +
> +void __init ralink_clk_init(void)
> +{
> +	unsigned long cpu_rate;
> +	u32 t = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG);
> +	t = ((t >> SYSTEM_CONFIG_CPUCLK_SHIFT) & SYSTEM_CONFIG_CPUCLK_MASK);
> +
> +	switch (t) {
> +	case SYSTEM_CONFIG_CPUCLK_250:
> +		cpu_rate = 250000000;
> +		break;
> +	case SYSTEM_CONFIG_CPUCLK_266:
> +		cpu_rate = 266666667;
> +		break;
> +	case SYSTEM_CONFIG_CPUCLK_280:
> +		cpu_rate = 280000000;
> +		break;
> +	case SYSTEM_CONFIG_CPUCLK_300:
> +		cpu_rate = 300000000;
> +		break;
> +	}
> +
> +	ralink_clk_add("cpu", cpu_rate);
> +	ralink_clk_add("300100.timer", cpu_rate / 2);
> +	ralink_clk_add("300120.watchdog", cpu_rate / 2);
> +	ralink_clk_add("300500.uart", cpu_rate / 2);
> +	ralink_clk_add("300c00.uartlite", cpu_rate / 2);
> +	ralink_clk_add("400000.ethernet", cpu_rate / 2);
> +}
> +
> +void __init ralink_of_remap(void)
> +{
> +	rt_sysc_membase = plat_of_remap_node("ralink,rt2880-sysc");
> +	rt_memc_membase = plat_of_remap_node("ralink,rt2880-memc");
> +
> +	if (!rt_sysc_membase || !rt_memc_membase)
> +		panic("Failed to remap core resources");
> +}
> +
> +void prom_soc_init(struct ralink_soc_info *soc_info)
> +{
> +	void __iomem *sysc = (void __iomem *) KSEG1ADDR(RT2880_SYSC_BASE);
> +	const char *name;
> +	u32 n0;
> +	u32 n1;
> +	u32 id;
> +
> +	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
> +	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
> +	id = __raw_readl(sysc + SYSC_REG_CHIP_ID);
> +
> +	if (n0 == RT2880_CHIP_NAME0 && n1 == RT2880_CHIP_NAME1) {
> +		soc_info->compatible = "ralink,r2880-soc";
> +		name = "RT2880";
> +	} else {
> +		panic("rt288x: unknown SoC, n0:%08x n1:%08x", n0, n1);
> +	}
> +
> +	snprintf(soc_info->sys_type, RAMIPS_SYS_TYPE_LEN,
> +		"Ralink %s id:%u rev:%u",
> +		name,
> +		(id >> CHIP_ID_ID_SHIFT) & CHIP_ID_ID_MASK,
> +		(id & CHIP_ID_REV_MASK));
> +}
> 
