Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 12:55:00 +0000 (GMT)
Received: from p508B65B9.dip.t-dialin.net ([IPv6:::ffff:80.139.101.185]:59295
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225349AbTA1My7>; Tue, 28 Jan 2003 12:54:59 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0SCsrW32369;
	Tue, 28 Jan 2003 13:54:53 +0100
Date: Tue, 28 Jan 2003 13:54:53 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Mike Uhler <uhler@mips.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: unaligned load in branch delay slot
Message-ID: <20030128135453.B27977@linux-mips.org>
References: <20030128124750.A25956@linux-mips.org> <Pine.GSO.3.96.1030128130651.22934A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030128130651.22934A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jan 28, 2003 at 01:30:03PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 28, 2003 at 01:30:03PM +0100, Maciej W. Rozycki wrote:

>  Actually I have a datasheet for the Vr4121 (which is a Vr4120 plus some
> glue logic for specific peripherals) and it explicitly states whenever
> cp0.EPC points to a preceding branch/jump of a faulting instruction, the
> cp0.Cause.BD bit is set.  Maybe there is an errata sheet available.

Honestly I'd not expect this to be documented in a NEC manual - they
basically look like the description of the processor core is the same for
basically all the Vr4xxx processors and SOCs.

>  Additionally the processor is "nice" enough to implement the MIPS III ISA
> (with the MIPS16 extension) except ll/sc, lld/scd, sigh...  So the
> emulation would need to be ported to the 64-bit kernel if we were to
> support this processor in the 64-bit mode. 

Maximum agreement on the "sigh" part ...

  Ralf
