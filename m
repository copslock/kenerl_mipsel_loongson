Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2003 19:51:25 +0000 (GMT)
Received: from p508B5A6A.dip.t-dialin.net ([IPv6:::ffff:80.139.90.106]:32710
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225347AbTLOTvY>; Mon, 15 Dec 2003 19:51:24 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hBFJpJoK004068;
	Mon, 15 Dec 2003 20:51:19 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hBFJpITM004067;
	Mon, 15 Dec 2003 20:51:18 +0100
Date: Mon, 15 Dec 2003 20:51:18 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Dominic Sweetman <dom@mips.com>
Cc: Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org
Subject: Re: Instability / caching problems on Qube 2 - solved ?
Message-ID: <20031215195118.GA1787@linux-mips.org>
References: <20031214162605.GA18357@skeleton-jack> <20031215022717.GA16560@linux-mips.org> <20031215083236.GA1164@skeleton-jack> <16349.31025.637084.624143@doms-laptop.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16349.31025.637084.624143@doms-laptop.algor.co.uk>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 15, 2003 at 09:04:49AM +0000, Dominic Sweetman wrote:

> My prejudices are showing but...
> 
> o Shouldn't the kernel should have a zero-tolerance policy towards cache
>   aliases?  That is, no D-cache alias should ever be permitted to
>   happen, not even in data you reasonably hope might be read-only?

We're already trying hard to avoid such aliases.  The case found by Peter
is clearly a bug and nothing else.

>   Aliases only appeared by a kind of mistake when the R4000 was
>   opportunistically repackaged without the secondary cache (the L2
>   cache tags used to keep track of the virtually-indexed L1s, and you
>   got an exception if you created an L1-alias).
> 
>   They really aren't a feature to be tolerated in the hope you can
>   clean up before disaster strikes.

These days R4000SC is only an ancient processor - but very valuable for
Linux maintenance because it's virtual coherency exception is the
only available hardware detector for aliases.

> o And I could never get my brains round cache maintenance if I used
>   the same word ("flush") both for invalidate and write-back.

I once had a discussion about the terminology with maintainers of other
architectures.  Turned none of the MIPS terms were really unambigious;
does flush imply a writeback, does it imply invalidation?  Does
invalidate imply writing back to memory or writeback imply invalidation
etc. etc. ad infinitum.  Confusion pure ...

  Ralf
