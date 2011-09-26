Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Sep 2011 03:41:01 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:32809 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491987Ab1IZBkz convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Sep 2011 03:40:55 +0200
Received: by gyg13 with SMTP id 13so4608407gyg.36
        for <multiple recipients>; Sun, 25 Sep 2011 18:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nNkD1ODoBLvtmbAfRO0PP/gLO1GG3cUxqvX5DBuqboM=;
        b=VuMWCPX+65Lr7pjSTC7Qldpe45O8OXR9y1gbyeWomYPcWRFxTXH//gJwI8NgytDWYC
         loGnCNnHLOScYwjraDkTH0imk3grGodJmK/k/vwDSh2Bm8reBSDLmpyg7lSujEld4XFw
         he41LtnwBJoyKa6S9wN1p1Yf0gR9eXg2mdS7A=
MIME-Version: 1.0
Received: by 10.42.153.1 with SMTP id k1mr1347517icw.145.1317001248407; Sun,
 25 Sep 2011 18:40:48 -0700 (PDT)
Received: by 10.231.152.148 with HTTP; Sun, 25 Sep 2011 18:40:48 -0700 (PDT)
In-Reply-To: <CACoURw540BQgs4457uEtkGf41-uLbbubGBP23qnvT4W-MNJqOQ@mail.gmail.com>
References: <1316845316-5765-1-git-send-email-keguang.zhang@gmail.com>
        <CAD+V5YLrs91Cjj-EXbjREhs+sQnEjR=q5n3OXtEB0kFQ88p5Pw@mail.gmail.com>
        <CACoURw540BQgs4457uEtkGf41-uLbbubGBP23qnvT4W-MNJqOQ@mail.gmail.com>
Date:   Mon, 26 Sep 2011 09:40:48 +0800
Message-ID: <CAD+V5YLSR-0YdytbJjPnHqKZ4YKdb+sSWgK529SdqrZyZR9=+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Add basic support for Loongson1B (UPDATED)
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Shane McDonald <mcdonald.shane@gmail.com>
Cc:     keguang.zhang@gmail.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        r0bertz@gentoo.org, chenj@lemote.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14253

On Sun, Sep 25, 2011 at 9:40 PM, Shane McDonald
<mcdonald.shane@gmail.com> wrote:
>>> diff --git a/arch/mips/include/asm/mach-loongson1/regs-clk.h b/arch/mips/include/asm/mach-loongson1/regs-clk.h
>>> new file mode 100644
>>> index 0000000..7a09d6a
>>> --- /dev/null
>>> +++ b/arch/mips/include/asm/mach-loongson1/regs-clk.h
>>> @@ -0,0 +1,32 @@
>>> +/*
>>> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
>>> + *
>>> + * Loongson1 Clock Register Definitions.
>>> + *
>>> + * This program is free software; you can redistribute  it and/or modify it
>>> + * under  the terms of  the GNU General  Public License as published by the
>>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>>> + * option) any later version.
>>> + */
>>> +
>>> +#ifndef __ASM_MACH_LOONGSON1_REGS_CLK_H
>>> +#define __ASM_MACH_LOONGSON1_REGS_CLK_H
>>> +
>>> +#define LS1_CLK_REG(x)         ((void __iomem *)(LOONGSON1_CLK_BASE + (x)))
>>
>> "volatile" keyword may be required for __iomem access, the same to the
>> following similar usage.
>>
>> Considering a scene is(LS1_XXX_REG(X) doesn't really exist):
>>
>> LS1_XXX_REG(X) = 0;              /* put cpu into idle and wait interrupt */
>> LS1_XXX_REG(X) = 7;              /* recover the cpu frequency to the highest */
>>
>> If no "volatile" keyword indicated, the first line will be
>> intelligently but wrongly removed by compiler.
>
> No -- please see Documentation/volatile-considered-harmful.txt,
> particularly the paragraph starting at line 49.  This macro
> is only being used as an argument to __raw_readl,
> as it should be.

Yeah, __raw_readl/writel() will use volatile to prevent it from
optimization, thanks ;)

"within the kernel, I/O memory  accesses are always done through
accessor functions;
 accessing I/O memory directly through pointers is frowned upon and
does not work on all
 architectures.  Those accessors are written to prevent unwanted
 optimization,
....
  - The above-mentioned accessor functions might use volatile on
     architectures where direct I/O memory access does work.  Essentially,
     each accessor call becomes a little critical section on its own and
     ensures that the access happens as expected by the programmer.
...
Patches to remove volatile variables are generally welcome - as long as
 they come with a justification which shows that the concurrency issues have
 been properly thought through.
"

Thanks & Regards,
Wu Zhangjin

>
> Shane
>
