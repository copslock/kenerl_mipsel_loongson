Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 21:10:15 +0100 (CET)
Received: from mail-qc0-f171.google.com ([209.85.216.171]:41716 "EHLO
        mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011693AbaJ2UKOJCNzl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 21:10:14 +0100
Received: by mail-qc0-f171.google.com with SMTP id m20so3050290qcx.2
        for <multiple recipients>; Wed, 29 Oct 2014 13:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FS2mMO4ZZVdE13I56lMjZzocnj1BT7E+Mqy0GZqlaws=;
        b=waksUdekFqfkNnDj8Wnduw/QEFYRCrw9PD1ME1ege957AbMdi8Ns3ToYYph8hwOj4r
         ZuySvIHZPN+Ye54wsuNXFDASWNdOZEnlvqKM/m0h0zz+Tf9k1EHIrl3sLbh+tOFi5r/q
         woINZA4JmwKbT/Xh6RTknfWzTZRIEeb6vwHelDKSWzfnKyMqpeDldxsrDfGUvQXtDrv5
         YGSmrF+9koDUIHvC8pY1om9zTadHMEXv7tuWs8j/lRLpaM9vAPzSAdqfp0vyjg325Sn+
         vf589IzrAf011NdhVKOaMTxz6enUJUEYVuwvaoj2X/1EK9+LfaoVCZl+poyt387zJi4m
         awlQ==
X-Received: by 10.224.41.142 with SMTP id o14mr19613937qae.100.1414613408090;
 Wed, 29 Oct 2014 13:10:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Wed, 29 Oct 2014 13:09:47 -0700 (PDT)
In-Reply-To: <5338153.4SY4TFtus9@wuerfel>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
 <11255905.1JsQYcArO7@wuerfel> <CAJiQ=7BcVH52-PCo40dSEoNHjT1Pg8X88uq-KZ6tQPKYWaM94A@mail.gmail.com>
 <5338153.4SY4TFtus9@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 29 Oct 2014 13:09:47 -0700
Message-ID: <CAJiQ=7C7SzT2ngQzP=dQqdQz=+ShJ_Jf0z4kwFgvUKg1G3vrAw@mail.gmail.com>
Subject: Re: [PATCH 01/11] irqchip: Allow irq_reg_{readl,writel} to use __raw_{readl_writel}
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43724
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

On Wed, Oct 29, 2014 at 12:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> The host CPU is connected to the peripheral/register interface using a
>> 32-bit wide data bus.  A simple 32-bit store originating from the host
>> CPU, targeted to an onchip SoC peripheral, will never need endian
>> swapping.  i.e. this code works equally well on all supported systems
>> regardless of endianness:
>>
>>     volatile u32 *foo = (void *)MY_REG_VA;
>>     *foo = 0x12345678;
>>
>> 8-bit and 16-bit accesses may be another story, but only appear in a
>> few very special peripherals.
>
> Sorry, but this makes no sense. If you run a little-endian kernel
> on one of the MIPS systems that you marked as "always BE", or a
> big-endian kernel on the systems that are marked "always LE",
> then you have to byte swap.

If I ran an LE MIPS kernel on a BE system, it would hang on boot.  I
know this through experience. ;-)

Setting aside the problem that the instruction words, pointers, and
bitfields in the image are all in the wrong byte order, there are many
other endian-specific assumptions baked into the executable.

Does this actually work on other architectures like ARM?  I still see
compile-time checks for CONFIG_CPU_ENDIAN* in a couple of places under
arch/arm.

>> FWIW, several of the BCM7xxx peripherals default to "native" mode (no
>> swap for either LE/BE), but can be optionally reconfigured as LE in
>> order to preserve compatibility with the standard AHCI/SDHCI/...
>> drivers that use the PCI accessors.
>
> The reconfigurability is definitely the worst part.

That depends on who is doing the reconfiguring...

If the kernel has to support both options, then it's definitely a
hassle (and probably quite intrusive for some drivers).

In our case we just enable swapping unconditionally and then use the
stock driver code, with no changes to the I/O accessors.

>> Or, we could add IRQ_GC_NATIVE_IO and/or IRQ_GC_BE_IO to enum irq_gc_flags.
>>
>> Would either of these choices satisfy everyone's goals?
>
> This is what I meant with doing extra work in the case where we want to
> support both in the same kernel. We would only enable the runtime
> logic if both GENERIC_IRQ_CHIP and GENERIC_IRQ_CHIP_BE are set, and
> leave it up to the platform to select the right one. For MIPS BCM7xxx,
> you could use
>
> config BCM7xxx
>         select GENERIC_IRQ_CHIP if CPU_LITTLE_ENDIAN
>         select GENERIC_IRQ_CHIP_BE if CPU_BIG_ENDIAN
>
> so you would default to the hardwired big-endian accessor unless
> some other drivers selects GENERIC_IRQ_CHIP.

generic-chip.c already has a fair amount of indirection, with pointers
to saved masks, user-specified register offsets, and such.  Is there a
concern that introducing, say, a pair of readl/writel function
pointers, would cause an unacceptable performance drop?

Backing up a little bit, do we have a consensus that defining
irq_reg_{readl,writel} at compile time from include/linux/irq.h is a
bad idea for multiplatform images, and it should be removed one way or
another?
