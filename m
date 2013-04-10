Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 15:51:55 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:56977 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822672Ab3DJNvxse7tZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Apr 2013 15:51:53 +0200
Received: from mail-vb0-f52.google.com (mail-vb0-f52.google.com [209.85.212.52])
        by mail.nanl.de (Postfix) with ESMTPSA id 169224031C;
        Wed, 10 Apr 2013 13:51:43 +0000 (UTC)
Received: by mail-vb0-f52.google.com with SMTP id w8so364702vbf.39
        for <multiple recipients>; Wed, 10 Apr 2013 06:51:49 -0700 (PDT)
X-Received: by 10.52.70.49 with SMTP id j17mr1310628vdu.67.1365601909622; Wed,
 10 Apr 2013 06:51:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.31.73 with HTTP; Wed, 10 Apr 2013 06:51:29 -0700 (PDT)
In-Reply-To: <1365594447-13068-7-git-send-email-blogic@openwrt.org>
References: <1365594447-13068-1-git-send-email-blogic@openwrt.org> <1365594447-13068-7-git-send-email-blogic@openwrt.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 10 Apr 2013 15:51:29 +0200
Message-ID: <CAOiHx==gGkztMopkWCF4Td1NtKHiyG0FcL2TA59XWpAsHZtuhA@mail.gmail.com>
Subject: Re: [PATCH 06/18] MIPS: ralink: add pinmux driver
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On 10 April 2013 13:47, John Crispin <blogic@openwrt.org> wrote:
> Add code to setup the pinmux on ralonk SoC. The SoC has a single 32 bit register
> for this functionality with simple on/off bits. Building a full featured pinctrl
> driver would be overkill.

Bindings documentation, pretty please?

>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/ralink/Makefile |    2 +-
>  arch/mips/ralink/common.h |    8 +++-
>  arch/mips/ralink/of.c     |    2 +
>  arch/mips/ralink/pinmux.c |   95 +++++++++++++++++++++++++++++++++++++++++++++
>  arch/mips/ralink/rt305x.c |    6 +--
>  5 files changed, 107 insertions(+), 6 deletions(-)
>  create mode 100644 arch/mips/ralink/pinmux.c
>
> diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
> index 939757f..39ef249 100644
> --- a/arch/mips/ralink/Makefile
> +++ b/arch/mips/ralink/Makefile
> @@ -6,7 +6,7 @@
>  # Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
>  # Copyright (C) 2013 John Crispin <blogic@openwrt.org>
>
> -obj-y := prom.o of.o reset.o clk.o irq.o
> +obj-y := prom.o of.o reset.o clk.o irq.o pinmux.o
>
>  obj-$(CONFIG_SOC_RT305X) += rt305x.o
>
> diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
> index 3009903..193c76c 100644
> --- a/arch/mips/ralink/common.h
> +++ b/arch/mips/ralink/common.h
> @@ -22,9 +22,13 @@ struct ralink_pinmux {
>         struct ralink_pinmux_grp *mode;
>         struct ralink_pinmux_grp *uart;
>         int uart_shift;
> +       u32 uart_mask;
>         void (*wdt_reset)(void);
> +       struct ralink_pinmux_grp *pci;
> +       int pci_shift;
> +       u32 pci_mask;
>  };
> -extern struct ralink_pinmux gpio_pinmux;
> +extern struct ralink_pinmux rt_pinmux;
>
>  struct ralink_soc_info {
>         unsigned char sys_type[RAMIPS_SYS_TYPE_LEN];
> @@ -41,4 +45,6 @@ extern void prom_soc_init(struct ralink_soc_info *soc_info);
>
>  __iomem void *plat_of_remap_node(const char *node);
>
> +void ralink_pinmux(void);
> +
>  #endif /* _RALINK_COMMON_H__ */
> diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
> index 4165e70..ecf1482 100644
> --- a/arch/mips/ralink/of.c
> +++ b/arch/mips/ralink/of.c
> @@ -101,6 +101,8 @@ static int __init plat_of_setup(void)
>         if (of_platform_populate(NULL, of_ids, NULL, NULL))
>                 panic("failed to populate DT\n");
>
> +       ralink_pinmux();
> +
>         return 0;
>  }
>
> diff --git a/arch/mips/ralink/pinmux.c b/arch/mips/ralink/pinmux.c
> new file mode 100644
> index 0000000..c10df50
> --- /dev/null
> +++ b/arch/mips/ralink/pinmux.c
> @@ -0,0 +1,95 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + *  Copyright (C) 2013 John Crispin <blogic@openwrt.org>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +
> +#include <asm/mach-ralink/ralink_regs.h>
> +
> +#include "common.h"
> +
> +#define SYSC_REG_GPIO_MODE     0x60
> +
> +static u32 ralink_mux_mask(const char *name, struct ralink_pinmux_grp *grps)
> +{
> +       for (; grps->name; grps++)
> +               if (!strcmp(grps->name, name))
> +                       return grps->mask;
> +
> +       return 0;
> +}
> +
> +void ralink_pinmux(void)

