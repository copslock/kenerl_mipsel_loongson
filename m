Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11DSif02116
	for linux-mips-outgoing; Fri, 1 Feb 2002 05:28:44 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11DSad02105
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 05:28:36 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA27942;
	Fri, 1 Feb 2002 13:27:42 +0100 (MET)
Date: Fri, 1 Feb 2002 13:27:42 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: jgg@debian.org, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: An mb() rework
In-Reply-To: <E16WQn9-0003XW-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1020201130541.26449E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 31 Jan 2002, Alan Cox wrote:

> The x86 behaviour forced as I understand it is
> 
> 	barrier()		-	compiler level store barrier
> 	rmb()			-	read barrier to bus/DMA level
> 					[no operation]
> 	wmb()			-	write barrier to bus/DMA level
> 					[synchronizing instruction sequence
> 					 of locked add of 0 to stack top]
> 
> 	(mb and wmb as names come from Alpha so I guess its definitive 8))

 Well, after looking at the Alpha Architecture Handbook I see "mb" and
"wmb" are pure ordering barriers -- any transactions at the CPU bus (pins)
may still be deferred or prefetched (architecturally -- can't comment on
specific chips).  So after all, maybe all the macros should be purely
"sync" for MIPS ("" for MIPS I, and mb() equal to wbflush() for R3220 and
similar setups) and anything that wants to see all writes actually
committed should use wbflush(), which would be defined as "mb();
uncached_read();" (or in a system-specific way, for R3220, etc.)?

 The i386 implementation seems stronger than it should be, but that's
probably because of the limited choice available. 

 Any thoughts?

> It does not enforce PCI posting. Also your spurious interrupt case is
> wrong for other horrible reasons. Interrupt delivery must never be 
> assumed to be synchronous in a portable driver. (In fact you'll see async
> irq delivery on an X86)

 For interrupts arriving to an interrupt controller -- agreed.

 But we don't generally expect a spurious interrupt from a line that was
already masked at the controller level.  In other words mask_and_ack()
must undertake any means possible, to assure the addressed controller
received the new mask.  If an interrupt passes by ocassionally anyway,
then it's not fatal, i.e. we can handle it, but it shouldn't be a rule
(i.e. receiving as many spurious interrupts as real ones).  Am I right?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
