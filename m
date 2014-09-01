Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Sep 2014 16:57:48 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.24]:57612 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007822AbaIAO5mOH0JT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Sep 2014 16:57:42 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue105) with ESMTP (Nemesis)
        id 0MXGy5-1XsZ1m1mqb-00WIES; Mon, 01 Sep 2014 16:57:19 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Booting bcm47xx (bcma & stuff), sharing code with bcm53xx
Date:   Mon, 01 Sep 2014 16:57:18 +0200
Message-ID: <4072992.6HB7sP7z87@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CACna6rwMovK133ZoFYsLcsnH39umU7=UAoyG6jmgM8ZVq0AYRA@mail.gmail.com>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com> <CACna6rwmNtS1JSi=VHXWHu6mOM72Y8sBrr5EqCRbpYUHFrMnCg@mail.gmail.com> <CACna6rwMovK133ZoFYsLcsnH39umU7=UAoyG6jmgM8ZVq0AYRA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V02:K0:Os0FNj7Vmb0ORrMn4TigXt4BBE28rkAUfECDrviMWVl
 9t6sjSEuyYa7LRJ3MrZhfl6tTOoGpP+BkJ7DHClvkgyMtqixy4
 AktNWVUTvM3GLZSe5Ln2nCNLz8FCH4WX1d3HgN17jJIpuZN8/H
 z/MKbTexqX2Dx+D9gLASSMchsJyQkf18tLZyK3vAnYr/nctbPS
 g8BbHbwthzobBDItoq7RSyHlOZV0QZJOBBNA3/t10y3C8WbUM7
 UKshauG43EUGUFsA7tX6UDrS+z7/VXkNPjn0OX5B7cVKOsqjdx
 svAreGneMt6ghW6SSU192rsYSXkCJx7agfTUQhq8CqBqMzYnxM
 4KvoCeR2Bt3S5ZlNL15g=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42360
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

On Monday 01 September 2014 09:48:48 Rafał Miłecki wrote:
> On 31 August 2014 11:20, Rafał Miłecki <zajec5@gmail.com> wrote:
> > On 29 August 2014 22:04, Arnd Bergmann <arnd@arndb.de> wrote:
> >> You mentioned that the 'boot_device' variable in your code snippet
> >> comes from a hardware register that can be accessed easily, right?
> >> A possible way to handle it would then be to have two DT entries
> >> like
> >>
> >>         nvram@1c000000 {
> >>                 compatible = "bcm,bcm4710-nvram";
> >>                 reg = <0x1c000000 0x1000000>;
> >>                 bcm,boot-device = BCMA_BOOT_DEV_NAND;
> >>         };
> >>
> >>         nvram@1c000000 {
> >>                 compatible = "bcm,bcm4710-nvram";
> >>                 reg = <0x1e000000 0x1000000>;
> >>                 bcm,boot-device = BCMA_BOOT_DEV_SERIAL;
> >>         };
> >
> > This sounds like a nice consensus for me! Actually it seems to be
> > similar to what we already do for other hardware parts.
> >
> > E.g. in bcm4708.dtsi Hauke put registers location of 4 Ethernet cores
> > (gmac@0, gmac@1, gmac@2, gmac@3). I believe this board is ready for 4
> > Ethernet cores so DT matches hardware capabilities. Then most vendors
> > use/activate only one (maybe up to 2?) Ethernet cores. It's up to the
> > driver to detect if core is activated/used.

Actually we normally list in the board-specific dts file which ones
are available on a particular machine.

> > AFAIU having two flash mappings (as suggested above) would follow this
> > logic. It would match hardware capabilities. And then it would be up
> > to driver to detect which one mapping is really in use for this
> > particular board.
> >
> > Does it make sense?

I mainly showed the example above for how it could be done, not saying
it's my preferred way. I think both Hauke and I said it would be betted
to do it explicitly in the dts file using the 'status="disabled"' property
instead of the 'brcm,boot-device = BCMA_BOOT_DEV_NAND' property.

For me this is mainly a question of whether we need a per-board
dts file or not. Hauke said he thinks we do need it, and (without
knowing anything about the platform), I would assume the same. If
we did not need that, and the nvram location was in fact the only
think we need to know, then the autoconfiguration based on the
brcm,boot-device property would become much more attractive.

> I've just realized something. When Broadcom's code reads NVRAM content
> it uses "hndnand_checkbadb" to skip bad blocks. It seems NVRAM doesn't
> lay in 100% reliable flash sectors.
> 
> Above function comes from shared/ which (the directory) provides tons
> of low level stuff without using any kernel API. OFC it won't be
> acceptable for us to implement low level NAND stuff in the nvram
> driver (this would mean duplicating NAND driver code). It seems we
> won't be able to use NAND flash mapping to the memory (this magic
> 0x1c000000) at all...

Hmm

> So I think we'll need to change our vision of flash access in
> bcm74xx_nvram driver. I guess we will have to:
> 1) Register NAND core early
> 2) Initialize NAND driver
> 3) Use mtd/nand API in bcm47xx_nvram

This would mean it's available really late. Is that a problem?

A possible solution for this would be to use the boot wrapper
I mentioned earlier, to put all the data from nvram into DT
properties before the kernel gets started.

	Arnd
