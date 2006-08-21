Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2006 15:52:04 +0100 (BST)
Received: from p549F5B3A.dip.t-dialin.net ([84.159.91.58]:34771 "EHLO
	p549F5B3A.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20037541AbWHUOwC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 Aug 2006 15:52:02 +0100
Received: from witte.sonytel.be ([80.88.33.193]:16268 "EHLO witte.sonytel.be")
	by lappi.linux-mips.net with ESMTP id S1099327AbWHUOwA (ORCPT
	<rfc822;macro@linux-mips.org> + 1 other);
	Mon, 21 Aug 2006 16:52:00 +0200
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k7LEpfQe029603;
	Mon, 21 Aug 2006 16:51:41 +0200 (MEST)
Date:	Mon, 21 Aug 2006 16:51:40 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, macro@linux-mips.org,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] qemu does not have dcache aliases
In-Reply-To: <20060821144605.GA19032@linux-mips.org>
Message-ID: <Pine.LNX.4.62.0608211651010.6328@pademelon.sonytel.be>
References: <20060820.003338.25478178.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64N.0608211340120.17504@blysk.ds.pg.gda.pl>
 <20060821.225910.108307053.anemo@mba.ocn.ne.jp> <20060821144605.GA19032@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 21 Aug 2006, Ralf Baechle wrote:
> On Mon, Aug 21, 2006 at 10:59:10PM +0900, Atsushi Nemoto wrote:
> > On Mon, 21 Aug 2006 13:45:03 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > >  Hmm, it looks like a bug in QEMU -- we should definitely implement them!
> > 
> > Well, the QEMU cpu has 2-way 2kB dcache... does not have aliasing
> > anyway. :-)
> > 
> > Or we can just remove cpu_has_dc_aliases from the file and use generic
> > definition.
> 
> The CPU emulated by Qemu might change eventually so I think this is
> preferable.

Or become fully configurable, to make it match every single MIPS core ever
build?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
