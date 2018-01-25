Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jan 2018 12:04:54 +0100 (CET)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:38974
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992827AbeAYLEonmGyS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Jan 2018 12:04:44 +0100
Received: by mail-io0-x244.google.com with SMTP id b198so8238601iof.6;
        Thu, 25 Jan 2018 03:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EfUwLSkFGdLbW+sKYY8pVnCUXP7goMNRLf4zRcFGmPg=;
        b=sojC8CeaMXIFDGUpdx1Enaj7qGGHiVzyDGHrlN+ff+qMtgen/meLTavYw6PqRR9VOM
         sSYkbbDNZ0U+cSYwE1gLIx+9adSgGRoxLn1IBlYlK7ofQgtDqfu7HzXtd+PB3NTvkYM7
         w+8p985HCJUx1bnOys+Dx7CTgpyrnJ3vLxgos/Qvul3+DPYFcuJGu7o0ZNlEJcL2X4Gg
         3kPud8aZSzSgL7mVIOkONOhFsVuSTxsrScTytoZrhUh7GlrtT48qIV4hU1PEPD4jXHzd
         0UUvQMS5PDVRZC8AbE5OJcgmv4Juwl/KC++aNHXpzPZdoJp6rhTxnS3DymTJqtMgcvuc
         TCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EfUwLSkFGdLbW+sKYY8pVnCUXP7goMNRLf4zRcFGmPg=;
        b=p9y2kDZN81bwbGNdwVO4aArxggU1pSEWEMeyn9kCfxw8CZRgm7sWYc8GgYdagQAdJp
         eWbvGXDSmB66tbEUCi7K61q8bydWS/WNJ0HbolitXxuNM+W4tyoPKH4Uha1Y4zA58nXA
         fdiaOYrTmzuxSej4HYxptRDycbG/FCNONu3Bthk3sQVhxuZiMo4d/Jo4GCslCGcMzZwe
         h7y5PZrG/6WHw8uOHJVu1mk0Bo6O72emLf/ofBYP7shQgbIwuUpsoNkjQDQxj1f8U+Pn
         44vJIKQ2c7UGJImBr5xCRwj63kXLlv2gHolllwFRf1wHWBJP9CToD/jIszBmQ2hXJHEE
         oyCw==
X-Gm-Message-State: AKwxytd7EsKvjIceyzRyaO4MmoRNyxvxX7HtJ9+njLb9TVNnJP7g+Oze
        0nfjfzuRlSZblUMwaVsY4BMuNp167tV8/2s7YoQ=
X-Google-Smtp-Source: AH8x227a1brb3dIhn+cHgqT75x8+/Jog00HBBtixEkoPuiHELWc65NZVhH0wS5SdvMMC+AI2IPGabrgoA53iTzSCBGg=
X-Received: by 10.107.83.12 with SMTP id h12mr4165368iob.277.1516878278363;
 Thu, 25 Jan 2018 03:04:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.51.212 with HTTP; Thu, 25 Jan 2018 03:04:37 -0800 (PST)
In-Reply-To: <20180125105449.GL5446@saruman>
References: <1510821355-24694-1-git-send-email-chenhc@lemote.com>
 <20180124140234.GF5446@saruman> <20180124141144.GB25393@lst.de>
 <20180124150304.GG5446@saruman> <20180124152904.GA29244@lst.de>
 <CAAhV-H7YgzqwLPS4SrhGbqdHmLTaHV9mgwXYdY-MU_=yw8HDdA@mail.gmail.com>
 <20180125075520.GA3270@saruman> <CAAhV-H7i8PZtn7JMgzCW3nseH-rwtcc_H6_9n+pOE4DU5i1KAg@mail.gmail.com>
 <20180125105449.GL5446@saruman>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Thu, 25 Jan 2018 19:04:37 +0800
X-Google-Sender-Auth: x-mV-bkGCWnMvfJDHn-jyYsjd68
Message-ID: <CAAhV-H5F3tzezN1BJ=NzYpfVPi3UCFpzQ=48mOS5ZFjVBcGyKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Loongson64: Add cache_sync to loongson_dma_map_ops
To:     James Hogan <jhogan@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

