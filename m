Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jun 2004 01:15:45 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:31473 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225260AbUF3APk>;
	Wed, 30 Jun 2004 01:15:40 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i5U0Fb4O011144;
	Tue, 29 Jun 2004 17:15:37 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i5U0Fbnq011143;
	Tue, 29 Jun 2004 17:15:37 -0700
Date: Tue, 29 Jun 2004 17:15:37 -0700
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	jsun@mvista.com
Subject: Re: [patch] Incorrect mapping of serial ports to lines
Message-ID: <20040629171537.F6498@mvista.com>
References: <Pine.LNX.4.55.0406281513120.23162@jurand.ds.pg.gda.pl> <20040628235908.GC5736@linux-mips.org> <Pine.LNX.4.55.0406291345590.31801@jurand.ds.pg.gda.pl> <Pine.GSO.4.58.0406291408020.29058@waterleaf.sonytel.be> <Pine.LNX.4.55.0406291546480.31801@jurand.ds.pg.gda.pl> <20040629151313.E6498@mvista.com> <20040629224932.GA10375@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040629224932.GA10375@linux-mips.org>; from ralf@linux-mips.org on Wed, Jun 30, 2004 at 12:49:32AM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Jun 30, 2004 at 12:49:32AM +0200, Ralf Baechle wrote:
> On Tue, Jun 29, 2004 at 03:13:13PM -0700, Jun Sun wrote:
> 
> > > > The NEC DDB Vrc-5074 (and probably the other DDB variants as well) has one
> > > > serial port in the Nile 4 host bridge, and 2 serial ports in the Super I/O.
> > > > 
> > > > To me it sounds the most logical if the one in the Nile 4 is ttyS0.
> > > 
> > >  Then we need to find a way to make the order configurable somehow.
> > 
> > This is why I favor run-time serial port configuration.  My view
> > (maybe a little dramatic) is to remove all static serial port definition
> > and push them into board setup routine.  asm/serial.h only needs
> > to define the number serial lines, which itself could be configurable.
> 
> <asm/serial.h> is on it's way out of the kernel - it's only a question of
> time until either the current maintainer of the serial driver or somebody
> with more time at hands will eleminate it.  And serial.h was always only
> meant to handle the kind of serial interfaces of which you just have to
> know that they're there because probing for it isn't possible.  Something
> which these days is getting increasingly more rare thanks to PCI.
> 
> What I really wouldn't like to see is the runtime registration for all
> the legacy serial stuff that possibly could be plugged into some board
> be duplicated into half a dozen of systems ...
> 

No fear really.  You can still provide STD_SERIAL_PORT in the asm/serial.h
where each individual board simply does a registration for each line
defined there.  You might even provide some inline function for 
doing so in asm/serial.h.

The big advantage of this scheme is that the board-level complexity is not 
exposed to MIPS arch layer.  So when it is time for a board to die, one
does not have to clean up a dozen or so common files like asm/serial.h file.

Of course it also offers complete control over the ordering of serial
ports to the board.

See arch/mips/vr4181/common/serial.c for a simple example of run-time
registeration.  I believe a couple of other boards are doing this too.

Jun
