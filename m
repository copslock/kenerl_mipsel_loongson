Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 09:48:27 +0200 (CEST)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36740 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491040Ab1FOHsV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2011 09:48:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=agOcgmQc07pm4x5FRlTzdVmIRxDIXvcdzqDHM+ZMJZk=;
        b=UWfeIl/fb6ZsAwsAtL3BPXfQ6+uqL0JrTVA6/Qh5QlXtJIi6rovDLzrS8hdB1bHUhxSFDRMRmDcQSU39/9IdyRj6hBBhtLliq6x8RM7ewOlCUADYFGDgKvmITZsYbwp1o11Sop6FNqenSy+8MnsYbqqfuwcoSoFKGDdtUUbWfdg=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1QWkpM-0003Lu-Bv; Wed, 15 Jun 2011 08:47:52 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1QWkpK-0003Qi-D2; Wed, 15 Jun 2011 08:47:50 +0100
Date:   Wed, 15 Jun 2011 08:47:50 +0100
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
Message-ID: <20110615074749.GB28989@n2100.arm.linux.org.uk>
References: <20110614190850.GA13526@linux-mips.org> <4DF7C3CA.9050902@zytor.com> <201106142333.16203.arnd@arndb.de> <4DF83577.6040903@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DF83577.6040903@zytor.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-archive-position: 30398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12151

On Tue, Jun 14, 2011 at 09:30:47PM -0700, H. Peter Anvin wrote:
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
> 
> Floppy is special (in the short bus sense), since it is closely tied to
> ISA DMA.  Conditionalizing this on ISA DMA makes total sense.

No it doesn't.  It depends on the ISA DMA API, not that the machine has
ISA DMA.

I have a platform which has no ISA DMA but uses the floppy driver.  Please
don't break it.
