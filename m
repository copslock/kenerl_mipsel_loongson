Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 18:50:23 +0100 (CET)
Received: from utopia.booyaka.com ([74.50.51.50]:35579 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007063AbaKYRuRsyEM7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 18:50:17 +0100
Received: (qmail 20038 invoked by uid 1019); 25 Nov 2014 17:50:11 -0000
Date:   Tue, 25 Nov 2014 17:50:11 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>
cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kumar Gala <galak@codeaurora.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sandeep Nair <sandeep_n@ti.com>, linux-soc@vger.kernel.org
Subject: Re: [PATCH V3] MIPS: BCM47XX: Move NVRAM driver to the
 drivers/soc/
In-Reply-To: <CACna6rxwwn5_e86278TAiOFZ3sVu_Exfm2x94vN2KiTJfsFujQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1411251407290.16047@utopia.booyaka.com>
References: <1416736241-12723-1-git-send-email-zajec5@gmail.com> <1416778509-31502-1-git-send-email-zajec5@gmail.com> <alpine.DEB.2.02.1411240910100.16047@utopia.booyaka.com> <CACna6rxwwn5_e86278TAiOFZ3sVu_Exfm2x94vN2KiTJfsFujQ@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-912676024-1416924486=:16047"
Content-ID: <alpine.DEB.2.02.1411251408250.16047@utopia.booyaka.com>
Return-Path: <paul@pwsan.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@pwsan.com
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-912676024-1416924486=:16047
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.02.1411251408251.16047@utopia.booyaka.com>

Hi Rafa=B3,

On Mon, 24 Nov 2014, Rafa=B3 Mi=B3ecki wrote:

> On 24 November 2014 at 11:02, Paul Walmsley <paul@pwsan.com> wrote:
> > Hi Rafa=B3.
> >
> > On Sun, 23 Nov 2014, Rafa=B3 Mi=B3ecki wrote:
> >
> >> After Broadcom switched from MIPS to ARM for their home routers we nee=
d
> >> to have NVRAM driver in some common place (not arch/mips/).
> >
> > So this is a driver for a chunk of NVRAM that's embedded in the SoC,
> > hanging off an I/O bus?
> >
> > Is this actually some kind of RAM, or is it flash, or something else?
>=20
> I think you missed my description (help section) in Kconfig file :)

That's correct.  I only looked at the patch description in the E-mail, and=
=20
the code in arch/mips/bcm47xx/nvram.c.

> As it says, NVRAM is a special partition on flash.

OK, thanks for the clarification.

> >> We were thinking about putting it in bus directory, however there are
> >> two possible buses for MIPS: drivers/ssb/ and drivers/bcma/. So this
> >> won't fit there neither.
> >> This is why I would like to move this driver to the drivers/soc/
> >
> > Can't speak for anyone else, but I personally consider drivers/soc to b=
e
> > primarily intended for so-called "integration" IP blocks.  Those are us=
ed
> > for SoC control functions.
> >
> > So low-level NVRAM drivers would probably go somewhere else.  Here are
> > some likely possibilities, where it can live with others of its kind
> > (assuming it is something similar to RAM):
> >
> > 1. the PC "CMOS memory" NVRAM driver appears to be under drivers/char, =
as
> > drivers/char/nvram.c.
> >
> > 2. there's a generic SRAM driver, drivers/misc/sram.c
> >
> > 3. while people have put some of the eFuse code under drivers/soc, in m=
y
> > opinion, the low-level fuse access code should really go under
> > drivers/misc/fuse.
>=20
> I don't think NVRAM can be treated as a standard char device. Also, in
> my V1 I tried moving it to the drivers/misc/, but then drivers/soc/
> was suggested as a better place, see Arnd's reply:
> http://www.linux-mips.org/archives/linux-mips/2014-11/msg00238.html

Yeah.  It depends on who is going to merge the patch.  If you can persuade=
=20
someone else to merge it in drivers/soc, then it doesn't really matter=20
what I think.

