Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jun 2004 23:13:26 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:56307 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225800AbUF2WNW>;
	Tue, 29 Jun 2004 23:13:22 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i5TMDE4O010296;
	Tue, 29 Jun 2004 15:13:14 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i5TMDDjY010295;
	Tue, 29 Jun 2004 15:13:13 -0700
Date: Tue, 29 Jun 2004 15:13:13 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	jsun@mvista.com
Subject: Re: [patch] Incorrect mapping of serial ports to lines
Message-ID: <20040629151313.E6498@mvista.com>
References: <Pine.LNX.4.55.0406281513120.23162@jurand.ds.pg.gda.pl> <20040628235908.GC5736@linux-mips.org> <Pine.LNX.4.55.0406291345590.31801@jurand.ds.pg.gda.pl> <Pine.GSO.4.58.0406291408020.29058@waterleaf.sonytel.be> <Pine.LNX.4.55.0406291546480.31801@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.55.0406291546480.31801@jurand.ds.pg.gda.pl>; from macro@linux-mips.org on Tue, Jun 29, 2004 at 03:49:11PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Jun 29, 2004 at 03:49:11PM +0200, Maciej W. Rozycki wrote:
> On Tue, 29 Jun 2004, Geert Uytterhoeven wrote:
> 
> > The NEC DDB Vrc-5074 (and probably the other DDB variants as well) has one
> > serial port in the Nile 4 host bridge, and 2 serial ports in the Super I/O.
> > 
> > To me it sounds the most logical if the one in the Nile 4 is ttyS0.
> 
>  Then we need to find a way to make the order configurable somehow.

This is why I favor run-time serial port configuration.  My view
(maybe a little dramatic) is to remove all static serial port definition
and push them into board setup routine.  asm/serial.h only needs
to define the number serial lines, which itself could be configurable.

Jun
