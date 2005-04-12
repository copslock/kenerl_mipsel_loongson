Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2005 12:43:19 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:45083 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8224916AbVDLLnE>; Tue, 12 Apr 2005 12:43:04 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3CBgqqQ021323;
	Tue, 12 Apr 2005 12:42:52 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3CBgqH8021322;
	Tue, 12 Apr 2005 12:42:52 +0100
Date:	Tue, 12 Apr 2005 12:42:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Paul Chapman <paul.chapman@BrockU.CA>, linux-mips@linux-mips.org
Subject: Re: ip27 PCI devices
Message-ID: <20050412114252.GE5573@linux-mips.org>
References: <1113251422.21580.33.camel@paul.dev.brocku.ca> <20050412105815.GC5573@linux-mips.org> <Pine.LNX.4.61L.0504121213400.18606@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0504121213400.18606@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 12, 2005 at 12:18:15PM +0100, Maciej W. Rozycki wrote:

> > > I've been experimenting with trying various PCI cards I have lying
> > > around in my Origin 200, to see if I can make any of them work.
> > 
> > The current Linux implementation limits IP27 to cards with 64-bit
> > addressing capability.
> 
>  Do we have a problem with our implementation of PCI DMA masks or is the 
> low 4GB of PCI address space already consumed on this system?  The problem 
> is most 32-bit PCI cards unfortunately do not support DAC.

32-bit devices can only address a tiny fraction of the address space on
IP27.  To make matters more interesting, there is no memory at all in the
low 4GB of the crosstalk address space,  so 32-bit PCI has to rely on the
yet non-existing support for the IOMMU.  SGI trying to save a little too
much money on the external SRAM for the IOMMU in the Origin 200 finally
made it a hard to use in an OS, deadlock prone thing.

  Ralf
