Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 13:02:43 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.24]:61777 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007191AbaH1LClmrkrZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 13:02:41 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue105) with ESMTP (Nemesis)
        id 0Lql1O-1Wiy5q2hrW-00eJRt; Thu, 28 Aug 2014 13:02:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: Booting bcm47xx (bcma & stuff), sharing code with bcm53xx
Date:   Thu, 28 Aug 2014 13:02:30 +0200
Message-ID: <3921668.sgOLRYjGUr@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CACna6rwO4qOR_pg-aOt87cdb=HfgdeOeMV_KGvsUyR7kDjnKWg@mail.gmail.com>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com> <3222444.6Ji0x5QqTP@wuerfel> <CACna6rwO4qOR_pg-aOt87cdb=HfgdeOeMV_KGvsUyR7kDjnKWg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V02:K0:j4uOj9gP9iKtS8jUlk+ztQ1KLrMR8pvZP49L6bxSrSD
 8oTQEjtTfWhhQDtOPzq9EnXNEyqxcoR8njlnqROqkednWiXHGX
 tGzxwjbs6RmuWXSQImag0XlZ6gh+am/2z08N/hrnQw2zfL3E0i
 aC0hldKfvFwWJYKjRxIUsQHCQ8XnFrMy+ZFvavCCo0DEh3hAi6
 Itw1Sm2sOnB7juC3RI8WElHmrIU4qtMRsIDP00zQ8BsS5z8PXn
 i667yr5U0F4j8xW1Szx5zt/EnXsgfj1ELqRmNdPzv+Ltj1Axsu
 ewE5hpryKl8aja+krFJ9scOOKtqp3N1P5Y5v3YCmwiA3Dk+xrw
 YOfBMqPemOW+g4tUwrxI=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thursday 28 August 2014 12:47:29 Rafał Miłecki wrote:
> On 28 August 2014 12:13, Arnd Bergmann <arnd@arndb.de> wrote:
> >> 1) prom_init / plat_mem_setup
> >> These two functions are called in pretty much the same phase from the
> >> setup_arch (arch/mips/kernel/setup.c).
> >> Task: detect & register memory
> >> Requires: CPU type, maybe Broadcom chip ID (highmem support)
> >> Available: CPU type
> >> Not available: kmalloc, device_add (kobject)
> >>
> >> 2) arch_init_irq
> >> Called from the arch specific init_IRQ (arch/mips/kernel/irq.c)
> >> Task: setup bcma's MIPS core
> >> Requires: bcma bus MIPS core
> >> Available: kmalloc
> >> Not available: device_add (kobject)
> >>
> >> 3) plat_time_init
> >> Called from the arch specific time_init (arch/mips/kernel/time.c)
> >> Task: set frequency
> >> Requires: bcma bus ChipCommon core, nvram
> >> Available: kmalloc
> >> Not available: device_add (kobject)
> >
> > My impression is that all the information that you need in these early
> > three steps is stuff that is already meant to be part of DT.
> > This isn't surprising, because the bcm47xx serves a similar purpose
> > to DT, it's just more specialized.
> >
> > This duplication is a bit unfortunate, but it seems that just using
> > the respective information from DT would be easier here.
> >
> > Is any of the information you need early dynamic? It sounds that
> > for a given SoC, it should never change and can just be statically
> > encoded in DT.
> 
> I'm not sure which info you exactly are talking about. I believe one
> SoC model always use the same CPU, ChipCommon, embedded wireless and
> PCIe + USB controllers. However amount of RAM, type of flash (serial
> vs. NAND), size of flash, booting method, NVRAM location, etc. all
> depend on vendor's choice. I think CPU speed could also depend on
> vendor choice.

But those would also be present in DT on ARM, right?

> >> 4) At some point we need to register bcma devices, device_initcall can
> >> be used for that
> >>
> >> As you can see, we need access to the NVRAM quite early (step 3,
> >> plat_time_init, or even earlier), but device_add (platform
> >> devices/drivers) is not available then yet. So I'm afraid we won't be
> >> able to use this common way to write NVRAM driver.
> >>
> >>
> >> So there I want to present my plan for the NVRAM improvements. If you
> >> don't agree with any part of it, or you can see any better solution,
> >> please speak up!
> >>
> >> 1) I won't make nvram.c a platform driver. Instead I would like to
> >> make it less bcm47xx specific. I don't want to touch bcm47xx_bus in
> >> this file. Instead I want to add a generic function that will accept
> >> address and size of memory where NVRAM should be found. Then I'd like
> >> to move this file out of "mips" arch (drivers/misc/?
> >> drivers/bcma/nvram/?) and allow using it for bcm53xx.
> >
> > In general, I'd try to avoid adding any platform specific code on ARM
> > when it needs to run as something other than a device driver.
> > Moving the code out of arch/mips and making it more generic definitely
> > sounds good to me, but I'd prefer to have an actual platform_driver
> > for it.
> 
> Sure, I didn't want to add NVRAM driver into arch/arm/ :)

What I meant is that I'd prefer to not even call a probe function
for this driver from arch/arm. I may have misunderstood what you meant
though.

> Can you see any solution for making NVRAM support a standard platform
> driver on MIPS and ARM? As I said, on MIPS we need access to the NVRAM
> really early, before platform devices/drivers can operate.

I think it would make sense to have a common driver that has both
an 'early' init part used by MIPS and a regular init part used by
ARM and potentially also on MIPS if we want. Most of the code can
still be shared.

> >> 3) Above change (point 2) would require some small change in bcma. We
> >> would need 2-stages init: detecting (with kmalloc!) bus cores,
> >> registering cores. This is required, because we can't register cores
> >> too early, device_add (and the underlying kobject) would oops/WARN in
> >> kobject_get.
> >
> > Right. Could you do the bcma scan much later, at the time when
> > device_add works as well? Traditionally PCI has been a problem
> > since it had to be enabled really early, but that restriction
> > should be gone now, and we can actually probe it from a loadable
> > module.
> 
> Take a look at "arch_init_irq" I described above. It needs access to
> the MIPS core (bcma bus contains many cores). To get access to this
> core (to know it exists and to get it mapped), I need to scan the bus.

I see. Still that would fit into the model of only using the
early probe on MIPS, but getting that information out of DT
on ARM, right? I would also expect the ARM version to use a
regular GIC only instead of the bcma irqchip, but I haven't
looked at that.

> > On a global level, there is another choice, which is to do something
> > similar to the 'pxa-impedence-matcher' and the 'sunxi-babelfish':
> > These are two projects that implement a last-stage boot loader that
> > runs before the kernel and translates a platform-specific boot format
> > into standard DTB format. We could do the same for bcm53xx and
> > translate any nvram strings we know about into properties of device
> > nodes we already have, and copy all remaining strings into a
> > properties of the /chosen node. That way, we don't even need any
> > nvram driver for ARM, except a trivial one that provides raw
> > write access to user space for updating it.
> 
> I think on bcm53xx early access to the NVRAM is less important, so
> this may be not such a big problem at all.

Ok.

	Arnd
