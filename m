Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Oct 2002 01:44:00 +0200 (CEST)
Received: from p508B51F7.dip.t-dialin.net ([80.139.81.247]:47528 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123253AbSJDXn7>; Sat, 5 Oct 2002 01:43:59 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g94NhjF24250;
	Sat, 5 Oct 2002 01:43:45 +0200
Date: Sat, 5 Oct 2002 01:43:45 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Dominic Sweetman <dom@algor.co.uk>,
	Carsten Langgaard <carstenl@mips.com>,
	linux-mips@linux-mips.org
Subject: Re: Promblem with PREF (prefetching) in memcpy
Message-ID: <20021005014345.B15883@linux-mips.org>
References: <3D9D484B.4C149BD8@mips.com> <200210041153.MAA12052@mudchute.algor.co.uk> <00dd01c26ba2$b18f55b0$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <00dd01c26ba2$b18f55b0$10eca8c0@grendel>; from kevink@mips.com on Fri, Oct 04, 2002 at 02:36:39PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 04, 2002 at 02:36:39PM +0200, Kevin D. Kissell wrote:

> In case Carsten's reply wasn't clear enough, there is a loophole
> in the spec:  kseg0.  There is no TLB access to cause a TLB
> exception (which would suppress the operation and be nullifed),
> If the prefetch address is correctly aligned, so that there is no
> address exception.  In typical use, kseg0 is cacheable, which
> means that the second paragraph you quote does not apply.
> A prefetch to a well-formed, cacheable kseg0 address which 
> has no primary storage behind it (e.g. 0x04000000 on a system
> with 64M of physical memory) should, according to the spec,
> cause a cache fill to be initiated for the line at that address,
> which will result in a bus error, if not a flat-out system hang.

Traditionally the kernel leaves the last page of memory unused but this
has been lost in the many changes to the memory initialization code.
It's still a good idea with all the broken I/O chips and PCI bridges out
there - and can avoid a hard to track bug.

That only leaves stuff usermode device drivers that are using cachable
mappings in the dangerzone.  That should be a rare case, if at all.

  Ralf
