Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KF5DEC029678
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 08:05:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KF5DUQ029677
	for linux-mips-outgoing; Tue, 20 Aug 2002 08:05:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KF54EC029666
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 08:05:06 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA13956;
	Tue, 20 Aug 2002 17:08:20 +0200 (MET DST)
Date: Tue, 20 Aug 2002 17:08:20 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Daniel Jacobowitz <dan@debian.org>, linux-mips@oss.sgi.com
Subject: Re: New binutils for kernel
In-Reply-To: <20020820165835.B26852@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1020820170025.8700L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 20 Aug 2002, Ralf Baechle wrote:

> > Well, I think 2.13's a good idea, but it's very new.  I'd say that was
> > acceptable as long as you're looking at MIPS64 only, not at MIPS32. 
> 
> Such considerations have kept us back at antique levels of binutils.  And
> juggling with several different versions for userland, and two kernel
> flavours is evil ...

 Any version since 2.11, possibly older, should work just fine for 32-bit
MIPS.  I don't think there are any significant interface changes between
2.11 and 2.13, so if 2.13 works then 2.11 will not bail out either.  Thus
there is no need to force 2.13 for 32-bit MIPS, but I think it is
acceptable to stop caring about versions older than 2.11 in the nearby
future.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
