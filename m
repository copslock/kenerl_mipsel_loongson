Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 22:57:34 +0100 (CET)
Received: from mail-qa0-f53.google.com ([209.85.216.53]:59458 "EHLO
        mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013875AbaKQV5dRCESg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 22:57:33 +0100
Received: by mail-qa0-f53.google.com with SMTP id n8so15043575qaq.26
        for <multiple recipients>; Mon, 17 Nov 2014 13:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yx9DOoiLYtWxk6ygy2R7llEtqjCVJaha0smSSTrt4+I=;
        b=HE7071RrrFAXk+n9ziG+zsHw558LBojVTccaO/ulFkCTsVlOIddp30Yqcpe65aSLH9
         hGnY5Tb1oI33B5TLnuJpZNjv1BO3nUnTSFKVDVscbVAuL6VVMhaigozO+k1J+Qb40P8e
         GFaESLirf2UmPv5oxLXSBzNvKP3mVBT3C6Hyu8uasyYjgvKgbzXocfjRf1y/HtpEwMs9
         osmtIWZwt4LNlIRBgSiALdzaIq/W2wRDSgj+bH/JyD35ey447ZzGXJBsm/u+rwnUqhGj
         EUewdMLySSZDkjvfSN34YE62SJF5KcE4kHEURGypkqCs9Z3xEwwsPohqOMtEamC2SyNM
         40eQ==
X-Received: by 10.140.84.71 with SMTP id k65mr37396727qgd.76.1416261447380;
 Mon, 17 Nov 2014 13:57:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Mon, 17 Nov 2014 13:57:07 -0800 (PST)
In-Reply-To: <2622492.TiaF5tO0a3@wuerfel>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
 <14461008.6cZzGdpat2@wuerfel> <CAJiQ=7CmFNhufdeoeH_6SuYOhf3Luwc2zwy_+8au1V8RW78rOw@mail.gmail.com>
 <2622492.TiaF5tO0a3@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 17 Nov 2014 13:57:07 -0800
Message-ID: <CAJiQ=7AhyAyN6Hnvtdowdh6oPknbPFMe-_PrPdzyCGe5H7eE1g@mail.gmail.com>
Subject: Re: [PATCH V2 22/22] MIPS: Add multiplatform BMIPS target
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jonas Gorski <jogo@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Mon, Nov 17, 2014 at 12:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> This mostly depends on the desired feature set, and the delta from one
>> board to the next.  Many of the reference board sections are largely
>> copied from a working design, but sometimes there are changes that
>> affect us.  Other times there are tweaks that can be autodetected,
>> like a different flash chip.
>>
>> The analog interfaces like SATA/USB/Ethernet don't tend to vary all
>> that much (although some may be missing ports on the board, or
>> disabled on the chip).
>>
>> The pin muxing situation leaves a lot of room for board differences,
>> and on these platforms it isn't really handled in a central place.
>> This gets even more challenging when combined with some of the power
>> management requirements.
>>
>> The peripherals that I added in my patch submission are among the
>> easiest / safest of the bunch.
>
> Right, that is exactly the danger: it's easy to get the basics working
> like this, but the differences between SoCs are not what we need DT
> for anyway, those are easily abstracted in kernel code if necessary,
> hardcoded by some soc version identifier.

That depends on how many SoC's we're talking about...

On MIPS we have literally dozens.  Most of the "building blocks" are
pretty similar, but the MMIO addresses, IRQ mappings, and
quantity/revision of each peripheral vary.  DT is ideal for
representing these differences and for rapidly bringing up a new
system.

> What you end up with in your approach is a kernel that can support
> multiple SoCs but only some boards per SoC, and otherwise you still
> depend on compile-time configuration.

Agreed, but for legacy platforms this is somewhat inevitable.  These
systems are already in production so there is no manpower available to
go back and test every single one-off board.  It is most likely that a
small subset of "interesting" boards will receive the best support.
For instance, I see an arch/arm/boot/dts/bcm2835-rpi-b.dts, but that's
hardly the only BCM2835-based platform found in the wild.

The limited board support doesn't negate the value of having a generic
BMIPS kernel available upstream; this build still eliminates
duplicated efforts on many of the basic items (CPU/SMP/caching, IRQ
controllers, UART).  It also allows easy reuse of DT-ready peripherals
that are common to the CM/DSL/STB MIPS and ARM chips, which was the
original goal of the BCM3384 port.

Going forward I would expect that with this build available in
mainline, it will open up new opportunities for modernizing the
bootloaders on each product line.

> Aside from pin configuration,
> you have to have a per-board dtb file if you have any i2c or spi
> connected components, PCI devices with custom interrupt lines,
> LEDs, GPIO buttons, or anything else on a nondiscoverable bus.

Correct.

For better or for worse, most of these don't use Linux kernel drivers on STB.
