Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 15:12:40 +0100 (CET)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:33401
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990421AbdL2OMdDfgS8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 15:12:33 +0100
Received: by mail-qt0-x241.google.com with SMTP id e2so54386872qti.0
        for <linux-mips@linux-mips.org>; Fri, 29 Dec 2017 06:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CngtFWMFI86iVviEXbcdKS12rxLXJpnUsJdUNn4d4fY=;
        b=XQnFdxGErOrDh/3KFwv/XPRIM7J3z3aoW8EU5Mp0bwyGaK5oU6UA7k+/HeXnIMgOlK
         291ZzntnkxO4scZr3KkjYRSfMxxxRDEYcyv2LF1AYmaAKld/MPufIR70rfOQFZPdQRLV
         P+PJiK7RbTb9KWovxL6D0c0YAYVjeAIcaKMxVBtb9xwVze+NSUfk/CEqXQlKYqc36P/C
         fj1NKQ4r4KA3J+/6KZYyO6xAQavfbqFBxiGRGgk1MsVf8aV58DkPeXmM4EizSmstv3kO
         ewqEVNhC/VVCr1zcXk5fLG7W9cYXRduTJ/Pv6DIjo0R/rM9LW4iWm+6QLNGi7HY6yO6S
         XTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CngtFWMFI86iVviEXbcdKS12rxLXJpnUsJdUNn4d4fY=;
        b=DULBto5ZBHD0rNU+1W2ZDd81BydMkenqWPnbSZ6VMXBuLvhCyxqfrL/cNKTCUkYRvg
         EuhYe/y819PG62iOksGdaTkJ5txYEO133q8ZPDFQQIm9G3AN39gZR0GfnnWjESi8Jmlo
         /IV1t98DUIaAuj0lTicf2CehvZpK3r99ifLDS9P5Zz1CFX+0wLLK+iXGiR/p3sqDbVJk
         afWVsQly5PoIhW/QwGgCa4hJXGgxDjJ7KzMVCosDWAv/6P+JsniUyh2bqq+tDXXONCOU
         pWmWNRGCUG0eSiGDfoFc9403CO+vrpa+3/5Te8W6pLfamr1zj6L2K4A6G2G0oEyvI9kD
         4E2g==
X-Gm-Message-State: AKGB3mLeJddNndBpueGUs27sT8G59Poly3bi17dD6VM2thBpB/zCzfeN
        bL2ZitPvoNs7RSh+E+VmMJE4yM7cSC0L/6Bf9ZM=
X-Google-Smtp-Source: ACJfBovbKDYHP2tEuLC+oXYEgrMRmyfC86fqPCDurJwWv062BWk2C1V0wjv4P1DNn2Sbjmn9z2J8WfxjjoUe379cy7w=
X-Received: by 10.200.3.65 with SMTP id w1mr48268845qtg.297.1514556747046;
 Fri, 29 Dec 2017 06:12:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.44.66 with HTTP; Fri, 29 Dec 2017 06:12:25 -0800 (PST)
In-Reply-To: <20171229081911.2802-28-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-28-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Dec 2017 15:12:25 +0100
X-Google-Sender-Auth: wcKVmMK08b2zo5wlCfuCt2n51Yw
Message-ID: <CAMuHMdWg3PnTXezMCcr3oGf-83-cjvcj4wGiPk7j2pY1Tgzo9Q@mail.gmail.com>
Subject: Re: [PATCH 27/67] dma-direct: add dma address sanity checks
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        patches@groups.riscv.org,
        "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Cris <linux-cris-kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi Christoph,

On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> Roughly based on the x86 pci-nommu implementation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for your patch!

> --- a/lib/dma-direct.c
> +++ b/lib/dma-direct.c
> @@ -9,6 +9,24 @@
>  #include <linux/scatterlist.h>
>  #include <linux/pfn.h>
>
> +#define DIRECT_MAPPING_ERROR           0
> +
> +static bool
> +check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
> +               const char *caller)
> +{
> +       if (unlikely(dev && !dma_capable(dev, dma_addr, size))) {
> +               if (*dev->dma_mask >= DMA_BIT_MASK(32)) {
> +                       dev_err(dev,
> +                               "%s: overflow %llx+%zu of device mask %llx\n",

Please use "%pad" to format dma_addr_t ...

> +                               caller, (long long)dma_addr, size,

... and use &dma_addr.

> +                               (long long)*dev->dma_mask);

This cast is not needed, as u64 is unsigned long long in kernelspace on
all architectures.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
