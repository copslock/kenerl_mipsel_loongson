Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jan 2018 08:49:49 +0100 (CET)
Received: from mail-qk0-x242.google.com ([IPv6:2607:f8b0:400d:c09::242]:34802
        "EHLO mail-qk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990754AbeACHtmgDu5i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jan 2018 08:49:42 +0100
Received: by mail-qk0-x242.google.com with SMTP id g81so615107qke.1
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 23:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dg1gZQ0XTPl5ik865QhgMxj2iYnvoVLLg0Ri4903uJ4=;
        b=UQUCMDYTa6Xir3yzlWynpdu5ZxwVqJkJqkGHy9g61baXK0r6dv8OcyPAGJ+1WoxIwS
         IDsSaywI5gpGGex2l+3JD9ZfHtzLePQS13BKIe8nXZ4GhunrN83t+KO9A8+HppZ1a+8e
         dOiFjt0Qj0aKNR67MQWmJH2YwNL4bxRdhj92HDX4muLFujZQ7XWovpYKMhNXFwpcz8tX
         tRg6wY90t4s2xBD5NHiz4m3BfRe+wF9QVZdazO0cPDmQwpUunuyoR9PQMj58oLJQbM62
         kQaGI9XnmEtm3arUBS+KLMzGtLcJ4eJe6mdi8QZgrgsxMCVzWcXrsv9y+4woGCUhGCCp
         H+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=dg1gZQ0XTPl5ik865QhgMxj2iYnvoVLLg0Ri4903uJ4=;
        b=CcsbIxGo4ccp/1hPV/PhCQYm7WKBiCkMnL+4AVwBXrjDR6sZMESONrNjrybQk2oobF
         joSXh4DbpL1CiakQBmr558zmv8JdpUapDRFwrF7TSyIGcZxvNVBH/b9fMv8bm9Ccz12X
         gYMaCwIEaHKugorRfAIBTACaOljISMC09ejesl/voBPEhGXYXuuTu+Z/1eJdNmfOXFq6
         0rf2BB1AWMZE6cWuuYPkRxOjtgt2NumUpMV0Oh0GImo9fPxGICZtQVlqwFBet6dz5ZcL
         YW2h9adP3EoGILqXGPfORYhQ8NnO1iKIfpHueWjdPIN0MTqzyuDSQPKiTerEEfYYIXTR
         fHDQ==
X-Gm-Message-State: AKGB3mLClXI3do+jqpS2Yk1x3EzLpVe4khBs3n1wGi93WsmnqinzjfNX
        5qSGLvM9Jfm7cGZrV2bmhn+Ub899wDV2TMgHGBI=
X-Google-Smtp-Source: ACJfBosjKbQ3lZy+Ip0KcMk6EGDf7VZMtuMoPU4vodAfZ0xh/mp9uKJMqwr3QljTEFf2n85CWmBPVY3pXtHAmk/D7nI=
X-Received: by 10.55.75.19 with SMTP id y19mr723121qka.45.1514965776374; Tue,
 02 Jan 2018 23:49:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.44.66 with HTTP; Tue, 2 Jan 2018 23:49:35 -0800 (PST)
In-Reply-To: <87h8s3cvel.fsf@concordia.ellerman.id.au>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-17-hch@lst.de>
 <878tdgtwzp.fsf@concordia.ellerman.id.au> <CAMuHMdWWus2kNSOzS94k-3678826W1YjKwCWTquu3hBLZ80cvw@mail.gmail.com>
 <87h8s3cvel.fsf@concordia.ellerman.id.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 Jan 2018 08:49:35 +0100
X-Google-Sender-Auth: oqSUvd2ZdU5LGG2QV3eD-O97YFc
Message-ID: <CAMuHMdWYDz_jHNxQ-B8944520R-myzHkjkL1rKWUjA38inU7cw@mail.gmail.com>
Subject: Re: [PATCH 16/67] powerpc: rename dma_direct_ to dma_nommu_
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
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
X-archive-position: 61885
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

Hi Michael,

On Wed, Jan 3, 2018 at 7:24 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
>> On Tue, Jan 2, 2018 at 10:45 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> Christoph Hellwig <hch@lst.de> writes:
>>>
>>>> We want to use the dma_direct_ namespace for a generic implementation,
>>>> so rename powerpc to the second best choice: dma_nommu_.
>>>
>>> I'm not a fan of "nommu". Some of the users of direct ops *are* using an
>>> IOMMU, they're just setting up a 1:1 mapping once at init time, rather
>>> than mapping dynamically.
>>>
>>> Though I don't have a good idea for a better name, maybe "1to1",
>>> "linear", "premapped" ?
>>
>> "identity"?
>
> I think that would be wrong, but thanks for trying to help :)
>
> The address on the device side is sometimes (often?) offset from the CPU
> address. So eg. the device can DMA to RAM address 0x0 using address
> 0x800000000000000.
>
> Identity would imply 0 == 0 etc.
>
> I think "bijective" is the correct term, but that's probably a bit
> esoteric.

OK, didn't know about the offset.
Then "linear" is what we tend to use, right?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
