Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2017 11:38:28 +0200 (CEST)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:33214
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993876AbdFZJiUeOALK convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Jun 2017 11:38:20 +0200
Received: by mail-it0-x241.google.com with SMTP id x12so12003095itb.0;
        Mon, 26 Jun 2017 02:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Lmvl/JCWqHPo+HnIsI6fYu1WHXcx2l0W7kzI93Jm4jA=;
        b=pHsTYIX1CGIKiWz4dJej6UeIaqtA5bqUky+G9+3GdFMfYdxnYWwpg/2uvSLb0lADrY
         We9CPxqQY86PEhvXvK+D+qYxFzlaGNGfk5sGfFnfoRrObimiQgequ9piIOCO0IEa4HY2
         xyyNi1aeKJScwB3sP8Bsj8IPf0qWFZfR3AtI4zHayIYx/rOhKl3/3LicTtEe0TE21Oio
         a7tRA2XHqQ/QPLfA7qXqdZOe2PoSMUp4qH/r3VKD+DTg5k794F7sWHDfilT1dUynp5TZ
         8iW9thYwZp7eHd/S8Ml0NLq22u2PcZMCDLfQzUjd49dFv0Lu/vNWgwHCSJsvKm3ydIr9
         /G/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Lmvl/JCWqHPo+HnIsI6fYu1WHXcx2l0W7kzI93Jm4jA=;
        b=Vuz1jVazLFmNjQfNNZEfUE4MN1CEbdUoUi+llE6xCNS3b+bX3FdysBirOU0wiBpWxB
         PfB/1/WV+IGGFU9i0Gf3TmvXKhjZBEg19ap4B1/h5Grf5RWP0Ai9FR3va7NCi+L7dSDz
         gKhOi/JERHfkE3svC38g9Rh+0Ys+e8mGHacfB8mMEBX/3CQzTUB6x+tZziYpzdgimLiK
         o73bZ/EfwTqw0IEnO/9BGxHHkHefa15VUJ0BByA+4DJXIU1Z8Io6ywqqLNGu+A04RRgw
         YeSsL4WatA00pWNeEXcujsQAMIGyg4YhmNoQbXTYs8mtX8d6TURg275+gu6FH66lMTz3
         f0mg==
X-Gm-Message-State: AKS2vOyF33Z+6RAY5QVIc8epNcRBYvCLytsRWT72Kbl/hGPmM7tw4K4B
        Y1evpc5uGiBPH3z1O6aJsE43RtQ/kw==
X-Received: by 10.36.219.132 with SMTP id c126mr22507745itg.73.1498469894784;
 Mon, 26 Jun 2017 02:38:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.144.85 with HTTP; Mon, 26 Jun 2017 02:38:14 -0700 (PDT)
In-Reply-To: <20170626082637.GE6973@jhogan-linux.le.imgtec.org>
References: <1498144016-9111-1-git-send-email-chenhc@lemote.com>
 <1498144016-9111-10-git-send-email-chenhc@lemote.com> <20170623145453.GB31455@jhogan-linux.le.imgtec.org>
 <CAAhV-H5NO1otR1YmyobZMk5Sw_GpgATVWMn5rNwmaMFOUFuctQ@mail.gmail.com>
 <1B97A9D2-5753-4143-AB56-389280FDBA64@imgtec.com> <CAAhV-H4=D0QqKA=M48e8r+3x2N3SXEDTYLawxU5+sYndJ1fZ9Q@mail.gmail.com>
 <20170626082637.GE6973@jhogan-linux.le.imgtec.org>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Mon, 26 Jun 2017 17:38:14 +0800
X-Google-Sender-Auth: VKMZbQkgVQjgC3mjSnUz1BO9g74
Message-ID: <CAAhV-H7-Y6K5T6HVWqL7sfUoDdAr9j4NECbATQdBAAa-4Ty4Lg@mail.gmail.com>
Subject: Re: [PATCH V7 9/9] MIPS: Loongson: Introduce and use LOONGSON_LLSC_WAR
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58799
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

