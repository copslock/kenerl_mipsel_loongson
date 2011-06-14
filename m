Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2011 23:35:55 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.186]:54367 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491028Ab1FNVfu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2011 23:35:50 +0200
Received: from wuerfel.localnet (port-92-200-80-152.dynamic.qsc.de [92.200.80.152])
        by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
        id 0MY28S-1Q1kZk2wIy-00Uo9f; Tue, 14 Jun 2011 23:33:28 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Date:   Tue, 14 Jun 2011 23:33:15 +0200
User-Agent: KMail/1.13.6 (Linux/3.0.0-rc1nosema+; KDE/4.6.3; x86_64; ; )
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
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
References: <20110614190850.GA13526@linux-mips.org> <4DF7C3CA.9050902@zytor.com>
In-Reply-To: <4DF7C3CA.9050902@zytor.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106142333.16203.arnd@arndb.de>
X-Provags-ID: V02:K0:4Zssem6JWizqn7BkT7+NQXYfMfyH4hXjXBiyiXNVpSb
 cn8oU3BrS/+p+x06i7aE/WdPdAaMuShkqSrTK+hqlZBemaZjH2
 mAiyyo3L06hVuJJApWQij2iyvaMHUukM2KfMtL+wYasMvFww5A
 Br2rHs0CZ3awQYtNCBRhI3vaJhaxhVLR6rt32ZxVorMrBdgsUo
 PcETbV8aYwWDGCAGSUK0g==
X-archive-position: 30387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11909

On Tuesday 14 June 2011 22:25:46 H. Peter Anvin wrote:
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

I'd say any other classic ISA/PC driver, including floppy, gameport or
serial-8250. One problem with these is that we never fully worked out
the dependencies for these, which we probably should. CONFIG_ISA
generally means ISA add-on cards, but that might not be enabled for
platforms that have a pc-parport but no ISA slots.

On the other hand, you have embedded platforms that currently build support
for parport-pc but define the inb/outb macros to plain pointer dereferences
(otherwise you can't build the 8250 driver). Loading parport-pc on those
machines typically results in derefencing user memory in the best case.

What I'd love to see is a configuration option for "arch has working
PC-style inb/outb instructions", so we can build a kernel without them but
still get MMIO based drivers for PCI-less platforms.

	Arnd
