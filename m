Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 17:05:18 +0200 (CEST)
Received: from mail-vc0-f169.google.com ([209.85.220.169]:36309 "EHLO
        mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007230AbaH1PFMsRW4Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 17:05:12 +0200
Received: by mail-vc0-f169.google.com with SMTP id hq11so978440vcb.28
        for <multiple recipients>; Thu, 28 Aug 2014 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=y3oTjNg7pjFdEizO8g/OVf8Z1Ame4l980U6aeFwi5yI=;
        b=PWZzDE7HxVrrYgGNz0ATYrQ0NITU8UPZsmQk//GEoy6qQtUNASd8uwbwnvHkcIYm6l
         Bgfdmnh9QfoTjpnnIQIMHtkDcLSx/pN2gDpMzf4Lf/VnpWwVKfxUmaB3WUZhlWAoHrKI
         JGQClMUeiV49T+WkbrBCQIJjef8rmM3PLTgwEo9HGWF8NCvhNAb7SdO42khdzDF4II4J
         kwZo0tSmyVVV4HRl6MJJVQ4gH1A3gKQ08qS7vL1IaxeJA3bYuUkt8FqtkCLFGTfMxQJ/
         hPSgQAp0m0uQPlAPtIE1Sh9xnPiKRRlxarYLX8H3G0WIy65bOPo+TOkehYwn/Wu4d71A
         f+Gg==
X-Received: by 10.52.73.202 with SMTP id n10mr1127437vdv.86.1409238306392;
 Thu, 28 Aug 2014 08:05:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.107.66 with HTTP; Thu, 28 Aug 2014 08:04:46 -0700 (PDT)
In-Reply-To: <CAOiHx=mZPt=p_jw4fyEqgniJvqunQ86ro_Run5ZtD1zLYWzmqA@mail.gmail.com>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
 <CAGVrzcZobuL4z0WNX+Sz4p_uwaPL-S5yvEmgRUwZPJi4+qq0tg@mail.gmail.com>
 <CAL1qeaGb-o0P7x4nZPJ+dGfoSKz+2ANrB0gGrBi19TtPxVTAZQ@mail.gmail.com>
 <20140823063113.GC23715@localhost> <CAMuHMdXudu0kuOkKN8JCrWZSrQ4awKHhHU0E2ss++ProP0rteQ@mail.gmail.com>
 <CAOiHx=mZPt=p_jw4fyEqgniJvqunQ86ro_Run5ZtD1zLYWzmqA@mail.gmail.com>
From:   Rob Herring <robherring2@gmail.com>
Date:   Thu, 28 Aug 2014 10:04:46 -0500
Message-ID: <CAL_Jsq+zpvK4Zbp4cN2eq3hfGDc09x3d4+b_TdEgnSQ5063rZw@mail.gmail.com>
Subject: Re: [PATCH 0/7] MIPS: Move device-tree files to a common location
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Olof Johansson <olof@lixom.net>,
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
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

On Mon, Aug 25, 2014 at 10:17 AM, Jonas Gorski <jogo@openwrt.org> wrote:
> On Sat, Aug 23, 2014 at 9:50 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Sat, Aug 23, 2014 at 8:31 AM, Olof Johansson <olof@lixom.net> wrote:
>>>> > arch/arm/boot/dts/<vendor>/
>>>> >
>>>> > Is this something we should do for the MIPS and update the other architectures
>>>> > to follow that scheme?
>>>>
>>>> I recall reading that as well and that it would be adopted for ARM64,
>>>> but that hasn't seemed to have happened.  Perhaps Olof (CC'ed) will no
>>>> more.
>>>
>>> Yeah, I highly recommend having a directory per vendor. We didn't on ARM,
>>> and the amount of files in that directory is becoming pretty
>>> insane. Moving to a subdirectory structure later gets messy which is
>>> why we've been holding off on it.
>>
>> It would mean we can change our scripts to operate on "interesting"
>> DTS files from
>>
>>      do-something-with $(git grep -l $vendor, -- arch/arm/boot/dts)
>>
>> to
>>
>>     do-something-with arch/arm/boot/dts/$vendor/*
>>
>> which is easier to type...
>
> Btw, do you mean chip-vendor or device-vendor with vendor?
> Device-vendor could get a bit messy on the source part as the router
> manufacturers tend to switch them quite often. E.g. d-link used arm,
> mips and ubi32 chips from marvell, ubicom, broadcom, atheros, realtek
> and ralink for their dir-615 router, happily switching back and forth.
> There are 14 known different hardware revisions of it where the chip
> differed from the previous one.

There's probably no hard and fast rule that works perfectly for
everything. Since the chip/soc generally defines most of the platform,
I would say follow the chip vendor. A few "../other-vendor/" includes
would be okay, but they should be the exception. 3rd party boards with
common daughter cards come to mind here.

Rob
