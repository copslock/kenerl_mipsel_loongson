Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Sep 2011 05:27:43 +0200 (CEST)
Received: from mail-vw0-f51.google.com ([209.85.212.51]:48144 "EHLO
        mail-vw0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491109Ab1IOD1g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Sep 2011 05:27:36 +0200
Received: by vws20 with SMTP id 20so3612862vws.24
        for <multiple recipients>; Wed, 14 Sep 2011 20:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hwdrH2QZTaNUiEKqqBAMn7eHP/yeRsmBYMeD03wmbRw=;
        b=nVhAzasqk1ZYmZQ8gZLm6+JXTZe4isHXYEJKg9Jjde+gdBsUyZ343KRh6RlFnqmho6
         QYj+hURYDlHjaUs/6QSmlUs+K8Xdq1MxPJOcZJjdXy8Z7Qv5vdnin9CWYr6r2lI98zp8
         SB41lOCp24V4OOW8WagHjC9b+dIFEBh4+szZs=
MIME-Version: 1.0
Received: by 10.220.213.135 with SMTP id gw7mr154450vcb.123.1316057250696;
 Wed, 14 Sep 2011 20:27:30 -0700 (PDT)
Received: by 10.220.84.82 with HTTP; Wed, 14 Sep 2011 20:27:30 -0700 (PDT)
In-Reply-To: <20110914160013.GH4110@mails.so.argh.org>
References: <1315997270-14332-1-git-send-email-keguang.zhang@gmail.com>
        <20110914113134.GS15003@mails.so.argh.org>
        <CAJhJPsUW+4fpJUSR07LBO=FDCyAw-KHKaZCt8G+sHCJtjts0oA@mail.gmail.com>
        <20110914160013.GH4110@mails.so.argh.org>
Date:   Thu, 15 Sep 2011 11:27:30 +0800
Message-ID: <CAJhJPsUXvGJBB-YiLB53VSf8GRXHjkrPRf3F3YE5ekOz-OVqgQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add basic support for Loongson1B
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     Andreas Barth <aba@not.so.argh.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, wuzhangjin@gmail.com, r0bertz@gentoo.org,
        chenj@lemote.com
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7573

2011/9/15, Andreas Barth <aba@not.so.argh.org>:
> * Kelvin Cheung (keguang.zhang@gmail.com) [110914 15:54]:
>> 2011/9/14, Andreas Barth <aba@not.so.argh.org>:
>> > * keguang.zhang@gmail.com (keguang.zhang@gmail.com) [110914 12:49]:
>> >> This patch adds basic support for Loongson1B
>> >> including serial, timer and interrupt handler.
>> >
>> > I have a couple of questions. One of them is if it shouldn't be
>> > possible to add this as part of the loongson-platform, and if we
>> > really need a new platform. Each platform comes with some maintainence
>> > costs which we should try to avoid. Making things more generic is
>> > usually the right answer.
>>
>> I've tried to add Loongson1 to loongson-platform (acturally loongson2
>> platform), but there is essential difference between them. The
>> loongson2 platform is something like the PC's architecture, which has
>> north and south bridge, while the loongson1 is SoC.
>> So, I think it's better that adding loongson1 as a new platform.
>
> I'm not convinced, but that's also not necessary.

As I mentioned before, Loongson1 is a 32-bit SoC with many built-in
controllers, which implements the MIPS32 release 2 instruction set,
while Loongson2 is a 64-bit CPU, which only implements the MIPSIII
instruction set.
The Loongson1 does not have a PCI controller. And its interrupt and
gpio are different from Loongson2 ...

They are totally different thing.
So, it is hard to reuse the code of loongson-platform.

>> >> --- /dev/null
>> >> +++ b/arch/mips/loongson1/common/clock.c
>> >> @@ -0,0 +1,164 @@
>> >> +/*
>> >> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
>> >
>> > Is this file not derived from any of the clock drivers we already have
>> > in Linux?
>> >
>> > Doesn't any of the existing clock drivers work?
>> >
>> > Is this clock part of the CPU? Otherwise it would make sense to move
>> > it out to the generic drivers section.
>
> What's the answer to this questions?

I just did what other platform did, such as ar7, ath79, bcm63xx and
jz4740. Could you have a look at their clock.c/clk.c?

>> >> --- /dev/null
>> >> +++ b/arch/mips/loongson1/common/irq.c
>> >> @@ -0,0 +1,132 @@
>> >> +/*
>> >> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
>> >> + *
>> >> + * Based on Copyright (C) 2009 Lemote Inc.
>> >
>> > same question here. Also, do you have permission from Lemote to put
>> > the code within GPLv2?
>>
>> These code are based on the loongson platform, which is part of the
>> kernel code already.
>
> In that case, it would make sense to say "derived from arch/mips/..."
> so that other people can understand where it comes from.

Thanks! I will pay attention to this.

>> >> diff --git a/arch/mips/loongson1/common/prom.c
>> >> b/arch/mips/loongson1/common/prom.c
>> >> new file mode 100644
>> >> index 0000000..84a25f6
>> >> --- /dev/null
>> >> +++ b/arch/mips/loongson1/common/prom.c
>> >
>> > Can't we re-use the prom-routines from the loongson platform here? Or
>> > even better, factor them out somewhere else in the mips or even
>> > generic linux tree?
>>
>> Same reason as question 1.
>
> Not really. Please try to de-duplicate code as far as possible, and to
> generalize it's usage. Having some code of the form

I did not just duplicate code, modified exactly. The prom-routines of
loongson platform does not fit loongson1.For instance, the
"cpu_clock_freq" parameter is not needed. The cpu freq. could be get
from the PLL register directly. Moreover, the routines does not
include the parameter "ethaddr", which is useful for embedded system.

> +       while (((readb(PORT(UART_BASE, UART_LSR)) & UART_LSR_THRE) == 0)
> +                       && (timeout-- > 0))
> +               ;
> +
> +       writeb(c, PORT(UART_BASE, UART_TX));
> here doesn't make too much sense to me. (Also questioning why this is
> part of the prom.c file).
>

I just did what other platform did, such as ar7, bcm47xx and jz4740.
Could you have a look at their prom.c?

>
> Andi
>


-- 
Best Regards!
Kelvin
