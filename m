Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2003 14:29:30 +0100 (BST)
Received: from p508B780A.dip.t-dialin.net ([IPv6:::ffff:80.139.120.10]:58837
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225479AbTJNN3W>; Tue, 14 Oct 2003 14:29:22 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9EDSrNK013633;
	Tue, 14 Oct 2003 15:28:53 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9EDSong013632;
	Tue, 14 Oct 2003 15:28:50 +0200
Date: Tue, 14 Oct 2003 15:28:50 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20031014132850.GA12938@linux-mips.org>
References: <20031013142637Z8225419-1272+7775@linux-mips.org> <Pine.GSO.3.96.1031014114452.17028B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1031014114452.17028B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 14, 2003 at 11:47:59AM +0200, Maciej W. Rozycki wrote:

> > Log message:
> > 	Config bits of support for TLB page sizes other than 4k.  So not
> > 	functional yet but this is a fairly large project and everybody should
> > 	finally get rid of the assumption that PAGE_SIZE is always 4k.
> 
>  I've already thought we might unconditionally switch to a larger page
> size, e.g. 16kB, for the 64-bit kernel -- I suppose everything that
> supports 64-bit operation also supports larger page sizes, doesn't it?

True.  At 16k pagesize we can also start harvesting other advantages, for
example we'd then know that cpu_has_dc_aliases is never true which will
make the compiler simply throw away large parts of the cache code.

As the result of living in an alias-free universe we could use the nice
recursive page fault technique from very old Linux kernels again,
something that allowed blindigly fast TLB refill handlers.

An additional bonus is the increased coverage of a pagetables with 16k
page size.  A 16k page has space for 2048 pointers.  So in case of a
two level pagetable tree that makes the total capacity 16k*2k*2k = 64GB.
So that means one level of the pagetable tree less than we currently
have, yet enough capacity for everything but the largest jobs.

Still want more?  A 3 level tree would then cover 128TB of virtual
address space already exceedin the hardware limits of all processors but
the R8000.

64k pagesize stretches the limits even further.   Here a two level
pagetable tree would cover 4TB, 3-level could cover 32PB exceeding
the capacity of every MIPS processor ever made - and probably sufficient
for the coming decade :-)

  Ralf
