Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2011 12:31:51 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:52844 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491134Ab1HAKbp convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Aug 2011 12:31:45 +0200
Received: by yxj20 with SMTP id 20so3508347yxj.36
        for <multiple recipients>; Mon, 01 Aug 2011 03:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8wmF7iBnBR18vFFMDmytP8r+rJ6eh9Mk1qKkkT96p80=;
        b=FHT3qdmmxM9Uq68Jq+bvdYHKPbu0ox+Djno0NrAcwvbV05at2siYUEciEJoAuDd0c9
         VnE5QztOEy0TF+zl/2VSWh5H763pZxTErXLm4gmx07saIr4fbrZxqbC80OV0N6FkoGOU
         R4/TnQypY4HJ65ClcsVe/N1Fl0NnCq07WMtPo=
Received: by 10.150.51.12 with SMTP id y12mr691591yby.33.1312194699174; Mon,
 01 Aug 2011 03:31:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.11.10 with HTTP; Mon, 1 Aug 2011 03:31:19 -0700 (PDT)
In-Reply-To: <1312194382-3706-3-git-send-email-florian@openwrt.org>
References: <1312194382-3706-1-git-send-email-florian@openwrt.org> <1312194382-3706-3-git-send-email-florian@openwrt.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Mon, 1 Aug 2011 12:31:19 +0200
Message-ID: <CAOiHx=no--75g7K_MoZrD-=LkcbskQBufUFWrz52NSNQJ36T4Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] MIPS: introduce CPU_R4K_CACHE_TLB
To:     Florian Fainelli <florian@openwrt.org>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 299

Hi,

On 1 August 2011 12:26, Florian Fainelli <florian@openwrt.org> wrote:
> R4K-style CPUs having common code to support their caches and tlb have this
> boolean defined by default. Allows us to save some lines in
> arch/mips/mm/Makefile
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  arch/mips/Kconfig     |    4 ++++
>  arch/mips/mm/Makefile |   16 +---------------
>  2 files changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 44eebc7..0150745 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1811,6 +1811,10 @@ config CPU_R4K_FPU
>        bool
>        default y if !(CPU_R3000 || CPU_R6000 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
>
> +config CPU_R4K_CACHE_TLB
> +       bool
> +       default y if !(CPU_R3000 || CPU_SB1 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
> +
>  choice
>        prompt "MIPS MT options"
>
> diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
> index 4d8c162..04ece1b5 100644
> --- a/arch/mips/mm/Makefile
> +++ b/arch/mips/mm/Makefile
> @@ -11,24 +11,10 @@ obj-$(CONFIG_64BIT)         += pgtable-64.o
>  obj-$(CONFIG_HIGHMEM)          += highmem.o
>  obj-$(CONFIG_HUGETLB_PAGE)     += hugetlbpage.o
>
> -obj-$(CONFIG_CPU_LOONGSON2)    += c-r4k.o cex-gen.o tlb-r4k.o
> -obj-$(CONFIG_CPU_MIPS32)       += c-r4k.o cex-gen.o tlb-r4k.o
> -obj-$(CONFIG_CPU_MIPS64)       += c-r4k.o cex-gen.o tlb-r4k.o
> -obj-$(CONFIG_CPU_NEVADA)       += c-r4k.o cex-gen.o tlb-r4k.o
> -obj-$(CONFIG_CPU_R10000)       += c-r4k.o cex-gen.o tlb-r4k.o
> +obj-$(CONFIG_CPU_R4K_CACHE_TLB) += c-r4k.o cex-gen.o tlb-r4k.o
>  obj-$(CONFIG_CPU_R3000)                += c-r3k.o tlb-r3k.o
> -obj-$(CONFIG_CPU_R4300)                += c-r4k.o cex-gen.o tlb-r4k.o
> -obj-$(CONFIG_CPU_R4X00)                += c-r4k.o cex-gen.o tlb-r4k.o
> -obj-$(CONFIG_CPU_R5000)                += c-r4k.o cex-gen.o tlb-r4k.o
> -obj-$(CONFIG_CPU_R5432)                += c-r4k.o cex-gen.o tlb-r4k.o
> -obj-$(CONFIG_CPU_R5500)                += c-r4k.o cex-gen.o tlb-r4k.o
> -obj-$(CONFIG_CPU_R8000)                += c-r4k.o cex-gen.o tlb-r8k.o

This one should stay (and be added to the exceptions): tlb-r*8*k. ;-)

> -obj-$(CONFIG_CPU_RM7000)       += c-r4k.o cex-gen.o tlb-r4k.o
> -obj-$(CONFIG_CPU_RM9000)       += c-r4k.o cex-gen.o tlb-r4k.o
>  obj-$(CONFIG_CPU_SB1)          += c-r4k.o cerr-sb1.o cex-sb1.o tlb-r4k.o
>  obj-$(CONFIG_CPU_TX39XX)       += c-tx39.o tlb-r3k.o
> -obj-$(CONFIG_CPU_TX49XX)       += c-r4k.o cex-gen.o tlb-r4k.o
> -obj-$(CONFIG_CPU_VR41XX)       += c-r4k.o cex-gen.o tlb-r4k.o
>  obj-$(CONFIG_CPU_CAVIUM_OCTEON)        += c-octeon.o cex-oct.o tlb-r4k.o
>  obj-$(CONFIG_CPU_XLR)          += c-r4k.o tlb-r4k.o cex-gen.o

This one should go, too. You probably missed it because it used a
different file name order ;-). I haven't checked if they are others
outside of the context lines.


Jonas
