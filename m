Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6ND4TRw025890
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Jul 2002 06:04:29 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6ND4TeY025889
	for linux-mips-outgoing; Tue, 23 Jul 2002 06:04:29 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6ND4LRw025880;
	Tue, 23 Jul 2002 06:04:22 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA28389;
	Tue, 23 Jul 2002 15:05:48 +0200 (MET DST)
Date: Tue, 23 Jul 2002 15:05:47 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux: cpu_probe(): remove 32-bit CPU bits for MIPS64
In-Reply-To: <20020723141407.B10566@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020723144023.26569B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 23 Jul 2002, Ralf Baechle wrote:

> I intentionally have that 32-bit stuff in the 64-bit kernel so we can simply
> have share identical CPU probing code between the 32-bit and 64-bit kernels.
> This in anticipation of a further unification of the two ports which still
> duplicate plenty of code with just minor changes.

 I suspected a maintability reason.  Thus as a temporary fix I'm checking
in a version that provides the missing cpu_has_fpu() function (a copy
from the trunk).

> To make sharing easier I suggest to move all the CPU probing code into it's
> own file, probe.c or so?

 That might be a good idea in principle, but it won't solve the problem
anyway.  I'd like to see the code for 32-bit processors get annihilated by
the compiler if built for mips64.  I'll look at it soon.  The MIPS32/64
crap needs to be fixed here as well.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
