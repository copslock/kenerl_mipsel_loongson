Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Dec 2017 14:23:34 +0100 (CET)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:40903
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992176AbdLRNX07Y8Yr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Dec 2017 14:23:26 +0100
Received: by mail-it0-x244.google.com with SMTP id f190so27516864ita.5;
        Mon, 18 Dec 2017 05:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CePqoquTsd7jpsi2aQ4BY9cftJlm+4zrHNgCHEWvsr4=;
        b=KhBdrgkJaJ4WXY2UVlURyIEgDwieZTe6/MRVuayFgzdklZBpELdcVqygDUczv0C59z
         TJmSafesJLXpmfEJCgp3nYdLurvrLZbxf4I2wn9F3b9QXs8iyl/FYoKb2aXmz69lE/U6
         9tg8rtvAvFXP3rXFvQoHICkJ/qKly66dC1Y1XIhvogkt6WPxj7JgBXwDKaeDbI5n2bL4
         w8F3bIjotg7nJVg49pmIlaWjJeRV5D83jYpfiXUNZSVOUm3b86cUaRkfmbcD17OpmtXv
         saHMhdj3o+uCtcPtBNkkDkA7h0j3A7NAosR/Sb3II3szoJndc5GkE6uERWiHrSsSgh4y
         YViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CePqoquTsd7jpsi2aQ4BY9cftJlm+4zrHNgCHEWvsr4=;
        b=cWhGoD6+EQnt6UUhMHlH1PIfQtK0ZzzucerzL8sUCHqJo5t4T3Z4XucrDxsveAX8DN
         9lifrS0kj/RPbGKwUJHP6AYrUVEO3kinliqbo+LdUgNabTeBlrXtVVfdWqg2gzGvLGEK
         yE/R6SwSTg6YQAYTiKIooM7e+G8IMzmDs5yP3EAVhwzzvNe3VV8BB/lDtFQrJ8fAtHQN
         4w2Ox/bseE+SvDNWdGa46mnDqtZ5ufmbUcCAI6fwxxMYoqAA8woczZaMLTfmewd+hvin
         S21aEFuwExyWxG9wxDIh5mIwS5zpOBOBVglKul33m/O7jsNFCSKJSQMpry6urehB876V
         lL2Q==
X-Gm-Message-State: AKGB3mLGH+G7A+NEqPkwClBIeFipmsnI8sQeBiJW45aMLQtLWS294rW4
        V7uzZDASIHmajYSpyW5cxrUZ9sevR78Xd7nyF7+uSC/1
X-Google-Smtp-Source: ACJfBos2v9otfcOzBQUCWDkI4bo2amKdWceInoO+TY6v+U97eDqJcLAxWRSpGJwCeE6o89abBiwdK6Sdrxs44lD8/hg=
X-Received: by 10.36.70.146 with SMTP id j140mr11405319itb.66.1513603400435;
 Mon, 18 Dec 2017 05:23:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.169.20 with HTTP; Mon, 18 Dec 2017 05:23:20 -0800 (PST)
In-Reply-To: <20171208154618.20105-10-alexandre.belloni@free-electrons.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com> <20171208154618.20105-10-alexandre.belloni@free-electrons.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Mon, 18 Dec 2017 18:53:20 +0530
Message-ID: <CANc+2y4YicFJ4i1Wuan4oh+z=6cG7K-HKTm0Cp2z8xnHD2bedw@mail.gmail.com>
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
X-archive-position: 61511
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

Looks good to me.
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Regards,
PrasannaKumar
