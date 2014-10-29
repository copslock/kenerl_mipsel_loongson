Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 00:05:53 +0100 (CET)
Received: from mail-qg0-f49.google.com ([209.85.192.49]:56512 "EHLO
        mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011766AbaJ2XFrvE9Tk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 00:05:47 +0100
Received: by mail-qg0-f49.google.com with SMTP id z60so320695qgd.36
        for <multiple recipients>; Wed, 29 Oct 2014 16:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+S9UIx0t32XSHXwkHZmPDCBR6YYxTGH9IPWZBRTOnRw=;
        b=0kS4qUkNXTPa1kRoNCncbE182+ec237WmexXoWR+bxE1eu3hMqR1ywppmJn01lcHb4
         9PFJpi2zf5/fahQcZaOzYQ1uWfIwhLtCsEzESYRIoBYm+LRCfHUkQxtq7J8eckRPfU9C
         rwVLmrwCV2/TdK3Dji/Lr3wJgDP5uWV8hovAh52ohnmijs5lYViYoU8NKcOnYhDKi3y8
         jYZyk5i9bbpTYOpVbbIfv85fOd56Bhrh7JRdatSvhIVeZh1aeKJP21uKrUCI1xv5kYqa
         TmKzok+vO99USrTxL8+G2nbhwxYw0+3qnhd2YHT6+0mjiVfOpkelZDXs8Wx+3pmWyyJ+
         TpNA==
X-Received: by 10.140.102.169 with SMTP id w38mr19560200qge.95.1414623941678;
 Wed, 29 Oct 2014 16:05:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Wed, 29 Oct 2014 16:05:21 -0700 (PDT)
In-Reply-To: <22478002.kqKBdeLAKz@wuerfel>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
 <5338153.4SY4TFtus9@wuerfel> <CAJiQ=7C7SzT2ngQzP=dQqdQz=+ShJ_Jf0z4kwFgvUKg1G3vrAw@mail.gmail.com>
 <22478002.kqKBdeLAKz@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 29 Oct 2014 16:05:21 -0700
Message-ID: <CAJiQ=7DWEr9Oej6=+3vqKL_fJd2-wvQjx2Xw4dYwyE3AGDXOUA@mail.gmail.com>
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
X-archive-position: 43730
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

On Wed, Oct 29, 2014 at 2:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 29 October 2014 13:09:47 Kevin Cernekee wrote:
>> On Wed, Oct 29, 2014 at 12:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >> The host CPU is connected to the peripheral/register interface using a
>> >> 32-bit wide data bus.  A simple 32-bit store originating from the host
>> >> CPU, targeted to an onchip SoC peripheral, will never need endian
>> >> swapping.  i.e. this code works equally well on all supported systems
>> >> regardless of endianness:
>> >>
>> >>     volatile u32 *foo = (void *)MY_REG_VA;
>> >>     *foo = 0x12345678;
>> >>
>> >> 8-bit and 16-bit accesses may be another story, but only appear in a
>> >> few very special peripherals.
>> >
>> > Sorry, but this makes no sense. If you run a little-endian kernel
>> > on one of the MIPS systems that you marked as "always BE", or a
>> > big-endian kernel on the systems that are marked "always LE",
>> > then you have to byte swap.
>>
>> If I ran an LE MIPS kernel on a BE system, it would hang on boot.  I
>> know this through experience.
>
> What is a "BE system" then? Is the CPU core not capable of running
> code either way?

On the MIPS BCM7xxx chips, LE/BE support was a design requirement.  So:

 - The chips include a strap pin for LE/BE so it can be configured
through board jumpers.  This is the only supported method of switching
endianness.

 - Endianness interactions and performance concerns have been analyzed
for all peripherals, buses, and data flows.

 - As Florian mentioned earlier, the LE/BE strap preconfigures several
hardware blocks at boot time, e.g. telling the SPI controller how to
arrange the incoming data such that the MSB of each instruction word
read from flash shows up in the right place.

 - The entire software stack (and even the cross toolchain) needs to
be compiled for either LE or BE.

So in this context a "BE system" is a BCM7xxx MIPS chip strapped for
BE, or one of the BCM33xx/BCM63xx/BCM68xx MIPS chips that is hardwired
and verified for BE only.

>> Does this actually work on other architectures like ARM?  I still see
>> compile-time checks for CONFIG_CPU_ENDIAN* in a couple of places under
>> arch/arm.
>
> Yes, it should work on any architecture that supports both modes. It
> definitely works on all ARM cores I know, and on most PowerPC cores.
> I always assumed that MIPS was bi-endian as well, but according to
> what you say I guess it is not.
>
> ARM and PowerPC can actually switch endianess in the kernel, and this
> is what they do in the first instruction when you run a different
> endianess from what the boot loader runs as it calls into the kernel.
> The ARM boot protocol requires entering the kernel in little-endian
> mode, while I think on PowerPC the boot loader is supposed to detect
> the format of the kernel binary and pick the right mode before calling
> it.

Is it the intention to allow runtime endian switching on any
ARM/PowerPC platform (even the Samsung products you mentioned)?  Or
only on the boards that were designed to operate this way?

Our problem becomes much simpler if we assume that the majority of
systems have a fixed endianness, and only a few special cases need to
accommodate the different kernel/register endianness permutations
you've listed.
