Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2011 15:54:47 +0200 (CEST)
Received: from mail-vw0-f41.google.com ([209.85.212.41]:62939 "EHLO
        mail-vw0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491124Ab1INNyj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Sep 2011 15:54:39 +0200
Received: by vwm42 with SMTP id 42so2535401vwm.28
        for <multiple recipients>; Wed, 14 Sep 2011 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BZ/SPOxkluppiFHl0KtO4rhwWH9KXCY5g/KOek4OKKA=;
        b=o0d+tCy91tXWJeU2HlcpbQCHkOnS1Dr9I2cX2OpoiVF1ld9PFC9avpCP2udfNxobvg
         XnAlyP3W1Yp8c4SgDcO14EkFfuxGzk8CVisMK/BHftFF9isKBu/Tb+MmWHjW+tVdyj2f
         UQ5AiU8FI7Jc3RNjw8ib8CK1d+g+ciquOlq78=
MIME-Version: 1.0
Received: by 10.52.76.68 with SMTP id i4mr2437721vdw.213.1316008472662; Wed,
 14 Sep 2011 06:54:32 -0700 (PDT)
Received: by 10.220.84.82 with HTTP; Wed, 14 Sep 2011 06:54:32 -0700 (PDT)
In-Reply-To: <20110914113134.GS15003@mails.so.argh.org>
References: <1315997270-14332-1-git-send-email-keguang.zhang@gmail.com>
        <20110914113134.GS15003@mails.so.argh.org>
Date:   Wed, 14 Sep 2011 21:54:32 +0800
Message-ID: <CAJhJPsUW+4fpJUSR07LBO=FDCyAw-KHKaZCt8G+sHCJtjts0oA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add basic support for Loongson1B
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     Andreas Barth <aba@not.so.argh.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, wuzhangjin@gmail.com, r0bertz@gentoo.org,
        chenj@lemote.com
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7143

2011/9/14, Andreas Barth <aba@not.so.argh.org>:
> * keguang.zhang@gmail.com (keguang.zhang@gmail.com) [110914 12:49]:
>> This patch adds basic support for Loongson1B
>> including serial, timer and interrupt handler.
>
> I have a couple of questions. One of them is if it shouldn't be
> possible to add this as part of the loongson-platform, and if we
> really need a new platform. Each platform comes with some maintainence
> costs which we should try to avoid. Making things more generic is
> usually the right answer.

I've tried to add Loongson1 to loongson-platform (acturally loongson2
platform), but there is essential difference between them. The
loongson2 platform is something like the PC's architecture, which has
north and south bridge, while the loongson1 is SoC.
So, I think it's better that adding loongson1 as a new platform.

>> diff --git a/arch/mips/include/asm/mach-loongson1/irq.h
>> b/arch/mips/include/asm/mach-loongson1/irq.h
>> new file mode 100644
>> index 0000000..44cec4a
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-loongson1/irq.h
>> @@ -0,0 +1,70 @@
>> +/*
>> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
>> + *
>> + * Register mappings for Loongson1.
>
> Can't we do the mapping via device trees, or are we not there yet?
>
>
>> --- /dev/null
>> +++ b/arch/mips/loongson1/common/clock.c
>> @@ -0,0 +1,164 @@
>> +/*
>> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
>
> Is this file not derived from any of the clock drivers we already have
> in Linux?
>
> Doesn't any of the existing clock drivers work?
>
> Is this clock part of the CPU? Otherwise it would make sense to move
> it out to the generic drivers section.
>
>> --- /dev/null
>> +++ b/arch/mips/loongson1/common/irq.c
>> @@ -0,0 +1,132 @@
>> +/*
>> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
>> + *
>> + * Based on Copyright (C) 2009 Lemote Inc.
>
> same question here. Also, do you have permission from Lemote to put
> the code within GPLv2?

These code are based on the loongson platform, which is part of the
kernel code already.

>> diff --git a/arch/mips/loongson1/common/prom.c
>> b/arch/mips/loongson1/common/prom.c
>> new file mode 100644
>> index 0000000..84a25f6
>> --- /dev/null
>> +++ b/arch/mips/loongson1/common/prom.c
>
> Can't we re-use the prom-routines from the loongson platform here? Or
> even better, factor them out somewhere else in the mips or even
> generic linux tree?

Same reason as question 1.

>> index 0000000..b34ad35
>> --- /dev/null
>> +++ b/arch/mips/loongson1/common/reset.c
>
>
>> +static void loongson1_halt(void)
>> +{
>> +	pr_notice("\n\n** You can safely turn off the power now **\n\n");
>> +	while (1) {
>> +		if (cpu_wait)
>> +			cpu_wait();
>> +	}
>> +}
>
>
> This code looks familiar to me, i.e. it shouldn't be
> platform-specific.
>
>
>
>
> Andi
>

Thanks for your review!

-- 
Best Regards!
Kelvin
