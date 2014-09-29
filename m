Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2014 14:48:31 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:43574 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009297AbaI2Ms2u0ZB1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Sep 2014 14:48:28 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 8308928BEAF;
        Mon, 29 Sep 2014 14:47:31 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qg0-f46.google.com (mail-qg0-f46.google.com [209.85.192.46])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 0F7A328AD3E;
        Mon, 29 Sep 2014 14:47:02 +0200 (CEST)
Received: by mail-qg0-f46.google.com with SMTP id a108so95537qge.19
        for <multiple recipients>; Mon, 29 Sep 2014 05:47:43 -0700 (PDT)
X-Received: by 10.224.165.1 with SMTP id g1mr1165451qay.97.1411994863047; Mon,
 29 Sep 2014 05:47:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.101.178 with HTTP; Mon, 29 Sep 2014 05:47:22 -0700 (PDT)
In-Reply-To: <1411929195-23775-6-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com> <1411929195-23775-6-git-send-email-ryazanov.s.a@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 29 Sep 2014 14:47:22 +0200
Message-ID: <CAOiHx==peRWkQjSOJvtJVKoiRdiugiu6-hmrEsafWw3K8HS1Ww@mail.gmail.com>
Subject: Re: [PATCH 05/16] MIPS: ar231x: add early printk support
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42885
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

On Sun, Sep 28, 2014 at 8:33 PM, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> ---
>  arch/mips/Kconfig               |  1 +
>  arch/mips/ar231x/Makefile       |  2 ++
>  arch/mips/ar231x/early_printk.c | 45 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
>  create mode 100644 arch/mips/ar231x/early_printk.c
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index bd81f7a..b89bfdf 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -83,6 +83,7 @@ config AR231X
>         select SYS_SUPPORTS_BIG_ENDIAN
>         select SYS_SUPPORTS_32BIT_KERNEL
>         select ARCH_REQUIRE_GPIOLIB
> +       select SYS_HAS_EARLY_PRINTK
>         help
>           Support for Atheros AR231x and Atheros AR531x based boards
>
> diff --git a/arch/mips/ar231x/Makefile b/arch/mips/ar231x/Makefile
> index 201b7d4..eabad7d 100644
> --- a/arch/mips/ar231x/Makefile
> +++ b/arch/mips/ar231x/Makefile
> @@ -10,5 +10,7 @@
>
>  obj-y += board.o prom.o devices.o
>
> +obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
> +
>  obj-$(CONFIG_SOC_AR5312) += ar5312.o
>  obj-$(CONFIG_SOC_AR2315) += ar2315.o
> diff --git a/arch/mips/ar231x/early_printk.c b/arch/mips/ar231x/early_printk.c
> new file mode 100644
> index 0000000..393c5ab
> --- /dev/null
> +++ b/arch/mips/ar231x/early_printk.c
> @@ -0,0 +1,45 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2010 Gabor Juhos <juhosg@openwrt.org>
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/io.h>
> +#include <linux/serial_reg.h>
> +
> +#include <ar2315_regs.h>
> +#include <ar5312_regs.h>
> +#include "devices.h"
> +
> +static inline void prom_uart_wr(void __iomem *base, unsigned reg,
> +                               unsigned char ch)
> +{
> +       __raw_writel(ch, base + 4 * reg);
> +}
> +
> +static inline unsigned char prom_uart_rr(void __iomem *base, unsigned reg)
> +{
> +       return __raw_readl(base + 4 * reg);
> +}
> +
> +void prom_putchar(unsigned char ch)
> +{
> +       static void __iomem *base;
> +
> +       if (unlikely(base == NULL)) {
> +               if (is_2315())
> +                       base = (void __iomem *)(KSEG1ADDR(AR2315_UART0));
> +               else
> +                       base = (void __iomem *)(KSEG1ADDR(AR5312_UART0));
> +       }
> +
> +       while ((prom_uart_rr(base, UART_LSR) & UART_LSR_THRE) == 0)
> +               ;
> +       prom_uart_wr(base, UART_TX, ch);
> +       while ((prom_uart_rr(base, UART_LSR) & UART_LSR_THRE) == 0)
> +               ;
> +}


Have you tried using EARLY_PRINTK_8250 instead? Since this is a 8250 anyway.


Jonas
