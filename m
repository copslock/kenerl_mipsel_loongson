Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 13:12:41 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:35353 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816206Ab3DLLMjAqSoa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 13:12:39 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JWXmBDkcp5BP; Fri, 12 Apr 2013 13:11:52 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 04C82280520;
        Fri, 12 Apr 2013 13:11:51 +0200 (CEST)
Message-ID: <5167EC42.2060009@openwrt.org>
Date:   Fri, 12 Apr 2013 13:13:06 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 11/16] MIPS: ralink: adds support for RT3883 SoC family
References: <1365751663-5725-1-git-send-email-blogic@openwrt.org> <1365751663-5725-11-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365751663-5725-11-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36111
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
> Add support code for rt3883 SOC.
> 
> The code detects the SoC and registers the clk / pinmux settings.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/include/asm/mach-ralink/rt3883.h |  247 ++++++++++++++++++++++++++++
>  arch/mips/ralink/Kconfig                   |    5 +
>  arch/mips/ralink/Makefile                  |    1 +
>  arch/mips/ralink/Platform                  |    5 +
>  arch/mips/ralink/rt3883.c                  |  244 +++++++++++++++++++++++++++
>  5 files changed, 502 insertions(+)
>  create mode 100644 arch/mips/include/asm/mach-ralink/rt3883.h
>  create mode 100644 arch/mips/ralink/rt3883.c

<...>

> diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
> new file mode 100644
> index 0000000..701c9fd
> --- /dev/null
> +++ b/arch/mips/ralink/rt3883.c
> @@ -0,0 +1,244 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + *
> + * Parts of this file are based on Ralink's 2.6.21 BSP
> + *
> + * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
> + * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
> + * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +
> +#include <asm/mipsregs.h>
> +#include <asm/mach-ralink/ralink_regs.h>
> +#include <asm/mach-ralink/rt3883.h>
> +
> +#include "common.h"
> +
> +struct ralink_pinmux_grp mode_mux[] = {
> +	{
> +		.name = "i2c",
> +		.mask = RT3883_GPIO_MODE_I2C,
> +		.gpio_first = RT3883_GPIO_I2C_SD,
> +		.gpio_last = RT3883_GPIO_I2C_SCLK,
> +	}, {
> +		.name = "spi",
> +		.mask = RT3883_GPIO_MODE_SPI,
> +		.gpio_first = RT3883_GPIO_SPI_CS0,
> +		.gpio_last = RT3883_GPIO_SPI_MISO,
> +	}, {
> +		.name = "uartlite",
> +		.mask = RT3883_GPIO_MODE_UART1,
> +		.gpio_first = RT3883_GPIO_UART1_TXD,
> +		.gpio_last = RT3883_GPIO_UART1_RXD,
> +	}, {
> +		.name = "jtag",
> +		.mask = RT3883_GPIO_MODE_JTAG,
> +		.gpio_first = RT3883_GPIO_JTAG_TDO,
> +		.gpio_last = RT3883_GPIO_JTAG_TCLK,
> +	}, {
> +		.name = "mdio",
> +		.mask = RT3883_GPIO_MODE_MDIO,
> +		.gpio_first = RT3883_GPIO_MDIO_MDC,
> +		.gpio_last = RT3883_GPIO_MDIO_MDIO,
> +	}, {
> +		.name = "ge1",
> +		.mask = RT3883_GPIO_MODE_GE1,
> +		.gpio_first = RT3883_GPIO_GE1_TXD0,
> +		.gpio_last = RT3883_GPIO_GE1_RXCLK,
> +	}, {
> +		.name = "ge2",
> +		.mask = RT3883_GPIO_MODE_GE2,
> +		.gpio_first = RT3883_GPIO_GE2_TXD0,
> +		.gpio_last = RT3883_GPIO_GE2_RXCLK,
> +	}, {
> +		.name = "pci",
> +		.mask = RT3883_GPIO_MODE_PCI,
> +		.gpio_first = RT3883_GPIO_PCI_AD0,
> +		.gpio_last = RT3883_GPIO_PCI_AD31,
> +	}, {
> +		.name = "lna a",
> +		.mask = RT3883_GPIO_MODE_LNA_A,
> +		.gpio_first = RT3883_GPIO_LNA_PE_A0,
> +		.gpio_last = RT3883_GPIO_LNA_PE_A2,
> +	}, {
> +		.name = "lna g",
> +		.mask = RT3883_GPIO_MODE_LNA_G,
> +		.gpio_first = RT3883_GPIO_LNA_PE_G0,
> +		.gpio_last = RT3883_GPIO_LNA_PE_G2,
> +	}, {0}
> +};
> +
> +struct ralink_pinmux_grp uart_mux[] = {
> +	{
> +		.name = "uartf",
> +		.mask = RT3883_GPIO_MODE_UARTF,
> +		.gpio_first = RT3883_GPIO_7,
> +		.gpio_last = RT3883_GPIO_14,
> +	}, {
> +		.name = "pcm uartf",
> +		.mask = RT3883_GPIO_MODE_PCM_UARTF,
> +		.gpio_first = RT3883_GPIO_7,
> +		.gpio_last = RT3883_GPIO_14,
> +	}, {
> +		.name = "pcm i2s",
> +		.mask = RT3883_GPIO_MODE_PCM_I2S,
> +		.gpio_first = RT3883_GPIO_7,
> +		.gpio_last = RT3883_GPIO_14,
> +	}, {
> +		.name = "i2s uartf",
> +		.mask = RT3883_GPIO_MODE_I2S_UARTF,
> +		.gpio_first = RT3883_GPIO_7,
> +		.gpio_last = RT3883_GPIO_14,
> +	}, {
> +		.name = "pcm gpio",
> +		.mask = RT3883_GPIO_MODE_PCM_GPIO,
> +		.gpio_first = RT3883_GPIO_10,
> +		.gpio_last = RT3883_GPIO_14,
> +	}, {
> +		.name = "gpio uartf",
> +		.mask = RT3883_GPIO_MODE_GPIO_UARTF,
> +		.gpio_first = RT3883_GPIO_7,
> +		.gpio_last = RT3883_GPIO_14,
> +	}, {
> +		.name = "gpio i2s",
> +		.mask = RT3883_GPIO_MODE_GPIO_I2S,
> +		.gpio_first = RT3883_GPIO_7,
> +		.gpio_last = RT3883_GPIO_14,
> +	}, {
> +		.name = "gpio",
> +		.mask = RT3883_GPIO_MODE_GPIO,
> +		.gpio_first = RT3883_GPIO_7,
> +		.gpio_last = RT3883_GPIO_14,
> +	}, {0}
> +};
> +
> +struct ralink_pinmux_grp pci_mux[] = {
> +	{
> +		.name = "pci-dev",
> +		.mask = 0,
> +		.gpio_first = RT3883_GPIO_PCI_AD0,
> +		.gpio_last = RT3883_GPIO_PCI_AD31,
> +	}, {
> +		.name = "pci-host2",
> +		.mask = 1,
> +		.gpio_first = RT3883_GPIO_PCI_AD0,
> +		.gpio_last = RT3883_GPIO_PCI_AD31,
> +	}, {
> +		.name = "pci-host1",
> +		.mask = 2,
> +		.gpio_first = RT3883_GPIO_PCI_AD0,
> +		.gpio_last = RT3883_GPIO_PCI_AD31,
> +	}, {
> +		.name = "pci-fnc",
> +		.mask = 3,
> +		.gpio_first = RT3883_GPIO_PCI_AD0,
> +		.gpio_last = RT3883_GPIO_PCI_AD31,
> +	}, {
> +		.name = "pci-gpio",
> +		.mask = 7,
> +		.gpio_first = RT3883_GPIO_PCI_AD0,
> +		.gpio_last = RT3883_GPIO_PCI_AD31,
> +	}, {0}
> +};
> +
> +static void rt3883_wdt_reset(void)
> +{
> +	u32 t;
> +
> +	/* enable WDT reset output on GPIO 2 */
> +	t = rt_sysc_r32(RT3883_SYSC_REG_SYSCFG1);
> +	t |= RT3883_SYSCFG1_GPIO2_AS_WDT_OUT;
> +	rt_sysc_w32(t, RT3883_SYSC_REG_SYSCFG1);
> +}
> +
> +struct ralink_pinmux rt_pinmux = {
> +	.mode = mode_mux,
> +	.uart = uart_mux,
> +	.uart_shift = RT3883_GPIO_MODE_UART0_SHIFT,
> +	.uart_mask = RT3883_GPIO_MODE_GPIO,
> +	.wdt_reset = rt3883_wdt_reset,
> +	.pci = pci_mux,
> +	.pci_shift = RT3883_GPIO_MODE_PCI_SHIFT,
> +	.pci_mask = RT3883_GPIO_MODE_PCI_MASK,
> +};

Similarly to the rt2800 code, the pinmux related stuff is not used at all, so
these should be removed. Additionally, I suspect that it is not even possible to
compile this code. The rt_pinmux struct has no .pci* fields. Those were added by
the pinmux driver patch in the previous version of this series. Now that the
pinmux patch is not included, these fields are not present.
