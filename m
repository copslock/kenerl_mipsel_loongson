Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 20:47:44 +0100 (CET)
Received: from mail-qg0-f42.google.com ([209.85.192.42]:39579 "EHLO
        mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013859AbaKQTrjddNlD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 20:47:39 +0100
Received: by mail-qg0-f42.google.com with SMTP id i50so15822628qgf.15
        for <multiple recipients>; Mon, 17 Nov 2014 11:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5eKh+NNYDSP+JbItPWRw6XKoEgzrpSLO3Jc1l1OY82w=;
        b=DmPVmjsMmxbzwYO3JALStRo765BkC3k9XsafVDLiSiJMQR6srdJHPrC8V1ogyy5fdY
         /lISk1Rrr1oaLHFIGn6eiC8xKqHbA21pk45bSRGHrmyCVV0qtNFHDxP/ZnhoZJ33/XAD
         /S/tL4rTeRtmmQgjSJ6AypShUkKLvhXhAfcrrvpTBTOVdNmTfpWylE8BleD3zp7mV2hS
         awjwydopHIMfnubuWQqU9Zd0TdonhIVdL9QLJ8msPPW64SSQxQXuNAQpGkMFpw5eMWhX
         MvroOviMz501GmA846bi9uS0D/4PG+b8A0l7rJTjVWLeqlxEAOiigXXmKkeNqvB5Qcxm
         Iw0g==
X-Received: by 10.224.148.18 with SMTP id n18mr37447123qav.100.1416253654071;
 Mon, 17 Nov 2014 11:47:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Mon, 17 Nov 2014 11:47:12 -0800 (PST)
In-Reply-To: <14461008.6cZzGdpat2@wuerfel>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
 <2018325.yOrLZndTTm@wuerfel> <CAJiQ=7An5eZ3j2+Zkx1crV9pBSVodkEQ+6ESGcFk5z0tDV7cHA@mail.gmail.com>
 <14461008.6cZzGdpat2@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 17 Nov 2014 11:47:12 -0800
Message-ID: <CAJiQ=7CmFNhufdeoeH_6SuYOhf3Luwc2zwy_+8au1V8RW78rOw@mail.gmail.com>
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
X-archive-position: 44244
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

On Mon, Nov 17, 2014 at 10:55 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >> And unless there is one, having a
>> >> multiplatform kernel does not make much sense, as there is no sane way
>> >> to tell apart different platforms on boot.
>> >
>> > How do you normally tell boards apart on MIPS when you don't use DT?
>>
>> On BCM7xxx (STB) kernels, we could assume the chip ID was in a known
>> register, and also we could call back into the bootloader to get a
>> somewhat-accurate board name.
>>
>> On BCM63xx there is logic in arch/mips/bcm63xx/cpu.c to try to guess
>> the chip identity from the CPU type/revision (because the latter can
>> be read directly from CP0).
>>
>> These systems were never really designed to support multiplatform
>> kernels.  The ARM BCM7xxx variants, by contrast, were.
>
> Guessing the chip doesn't really help you all that much of course
> as long as you don't know the board, and once you know that,
> the chip is implied.

This mostly depends on the desired feature set, and the delta from one
board to the next.  Many of the reference board sections are largely
copied from a working design, but sometimes there are changes that
affect us.  Other times there are tweaks that can be autodetected,
like a different flash chip.

The analog interfaces like SATA/USB/Ethernet don't tend to vary all
that much (although some may be missing ports on the board, or
disabled on the chip).

The pin muxing situation leaves a lot of room for board differences,
and on these platforms it isn't really handled in a central place.
This gets even more challenging when combined with some of the power
management requirements.

The peripherals that I added in my patch submission are among the
easiest / safest of the bunch.
