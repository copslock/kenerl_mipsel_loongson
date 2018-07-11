Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2018 01:09:19 +0200 (CEST)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:35247
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993889AbeGKXJLpvML7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2018 01:09:11 +0200
Received: by mail-it0-x243.google.com with SMTP id l16-v6so4702643ita.0;
        Wed, 11 Jul 2018 16:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JQF5mpvH9diWFh31HHrS2TTCbnmpzqvcDiu7nbsqEv0=;
        b=gMsogY9dQ+sHH1zfTjnprGkVpFy0Hgso4x+U4/gRMDx8cXiE27Ma1j2MO+lHsCUJeh
         i3rOVWD65mo8GgElCUR9evIVodPCK6gNtceLhjkgNz/GRfpBYJRAgDr+PNJETf+2/ZNt
         +OCcb0R0U7NcyWb0G9IWdUaGkxtd9mXbO2y/qDxFxgLMtMjPXL9TP/1VKCzkUpq+yi3p
         XCX8ByyF4I9/NCWD0su3RKGAsciFqqDsG4UOg3V02EMET2Zyp8DkorLMYOKKVIq4m5YJ
         84H25p/L9pDY/l6kAxSDbiYAGokuqDIRXO/DoWylKsDncf2bwHdNRsrHiMji4kFho5ig
         RJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JQF5mpvH9diWFh31HHrS2TTCbnmpzqvcDiu7nbsqEv0=;
        b=M4LiGb9uB3+G2WncgjtB6sA4jaF7wYDUcCM0DAXlRUD5MhZm505/irKY8PfooqTUxc
         1Q9PDwnj0oklEN/3R37quxaJQVnJWoZ5RFwruDKtWXQtt45zfV5qJtytenFdeTrmextd
         AjzsZZtxwMMtxxYBomOK/zAl7Og3/nW4seSk3JSz1tCQ3HxPYQAgNWty0nUPdizk98I5
         K2V6NBtxy7HjfimWxyOlAgFryfEIDdrR6+PAAtG4SfUU5xgKbUt8oqxHkjKC4LNJVF7K
         GK3Dfr0MWujZZCvfFGRCTB8SibzTcXeru4ulZCzMxH5Rwdue3eC5TFGHrCtcjuQrRwAV
         c/xQ==
X-Gm-Message-State: AOUpUlH26HWKaSupWo/kEfOy0JkS31kXqxM6GsRqSAacxTLFIORUpGZM
        tRzgJJ6XZ5/KxL51VNmxu2QcXqSsPcedl8UjNM4=
X-Google-Smtp-Source: AAOMgpeokB1UMSCSVH/z4VlHqwNJWPQ4jQMAt6Y9Um/3bMA+Z9pHFLk8NmIXqKhIP/YSY/2nqMXkEUECo8txhocS1h4=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr281718iti.135.1531350545350;
 Wed, 11 Jul 2018 16:09:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:3757:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 16:09:04
 -0700 (PDT)
In-Reply-To: <20180711155729.kwv73y5bw3mlkbq7@pburton-laptop>
References: <1531297697-7952-1-git-send-email-chenhc@lemote.com> <20180711155729.kwv73y5bw3mlkbq7@pburton-laptop>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 12 Jul 2018 07:09:04 +0800
Message-ID: <CAAhV-H4rW7fa6zKSSuDboZqbuvOJkY=nHhSsnU36Be9d-foB-Q@mail.gmail.com>
Subject: Re: [PATCH RFC] MIPS: Make UTS_MACHINE reflect big-endian/little-endian
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

On Wed, Jul 11, 2018 at 11:57 PM, Paul Burton <paul.burton@mips.com> wrote:
> Hi Huacai,
>
> On Wed, Jul 11, 2018 at 04:28:17PM +0800, Huacai Chen wrote:
>> It seems like some application use "uname" command's output to do
>> something different between big-endian and little-endian, so we make
>> UTS_MACHINE reflect both 32bit/64bit and big-endian/little-endian.
>
> Since UTS_MACHINE is exposed to userland (which is of course the point
> of your patch) I'm not comfortable changing it. If some piece of code
> checks whether uname -m gives "mips" then we'd break it by suddenly
> giving "mipsel". This is too risky.
>
> Which applications are you talking about that look for endianness in
> uname output? Since Linux on MIPS doesn't expose endianness information
> in this way these applications will always have been broken on MIPS
> systems, and it would make more sense to fix the applications than to
> change the kernel & probably break others.
Hi, we are making Fedora on MIPS, we found that yum use uname's output
to adjust endianness compatibility. We haven't seen anything broken
while we changing mips64 to mips64el, do you know something about
"broken things with this changing". I also don't want to change
UTS_MACHINE, but if it is harmless, I think we can just do it.

>
> Thanks,
>     Paul
>
>> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
>> index e2122cc..a21c3a1 100644
>> --- a/arch/mips/Makefile
>> +++ b/arch/mips/Makefile
>> @@ -38,11 +38,11 @@ endif
>>
>>  ifdef CONFIG_32BIT
>>  tool-archpref                = $(32bit-tool-archpref)
>> -UTS_MACHINE          := mips
>> +UTS_MACHINE          := $(32bit-tool-archpref)
>>  endif
>>  ifdef CONFIG_64BIT
>>  tool-archpref                = $(64bit-tool-archpref)
>> -UTS_MACHINE          := mips64
>> +UTS_MACHINE          := $(64bit-tool-archpref)
>>  endif
