Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2014 11:31:04 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:36784 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008535AbaI2JbCiYBds (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Sep 2014 11:31:02 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id DF7AF28BF2C;
        Mon, 29 Sep 2014 11:30:17 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qg0-f44.google.com (mail-qg0-f44.google.com [209.85.192.44])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 0541528BE17;
        Mon, 29 Sep 2014 11:30:09 +0200 (CEST)
Received: by mail-qg0-f44.google.com with SMTP id j5so2953787qga.31
        for <multiple recipients>; Mon, 29 Sep 2014 02:30:51 -0700 (PDT)
X-Received: by 10.224.128.9 with SMTP id i9mr50086411qas.50.1411983051459;
 Mon, 29 Sep 2014 02:30:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.101.178 with HTTP; Mon, 29 Sep 2014 02:30:31 -0700 (PDT)
In-Reply-To: <1411929195-23775-2-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com> <1411929195-23775-2-git-send-email-ryazanov.s.a@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 29 Sep 2014 11:30:31 +0200
Message-ID: <CAOiHx=m-adJVEhOFmmRn73PHGTxJXVvZytt2T=EtgCQj4BQxgg@mail.gmail.com>
Subject: Re: [PATCH 01/16] MIPS: ar231x: add common parts
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42880
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
> Add common code for Atheros AR5312 and Atheros AR2315 SoCs families.
>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> ---
>  arch/mips/Kbuild.platforms                         |  1 +
>  arch/mips/Kconfig                                  | 13 ++++
>  arch/mips/ar231x/Makefile                          | 11 ++++
>  arch/mips/ar231x/Platform                          |  6 ++
>  arch/mips/ar231x/board.c                           | 53 +++++++++++++++
>  arch/mips/ar231x/devices.c                         | 20 ++++++
>  arch/mips/ar231x/devices.h                         | 22 +++++++
>  arch/mips/ar231x/prom.c                            | 26 ++++++++
>  arch/mips/include/asm/mach-ar231x/ar231x.h         | 29 +++++++++
>  .../asm/mach-ar231x/cpu-feature-overrides.h        | 76 ++++++++++++++++++++++
>  arch/mips/include/asm/mach-ar231x/dma-coherence.h  | 64 ++++++++++++++++++
>  arch/mips/include/asm/mach-ar231x/gpio.h           | 16 +++++
>  arch/mips/include/asm/mach-ar231x/war.h            | 25 +++++++
>  13 files changed, 362 insertions(+)
>  create mode 100644 arch/mips/ar231x/Makefile
>  create mode 100644 arch/mips/ar231x/Platform
>  create mode 100644 arch/mips/ar231x/board.c
>  create mode 100644 arch/mips/ar231x/devices.c
>  create mode 100644 arch/mips/ar231x/devices.h
>  create mode 100644 arch/mips/ar231x/prom.c
>  create mode 100644 arch/mips/include/asm/mach-ar231x/ar231x.h
>  create mode 100644 arch/mips/include/asm/mach-ar231x/cpu-feature-overrides.h
>  create mode 100644 arch/mips/include/asm/mach-ar231x/dma-coherence.h
>  create mode 100644 arch/mips/include/asm/mach-ar231x/gpio.h
>  create mode 100644 arch/mips/include/asm/mach-ar231x/war.h
>
> diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
> index f5e18bf..ee1940a 100644
> --- a/arch/mips/Kbuild.platforms
> +++ b/arch/mips/Kbuild.platforms
> @@ -1,6 +1,7 @@
>  # All platforms listed in alphabetic order
>
>  platforms += alchemy
> +platforms += ar231x
>  platforms += ar7
>  platforms += ath79
>  platforms += bcm47xx
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 01c0389..6adae4c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -73,6 +73,19 @@ config MIPS_ALCHEMY
>         select SYS_SUPPORTS_ZBOOT
>         select COMMON_CLK
>
> +config AR231X

I would suggest naming it ATH25, to match the other atheros target (ATH79).

> +       bool "Atheros AR231x/AR531x SoC support"
> +       select CEVT_R4K
> +       select CSRC_R4K
> +       select DMA_NONCOHERENT
> +       select IRQ_CPU
> +       select SYS_HAS_CPU_MIPS32_R1
> +       select SYS_SUPPORTS_BIG_ENDIAN
> +       select SYS_SUPPORTS_32BIT_KERNEL
> +       select ARCH_REQUIRE_GPIOLIB
> +       help
> +         Support for Atheros AR231x and Atheros AR531x based boards
> +
>  config AR7
>         bool "Texas Instruments AR7"
>         select BOOT_ELF32
> diff --git a/arch/mips/ar231x/Makefile b/arch/mips/ar231x/Makefile
> new file mode 100644
> index 0000000..9199fa1
> --- /dev/null
> +++ b/arch/mips/ar231x/Makefile
> @@ -0,0 +1,11 @@
> +#
> +# This file is subject to the terms and conditions of the GNU General Public
> +# License.  See the file "COPYING" in the main directory of this archive
> +# for more details.
> +#
> +# Copyright (C) 2006 FON Technology, SL.
> +# Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
> +# Copyright (C) 2006-2009 Felix Fietkau <nbd@openwrt.org>
> +#
> +
> +obj-y += board.o prom.o devices.o
> diff --git a/arch/mips/ar231x/Platform b/arch/mips/ar231x/Platform
> new file mode 100644
> index 0000000..c924fd1
> --- /dev/null
> +++ b/arch/mips/ar231x/Platform
> @@ -0,0 +1,6 @@
> +#
> +# Atheros AR531X/AR231X WiSoC
> +#
> +platform-$(CONFIG_AR231X)      += ar231x/
> +cflags-$(CONFIG_AR231X)                += -I$(srctree)/arch/mips/include/asm/mach-ar231x
> +load-$(CONFIG_AR231X)          += 0xffffffff80041000
> diff --git a/arch/mips/ar231x/board.c b/arch/mips/ar231x/board.c
> new file mode 100644
> index 0000000..9cde045
> --- /dev/null
> +++ b/arch/mips/ar231x/board.c
> @@ -0,0 +1,53 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2003 Atheros Communications, Inc.,  All Rights Reserved.
> + * Copyright (C) 2006 FON Technology, SL.
> + * Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
> + * Copyright (C) 2006-2009 Felix Fietkau <nbd@openwrt.org>
> + */
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <asm/irq_cpu.h>
> +#include <asm/reboot.h>
> +#include <asm/bootinfo.h>
> +#include <asm/time.h>
> +
> +static void ar231x_halt(void)
> +{
> +       local_irq_disable();
> +       while (1)
> +               ;
> +}
> +
> +void __init plat_mem_setup(void)
> +{
> +       _machine_halt = ar231x_halt;
> +       pm_power_off = ar231x_halt;
> +
> +       /* Disable data watchpoints */
> +       write_c0_watchlo0(0);
> +}
> +
> +asmlinkage void plat_irq_dispatch(void)
> +{
> +}
> +
> +void __init plat_time_init(void)
> +{
> +}
> +
> +unsigned int __cpuinit get_c0_compare_int(void)
> +{
> +       return CP0_LEGACY_COMPARE_IRQ;
> +}
> +
> +void __init arch_init_irq(void)
> +{
> +       clear_c0_status(ST0_IM);
> +       mips_cpu_irq_init();
> +}
> +
> diff --git a/arch/mips/ar231x/devices.c b/arch/mips/ar231x/devices.c
> new file mode 100644
> index 0000000..f71a643
> --- /dev/null
> +++ b/arch/mips/ar231x/devices.c
> @@ -0,0 +1,20 @@
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <asm/bootinfo.h>
> +
> +#include "devices.h"
> +
> +int ar231x_devtype = DEV_TYPE_UNKNOWN;
> +
> +static const char * const devtype_strings[] = {
> +       [DEV_TYPE_UNKNOWN] = "Atheros (unknown)",
> +};
> +
> +const char *get_system_type(void)
> +{
> +       if ((ar231x_devtype >= ARRAY_SIZE(devtype_strings)) ||
> +           !devtype_strings[ar231x_devtype])
> +               return devtype_strings[DEV_TYPE_UNKNOWN];
> +       return devtype_strings[ar231x_devtype];
> +}
> +
> diff --git a/arch/mips/ar231x/devices.h b/arch/mips/ar231x/devices.h
> new file mode 100644
> index 0000000..1590577
> --- /dev/null
> +++ b/arch/mips/ar231x/devices.h
> @@ -0,0 +1,22 @@
> +#ifndef __AR231X_DEVICES_H
> +#define __AR231X_DEVICES_H
> +
> +#include <linux/cpu.h>
> +
> +enum {
> +       DEV_TYPE_UNKNOWN
> +};
> +
> +extern int ar231x_devtype;
> +
> +static inline bool is_2315(void)

Since this is matching the whole family of ar231x SoCs, I would
suggest to give it a prefix and call it ath25_is_231x.
> +{
> +       return (current_cpu_data.cputype == CPU_4KEC);

Unnecessary ().

> +}
> +
> +static inline bool is_5312(void)

Same comment here for 5312 -> 531x.

> +{
> +       return !is_2315();
> +}
> +
> +#endif


Regards
Jonas
