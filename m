Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Sep 2011 15:40:29 +0200 (CEST)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:38080 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491146Ab1IYNkZ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 25 Sep 2011 15:40:25 +0200
Received: by vcbfo1 with SMTP id fo1so3245286vcb.36
        for <multiple recipients>; Sun, 25 Sep 2011 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=USOKyjDAlefGxDJwY9GqeYRn/zGf5lznITmAKsMxOlo=;
        b=KODcIWmgy1HiLiQRrAN8gew0lF56+8qmrN+z6UDW04ymk2w7zRmpHplV/hjIHfpyxq
         y1ThK0gvga5setdGTywR0/9K9MC9JlupYt7DJKx/wL/L2HXH3rwS/zU/Hy72h6DVdhDY
         Ksx6yPhANCdINitX8F7SLbgmR1xIhy+7Ns9Jw=
MIME-Version: 1.0
Received: by 10.52.100.73 with SMTP id ew9mr5186224vdb.371.1316958018762; Sun,
 25 Sep 2011 06:40:18 -0700 (PDT)
Received: by 10.52.162.137 with HTTP; Sun, 25 Sep 2011 06:40:18 -0700 (PDT)
In-Reply-To: <CAD+V5YLrs91Cjj-EXbjREhs+sQnEjR=q5n3OXtEB0kFQ88p5Pw@mail.gmail.com>
References: <1316845316-5765-1-git-send-email-keguang.zhang@gmail.com>
        <CAD+V5YLrs91Cjj-EXbjREhs+sQnEjR=q5n3OXtEB0kFQ88p5Pw@mail.gmail.com>
Date:   Sun, 25 Sep 2011 07:40:18 -0600
Message-ID: <CACoURw540BQgs4457uEtkGf41-uLbbubGBP23qnvT4W-MNJqOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Add basic support for Loongson1B (UPDATED)
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     keguang.zhang@gmail.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        r0bertz@gentoo.org, chenj@lemote.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14110

>> diff --git a/arch/mips/include/asm/mach-loongson1/regs-clk.h b/arch/mips/include/asm/mach-loongson1/regs-clk.h
>> new file mode 100644
>> index 0000000..7a09d6a
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-loongson1/regs-clk.h
>> @@ -0,0 +1,32 @@
>> +/*
>> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
>> + *
>> + * Loongson1 Clock Register Definitions.
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + */
>> +
>> +#ifndef __ASM_MACH_LOONGSON1_REGS_CLK_H
>> +#define __ASM_MACH_LOONGSON1_REGS_CLK_H
>> +
>> +#define LS1_CLK_REG(x)         ((void __iomem *)(LOONGSON1_CLK_BASE + (x)))
>
> "volatile" keyword may be required for __iomem access, the same to the
> following similar usage.
>
> Considering a scene is(LS1_XXX_REG(X) doesn't really exist):
>
> LS1_XXX_REG(X) = 0;              /* put cpu into idle and wait interrupt */
> LS1_XXX_REG(X) = 7;              /* recover the cpu frequency to the highest */
>
> If no "volatile" keyword indicated, the above two lines will be
> intelligently but wrongly removed by compiler.

No -- please see Documentation/volatile-considered-harmful.txt,
particularly the paragraph starting at line 49.  This macro
is only being used as an argument to __raw_readl,
as it should be.

Shane
