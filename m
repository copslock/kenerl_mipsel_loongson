Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 01:13:13 +0100 (CET)
Received: from conssluserg-04.nifty.com ([210.131.2.83]:24283 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbdKIANGJ2xW9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 01:13:06 +0100
Received: from mail-yw0-f172.google.com (mail-yw0-f172.google.com [209.85.161.172]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id vA90CLYr018092;
        Thu, 9 Nov 2017 09:12:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com vA90CLYr018092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1510186342;
        bh=EmZEs0ECM8Cu/5biSg6ByVMNVat1fU9umQGH34atM2s=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=cJvjR57qC6emVpuYYa29NB/q0/fTxfBgX5aVckr0vl9CdgeCqWfdW6OzXZHdxrEij
         331MxL0GHgnsxHShOMl5IsFGG4uN3Sab/6GwEO4XHgHvBrT/2RleeNn4KHNCmOm6CP
         VD4KGdPQX/ttQPWY0dfG36nJ/ga72Z13dJ3UcgmPS5Czut1HxsC+xrGvNvQ6mp3okM
         kVs5p9GIm+ydG6ipRaK5SkHDg9nKBuOF0dTsZI5AqNNm3VjBHbR4aXtbb7u3/VDQfP
         wsLIIpacmo1wYDtk4k1JncvzFYzvpG4X4jykyv6odpfP4Kq9OhQLRUH3WsfOqnZ1jB
         fC5PoP1l7ocsw==
X-Nifty-SrcIP: [209.85.161.172]
Received: by mail-yw0-f172.google.com with SMTP id k11so3901435ywh.1;
        Wed, 08 Nov 2017 16:12:22 -0800 (PST)
X-Gm-Message-State: AJaThX5ZNp7CaLyUpQ6Pm17qOId9Kl0K7h1Z4t6Qptg0skTBuIahY88D
        87WgIvtLPC7Xr/kJ4O+HYo/4O+7nu37AfZsblQE=
X-Google-Smtp-Source: ABhQp+Tk3P+AP0RAicZvgvR/F5KXXDpP9OrWWodQnKfgvA2E53oJ7W4tTZQZE14A0H3ZWy8tKLq0zd8SJmNdFIrgspA=
X-Received: by 10.37.65.133 with SMTP id o127mr1368110yba.139.1510186341381;
 Wed, 08 Nov 2017 16:12:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.110.139 with HTTP; Wed, 8 Nov 2017 16:11:41 -0800 (PST)
In-Reply-To: <CAL_JsqJ8taCKnr_79UumiH2GFYq-fMzzkYm2iYevTOgUUWuzvg@mail.gmail.com>
References: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
 <1509859853-27473-2-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQfK_BWQcVW-ScrpAwNAHav3MrrzV-tjn_YUjsuvd7U5A@mail.gmail.com>
 <20171106095139.GG15260@jhogan-linux> <CAK7LNAQ_bugEP8hHKmCif5QCz2=Pw_GpXzYz4zJeXO0HXaT_ag@mail.gmail.com>
 <CAL_JsqJ8taCKnr_79UumiH2GFYq-fMzzkYm2iYevTOgUUWuzvg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 9 Nov 2017 09:11:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNATZ9O4cCpxLrG3MJoKYF+RnURkY4-tY2MdiZb90eGPtQg@mail.gmail.com>
Message-ID: <CAK7LNATZ9O4cCpxLrG3MJoKYF+RnURkY4-tY2MdiZb90eGPtQg@mail.gmail.com>
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
X-archive-position: 60781
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

2017-11-09 1:51 GMT+09:00 Rob Herring <robh+dt@kernel.org>:
> On Mon, Nov 6, 2017 at 5:00 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2017-11-06 19:41 GMT+09:00 James Hogan <jhogan@kernel.org>:
>>> Hi,
>>>
>>> On Sun, Nov 05, 2017 at 11:11:38PM +0900, Masahiro Yamada wrote:
>>>> +CC Ralf Baechle <ralf@linux-mips.org>
>>>> +CC linux-mips@linux-mips.org
>>>> +CC Kevin Cernekee <cernekee@gmail.com>
>>>> +CC Florian Fainelli <f.fainelli@gmail.com>
>>>>
>>>>
>>>> I missed to CC MIPS maintainers.
>>>
>>> Yes, please resend the patch so it lands in patchwork.linux-mips.org.
>>
>>
>> This is a part of clean-up series of DT building.
>>
>> I want Acked-by from MIPS maintainers
>> so that the whole series can go to a different tree.
>> (DT or Kbuild).
>>
>>
>> Sam addressed more clean-up candidates in MIPS Makefiles
>> https://patchwork.kernel.org/patch/10041879/
>>
>> So, I will probably end up with touching those Makefiles more.
>>
>> All patches must go to the same tree.
>>
>>
>>>> 2017-11-05 14:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>>>> > arch/mips/boot/dts/brcm/bcm96358nb4ser.dts does not exist, so
>>>> > we cannot build bcm96358nb4ser.dtb .
>>>
>>> This appears to be due to the file being renamed in commit 695835511f96
>>> ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom").
>>> Please can you update the commit message when you resend to mention the
>>> cause of the problem.
>>>
>>> You could also add the following if you like while you're at it:
>>>
>>> Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom")
>>> Cc: <stable@vger.kernel.org> # 4.9+
>
> I think this one can be applied independently and we'd want it to if
> we tag for stable. So I think it can go thru the MIPS tree.
>


As I said to MIPS folks, this patch must go before 2/2.

You picked up only 2/2, so your dt/kbuild branch is broken.


make ARCH=mips allyesconfig
&& make ARCH=mips CROSS_COMPILE=mips-linux- dtbs


will produce the following error.


make[2]: *** No rule to make target
'arch/mips/boot/dts/brcm/bcm96358nb4ser.dtb', needed by '__build'.
Stop.
scripts/Makefile.build:570: recipe for target 'arch/mips/boot/dts/brcm' failed
make[1]: *** [arch/mips/boot/dts/brcm] Error 2
arch/mips/Makefile:413: recipe for target 'dtbs' failed
make: *** [dtbs] Error 2


-- 
Best Regards
Masahiro Yamada
