Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g54IrOnC003742
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 4 Jun 2002 11:53:24 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g54IrO5I003741
	for linux-mips-outgoing; Tue, 4 Jun 2002 11:53:24 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g54IrEnC003736
	for <linux-mips@oss.sgi.com>; Tue, 4 Jun 2002 11:53:15 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA25734;
	Tue, 4 Jun 2002 20:55:20 +0200 (MET DST)
Date: Tue, 4 Jun 2002 20:55:20 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: mb() and friends again
In-Reply-To: <3CFCFC79.E846226B@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1020604201917.17556M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 4 Jun 2002, Gleb O. Raiko wrote:

> Basically, the patch logically allows combination of a CPU with internal
> write-buffer and an external wb chip. It's impossible if hw designers
> don't smoke hard. :-)

 Well, I believe it might be useful -- if a CPU uses a higher clock for
its pipeline and a lower one for its external bus, it might be useful to
buffer a few words internally to avoid stalls at two consecutive writes.
Then you may have an additional buffer externally to lower the number of
stalls on memory or I/O (generally the rest of a system) accesses.
Essentially a buffer every time you cross a frequency domains' border,
leaving the faster one.  You need at least a single-word buffer at each
such border anyway if you don't want to stall the whole system for any
cycle accessing slower domains. 

 Consider it a complement of a hierarchical cache organization -- I've
seen (and actually used) systems with up to three levels of caches. 

> In fact, CONFIG_CPU_HAS_WB means !CONFIG_CPU_HAS_WB, i.e. CPU don't have
> built-in write-buffer logic and there is an external write-buffer chip
> somewhere in the box.
> ("Somewhere" means a place on the path from the local bus to a memory
> controller.)

 That's a bit awkward possibly, but "has" has a wide meaning and does not
necessarily state "contains".  It might mean "owns" as well.  For R[23]k
CPUs the option originally corresponded to external R2020 and R3220 chips
(just like floating point units may be external but still be considered a
part of a CPU) that were treated as a part of coprocessor 0 (with "bc0f"
or "bc0t" instructions testing their state). 

 Besides, who says discrete CPUs are forbidden? ;-)

> Then, __fast_iob just flushes internal wb while wbflush flushes an
> external wb.

 Well, that's used by __wbflush internally if it knows there is no
external buffer that needs explicit handling (for the DECstation, at least
-- other systems might make use of it as well).  That's unused in this
patch but is needed in the other one -- well, I had to split these patches
logically somehow and this one only contains system-independent code.

> That's why I call it "unusual terms from hw POV". 

 Hopefully, I clarified the terms a bit.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
