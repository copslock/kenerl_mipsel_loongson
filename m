Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 15:08:09 +0000 (GMT)
Received: from p508B7363.dip.t-dialin.net ([IPv6:::ffff:80.139.115.99]:48705
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225440AbUBBPII>; Mon, 2 Feb 2004 15:08:08 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i12F86ex028664;
	Mon, 2 Feb 2004 16:08:06 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i12F86Cg028663;
	Mon, 2 Feb 2004 16:08:06 +0100
Date: Mon, 2 Feb 2004 16:08:06 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] pg-r4k.c cp0 hazards for R4000/R4400
Message-ID: <20040202150806.GA27819@linux-mips.org>
References: <Pine.LNX.4.55.0401261755460.26076@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0401261755460.26076@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 26, 2004 at 06:12:43PM +0100, Maciej W. Rozycki wrote:

>  The R4000/R4400 has a coprocessor 0 hazard when a P-cache operation is
> less than two non-load, non-cache instructions apart from a store to the
> same line.  For processors without a secondary cache, the code in pg-r4k.c
> currently issues a Create Dirty Exclusive D-cache operation and then
> immediately executes consecutive stores to the same line, therefore 
> fulfilling the conditions for the hazard.

The wording is "There must be two non-load, non-CACHE instructions between
a store and a CACHE instruction directed to the same primary cache line as
the store."  My interpretation of that is the problem only exists if a
store instruction is followed by a cache instruction, not if the
cache instruction is followed by the store?  I've not found any hints in
the manual to verify or falsify this theory.  In case you're right we've
violated this hazard since almost beginning of the time, see
http://www.linux-mips.org/cvsweb/linux/arch/mips/mm/Attic/pg-r4k.S?rev=1.9
and I've not heared of any problems arising from this.

Any DECstations using the R4[04]00PC CPU variant?

>  The following patch changes the problematic operations to be performed on 
> the cache line following the one to be written immediately.  It is safe to 
> do so, because the cache operations are only a performance hint and are 
> not required for data coherency.  However it is essential not to bypass 
> the end of the page, so the trailing area of the page is excluded from 
> these cache operation, similarly to what has already been done for 
> prefetching.
> 
>  Actually, I'd like to optimize the functions a bit further, specifically 
> to avoid multiple cacheops to the same line (if you don't mind),

Please do so - cacheops are fairly expensive, we must use them as
intelligently as possible.

> but 
> currently I'd like to apply this change to assure correct operation.  As I 
> have no non-SC R4000/R4400 system, this was untested, but perhaps studying 
> the problem covered by the -scache patch sent previously will show if the 
> hazard is indeed avoided.

Have you actually been hit by that hazard?  

>  The patch also increases the buffers a bit for three reasons:
> 
> 1. copy_page_array is already too small for the 128-byte S-cache line 
> case. ;-)
>
> 2. The trail for non-SC R4000/R4400 increases buffer consumption and I was 
> too lazy to calculate the requirements.
> 
> 3. The planned optimization will likely require a little bit more space as 
> well.
> 
> BTW, I was unable to reproduce your instruction count calculation for the
> prefetch case; other results seem OK.

Yep, the patch I just checked in increased the allocation size to handle
the worst case appropriately.  In the end I think we really want to trade
memory for performance here.

>  OK to apply?

Most of your changes conflict with my fixes, so I guess that need redoing ...

  Ralf
