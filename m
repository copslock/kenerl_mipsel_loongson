Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jun 2004 00:59:14 +0100 (BST)
Received: from p508B7E89.dip.t-dialin.net ([IPv6:::ffff:80.139.126.137]:13334
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224914AbUF1X7J>; Tue, 29 Jun 2004 00:59:09 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i5SNx8n8007443;
	Tue, 29 Jun 2004 01:59:08 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i5SNx8D0007442;
	Tue, 29 Jun 2004 01:59:08 +0200
Date: Tue, 29 Jun 2004 01:59:08 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] Incorrect mapping of serial ports to lines
Message-ID: <20040628235908.GC5736@linux-mips.org>
References: <Pine.LNX.4.55.0406281513120.23162@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0406281513120.23162@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 28, 2004 at 03:25:04PM +0200, Maciej W. Rozycki wrote:

>  Onboard PC-compatible serial ports of the 8250 family are expected to be
> assigned to lines 0 - 3.  Unfortunately for MIPS this is not guaranteed as
> EXTRA_SERIAL_PORT_DEFNS and HUB6_SERIAL_PORT_DFNS precede
> STD_SERIAL_PORT_DEFNS on the port list and their definitions change
> depending on CONFIG_SERIAL_MANY_PORTS and CONFIG_HUB6 which are user
> settable.  As a result, they may get different assignments depending on
> configuration -- e.g. my last build for the Malta board resulted in its
> onboard ports being assigned to lines 28 and 29.
> 
>  This can be fixed with a correct ordering of entries on the port list, 
> like the following.  OK to apply?

Yep, having STD_SERIAL_PORT_DEFNS after EXTRA_SERIAL_PORT_DEFNS was
unintentional.  The idea was to have to have all the system-specific at
the start of the list or we get fun on all system that may have on-board
serials which should receive the lowest numbers and any (E)ISA serial cards
at the end, so my suggestion for fixing this would look a little different:

#define SERIAL_PORT_DFNS                                \
        COBALT_SERIAL_PORT_DEFNS                        \
        DDB5477_SERIAL_PORT_DEFNS                       \
        EV96100_SERIAL_PORT_DEFNS                       \
        IP32_SERIAL_PORT_DEFNS                          \
        ITE_SERIAL_PORT_DEFNS                           \
        IVR_SERIAL_PORT_DEFNS                           \
        JAZZ_SERIAL_PORT_DEFNS                          \
        MOMENCO_OCELOT_G_SERIAL_PORT_DEFNS              \
        MOMENCO_OCELOT_C_SERIAL_PORT_DEFNS              \
        MOMENCO_OCELOT_SERIAL_PORT_DEFNS                \
        TXX927_SERIAL_PORT_DEFNS                        \
        AU1000_SERIAL_PORT_DEFNS			\
							\
        STD_SERIAL_PORT_DEFNS                           \
	EXTRA_SERIAL_PORT_DEFNS				\
        HUB6_SERIAL_PORT_DFNS                           \

Comments?

 Ralf
