Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2005 15:45:48 +0000 (GMT)
Received: from p3EE076D7.dip.t-dialin.net ([IPv6:::ffff:62.224.118.215]:5908
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225218AbVBDPpd>; Fri, 4 Feb 2005 15:45:33 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j14FjW4n022596;
	Fri, 4 Feb 2005 16:45:32 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j14FjW91022595;
	Fri, 4 Feb 2005 16:45:32 +0100
Date:	Fri, 4 Feb 2005 16:45:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dominic Sweetman <dom@mips.com>
Cc:	Nigel Stephens <nigel@mips.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: c-r4k.c cleanup
Message-ID: <20050204154532.GA22217@linux-mips.org>
References: <20050204.231254.74753794.anemo@mba.ocn.ne.jp> <4203890B.5030305@mips.com> <20050204145803.GA5618@linux-mips.org> <16899.37525.412441.558873@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16899.37525.412441.558873@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 04, 2005 at 03:19:49PM +0000, Dominic Sweetman wrote:

> Only some CPUs suffer from aliases.  A 4Kbyte direct-mapped cache must
> be alias free, because all the virtual index bits are the same (being
> in-page) as the physical address bits.  That's true but irrelvant,
> since there aren't any 4Kbyte caches: but what's slightly less obvious
> is that a 16Kbyte 4-way set-associative cache is also alias free.

I had dark memory of some el cheapo CPU having 4k caches.

> 24K's "AR" bit trick applies *only* to the D-cache, and only to a
> 32Kbyte cache.  (But then most alias problems are D-cache aliases, and
> 32Kbyte happens to be the most popular size for a 24K cache - so this
> is a trick worth doing).
> 
> Note that I-cache aliases are not completely harmless; sometimes you
> want to invalidate any I-cache copies of some data, and if it's
> aliased you may miss some of them.  Shared libraries are generally
> aligned to some large page-size multiple - so multiple text images are
> usually the same colour, and don't matter.  You can get problems with
> trampolines and stuff.

Linux computes the necessary alignment on the fly.  The method used is
not strictly correct because as you say it should account for possible
I-cache aliases also.

Seems it's cache day again today ;-)

  Ralf
