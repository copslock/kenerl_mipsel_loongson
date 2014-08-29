Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Aug 2014 22:04:51 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.10]:63092 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007451AbaH2UEtyP4rI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Aug 2014 22:04:49 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue104) with ESMTP (Nemesis)
        id 0M1XmT-1YGVwB0OUb-00tVEH; Fri, 29 Aug 2014 22:04:42 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Booting bcm47xx (bcma & stuff), sharing code with bcm53xx
Date:   Fri, 29 Aug 2014 22:04:39 +0200
Message-ID: <5882203.GXbhhcHqjK@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CACna6rzaXHww2UXoP4Fi-zA3uNve4NQ48DeChF8zoBS-_-mtyw@mail.gmail.com>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com> <53FF9D9B.30106@hauke-m.de> <CACna6rzaXHww2UXoP4Fi-zA3uNve4NQ48DeChF8zoBS-_-mtyw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V02:K0:E79eRdCIBFbC8n/Bp3ewQTyGGkxuFLfKJV/sGE7rBKz
 7QH5k3KaeCQIO9mL6sFZL8UJjHZgIq8FyYeIitEyOlKYHw2RPm
 JCP3b0J2M/1t2215SFgQfV72DlMcvr3v/QLF7NaWBrUkgIRUQT
 Pt2lDPhL0dlznfdnfVopRW78mB2yZUIXNNIPvqaKjUVAWByjMY
 M1i0xSQ2QUrMM3MQPIJR86sLOspFO4kClgkn64Zxi0/xWeynSR
 NPFjezzMuevWV8uE9x7mMHQbF8G+QGKXW5IXoLt25Y7zrbLNG3
 hIXMc9WCnN+UIl77uWwfaRdo/VV60dRdNIKj2lJcmWVOlIynh2
 1X9aJiNg5VN+EUE3JU9A=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42322
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

On Friday 29 August 2014 17:21:18 Rafał Miłecki wrote:
> On 28 August 2014 23:22, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> > On 08/28/2014 01:56 PM, Arnd Bergmann wrote:
> >> On Thursday 28 August 2014 13:39:55 Rafał Miłecki wrote:
> >>> Well, that depends. Hauke was planning to put info about flash in DT.
> >>>> I think it would make sense to have a common driver that has both
> >>>> an 'early' init part used by MIPS and a regular init part used by
> >>>> ARM and potentially also on MIPS if we want. Most of the code can
> >>>> still be shared.
> >>>
> >>> OK, now it's clear what you meant.
> >>> The thing is that we may want to call probe function from
> >>> drivers/bcma/main.c. I think we never meant to call it directly from
> >>> arch code. This code in drivers/bcma/main.c is used on both: MIPS and
> >>> ARM. So I wonder if there is much sense in doing it like
> >>> #ifdev MIPS
> >>> bcm47xx_nvram_init(nvram_address);
> >>> #endif
> >>> #ifdef ARM
> >>> nvram_device.resource[0].start = nvram_address;
> >>> platform_device_register(nvram_device);
> >>> #endif
> >>>
> >>> What do you think about this?
> >>
> >> I definitely don't want to see any manual platform_device_register()
> >> calls on ARM, any device should be either a platform_device probed
> >> from DT, or a bcma_device that comes from the bcma bus.
> >>
> >> I suspect I'm still missing part of the story here. How is the
> >> nvram chip actually connected?
> >
> > I think we have to provide an own device tree for every board, like it
> > is done for other arm boards. If we do so I do not see a problem to
> > specify the nvram address space in device tree.
> 
> Alright, I think we should try to answer one main question at this
> point: how much data we want to put in DTS? It's still not clear to
> me.
> 
> What about this flash memory mapping? You added this in your RFC:
> reg = <0x1c000000 0x01000000>;
> 
> As I described, the first part (address 0x1c000000) could be extracted
> on runtime. For that you need my patch:
> [PATCH] bcma: get & store info about flash type SoC booted from
> http://www.spinics.net/lists/linux-wireless/msg126163.html
> 
> And then add some simple "swtich" like:
> switch (boot_device) {
> case BCMA_BOOT_DEV_NAND:
>     nvram_address = 0x1c000000;
>     break;
> case BCMA_BOOT_DEV_SERIAL:
>     nvram_address = 0x1e000000;
>     break;
> }

At the very least, those addresses should come from DT in some form.
We should never hardcode register locations in kernel code, since those
tend to change when a new hardware version comes out. Even if you are
sure that wouldn't happen with bcm53xx, it's still bad style and I
want to avoid having other developers copy code like that into a new
platform or driver.

> So... should we handle it on runtime? Or do we really want this in DTS?
> I was thinking about doing this on runtime. This would limit amount of
> DTS entries and this is what makes more sense to me. The same way
> don't hardcode many other hardware details. For example we don't store
> flash size, block size, erase size in DTS. We simply use JEDEC and
> mtd's spi-nor framework database.

I think the main difference is that for the example of the flash
chip, we can find out that information by looking at the device itself:
The DT describes how to find the device and from there we can do
proper hardware probing.

For the case of the nvram, I don't see how that would be done, since
the presence of the device itself is something your code above tries
to derive from something that from an unrelated setting, so I'd rather
see it done explicit in DT.

You mentioned that the 'boot_device' variable in your code snippet
comes from a hardware register that can be accessed easily, right?
A possible way to handle it would then be to have two DT entries
like

	nvram@1c000000 {
		compatible = "bcm,bcm4710-nvram";
		reg = <0x1c000000 0x1000000>;
		bcm,boot-device = BCMA_BOOT_DEV_NAND;
	};	

	nvram@1c000000 {
		compatible = "bcm,bcm4710-nvram";
		reg = <0x1e000000 0x1000000>;
		bcm,boot-device = BCMA_BOOT_DEV_SERIAL;
	};

We would then have two platform device instances and get the
driver's probe function to reject any device whose bcm,boot-device
property doesn't match the contents of the register.

That would correctly describe the hardware while still allowing
automatic probing of the device, but I don't see a value in
the extra complexity compared to just marking one of the two
as status="disabled".

	Arnd
