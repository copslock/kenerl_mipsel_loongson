Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0ICGfg19739
	for linux-mips-outgoing; Fri, 18 Jan 2002 04:16:41 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0ICGSP19736;
	Fri, 18 Jan 2002 04:16:29 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA16818;
	Fri, 18 Jan 2002 12:16:16 +0100 (MET)
Date: Fri, 18 Jan 2002 12:16:14 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: IDE driver broken in bigendian 2.4.17 kernel
In-Reply-To: <3C472F60.E5B62F0C@mips.com>
Message-ID: <Pine.GSO.3.96.1020118115218.16009A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 17 Jan 2002, Carsten Langgaard wrote:

> The order of header inclusions doesn't matter, because the ide.h file include the
> io.h file, and that way io.h always get include first.
> The '#ifndef' in all header file makes sure it only get included once.

 Then it's partially safe -- the definition used still depends on whether
some code includes ide.h or not.

> >  If the problem is generic to a chipset, then you indeed need to redefine
> > I/O macros, but then in <asm/io.h>.  If that's PCI-specific, for example,
> > then you should probably make the redefinition conditional on CONFIG_PCI.
> 
> I'm not in a position, where I can fix and not at least test the changes, that it
> needed in both the IDE driver as well as in all the other bigendian architectures
> ide.h files.

 Nobody expects you to test changes on every possible system in existence. 
Just try to handle whatever you anticipate and let people test the
changes.  You can read the code and see what others expect from it -- most
likely that will be accurate or you hit a comment on why something is not
obvious. 

> I think my fix is the only one that doesn't break things for anyone else, you may
> argue that it isn't the right one and I kind of agree, but at this point I think
> it's the best solution.

 I'm afraid it is the kind of a defensive attitude that makes the
arch/mips, include/asm-mips code so ugly and hackish in certain places. 
The discussion lists (linux-mips, linux-kernel and others, depending on
the subsystem) exist for the purpose to send patches and let people test
them.  You need not be afraid something gets broken -- it happens all the
time -- if anyone uses the code affected, someone will fix it, otherwise
why to care at all? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
