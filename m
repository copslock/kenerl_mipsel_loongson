Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2004 09:18:46 +0100 (BST)
Received: from p508B7A8B.dip.t-dialin.net ([IPv6:::ffff:80.139.122.139]:37493
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224791AbUHTISl>; Fri, 20 Aug 2004 09:18:41 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7K8IX7C017370;
	Fri, 20 Aug 2004 10:18:33 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7K8IW2Z017369;
	Fri, 20 Aug 2004 10:18:32 +0200
Date: Fri, 20 Aug 2004 10:18:32 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Srinivas Kommu <kommu@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: mips32 kernel memory mapping
Message-ID: <20040820081832.GD15543@linux-mips.org>
References: <BAY1-F25sCR6nWqNG2Y00092cf9@hotmail.com> <Pine.LNX.4.58L.0407231348580.5644@blysk.ds.pg.gda.pl> <20040723202439.GA3711@linux-mips.org> <Pine.LNX.4.58L.0407261258010.3873@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0407261258010.3873@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 26, 2004 at 01:23:41PM +0200, Maciej W. Rozycki wrote:

> > There is a general perception among Linux users that 64-bit is new an
> > not really needed which in part I blame on the bs Intel is spreading to
> > hide the fact that for a long time they simply had no 64-bit roadmap at
> > all.
> 
>  Huh?  How's Intel's policy related to 64-bit Linux?  Especially for other
> processors, like MIPS.

Their wrong claims that only server machines need 64-bit.

>  Linux has supported 64-bit operation since ~1995 and around 1998 when I
> had an opportunity to use it on DEC Alpha, it (2.0.x) was already stable
> enough for regular use.  That is the generic core and the Alpha bits, of
> course -- the maturity of other processor support may vary, but for MIPS
> it's not worse than the 32-bit support.

At least after I fixed kernel mode page tables last week.  The 4MB limit
we had before that was just ridiculous.

> > There are still improvments to be made for BCM1250 support.  Somebody
> > thought scattering the first 1GB of memory through the lowest 4GB of
> > physical address space like a three year old his toys over the floor
> > was a good thing ...  The resulting holes in the memory map are wasting
> > significant amounts of memory for unused memory; the worst case number
> > that is reached for 64-bit kernel on a system with > 1GB of RAM is 96MB!
> 
>  Well, there are some resons given in the manual.  Anyway, memory seems to
> be remappable to 0x100000000 in the DRAM controller.  Still we probably
> have to keep low 256MB mapped and registered within Linux at 0 for bounce
> buffers for broken PCI hardware ("hidden" mapping for exception handlers 
> and kernel segments would be easier).
> 
>  With only 256MB installed in my system it would be tough for me to code
> anything interesting, though.  Perhaps another time.

I have 1GB and that's where 32-bit kernels are beginning to look really
like a bad idea on MIPS.  Fortunately on the BCM1250 and all the other
64-bit processors there is an easy way out.  Better even, some of the
embedded application performance numbers suggest significant performance
gains for 64-bit processing contrary to conventional wisdom about 64-bit
computing.

  Ralf
