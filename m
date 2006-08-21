Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2006 16:37:44 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:54145 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20037562AbWHUPhm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2006 16:37:42 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 37D234668F; Mon, 21 Aug 2006 17:37:44 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1GFBp2-0006V3-PO; Mon, 21 Aug 2006 16:36:16 +0100
Date:	Mon, 21 Aug 2006 16:36:16 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] qemu does not have dcache aliases
Message-ID: <20060821153616.GC20395@networkno.de>
References: <20060820.003338.25478178.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0608211340120.17504@blysk.ds.pg.gda.pl> <20060821.225910.108307053.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0608211612090.17504@blysk.ds.pg.gda.pl> <20060821152657.GB19600@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821152657.GB19600@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Aug 21, 2006 at 04:16:21PM +0100, Maciej W. Rozycki wrote:
> 
> > > Well, the QEMU cpu has 2-way 2kB dcache... does not have aliasing
> > > anyway. :-)
> > 
> >  I don't think emulating a bigger cache so that we can add aliases should 
> > be *that* difficult.  Adding aliases themselves might be a bit trickier, 
> > but the gain would certainly justify the hassle, wouldn't it?
> 
> The cache lookup for every access would have serious impact on performance.
> The question is, is it worth the price?  Would such patches be acceptable
> by the upstream qemu maintainers?

Likely not, given that performance is the prime criterion there.


Thiemo
