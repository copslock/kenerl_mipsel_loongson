Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KGjr118896
	for linux-mips-outgoing; Wed, 20 Feb 2002 08:45:53 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KGjK918892;
	Wed, 20 Feb 2002 08:45:45 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA10233;
	Wed, 20 Feb 2002 16:45:08 +0100 (MET)
Date: Wed, 20 Feb 2002 16:45:08 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Jun Sun <jsun@mvista.com>, "Kevin D. Kissell" <kevink@mips.com>,
   linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
In-Reply-To: <20020220160513.A17227@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020220160940.5781B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 20 Feb 2002, Ralf Baechle wrote:

> >  Ill???  I think someone was just longsighted enough not to limit PTEs to
> > 38-bit physical addresses.  A shift costs a single cycle if we want to
> > save memory. 
> 
> The idea of the register was to directly generate the address of a PTE.

 And it does -- doesn't it?  It simply cannot fit all needs at once.  What
about pages larger than 4kB, for example?

> An extra instruction in TLB exception handlers isn't only visible in
> performance, it also means introducing constraints on the address itself -

 The performance is an issue, of course -- you get about 10% hit in the
exception handler.  You need to decide (possibly at the run time) what's
more important: the gain from a faster TLB refill or the gain from a
compression of page tables. 

> an arithmetic shift by one bit for 4 byte PTEs will result in the two
> high bits of the address being identical, an arithmetic shift will make
> the high bit a null etc.  Just on 32-bit kernels on 64-bit hw you're
> lucky, you have a bit 32 in c0_context which will be shifted into bit 31.

 Since the address is virtual -- what's the deal?

> Messy?

 Hardly.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
