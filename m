Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jan 2018 08:09:47 +0100 (CET)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:35603
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992821AbeAYHJkwt12U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Jan 2018 08:09:40 +0100
Received: by mail-io0-x244.google.com with SMTP id m11so7597200iob.2;
        Wed, 24 Jan 2018 23:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yQbvIUfEC3mXEtI9XOYk9vP02ud+S2XLlXjOoJca3eY=;
        b=nYnBkiBQ4Ynw5JgOLu5brRbJ+KYaOYi0ZwepT7zF3R+VIfTvdrpbxHqmBFtsTV82ky
         TqKBQiEDlX/A1faQH/kSa/UV1lHCmOGKFA7NquRUWkHvzVZfzl0rIbb7liVqNxU9gYUy
         4KX3TGT16FOKWfVVp76W0DiYRMMezRkK6Me3VDsPQzdjB0ox/fAERUs/W2BfZ0IBw0+g
         +egInCiY++iftOi+xY1SJzItPp6PYhhSb6609oLOL9u/cGI/AgaRbhBoz20F4T3gViVy
         f+gt18MX8ta5IU/IDM1SDm/Tj0qfeFKXze1dVijsTC8FqzgaPUvEtjWp+Kva/37HG+M8
         o7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yQbvIUfEC3mXEtI9XOYk9vP02ud+S2XLlXjOoJca3eY=;
        b=Rn6rx7Ob7APu1BBBxHR062l+/8Co4piNIx4Yl837PInMokyWY2m/LSiXTPgdWHEBlX
         7XZ1eIctAnAnPo5Is7XS1phOCH6N7tXQn/Hsl5VProkDi3jeLMNwMUMG/yV5RnWYpFvC
         hW9qwY2zm+djkJrm0mmJnzyZtp5a3Iwl/yK6J+AuhQarfiHacrJePO6qlUFSApJoq9st
         fVyJ2iW5uVhFdzISpbX57LZketLHEYk4x3vy3FJtUOupMheLCZ1vCANJm3E2/k8sLtME
         HE09Q8kOClh3tHXfovuBkoU3C3stvb1rVyBskEQdBae+8fIbnb9hyS3UvF92H4P4OvEI
         80YA==
X-Gm-Message-State: AKwxytcl+tKYuDbZbVNRCYah7BgAfha4ZmC/E0y1+nFejti5qIeNX8OQ
        XuMLZLOWGdEQZpXd/1Xj/saimh162kj41B1hbg8=
X-Google-Smtp-Source: AH8x226T1IDW/Z7ddSOIsSpOhdPP95rw1yHKgKZzc/tVZB3aXeph1mM0wfnGBzNKKhdjLYdBF9qlrPbr3GX+M2g3RJI=
X-Received: by 10.107.182.67 with SMTP id g64mr5044795iof.150.1516864174378;
 Wed, 24 Jan 2018 23:09:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.51.212 with HTTP; Wed, 24 Jan 2018 23:09:33 -0800 (PST)
In-Reply-To: <20180124152904.GA29244@lst.de>
References: <1510821355-24694-1-git-send-email-chenhc@lemote.com>
 <20180124140234.GF5446@saruman> <20180124141144.GB25393@lst.de>
 <20180124150304.GG5446@saruman> <20180124152904.GA29244@lst.de>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Thu, 25 Jan 2018 15:09:33 +0800
X-Google-Sender-Auth: t4QtFCGgCfCwgeVOoXNbGCmu6y4
Message-ID: <CAAhV-H7YgzqwLPS4SrhGbqdHmLTaHV9mgwXYdY-MU_=yw8HDdA@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Loongson64: Add cache_sync to loongson_dma_map_ops
To:     Christoph Hellwig <hch@lst.de>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
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
X-archive-position: 62323
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

Hi, James and Christoph,

We have modified arch/mips/loongson64/common/dma-swiotlb.c to make
Loongson support coherent&non-coherent devices co-exist. You can see
code here:
https://github.com/linux-loongson/linux-loongson/commit/3f212e36b2432a7c4a843649e4b79c9c0837d1d2
When device is non-coherent, we will call dma_cache_sync().

Then, if dma_cache_sync() is only designed for
DMA_ATTR_NON_CONSISTENT, what can I use?
1, __dma_sync_virtual() and __dma_sync() are both static functions, so
can't be called in other files.
2, mips_dma_cache_sync() is not static, but I think it isn't designed
to be called directly (So it should be static).
3, dma_cache_wback(), dma_cache_inv() and dma_cache_wback_inv() does't
take a "direction" argument, so I should determine the direction first
(then I will reimplement __dma_cache_sync for myself).
So, It seems that I can only use dma_cache_sync().

Huacai

On Wed, Jan 24, 2018 at 11:29 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Jan 24, 2018 at 03:03:05PM +0000, James Hogan wrote:
>> I see, that makes sense. Thanks Christoph. I'll assume this patch isn't
>> applicable then unless Huacai adds some explanation.
>
> In addition there also is no driver that can be used on loongsoon
> that actually calls dma_cache_sync either.
>
