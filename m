Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 22:40:40 +0200 (CEST)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:32922
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994874AbdFPUkaxZK6s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 22:40:30 +0200
Received: by mail-qk0-x244.google.com with SMTP id u8so46259qka.0
        for <linux-mips@linux-mips.org>; Fri, 16 Jun 2017 13:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sfiij9njwarP3qmZrxoyqo0zJMdqUZICYoFUTxizFpU=;
        b=njtZQKcwTaurHqgNrrq5XsRkad4AKOtZkcM/eBJSuYppTERfBd4blY77/NhEo/ckMI
         hyzZZYcSi8Uzg3Ipf9AmPP4e3esTAGwwrfXvjp68Mg3sgX1KQiiY7TQJCqw94bd8GY61
         Z0MXKxXlEk5KohFWn1EN7rdGWJ/vGK1U48Rp5EvEsVgCiO+bYGB218P3NbHdCiKyk8AP
         jq5OgOiVzXyO4Or2ATPf6cw/cvovk90Q7SRZOLCuovtQDG4psx/kcsCGsv9BdCqAtZjo
         sKecC6QkK0BuQw0GNiCp79qxLqQ/2HG5t/WCdco+XGVTjrRx72FnQfCBsK4K7ZpUzEcF
         sQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sfiij9njwarP3qmZrxoyqo0zJMdqUZICYoFUTxizFpU=;
        b=O7XyHMdhEhnQo+ZAy7VM8+iv+HYg1yxmenKDD6aQuI3Du/YpRrqoGpjbtF9KnKL8xi
         njiGatzylVlshqorqTdC7BZjUhSSZVfx+kSwp6m+EUNFW+h0k4qwuhQndLRu1W0O4Mlq
         TyoVY1oR7Z0raQmUD3kQBuapEBZcRnh5rkvQ2I0ztPYfMxguewALUtfLxFn2y6ot1Osq
         +nL8GPBnAj6X5DHEKSBbf6n7t+vZ71DV6faK6F93U1r5bjzW9EEsufkZSWN81K2AGgBj
         U5pxEOgdT5GGinvN0TCgFL82W3gOZYNg/CVLfQUm6ZNhLcFMJkhB9GEIVZJxRjYY35F3
         7XOQ==
X-Gm-Message-State: AKS2vOyDDnKXVpoeDO7yaZJZ03S1DO/jQwxX18Jqidfahui3AfF8Zuey
        JbNVKWG3i9iI0lviOPtbztjQmgKjQw==
X-Received: by 10.55.52.21 with SMTP id b21mr3851944qka.10.1497645624814; Fri,
 16 Jun 2017 13:40:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.39.144 with HTTP; Fri, 16 Jun 2017 13:40:24 -0700 (PDT)
In-Reply-To: <20170616181059.19206-4-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de> <20170616181059.19206-4-hch@lst.de>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 16 Jun 2017 13:40:24 -0700
Message-ID: <CAKgT0UdxrimWrxNVsLMQ9G6ABBJZwfWHTcP18qqd4rT0Fa-KWg@mail.gmail.com>
Subject: Re: [PATCH 03/44] dmaengine: ioat: don't use DMA_ERROR_CODE
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <alexander.duyck@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.duyck@gmail.com
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

On Fri, Jun 16, 2017 at 11:10 AM, Christoph Hellwig <hch@lst.de> wrote:
> DMA_ERROR_CODE is not a public API and will go away.  Instead properly
> unwind based on the loop counter.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> Acked-By: Vinod Koul <vinod.koul@intel.com>
> ---
>  drivers/dma/ioat/init.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 6ad4384b3fa8..ed8ed1192775 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -839,8 +839,6 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
>                 goto free_resources;
>         }
>
> -       for (i = 0; i < IOAT_NUM_SRC_TEST; i++)
> -               dma_srcs[i] = DMA_ERROR_CODE;
>         for (i = 0; i < IOAT_NUM_SRC_TEST; i++) {
>                 dma_srcs[i] = dma_map_page(dev, xor_srcs[i], 0, PAGE_SIZE,
>                                            DMA_TO_DEVICE);
> @@ -910,8 +908,6 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
>
>         xor_val_result = 1;
>
> -       for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++)
> -               dma_srcs[i] = DMA_ERROR_CODE;
>         for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++) {
>                 dma_srcs[i] = dma_map_page(dev, xor_val_srcs[i], 0, PAGE_SIZE,
>                                            DMA_TO_DEVICE);
> @@ -965,8 +961,6 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
>         op = IOAT_OP_XOR_VAL;
>
>         xor_val_result = 0;
> -       for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++)
> -               dma_srcs[i] = DMA_ERROR_CODE;
>         for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++) {
>                 dma_srcs[i] = dma_map_page(dev, xor_val_srcs[i], 0, PAGE_SIZE,
>                                            DMA_TO_DEVICE);
> @@ -1017,18 +1011,14 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
>         goto free_resources;
>  dma_unmap:
>         if (op == IOAT_OP_XOR) {
> -               if (dest_dma != DMA_ERROR_CODE)
> -                       dma_unmap_page(dev, dest_dma, PAGE_SIZE,
> -                                      DMA_FROM_DEVICE);
> -               for (i = 0; i < IOAT_NUM_SRC_TEST; i++)
> -                       if (dma_srcs[i] != DMA_ERROR_CODE)
> -                               dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE,
> -                                              DMA_TO_DEVICE);
> +               while (--i >= 0)
> +                       dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE,
> +                                      DMA_TO_DEVICE);
> +               dma_unmap_page(dev, dest_dma, PAGE_SIZE, DMA_FROM_DEVICE);
>         } else if (op == IOAT_OP_XOR_VAL) {
> -               for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++)
> -                       if (dma_srcs[i] != DMA_ERROR_CODE)
> -                               dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE,
> -                                              DMA_TO_DEVICE);
> +               while (--i >= 0)
> +                       dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE,
> +                                      DMA_TO_DEVICE);

Wouldn't it make more sense to pull out the while loop and just call
dma_unmap_page on dest_dma if "op == IOAT_OP_XOR"? Odds are it is what
the compiler is already generating and will save a few lines of code
so what you end up with is something like:
    while (--i >= 0)
        dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE, DMA_TO_DEVICE);
    if (op == IOAT_OP_XOR)
        dma_unmap_page(dev, dest_dma, PAGE_SIZE, DMA_FROM_DEVICE);

>         }
>  free_resources:
>         dma->device_free_chan_resources(dma_chan);
> --
> 2.11.0
>
