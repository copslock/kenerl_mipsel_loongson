Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 19:00:18 +0200 (CEST)
Received: from mail-ua0-x243.google.com ([IPv6:2607:f8b0:400c:c08::243]:38892
        "EHLO mail-ua0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992404AbeC1RAMWH9Cf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 19:00:12 +0200
Received: by mail-ua0-x243.google.com with SMTP id q38so1966055uad.5
        for <linux-mips@linux-mips.org>; Wed, 28 Mar 2018 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CPdPM3LwLxcdA+gSh17Fed0Qb7oAnHOLZ9fJvXCe/YY=;
        b=iGsYH/qg0H4ZE93CQ7r+xXTNjD3kQAveDf3rG49Hqdr/QBD0BoNjitatoQoV+XPiQO
         J03A+M+v4bjDwZHL5jf3Z89ZBLhgVdmy12nFcKzCNUYS5KV8F0CiYTnrRdkJy1O42QjL
         O6NOwrgfhU+33jGGsLJi8KXCdN6ldCzp/nNpfHFtzsEuY5LrTYgTVuAWGqz7Rnzk8Jtt
         O9u5LxWlzE4iProzXsnYyJj+NzWxLmX41TSp7bcVcbHpjAqEdha/98Mz2Ia3DdRvpi30
         vfITiQ5QSMNFCM6sVDxI7P5EmHt4chR+2BitxJywaySy23+OVwvE94a6Gsc9L8ubRjVQ
         D+PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CPdPM3LwLxcdA+gSh17Fed0Qb7oAnHOLZ9fJvXCe/YY=;
        b=gr6pMACaog9X5YbibZrtdUB8wer2dCXFuMFdqBJMOdwuMI7z8L766IRMZZGLcf0m4+
         OcNS9/VVwL2LvKxpN6w3CZWdDdCm9RdJzeHSfq0BMAtayaV7jPop8UW4VjPMPX436E0j
         +yJAh1HTq9WKBqqW+YqrfNNjPAMFBiT26tjzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CPdPM3LwLxcdA+gSh17Fed0Qb7oAnHOLZ9fJvXCe/YY=;
        b=mw07L8BQGispsI5RcS1tNdtB7RW9e4s8Llp4n6UcUSiG8NepGOrbPaWgQFtCmr3ZJH
         HSn9VS/HQzY7o5j7erTnRe2DbwaSGdHN67nz/p23LAHzt2qafl+FEYcQmJ/aRfI7rBxX
         dPxbWHYKuFcDwoJMjRfECGsXmY3RgfioohF4U+9dP1NABYnyPVVIsahSoF90vQGA23QC
         rDsXi336l9H5XTkZCscp45W9s6CFJ6uIqJ3afUlD2vBapTPCNpTu80peZbp2R12iODZA
         VwAh7Mgk+9N+hjVn4PtNRgaIZihnNdcM3lcAqORXcgDZubBFeJ+Ld2S9uJz2xSJhtq3J
         v/lQ==
X-Gm-Message-State: AElRT7ETsaXXLcsiJTqIVcwMGiel5918xgopVm9E+uYRCQ7kHpVwj94P
        hICWKjSnaWV71Fx0M8wCJdwnmBbSWvk1KWJrXDIsuQ==
X-Google-Smtp-Source: AIpwx496S8sj1SOZ917G/QQ7MCp9mNOzUKOPYUfnNfv84pzpZs+rWjwsbWGfkxMlHsdIkTDNIbZ9v8KOGQcNDcg6nEs=
X-Received: by 10.176.14.3 with SMTP id g3mr3021461uak.83.1522256406114; Wed,
 28 Mar 2018 10:00:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.129.9 with HTTP; Wed, 28 Mar 2018 10:00:05 -0700 (PDT)
In-Reply-To: <20180328152115.GB1991@saruman>
References: <1522226933-29317-1-git-send-email-chenhc@lemote.com> <20180328152115.GB1991@saruman>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 28 Mar 2018 10:00:05 -0700
X-Google-Sender-Auth: CiAUwqRpYRkqCJ4B_OZoSVGmCAU
Message-ID: <CAGXu5j+p9fy=fVkBtyXUNH6tmCfraWdZTJCqiRHvyO3vxNxzng@mail.gmail.com>
Subject: Re: [PATCH V4 Resend] ZBOOT: fix stack protector in compressed boot phase
To:     James Hogan <jhogan@kernel.org>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        linux-sh <linux-sh@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Wed, Mar 28, 2018 at 8:21 AM, James Hogan <jhogan@kernel.org> wrote:
> On Wed, Mar 28, 2018 at 04:48:53PM +0800, Huacai Chen wrote:
>> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
>> index fdf99e9..81df904 100644
>> --- a/arch/mips/boot/compressed/decompress.c
>> +++ b/arch/mips/boot/compressed/decompress.c
>> @@ -76,12 +76,7 @@ void error(char *x)
>>  #include "../../../../lib/decompress_unxz.c"
>>  #endif
>>
>> -unsigned long __stack_chk_guard;
>> -
>> -void __stack_chk_guard_setup(void)
>> -{
>> -     __stack_chk_guard = 0x000a0dff;
>> -}
>> +const unsigned long __stack_chk_guard = 0x000a0dff;
>>
>>  void __stack_chk_fail(void)
>>  {
>> @@ -92,8 +87,6 @@ void decompress_kernel(unsigned long boot_heap_start)
>>  {
>>       unsigned long zimage_start, zimage_size;
>>
>> -     __stack_chk_guard_setup();
>> -
>>       zimage_start = (unsigned long)(&__image_begin);
>>       zimage_size = (unsigned long)(&__image_end) -
>>           (unsigned long)(&__image_begin);
>
> This looks good to me, though I've Cc'd Kees as apparently the original
> author from commit 8779657d29c0 ("stackprotector: Introduce

I wonder what changed in the compiler -- I regularly boot
stack-protected ARM images. Regardless, this is fine. :)

> CONFIG_CC_STACKPROTECTOR_STRONG") in case there was a particular reason
> this wasn't done in the first place.

I think I was copying from other places? It's been long enough that I
don't remember, actually. :)

> Acked-by: James Hogan <jhogan@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

> (Happy to apply with acks from Kees and ARM, SH maintainers if nobody
> else does).

That'd be fine by me, FWIW. Thanks!

-Kees

-- 
Kees Cook
Pixel Security
