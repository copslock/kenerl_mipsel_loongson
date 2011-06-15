Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 11:48:18 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.187]:54707 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490982Ab1FOJsO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2011 11:48:14 +0200
Received: from klappe2.localnet (deibp9eh1--blueice3n2.emea.ibm.com [195.212.29.180])
        by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
        id 0Lx0lJ-1PQs4Z3vD7-016il5; Wed, 15 Jun 2011 11:46:19 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Date:   Wed, 15 Jun 2011 11:46:13 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.31-22-generic; KDE/4.3.2; x86_64; ; )
Cc:     linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Lennox Wu <lennox.wu@gmail.com>, linux-arch@vger.kernel.org,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Russell King <linux@arm.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matt Turner <mattst88@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        microblaze-uclinux@itee.uq.edu.au,
        Chris Metcalf <cmetcalf@tilera.com>,
        Mikael Starvik <starvik@axis.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Henderson <rth@twiddle.net>,
        Chris Zankel <chris@zankel.net>,
        Michal Simek <monstr@monstr.eu>,
        Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
        linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
        Kyle McMartin <kyle@mcmartin.ca>,
        Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
References: <20110614190850.GA13526@linux-mips.org> <201106142333.16203.arnd@arndb.de> <4DF83577.6040903@zytor.com>
In-Reply-To: <4DF83577.6040903@zytor.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201106151146.13320.arnd@arndb.de>
X-Provags-ID: V02:K0:UgVhHbJxxDK/cApY1GY56+x3rDAp403fcp7osiEzSV+
 c/BkLKpeSzJWKAH2NhkipzckEerD+ifXIZFDda14U+2AELaEDL
 5BuWUx5fUGyKn3Joch+yzM1xqBnNWVhb9ZpaSPDdMqGfRLeNam
 zPswG5xDOA1u7jkOKjVtu2cPE65ywcJ4YVdWx62K1sBQkqKmXy
 Vwd28VWYT/zHwfCqCRE3w==
X-archive-position: 30404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12225

On Wednesday 15 June 2011, H. Peter Anvin wrote:
> On 06/14/2011 02:33 PM, Arnd Bergmann wrote:
> >>
> >> Why on earth restrict it like that?  It's just a device driver, like
> >> more or less any other device driver...
> > 
> > I'd say any other classic ISA/PC driver, including floppy, gameport or
> > serial-8250. One problem with these is that we never fully worked out
> > the dependencies for these, which we probably should. CONFIG_ISA
> > generally means ISA add-on cards, but that might not be enabled for
> > platforms that have a pc-parport but no ISA slots.
> > 
> 
> OK, serial-8250 is clearly just plain wrong, since the 8250 series UARTs
> are ubiquitous across just about every platform.

Obviously you want to support 8250 uarts with MMIO on most architectures,
but the driver can only be built if you define both MMIO and PIO 
accessors (readb and outb). I would like to make the PIO part of 8250
conditional on having PIO support so that an architecture that doesn't
support this no longer has to provide fake accessor functions.

> Parallel port is an intermediate case... Centronics parallel ports
> predate the PC ecosystem by quite a bit, and the particular arrangement
> of ports became popular with the PC and spread to other platforms, but
> the particular variant of it known as ECP (as opposed to EPP) is ISA DMA
> specific.

The driver looks like it can easily be built without support for the ISA DMA
API.

> > On the other hand, you have embedded platforms that currently build support
> > for parport-pc but define the inb/outb macros to plain pointer dereferences
> > (otherwise you can't build the 8250 driver). Loading parport-pc on those
> > machines typically results in derefencing user memory in the best case.
> >
> > What I'd love to see is a configuration option for "arch has working
> > PC-style inb/outb instructions", so we can build a kernel without them but
> > still get MMIO based drivers for PCI-less platforms.
> 
> Now, isn't that was iowrite/ioread was designed for?

Yes, it just isn't used consistently. As far as I can tell, this is for multiple
number of reasons:

* In case of 8250, the driver abstracts the difference between PIO and MMIO itself,
  because it uses the same method to do indirect accesses and different strides.
  Using ioread wouldn't really make the driver much simpler.

* For parport-pc, the driver really only needs PIO, we don't even
  try to support the same device on random MMIO addresses, and that might not
  be necessary.

* In case of floppies, the "solution" was to write a driver for every platform that
  doesn't have PIO, since they tend to have other differences. The amiflop and
  ataflop drivers are not even use readb(), they just derefence volatile pointers
  to do MMIO. I doubt we can find volunteers to clean that up.

	Arnd
