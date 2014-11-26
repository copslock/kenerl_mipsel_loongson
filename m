Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 06:19:12 +0100 (CET)
Received: from mail-qg0-f53.google.com ([209.85.192.53]:46163 "EHLO
        mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006931AbaKZFTKX7QgP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 06:19:10 +0100
Received: by mail-qg0-f53.google.com with SMTP id q108so1579192qgd.12
        for <multiple recipients>; Tue, 25 Nov 2014 21:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lEcREGz4mMsIr2oUxkBxzOSf2kr7DgnfUsCHw0qdBU0=;
        b=GrsaPxjj9aN3/OWDfOIf2ZmDOKCODwh2e3wmbSmLYCCaw/3M9wLGzxt3JiDab4ukBY
         dGFdiukki2ugrZeaXqsb7xwS2c7AgtB7aohZSqbYcwLUVjDKt1P36U1saBkSOPGoo4ma
         RHHgAMB1JylnS2KOoUt+b9FxM0/tDTbuZKeUx5/k8RXWwSBT8PsRABk4TWNUwGERc4TC
         AURS50ZnuoaaltcJLTfLs5UBp/XQ8j8T6KBnS6KKiiQtTG+kE4W1Z3EixqzosDm40kRq
         rPltrJTukfmqZfWAblhPYwskw3kxMooNIBvJA4KbGmOsJtU934YklEtIz/8SAr/stVnX
         vyqQ==
X-Received: by 10.224.80.71 with SMTP id s7mr41470706qak.35.1416979144538;
 Tue, 25 Nov 2014 21:19:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Tue, 25 Nov 2014 21:18:44 -0800 (PST)
In-Reply-To: <CAOiHx=ntm7AO5BU2Ge0JDC5nDgXSZwQDm05s5VTM8mLqYmCZRw@mail.gmail.com>
References: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
 <1416796846-28149-7-git-send-email-cernekee@gmail.com> <CAOiHx=ntm7AO5BU2Ge0JDC5nDgXSZwQDm05s5VTM8mLqYmCZRw@mail.gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Tue, 25 Nov 2014 21:18:44 -0800
Message-ID: <CAJiQ=7CvpFWxDY1uad2bZz8MBG0Mvg2Jx8WBp6gHi-kD4TDvXA@mail.gmail.com>
Subject: Re: [PATCH V3 06/11] irqchip: bcm7120-l2: Change DT binding to allow
 non-contiguous IRQEN/IRQSTAT
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Brian Norris <computersforpeace@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44464
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

On Mon, Nov 24, 2014 at 6:31 AM, Jonas Gorski <jogo@openwrt.org> wrote:
> On Mon, Nov 24, 2014 at 3:40 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
>> To date, all supported controllers have had the IRQEN register at offset
>> 0x00 and the IRQSTAT register at 0x04.  So in DT we would typically see
>> something like:
>>
>>     reg = <0xf0406800 0x8>;
>>
>> We still want to support this format, but we also need to support cases
>> where IRQEN and IRQSTAT aren't adjacent.  So, we will amend the driver to
>> accept an alternate format that looks like this:
>>
>>     reg = <0xf0406800 0x4 0xf0406804 0x4>;
>>
>> i.e. if the first resource_size() == 4, assume that the first resource
>> points to IRQEN and that the next resource points to IRQSTAT.  If the
>> first resource_size() == 8, retain the current behavior.
>>
>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>
> Hmm ... the more I think about this, the less I like it.
>
> Using the amount and size of the reg-properties to infer a certain
> layout seems rather hackish and dirty to me. Maybe we should just use
> different compatible match ids for that? E.g. brcm,bm7120-l2-intc for
> the 32-bit en/stat pairs, and e.g. brcm,bcm6368-l2-intc for the 64-bit
> wide one. Or maybe make the bcm63xx one a separate driver and let it
> share code with the bcm7120-l2-intc driver.

In my current proposal, it is easy to specify an arbitrary number of
enable/status pairs located in any order and spread across different
parts of the register space.  Even register indices (0,2,4,...) are
enable registers, and odd register indices are status registers.

If I'm interpreting your post correctly, you don't agree that we need
this level of flexibility.  But looking over the register listings,
here are the cases we need to cover:


6828,6318: 4x mask(exthi,extlo,hi,lo),status(exthi,extlo,hi,lo)

TP0ExtIrqMaskHi
TP0ExtIrqMaskLo
TP0IrqMaskHi
TP0IrqMaskLo
TP0ExtIrqStatusHi
TP0ExtIrqStatusLo
TP0IrqStatusHi
TP0IrqStatusLo

TP1ExtIrqMaskHi
TP1ExtIrqMaskLo
...


6816,6362,6328: 2x extmask,mask,extstatus,status

ExtraChipIrqMask
ChipIrqMask
ExtraChipIrqStatus
ChipIrqStatus
ExtraChipIrqMask1 [1=TP1]
ChipIrqMask1
ExtraChipIrqStatus1
ChipIrqStatus1


6368: similar to above, but with yet another naming convention:

IRQMASK_MIPS0_Hi
IRQMASK_MIPS0_Lo
IRQSTATUS_MIPS0_Hi
IRQSTATUS_MIPS0_Lo
IRQMASK_MIPS1_Hi
IRQMASK_MIPS1_Lo
IRQSTATUS_MIPS1_Hi
IRQSTATUS_MIPS1_Lo



6838,3384: interleaved "mystery meat" mask/status (same IRQ source
names, with the output of each bcm7120-l2 routed to several different
processors/threads):

PeriphIRQMASK0
PeriphIRQSTATUS0
PeriphIRQMASK1 <- mine, if running on Zephyr
PeriphIRQSTATUS1 <- mine, if running on Zephyr
PeriphIRQMASK2
PeriphIRQSTATUS2
PeriphIRQMASK3 <- mine, if running on Viper
PeriphIRQSTATUS3 <- mine, if running on Viper

But wait, there's more!  There wasn't enough space in this block for
>32 IRQ bits, so the upper bits spilled over into a separate
"INT_EXT_PER" block that lives elsewhere in the register space:

PeriphIRQMASK0_2
PeriphIRQSTATUS0_2
PeriphIRQMASK1_2 <- mine, if running on Zephyr
PeriphIRQSTATUS1_2 <- mine, if running on Zephyr
PeriphIRQMASK2_2
PeriphIRQSTATUS2_2
PeriphIRQMASK3_2 <- mine, if running on Viper
PeriphIRQSTATUS3_2 <- mine, if running on Viper

The "INT_PER" and "INT_EXT_PER" outputs are ORed into the same MIPS
IRQ lines, so we need to treat them as two sides of a single
controller.  AFAICT, unlike a shared device IRQ, there is no way to
share a MIPS IRQ line between two controller instances.

Additionally, we have a few other random MASK/STATUS pairs scattered
around (ZMIPS, CMIPS blocks), and then we also have DQM IRQs with
multiple mask registers + single status register:

CMIPS_NOT_EMPTY_IRQ_MSK
CMIPS1_NOT_EMPTY_IRQ_MSK <- mine, if running on Viper
ZMIPS_NOT_EMPTY_IRQ_MSK <- mine, if running on Zephyr
PMC_NOT_EMPTY_IRQ_MSK
DFAP_NOT_EMPTY_IRQ_MSK
NOT_EMPTY_IRQ_STS

I suppose another alternative is to ioremap() a range large enough to
cover enable + status, and then specify the offset of each one in
another property.  This does run the risk of overlapping mappings.


> This would avoid having to specify a lot of regs (let's assume we also
> add support for affinity)

I concede that I have no idea how affinity should be handled here.
AFAICT it is completely off limits on BCM3384 because we just don't
have enough L2 outputs to offer proper masking for all of the
threads/CPUs in the system.

Perhaps we could write a simple, SMP-capable driver for the
saner/newer SoCs, and use the flexible-but-non-SMP version for the
complicated ones.


> and cause a lot of io(re)map calls

Is the ioremap() call really that big of a deal?

On MIPS it's basically computing CKSEG1ADDR(phys_addr).  On ARM, the
top level (with 64 to 128+ IRQs) goes through the GIC.  On both,
ioremap() is a one-time cost at startup.
