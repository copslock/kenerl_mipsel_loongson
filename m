Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OF4URw020706
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 08:04:30 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OF4UZi020705
	for linux-mips-outgoing; Wed, 24 Jul 2002 08:04:30 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OF4LRw020689;
	Wed, 24 Jul 2002 08:04:22 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA00413;
	Wed, 24 Jul 2002 17:05:53 +0200 (MET DST)
Date: Wed, 24 Jul 2002 17:05:52 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: cpu_probe(): remove 32-bit CPU bits for MIPS64
In-Reply-To: <20020724165239.F28010@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020724165715.27732F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf,

> >  I don't think it's possible to be fully achieved.  Some differences will
> > have to exist, at least in the headers, but likely within the arch tree as
> > well.  The reason is binary code size or perfomance -- having R3000
> > support code in mips64 binaries is simply ridiculous as is using 32-bit
> > operations with 64-bit data on a 64-bit CPU.  However, it is worth trying
> > to minimize visible differences where possible, e.g. by convincing the
> > compiler to optimize irrelevant bits away.
> 
> In this particular case all the bloat is just in __init code, could that
> convince you?

 Nope, sorry.  I'm by all means for keeping any questionable but at least
remotely useful code under the __init justification.  But in this case,
the code will never, ever be used.

 As I stated, I'm going to look deeper at the issue.  Just let it exist as
is for now, until me (or someone else) invents an improvement.  To state
it explicitly: yes, I'm going to keep a single source for both paths and
convince the compiler somehow to rip unneeded bits in the 64-bit case.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
