Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Dec 2017 15:57:16 +0100 (CET)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:40911
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994644AbdLSO5JWNKyl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Dec 2017 15:57:09 +0100
Received: by mail-io0-x241.google.com with SMTP id v186so13860143iod.7;
        Tue, 19 Dec 2017 06:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yjin0CzmDmBMc8WKVfzM+iEUBR5DnFniV9eeYahO2z8=;
        b=CcLom54H/W3d1oidX4ChSmBHfmz6B4oDBbOPNhCfKAnIMK2HdGp+94gcAt/Xkh46vt
         JjMg7quEn+rVhmO0P9qiLE7du8e9qXiA3h/xixD1mk4ksbwkbLjzTWuRTjt0LNwuvTmJ
         77/UBQyXXqptCQsQ8zHJ0pZE+NBbw/3j0oV565qv1egJxvDy//o5ElPsgAoN07j3Clvg
         fl0gHYu0LJM52dkJkSAAqaW/V+pXdZJaoCnX3f1w69X55a5316UXOPgiaArTofk14PgA
         NrJVfHdxADzm8mg9hHzs7LAUws6aXN+0gthzi8MywLbeE+19mFedwp9+4RF/lqlef8vX
         +VFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yjin0CzmDmBMc8WKVfzM+iEUBR5DnFniV9eeYahO2z8=;
        b=ls7SSEIq3s0IGSDojGkYJw/POC+ebSO7BwdDsbsRxTKUDz8KF4NbntMwrUZ0WNL4dH
         5AaT79pYRuQZlirxDfxV3lW6n0bVeohHtezTjTbHMbrcQGZAcHeP2sSvf9QlR+5CWd+3
         O/VfcnfePeFRB+4NrWPeMZnUqYgrIe7jLoNpfMcy5qpZbALaneGphBUgQjnDyA7W6Ls8
         FkmzOSRsjZrR+vTEo2JSJup07e7sBzJVxjD62s0vbz8K5tvERKNGnjljxpu9BrmvoW/r
         GU+hfVXdxqtk4Z/mQfQScFm2cPMvkBKaiaxkPKgc+cUxUmsvHAkm1HS/oMOCwnNUbIbn
         KzJg==
X-Gm-Message-State: AKGB3mIddCM6phNmBBd85JnfGgOVQdqN0zAZ7K01uzzyNxZ+SJ9+76Nk
        jvpEA7LbwO3pt35EGCHH35xbMdxbb91HO0uCCEI=
X-Google-Smtp-Source: ACJfBosWovlpfPSqelXFXJATfSurxQu9KVXbBTpfAno7aMfUEFF1AcNNaK3eeIAHGakbf/9ttQZ9pi8/3yBKIm9fWKk=
X-Received: by 10.107.165.15 with SMTP id o15mr4105002ioe.129.1513695422793;
 Tue, 19 Dec 2017 06:57:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.169.20 with HTTP; Tue, 19 Dec 2017 06:57:02 -0800 (PST)
In-Reply-To: <20171208154618.20105-10-alexandre.belloni@free-electrons.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com> <20171208154618.20105-10-alexandre.belloni@free-electrons.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Tue, 19 Dec 2017 20:27:02 +0530
Message-ID: <CANc+2y4BroVz4eZOeb_ygYH42kg4WPP0y_t4OUuVd50OBSDgXQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] MIPS: mscc: Add initial support for Microsemi
 MIPS SoCs
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Hi Alexandre,

