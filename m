Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2007 19:37:08 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:26500 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20021656AbXHFShG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Aug 2007 19:37:06 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1II7Op-0008U8-MQ; Mon, 06 Aug 2007 20:33:51 +0200
Date:	Mon, 6 Aug 2007 20:33:51 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Michael Buesch <mb@bu3sch.de>
Cc:	Felix Fietkau <nbd@openwrt.org>, Andrew Morton <akpm@osdl.org>,
	linux-mips@linux-mips.org, Waldemar Brodkorb <wbx@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
Subject: Re: [PATCH -mm 3/4] MIPS: Add BCM947XX to Kconfig
Message-ID: <20070806183351.GC32465@hall.aurel32.net>
References: <20070806150931.GH24308@hall.aurel32.net> <200708062009.14971.mb@bu3sch.de> <46B764D3.2030402@openwrt.org> <200708062024.53952.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200708062024.53952.mb@bu3sch.de>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

On Mon, Aug 06, 2007 at 08:24:53PM +0200, Michael Buesch wrote:
> On Monday 06 August 2007, Felix Fietkau wrote:
> > Michael Buesch wrote:
> > 
> > > Shouldn't we leave the PCICORE an option instead of force selecting
> > > it here?
> > > My WRT54G doesn't have a (usable) PCI core. So it would work
> > > without the driver for it.
> > > Especially on the small WAP54G disabling PCIcore support could
> > > be useful to reduce the kernel size.
> > Yeah, leave it as an option, but I think a 'default y if BCM947XX' on
> > the PCICORE option would be reasonable, since many 47xx devices do have pci.
> 
> Yeah, probably a good idea.
> 

I will send a new patch to fix that.

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
