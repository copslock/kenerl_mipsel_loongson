Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Aug 2014 09:12:50 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.13]:62561 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007354AbaH2HMsHYo4P convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Aug 2014 09:12:48 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue104) with ESMTP (Nemesis)
        id 0Mfpbg-1XkRW72jJM-00NApo; Fri, 29 Aug 2014 09:12:39 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Booting bcm47xx (bcma & stuff), sharing code with bcm53xx
Date:   Fri, 29 Aug 2014 09:12:37 +0200
Message-ID: <2928362.8a0siS8rnK@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <53FF9D9B.30106@hauke-m.de>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com> <2859425.94ptgpItD3@wuerfel> <53FF9D9B.30106@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V02:K0:+Gvwa5eu7JQoTEmN5879Qg5cReXr8PiK7g+obAaVKsW
 ZK3M/82ey9VVwyXwkIPznlCY5ANMg6niAl5ABc5ckPaGscFMyk
 G8woNgUA5dkkieEYDRkasTQfj1sh7PNbtz0GeTEt7MkavIvJ7U
 YRZ8gpAAA5cXmwLoqXM9rLtJ7Iypcttf9X3sx5CzzHDxZP61Bs
 OcUaApu9nkK/vhhgXxrqMHeThtkIB3klD14gajAiqweCIVRyy/
 I9Ce5HCc5m8AgQiGeoMZo1DokapJ80Ru1r7k54WxcY0U46byEK
 ppXmojH6RCyoWIh9z+zGJ/DL5A/7PCekc7WlSjaLb4ChaC0Eat
 YzeBK2ve2Kg/9tE2MZTM=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42317
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

On Thursday 28 August 2014 23:22:35 Hauke Mehrtens wrote:
> 
> I think we have to provide an own device tree for every board, like it
> is done for other arm boards. If we do so I do not see a problem to
> specify the nvram address space in device tree.  I do not think the arm
> guys do like some board files containing the gpio numbers of the leds
> and buttons found on the board.

Ok. The part I'm not sure about is how to best represent the nvram
in a way that matches the actual hardware.

If the two physical address ranges are just used for the purpose
of showing nvram, that would be fairly straightforward, and we
can jut put both of them in DT, mark them as 'status="disabled"'
by default and let the board specific file enable the one it needs.

However, if these registers really belong into the address range
that is owned by the flash controller device and that is behind
the bcma bus logic, things get a little tricky and we have to decide
whether we want to intentionally put a simplified (and incorrect)
description into the DT to make it easier to use, or to make
the description more correct at the expense of complicating the
code to detect it (thereby negating the intention of this hardware,
which is built to make it easier to boot).

> For the MIPS version of BCM47xx we are able to automatically detect
> mostly everything, just for the gpio configuration we try to guess the
> board name based on nvram content and then configure the gpios.

We could still do something like this with a boot wrapper that fills
the fields in the dtb from nvram data. We are pretty flexible in
the kernel when it comes to how that dtb is created, and there is no
requirement to have each board's dts file be part of the kernel sources
if there is some pre-kernel environment (firmware, boot loader,
wrapper, ...) that can generate it for us.

> The ARM BCM47xx contains a standard ARM with GIC and other standard arm
> things just the flash, Ethernet, PCIe, USB controller and their
> interconnection are Braodcom specific.

Ok.

> My plan was to provide a nvram and sprom driver which registers as a
> normal platform device and supports device tree, like the one I posted
> and it would also be possible to call the function with the address of
> the flash directly, this function would be used for MIPS, this way we
> can share the code and do not have to change the mips stuff so much.

Yes, and none of that should interfere with the cleanup plans for MIPS
that Rafał talked about, right?

> For ARM BCM47xx we do not need bcma at all to boot the device, so it
> should also work when bcma is build as a module, this is different to
> MIPS. The ARM BCM47xx code currently in mainline Linux boots for me into
> user space with an initramfs, it just misses many parts like Ethernet,
> flash PCIe, ...

Ah, good. So to confirm: all the essential devices including irqchip,
clocksource, uart and nvram can be accessed without using the bcma bus,
right?
Does that mean they are actually connected to another bus, or are they
actually bcma bus devices for which you provide an additional probe
method using dt/platform_device?

> The address of the console is already hard coded in device tree. It
> would also be possible to automatically detect their address based on
> some description in the AIX bus (bcma), but I think hard coding the
> address in device tree is easier.

Right. Importantly for the console, there are patches to allow a very
early output by having some minimal dt parsing done before start
accessing any other hardware. I think this is valuable even if it
means we compromise on the accurate DT description. We do the same
thing for consoles on other buses (ISAPnP, PCI, of_platform, ...)
and a lot of serial drivers have a way to retroactively connect that
early console setup to the actual device once it is probed normally.

	Arnd
