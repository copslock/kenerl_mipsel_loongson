Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1IFV8d01072
	for linux-mips-outgoing; Mon, 18 Feb 2002 07:31:08 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1IFV2901052
	for <linux-mips@oss.sgi.com>; Mon, 18 Feb 2002 07:31:03 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA18433;
	Mon, 18 Feb 2002 15:24:02 +0100 (MET)
Date: Mon, 18 Feb 2002 15:24:02 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Hartvig Ekner <hartvige@mips.com>
cc: Dominic Sweetman <dom@algor.co.uk>, "Kevin D. Kissell" <kevink@mips.com>,
   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, mdharm@momenco.com,
   ralf@uni-koblenz.de, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
In-Reply-To: <200202181252.NAA03169@copsun18.mips.com>
Message-ID: <Pine.GSO.3.96.1020218145911.13485I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 18 Feb 2002, Hartvig Ekner wrote:

> You are no doubt correct regarding the R4K manual - so my comment probably
> only applies for CPU's that claim to be MIPS32/MIPS64 compliant. All MTI's
> CPU offerings (cores only) do in fact flush the WB on a SYNC to comply with
> the current spec.

 Note that the MIPS II spec doesn't forbid a "sync" implementation to be
stronger than required.

> This I do have a problem understanding. If the SYNC does not flush the WB
> on some processor/writebuffer combinations, and a read can be satisfied
> out of the WB, how would you ever be able to guarantee that DMA data written
> by the CPU has reached memory before triggering the IO device?

 If after a "sync" an uncached read could be satisfied from an
uncommittedd write pending since before the "sync" in a CPU's oncore WB,
then the CPU would violate the MIPS II spec of "sync", as the order of
transactions at this CPU's external bus would not be preserved.  You may
exploit this property to do a write-back flush to the host bus -- that's
what I added iob() for.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
