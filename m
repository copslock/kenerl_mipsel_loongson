Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1CDmsW31695
	for linux-mips-outgoing; Tue, 12 Feb 2002 05:48:54 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1CDmh931692
	for <linux-mips@oss.sgi.com>; Tue, 12 Feb 2002 05:48:47 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA19778;
	Tue, 12 Feb 2002 13:45:22 +0100 (MET)
Date: Tue, 12 Feb 2002 13:45:21 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Matthew Dharm <mdharm@momenco.com>, Ralf Baechle <ralf@uni-koblenz.de>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
In-Reply-To: <010601c1b3bd$1da618e0$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1020212132316.17858E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 12 Feb 2002, Kevin D. Kissell wrote:

> >  Obviously there are as "sync" is standard for MIPS II and above.  That's
> > why only CONFIG_CPU_R3000 and CONFIG_CPU_TX39XX disable "sync".
> 
> According to the (rather old) Tx39xx specs at my disposal,
> those parts should also support the SYNC instruction.  Does
> anyone know for a fact that some of them do not?

 I set these values according to what I found in arch/mips/setup.c --
Tx39xx are marked as MIPS_CPU_ISA_I, but obviously if they still implement
"sync" as an extension they should be marked to enable the code that uses
it.  The patch should be applied as is anyway -- until it's clear if all
members of the Tx39xx family implement "sync", it's better to leave their
configuration in the current state. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
