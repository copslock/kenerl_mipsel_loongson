Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NJrrC20719
	for linux-mips-outgoing; Wed, 23 May 2001 12:53:53 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NJmIF20413
	for <linux-mips@oss.sgi.com>; Wed, 23 May 2001 12:48:36 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA17299;
	Wed, 23 May 2001 21:37:18 +0200 (MET DST)
Date: Wed, 23 May 2001 21:37:18 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Joe deBlaquiere <jadb@redhat.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <00ec01c0e3b5$00ab83c0$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010523212941.16787A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 23 May 2001, Kevin D. Kissell wrote:

> parts, the latter is more efficient for contemporary parts.  Those
> of us who work on recent and future designs will always tend
> to favor the latter - what's the point of using MIPS32/MIPS64
> and beyond CPUs if gnu/Linux binaries are going to treat them
> like R3000s?

 If you work on new processors only, then there is no problem.  You
configure your tools to build binaries for systems you use and you'll
never see R3k compatibility code.

 Please do yourself a favor and look at the relevant part of glibc.  If
you build glibc (and any other other program that makes use of
_test_and_set()) for ISA II+, the code gets actually inlined with ll/sc
used as expected.

 So the problem is?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
