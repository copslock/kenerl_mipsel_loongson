Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4OB37N12389
	for linux-mips-outgoing; Thu, 24 May 2001 04:03:07 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4OB0NF12172
	for <linux-mips@oss.sgi.com>; Thu, 24 May 2001 04:00:25 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA10098;
	Thu, 24 May 2001 12:44:34 +0200 (MET DST)
Date: Thu, 24 May 2001 12:44:33 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Joe deBlaquiere <jadb@redhat.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <011501c0e3e3$007c4780$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010524113444.6990B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 24 May 2001, Kevin D. Kissell wrote:

> The problem is that, out in industry, not everyone wants to
> build their entire userland from source, and nobody particularly 
> wants to deal with  the product management problems of making, 
> maintaining,  testing, and distributing all the permutations of BE/LE, 
> FP/noFP, LLSC/noLLSC, etc, etc.

 First, we are talking about glibc and not the entire userland.  I insist
on having the performance-wise implementation in glibc.

 Second, do you expect everyone compiling the entire userland from
sources?  I don't.  The normal approach is to take a distribution and
build only these pieces which are not satisfying for one reason or
another.  Just take an ISA I, ISA II or whatever version you need.

 Third, an ISA-II-hosted glibc still contains an _test_and_set() function
which makes use of ll/sc, independently from an inlined version in a
header.

 Fourth, maintaining differently optimized distributions is not that
troublesome.  It's mostly a matter of disk space (which is hardly an issue
these days).  Once you have one version ready (prepared manually), all
others can be built automatically with no intervention.  With RPM it's as
easy as having different optflags settings in an rc file and having an
autobuilder perform the boring work.  It's not a theory, this is for
example how the PLD distribution is being developed -- see
http://www.pld.org.pl/ for details.  It just works.

 Fifth, I don't object having an ll/sc emulation per se -- as long as you
use the ABI-defined _test_and_set() function, everyone is free to
recompile sources to suite their needs. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
