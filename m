Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FEE5S18402
	for linux-mips-outgoing; Fri, 15 Feb 2002 06:14:05 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FEDa918388
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 06:13:49 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA02690;
	Fri, 15 Feb 2002 14:03:45 +0100 (MET)
Date: Fri, 15 Feb 2002 14:03:45 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Hartvig Ekner <hartvige@mips.com>
cc: Dominic Sweetman <dom@algor.co.uk>, "Kevin D. Kissell" <kevink@mips.com>,
   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, mdharm@momenco.com,
   ralf@uni-koblenz.de, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
In-Reply-To: <200202151205.NAA25636@copsun18.mips.com>
Message-ID: <Pine.GSO.3.96.1020215135427.29773F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 15 Feb 2002, Hartvig Ekner wrote:

> But in-order for the CPU is not enough - it also needs to make sure all
> written data is visible for DMA accesses to memory from the outside, which
> is why the writebuffer needs to be flushed by a SYNC as well. From the
> definition of "SYNC":
> 
> 	"A store is completed when the stored value is visible to every other
> 	processor in the system". 
> 
> Which presumably also includes DMA I/O devices...

 The description found in the R4k manual seems to contradict.  A "sync" on
a single CPU only assures transactions on it's external bus will happen in
order wrt the "sync".  In a multiple-CPU environment all CPUs interested
in a barrier need to execute a "sync".  That's seems natural -- how would 
you define a synchronization point for a CPU that does not execute a
"sync".

 Since I/O devices have no means to signal a CPU a "sync" operation, how
can you expect a "sync" on the CPU to complete all preceding writes to the
device?  It's only a following read that may imply it.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
