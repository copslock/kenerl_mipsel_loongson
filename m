Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jun 2004 23:49:39 +0100 (BST)
Received: from p508B7BFA.dip.t-dialin.net ([IPv6:::ffff:80.139.123.250]:35877
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225800AbUF2Wtf>; Tue, 29 Jun 2004 23:49:35 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i5TMnXO5011398;
	Wed, 30 Jun 2004 00:49:33 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i5TMnWFC011397;
	Wed, 30 Jun 2004 00:49:32 +0200
Date: Wed, 30 Jun 2004 00:49:32 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [patch] Incorrect mapping of serial ports to lines
Message-ID: <20040629224932.GA10375@linux-mips.org>
References: <Pine.LNX.4.55.0406281513120.23162@jurand.ds.pg.gda.pl> <20040628235908.GC5736@linux-mips.org> <Pine.LNX.4.55.0406291345590.31801@jurand.ds.pg.gda.pl> <Pine.GSO.4.58.0406291408020.29058@waterleaf.sonytel.be> <Pine.LNX.4.55.0406291546480.31801@jurand.ds.pg.gda.pl> <20040629151313.E6498@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040629151313.E6498@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 29, 2004 at 03:13:13PM -0700, Jun Sun wrote:

> > > The NEC DDB Vrc-5074 (and probably the other DDB variants as well) has one
> > > serial port in the Nile 4 host bridge, and 2 serial ports in the Super I/O.
> > > 
> > > To me it sounds the most logical if the one in the Nile 4 is ttyS0.
> > 
> >  Then we need to find a way to make the order configurable somehow.
> 
> This is why I favor run-time serial port configuration.  My view
> (maybe a little dramatic) is to remove all static serial port definition
> and push them into board setup routine.  asm/serial.h only needs
> to define the number serial lines, which itself could be configurable.

<asm/serial.h> is on it's way out of the kernel - it's only a question of
time until either the current maintainer of the serial driver or somebody
with more time at hands will eleminate it.  And serial.h was always only
meant to handle the kind of serial interfaces of which you just have to
know that they're there because probing for it isn't possible.  Something
which these days is getting increasingly more rare thanks to PCI.

What I really wouldn't like to see is the runtime registration for all
the legacy serial stuff that possibly could be plugged into some board
be duplicated into half a dozen of systems ...

  Ralf
