Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 17:03:17 +0100 (CET)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:35298
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993086AbeABQDEADpW1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 17:03:04 +0100
Received: by mail-io0-x244.google.com with SMTP id 14so42851818iou.2;
        Tue, 02 Jan 2018 08:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P/CHpmDcBnS+7m4iMnt034Jma4Wb/wunnuZSWDW44FM=;
        b=KU9Csi5YFIJbFz7X+hHkNi0ovgN8cvuJyyJEYBtXIA/oieMEqcO13qtfy9ZdVeA9Hv
         AyQ/1VrtlKmNNGVWZFSHn5BYu1Hfx2WUGWIhmmtdQA7pDXSdmdaPxAEjNjfSkDUWL0xA
         +Yl2AJciW9hLjOlqRW6FiRjulsa1G45iMg//Se4nD+vFWijfWxPsVh2t7/tl6kzwtgyT
         LZk5BlfJx7raXEGJZtDCf9/TNRbeKkGMZ+HB9rVFoOTga7BbLO56MNnpDqI4lCnvaUt1
         rsRfT2iGyjrywvvcEF3DUHqGx1GqXfkJfc4nKr9emfdbXxKTP1DWJpDkDSfp2Ts8EtpY
         EQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P/CHpmDcBnS+7m4iMnt034Jma4Wb/wunnuZSWDW44FM=;
        b=WnimsIWW00S7KZgW3Px0ZRmG2AKn6mRn2lBChB/AMy/ENktBcFxPT5yLXbINGGQDJj
         mGkrL2fhUaVtYcAItd6GAOaXfQvyuypg42tgQ6rc5PZOZ4YmL0hOdCCXXn9rWzMLuavZ
         KJXVciq/DG6EvuQmzp5jW60T9Hs5Qm+F1W0sq4+1EWUB50TNX+6xf0199V4kvWCwTLFa
         1lj68uDPE7OYqMGEC7o4K9q+GeU5l0GPcPTsTq5HTeW+EQ4MpX7UE/0TSbqHVeNf6pni
         O1vfEkbz6jy4MqGkC8HZAAIrWwixyQ3e6g+w63xc1hEYd9vtplPrZ62KataQCeVP299b
         IxNQ==
X-Gm-Message-State: AKGB3mLw8E25fkqcditRk6kjNhTGT2XnM7xhr7EJk8bNujqjAGEpTn08
        ENhuh+kzWCajlHZLNY1GNjwdEIfEftNApRWHy4Q=
X-Google-Smtp-Source: ACJfBot7BBDLUt1RVV33TbFFNr55JLd9TgLNm6A18ZwGflRUF8D4T83LwhEJrn4zpJM6wfKDBz1v7FwYX8uDrvj0QeA=
X-Received: by 10.107.107.13 with SMTP id g13mr703794ioc.263.1514908977703;
 Tue, 02 Jan 2018 08:02:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.144.208 with HTTP; Tue, 2 Jan 2018 08:02:57 -0800 (PST)
In-Reply-To: <20180102150848.11314-10-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net> <20180102150848.11314-10-paul@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Tue, 2 Jan 2018 21:32:57 +0530
Message-ID: <CANc+2y7ePJ9PwXQp2EQS_CFj541iOkWLbZm7K3U0G7j0bx4RDg@mail.gmail.com>
Subject: Re: [PATCH v5 10/15] MIPS: ingenic: Add machine info for supported boards
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61847
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

Hi Paul,

