Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Nov 2017 12:02:21 +0100 (CET)
Received: from conssluserg-02.nifty.com ([210.131.2.81]:26116 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990474AbdKFLCOWtaRW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Nov 2017 12:02:14 +0100
Received: from mail-yw0-f172.google.com (mail-yw0-f172.google.com [209.85.161.172]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id vA6B1UEJ000850;
        Mon, 6 Nov 2017 20:01:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com vA6B1UEJ000850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1509966091;
        bh=WysYu5Sxu6316PTx3ouBkF7DbThYY1lMR2jI3KJv3NM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=WgQ1cCZLlutdtmKRPO9+hoGH5IyMU4IzLvxrICezT9aufWTWswnDRpwhHGRwSIveD
         dfrny/vUFPchVU3vt5Ft0NoxlIvOMfrgMaX2ejBISX9wtkgyu0X2pXoJjpx3y5ZJvl
         MgNSqgd4PxyidGRR8W80O0RYyTSkQEW9LcCBhfkn96eKMQm/wE1/Qt7lGbiejzWc0e
         KJp4YozWzBBxWycU0EkekKiqVKoW72UDD7H0uPfFAhkfssesuzfgUEP5ULyNr26rdG
         hLMEJYgDIK/oD+WZHZql3wJMzOlIwVF4YOKAXeWBTjp3nHf6WXY2qCUsGzfrE+JbXM
         uK7GQzIn3mCbA==
X-Nifty-SrcIP: [209.85.161.172]
Received: by mail-yw0-f172.google.com with SMTP id i198so7440724ywe.7;
        Mon, 06 Nov 2017 03:01:30 -0800 (PST)
X-Gm-Message-State: AJaThX4nfvebW4+u0InIEGtP+BjhzCg1YOrXyWvRSfMGrh3CgOhOfMd4
        6/C9H7oB9B6BQS2iCPM9VFe5AgWOEjCindzJmHs=
X-Google-Smtp-Source: ABhQp+S6st6Khdgn+ig50twx14zY3olLsDt/eVy4vrfnJxCbnKA52nivxZGi3I4Un/d4aGeTeDq+860ii83JpTY32bY=
X-Received: by 10.37.113.197 with SMTP id m188mr4704481ybc.390.1509966089673;
 Mon, 06 Nov 2017 03:01:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.110.139 with HTTP; Mon, 6 Nov 2017 03:00:49 -0800 (PST)
In-Reply-To: <20171106095139.GG15260@jhogan-linux>
References: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
 <1509859853-27473-2-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQfK_BWQcVW-ScrpAwNAHav3MrrzV-tjn_YUjsuvd7U5A@mail.gmail.com> <20171106095139.GG15260@jhogan-linux>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 6 Nov 2017 20:00:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ_bugEP8hHKmCif5QCz2=Pw_GpXzYz4zJeXO0HXaT_ag@mail.gmail.com>
Message-ID: <CAK7LNAQ_bugEP8hHKmCif5QCz2=Pw_GpXzYz4zJeXO0HXaT_ag@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: dts: remove bogus bcm96358nb4ser.dtb from dtb-y entry
To:     James Hogan <jhogan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60719
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

2017-11-06 19:41 GMT+09:00 James Hogan <jhogan@kernel.org>:
> Hi,
>
> On Sun, Nov 05, 2017 at 11:11:38PM +0900, Masahiro Yamada wrote:
>> +CC Ralf Baechle <ralf@linux-mips.org>
>> +CC linux-mips@linux-mips.org
>> +CC Kevin Cernekee <cernekee@gmail.com>
>> +CC Florian Fainelli <f.fainelli@gmail.com>
>>
>>
>> I missed to CC MIPS maintainers.
>
> Yes, please resend the patch so it lands in patchwork.linux-mips.org.


This is a part of clean-up series of DT building.

I want Acked-by from MIPS maintainers
so that the whole series can go to a different tree.
(DT or Kbuild).


Sam addressed more clean-up candidates in MIPS Makefiles
https://patchwork.kernel.org/patch/10041879/

So, I will probably end up with touching those Makefiles more.

All patches must go to the same tree.


>> 2017-11-05 14:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> > arch/mips/boot/dts/brcm/bcm96358nb4ser.dts does not exist, so
>> > we cannot build bcm96358nb4ser.dtb .
>
> This appears to be due to the file being renamed in commit 695835511f96
> ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom").
> Please can you update the commit message when you resend to mention the
> cause of the problem.
>
> You could also add the following if you like while you're at it:
>
> Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom")
> Cc: <stable@vger.kernel.org> # 4.9+
>


Will do.  Thanks!


-- 
Best Regards
Masahiro Yamada
