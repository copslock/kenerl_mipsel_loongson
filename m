Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 17:45:28 +0100 (CET)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:43209
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeABQpUkqrzp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 17:45:20 +0100
Received: by mail-io0-x244.google.com with SMTP id w188so5052574iod.10;
        Tue, 02 Jan 2018 08:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5ghQuVEKCgkBS2w1lQ+kMIj40yjsR5p6GSwgY4Tu70w=;
        b=WxzDHfqnUDNCjqEX4oV2UwiSEO5PrCcVriucId72utvOvLSU55W4FqRPa6vXLJ8ZWI
         5UkYUg31PZmiYbKDMPd7Nx5I8Ulb+askobmXMlDIlcM2XOxkO2EEkPH2vFfpL+JhRbf1
         YPsmqy9tpvI2uoBp2HXMp8D6W/N4/EUXUgLHs/T3/atpHRdZs2MQxZWEfKSUu91K+8Y9
         WoVLtmk81+0zVYZWfLAMXik5xEtrHGKsd6UaBNIGB4sWsh8ZKxRcGQ4h+9THNwojmqOj
         NKwNwhgsjHbfXbrHl/rpcJEHM6oNvAfPODxUtePk0akveAjC7/suA36CG1ngBTanYB4e
         /Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5ghQuVEKCgkBS2w1lQ+kMIj40yjsR5p6GSwgY4Tu70w=;
        b=Vkul73WAJYg/eeni4qK3yWgkFh62OS4vqjvzgjoVbbBop90P3sG8qEqnIej7c+M/sI
         4rUt39DtX2bT427MArUrmvw4NFAKMN4unlxKMlsGDBYNC4Tvy8ddevhAm0hxdiDw4/OP
         MbAeerfmyU0molAcY7NfLGoRHoWG3piQcGZ+06avfjsqVeElRoOg/Sz7eGY2ok2OhjNn
         DUL8losuTWTW73DWq71y8CfA/ZjD16iIP/29+PRdARJc6i2GlSpTR34IkFSunYlukPah
         DrfmFYqXt4COB6P7y/DO7zTAXWXdFJXU8drreC3NOndhMTrqf5N1m1NiLG9U9t1dqA1u
         PWyQ==
X-Gm-Message-State: AKGB3mI5oM7O/SXweJHmZ6izl+UvKIFIMEdXoCYhRGSiO4LknifzzS2a
        BER05aARNJkx+5ukkqFkc1Le1q139l5MumQamqQnY+Jr
X-Google-Smtp-Source: ACJfBouy4PLP7SxS/BjeIc7WrQjp25BmtT/yKEpS3H5WDXbIleOY+z5oUbFYKmUdMKQxVnWbxVE4sCrIXID5BHfqDLM=
X-Received: by 10.107.171.195 with SMTP id u186mr20613271ioe.129.1514911514717;
 Tue, 02 Jan 2018 08:45:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.144.208 with HTTP; Tue, 2 Jan 2018 08:45:14 -0800 (PST)
In-Reply-To: <20180102150848.11314-13-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net> <20180102150848.11314-13-paul@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Tue, 2 Jan 2018 22:15:14 +0530
Message-ID: <CANc+2y4mJMMiN4SPiPtcXMrQ0AM_2XGnVRk1Dvyv9VYpNN3x-g@mail.gmail.com>
Subject: Re: [PATCH v5 13/15] MIPS: JZ4770: Workaround for corrupted DMA transfers
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
X-archive-position: 61857
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
> From: Maarten ter Huurne <maarten@treewalker.org>
>
> We have seen MMC DMA transfers read corrupted data from SDRAM when
> a burst interval ends at physical address 0x10000000. To avoid this
> problem, we remove the final page of low memory from the memory map.
>
> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
> ---
>  arch/mips/jz4740/setup.c | 24 ++++++++++++++++++++++++
>  arch/mips/kernel/setup.c |  8 ++++++++
>  2 files changed, 32 insertions(+)
>
>  v2: No change
>  v3: No change
>  v4: No change
>  v5: No change
>
> diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
> index afd84ee966e8..6948b133a15d 100644
> --- a/arch/mips/jz4740/setup.c
> +++ b/arch/mips/jz4740/setup.c
> @@ -23,6 +23,7 @@
>
>  #include <asm/bootinfo.h>
>  #include <asm/mips_machine.h>
> +#include <asm/page.h>
>  #include <asm/prom.h>
>
>  #include <asm/mach-jz4740/base.h>
> @@ -102,6 +103,29 @@ void __init arch_init_irq(void)
>         irqchip_init();
>  }
>
> +/*
> + * We have seen MMC DMA transfers read corrupted data from SDRAM when a burst
> + * interval ends at physical address 0x10000000. To avoid this problem, we
> + * remove the final page of low memory from the memory map.
> + */
> +void __init jz4770_reserve_unsafe_for_dma(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < boot_mem_map.nr_map; i++) {
> +               struct boot_mem_map_entry *entry = boot_mem_map.map + i;
> +
> +               if (entry->type != BOOT_MEM_RAM)
> +                       continue;
> +
> +               if (entry->addr + entry->size != 0x10000000)
> +                       continue;
> +
> +               entry->size -= PAGE_SIZE;
> +               break;
> +       }
> +}
> +

Just a wild idea (probably bad too). Changing the memory node in the
device tree to skip this physical address would work I think. What is
your opinion about that?

>  static int __init jz4740_machine_setup(void)
>  {
>         mips_machine_setup();
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 85bc601e9a0d..5a2c20145aee 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -879,6 +879,14 @@ static void __init arch_mem_init(char **cmdline_p)
>
>         parse_early_param();
>
> +#ifdef CONFIG_MACH_JZ4770
> +       if (current_cpu_type() == CPU_JZRISC &&
> +                               mips_machtype == MACH_INGENIC_JZ4770) {
> +               extern void __init jz4770_reserve_unsafe_for_dma(void);
> +               jz4770_reserve_unsafe_for_dma();
> +       }
> +#endif
> +
>         if (usermem) {
>                 pr_info("User-defined physical RAM map:\n");
>                 print_memory_map();
> --
> 2.11.0
>
>

Thanks,
PrasannaKumar
