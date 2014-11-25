Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 19:22:56 +0100 (CET)
Received: from mail-ig0-f182.google.com ([209.85.213.182]:58052 "EHLO
        mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007054AbaKYSWvOaYvN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Nov 2014 19:22:51 +0100
Received: by mail-ig0-f182.google.com with SMTP id hn15so1208992igb.3
        for <multiple recipients>; Tue, 25 Nov 2014 10:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=r0ZO36A4ji4Ihg3sci+RS7Jd1YNg0DAIHKFKFwdPZ1w=;
        b=CbVkqyJ0gH91nrycY4NeUBUttPvzAqDVJjt6lkY4TWooo3photFPpo/PM/3bbgJmMR
         KqtjVBxUS8Ey6q1SKJPungvqf+HtxicPFnUx+rREorCZIoA7Us4RtSOLqrmh2/WjHnng
         BYjw3qd42ZZ1inSfDhzRFvhb9fhWvzXi8bw7SF8Bltkpo8t7gv1BoH/i940AESqAPSh1
         z/Eh38txTzDl269vnvfJ2u6GTUuzLi9rlKgFyrADZi4p5/b8WN2ooSgmOFPI19ST4J6t
         JVxDviPhzpn0LJnRwgBkAs9wApF9P0LtCuPZ1NGCL20meWU6iNlIdfchu8Arxs116GRY
         iAHw==
MIME-Version: 1.0
X-Received: by 10.107.170.98 with SMTP id t95mr25133634ioe.7.1416939765049;
 Tue, 25 Nov 2014 10:22:45 -0800 (PST)
Received: by 10.107.14.9 with HTTP; Tue, 25 Nov 2014 10:22:44 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1411251407290.16047@utopia.booyaka.com>
References: <1416736241-12723-1-git-send-email-zajec5@gmail.com>
        <1416778509-31502-1-git-send-email-zajec5@gmail.com>
        <alpine.DEB.2.02.1411240910100.16047@utopia.booyaka.com>
        <CACna6rxwwn5_e86278TAiOFZ3sVu_Exfm2x94vN2KiTJfsFujQ@mail.gmail.com>
        <alpine.DEB.2.02.1411251407290.16047@utopia.booyaka.com>
Date:   Tue, 25 Nov 2014 19:22:44 +0100
Message-ID: <CACna6rxj8=V8me1_L8SxhV3=kgYRyKeBHkxShSMZa4kbcHimLg@mail.gmail.com>
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
X-archive-position: 44447
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

On 25 November 2014 at 18:50, Paul Walmsley <paul@pwsan.com> wrote:
>> I don't think NVRAM can be treated as a standard char device. Also, in
>> my V1 I tried moving it to the drivers/misc/, but then drivers/soc/
>> was suggested as a better place, see Arnd's reply:
>> http://www.linux-mips.org/archives/linux-mips/2014-11/msg00238.html
>
> Yeah.  It depends on who is going to merge the patch.  If you can persuade
> someone else to merge it in drivers/soc, then it doesn't really matter
> what I think.

I'm looking for the solution that will satisfy most ppl. I understand
your arguments against drivers/soc/, but on the other hand I have no
idea where else this driver could go.


>> > Looking at arch/mips/bcm47xx/nvram.c: if the low-level NVRAM probe code
>> > were moved elsewhere, the higher-level NVRAM "interpretation" functions
>> > still remain: bcm47xx_nvram_getenv() and bcm47xx_nvram_gpio_pin().  Those
>> > seem to be intended to parse device configuration data, yes?  And this
>> > device configuration data is organized this way by platform software
>> > convention -- there's no hardware requirement to store data this way in
>> > the NVRAM, right?
>>
>> This bcm47xx_nvram driver has two ways of reading NVRAM content:
>> 1) Using a standard MTD API to access "nvram" partition. In such case
>> flash driver is a low-level thing if you call it so.
>
> OK, so just to confirm, you are referring to these drivers:
>
> drivers/mtd/nand/bcm47xxnflash/*
> drivers/mtd/devices/bcm47xxsflash.c
> drivers/ssb/driver_mipscore.c (for pflash)
> drivers/bcma/driver_mips.c (for pflash)
>
> ?

Yes, these are drivers for Broadcom flash memories that implement
(more or less directly) MTD API. There is also a new SPI-NOR based
driver I'm trying to upstream (it was already sent, needs accepting
some more spi-nor changes first).


> Just out of curiosity, the nvram.c code seems to contain some code to work
> around cases where the flash size is larger than the MMIO aperture, and to
> truncate the copy.  Is there some way to program the flash controller to
> point the aperture at a different section of the flash?

Er, not really. We assume NVRAM content is not bigger than NVRAM_SPACE
(0x8000), but that's all. If NVRAM can be read using MMIO, then it's
always fully available.

There isn't any documented way of reprogramming flash content mapping
into memory.


>> 2) Using memory-mapped flash access window. In such case there isn't
>> any extra low-level driver.
>
> Could you point me at the software entity that configures the
> memory-mapped flash access window and programs the flash controller to use
> one of {p,n,s}flash?  Or is that done by some code external to the kernel,
> like the bootloader?

It's done by the CFE (bootloader). You can find CFE source in some
tarballs published by Asus in their GPL firmware packages. I never
really focused on CFE source, never tried to compiling it or
re-installing.


>> The "nvram" partition is required by the bootloader (CFE). It contains
>> some important info like CPU clock, RAM configuration, switch ports
>> layout. Then it's used by system drivers (like Ethernet driver bgmac)
>> to get info about some particular hardware parts (like PHY address,
>> MAC, etc.).
>
> So it's not used by the on-chip boot-ROM?  Sounds like it's just software
> convention, then?  In other words, if one used a different bootloader,
> like u-boot, and passed a DT or something like that to the kernel, this
> wouldn't be needed.  The presence and format of this flash is part of a
> specific hardware/software platform, external to the SoC hardware itself,
> that Broadcom suggests.  It's analogous to ARM ATAGS -
> arch/arm/kernel/atags_parse.c.  Does all this match your understanding?
> (I'm not advocating using a different bootloader or device data format - I
> think it's important to preserve compatibility with CPE - I am just trying
> to understand how this area of flash is used.)

I guess yes, you could probably use different bootloader and hardcode
all important settings into it (e.g. using DTB).

I guess DT is older than CFE, but Broadcom decided to invent own
solution called NVRAM anyway. This is a bit messy, because it actually
stores hardware details (CPU, RAM, switch) as well as user settings
(e.g. LEDs behavior). I can't say why Broadcom decided to implement it
this way.

We all would love to see Broadcom shipping devices with U-Boot and DT! ;)


>> > So if the answer to the above two questions is "yes," meaning that this
>> > NVRAM is used to store device probing data by software convention, then it
>> > would seem to me that proposing some place like
>> > drivers/devicedata/bcm47xx-nvram is a better bet (where "bcm47xx-nvram" is
>> > just some kind of opaque token).  Looking at those two functions, it
>> > doesn't seem like there's really anything MIPS or Broadcom or NVRAM or
>> > even SoC-specific about key-value pair parsing and GPIO device data?  Or
>> > am I missing something?
>> >
>> > Actually, considering that bcm47xx_nvram_gpio_pin() isn't even used, can
>> > we just drop it and save the hassle?  :-)
>>
>> We need this function to easily find GPIO responsible for "something".
>> For example during switch initialization we need to reset it toggling
>> GPIO. NVRAM contains info which GPIO should be toggled, e.g.:
>> gpio4=robo_reset
>> (robo means roboswitch)
>>
>> bcm47xx_nvram_gpio_pin is needed by out-of-tree "b53" driver that some
>> tried to push upstream, but was rejected because of API.
>>
>> I'll also send a patch to USB host driver soon that will require
>> bcm47xx_nvram_gpio_pin.
>
> OK thanks for the context.
>
> It sounds to me like this code is a combination of three
> pieces:
>
> 1. code that autoprobes the size of the "nvram" partition in the Broadcom
> platform flash, by reading various locations in the MMIO flash aperture,
> configured by some other system entity

That's right, on MIPS we simply detect flash type (drivers/ssb &
driver/bcma) and using that we init NVRAM passing memory offset where
the flash is mapped.


> 2. code that shadow copies the device data from the MMIO flash aperture
> into system RAM
>
> 3. code that parses the CPE-generated device data and returns it to other
> drivers
>
> Does that sound accurate?

Correct (s/CPE/CFE).

-- 
Rafał
