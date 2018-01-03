Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jan 2018 09:20:19 +0100 (CET)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:45153
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992105AbeACIUMeg1Yi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jan 2018 09:20:12 +0100
Received: by mail-wr0-x241.google.com with SMTP id o15so737868wrf.12
        for <linux-mips@linux-mips.org>; Wed, 03 Jan 2018 00:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sMfETgmfI7U8AQjGPwtH0IDmQDFB2DTP74LNtFVnKSo=;
        b=FQ9+QZTD8Udp9egL79r8e672KMsgHB6avzwNdtNCuhW9KroGPsHnlxTiSNAr3ZBz4a
         Qndv3jQ5CGLe9ZFCXyx0qDzZiWCnYt3poQnHocznkL7Ln/tcrx8RjfX8zTy76SG2XWct
         tR742tSk3XiGgjz0SMXsrjSyqk8b42NcJXlwr9+V+zabv939Yf4XIPYzVDO7oGMlIi7B
         kbxQiMEJ/a/5UVl+asevb6ZYMFucrefgqLs5PYfyrhbzTTMl4nzyFz4G6TjwHN/UT/S2
         Mq6qGneEihhwfZaiEbN/MoN3jM8aDMXX/I3qbRVjnAccNGHLhkYEKm2OQWc4B8r6YHsA
         sgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sMfETgmfI7U8AQjGPwtH0IDmQDFB2DTP74LNtFVnKSo=;
        b=Qw2fH+KeYQxfCC+18pIvoi1cktkpqrLAq/z0ArJIyXv35zh2Si1PuDTWiLBaqGi3Dy
         U/jvbYoMSYPZBRQaWluApd9Mms90ruKSoij2WEr8yGoFbRzESLI8Kis33qaun7w7ugYe
         YEbDk+nrcui1FYIQvGwbK/R9LG1CR5R5+fljIKeJFH8brKshpxzcJUpuMxeSMI3a6jiX
         DqWcy0WagcsXtCjtgFwEMq6knARrL17cGbB2L8G7eSvd/uUdmWnWvoxAJ7VQMG3SQNiy
         5+hh6bdl4H4GUEGasv/L0fv05tI5dNcdpeYUuGqTDfRQVQky8ZYBqtm8Su65edEvR1+X
         tI6A==
X-Gm-Message-State: AKGB3mLl5f4SgzCz5RqAI/yykRuEC3MvtyViiaBUcZnTZClRUlf2Fr5T
        035U8/45/ULdZvClT5axNrE9gfaSk8KyT44nvvk=
X-Google-Smtp-Source: ACJfBovkxcUik9Pw0e4DTBdVebqLIFW6U84Gz81Ne7r1ZhLu1BPxwuTdJ8+XabVZBGC9/QEtqP9RocDmEzlnzUOnvdk=
X-Received: by 10.223.195.99 with SMTP id e32mr730691wrg.10.1514967607103;
 Wed, 03 Jan 2018 00:20:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.153.163 with HTTP; Wed, 3 Jan 2018 00:19:46 -0800 (PST)
In-Reply-To: <CAMuHMdWYDz_jHNxQ-B8944520R-myzHkjkL1rKWUjA38inU7cw@mail.gmail.com>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-17-hch@lst.de>
 <878tdgtwzp.fsf@concordia.ellerman.id.au> <CAMuHMdWWus2kNSOzS94k-3678826W1YjKwCWTquu3hBLZ80cvw@mail.gmail.com>
 <87h8s3cvel.fsf@concordia.ellerman.id.au> <CAMuHMdWYDz_jHNxQ-B8944520R-myzHkjkL1rKWUjA38inU7cw@mail.gmail.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Wed, 3 Jan 2018 19:19:46 +1100
Message-ID: <CAGRGNgV+DnZAAtiE5oe8rxp4=_JHJrtSQc8F5jrgN0rgYKfwjA@mail.gmail.com>
Subject: Re: [PATCH 16/67] powerpc: rename dma_direct_ to dma_nommu_
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org,
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
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Cris <linux-cris-kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <julian.calaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julian.calaby@gmail.com
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

Hi All,

On Wed, Jan 3, 2018 at 6:49 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Michael,
>
> On Wed, Jan 3, 2018 at 7:24 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>
>>> On Tue, Jan 2, 2018 at 10:45 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>>> Christoph Hellwig <hch@lst.de> writes:
>>>>
>>>>> We want to use the dma_direct_ namespace for a generic implementation,
>>>>> so rename powerpc to the second best choice: dma_nommu_.
>>>>
>>>> I'm not a fan of "nommu". Some of the users of direct ops *are* using an
>>>> IOMMU, they're just setting up a 1:1 mapping once at init time, rather
>>>> than mapping dynamically.
>>>>
>>>> Though I don't have a good idea for a better name, maybe "1to1",
>>>> "linear", "premapped" ?
>>>
>>> "identity"?
>>
>> I think that would be wrong, but thanks for trying to help :)
>>
>> The address on the device side is sometimes (often?) offset from the CPU
>> address. So eg. the device can DMA to RAM address 0x0 using address
>> 0x800000000000000.
>>
>> Identity would imply 0 == 0 etc.
>>
>> I think "bijective" is the correct term, but that's probably a bit
>> esoteric.
>
> OK, didn't know about the offset.
> Then "linear" is what we tend to use, right?

If this is indeed a linear mapping, can we just remove this and
replace it with the new "generic" mapping being introduced by this
patchset?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
