Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2003 16:42:24 +0100 (BST)
Received: from p508B6582.dip.t-dialin.net ([IPv6:::ffff:80.139.101.130]:7406
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225197AbTDCPmX>; Thu, 3 Apr 2003 16:42:23 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h33FgJ704697;
	Thu, 3 Apr 2003 17:42:19 +0200
Date: Thu, 3 Apr 2003 17:42:19 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030403174219.A4276@linux-mips.org>
References: <20030403162428.A2460@linux-mips.org> <Pine.GSO.3.96.1030403163046.19058F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030403163046.19058F-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Apr 03, 2003 at 04:48:21PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 03, 2003 at 04:48:21PM +0200, Maciej W. Rozycki wrote:

> > I know of one machine where changing the size of the cacheline is supposed
> > not to work, that's the MIPS Magnum 4000 and it's close relatives.
> 
>  Hmm, why -- is such a change observable externally in any way?  Of
> course you can't switch the other way if the s-cache uses a line width of
> 16 bytes.  Maybe that's the case with the Magnum?

It's a hardware problem with the memory controller I was told by one of
it's developpers.  That forced them to run the machine with an different
line size for D-cache and I-Cache.  There's various revs of the Magnum's
memory controller and only one of them got all the cases right ...

Maybe DECstation and other SGI hardware got that better?

> > Anyway, I put the check there for the unlikely case there are broken
> > systems out there.  In practice I assume vendors were aware of this
> > problem and the check is purely theoretical and for paranoid correctness's
> > sake.
> 
>  Still V3.0 should be taken into account.

Ok.

> > It seems like changing the configuration to larger cache lines where
> > possible should improve performance somewhat.  If all the cache code is
> 
>  Why?  It isn't that obvious especially as a p-cache miss costs a single
> cycle only.

During my recent work on the cache code I found the execution time of
cache flushing code to be quite a bit higher than previously assumed so
larger lines would help reducing that also.

> > working truly correct we also should no longer see VCE exceptions on
> > R4000SC processors - the reason why Indys are still a valuable test tool.
> 
>  As are DECstations which use the opposite endianness -- so you can test
> code both ways.

A bunch of evaluation boards that support running in the other endianess
and way exceed the performance of any R4000-based platform.  Just having
to flip a switch on the board is very handy.

  Ralf
