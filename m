Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 12:29:52 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:29163 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225349AbTA1M3w>; Tue, 28 Jan 2003 12:29:52 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA23653;
	Tue, 28 Jan 2003 13:30:03 +0100 (MET)
Date: Tue, 28 Jan 2003 13:30:03 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Mike Uhler <uhler@mips.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: unaligned load in branch delay slot
In-Reply-To: <20030128124750.A25956@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030128130651.22934A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 28 Jan 2003, Ralf Baechle wrote:

> Hmm...  If you can't reproduce this anymore I guess we should pull this
> patch again?  Despite Mike basically acknowledging that such behaviour
> exists I don't feel to well about applying patches for non-reproducable
> processor behaviour and would rather prefer to wait until we believe to
> know the full details.

 Agreed, and I believe a run-time check would be better (and trivial as
well).  The (!MIPS32 && !MIPS64) approximation is too rough.

> > I think you can remove the unconditional jumps, cfr. Mike's comments.
> 
> That's one of the points where I felt a bit unsafe about the extend of
> the issue so I left the jumps in.  Anyway, why should it make a difference
> if an instruction is conditional or not?

 I think jumps cannot be non-taken... 

> > Isn't the Vr4120A core MIPS32?
> 
> Vr4120 is MIPS III.

 Actually I have a datasheet for the Vr4121 (which is a Vr4120 plus some
glue logic for specific peripherals) and it explicitly states whenever
cp0.EPC points to a preceding branch/jump of a faulting instruction, the
cp0.Cause.BD bit is set.  Maybe there is an errata sheet available.

 Additionally the processor is "nice" enough to implement the MIPS III ISA
(with the MIPS16 extension) except ll/sc, lld/scd, sigh...  So the
emulation would need to be ported to the 64-bit kernel if we were to
support this processor in the 64-bit mode. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