To my mind, drivers/soc was intended to fill a very narrow and specific=20
need: for low-level, hardware IP block drivers for so-called 'integration'=
=20
IP blocks.  These IP blocks generally control some combination of clocks,=
=20
external muxing (pin mux), internal muxing, reset, IO cells/bricks, debug=
=20
observability, etc., and tend to be very specific to particular SoC=20
families.  While it's certainly understandable that folks would=20
like a place to move arbitrary code out of arch/*, drivers/soc was not=20
intended to be that.

> > Looking at arch/mips/bcm47xx/nvram.c: if the low-level NVRAM probe code
> > were moved elsewhere, the higher-level NVRAM "interpretation" functions
> > still remain: bcm47xx_nvram_getenv() and bcm47xx_nvram_gpio_pin().  Tho=
se
> > seem to be intended to parse device configuration data, yes?  And this
> > device configuration data is organized this way by platform software
> > convention -- there's no hardware requirement to store data this way in
> > the NVRAM, right?
>=20
> This bcm47xx_nvram driver has two ways of reading NVRAM content:
> 1) Using a standard MTD API to access "nvram" partition. In such case
> flash driver is a low-level thing if you call it so.

OK, so just to confirm, you are referring to these drivers:

drivers/mtd/nand/bcm47xxnflash/*
drivers/mtd/devices/bcm47xxsflash.c=20
drivers/ssb/driver_mipscore.c (for pflash)
drivers/bcma/driver_mips.c (for pflash)

? =20

Just out of curiosity, the nvram.c code seems to contain some code to work=
=20
around cases where the flash size is larger than the MMIO aperture, and to=
=20
truncate the copy.  Is there some way to program the flash controller to=20
point the aperture at a different section of the flash?

> 2) Using memory-mapped flash access window. In such case there isn't=20
> any extra low-level driver.

Could you point me at the software entity that configures the=20
memory-mapped flash access window and programs the flash controller to use=
=20
one of {p,n,s}flash?  Or is that done by some code external to the kernel,=
=20
like the bootloader?

> The "nvram" partition is required by the bootloader (CFE). It contains
> some important info like CPU clock, RAM configuration, switch ports
> layout. Then it's used by system drivers (like Ethernet driver bgmac)
> to get info about some particular hardware parts (like PHY address,
> MAC, etc.).

So it's not used by the on-chip boot-ROM?  Sounds like it's just software=
=20
convention, then?  In other words, if one used a different bootloader,=20
like u-boot, and passed a DT or something like that to the kernel, this=20
wouldn't be needed.  The presence and format of this flash is part of a=20
specific hardware/software platform, external to the SoC hardware itself,=
=20
that Broadcom suggests.  It's analogous to ARM ATAGS -=20
arch/arm/kernel/atags_parse.c.  Does all this match your understanding? =20
(I'm not advocating using a different bootloader or device data format - I=
=20
think it's important to preserve compatibility with CPE - I am just trying=
=20
to understand how this area of flash is used.)

> > So if the answer to the above two questions is "yes," meaning that this
> > NVRAM is used to store device probing data by software convention, then=
 it
> > would seem to me that proposing some place like
> > drivers/devicedata/bcm47xx-nvram is a better bet (where "bcm47xx-nvram"=
 is
> > just some kind of opaque token).  Looking at those two functions, it
> > doesn't seem like there's really anything MIPS or Broadcom or NVRAM or
> > even SoC-specific about key-value pair parsing and GPIO device data?  O=
r
> > am I missing something?
> >
> > Actually, considering that bcm47xx_nvram_gpio_pin() isn't even used, ca=
n
> > we just drop it and save the hassle?  :-)
>=20
> We need this function to easily find GPIO responsible for "something".
> For example during switch initialization we need to reset it toggling
> GPIO. NVRAM contains info which GPIO should be toggled, e.g.:
> gpio4=3Drobo_reset
> (robo means roboswitch)
>=20
> bcm47xx_nvram_gpio_pin is needed by out-of-tree "b53" driver that some
> tried to push upstream, but was rejected because of API.
>=20
> I'll also send a patch to USB host driver soon that will require
> bcm47xx_nvram_gpio_pin.

OK thanks for the context.

It sounds to me like this code is a combination of three=20
pieces:

1. code that autoprobes the size of the "nvram" partition in the Broadcom=
=20
platform flash, by reading various locations in the MMIO flash aperture,=20
configured by some other system entity

2. code that shadow copies the device data from the MMIO flash aperture=20
into system RAM

3. code that parses the CPE-generated device data and returns it to other=
=20
drivers

Does that sound accurate?


- Paul
--843723315-912676024-1416924486=:16047--
