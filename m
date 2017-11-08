Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2017 17:52:07 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:43912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992312AbdKHQv6khFPc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Nov 2017 17:51:58 +0100
Received: from mail-qt0-f178.google.com (mail-qt0-f178.google.com [209.85.216.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0441921937;
        Wed,  8 Nov 2017 16:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0441921937
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
Received: by mail-qt0-f178.google.com with SMTP id 1so4146522qtn.3;
        Wed, 08 Nov 2017 08:51:56 -0800 (PST)
X-Gm-Message-State: AJaThX6aLixb86L9xUQGnRafHXtwNNDrWBz+792i1UuIJ9hrhsGZggFo
        7iD466dRwQ4f0f8Nexs/LNJcn8eOV4D3/rcnEg==
X-Google-Smtp-Source: ABhQp+S6UBBLsX0TYLvCyNxyOCWHY+fvkTn7bDA+QDRPifXoOJvpE+N9+8Mt70THlLgRH6mO+MnD0FIhKFptAnMOFJU=
X-Received: by 10.237.42.43 with SMTP id c40mr1782919qtd.322.1510159916174;
 Wed, 08 Nov 2017 08:51:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.130.134 with HTTP; Wed, 8 Nov 2017 08:51:35 -0800 (PST)
In-Reply-To: <CAK7LNAQ_bugEP8hHKmCif5QCz2=Pw_GpXzYz4zJeXO0HXaT_ag@mail.gmail.com>
References: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
 <1509859853-27473-2-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQfK_BWQcVW-ScrpAwNAHav3MrrzV-tjn_YUjsuvd7U5A@mail.gmail.com>
 <20171106095139.GG15260@jhogan-linux> <CAK7LNAQ_bugEP8hHKmCif5QCz2=Pw_GpXzYz4zJeXO0HXaT_ag@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 Nov 2017 10:51:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ8taCKnr_79UumiH2GFYq-fMzzkYm2iYevTOgUUWuzvg@mail.gmail.com>
Message-ID: <CAL_JsqJ8taCKnr_79UumiH2GFYq-fMzzkYm2iYevTOgUUWuzvg@mail.gmail.com>
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
X-archive-position: 60760
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

On Mon, Nov 6, 2017 at 5:00 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2017-11-06 19:41 GMT+09:00 James Hogan <jhogan@kernel.org>:
>> Hi,
>>
>> On Sun, Nov 05, 2017 at 11:11:38PM +0900, Masahiro Yamada wrote:
>>> +CC Ralf Baechle <ralf@linux-mips.org>
>>> +CC linux-mips@linux-mips.org
>>> +CC Kevin Cernekee <cernekee@gmail.com>
>>> +CC Florian Fainelli <f.fainelli@gmail.com>
>>>
>>>
>>> I missed to CC MIPS maintainers.
>>
>> Yes, please resend the patch so it lands in patchwork.linux-mips.org.
>
>
> This is a part of clean-up series of DT building.
>
> I want Acked-by from MIPS maintainers
> so that the whole series can go to a different tree.
> (DT or Kbuild).
>
>
> Sam addressed more clean-up candidates in MIPS Makefiles
> https://patchwork.kernel.org/patch/10041879/
>
> So, I will probably end up with touching those Makefiles more.
>
> All patches must go to the same tree.
>
>
>>> 2017-11-05 14:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>>> > arch/mips/boot/dts/brcm/bcm96358nb4ser.dts does not exist, so
>>> > we cannot build bcm96358nb4ser.dtb .
>>
>> This appears to be due to the file being renamed in commit 695835511f96
>> ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom").
>> Please can you update the commit message when you resend to mention the
>> cause of the problem.
>>
>> You could also add the following if you like while you're at it:
>>
>> Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom")
>> Cc: <stable@vger.kernel.org> # 4.9+

I think this one can be applied independently and we'd want it to if
we tag for stable. So I think it can go thru the MIPS tree.

Rob
