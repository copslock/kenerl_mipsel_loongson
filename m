Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2003 12:36:08 +0100 (BST)
Received: from p508B7FA0.dip.t-dialin.net ([IPv6:::ffff:80.139.127.160]:6324
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225199AbTDKLgI>; Fri, 11 Apr 2003 12:36:08 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3BBZvP24706;
	Fri, 11 Apr 2003 13:35:57 +0200
Date: Fri, 11 Apr 2003 13:35:57 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Dominic Sweetman <dom@mips.com>
Cc: Mike Uhler <uhler@mips.com>, Jun Sun <jsun@mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: way selection bit for multi-way cache
Message-ID: <20030411133557.A23640@linux-mips.org>
References: <20030410220906.B519@linux-mips.org> <200304102028.h3AKSf211575@uhler-linux.mips.com> <20030410225212.A3294@linux-mips.org> <16022.24992.314581.716649@gladsmuir.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16022.24992.314581.716649@gladsmuir.mips.com>; from dom@mips.com on Fri, Apr 11, 2003 at 07:33:04AM +0100
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 11, 2003 at 07:33:04AM +0100, Dominic Sweetman wrote:

> > > I'm not sure what you mean by TLB translations required for hit
> > > cacheops.  If you mean the Index Writeback or Index Invalidate
> > > functions, note that you can (and should) use a kseg0 address to
> > > do this.
> 
> Mike was proposing a kseg0 address translating to the right physical
> address, and used with a hit-type cacheop.  I believe Ralf (and Linux)
> are just assuming that's no good because it doesn't work if you have
> cacheable memory above 512Mbytes physical address.
> 
> I wonder whether anything really bad would happen if you temporarily
> changed the (machine) ASID to that of the address space you wanted to
> invalidate?

There are non-trivial race conditions related to the IPI mechanism used
on multi-processors when attempting this.  The easy fix would be
temporarily disabling interrupts - but of course that's undesireable as
well.

  Ralf
