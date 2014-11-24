Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 11:35:12 +0100 (CET)
Received: from mail-ig0-f180.google.com ([209.85.213.180]:53533 "EHLO
        mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006625AbaKXKfLM3ljL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Nov 2014 11:35:11 +0100
Received: by mail-ig0-f180.google.com with SMTP id h15so2867390igd.13
        for <multiple recipients>; Mon, 24 Nov 2014 02:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2+q4wE4mH5ksBD+zYr4FvcKqVW9uAai67BvPXGq7klY=;
        b=I1Jdu7tiOiRqedz37aev5nSnTBjlAeKX+Li0Nb7BVPQ33dRh3aXCBodVoM+N4s9ooE
         3wt9PBgQhp6WZAs8EwB9Wk5t2mhLHBJW6s2t5U4zzASfYDvq85YV07iYryaGEj6dpk1h
         LcFwnXz7gcThrS78qiWE2HZdg3neo7uvhrQFS4XB/oi/jFNjEJr8Nv3QT+yR4YIrAKKm
         c0n68pjUHLI2CE+xdok8unxp+3GjRNIi5SaIScIGsT5fW5tPSwM5JqzwawuJHdhEbGho
         JPIwHW9LfzuwmXJRNQD+CyS+iWTofdQ4KwRn8oxVjUGWuGyq8XKsks047itRGQ70UNuJ
         eVZg==
MIME-Version: 1.0
X-Received: by 10.107.155.196 with SMTP id d187mr17593185ioe.14.1416825305331;
 Mon, 24 Nov 2014 02:35:05 -0800 (PST)
Received: by 10.107.14.9 with HTTP; Mon, 24 Nov 2014 02:35:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1411240910100.16047@utopia.booyaka.com>
References: <1416736241-12723-1-git-send-email-zajec5@gmail.com>
        <1416778509-31502-1-git-send-email-zajec5@gmail.com>
        <alpine.DEB.2.02.1411240910100.16047@utopia.booyaka.com>
Date:   Mon, 24 Nov 2014 11:35:05 +0100
Message-ID: <CACna6rxwwn5_e86278TAiOFZ3sVu_Exfm2x94vN2KiTJfsFujQ@mail.gmail.com>
Subject: Re: [PATCH V3] MIPS: BCM47XX: Move NVRAM driver to the drivers/soc/
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Paul Walmsley <paul@pwsan.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kumar Gala <galak@codeaurora.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sandeep Nair <sandeep_n@ti.com>, linux-soc@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 24 November 2014 at 11:02, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Rafał.
>
> On Sun, 23 Nov 2014, Rafał Miłecki wrote:
>
>> After Broadcom switched from MIPS to ARM for their home routers we need
>> to have NVRAM driver in some common place (not arch/mips/).
>
> So this is a driver for a chunk of NVRAM that's embedded in the SoC,
> hanging off an I/O bus?
>
> Is this actually some kind of RAM, or is it flash, or something else?

I think you missed my description (help section) in Kconfig file :) As
it says, NVRAM is a special partition on flash.


>> We were thinking about putting it in bus directory, however there are
>> two possible buses for MIPS: drivers/ssb/ and drivers/bcma/. So this
>> won't fit there neither.
>> This is why I would like to move this driver to the drivers/soc/
>
> Can't speak for anyone else, but I personally consider drivers/soc to be
> primarily intended for so-called "integration" IP blocks.  Those are used
> for SoC control functions.
>
> So low-level NVRAM drivers would probably go somewhere else.  Here are
> some likely possibilities, where it can live with others of its kind
> (assuming it is something similar to RAM):
>
> 1. the PC "CMOS memory" NVRAM driver appears to be under drivers/char, as
> drivers/char/nvram.c.
>
> 2. there's a generic SRAM driver, drivers/misc/sram.c
>
> 3. while people have put some of the eFuse code under drivers/soc, in my
> opinion, the low-level fuse access code should really go under
> drivers/misc/fuse.

I don't think NVRAM can be treated as a standard char device. Also, in
my V1 I tried moving it to the drivers/misc/, but then drivers/soc/
was suggested as a better place, see Arnd's reply:
http://www.linux-mips.org/archives/linux-mips/2014-11/msg00238.html


> Looking at arch/mips/bcm47xx/nvram.c: if the low-level NVRAM probe code
> were moved elsewhere, the higher-level NVRAM "interpretation" functions
> still remain: bcm47xx_nvram_getenv() and bcm47xx_nvram_gpio_pin().  Those
> seem to be intended to parse device configuration data, yes?  And this
> device configuration data is organized this way by platform software
> convention -- there's no hardware requirement to store data this way in
> the NVRAM, right?

This bcm47xx_nvram driver has two ways of reading NVRAM content:
1) Using a standard MTD API to access "nvram" partition. In such case
flash driver is a low-level thing if you call it so.
2) Using memory-mapped flash access window. In such case there isn't
any extra low-level driver.

The "nvram" partition is required by the bootloader (CFE). It contains
some important info like CPU clock, RAM configuration, switch ports
layout. Then it's used by system drivers (like Ethernet driver bgmac)
to get info about some particular hardware parts (like PHY address,
MAC, etc.).


> So if the answer to the above two questions is "yes," meaning that this
> NVRAM is used to store device probing data by software convention, then it
> would seem to me that proposing some place like
> drivers/devicedata/bcm47xx-nvram is a better bet (where "bcm47xx-nvram" is
> just some kind of opaque token).  Looking at those two functions, it
> doesn't seem like there's really anything MIPS or Broadcom or NVRAM or
> even SoC-specific about key-value pair parsing and GPIO device data?  Or
> am I missing something?
>
> Actually, considering that bcm47xx_nvram_gpio_pin() isn't even used, can
> we just drop it and save the hassle?  :-)

We need this function to easily find GPIO responsible for "something".
For example during switch initialization we need to reset it toggling
GPIO. NVRAM contains info which GPIO should be toggled, e.g.:
gpio4=robo_reset
(robo means roboswitch)

bcm47xx_nvram_gpio_pin is needed by out-of-tree "b53" driver that some
tried to push upstream, but was rejected because of API.

I'll also send a patch to USB host driver soon that will require
bcm47xx_nvram_gpio_pin.

-- 
Rafał