On 2 January 2018 at 20:38, Paul Cercueil <paul@crapouillou.net> wrote:
> This makes sure that 'mips_machtype' will be initialized to the SoC
> version used on the board.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/Kconfig         |  1 +
>  arch/mips/jz4740/Makefile |  2 +-
>  arch/mips/jz4740/boards.c | 12 ++++++++++++
>  arch/mips/jz4740/setup.c  | 34 +++++++++++++++++++++++++++++-----
>  4 files changed, 43 insertions(+), 6 deletions(-)
>  create mode 100644 arch/mips/jz4740/boards.c
>
>  v2: No change
>  v3: No change
>  v4: No change
>  v5: Use SPDX license identifier
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 350a990fc719..83243e427e36 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -376,6 +376,7 @@ config MACH_INGENIC
>         select BUILTIN_DTB
>         select USE_OF
>         select LIBFDT
> +       select MIPS_MACHINE
>
>  config LANTIQ
>         bool "Lantiq based platforms"
> diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
> index 88d6aa7d000b..fc2d3b3c4a80 100644
> --- a/arch/mips/jz4740/Makefile
> +++ b/arch/mips/jz4740/Makefile
> @@ -6,7 +6,7 @@
>  # Object file lists.
>
>  obj-y += prom.o time.o reset.o setup.o \
> -       platform.o timer.o
> +       platform.o timer.o boards.o
>
>  CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
>
> diff --git a/arch/mips/jz4740/boards.c b/arch/mips/jz4740/boards.c
> new file mode 100644
> index 000000000000..13b0bddd8cb7
> --- /dev/null
> +++ b/arch/mips/jz4740/boards.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Ingenic boards support
> + * Copyright 2017, Paul Cercueil <paul@crapouillou.net>
> + */
> +
> +#include <asm/bootinfo.h>
> +#include <asm/mips_machine.h>
> +
> +MIPS_MACHINE(MACH_INGENIC_JZ4740, "qi,lb60", "Qi Hardware Ben Nanonote", NULL);
> +MIPS_MACHINE(MACH_INGENIC_JZ4780, "img,ci20",
> +                       "Imagination Technologies CI20", NULL);
> diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
> index 6d0152321819..afd84ee966e8 100644
> --- a/arch/mips/jz4740/setup.c
> +++ b/arch/mips/jz4740/setup.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_fdt.h>
>
>  #include <asm/bootinfo.h>
> +#include <asm/mips_machine.h>
>  #include <asm/prom.h>
>
>  #include <asm/mach-jz4740/base.h>
> @@ -53,16 +54,34 @@ static void __init jz4740_detect_mem(void)
>         add_memory_region(0, size, BOOT_MEM_RAM);
>  }
>
> +static unsigned long __init get_board_mach_type(const void *fdt)
> +{
> +       const struct mips_machine *mach;
> +
> +       for (mach = (struct mips_machine *)&__mips_machines_start;
> +                       mach < (struct mips_machine *)&__mips_machines_end;
> +                       mach++) {
> +               if (!fdt_node_check_compatible(fdt, 0, mach->mach_id))
> +                       return mach->mach_type;
> +       }
> +
> +       return MACH_INGENIC_JZ4740;
> +}
> +
>  void __init plat_mem_setup(void)
>  {
>         int offset;
>
> +       if (!early_init_dt_scan(__dtb_start))
> +               return;
> +
>         jz4740_reset_init();
> -       __dt_setup_arch(__dtb_start);
>
>         offset = fdt_path_offset(__dtb_start, "/memory");
>         if (offset < 0)
>                 jz4740_detect_mem();
> +
> +       mips_machtype = get_board_mach_type(__dtb_start);
>  }
>
>  void __init device_tree_init(void)
> @@ -75,13 +94,18 @@ void __init device_tree_init(void)
>
>  const char *get_system_type(void)
>  {
> -       if (IS_ENABLED(CONFIG_MACH_JZ4780))
> -               return "JZ4780";
> -
> -       return "JZ4740";
> +       return mips_get_machine_name();
>  }
>
>  void __init arch_init_irq(void)
>  {
>         irqchip_init();
>  }
> +
> +static int __init jz4740_machine_setup(void)
> +{
> +       mips_machine_setup();
> +
> +       return 0;
> +}
> +arch_initcall(jz4740_machine_setup);
> --
> 2.11.0
>
>

Why add another file in arch/mips/jz4740/? I think declaring a machine
and compatible string in dts would suffice. Please feel free to
correct me if I am wrong.

Regards,
PrasannaKumar
