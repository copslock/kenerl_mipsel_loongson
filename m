Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g71G3LRw006383
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 1 Aug 2002 09:03:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g71G3LNe006382
	for linux-mips-outgoing; Thu, 1 Aug 2002 09:03:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g71G3ARw006373;
	Thu, 1 Aug 2002 09:03:11 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA09605;
	Thu, 1 Aug 2002 18:05:17 +0200 (MET DST)
Date: Thu, 1 Aug 2002 18:05:17 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [update] [patch] linux: Cache coherency fixes
In-Reply-To: <20020801152500.A31808@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020801173504.8256H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 1 Aug 2002, Ralf Baechle wrote:

> Looks mostly right except that the code in config-shared.in which deciedes
> if a system is coherent is wrong.  Basically it assumes every R10000 or
> every uniprocessor system is non-coherent and that's wrong.  As coherency
> between CPUs and for DMA I/O is basically the same thing I've changed your
> code from the use of CONFIG_CPU_CACHE_COHERENCY to CONFIG_NONCOHERENT_IO
> which did already exist; I don't think we need another config symbol to
> handle this.  Will apply once I did a few test builds and patches the
> whole thing into 2.5 ...

 Huh?  Coherent caching mode can be used for a few processors only, namely
R4[04]00MC and presumably SB1 (inferred from the sources), i.e. the ones
that support the interprocessor coherency protocol.  If you know of any
other processor that supports the protocol, I'd be pleased to see a
reference to a spec -- I hoped someone, possibly you, would fill the
missing bits when I proposed the patch a month ago.  Nobody bothered,
though, sigh...

 I see your changes are broken conceptually, as the caching mode for the
TLB should be inferred from the CPU configuration in the first place and
not the system selection (actually it should be best selected ath the run
time).  Hence I'd invert the flag, since most systems are non-coherent,
and only permit it for certain processors.  Using a non-coherent
configuration for an UP system that supports coherency (do SGI IP27 and
SiByte SB1250 have another agent in the chipset that may issue coherent
requests regardless of the number of processors started?) results in a
performance hit only due to superfluous invalidations, but using a
coherent configuration for a processor/system that doesn't support it may
lead to a hard to debug hang with no apparent reason (as I wrote
previously, even NMI/Reset stopped working on my system -- I had to hit
the power switch). 

 I'll cook another patch to fix what got broken.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
