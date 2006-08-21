Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2006 19:13:50 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:18830 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20038587AbWHUSNp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2006 19:13:45 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id DCEF645FD8; Mon, 21 Aug 2006 20:13:40 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1GFEG0-0007Wo-T1; Mon, 21 Aug 2006 19:12:16 +0100
Date:	Mon, 21 Aug 2006 19:12:16 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] qemu does not have dcache aliases
Message-ID: <20060821181216.GD20395@networkno.de>
References: <20060820.003338.25478178.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0608211340120.17504@blysk.ds.pg.gda.pl> <20060821.225910.108307053.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0608211612090.17504@blysk.ds.pg.gda.pl> <20060821152657.GB19600@linux-mips.org> <20060821153616.GC20395@networkno.de> <Pine.LNX.4.62.0608211741580.6328@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0608211741580.6328@pademelon.sonytel.be>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:
> On Mon, 21 Aug 2006, Thiemo Seufer wrote:
> > Ralf Baechle wrote:
> > > On Mon, Aug 21, 2006 at 04:16:21PM +0100, Maciej W. Rozycki wrote:
> > > 
> > > > > Well, the QEMU cpu has 2-way 2kB dcache... does not have aliasing
> > > > > anyway. :-)
> > > > 
> > > >  I don't think emulating a bigger cache so that we can add aliases should 
> > > > be *that* difficult.  Adding aliases themselves might be a bit trickier, 
> > > > but the gain would certainly justify the hassle, wouldn't it?
> > > 
> > > The cache lookup for every access would have serious impact on performance.
> > > The question is, is it worth the price?  Would such patches be acceptable
> > > by the upstream qemu maintainers?
> > 
> > Likely not, given that performance is the prime criterion there.
> 
> It depends. If you just want to run MIPS Linux, yes.
> If you want to debug the kernel on a MIPS core with cache aliasing[*], no.

I wrote about qemu upstream's priorities.


Thiemo
