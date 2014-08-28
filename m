Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 12:13:28 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.13]:54704 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006987AbaH1KN1Q35zk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 12:13:27 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue104) with ESMTP (Nemesis)
        id 0LsQye-1WLOll2ShU-01244v; Thu, 28 Aug 2014 12:13:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: Booting bcm47xx (bcma & stuff), sharing code with bcm53xx
Date:   Thu, 28 Aug 2014 12:13:19 +0200
Message-ID: <3222444.6Ji0x5QqTP@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V02:K0:NE0M0Yoxb4wKcG2W5CwARmqzJbvLZi+vCtWEiaYMT51
 iAMga5WEQ25GazMN3vnyWUOVhR3D0WntJRMmNbiiCmVOJ8CEBe
 6eZ63z14IDTpTKY9+LeTYid9r9W9GePz2DbYEAWM92F0a099Ku
 rMRcykkQYrh8kSrsqJWjrf1S6w9YiL0JxhaQYv9IZz58caKeBK
 FGYZiMUTQ+Gjebu8R6LbEInZQJgf7Udqzustbfc/UQ5vpNAoef
 /Gt7XQBMVrxsf23WmuhwhqzyxkLG+ZB4LLvSusycwlhF/GO0l9
 tw7XZnwKZDtCYBjahbsi8Svhm6GCBpKNr4FojJAu6CNPyLAKeW
 s2nQTXWEeksM9uShxq84=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42303
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

On Tuesday 26 August 2014 18:42:51 Rafał Miłecki wrote:
> 
> We're working on another Broadcom platform, SoC with an ARM CPU,
> platform called bcm53xx. It shares many things with the older (MIPS
> based) bcm47xx, so we need to figure out how to modify some of the
> drivers.
> 
> Hauke recently proposed sharing code for NVRAM support as a separated
> driver. In his RFC patch it was added as a new platform driver. I
> liked this idea (I'd simply prefer to modify existing code instead of
> duplicating it), so I played with it a bit today.
> 
> My plan was to modify bcm47xx code to make nvram.c a separated driver
> and update bcm47xx/bcma to use it. Well, it didn't work out. The
> problem is that we need access to the NVRAM pretty early. Please take
> a look at my description of bcm47xx booting process (it's simply a
> summary of start_kernel and bcm47xx code):
> 
> 1) prom_init / plat_mem_setup
> These two functions are called in pretty much the same phase from the
> setup_arch (arch/mips/kernel/setup.c).
> Task: detect & register memory
> Requires: CPU type, maybe Broadcom chip ID (highmem support)
> Available: CPU type
> Not available: kmalloc, device_add (kobject)
> 
> 2) arch_init_irq
> Called from the arch specific init_IRQ (arch/mips/kernel/irq.c)
> Task: setup bcma's MIPS core
> Requires: bcma bus MIPS core
> Available: kmalloc
> Not available: device_add (kobject)
> 
> 3) plat_time_init
> Called from the arch specific time_init (arch/mips/kernel/time.c)
> Task: set frequency
> Requires: bcma bus ChipCommon core, nvram
> Available: kmalloc
> Not available: device_add (kobject)

My impression is that all the information that you need in these early
three steps is stuff that is already meant to be part of DT.
This isn't surprising, because the bcm47xx serves a similar purpose
to DT, it's just more specialized.

This duplication is a bit unfortunate, but it seems that just using
the respective information from DT would be easier here.

Is any of the information you need early dynamic? It sounds that
for a given SoC, it should never change and can just be statically
encoded in DT.

> 4) At some point we need to register bcma devices, device_initcall can
> be used for that
> 
> As you can see, we need access to the NVRAM quite early (step 3,
> plat_time_init, or even earlier), but device_add (platform
> devices/drivers) is not available then yet. So I'm afraid we won't be
> able to use this common way to write NVRAM driver.
> 
> 
> So there I want to present my plan for the NVRAM improvements. If you
> don't agree with any part of it, or you can see any better solution,
> please speak up!
> 
> 1) I won't make nvram.c a platform driver. Instead I would like to
> make it less bcm47xx specific. I don't want to touch bcm47xx_bus in
> this file. Instead I want to add a generic function that will accept
> address and size of memory where NVRAM should be found. Then I'd like
> to move this file out of "mips" arch (drivers/misc/?
> drivers/bcma/nvram/?) and allow using it for bcm53xx.

In general, I'd try to avoid adding any platform specific code on ARM
when it needs to run as something other than a device driver.
Moving the code out of arch/mips and making it more generic definitely
sounds good to me, but I'd prefer to have an actual platform_driver
for it.

> 2) I was also thinking about cleaning bcm47xx init. Right now we do a
> lot of hacks in plat_mem_setup & bcma to register the bus and scan its
> cores. It's so early (before mm_init) that we can't alloc memory!
> Doing all this stuff slightly later (e.g. arch_init_irq) would allow
> us to simply use "kmalloc" and drop all current hacks in bcma.

This sounds good

> 3) Above change (point 2) would require some small change in bcma. We
> would need 2-stages init: detecting (with kmalloc!) bus cores,
> registering cores. This is required, because we can't register cores
> too early, device_add (and the underlying kobject) would oops/WARN in
> kobject_get.

Right. Could you do the bcma scan much later, at the time when
device_add works as well? Traditionally PCI has been a problem
since it had to be enabled really early, but that restriction
should be gone now, and we can actually probe it from a loadable
module.

A common exception is the console driver, and we have a number
of other cases where we do a minimal bus scan just to find the
serial console at very early boot, but then probe all other
devices from a regular initcall.

On a global level, there is another choice, which is to do something
similar to the 'pxa-impedence-matcher' and the 'sunxi-babelfish':
These are two projects that implement a last-stage boot loader that
runs before the kernel and translates a platform-specific boot format
into standard DTB format. We could do the same for bcm53xx and
translate any nvram strings we know about into properties of device
nodes we already have, and copy all remaining strings into a
properties of the /chosen node. That way, we don't even need any
nvram driver for ARM, except a trivial one that provides raw
write access to user space for updating it.

	Arnd
