Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 06:31:40 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:54431 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490982Ab1FOEbc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jun 2011 06:31:32 +0200
Received: from tazenda.hos.anvin.org ([IPv6:2001:470:861f:0:e269:95ff:fe35:9f3c])
        (authenticated bits=0)
        by mail.zytor.com (8.14.4/8.14.4) with ESMTP id p5F4UqHr019189
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Tue, 14 Jun 2011 21:30:53 -0700
Message-ID: <4DF83577.6040903@zytor.com>
Date:   Tue, 14 Jun 2011 21:30:47 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@arndb.de>
CC:     linux-arm-kernel@lists.infradead.org,
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
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
References: <20110614190850.GA13526@linux-mips.org> <4DF7C3CA.9050902@zytor.com> <201106142333.16203.arnd@arndb.de>
In-Reply-To: <201106142333.16203.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 30392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12087

On 06/14/2011 02:33 PM, Arnd Bergmann wrote:
>>
>> Why on earth restrict it like that?  It's just a device driver, like
>> more or less any other device driver...
> 
> I'd say any other classic ISA/PC driver, including floppy, gameport or
> serial-8250. One problem with these is that we never fully worked out
> the dependencies for these, which we probably should. CONFIG_ISA
> generally means ISA add-on cards, but that might not be enabled for
> platforms that have a pc-parport but no ISA slots.
> 

OK, serial-8250 is clearly just plain wrong, since the 8250 series UARTs
are ubiquitous across just about every platform.

Floppy is special (in the short bus sense), since it is closely tied to
ISA DMA.  Conditionalizing this on ISA DMA makes total sense.

Parallel port is an intermediate case... Centronics parallel ports
predate the PC ecosystem by quite a bit, and the particular arrangement
of ports became popular with the PC and spread to other platforms, but
the particular variant of it known as ECP (as opposed to EPP) is ISA DMA
specific.

> On the other hand, you have embedded platforms that currently build support
> for parport-pc but define the inb/outb macros to plain pointer dereferences
> (otherwise you can't build the 8250 driver). Loading parport-pc on those
> machines typically results in derefencing user memory in the best case.
>
> What I'd love to see is a configuration option for "arch has working
> PC-style inb/outb instructions", so we can build a kernel without them but
> still get MMIO based drivers for PCI-less platforms.

Now, isn't that was iowrite/ioread was designed for?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
