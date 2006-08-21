Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2006 16:43:33 +0100 (BST)
Received: from witte.sonytel.be ([80.88.33.193]:33688 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S20038567AbWHUPnb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2006 16:43:31 +0100
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k7LFhUQe001651;
	Mon, 21 Aug 2006 17:43:30 +0200 (MEST)
Date:	Mon, 21 Aug 2006 17:43:29 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Thiemo Seufer <ths@networkno.de>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] qemu does not have dcache aliases
In-Reply-To: <20060821153616.GC20395@networkno.de>
Message-ID: <Pine.LNX.4.62.0608211741580.6328@pademelon.sonytel.be>
References: <20060820.003338.25478178.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64N.0608211340120.17504@blysk.ds.pg.gda.pl>
 <20060821.225910.108307053.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64N.0608211612090.17504@blysk.ds.pg.gda.pl>
 <20060821152657.GB19600@linux-mips.org> <20060821153616.GC20395@networkno.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 21 Aug 2006, Thiemo Seufer wrote:
> Ralf Baechle wrote:
> > On Mon, Aug 21, 2006 at 04:16:21PM +0100, Maciej W. Rozycki wrote:
> > 
> > > > Well, the QEMU cpu has 2-way 2kB dcache... does not have aliasing
> > > > anyway. :-)
> > > 
> > >  I don't think emulating a bigger cache so that we can add aliases should 
> > > be *that* difficult.  Adding aliases themselves might be a bit trickier, 
> > > but the gain would certainly justify the hassle, wouldn't it?
> > 
> > The cache lookup for every access would have serious impact on performance.
> > The question is, is it worth the price?  Would such patches be acceptable
> > by the upstream qemu maintainers?
> 
> Likely not, given that performance is the prime criterion there.

It depends. If you just want to run MIPS Linux, yes.
If you want to debug the kernel on a MIPS core with cache aliasing[*], no.

[*] Replace with whatever slow-to-emulate and hard-to-debug feature.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
