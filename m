Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJ2TAd26517
	for linux-mips-outgoing; Tue, 18 Dec 2001 18:29:10 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJ2T0o26513
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 18:29:01 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id CAA17386;
	Wed, 19 Dec 2001 02:28:32 +0100 (MET)
Date: Wed, 19 Dec 2001 02:28:32 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jim Paris <jim@jtan.com>
cc: linux-mips@oss.sgi.com
Subject: Re: ISA
In-Reply-To: <20011218172456.A12735@neurosis.mit.edu>
Message-ID: <Pine.GSO.3.96.1011219020930.16267A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 18 Dec 2001, Jim Paris wrote:

> So I should modify ioremap to return (addr+isa_slot_offset) when
> CONFIG_ISA is defined and the given I/O address is in the 16 MB ISA
> range.  That will make things work according to Linus' description of
> how they should.

 Yep.

> Okay, point.  So the i82365 driver is at fault when it calls
> check_mem_region(ISA_address).  How should I fix that?  Should it
> call check_mem_region(ioremap(ISA_address)) instead?  

 Hmm, it looks no ISA device driver bothers to handle iomem resources.  I
believe check_mem_region(virt_to_phys(ioremap(ISA_address)), ...) should
work, but I haven't checked.  Note that you should probably look at the
*_resource() functions (as declared in <linux/ioport.h>) as *_region() 
ones seem to be doomed obsolete. 

> Or should /proc/iomap contain physical addresses, which the i82365
> driver has no way of knowing without breaking abstractions?  (And if
> that's the case, how should I do it?  Create isa_check_mem_region?)

 /proc/iomem (I suppose it is what you meant) does contain physical
addresses. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
