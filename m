Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1LFFXs23234
	for linux-mips-outgoing; Thu, 21 Feb 2002 07:15:33 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1LFFJ923079
	for <linux-mips@oss.sgi.com>; Thu, 21 Feb 2002 07:15:22 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA08434;
	Thu, 21 Feb 2002 15:12:44 +0100 (MET)
Date: Thu, 21 Feb 2002 15:12:43 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
cc: kevink@mips.com, mdharm@momenco.com, ralf@uni-koblenz.de,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
In-Reply-To: <20020221.204120.102764790.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.GSO.3.96.1020221143103.1033G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 21 Feb 2002, Atsushi Nemoto wrote:

> TX39 satisfy this on uncached load/store.  "sync" does not flush a
> write buffer, but any uncached load are executed AFTER completion of
> pending uncached store.  On combination of cached and uncached
> operation, TX39 does not satisfy this order.

 With respect to cache refills (what is already cached is irrelevant,
obviously, as read accesse to it don't appear externally), "32-bit RISC
Microprocessor TX39 Family Core Architecture User's Manual" seems to
contradict.  In the description of the "sync" instruction it states: 

"Interlocks the pipeline until the load, store or data cache refill
operation of the previous instruction is completed.  The R3900 Processor
Core can continue processing instructions following a load instruction
even if a cache refill is caused by the load instruction or a load is made
from a noncacheable area.  Executing a SYNC instruction interlocks
subsequent instructions until the SYNC instruction execution is completed.
This ensures that the instructions following a load instruction are
executed in the proper sequence."

It's clear "sync" is strong on the TX39, stronger then required by MIPS
II. 

> TX39 has a function called "non-blocking load".  This function is
> described on chapter 4.4 of TX39/H2 manual.  "sync" operation is
> meaningful with this function.

 Chapter 4.3 ("") of the quoted manual.  The statement I quoted assures
it,
indeed (modulo errata, which hopefully don't exist here). 

> Chapter 4.9.4 in TX39/H2 Japanese manual describes write buffer.  But
> I could not find it in the English manual...

 The write buffer is described in the part about "TMPR3901F" (it appears
two manuals are concatenated in a single file), chapter 2.3 ("Bus
Interface Unit (Bus Controller / Write Buffer)").  It looks like a "bc0f" 
loop is needed for mb().  The only difference comparing to R2020/R3220 is
only a single "nop" is needed after a write for the coprocessor status to
become valid, it would seem.  It's not documented explicitly but the
supplied example code suggests so. 

 The document I'm referring to is available at: 
"http:/pdf.toshiba.com/taec/components/Generic/TX39_Core_um.pdf". 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
