Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jun 2004 12:57:45 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:35221 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225203AbUF2L5l>; Tue, 29 Jun 2004 12:57:41 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 5DB37475C1; Tue, 29 Jun 2004 13:57:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 4AAF7474EF; Tue, 29 Jun 2004 13:57:34 +0200 (CEST)
Date: Tue, 29 Jun 2004 13:57:34 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] Incorrect mapping of serial ports to lines
In-Reply-To: <20040628235908.GC5736@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0406291345590.31801@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0406281513120.23162@jurand.ds.pg.gda.pl>
 <20040628235908.GC5736@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 29 Jun 2004, Ralf Baechle wrote:

> Yep, having STD_SERIAL_PORT_DEFNS after EXTRA_SERIAL_PORT_DEFNS was
> unintentional.  The idea was to have to have all the system-specific at
> the start of the list or we get fun on all system that may have on-board
> serials which should receive the lowest numbers and any (E)ISA serial cards
> at the end, so my suggestion for fixing this would look a little different:
> 
> #define SERIAL_PORT_DFNS                                \
>         COBALT_SERIAL_PORT_DEFNS                        \
>         DDB5477_SERIAL_PORT_DEFNS                       \
>         EV96100_SERIAL_PORT_DEFNS                       \
>         IP32_SERIAL_PORT_DEFNS                          \
>         ITE_SERIAL_PORT_DEFNS                           \
>         IVR_SERIAL_PORT_DEFNS                           \
>         JAZZ_SERIAL_PORT_DEFNS                          \
>         MOMENCO_OCELOT_G_SERIAL_PORT_DEFNS              \
>         MOMENCO_OCELOT_C_SERIAL_PORT_DEFNS              \
>         MOMENCO_OCELOT_SERIAL_PORT_DEFNS                \
>         TXX927_SERIAL_PORT_DEFNS                        \
>         AU1000_SERIAL_PORT_DEFNS			\

 Hmm, why is Au1000 at the end -- does the system have others from the
list above, too?

 Also you've removed a few system-specific ports -- why?

> 							\
>         STD_SERIAL_PORT_DEFNS                           \
> 	EXTRA_SERIAL_PORT_DEFNS				\
>         HUB6_SERIAL_PORT_DFNS                           \
> 
> Comments?

 That's a bit troublesome for the Malta board which has both a pair of
PC-compatible serial ports which are expected to be lines 0 and 1 and an
Atlas serial port, which is expected to be line 2.  The Atlas port on the
Malta board isn't handled by Linux right now, but I plan to fix it.  Are
there systems that have both PC-compatible ports and system-specific ones
and expect them to be mapped in the reverse order?

 AFAIK, PC-compatible serial ports on PCI cards get mapped dynamically to
lines above this standard list.  I don't know about EISA boards, but it
would be consistent to handle them the same way, i.e. I'd propose to fix
the driver in this case.

  Maciej
