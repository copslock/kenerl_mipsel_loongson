Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1IDrNM27233
	for linux-mips-outgoing; Mon, 18 Feb 2002 05:53:23 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1IDrG927229
	for <linux-mips@oss.sgi.com>; Mon, 18 Feb 2002 05:53:16 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA12886;
	Mon, 18 Feb 2002 04:53:08 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA04156;
	Mon, 18 Feb 2002 04:53:04 -0800 (PST)
Received: from copsun18.mips.com (copsun18 [192.168.205.28])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g1ICqKA23120;
	Mon, 18 Feb 2002 13:52:20 +0100 (MET)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun18.mips.com (8.9.1/8.9.0) id NAA03169;
	Mon, 18 Feb 2002 13:52:47 +0100 (MET)
Message-Id: <200202181252.NAA03169@copsun18.mips.com>
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Mon, 18 Feb 2002 13:52:47 +0100 (MET)
Cc: hartvige@mips.com (Hartvig Ekner), dom@algor.co.uk (Dominic Sweetman),
   kevink@mips.com (Kevin D. Kissell),
   nemoto@toshiba-tops.co.jp (Atsushi Nemoto), mdharm@momenco.com,
   ralf@uni-koblenz.de, linux-mips@fnet.fr, linux-mips@oss.sgi.com
In-Reply-To: <Pine.GSO.3.96.1020215135427.29773F-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Feb 15, 2002 02:03:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Maciej W. Rozycki writes:
> 
> On Fri, 15 Feb 2002, Hartvig Ekner wrote:
> 
> > But in-order for the CPU is not enough - it also needs to make sure all
> > written data is visible for DMA accesses to memory from the outside, which
> > is why the writebuffer needs to be flushed by a SYNC as well. From the
> > definition of "SYNC":
> > 
> > 	"A store is completed when the stored value is visible to every other
> > 	processor in the system". 
> > 
> > Which presumably also includes DMA I/O devices...
> 
>  The description found in the R4k manual seems to contradict.  A "sync" on
> a single CPU only assures transactions on it's external bus will happen in
> order wrt the "sync".  In a multiple-CPU environment all CPUs interested
> in a barrier need to execute a "sync".  That's seems natural -- how would 
> you define a synchronization point for a CPU that does not execute a
> "sync".

You are no doubt correct regarding the R4K manual - so my comment probably
only applies for CPU's that claim to be MIPS32/MIPS64 compliant. All MTI's
CPU offerings (cores only) do in fact flush the WB on a SYNC to comply with
the current spec.

>  Since I/O devices have no means to signal a CPU a "sync" operation, how
> can you expect a "sync" on the CPU to complete all preceding writes to the
> device?  It's only a following read that may imply it.

This I do have a problem understanding. If the SYNC does not flush the WB
on some processor/writebuffer combinations, and a read can be satisfied
out of the WB, how would you ever be able to guarantee that DMA data written
by the CPU has reached memory before triggering the IO device?

/Hartvig

> 
> -- 
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
> 
> 


-- 
 _    _   _____  ____     Hartvig Ekner        Mailto:hartvige@mips.com
 |\  /| | |____)(____                          Direct: +45 4486 5503
 | \/ | | |     _____)    MIPS Denmark         Switch: +45 4486 5555
T E C H N O L O G I E S   http://www.mips.com  Fax...: +45 4486 5556
