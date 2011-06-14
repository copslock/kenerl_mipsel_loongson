Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 00:36:00 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:50784 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491000Ab1FNWfk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jun 2011 00:35:40 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5EMYEgR023515;
        Tue, 14 Jun 2011 23:34:14 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5EMY4nB023504;
        Tue, 14 Jun 2011 23:34:04 +0100
Date:   Tue, 14 Jun 2011 23:34:04 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Kyle McMartin <kyle@mcmartin.ca>,
        Lennox Wu <lennox.wu@gmail.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Mikael Starvik <starvik@axis.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Richard Henderson <rth@twiddle.net>,
        Russell King <linux@arm.linux.org.uk>,
        sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        microblaze-uclinux@itee.uq.edu.au, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Message-ID: <20110614223404.GA30057@linux-mips.org>
References: <20110614190850.GA13526@linux-mips.org>
 <4DF7C3CA.9050902@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DF7C3CA.9050902@zytor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11933

On Tue, Jun 14, 2011 at 01:25:46PM -0700, H. Peter Anvin wrote:

> On 06/14/2011 12:08 PM, Ralf Baechle wrote:
> > The PC parallel port Kconfig as acquired one of those messy terms to
> > describe it's architecture dependencies:
> > 
> >        depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && \
> >                (!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN
> > 
> > This isn't just ugly - it also almost certainly describes the dependencies
> > too coarse grainedly.  This is an attempt at cleaing the mess up.
> > 
> > I tried to faithfully aproximate the old behaviour but the existing
> > behaviour seems inacurate if not wrong for some architectures or platforms.
> > To improve on this I rely on comments from other arch and platforms
> > maintainers.  Any system that can take PCI multi-IO card or has a PC-style
> > parallel port on the mainboard should probably should now do a
> > select HAVE_PC_PARPORT.  And some arch Kconfig files should further
> > restrict the use of HAVE_PC_PARPORT to only those platforms that actually
> > need it.
> > 
> 
> Why on earth restrict it like that?  It's just a device driver, like
> more or less any other device driver...

Some of the older MIPS systems are based on PC chipsets from Intel, OPTi
or others.  On those you can expect the parport_pc driver to actually work.
The ISA/PCI implementations are often between lackluster and pure brokeness
such as with non-functioning I/O port address space.  So I don't want to
run such drivers on such a platforms, things might turn ugly.

Embedded systems often have PCI but no PCI slots or there may even be an
apropriate SuperIO chip in the the system but nothing wired to the parallel
port bits.

And there are systems such as DECstations which have nothing that even
at a parsec's distance has a similarity to (E)ISA or PCI - but still
PARPORT_PC is offered along with 40 other options that depend on it.

There is no point in offering to build something that couldn't possibly be
used.  It just makes the kernel harder to configure and inflates the test
matrix for no good reason.

  Ralf
