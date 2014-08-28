Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 13:56:38 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.13]:55642 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007191AbaH1L4hqhWby convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 13:56:37 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue105) with ESMTP (Nemesis)
        id 0Lcg0l-1WdEE53gTH-00k5xj; Thu, 28 Aug 2014 13:56:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: Booting bcm47xx (bcma & stuff), sharing code with bcm53xx
Date:   Thu, 28 Aug 2014 13:56:27 +0200
Message-ID: <2859425.94ptgpItD3@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CACna6rwnz0TGZ8QgW39o4MPfXTp1a1h8naDJqEGVV4UqtkgaWw@mail.gmail.com>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com> <3921668.sgOLRYjGUr@wuerfel> <CACna6rwnz0TGZ8QgW39o4MPfXTp1a1h8naDJqEGVV4UqtkgaWw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V02:K0:58QPAUBy135kfQ+tsK3R/flmShniuIxYR6EJ+atB0/l
 gmcsrwMWMCYpYl52N3obz01c8I7wlo01kv+IgLwa81+/TDZw3N
 CtsgHf8R+VdapWmSpJjuadzldP8u1Rl4P1vNslZ+myqCojWsnT
 9Gt1bUisbXGI4xqYxWhs7HmVoLaNZa2yhX9aOtkECB1o2iPJpg
 OsNa3p4157ck6byE0uOeWqY9xV21VkzJdSK2pd0GEU3vy2dFLh
 iADyBsjCrkEA6FSpOhcMPZ3WgtJ/ahjkdOpmbVFWtW4gbT+5Fs
 YnZlxQJlH6bm58HI0AAzOzYa2Up2d3+oTtsQ0t26qZRByKhZe3
 /R6V+hZBQKPvW7kZVKkw=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42307
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

On Thursday 28 August 2014 13:39:55 Rafał Miłecki wrote:
> On 28 August 2014 13:02, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 28 August 2014 12:47:29 Rafał Miłecki wrote:
> >> On 28 August 2014 12:13, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > My impression is that all the information that you need in these early
> >> > three steps is stuff that is already meant to be part of DT.
> >> > This isn't surprising, because the bcm47xx serves a similar purpose
> >> > to DT, it's just more specialized.
> >> >
> >> > This duplication is a bit unfortunate, but it seems that just using
> >> > the respective information from DT would be easier here.
> >> >
> >> > Is any of the information you need early dynamic? It sounds that
> >> > for a given SoC, it should never change and can just be statically
> >> > encoded in DT.
> >>
> >> I'm not sure which info you exactly are talking about. I believe one
> >> SoC model always use the same CPU, ChipCommon, embedded wireless and
> >> PCIe + USB controllers. However amount of RAM, type of flash (serial
> >> vs. NAND), size of flash, booting method, NVRAM location, etc. all
> >> depend on vendor's choice. I think CPU speed could also depend on
> >> vendor choice.
> >
> > But those would also be present in DT on ARM, right?
> 
> Well, that depends. Hauke was planning to put info about flash in DT.
> Me on the other hand suggested reading info about flash from the
> board. See my reply:
> https://www.mail-archive.com/devicetree@vger.kernel.org/msg39365.html
> 
> My plan was to use patch like
> [PATCH] bcma: get & store info about flash type SoC booted from
> http://www.spinics.net/lists/linux-wireless/msg126163.html
> (it would work on both: MIPS and ARM)
> and then:
> 
> switch (boot_device) {
> case BCMA_BOOT_DEV_NAND:
>     nvram_address = 0x1000dead;
>     break;
> case BCMA_BOOT_DEV_SERIAL:
>     nvram_address = 0x1000c0de;
>     break;
> }
> 

I don't understand. Why does the nvram address depend on the boot
device?

> >> Can you see any solution for making NVRAM support a standard platform
> >> driver on MIPS and ARM? As I said, on MIPS we need access to the NVRAM
> >> really early, before platform devices/drivers can operate.
> >
> > I think it would make sense to have a common driver that has both
> > an 'early' init part used by MIPS and a regular init part used by
> > ARM and potentially also on MIPS if we want. Most of the code can
> > still be shared.
> 
> OK, now it's clear what you meant.
> The thing is that we may want to call probe function from
> drivers/bcma/main.c. I think we never meant to call it directly from
> arch code. This code in drivers/bcma/main.c is used on both: MIPS and
> ARM. So I wonder if there is much sense in doing it like
> #ifdev MIPS
> bcm47xx_nvram_init(nvram_address);
> #endif
> #ifdef ARM
> nvram_device.resource[0].start = nvram_address;
> platform_device_register(nvram_device);
> #endif
> 
> What do you think about this?

I definitely don't want to see any manual platform_device_register()
calls on ARM, any device should be either a platform_device probed
from DT, or a bcma_device that comes from the bcma bus.

I suspect I'm still missing part of the story here. How is the
nvram chip actually connected?

	Arnd