On 8 December 2017 at 21:16, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Introduce support for the MIPS based Microsemi Ocelot SoCs.
> As the plan is to have all SoCs supported only using device tree, the
> mach directory is simply called mscc.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/mips/Kbuild.platforms |   1 +
>  arch/mips/Kconfig          |  24 ++++++++++
>  arch/mips/mscc/Makefile    |  11 +++++
>  arch/mips/mscc/Platform    |  12 +++++
>  arch/mips/mscc/setup.c     | 106 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 154 insertions(+)
>  create mode 100644 arch/mips/mscc/Makefile
>  create mode 100644 arch/mips/mscc/Platform
>  create mode 100644 arch/mips/mscc/setup.c
>
> diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
> index ac7ad54f984f..b3b2f8dc91db 100644
> --- a/arch/mips/Kbuild.platforms
> +++ b/arch/mips/Kbuild.platforms
> @@ -18,6 +18,7 @@ platforms += lantiq
>  platforms += lasat
>  platforms += loongson32
>  platforms += loongson64
> +platforms += mscc
>  platforms += mti-malta
>  platforms += netlogic
>  platforms += paravirt
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 350a990fc719..a9db028a0338 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -527,6 +527,30 @@ config MIPS_MALTA
>           This enables support for the MIPS Technologies Malta evaluation
>           board.
>
> +config MSCC_OCELOT
> +       bool "Microsemi Ocelot architecture"
> +       select BOOT_RAW
> +       select CEVT_R4K
> +       select CSRC_R4K
> +       select IRQ_MIPS_CPU
> +       select DMA_NONCOHERENT
> +       select SYS_HAS_CPU_MIPS32_R2
> +       select SYS_SUPPORTS_32BIT_KERNEL
> +       select SYS_SUPPORTS_BIG_ENDIAN
> +       select SYS_SUPPORTS_LITTLE_ENDIAN
> +       select SYS_HAS_EARLY_PRINTK
> +       select USE_GENERIC_EARLY_PRINTK_8250
> +       select MSCC_OCELOT_IRQ
> +       select PINCTRL
> +       select GPIOLIB
> +       select COMMON_CLK
> +       select USE_OF
> +       select BUILTIN_DTB
> +       select LIBFDT
> +       help
> +         This enables support for the Microsemi Ocelot architecture.
> +         It builds a generic DT-based kernel image.
> +
>  config MACH_PIC32
>         bool "Microchip PIC32 Family"
>         help
> diff --git a/arch/mips/mscc/Makefile b/arch/mips/mscc/Makefile
> new file mode 100644
> index 000000000000..c96b13546730
> --- /dev/null
> +++ b/arch/mips/mscc/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +#
> +# Microsemi MIPS SoC support
> +#
> +# License: Dual MIT/GPL
> +# Copyright (c) 2017 Microsemi Corporation
> +
> +#
> +# Makefile for the Microsemi MIPS SoCs
> +#
> +obj-y := setup.o
> diff --git a/arch/mips/mscc/Platform b/arch/mips/mscc/Platform
> new file mode 100644
> index 000000000000..9ae874c8f136
> --- /dev/null
> +++ b/arch/mips/mscc/Platform
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +#
> +# Microsemi MIPS SoC support
> +#
> +# License: Dual MIT/GPL
> +# Copyright (c) 2017 Microsemi Corporation
> +
> +#
> +# Microsemi Ocelot board(s)
> +#
> +platform-$(CONFIG_MSCC_OCELOT) += mscc/
> +load-$(CONFIG_MSCC_OCELOT)      += 0x80100000
> diff --git a/arch/mips/mscc/setup.c b/arch/mips/mscc/setup.c
> new file mode 100644
> index 000000000000..77803edd7bfd
> --- /dev/null
> +++ b/arch/mips/mscc/setup.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Microsemi MIPS SoC support
> + *
> + * License: Dual MIT/GPL
> + * Copyright (c) 2017 Microsemi Corporation
> + */
> +#include <linux/delay.h>
> +#include <linux/export.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/libfdt.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_platform.h>
> +#include <linux/reboot.h>
> +
> +#include <asm/time.h>
> +#include <asm/idle.h>
> +#include <asm/prom.h>
> +#include <asm/reboot.h>
> +
> +static void __init ocelot_earlyprintk_init(void)
> +{
> +       void __iomem *uart_base;
> +
> +       uart_base = ioremap_nocache(0x70100000, 0x0f);
> +       setup_8250_early_printk_port((unsigned long)uart_base, 2, 50000);
> +}
> +
> +void __init prom_init(void)
> +{
> +       /* Sanity check for defunct bootloader */
> +       if (fw_arg0 < 10 && (fw_arg1 & 0xFFF00000) == 0x80000000) {
> +               unsigned int prom_argc = fw_arg0;
> +               const char **prom_argv = (const char **)fw_arg1;
> +
> +               if (prom_argc > 1 && strlen(prom_argv[1]) > 0)
> +                       /* ignore all built-in args if any f/w args given */
> +                       strcpy(arcs_cmdline, prom_argv[1]);
> +       }
> +}
> +
> +void __init prom_free_prom_memory(void)
> +{
> +}
> +
> +unsigned int get_c0_compare_int(void)
> +{
> +       return CP0_LEGACY_COMPARE_IRQ;
> +}
> +
> +void __init plat_time_init(void)
> +{
> +       struct device_node *np;
> +       u32 freq;
> +
> +       np = of_find_node_by_name(NULL, "cpus");
> +       if (!np)
> +               panic("missing 'cpus' DT node");
> +       if (of_property_read_u32(np, "mips-hpt-frequency", &freq) < 0)
> +               panic("missing 'mips-hpt-frequency' property");
> +       of_node_put(np);
> +
> +       mips_hpt_frequency = freq;
> +}
> +
> +void __init arch_init_irq(void)
> +{
> +       irqchip_init();
> +}
> +
> +const char *get_system_type(void)
> +{
> +       return "Microsemi Ocelot";
> +}
> +
> +static void __init ocelot_late_init(void)
> +{
> +       ocelot_earlyprintk_init();
> +}
> +
> +extern void (*late_time_init)(void);
> +
> +void __init plat_mem_setup(void)
> +{
> +       /* This has to be done so late because ioremap needs to work */
> +       late_time_init = ocelot_late_init;
> +
> +       __dt_setup_arch(__dtb_start);
> +}
> +
> +void __init device_tree_init(void)
> +{
> +       if (!initial_boot_params)
> +               return;
> +
> +       unflatten_and_copy_device_tree();
> +}
> +
> +static int __init populate_machine(void)
> +{
> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +       return 0;
> +}
> +arch_initcall(populate_machine);
> --
> 2.15.1
>
>

Given the fact that setup code is very small and most of it is generic
code I strongly believe that it is plausible to make use of generic
code completely. Please have a look at [1] and [2].

1. https://patchwork.kernel.org/patch/9655699/
2. https://patchwork.kernel.org/patch/9655697/

PS: My rb tag stays if this could not be done immediately.

Regards,
PrasannaKumar Muralidharan