If call dma_cache_sync() is incorrect, then which is the correct way?
1, call mips_dma_cache_sync()?
2, remove static of __dma_sync_virtual() and call it?

Huacai

On Thu, Jan 25, 2018 at 6:54 PM, James Hogan <jhogan@kernel.org> wrote:
> On Thu, Jan 25, 2018 at 04:44:36PM +0800, Huacai Chen wrote:
>> On Thu, Jan 25, 2018 at 3:55 PM, James Hogan <jhogan@kernel.org> wrote:
>> > Hi Huacai,
>> >
>> > On Thu, Jan 25, 2018 at 03:09:33PM +0800, Huacai Chen wrote:
>> >> Hi, James and Christoph,
>> >>
>> >> We have modified arch/mips/loongson64/common/dma-swiotlb.c to make
>> >> Loongson support coherent&non-coherent devices co-exist. You can see
>> >> code here:
>> >> https://github.com/linux-loongson/linux-loongson/commit/3f212e36b2432a7c4a843649e4b79c9c0837d1d2
>> >> When device is non-coherent, we will call dma_cache_sync().
>> >>
>> >> Then, if dma_cache_sync() is only designed for
>> >> DMA_ATTR_NON_CONSISTENT, what can I use?
>> >
>> > How did you allocate the memory? The appropriate generic API for the
>> > type of memory should always be used in drivers over arch specific
>> > stuff.
>> >
>> > AFAIK (see e.g. Documentation/DMA-API.txt):
>> > - dma_alloc_coherent() shouldn't require syncing, though it may require
>> >   flushing of write combiners
>> > - dma_alloc_attrs() only requires syncing when DMA_ATTR_NON_CONSISTENT
>> >   is used, otherwise is the same as dma_alloc_coherent()
>> > - guaranteed contiguous memory within PA range (e.g. kmalloc()'d memory
>> >   with the appropriate GFP_DMA flags) can be synced using the
>> >   dma_map_*() and dma_unmap_*() functions.
>
> I also see there is a dma_sync_*_for_{cpu,device} to avoid "mapping" and
> "unmapping" the same area repeatedly if it is reused.
>
>> Yes, kmalloc()'d memory with the appropriate GFP_DMA flags can be
>> synced using the dma_map_*() and dma_unmap_*() functions. So,
>> loongson_dma_map_page()/loongson_dma_unmap_page() (which is the
>> backend of dma_map_*() and dma_unmap_*()) should call dma_cache_sync()
>> for non-coherent devices, right?
>
> Yeh, I suppose thats effectively what it should do (though probably via
> an arch specific function rather than dma_cache_sync() itself). Also the
> sync_*_for_{cpu,device} callbacks should probably do it too. See all the
> calls to __dma_sync() in the MIPS dma-default.c implementation.
>
> Cheers
> James
>
>>
>> Huacai
>>
>> >
>> > Cheers
>> > James
>> >
>> >> 1, __dma_sync_virtual() and __dma_sync() are both static functions, so
>> >> can't be called in other files.
>> >> 2, mips_dma_cache_sync() is not static, but I think it isn't designed
>> >> to be called directly (So it should be static).
>> >> 3, dma_cache_wback(), dma_cache_inv() and dma_cache_wback_inv() does't
>> >> take a "direction" argument, so I should determine the direction first
>> >> (then I will reimplement __dma_cache_sync for myself).
>> >> So, It seems that I can only use dma_cache_sync().
>> >>
>> >> Huacai
>> >>
>> >> On Wed, Jan 24, 2018 at 11:29 PM, Christoph Hellwig <hch@lst.de> wrote:
>> >> > On Wed, Jan 24, 2018 at 03:03:05PM +0000, James Hogan wrote:
>> >> >> I see, that makes sense. Thanks Christoph. I'll assume this patch isn't
>> >> >> applicable then unless Huacai adds some explanation.
>> >> >
>> >> > In addition there also is no driver that can be used on loongsoon
>> >> > that actually calls dma_cache_sync either.
>> >> >