Since you are only calling it from init code, couldn't it be also __init?

> +{
> +       const __be32 *wdt;
> +       struct device_node *np;
> +       struct property *prop;
> +       const char *uart, *pci, *pin;
> +       u32 mode = 0;
> +
> +       np = of_find_compatible_node(NULL, NULL, "ralink,rt3050-sysc");
> +       if (!np)
> +               return;
> +
> +       of_property_for_each_string(np, "ralink,gpiomux", prop, pin) {
> +               int m = ralink_mux_mask(pin, rt_pinmux.mode);

Missing empty line.

> +               if (m) {
> +                       mode |= m;
> +                       pr_debug("pinmux: registered gpiomux \"%s\"\n", pin);
> +               } else {
> +                       pr_err("pinmux: failed to load \"%s\"\n", pin);
> +               }
> +       }
> +
> +       of_property_for_each_string(np, "ralink,pinmux", prop, pin) {
> +               int m = ralink_mux_mask(pin, rt_pinmux.mode);

Missing empty line.

> +               if (m) {
> +                       mode &= ~m;
> +                       pr_debug("pinmux: registered pinmux \"%s\"\n", pin);
> +               } else {
> +                       pr_err("pinmux: failed to load group \"%s\"\n", pin);
> +               }
> +       }
> +
> +       uart = NULL;
> +       if (rt_pinmux.uart)
> +               of_property_read_string(np, "ralink,uartmux", &uart);
> +
> +       if (uart) {
> +               int m = ralink_mux_mask(uart, rt_pinmux.uart);
> +
> +               if (m) {
> +                       mode &= ~(rt_pinmux.uart_mask << rt_pinmux.uart_shift);
> +                       mode |= m << rt_pinmux.uart_shift;
> +                       pr_debug("pinmux: registered uartmux \"%s\"\n", uart);
> +               } else {
> +                       pr_debug("pinmux: unknown uartmux \"%s\"\n", uart);
> +               }
> +       }
> +
> +       wdt = of_get_property(np, "ralink,wdtmux", NULL);
> +       if (wdt && *wdt && rt_pinmux.wdt_reset)
> +               rt_pinmux.wdt_reset();
> +
> +       pci = NULL;
> +       if (rt_pinmux.pci)
> +               of_property_read_string(np, "ralink,pcimux", &pci);
> +
> +       if (pci) {
> +               int m = ralink_mux_mask(pci, rt_pinmux.pci);

Missing empty line.

> +               mode &= ~(rt_pinmux.pci_mask << rt_pinmux.pci_shift);
> +               if (m) {
> +                       mode |= (m << rt_pinmux.pci_shift);
> +                       pr_debug("pinmux: registered pcimux \"%s\"\n", pci);
> +               } else {
> +                       pr_debug("pinmux: registered pcimux \"gpio\"\n");
> +               }
> +       }
> +
> +       rt_sysc_w32(mode, SYSC_REG_GPIO_MODE);
> +}


Jonas
