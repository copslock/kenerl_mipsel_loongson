Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Sep 2004 12:43:54 +0100 (BST)
Received: from p508B7024.dip.t-dialin.net ([IPv6:::ffff:80.139.112.36]:35409
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224953AbUIJLnu>; Fri, 10 Sep 2004 12:43:50 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i8ABhnsm011903;
	Fri, 10 Sep 2004 13:43:49 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i8ABhiBx011902;
	Fri, 10 Sep 2004 13:43:44 +0200
Date: Fri, 10 Sep 2004 13:43:43 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Emmanuel Michon <em@realmagic.fr>
Cc: linux-mips@linux-mips.org
Subject: Re: ...cache dimensioning ;-)
Message-ID: <20040910114343.GA10064@linux-mips.org>
References: <1094811358.29872.8745.camel@nikita.france.sdesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094811358.29872.8745.camel@nikita.france.sdesigns.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 10, 2004 at 12:15:58PM +0200, Emmanuel Michon wrote:

> I'm still in the process of choosing the best configurable parameters of
> a hardware design based on 4KEc

Simply answer:

Linux is most happy if size_per_cache =< PAGE_SIZE * number_of_ways.

> As far as I understand, excepted alpha platforms, 4KByte pages are the
> de facto standard [I assume linux developers are reasonable so changing
> the page size to 8KB is not going to be a nightmare...]

4k may be the predominant size but by no means it's the defacto standard.

Some older ARM chips use 16k or 32k; Cris uses 8k; some 68k Suns using
the non-Motorola MMU use 8k also; sun4 and sparc64 both use 8k; IA-64 is
configurable to 4k (bad idea), 16k (prefered) and 64k.

On MIPS going for 4k was my choice in '95 ago because that's the pagesize
of the R3000 - and the i386 which eleminated a whole class of bugs in
porting.

It's now ten years later; everything is growing according to Moore's law
and some embedded systems that are considered small by today's standards
exceed what was a powerful workstation back then or even a full blown
supermini in '85 when the R2000 was created so increasig the page size
is overdue for most systems, MIPS and other.

> Since the mips cache is virtually indexed but physically tagged, I see
> two problems when the size of a cache way exceeds the size of a page:

Not all of them; it's just the most common cache policy.  There are also
PIPT caches and even VIVT I-caches.  I'll personally poke needles into
a doll of whoever should design VIVT D-caches ;-)

> - virtual aliasing. Can only happen on R/W pages (data cache) and only
> when two different virtual addresses map the same physical page. An
> example of this is: two processes sharing a memory area; should I
> consider this is taken into account by linux already?
> 
> - I was told the software exception handlers for tlb are much less
> efficient when cacheway > pagesize, forcing to flush too often. Is this
> true? What is, in practice, the ratio of instruction pages and data
> pages in a tlb?

The affected parts of memory managment are not part of the TLB exception
handlers in a strict sense but yes, on caches suffering from aliases in
situations where we can't use hit cacheops we need to flush nuber of ways
pages from the cache, so for a 4-way 32k cache that means half the cache.

Going to 16k pagesize would eleminate most such flushes entirely and as
a nice side effect also guarantee the correctness of a fairly complex
to get right piece of code by simple eleminating the need for it.

> If I consider a platform like Toshiba TX39 which has d-cache four ways
> with total 32KBytes, it must already have the problems above. I'd like
> to get some more clues though...

My paper says different numbers ...

  Ralf
