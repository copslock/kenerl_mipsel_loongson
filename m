Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f65BX0i14725
	for linux-mips-outgoing; Thu, 5 Jul 2001 04:33:00 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f65BWoV14719;
	Thu, 5 Jul 2001 04:32:54 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA12430;
	Thu, 5 Jul 2001 13:35:12 +0200 (MET DST)
Date: Thu, 5 Jul 2001 13:35:11 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, linux-mips@oss.sgi.com
Subject: Re: sti() does not work.
In-Reply-To: <20010704152619.E3829@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010705132623.11517D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 4 Jul 2001, Ralf Baechle wrote:

> > > extern __inline__ void  __sti(void)
> > > {
> > > 	__asm__ __volatile__(
> > > 		".set\tnoreorder\n\t"
> > > 		".set\tnoat\n\t"
> > > 		"mfc0\t$1,$12\n\t"
> > > 		"ori\t$1,0x1f\n\t"
> > > 		"xori\t$1,0x1e\n\t"
> > > 		"mtc0\t$1,$12\n\t"               /* <----- problem  here! */
> > 
> > Here should follow some nop's on a MIPS I system to make sure $12
> > is written
> 
> There are no nops there since we simply don't care how how many cycles
> after the mtc0 the interrupts actually get enabled.  Worst case is the
> R4000's 8 stage pipeline where we have a latency of 3 cycles, clearly
> nothing that justifies wasting memory and cycles for nops.

 Still there is a nop missing after mfc0 if this is to be executed on a
MIPS I CPU.  The 2.4.x code is fine, though, so nothing to worry about. 

> > (why is noreorder used here?).
> 
> Without the .set noreorder the assembler would be free to do arbitrary
> reordering of the object code generated.  Gas doesn't do that but there
> are other assemblers that do flow analysis and may generate object code
> that doesn't look very much like the source they were fed with.

 Hmm, I would consider that a bug in such an assembler.  The mtc0 and
possibly the mfc0 opcode should be treated as reordering barriers as they
may involve side effects an assembler might not be aware of. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
