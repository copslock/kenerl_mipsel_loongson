Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jan 2018 09:44:51 +0100 (CET)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:45597
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992827AbeAYIonPwSDj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Jan 2018 09:44:43 +0100
Received: by mail-it0-x243.google.com with SMTP id x42so8385560ita.4;
        Thu, 25 Jan 2018 00:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Qtxhy5mac01247851cWWnOACr62nW0w0ocd+zd9bAJY=;
        b=qFOKAR/HPlLGCgKYZ4yMkkIIJ1indOT0HfbYYII6l9Tm8Gd/k0rmN9QaBWBCvYF1PH
         VF7FwCaIL7+xDFGU+/A8Y/hrl7M2agndict7uipmmsejkZHE9P4hc1A1Zvtiz3j8erC4
         rWq6ZKVNHiMYwabV8G2B5P2GIMuTPaTNQYvWDb1vUsSBgrRYxxwihxY8G58Pwi2W16VS
         vUdSnj5N0satVb02vnjPbmOWfOh0JRDzbUdpdiSXh/NavIWK9bRHC7FZqGEuaDEzTeKW
         /KQ+onFK2rc1+WyAXQRW068OeEtAWsSotXs86tBD4F7Jdsq6sdUHzNDJWE6uaz0ckwSf
         IuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Qtxhy5mac01247851cWWnOACr62nW0w0ocd+zd9bAJY=;
        b=GAKAif2X+xqMAb8VDqb7NnhfAGSZCgnqRWGZrAzHeL2aQxpqLQ0NJIuUCSf10fWHDZ
         BsT/QLLSqf0X2N3hoM2oejyG8lDxuC+zXGp5jiYItcOO069ddsFfGJ6pdskZGWRJ/o+x
         63ef+uaDyIV2Av+J84/vo3s+wLL8gr7HRK45bPBscV9eXxI+G/gEfmhxHh1eFp8+YFxv
         joQC5L8Y/jdWvJTO4iFBchoEGpzSiD5Dhxxi8YRDfBrzY6TO21zRk/dK1s10svxZaRH9
         wQwOO76vFRFXs1f5wnIkuGOmJQ3LLYi25ccDkTDkkFsaLiaDbOiRnQ7aGZ2ecTqerfHp
         Ta8Q==
X-Gm-Message-State: AKwxytcYX14hDk7cc66RICN1DoCJ+TkQlOzZ6/mW0f5ggZqP1qTv3k8y
        dfSTkG2eoJkWLiR1oP1sL4o5bWmLY9aEuXXMUh8=
X-Google-Smtp-Source: AH8x226+xis4nyQKPg3BMj7KVU3wMeHa0g3/RXKSY2p53kLw8FD7CEk3/XjNdULW2106cg+w+wOPozDHhoQ4ZRMaIRc=
X-Received: by 10.36.240.72 with SMTP id p8mr12108864iti.104.1516869876972;
 Thu, 25 Jan 2018 00:44:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.51.212 with HTTP; Thu, 25 Jan 2018 00:44:36 -0800 (PST)
In-Reply-To: <20180125075520.GA3270@saruman>
References: <1510821355-24694-1-git-send-email-chenhc@lemote.com>
 <20180124140234.GF5446@saruman> <20180124141144.GB25393@lst.de>
 <20180124150304.GG5446@saruman> <20180124152904.GA29244@lst.de>
 <CAAhV-H7YgzqwLPS4SrhGbqdHmLTaHV9mgwXYdY-MU_=yw8HDdA@mail.gmail.com> <20180125075520.GA3270@saruman>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Thu, 25 Jan 2018 16:44:36 +0800
X-Google-Sender-Auth: hYiySU8qFeZvF5yCUkHV0-_Cpc0
Message-ID: <CAAhV-H7i8PZtn7JMgzCW3nseH-rwtcc_H6_9n+pOE4DU5i1KAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Loongson64: Add cache_sync to loongson_dma_map_ops
To:     James Hogan <jhogan@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Jayachandran C <jchandra@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62325
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

On Thu, Jan 25, 2018 at 3:55 PM, James Hogan <jhogan@kernel.org> wrote:
> Hi Huacai,
>
> On Thu, Jan 25, 2018 at 03:09:33PM +0800, Huacai Chen wrote:
>> Hi, James and Christoph,
>>
>> We have modified arch/mips/loongson64/common/dma-swiotlb.c to make
>> Loongson support coherent&non-coherent devices co-exist. You can see
>> code here:
>> https://github.com/linux-loongson/linux-loongson/commit/3f212e36b2432a7c4a843649e4b79c9c0837d1d2
>> When device is non-coherent, we will call dma_cache_sync().
>>
>> Then, if dma_cache_sync() is only designed for
>> DMA_ATTR_NON_CONSISTENT, what can I use?
>
> How did you allocate the memory? The appropriate generic API for the
> type of memory should always be used in drivers over arch specific
> stuff.
>
> AFAIK (see e.g. Documentation/DMA-API.txt):
> - dma_alloc_coherent() shouldn't require syncing, though it may require
>   flushing of write combiners
> - dma_alloc_attrs() only requires syncing when DMA_ATTR_NON_CONSISTENT
>   is used, otherwise is the same as dma_alloc_coherent()
> - guaranteed contiguous memory within PA range (e.g. kmalloc()'d memory
>   with the appropriate GFP_DMA flags) can be synced using the
>   dma_map_*() and dma_unmap_*() functions.

Yes, kmalloc()'d memory with the appropriate GFP_DMA flags can be
synced using the dma_map_*() and dma_unmap_*() functions. So,
loongson_dma_map_page()/loongson_dma_unmap_page() (which is the
backend of dma_map_*() and dma_unmap_*()) should call dma_cache_sync()
for non-coherent devices, right?

Huacai

>
> Cheers
> James
>
>> 1, __dma_sync_virtual() and __dma_sync() are both static functions, so
>> can't be called in other files.
>> 2, mips_dma_cache_sync() is not static, but I think it isn't designed
>> to be called directly (So it should be static).
>> 3, dma_cache_wback(), dma_cache_inv() and dma_cache_wback_inv() does't
>> take a "direction" argument, so I should determine the direction first
>> (then I will reimplement __dma_cache_sync for myself).
>> So, It seems that I can only use dma_cache_sync().
>>
>> Huacai
>>
>> On Wed, Jan 24, 2018 at 11:29 PM, Christoph Hellwig <hch@lst.de> wrote:
>> > On Wed, Jan 24, 2018 at 03:03:05PM +0000, James Hogan wrote:
>> >> I see, that makes sense. Thanks Christoph. I'll assume this patch isn't
>> >> applicable then unless Huacai adds some explanation.
>> >
>> > In addition there also is no driver that can be used on loongsoon
>> > that actually calls dma_cache_sync either.
>> >
