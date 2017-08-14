Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2017 08:21:18 +0200 (CEST)
Received: from mail-io0-x242.google.com ([IPv6:2607:f8b0:4001:c06::242]:38911
        "EHLO mail-io0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991965AbdHNGVJMIDUt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Aug 2017 08:21:09 +0200
Received: by mail-io0-x242.google.com with SMTP id o9so7022495iod.5
        for <linux-mips@linux-mips.org>; Sun, 13 Aug 2017 23:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q7ER7trGYUQtmhvQ6605+zTKJoX1ljrxHLdhGj7NWOI=;
        b=J4llaWTk23bf75S7Kfn4MdXnby6x6cfFfbcP4SqsRjg4euWwrrsxVEDbUU/Cx2ElDl
         NHvMTaw+smTvOVDQPF4t11/qNuIXNn9814uWR97BbFxQKj+Y4IUfRVo1n7bIyp+rvwFf
         9cRo6scnLeSbCGqWhDgE1IS8b5QIXM4Lry22ZnB747GO4jNzVTcSc+R4L+e9fh/PWwBm
         Rg5L3oLz/aoGWmwlGkojulQeB1z287WycN07MjPlXAP/0pLhfDZq/blUrzJdAWFBzqAE
         DY32mNhZ7gNuFxs6G6Q1GIOLU+xDUsgL1YOM8G1rhAqojY3opzMerVAa2xnKhpL8xrBk
         RtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q7ER7trGYUQtmhvQ6605+zTKJoX1ljrxHLdhGj7NWOI=;
        b=mZu4X+uQuhVwwImP1jOFSN5Ujf9i8r+7HgjWsfX0arqQu1+rRwK1lf3FjQ4OyuSqO8
         +G5X+77+MqNN7jc1IX7cLRYRJ6wKcTZN2tbe7Zcnvn9yzF0TwTpa+SrnjobVKRL1Ed4A
         j3xl26T+Mb0O1M+x0322xwAHrc6SniAtaQmNNuvBTIV0e2MbZ0v+VZ259d1GYmIRQ1Lf
         JyU3e0Bczvkh0cZrio3wt8n8dy/JOM+YEaThoIadfE7YmWnx761AzorQsp5ju2oNLcO2
         8IxwzU2meLEg5YcfZOoualxqjKbPCFqkHOZv47Qj7u/cWI8m/b9ocxWm2iKEjrBxf3jl
         KIFw==
X-Gm-Message-State: AHYfb5i9hPkWYdbra+tAiLRHoMQ0ZvvOeRP10FMAc4UNgD4qwFadXMUx
        ZhnMgWRnvZKHGUWqtDNMdo69tSP+EQ==
X-Received: by 10.107.134.87 with SMTP id i84mr17221987iod.294.1502691663441;
 Sun, 13 Aug 2017 23:21:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.201.130 with HTTP; Sun, 13 Aug 2017 23:21:02 -0700 (PDT)
In-Reply-To: <20170813124435.24684-1-syq@debian.org>
References: <20170813124435.24684-1-syq@debian.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 14 Aug 2017 14:21:02 +0800
Message-ID: <CAAhV-H64Qt7QwR3nE7pm=oShb2QhajSyHGCZ+ky8=iuZ6C-1=A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Loongson fix name confict - MEM_RESERVED
To:     YunQiang Su <syq@debian.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        YunQiang Su <yunqiang.su@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

Hi, Yunqiang

Please rename it to SYSTEM_RAM_RESERVED, thanks.

Huacai

On Sun, Aug 13, 2017 at 8:44 PM, YunQiang Su <syq@debian.org> wrote:
> From: YunQiang Su <yunqiang.su@imgtec.com>
>
> MEM_RESERVED is used as a value of enum mem_type in
> include/linux/edac.h.
> This will make failure to build for Loongson in some case:
> for example with CONFIG_RAS enabled.
>
> So here rename MEM_RESERVED to LOONGSON_MEM_RESERVED in Loongson code.
> ---
>  arch/mips/include/asm/mach-loongson64/boot_param.h | 2 +-
>  arch/mips/loongson64/common/mem.c                  | 2 +-
>  arch/mips/loongson64/loongson-3/numa.c             | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
> index 9f9bb9c53785..595a949e5f47 100644
> --- a/arch/mips/include/asm/mach-loongson64/boot_param.h
> +++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
> @@ -3,7 +3,7 @@
>
>  #define SYSTEM_RAM_LOW         1
>  #define SYSTEM_RAM_HIGH                2
> -#define MEM_RESERVED           3
> +#define LOONGSON_MEM_RESERVED          3
>  #define PCI_IO                 4
>  #define PCI_MEM                        5
>  #define LOONGSON_CFG_REG       6
> diff --git a/arch/mips/loongson64/common/mem.c b/arch/mips/loongson64/common/mem.c
> index b01d52473da8..6c97dbe2cb85 100644
> --- a/arch/mips/loongson64/common/mem.c
> +++ b/arch/mips/loongson64/common/mem.c
> @@ -79,7 +79,7 @@ void __init prom_init_memory(void)
>                                         (u64)loongson_memmap->map[i].mem_size << 20,
>                                         BOOT_MEM_RAM);
>                                 break;
> -                       case MEM_RESERVED:
> +                       case LOONGSON_MEM_RESERVED:
>                                 add_memory_region(loongson_memmap->map[i].mem_start,
>                                         (u64)loongson_memmap->map[i].mem_size << 20,
>                                         BOOT_MEM_RESERVED);
> diff --git a/arch/mips/loongson64/loongson-3/numa.c b/arch/mips/loongson64/loongson-3/numa.c
> index f17ef520799a..3ceb401f7691 100644
> --- a/arch/mips/loongson64/loongson-3/numa.c
> +++ b/arch/mips/loongson64/loongson-3/numa.c
> @@ -166,7 +166,7 @@ static void __init szmem(unsigned int node)
>                         memblock_add_node(PFN_PHYS(start_pfn),
>                                 PFN_PHYS(end_pfn - start_pfn), node);
>                         break;
> -               case MEM_RESERVED:
> +               case LOONGSON_MEM_RESERVED:
>                         pr_info("Node%d: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx MB\n",
>                                 (u32)node_id, mem_type, mem_start, mem_size);
>                         add_memory_region((node_id << 44) + mem_start,
> --
> 2.14.1
>
>
