Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQD8Fq23017
	for linux-mips-outgoing; Mon, 26 Nov 2001 05:08:15 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQD7io22997;
	Mon, 26 Nov 2001 05:07:47 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA25196;
	Mon, 26 Nov 2001 13:06:28 +0100 (MET)
Date: Mon, 26 Nov 2001 13:06:26 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Andre.Messerschmidt@infineon.com, linux-mips@oss.sgi.com
Subject: Re: Cross Compiler again
In-Reply-To: <20011126222855.D30436@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1011126130046.21598E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 26 Nov 2001, Ralf Baechle wrote:

> General rule for the kernel is don't use gcc 3.x.  It's not only buggier
> than the older compilers, it also produces worse code.  In particular it's
> know to misscompile certain drivers on other architectures.  I'm still
> using egcs 1.1.2 which is known to be a very solid compiler.  That may seem
> to be a bit overly conservative to some; for those I recommend a compiler
> derived from 2.95.3.

 I'll just add that I'm particularly happy with 2.95.3 with a set of
patches.  I'm using it for one about year and a half now (it was 2.95.2
then, but MIPS changes are the same) and the last fix I made was in April. 
No problems since then both for the kernel and the userland.  The C++
backend is unchecked, though.  An RPM package is available at
'ftp://ftp.ds2.pg.gda.pl/pub/macro/'; you may extract patches and build it
manually if you don't use RPM. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
