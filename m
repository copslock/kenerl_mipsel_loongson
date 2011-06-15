Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 17:22:45 +0200 (CEST)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57156 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491096Ab1FOPWl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2011 17:22:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Hs9ffxwPNuzFlKAsDVltuhGb26YVWeq3rynswaUUHuw=;
        b=o2C4AmDaw4GqMh9JeMW9JL7Q0AeHC1td9DdfByGSR9JWwIAiNBoa6tfwn0LHutRV/OUoy7atTYQj6m7phxAXcywgQT0Qt0Jep0M3+VzSgZr7DDmHd60EZoorXIxdTqWc9VbM+ItozajUwKnGxell7Ig1hYCNfqRgNW1LxslEfXY=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1QWruc-0003nj-Qf; Wed, 15 Jun 2011 16:21:47 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1QWrua-0004xR-Sd; Wed, 15 Jun 2011 16:21:44 +0100
Date:   Wed, 15 Jun 2011 16:21:44 +0100
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Lennox Wu <lennox.wu@gmail.com>, linux-arch@vger.kernel.org,
        Jesper Nilsson <jesper.nilsson@axis.com>,
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
Message-ID: <20110615152144.GE28989@n2100.arm.linux.org.uk>
References: <20110614190850.GA13526@linux-mips.org> <4DF7C3CA.9050902@zytor.com> <201106142333.16203.arnd@arndb.de> <4DF83577.6040903@zytor.com> <20110615074749.GB28989@n2100.arm.linux.org.uk> <4DF8CAD5.1090902@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DF8CAD5.1090902@zytor.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-archive-position: 30415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12427

On Wed, Jun 15, 2011 at 08:08:05AM -0700, H. Peter Anvin wrote:
> On 06/15/2011 12:47 AM, Russell King - ARM Linux wrote:
> >>
> >> OK, serial-8250 is clearly just plain wrong, since the 8250 series UARTs
> >> are ubiquitous across just about every platform.
> >>
> >> Floppy is special (in the short bus sense), since it is closely tied to
> >> ISA DMA.  Conditionalizing this on ISA DMA makes total sense.
> > 
> > No it doesn't.  It depends on the ISA DMA API, not that the machine has
> > ISA DMA.
> > 
> > I have a platform which has no ISA DMA but uses the floppy driver.  Please
> > don't break it.
> 
> OK, even more case in point, then.

It's already been solved - ARCH_MAY_HAVE_PC_FDC is supposed to be
defined to y in the cases where architectures have support for it.

What we do on ARM for example is:

config ARCH_MAY_HAVE_PC_FDC
        bool

and then select that symbol for our platforms which can have the
floppy driver.

And in any case we already have definitions for the presence of the
ISA DMA API vs the common ISA DMA helpers in kernel/.  The presence
of the ISA DMA API is given by CONFIG_ISA_DMA_API, while the
ISA DMA helper CONFIG_GENERIC_ISA_DMA.
