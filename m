Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2018 14:09:49 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37323 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992408AbeIJMJomH0dX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2018 14:09:44 +0200
Received: by mail-oi0-f68.google.com with SMTP id p84-v6so39592356oic.4
        for <linux-mips@linux-mips.org>; Mon, 10 Sep 2018 05:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mc26UuR5dKmFOfDl0ahG1ant/pyws8OvJC2+hJ4ZzQQ=;
        b=ITJKn1CHwnSEgLzq8vMvs+fQ/KOIHuw+QLAbbIY2SQGFucPzypLvpDya0uvSjOyogh
         FBdHJpl3YLA1zSHg5VIuEk3dFBCidhFpWZnAy6riNCXkyAA7hPrR+rZ07hoX5n32ZmKM
         AHbLShbUmf/MC8+3+LNdl+WJkF3WFSXS5whTstPGZKH2E6h3u5ky0LaAtoPdZhUpvaJB
         3NbHAzc6AZpAhVQ+Lpz+kya6Q1F/RyONGg554bv5pVEhQz043wN/8WLvpXdMos/AGFOi
         c/LXTPENk1HxCp/6KbgoCBbGPmGYofh8fNmXW3kXuznSVIA/cbTa3WzMnmDviar0vruj
         YCyg==
X-Gm-Message-State: APzg51CJxEwu/yiQczN69VDW/V2tdJBBR30fp3KnOnytgHaCRPdjQKN+
        fIkvkPydWZIHJdibsnf+A+zX3YLYm3MGwt2sgAQ=
X-Google-Smtp-Source: ANB0VdZeuNfRr474GbcvjKjeT0c+fkKarTAIEi61O4LfOJOqJnQ1RZu+F2Mg9SS0bQnIj4AO7+jJg3H/ZeYCyqBfj5U=
X-Received: by 2002:aca:3ad4:: with SMTP id h203-v6mr20456865oia.294.1536581373592;
 Mon, 10 Sep 2018 05:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180907185414.2630-1-paul.burton@mips.com> <20180907185414.2630-2-paul.burton@mips.com>
In-Reply-To: <20180907185414.2630-2-paul.burton@mips.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Mon, 10 Sep 2018 14:09:21 +0200
Message-ID: <CA+7wUsx8gmDNh_kYAxx=PUR2gNJFRCLNYq=hZE79jT=yjNrj+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Fix CONFIG_CMDLINE handling
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Paul Cercueil <paul@crapouillou.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "# v4 . 11" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

On Fri, Sep 7, 2018 at 8:55 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Commit 8ce355cf2e38 ("MIPS: Setup boot_command_line before
> plat_mem_setup") fixed a problem for systems which have
> CONFIG_CMDLINE_BOOL=y & use a DT with a chosen node that has either no
> bootargs property or an empty one. In this configuration
> early_init_dt_scan_chosen() copies CONFIG_CMDLINE into
> boot_command_line, but the MIPS code doesn't know this so it appends
> CONFIG_CMDLINE (via builtin_cmdline) to boot_command_line again. The
> result is that boot_command_line contains the arguments from
> CONFIG_CMDLINE twice.
>
> That commit took the approach of simply setting up boot_command_line
> from the MIPS code before early_init_dt_scan_chosen() runs, causing it
> not to copy CONFIG_CMDLINE to boot_command_line if a chosen node with no
> bootargs property is found.
>
> Unfortunately this is problematic for systems which do have a non-empty
> bootargs property & CONFIG_CMDLINE_BOOL=y. There
> early_init_dt_scan_chosen() will overwrite boot_command_line with the
> arguments from DT, which means we lose those from CONFIG_CMDLINE
> entirely. This breaks CONFIG_MIPS_CMDLINE_DTB_EXTEND. If we have
> CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER or
> CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND selected and the DT has a bootargs
> property which we should ignore, it will instead be honoured breaking
> those configurations too.
>
> Fix this by reverting commit 8ce355cf2e38 ("MIPS: Setup
> boot_command_line before plat_mem_setup") to restore the former
> behaviour, and fixing the CONFIG_CMDLINE duplication issue by instead
> providing a no-op implementation of early_init_dt_fixup_cmdline_arch()
> to prevent early_init_dt_scan_chosen() from using CONFIG_CMDLINE.

Sorry I cannot test this patch ATM. I've simply CCed Paul C. just in case.

> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Fixes: 8ce355cf2e38 ("MIPS: Setup boot_command_line before plat_mem_setup")
> References: https://patchwork.linux-mips.org/patch/18804/
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Jaedon Shin <jaedon.shin@gmail.com>
> Cc: Mathieu Malaterre <malat@debian.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: stable@vger.kernel.org # v4.16+
> ---
>  arch/mips/kernel/setup.c | 47 +++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index c71d1eb7da59..7f755bc8a91c 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -841,11 +841,38 @@ static void __init request_crashkernel(struct resource *res)
>  #define BUILTIN_EXTEND_WITH_PROM       \
>         IS_ENABLED(CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND)
>
> +void __init early_init_dt_fixup_cmdline_arch(char *data)
> +{
> +       /*
> +        * Do nothing - arch_mem_init() will assemble our command line below,
> +        * for both the DT & non-DT cases.
> +        */
> +}
> +
>  static void __init arch_mem_init(char **cmdline_p)
>  {
>         struct memblock_region *reg;
>         extern void plat_mem_setup(void);
>
> +       /* call board setup routine */
> +       plat_mem_setup();
> +
> +       /*
> +        * Make sure all kernel memory is in the maps.  The "UP" and
> +        * "DOWN" are opposite for initdata since if it crosses over
> +        * into another memory section you don't want that to be
> +        * freed when the initdata is freed.
> +        */
> +       arch_mem_addpart(PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT,
> +                        PFN_UP(__pa_symbol(&_edata)) << PAGE_SHIFT,
> +                        BOOT_MEM_RAM);
> +       arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
> +                        PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
> +                        BOOT_MEM_INIT_RAM);
> +
> +       pr_info("Determined physical RAM map:\n");
> +       print_memory_map();
> +
>  #if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
>         strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
>  #else
> @@ -873,26 +900,6 @@ static void __init arch_mem_init(char **cmdline_p)
>         }
>  #endif
>  #endif
> -
> -       /* call board setup routine */
> -       plat_mem_setup();
> -
> -       /*
> -        * Make sure all kernel memory is in the maps.  The "UP" and
> -        * "DOWN" are opposite for initdata since if it crosses over
> -        * into another memory section you don't want that to be
> -        * freed when the initdata is freed.
> -        */
> -       arch_mem_addpart(PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT,
> -                        PFN_UP(__pa_symbol(&_edata)) << PAGE_SHIFT,
> -                        BOOT_MEM_RAM);
> -       arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
> -                        PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
> -                        BOOT_MEM_INIT_RAM);
> -
> -       pr_info("Determined physical RAM map:\n");
> -       print_memory_map();
> -
>         strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
>
>         *cmdline_p = command_line;
> --
> 2.18.0
>
