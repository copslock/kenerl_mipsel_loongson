Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 09:41:27 +0100 (CET)
Received: from mail-ua0-x243.google.com ([IPv6:2607:f8b0:400c:c08::243]:43770
        "EHLO mail-ua0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990394AbdL0IlU45z9M convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Dec 2017 09:41:20 +0100
Received: by mail-ua0-x243.google.com with SMTP id g4so18575456ual.10;
        Wed, 27 Dec 2017 00:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kY0CCDF0+7jZ7gp8AxfY19C7flDOsOt4zCH2qhTzHWc=;
        b=gGC0gbKmla1lmpc9UMdazLAjzGF8esdCTcYoMef9k2bHfKrXHjXCAvOB8t9eUZe619
         w/4m1xjcbC2tFWc+qJRy7WQrMGYFsH0lAzduT0eqx6pVGMjnLY1bxfteSrPJiGoAmr3y
         dP1JbrwJI4mPf7EGATzXJAqlmyjO/mHWkRZQEt3qIdu8K6CnNjs0oVmYiXnhCPaUC0No
         qIsimTS4ktuOy+ULAmkj8XFXievC8srWkpE9rliscFWQ6AP+wngLW3PRHiqJFn8EOmDJ
         JgwvDJne7vcG3v9TgG9MeHMV8KSLH+4gFUkgVMInrzZbC96v+Paj2VFg0k0dBQZVpL+Q
         aRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kY0CCDF0+7jZ7gp8AxfY19C7flDOsOt4zCH2qhTzHWc=;
        b=Kriozzafyjffxljh/rAiZJJ6L3VMt328JJ/bw4Cb0XQ9HiOcny9+up97L47xw0rXNv
         lltr631Ig5x0iuWq2GfNGdZ/BRjz7X2PWZzUwOB0UBtLjJMQca/bpirQ57lhh6WuKIyh
         DmSCJVAjAvbrDBsFOoQC0kgmTy8zmu9YGEmweq0toPuZpA1gnYuJFlflVUzxll2Yxyp7
         AlVf0ypg77bHJu6YHsF2qIx0x1h96QdhsXnDVSu9TR4d3Uhx40l1eALobZnMc9/eRcXS
         fecdA/8OJ8Z+OhTw8X1BCctDo2D41zaICHpqcoq0JPVCDD3fpNv9/SFWnPA9czpkDZWI
         H/qA==
X-Gm-Message-State: AKGB3mL2eqyZaSp0cLtDnAr2dBiBU8qMvr8Ert2JRPWeCFyc17dJNOOe
        kaTq6MP0H98IwuxvDGXVHUxbSe3ZPIEjyhjd7lo=
X-Google-Smtp-Source: ACJfBovtOP+erHWtZxnZDrrgtZPrY1Kmk37q1BY55AGUe7JagrLUgWM6EnWEWIIMod6TpglYe0WH9KtwgOTxyKJhgL0=
X-Received: by 10.176.5.161 with SMTP id e30mr6444310uae.17.1514364074570;
 Wed, 27 Dec 2017 00:41:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.49.1 with HTTP; Wed, 27 Dec 2017 00:40:54 -0800 (PST)
In-Reply-To: <BD3A5F1946F2E540A31AF2CE969BAEEEC28256@MIPSMAIL01.mipstec.com>
References: <20171226104554.19612-1-malat@debian.org> <20171226104554.19612-2-malat@debian.org>
 <BD3A5F1946F2E540A31AF2CE969BAEEEC28256@MIPSMAIL01.mipstec.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 27 Dec 2017 09:40:54 +0100
X-Google-Sender-Auth: Hsi7Ns6RpxdABe2pFFyh5vOU6J0
Message-ID: <CA+7wUszosphtNTkSFnRK_JWgKvqDkQ+djmy1f=41-CDW7DoQXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: math-emu: Declare ys variable as possibly unused
To:     Aleksandar Markovic <Aleksandar.Markovic@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Miodrag Dinic <Miodrag.Dinic@mips.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        James Hogan <jhogan@kernel.org>,
        Douglas Leung <douglas.leung@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Aleksandar,

On Tue, Dec 26, 2017 at 4:12 PM, Aleksandar Markovic
<Aleksandar.Markovic@mips.com> wrote:
>> Fix non-fatal warning:
>>
>> arch/mips/math-emu/sp_fdp.c: In function ‘ieee754sp_fdp’:
>> arch/mips/math-emu/ieee754int.h:60:31: warning: variable ‘ys’ set but not used [-Wunused-but-set-variable]
>>   unsigned int ym; int ye; int ys; int yc
>>                                ^
>> arch/mips/math-emu/sp_fdp.c:37:2: note: in expansion of macro ‘COMPYSP’
>>   COMPYSP;
>>   ^~~~~~~
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>  arch/mips/math-emu/ieee754int.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/math-emu/ieee754int.h b/arch/mips/math-emu/ieee754int.h
>> index 06ac0e2ac7ac..cb8f04cd24bf 100644
>> --- a/arch/mips/math-emu/ieee754int.h
>> +++ b/arch/mips/math-emu/ieee754int.h
>> @@ -57,7 +57,7 @@ static inline int ieee754_class_nan(int xc)
>>          unsigned int xm; int xe; int xs __maybe_unused; int xc
>>
>>  #define COMPYSP \
>> -       unsigned int ym; int ye; int ys; int yc
>> +       unsigned int ym; int ye; int ys __maybe_unused; int yc
>>
>>  #define COMPZSP \
>>          unsigned int zm; int ze; int zs; int zc
>
> This will silence the warning, but will do it for all future cases of unused
> ys too - in other words, it may well silence even useful, valid warnings.
> Also, this introduces an inconsistency among COMPXSP, COMPYSP, and COMPZSP
> macros.
>
> A better solution would be to reduce the scope of ys, so that it is always
> used, if declared. Instead of this code segment (in arch/mips/math-emu/sp_fdp.c):
>
> union ieee754sp ieee754sp_fdp(union ieee754dp x)
> {
>         union ieee754sp y;
>         u32 rm;
>
>         COMPXDP;
>         COMPYSP;
>
>         EXPLODEXDP;
>
>         ieee754_clearcx();
>
>         FLUSHXDP;
>
>         switch (xc) {
>         case IEEE754_CLASS_SNAN:
>                 x = ieee754dp_nanxcpt(x);
>                 EXPLODEXDP;
>                 /* Fall through.  */
>         case IEEE754_CLASS_QNAN:
>                 y = ieee754sp_nan_fdp(xs, xm);
>                 if (!ieee754_csr.nan2008) {
>                         EXPLODEYSP;
>                         if (!ieee754_class_nan(yc))
>                                 y = ieee754sp_indef();
>                 }
>                 return y;
>
>
> ... should be the following: (COMPYSP is moved to a smaller code block)
>
> union ieee754sp ieee754sp_fdp(union ieee754dp x)
> {
>         union ieee754sp y;
>         u32 rm;
>
>         COMPXDP;
>
>         EXPLODEXDP;
>
>         ieee754_clearcx();
>
>         FLUSHXDP;
>
>         switch (xc) {
>         case IEEE754_CLASS_SNAN:
>                 x = ieee754dp_nanxcpt(x);
>                 EXPLODEXDP;
>                 /* Fall through.  */
>         case IEEE754_CLASS_QNAN:
>                 {
>                         COMPYSP;
>
>                         y = ieee754sp_nan_fdp(xs, xm);
>                         if (!ieee754_csr.nan2008) {
>                                 EXPLODEYSP;
>                                 if (!ieee754_class_nan(yc))
>                                         y = ieee754sp_indef();
>                         }
>                         return y;
>                 }
>


Thanks for the suggestion. However the sign bit is still not used, so
the warning is still there. Just for clarity did you see that:

 #define COMPXSP \
       unsigned int xm; int xe; int xs __maybe_unused; int xc

I'll try to give it some more thoughts, and come up with something
hopefully working.

-M
