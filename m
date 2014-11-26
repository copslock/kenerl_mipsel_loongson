Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 21:46:16 +0100 (CET)
Received: from mail-qc0-f179.google.com ([209.85.216.179]:53584 "EHLO
        mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007090AbaKZUqO0HHGp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 21:46:14 +0100
Received: by mail-qc0-f179.google.com with SMTP id c9so2630681qcz.38
        for <multiple recipients>; Wed, 26 Nov 2014 12:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QfZxjreBmVpCiWZ5UOXtOOg6A+YcIM2wEoSqQNQPV9o=;
        b=zdnpQmYbsDBT3Ti/eZQDBPsNFJTbu/lu6x+atV4Z20WM1O8/DRVIEW1JLrwQcbWy3J
         yX28l1A92DgNcYQxs3HWtHhkg4ua8rovOrkQhaD/rPlQzPWvG9Bo2eh9gep8Iz4XMJ0P
         EHreFiOw5NhgXed2M6LGDGPD/E2Bt1qmZmIcgrfZAcXHqOVq08veG8/wV2S7nua4x6e6
         w7PSerU1zfEInVHAFNHazKy/QEXjSSd6VQIa99OIV3rgk/nsJlI/BtZxV6z6fvrxlaxL
         mJ2Y3nk1eh+/2R0bANyTRTl4mpDz+cJlL0nBVzqQ90+g+U80mwnBhe2tgtDRg0bA3r1B
         IzMw==
X-Received: by 10.229.174.70 with SMTP id s6mr47611020qcz.7.1417034767685;
 Wed, 26 Nov 2014 12:46:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Wed, 26 Nov 2014 12:45:47 -0800 (PST)
In-Reply-To: <3146555.WCj2bhBSnP@wuerfel>
References: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
 <11772640.IZcxoRkMEM@wuerfel> <CAJiQ=7BXW5iWm7t_62dpm8fDppG0JCiW+okVKhPYUKSWGQhd_Q@mail.gmail.com>
 <3146555.WCj2bhBSnP@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 26 Nov 2014 12:45:47 -0800
Message-ID: <CAJiQ=7DwhSySAa19OxfUDkvT4DLWaZ3uhPU2QJzQ6Gc7YCvDgg@mail.gmail.com>
Subject: Re: [PATCH V3 11/11] MIPS: Add multiplatform BMIPS target
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jonas Gorski <jogo@openwrt.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44477
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

On Mon, Nov 24, 2014 at 1:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > As mentioned before, it seems like you are simply defining these all to zero,
>> > like most other platforms do too. Why not add this file as
>> > arch/mips/include/asm/mach-generic/war.h and delete all identical copies?
>>
>> Likewise - currently every existing MIPS machine type implements it this way.
>>
>> Perhaps a future patch series can generalize the way these definitions
>> are handled on MIPS?
>
> I'd like to hear what Ralf thinks about it, it's really his decision.
> What I was pointing out here are things that are still in the way of
> a real "multiplatform" implementation. None of these are really hard
> to do, but I don't know where you are heading with MIPS.

That probably depends on what types of platforms were going to be
supported by the multiplatform kernel.  For the case of war.h, about
2/3rds of arch/mips/include/asm/mach-*/war.h contain all zeroes...

> I think in case of the last one, it's really just a matter of moving the
> file, you could delete the other copies later.

...and so that's probably a good idea in general.

>> >> +OF_DECLARE_2(irqchip, mips_cpu_intc, "mti,cpu-interrupt-controller",
>> >> +          mips_cpu_irq_of_init);
>> >
>> > OF_DECLARE_2 really wasn't meant to be used directly. Can you move this
>> > code into drivers/irqchip and make it use IRQCHIP_DECLARE()?
>>
>> Perhaps arch/mips/kernel/irq_cpu.c could be moved under
>> drivers/irqchip in a future commit?  We'll probably have to change the
>> way arch/mips/ralink invokes it too.
>
> Possibly, but that seems unrelated. Moving this file is required
> in order to use IRQCHIP_DECLARE, which is defined in
> drivers/irqchip/irqchip.h.

arch/mips/kernel/irq_cpu.c is the actual irqchip driver containing
mips_cpu_irq_of_init().  It probably would not make sense to move
arch/mips/bmips/irq.c (platform IRQ stubs, not an irqchip driver)
under drivers/irqchip.

>> > Is this intended to become a generic MIPS boot interface? Better
>> > document it in Documentation/mips/
>>
>> Not sure yet.  It's currently limited to BCM3384.
>>
>> For V4 I can add an "Entry point for arch/mips/bmips" or even an
>> "Entry point for arch/mips" section to
>> Documentation/devicetree/booting-without-of.txt.  Any preferences?
>
> If the goal is being able to have a multiplatform kernel
> that can cover more than just BMIPS, I think this would have
> to be documented as the only way for MIPS multiplatform.
>
> If that isn't possible, most of my other comments here are
> moot, but then you shouldn't call it "multiplatform" but just
> "generic BMIPS" or something like that.

Currently my goal is to cover BMIPS only.  Although it's possible that
someday somebody develops a more hardware-independent implementation
that runs on other MIPS processor variants.

So, I can go ahead and rename it to "Generic BMIPS" if that clarifies
the intent.

>> >> diff --git a/arch/mips/include/asm/mach-bmips/dma-coherence.h b/arch/mips/include/asm/mach-bmips/dma-coherence.h
>> >> new file mode 100644
>> >> index 000000000000..5481a4d1bbbf
>> >> --- /dev/null
>> >> +++ b/arch/mips/include/asm/mach-bmips/dma-coherence.h
>> >> @@ -0,0 +1,45 @@
>> >> +#ifndef __ASM_MACH_BMIPS_DMA_COHERENCE_H
>> >> +#define __ASM_MACH_BMIPS_DMA_COHERENCE_H
>> >> +
>> >> +struct device;
>> >> +
>> >> +extern dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size);
>> >> +extern dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page);
>> >> +extern unsigned long plat_dma_addr_to_phys(struct device *dev,
>> >> +     dma_addr_t dma_addr);
>> >> +extern void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
>> >> +     size_t size, enum dma_data_direction direction);
>> >
>> > I think you could just add these to
>> > arch/mips/include/asm/mach-generic/dma-coherence.h and get rid of the
>> > header file, after adding a Kconfig symbol.
>>
>> Some platforms mix and match inline definitions versus externs in this file.
>>
>> Maybe Ralf can comment on whether we should move to an "all or nothing" model?
>
> To clarify where I was getting to here: In a generic multiplatform kernel,
> you would probably want to always look at the dma-ranges properties here,
> at least if there are one or more platforms built into the kernel that
> don't just have a flat mapping that the current mach-generic header
> provides.

For the BMIPS case:

plat_map_dma_mem* and plat_dma_addr_to_phys are just performing
remapping, so dma-ranges would work.

plat_unmap_dma_mem is used to perform an extra BMIPS-specific
cacheflush operation.


Not sure about something like this - I guess it would work with 4
ranges as long as bits 63:39 of daddr are 0:

phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
{
    long nid;
#ifdef CONFIG_PHYS48_TO_HT40
    /* We extract 2bit node id (bit 44~47, only bit 44~45 used now) from
     * Loongson-3's 48bit address space and embed it into 40bit */
    nid = (daddr >> 37) & 0x3;
    daddr = ((nid << 37) ^ daddr) | (nid << 44);
#endif
    return daddr;
}

dma-octeon.c also has a few different cases to handle, but it looks
like they are range remappings selected based on the machine type;
that might still be suitable for DT.

The other tests in that file (coherency, per-device DMA masks) might
be better off as DT properties.