OK, I have reworked patch 8 and patch 9.

Huacai

On Mon, Jun 26, 2017 at 4:26 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Hi Huacai,
>
> On Sat, Jun 24, 2017 at 05:23:52PM +0800, Huacai Chen wrote:
>> You are right, but it seems like __WEAK_LLSC_MB is already the best
>> name for this case. Maybe I define a macro named __VERY_WEAK_LLSC_MB
>> to expand a "sync" on Loongson?
>
> I suppose so.
>
> Can you clarify what very weak ordering means in this context? I.e. in
> what case is it insufficient to have the sync before the label rather
> than before every ll in the retry loop?
>
> Cheers
> James
>
>>
>> Huacai
>>
>> On Sat, Jun 24, 2017 at 5:02 PM, James Hogan <james.hogan@imgtec.com> wrote:
>> > On 24 June 2017 09:55:14 BST, Huacai Chen <chenhc@lemote.com> wrote:
>> >>Hi, James,
>> >>
>> >>smp_mb__before_llsc() can not be used in all cases, e.g., in
>> >>arch/mips/include/asm/spinlock.h and other similar cases which has a
>> >>label before ll/lld. So, I think it is better to keep it as is to keep
>> >>consistency.
>> >
>> > I know. I didn't mean use smp_mb_before_llsc directly, i just meant use something similar directly before the ll that would expand to nothing on non loongson kernels and still avoid the mass duplication of inline asm which leads to divergence, bitrot, and maintenance problems.
>> >
>> > cheers
>> > James
>> >
>> >>
>> >>Huacai
>> >>
>> >>On Fri, Jun 23, 2017 at 10:54 PM, James Hogan <james.hogan@imgtec.com>
>> >>wrote:
>> >>> On Thu, Jun 22, 2017 at 11:06:56PM +0800, Huacai Chen wrote:
>> >>>> diff --git a/arch/mips/include/asm/atomic.h
>> >>b/arch/mips/include/asm/atomic.h
>> >>>> index 0ab176b..e0002c58 100644
>> >>>> --- a/arch/mips/include/asm/atomic.h
>> >>>> +++ b/arch/mips/include/asm/atomic.h
>> >>>> @@ -56,6 +56,22 @@ static __inline__ void atomic_##op(int i,
>> >>atomic_t * v)                          \
>> >>>>               "       .set    mips0
>> >> \n"   \
>> >>>>               : "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)
>> >>       \
>> >>>>               : "Ir" (i));
>> >>       \
>> >>>> +     } else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {
>> >>       \
>> >>>> +             int temp;
>> >>       \
>> >>>> +
>> >>       \
>> >>>> +             do {
>> >>       \
>> >>>> +                     __asm__ __volatile__(
>> >>       \
>> >>>> +                     "       .set    "MIPS_ISA_LEVEL"
>> >> \n"   \
>> >>>> +                     __WEAK_LLSC_MB
>> >>       \
>> >>>> +                     "       ll      %0, %1          # atomic_" #op
>> >>"\n"   \
>> >>>> +                     "       " #asm_op " %0, %2
>> >> \n"   \
>> >>>> +                     "       sc      %0, %1
>> >> \n"   \
>> >>>> +                     "       .set    mips0
>> >> \n"   \
>> >>>> +                     : "=&r" (temp), "+" GCC_OFF_SMALL_ASM()
>> >>(v->counter)      \
>> >>>> +                     : "Ir" (i));
>> >>       \
>> >>>> +             } while (unlikely(!temp));
>> >>       \
>> >>>
>> >>> Can loongson use the common versions of all these bits of assembly by
>> >>> adding a LOONGSON_LLSC_WAR dependent smp_mb__before_llsc()-like macro
>> >>> before the asm?
>> >>>
>> >>> It would save a lot of duplication, avoid potential bitrot and
>> >>> divergence, and make the patch much easier to review.
>> >>>
>> >>> Cheers
>> >>> James
>> >
>> >
>> > --
>> > James Hogan
>> >
