Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Nov 2017 00:06:58 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:39698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990506AbdKIXGtU90G2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Nov 2017 00:06:49 +0100
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com [209.85.220.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8466D21985;
        Thu,  9 Nov 2017 23:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8466D21985
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
Received: by mail-qk0-f182.google.com with SMTP id 2so9030780qkg.13;
        Thu, 09 Nov 2017 15:06:46 -0800 (PST)
X-Gm-Message-State: AJaThX73NiAdWzQ30l912v1s5W9fRlJUGNWGnlCQ73pkrW1nnLMp1yd9
        EoQpBeLh5v8YQEIHqYzHts05fyDG+VR3sV8u3g==
X-Google-Smtp-Source: AGs4zMbHCfkOqvgw6BsZggzVEqdlBZ60B92JEGyyic8xuPZTSbUD5UP0bXJdZc994qX5p4SQVI4xxbFoBn8Pp71l1Mc=
X-Received: by 10.55.197.202 with SMTP id k71mr3494910qkl.270.1510268805651;
 Thu, 09 Nov 2017 15:06:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.130.134 with HTTP; Thu, 9 Nov 2017 15:06:25 -0800 (PST)
In-Reply-To: <CAK7LNARzRUA6ZGQUiebZ+nmLBSAVdYONsozHBf0VQb83KqSx1g@mail.gmail.com>
References: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
 <1509859853-27473-2-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQfK_BWQcVW-ScrpAwNAHav3MrrzV-tjn_YUjsuvd7U5A@mail.gmail.com>
 <20171106095139.GG15260@jhogan-linux> <CAK7LNAQ_bugEP8hHKmCif5QCz2=Pw_GpXzYz4zJeXO0HXaT_ag@mail.gmail.com>
 <CAL_JsqJ8taCKnr_79UumiH2GFYq-fMzzkYm2iYevTOgUUWuzvg@mail.gmail.com>
 <CAK7LNATZ9O4cCpxLrG3MJoKYF+RnURkY4-tY2MdiZb90eGPtQg@mail.gmail.com> <CAK7LNARzRUA6ZGQUiebZ+nmLBSAVdYONsozHBf0VQb83KqSx1g@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 9 Nov 2017 17:06:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJF=AV_m7DJyc4GGX0xrbvn+yJ05Oy8EWoM+FO8qr=k2g@mail.gmail.com>
Message-ID: <CAL_JsqJF=AV_m7DJyc4GGX0xrbvn+yJ05Oy8EWoM+FO8qr=k2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: dts: remove bogus bcm96358nb4ser.dtb from dtb-y entry
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
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
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh+dt@kernel.org
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

On Wed, Nov 8, 2017 at 6:38 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2017-11-09 9:11 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> 2017-11-09 1:51 GMT+09:00 Rob Herring <robh+dt@kernel.org>:
>>> On Mon, Nov 6, 2017 at 5:00 AM, Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>> 2017-11-06 19:41 GMT+09:00 James Hogan <jhogan@kernel.org>:
>>>>> Hi,
>>>>>
>>>>> On Sun, Nov 05, 2017 at 11:11:38PM +0900, Masahiro Yamada wrote:
>>>>>> +CC Ralf Baechle <ralf@linux-mips.org>
>>>>>> +CC linux-mips@linux-mips.org
>>>>>> +CC Kevin Cernekee <cernekee@gmail.com>
>>>>>> +CC Florian Fainelli <f.fainelli@gmail.com>
>>>>>>
>>>>>>
>>>>>> I missed to CC MIPS maintainers.
>>>>>
>>>>> Yes, please resend the patch so it lands in patchwork.linux-mips.org.
>>>>
>>>>
>>>> This is a part of clean-up series of DT building.
>>>>
>>>> I want Acked-by from MIPS maintainers
>>>> so that the whole series can go to a different tree.
>>>> (DT or Kbuild).
>>>>
>>>>
>>>> Sam addressed more clean-up candidates in MIPS Makefiles
>>>> https://patchwork.kernel.org/patch/10041879/
>>>>
>>>> So, I will probably end up with touching those Makefiles more.
>>>>
>>>> All patches must go to the same tree.
>>>>
>>>>
>>>>>> 2017-11-05 14:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>>>>>> > arch/mips/boot/dts/brcm/bcm96358nb4ser.dts does not exist, so
>>>>>> > we cannot build bcm96358nb4ser.dtb .
>>>>>
>>>>> This appears to be due to the file being renamed in commit 695835511f96
>>>>> ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom").
>>>>> Please can you update the commit message when you resend to mention the
>>>>> cause of the problem.
>>>>>
>>>>> You could also add the following if you like while you're at it:
>>>>>
>>>>> Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom")
>>>>> Cc: <stable@vger.kernel.org> # 4.9+
>>>
>>> I think this one can be applied independently and we'd want it to if
>>> we tag for stable. So I think it can go thru the MIPS tree.
>>>
>>
>>
>> As I said to MIPS folks, this patch must go before 2/2.
>>
>> You picked up only 2/2, so your dt/kbuild branch is broken.
>>
>>
>> make ARCH=mips allyesconfig
>> && make ARCH=mips CROSS_COMPILE=mips-linux- dtbs
>>
>>
>> will produce the following error.
>>
>>
>> make[2]: *** No rule to make target
>> 'arch/mips/boot/dts/brcm/bcm96358nb4ser.dtb', needed by '__build'.
>> Stop.
>> scripts/Makefile.build:570: recipe for target 'arch/mips/boot/dts/brcm' failed
>> make[1]: *** [arch/mips/boot/dts/brcm] Error 2
>> arch/mips/Makefile:413: recipe for target 'dtbs' failed
>> make: *** [dtbs] Error 2
>>
>
>
> Looking into it, probably
> bmips_dtb_defconfig was already broken regardless my patches.
>
> But, I am not comfortable with breaking all{yes,mod}config
> because they are often used for build test.
>
>
> I hope you can apply this in the order as I sent,
> with the following tag.
>
> Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to
> bcm6358-neufbox4-sercom")
> Cc: <stable@vger.kernel.org> # 4.9+

Okay, now applied.

Rob
