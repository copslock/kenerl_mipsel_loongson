Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f36GnXO00679
	for linux-mips-outgoing; Fri, 6 Apr 2001 09:49:33 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f36Gm1M00630
	for <linux-mips@oss.sgi.com>; Fri, 6 Apr 2001 09:48:26 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA18959;
	Fri, 6 Apr 2001 18:40:10 +0200 (MET DST)
Date: Fri, 6 Apr 2001 18:40:10 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Florian Lohoff <flo@rfc822.org>, debian-mips@lists.debian.org,
   linux-mips@oss.sgi.com
Subject: Re: first packages for mipsel
In-Reply-To: <00a401c0be8e$cfc065a0$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010406182059.15958E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 6 Apr 2001, Kevin D. Kissell wrote:

> What advantage would there be to using sysmips() as opposed
> to doing the ll/sc emulation?  It seems to me that the decode path
> in the kernel would be just as fast, and there would be a single
> "ABI" for all programs - the ll/sc instructions themselves.

 It was discussed a few times already.  It's ugly and is an overkill for
UP machines -- you take at least two faults for ll/sc emulation and only a
single syscall for TAS. 

 Sysmips() is ugly as well but it's a legacy call -- I proposed
implementing _test_and_set() call which would be the underlying
implementation of the ABI _test_and_set() library call for MIPS I systems
(which should probably be the only atomic operation available to the
userland).  Unfortunately the lack of time prevents me from doing it. 

 At least _test_and_set() has well-defined semantics.  It looks
straightforward as well. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
