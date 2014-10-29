Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 19:49:07 +0100 (CET)
Received: from mail-qa0-f46.google.com ([209.85.216.46]:51801 "EHLO
        mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011673AbaJ2StGOehPN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 19:49:06 +0100
Received: by mail-qa0-f46.google.com with SMTP id s7so2586430qap.5
        for <multiple recipients>; Wed, 29 Oct 2014 11:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TijFK+A1KCz57+54Y4kFD1qBUm9ia3e1yIYUkhNggyU=;
        b=rd0mguy/M0UV4gU3pHK/qJBivcFT7n255FUn6nwpYWknkzClst5npifEbQfOLrbhuI
         WxFfB1eswhzuDs8XYhY6IOqAqLJurslNG1ctYYlzd1l4Z8B8JMAO2zXb1yZCNfX2t1um
         wv1L+5kCaZ6h+Yd/eo9BNPEj6Y+WzSJJGCAJm3TThvT2S0+opFvBYO6savTrZ5EOcn4w
         Y1/lcB7zQsOHKIwyFRoTWFBrdCgbljmxWhthXiFDaVSzQp1UzWvDjyPd+14WOlygigBn
         IwxDSqSpPS7Oas4XyVogO1r0tUEJ7+snSeISBWgDipuFuxpUERYENB2OkfhHp3hpGqTX
         xf5A==
X-Received: by 10.140.102.169 with SMTP id w38mr17600456qge.95.1414608539829;
 Wed, 29 Oct 2014 11:48:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Wed, 29 Oct 2014 11:48:39 -0700 (PDT)
In-Reply-To: <11255905.1JsQYcArO7@wuerfel>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <11255905.1JsQYcArO7@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 29 Oct 2014 11:48:39 -0700
Message-ID: <CAJiQ=7BcVH52-PCo40dSEoNHjT1Pg8X88uq-KZ6tQPKYWaM94A@mail.gmail.com>
Subject: Re: [PATCH 01/11] irqchip: Allow irq_reg_{readl,writel} to use __raw_{readl_writel}
To:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
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
X-archive-position: 43719
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

On Wed, Oct 29, 2014 at 12:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 28 October 2014 20:58:48 Kevin Cernekee wrote:
>>
>> +#ifdef CONFIG_RAW_IRQ_ACCESSORS
>> +
>> +#ifndef irq_reg_writel
>> +# define irq_reg_writel(val, addr)     __raw_writel(val, addr)
>> +#endif
>> +#ifndef irq_reg_readl
>> +# define irq_reg_readl(addr)           __raw_readl(addr)
>> +#endif
>> +
>> +#else
>> +
>
> No, this is just wrong: registers almost always have a fixed endianess
> indenpent of CPU endianess, so if you use __raw_writel, it will be
> broken on one or the other.
>
> If you have a machine that uses big-endian registers in the interrupt
> controller, you need to find a way to use the correct accessors
> (e.g. iowrite32be) and use them independent of what endianess the CPU
> is running.
>
> As this code is being used on all sorts of platforms, you can't assume
> that they all use the same endianess, which makes it rather tricky.
>
> As the first step, you can probably introduce a new Kconfig symbol
> GENERIC_IRQ_CHIP_BE, and then make that mutually exclusive with the
> existing users that all use little-endian registers:
>
> #if defined(CONFIG_GENERIC_IRQ_CHIP) && !defined(CONFIG_GENERIC_IRQ_CHIP_BE)
> #define irq_reg_writel(val, addr)     writel(val, addr)
> #else if defined(CONFIG_GENERIC_IRQ_CHIP_BE) && !defined(CONFIG_GENERIC_IRQ_CHIP)
> #define irq_reg_writel(val, addr)     iowrite32be(val, addr)
> #else
> /* provoke a compile error when this is used */
> #define irq_reg_writel(val, addr)       irq_reg_writel_unknown_endian(val, addr)
> #endif

Thanks for the quick feedback, guys.  Let me try to fill in a little
more background information.

The irqchip drivers in question can be used on a variety of different SoCs:

BCM7xxx STB chip with ARM host (always LE)
BCM7xxx STB chip with MIPS host (user-selectable LE or BE via jumper)
BCM33xx cable chip with MIPS host (always BE)
BCM33xx cable chip with ARM host (always LE)
BCM63xx[x] DSL chip with MIPS host (always BE)
BCM63xx[x] DSL chip with ARM host (always LE, I think)
BCM68xx PON chip with MIPS host (always BE)

The host CPU is connected to the peripheral/register interface using a
32-bit wide data bus.  A simple 32-bit store originating from the host
CPU, targeted to an onchip SoC peripheral, will never need endian
swapping.  i.e. this code works equally well on all supported systems
regardless of endianness:

    volatile u32 *foo = (void *)MY_REG_VA;
    *foo = 0x12345678;

8-bit and 16-bit accesses may be another story, but only appear in a
few very special peripherals.

The external PCI/PCIe address space, by contrast, is always mapped
"bytewise," such that a 32-bit word's LSB is at offset 0 and the MSB
is at offset 3.  On the BE platforms, readl/writel/readw/writew will
implement an extra endian swap, allowing stock PCI device drivers such
as bnx2 or e1000e to work without modification.  (The other option is
to byteswap the data but use address swizzling for 8/16 bit accesses,
that isn't enabled by default.)

The problem we see here is that irq_reg_{readl,writel} use
readl/writel to access a non-PCI peripheral, thus adding an unwanted
endian swap.  And I can't avoid using the irq_reg_* accessors unless I
skip using GENERIC_IRQ_CHIP.

So, a few possible solutions include:

1) Implement your CONFIG_GENERIC_IRQ_CHIP_BE suggestion.  This could
probably be made to work, but I would need to define
CONFIG_GENERIC_IRQ_CHIP / CONFIG_GENERIC_IRQ_CHIP_BE conditionally
based on whether the build was LE or BE.  It would be nicer if the
driver didn't have to think about endianness because we know all of
these register accesses are always "native."

2) Offer a common way for irqchips to force GENERIC_IRQ_CHIP to use
the __raw_ variants.  Since there are already other irqchip drivers
using __raw_*, this seems like it might be useful to others someday.

