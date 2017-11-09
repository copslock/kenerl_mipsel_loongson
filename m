Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 01:40:05 +0100 (CET)
Received: from conssluserg-06.nifty.com ([210.131.2.91]:31714 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbdKIAj5TkrKQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 01:39:57 +0100
Received: from mail-yw0-f179.google.com (mail-yw0-f179.google.com [209.85.161.179]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id vA90d3KN001131;
        Thu, 9 Nov 2017 09:39:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com vA90d3KN001131
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1510187944;
        bh=Fg4u2Yrxavt/hPWCudsCmUw5AfstwrinXZM1lCQWyGE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=SwOEleF/8h03taVAkcsoObJZseHg+rKpq2lumQsm3rLU+kREocrFhInscB4l+6S2A
         ceYi+4eqk1lC1rjNQZ39Hi4C6JrxI/DphIaCkPmMs+gHK56ueXtBbYSPHLotvPrEs5
         AtnIt2zbQO6RcoUdWgPGfAf6YgVhvX8LpfZmZ43HxFxXMDQJ6BVdvkte6jOWJuPLde
         SDd6XyBTCEOBVa3YPACctA4yUF29hhCtGun+2UUiBWXC6g0qQV+3nETCRz++nnPIj1
         1PG/jm/muITJk0+AvSlxLBdd8S3BkQ/WIsYwCpFvyYj1TxvAPtkCl3gbw1eOkGStcN
         S/iQ08mRhKfSQ==
X-Nifty-SrcIP: [209.85.161.179]
Received: by mail-yw0-f179.google.com with SMTP id y75so3937622ywg.0;
        Wed, 08 Nov 2017 16:39:04 -0800 (PST)
X-Gm-Message-State: AJaThX5XYK0IqEhxkF3A1xRvR6DbiQLPYUiZIRlyX6pqrShsEP5vAqPV
        NCNKtnejK6vB6h/fNSCDfXXXSE2oMmtDeujOSTw=
X-Google-Smtp-Source: ABhQp+RJZBrcuY0E29sGDOYz/3OclTj8uCVLus3ZN/Ukc0hA+PICM6MhQ4P036TDI1VfyLI4eCrCSP4uZjwdlR6+aKw=
X-Received: by 10.37.113.197 with SMTP id m188mr1556380ybc.390.1510187942991;
 Wed, 08 Nov 2017 16:39:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.110.139 with HTTP; Wed, 8 Nov 2017 16:38:22 -0800 (PST)
In-Reply-To: <CAK7LNATZ9O4cCpxLrG3MJoKYF+RnURkY4-tY2MdiZb90eGPtQg@mail.gmail.com>
References: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
 <1509859853-27473-2-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQfK_BWQcVW-ScrpAwNAHav3MrrzV-tjn_YUjsuvd7U5A@mail.gmail.com>
 <20171106095139.GG15260@jhogan-linux> <CAK7LNAQ_bugEP8hHKmCif5QCz2=Pw_GpXzYz4zJeXO0HXaT_ag@mail.gmail.com>
 <CAL_JsqJ8taCKnr_79UumiH2GFYq-fMzzkYm2iYevTOgUUWuzvg@mail.gmail.com> <CAK7LNATZ9O4cCpxLrG3MJoKYF+RnURkY4-tY2MdiZb90eGPtQg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 9 Nov 2017 09:38:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNARzRUA6ZGQUiebZ+nmLBSAVdYONsozHBf0VQb83KqSx1g@mail.gmail.com>
Message-ID: <CAK7LNARzRUA6ZGQUiebZ+nmLBSAVdYONsozHBf0VQb83KqSx1g@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: dts: remove bogus bcm96358nb4ser.dtb from dtb-y entry
To:     Rob Herring <robh+dt@kernel.org>
Cc:     James Hogan <jhogan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

2017-11-09 9:11 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2017-11-09 1:51 GMT+09:00 Rob Herring <robh+dt@kernel.org>:
>> On Mon, Nov 6, 2017 at 5:00 AM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> 2017-11-06 19:41 GMT+09:00 James Hogan <jhogan@kernel.org>:
>>>> Hi,
>>>>
>>>> On Sun, Nov 05, 2017 at 11:11:38PM +0900, Masahiro Yamada wrote:
>>>>> +CC Ralf Baechle <ralf@linux-mips.org>
>>>>> +CC linux-mips@linux-mips.org
>>>>> +CC Kevin Cernekee <cernekee@gmail.com>
>>>>> +CC Florian Fainelli <f.fainelli@gmail.com>
>>>>>
>>>>>
>>>>> I missed to CC MIPS maintainers.
>>>>
>>>> Yes, please resend the patch so it lands in patchwork.linux-mips.org.
>>>
>>>
>>> This is a part of clean-up series of DT building.
>>>
>>> I want Acked-by from MIPS maintainers
>>> so that the whole series can go to a different tree.
>>> (DT or Kbuild).
>>>
>>>
>>> Sam addressed more clean-up candidates in MIPS Makefiles
>>> https://patchwork.kernel.org/patch/10041879/
>>>
>>> So, I will probably end up with touching those Makefiles more.
>>>
>>> All patches must go to the same tree.
>>>
>>>
>>>>> 2017-11-05 14:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>>>>> > arch/mips/boot/dts/brcm/bcm96358nb4ser.dts does not exist, so
>>>>> > we cannot build bcm96358nb4ser.dtb .
>>>>
>>>> This appears to be due to the file being renamed in commit 695835511f96
>>>> ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom").
>>>> Please can you update the commit message when you resend to mention the
>>>> cause of the problem.
>>>>
>>>> You could also add the following if you like while you're at it:
>>>>
>>>> Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom")
>>>> Cc: <stable@vger.kernel.org> # 4.9+
>>
>> I think this one can be applied independently and we'd want it to if
>> we tag for stable. So I think it can go thru the MIPS tree.
>>
>
>
> As I said to MIPS folks, this patch must go before 2/2.
>
> You picked up only 2/2, so your dt/kbuild branch is broken.
>
>
> make ARCH=mips allyesconfig
> && make ARCH=mips CROSS_COMPILE=mips-linux- dtbs
>
>
> will produce the following error.
>
>
> make[2]: *** No rule to make target
> 'arch/mips/boot/dts/brcm/bcm96358nb4ser.dtb', needed by '__build'.
> Stop.
> scripts/Makefile.build:570: recipe for target 'arch/mips/boot/dts/brcm' failed
> make[1]: *** [arch/mips/boot/dts/brcm] Error 2
> arch/mips/Makefile:413: recipe for target 'dtbs' failed
> make: *** [dtbs] Error 2
>


Looking into it, probably
bmips_dtb_defconfig was already broken regardless my patches.

But, I am not comfortable with breaking all{yes,mod}config
because they are often used for build test.


I hope you can apply this in the order as I sent,
with the following tag.

Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to
bcm6358-neufbox4-sercom")
Cc: <stable@vger.kernel.org> # 4.9+

-- 
Best Regards
Masahiro Yamada
