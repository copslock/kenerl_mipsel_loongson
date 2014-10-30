Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 21:54:34 +0100 (CET)
Received: from mail-qc0-f169.google.com ([209.85.216.169]:48739 "EHLO
        mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012329AbaJ3UycxD3e4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 21:54:32 +0100
Received: by mail-qc0-f169.google.com with SMTP id i17so4958744qcy.28
        for <multiple recipients>; Thu, 30 Oct 2014 13:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YPwv98gF0dCugD4mZH/OckUW7jT1Tksu+PnFttFJvm8=;
        b=YyUlzblciDFLrTH9EA848GPIIsBgVl8dGKyr619tcFZxUDvm1muXB/6JN/2D7QTQne
         eOrvT9vTd786NkXim8byT1eaKi2HukDBpQ689jsi15nlspyanWPDWkmDVdIMtH34X5Dz
         Iylu1i6DwP6Qg2bl/uYGt6ySYSoxhhf6yHnQRN1dwlNVkam2wbJk8+5LrgL9klQ6gvth
         COQdK+qLu/tfIBT6BX3pfxU7VDuSbDXtcnZUe0YUyjEo3v/Rh2QNJlJV3WXTITuaXppx
         P1UxvSIO+sXQa4Vhren9WVh8J4dkQ19tWhWgdD6TEFwoIKKWHUPduKTnZNbNFfG6XCSC
         aYLA==
X-Received: by 10.140.102.169 with SMTP id w38mr28638611qge.95.1414702466797;
 Thu, 30 Oct 2014 13:54:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Thu, 30 Oct 2014 13:54:06 -0700 (PDT)
In-Reply-To: <7275578.mKZ88H670E@wuerfel>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
 <7309232.oJGU5dTioF@wuerfel> <CAJiQ=7DD_ivNyJpZnQFKfaFBM5nk0Gb-S-5wfXuF9fxZ_FWHvA@mail.gmail.com>
 <7275578.mKZ88H670E@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Thu, 30 Oct 2014 13:54:06 -0700
Message-ID: <CAJiQ=7C+r80Jt51NXLCk-0D2nRezBfMN9pGBVT9V8ncefGhBnQ@mail.gmail.com>
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
X-archive-position: 43794
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

On Thu, Oct 30, 2014 at 12:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > Ah, I think I understand what you mean now. So this strapping is done
>> > for legacy operating systems that are not endian-aware and hardwired
>> > to one or the other.
>>
>> Hmm, maybe, but this wasn't done for legacy reasons.  The system was
>> designed to run in either endianness, with the understanding that all
>> software would be built for either LE or BE and that the hardware
>> would be strapped for one or the other.
>>
>> On dev boards this is a jumper on the board, but on production boards
>> it is often immutable.
>
> But only legacy OSs would need the jumper or the pin. Any modern OS
> like Linux should just work in either endianess independent of how
> the registers are done.

I did some checking; AFAICT our hardware does not support the type of
runtime endian switching that you describe.

MIPS CP0 register 12 bit 25 (Reverse Endian) "reverses the memory
endian selection when operating in user mode. Kernel or debug mode
references are not affected by the state of this bit."

MIPS CP0 register 16 bit 15 (Big Endian) "Indicates the endian mode in
which the processor is running. Set via SI_Endian input pin."  This
bit is read-only.

Based on the datasheets, the RE bit may be supported in BMIPS4380, but
is not supported in BMIPS5000 or MIPS 34K.  In any event, it won't
have an impact on kernel I/O accesses.

>> > In Linux, we don't care about that, we have the source and we can
>> > just make it run on any hardware we care about. If you port a kernel
>> > to such a platform, the best strategy is to ignore what the SoC
>> > vendor tried to do for the other OSs and set the chip into "never
>> > translate" in hardware so you can handle it correctly in the kernel.
>>
>> Right, the intention was to remain source-compatible between LE/BE,
>> but not binary-compatible.
>
> Well, I guess they failed on the "source-compatible" part ;-)

We have kernel trees and bootloaders that build LE/BE images from the
same source tree, just by changing CONFIG_CPU_*_ENDIAN.  They use the
__raw_ macros or equivalent when talking to peripherals.

>> Either the __raw_ accessors, or dynamically choosing between
>> readl/ioread32be based on CONFIG_CPU_BIG_ENDIAN (or DT properties, if
>> absolutely necessary), would work.
>
> No, this is just wrong. Don't ever assume that the endianess of the
> kernel has anything to do with how the hardware is built. You can
> make it a separate Kconfig option, and you can make it default
> to CPU_BIG_ENDIAN, but the two things are fundamentally different,
> whatever the hardware designers try to tell you.

But we have a situation where kernel endianness == hardware
endianness, so can't we make simplifying assumptions?

>> > - Any MMIO access to device memory storing byte streams (network
>> >   packets, audio, block, ...) will be swapped the same way that
>> >   the registers do, which means you now have to do the expensive
>> >   byte swaps (memcpy_fromio) in software instead of the cheap ones
>> >   (writel)
>>
>> The various endianness settings also affect our CPU's "view" of DRAM.
>> All current BCM7xxx SoCs have extra logic to make sure that packet
>> data, disk sectors from SATA, and other "bulky" transfers all arrive
>> in a suitable byte order.
>
> Wow, that seems like a lot of hardware effort to gain basically
> nothing. If they managed to get this right, at least it won't
> make it harder to support the hardware properly.

The hardware was built to guarantee that a byte access to skb->data[0]
reads back byte 0 of the packet, not byte 3, regardless of whether
we're in LE or BE mode.

It takes a surprising amount of effort to make sure this is done
consistently and correctly across dozens of onchip peripherals.

>> That depends somewhat on whether we're talking about binary-level
>> compatibility, or source-level compatibility.  For the latter case, we
>> can always redefine readl() to match the hardware at compile time.  On
>> MIPS this can be done through CONFIG_SWAP_IO_SPACE.
>
> That option seems to be incompatible with running one kernel across
> multiple SoC families, if each of them does it differently.

Agreed.  We have many such challenges on MIPS.  In the end, it is
possible that not every MIPS SoC will "fit the mold."

>> One catch is that almost all BCM7xxx MIPS systems are actually LE, and
>> BE gets less test coverage.  Some boards cannot even be configured for
>> BE.  BE has mostly been kept around to accommodate a few customers
>> with legacy code, not out of a burning desire to support both modes of
>> operation...
>
> If all the boards can be configured for LE, then you can just make this
> mode required when upstreaming the kernel port, independent of how the
> kernel runs.

I was hoping to eventually come up with a multiplatform BE BMIPS image
that boots on 3384, 6328, and 7346... (even though the common case for
7xxx is LE, it makes for a nice demo)