3) Stuff my __raw_ definitions into the mach-specific <irq.h>.

4) Don't use GENERIC_IRQ_CHIP at all; just reimplement the helpers
locally using __raw_* macros.

> registers almost always have a fixed endianess
> indenpent of CPU endianess

Going back to this statement - in my own personal experience, SoCs are
usually designed such that extra swaps are NOT necessary when
accessing onchip peripherals.  Although I've seen a few cases where
1-2 peripherals, often third party IP cores, needed special treatment.

FWIW, several of the BCM7xxx peripherals default to "native" mode (no
swap for either LE/BE), but can be optionally reconfigured as LE in
order to preserve compatibility with the standard AHCI/SDHCI/...
drivers that use the PCI accessors.

Not sure how easy it is to figure out which other SoCs do require the
swap, as we'd need to exclude both PCI drivers and LE hosts whose
drivers just used plain readl.  But a quick look around the drivers/
tree shows quite a few users of the __raw_ accessors:

$ git grep -l __raw_readl drivers | wc -l
228

By contrast, for BE-only registers:

$ git grep -lE "(ioread32be)|(readl_be)" drivers/ | wc -l
42

The latter list seems to include a lot of FPGAs.  Maybe it costs them
too many gates/LEs to support both endian orderings.


Thomas:
> How does that work with multi arch kernels?

I am assuming this question refers to e.g. CONFIG_ARCH_MULTIPLATFORM

If GENERIC_IRQ_CHIP is being used, the current implementation of
generic-chip.c will have to pick one global definition of
irq_reg_{readl,writel} for all supported SoCs.

One possibility is that individual irqchip drivers requiring special
accessors can pass in their own function pointers, similar to this:

struct sdhci_ops {
#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
u32 (*read_l)(struct sdhci_host *host, int reg);
u16 (*read_w)(struct sdhci_host *host, int reg);
u8 (*read_b)(struct sdhci_host *host, int reg);
void (*write_l)(struct sdhci_host *host, u32 val, int reg);
void (*write_w)(struct sdhci_host *host, u16 val, int reg);
void (*write_b)(struct sdhci_host *host, u8 val, int reg);
#endif

and fall back to readl/writel if none are supplied.  It would be nice
if this provided common definitions for the __raw_ and maybe the BE
variants too.

Or, we could add IRQ_GC_NATIVE_IO and/or IRQ_GC_BE_IO to enum irq_gc_flags.

Would either of these choices satisfy everyone's goals?
