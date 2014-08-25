Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 17:18:47 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:39487 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006728AbaHYPSqJ17Pa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 17:18:46 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 1368C2815D6;
        Mon, 25 Aug 2014 17:18:30 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qa0-f54.google.com (mail-qa0-f54.google.com [209.85.216.54])
        by arrakis.dune.hu (Postfix) with ESMTPSA id B2F9E28B40C;
        Mon, 25 Aug 2014 17:17:51 +0200 (CEST)
Received: by mail-qa0-f54.google.com with SMTP id k15so12201084qaq.41
        for <multiple recipients>; Mon, 25 Aug 2014 08:18:02 -0700 (PDT)
X-Received: by 10.224.88.198 with SMTP id b6mr36299831qam.97.1408979882003;
 Mon, 25 Aug 2014 08:18:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.84.244 with HTTP; Mon, 25 Aug 2014 08:17:41 -0700 (PDT)
In-Reply-To: <CAMuHMdXudu0kuOkKN8JCrWZSrQ4awKHhHU0E2ss++ProP0rteQ@mail.gmail.com>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
 <CAGVrzcZobuL4z0WNX+Sz4p_uwaPL-S5yvEmgRUwZPJi4+qq0tg@mail.gmail.com>
 <CAL1qeaGb-o0P7x4nZPJ+dGfoSKz+2ANrB0gGrBi19TtPxVTAZQ@mail.gmail.com>
 <20140823063113.GC23715@localhost> <CAMuHMdXudu0kuOkKN8JCrWZSrQ4awKHhHU0E2ss++ProP0rteQ@mail.gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 25 Aug 2014 17:17:41 +0200
Message-ID: <CAOiHx=mZPt=p_jw4fyEqgniJvqunQ86ro_Run5ZtD1zLYWzmqA@mail.gmail.com>
Subject: Re: [PATCH 0/7] MIPS: Move device-tree files to a common location
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Olof Johansson <olof@lixom.net>,
        Andrew Bresticker <abrestic@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        John Crispin <blogic@openwrt.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Sat, Aug 23, 2014 at 9:50 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sat, Aug 23, 2014 at 8:31 AM, Olof Johansson <olof@lixom.net> wrote:
>>> > arch/arm/boot/dts/<vendor>/
>>> >
>>> > Is this something we should do for the MIPS and update the other architectures
>>> > to follow that scheme?
>>>
>>> I recall reading that as well and that it would be adopted for ARM64,
>>> but that hasn't seemed to have happened.  Perhaps Olof (CC'ed) will no
>>> more.
>>
>> Yeah, I highly recommend having a directory per vendor. We didn't on ARM,
>> and the amount of files in that directory is becoming pretty
>> insane. Moving to a subdirectory structure later gets messy which is
>> why we've been holding off on it.
>
> It would mean we can change our scripts to operate on "interesting"
> DTS files from
>
>      do-something-with $(git grep -l $vendor, -- arch/arm/boot/dts)
>
> to
>
>     do-something-with arch/arm/boot/dts/$vendor/*
>
> which is easier to type...

Btw, do you mean chip-vendor or device-vendor with vendor?
Device-vendor could get a bit messy on the source part as the router
manufacturers tend to switch them quite often. E.g. d-link used arm,
mips and ubi32 chips from marvell, ubicom, broadcom, atheros, realtek
and ralink for their dir-615 router, happily switching back and forth.
There are 14 known different hardware revisions of it where the chip
differed from the previous one.



Jonas
