Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 17:32:54 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.10]:59145 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007230AbaH1PctI-5vt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 17:32:49 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue101) with ESMTP (Nemesis)
        id 0MZDVU-1X23SX2YaS-00Kyfh; Thu, 28 Aug 2014 17:32:41 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: Booting bcm47xx (bcma & stuff), sharing code with bcm53xx
Date:   Thu, 28 Aug 2014 17:32:38 +0200
Message-ID: <6633831.1CSHMPPLH1@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CACna6rx0E_s76wLLkDjj90sXH=Q3yzBemQM5Qrp96QiWCWr0qg@mail.gmail.com>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com> <2859425.94ptgpItD3@wuerfel> <CACna6rx0E_s76wLLkDjj90sXH=Q3yzBemQM5Qrp96QiWCWr0qg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V02:K0:PMaTtOkzYGxIhWlKbsKKp1fpNvGCNKl250UXXn/JHUf
 VYBwri8Se8xBoCKXDAnCscjct2zTQh9y6XvuUnkTtSY1KVDTHy
 utPjTL/dS5Ye3qpMWDA3JJgvB1cthkMrGVWKwJoeuIBj4BIOZv
 JggIlND6ZvZUhwkXkeSSgL/RyRstsoRnzBhDaDOwRsl/c7j5Ny
 7FCMNw2ipNUan4eTSi7pCpNBDWO91Tb/YLs4PO1rbswmAQ1dxs
 RY0hvZaL96D/AoellsWu84q5ZFmtvxwEe6aGxyx66kujXrT3Et
 JVosdMt+a8v3nQNQQKsfHLUqjlo1zx/MfAUVeUvpdCBjqGdig/
 DYTb+l5nu0P6i2DkQ+Mw=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42310
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

On Thursday 28 August 2014 14:37:54 Rafał Miłecki wrote:
> On 28 August 2014 13:56, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 28 August 2014 13:39:55 Rafał Miłecki wrote:
> >> switch (boot_device) {
> >> case BCMA_BOOT_DEV_NAND:
> >>     nvram_address = 0x1000dead;
> >>     break;
> >> case BCMA_BOOT_DEV_SERIAL:
> >>     nvram_address = 0x1000c0de;
> >>     break;
> >> }
> >>
> >
> > I don't understand. Why does the nvram address depend on the boot
> > device?
> 
> NVRAM is basically just a partition on flash, however there are few
> tricks applying to it.

Ah, that explains a lot! I was thinking of hardware nvram, which I assume
it was on some early hardware.

> To make booting possible, flash content is mapped to the memory. We're
> talking about read only access. This mapping allows CPU to get code
> (bootloader) and execute it as well as it allows CFE to get NVRAM
> content easily. You don't need flash driver (with erasing & writing
> support) to read NVRAM.

Ok. Just out of curiosity, how does the system manage to map NAND
flash into physical address space? Is this a feature of the SoC
of the flash chip?

I guess for writing you'd still use the full MTD driver, right?

> Depending on the boot flash device, content of flash is mapped at
> different offsets:
> 1) MIPS serial flash: SI_FLASH2 (0x1c000000)
> 2) MIPS NAND flash: SI_FLASH1 (0x1fc00000)
> 3) ARM serial flash: SI_NS_NORFLASH (0x1e000000)
> 4) ARM NAND flash: SI_NS_NANDFLASH (0x1c000000)
> 
> So on my ARM device with serial flash (connected over SPI) I was able
> to get NVRAM header this way:
> 
> void __iomem *iobase = ioremap_nocache(0x1e000000, 0x1000000);
> u8 *buf;
> 
> buf = (u8 *)(iobase + 0xff0000);
> pr_info("[NVRAM] %02X %02X %02X %02X\n", buf[0], buf[1], buf[2], buf[3]);
> 
> This resulted in:
> [NVRAM] 46 4C 53 48
> 
> (I hardcoded 0xff0000 above, normally you would need to try 0x10000,
> 0x20000, 0x30000 and so on...).

Does that mean the entire 0x1e000000-0x1f000000 area is mapped to
the flash and you are looking for the nvram in it, or that you don't
know where it is?

	Arnd
