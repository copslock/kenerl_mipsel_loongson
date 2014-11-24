Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 11:02:33 +0100 (CET)
Received: from utopia.booyaka.com ([74.50.51.50]:39439 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006819AbaKXKCaivU72 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 11:02:30 +0100
Received: (qmail 9826 invoked by uid 1019); 24 Nov 2014 10:02:27 -0000
Date:   Mon, 24 Nov 2014 10:02:27 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kumar Gala <galak@codeaurora.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sandeep Nair <sandeep_n@ti.com>, linux-soc@vger.kernel.org
Subject: Re: [PATCH V3] MIPS: BCM47XX: Move NVRAM driver to the
 drivers/soc/
In-Reply-To: <1416778509-31502-1-git-send-email-zajec5@gmail.com>
Message-ID: <alpine.DEB.2.02.1411240910100.16047@utopia.booyaka.com>
References: <1416736241-12723-1-git-send-email-zajec5@gmail.com> <1416778509-31502-1-git-send-email-zajec5@gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1960090229-1416820257=:16047"
Content-ID: <alpine.DEB.2.02.1411240911020.16047@utopia.booyaka.com>
Return-Path: <paul@pwsan.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44365
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

--843723315-1960090229-1416820257=:16047
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.02.1411240911021.16047@utopia.booyaka.com>

Hi Rafa=B3.

On Sun, 23 Nov 2014, Rafa=B3 Mi=B3ecki wrote:

> After Broadcom switched from MIPS to ARM for their home routers we need
> to have NVRAM driver in some common place (not arch/mips/).

So this is a driver for a chunk of NVRAM that's embedded in the SoC,=20
hanging off an I/O bus?

Is this actually some kind of RAM, or is it flash, or something else?

> We were thinking about putting it in bus directory, however there are
> two possible buses for MIPS: drivers/ssb/ and drivers/bcma/. So this
> won't fit there neither.
> This is why I would like to move this driver to the drivers/soc/

Can't speak for anyone else, but I personally consider drivers/soc to be=20
primarily intended for so-called "integration" IP blocks.  Those are used=
=20
for SoC control functions.

So low-level NVRAM drivers would probably go somewhere else.  Here are=20
some likely possibilities, where it can live with others of its kind=20
(assuming it is something similar to RAM):

1. the PC "CMOS memory" NVRAM driver appears to be under drivers/char, as=
=20
drivers/char/nvram.c. =20

2. there's a generic SRAM driver, drivers/misc/sram.c

3. while people have put some of the eFuse code under drivers/soc, in my=20
opinion, the low-level fuse access code should really go under=20
drivers/misc/fuse.

=2E..=20

Looking at arch/mips/bcm47xx/nvram.c: if the low-level NVRAM probe code=20
were moved elsewhere, the higher-level NVRAM "interpretation" functions=20
still remain: bcm47xx_nvram_getenv() and bcm47xx_nvram_gpio_pin().  Those=
=20
seem to be intended to parse device configuration data, yes?  And this=20
device configuration data is organized this way by platform software=20
convention -- there's no hardware requirement to store data this way in=20
the NVRAM, right?

Unfortunately the way that we organize device data parsing code in the=20
kernel is quite frankly ... anarchic.  In some kind of ideal world, we'd=20
have a standard place for device data storage and parsing functions, and=20
any combination of DT/ACPI/pdata/PCI/ISAPNP/whatever could be placed in=20
use, depending on the software environment.  But instead we have=20
directories like drivers/acpi and drivers/of and drivers/base/platform and=
=20
drivers/pnp and drivers/platform/chrome.

So if the answer to the above two questions is "yes," meaning that this=20
NVRAM is used to store device probing data by software convention, then it=
=20
would seem to me that proposing some place like=20
drivers/devicedata/bcm47xx-nvram is a better bet (where "bcm47xx-nvram" is=
=20
just some kind of opaque token).  Looking at those two functions, it=20
doesn't seem like there's really anything MIPS or Broadcom or NVRAM or=20
even SoC-specific about key-value pair parsing and GPIO device data?  Or=20
am I missing something?

Actually, considering that bcm47xx_nvram_gpio_pin() isn't even used, can=20
we just drop it and save the hassle?  :-)


- Paul
--843723315-1960090229-1416820257=:16047--
