Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJ2pxD27557
	for linux-mips-outgoing; Tue, 18 Dec 2001 18:51:59 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJ2pqo27551
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 18:51:53 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id CAA17624;
	Wed, 19 Dec 2001 02:50:54 +0100 (MET)
Date: Wed, 19 Dec 2001 02:50:53 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: jim@jtan.com, linux-mips@oss.sgi.com
Subject: Re: ISA
In-Reply-To: <3C1FEAB9.F590DFFE@mvista.com>
Message-ID: <Pine.GSO.3.96.1011219023325.16267B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 18 Dec 2001, Jun Sun wrote:

> > So I should modify ioremap to return (addr+isa_slot_offset) when
> > CONFIG_ISA is defined and the given I/O address is in the 16 MB ISA
> > range. 
> 
> I would consider it only as a workaround rather than a fix.

 Why?

> You need to make sure all other PCI-based boards have isa_slot_offset set to
> 0.

 I don't think it's needed.  Why to refer to isa_slot_offset for PCI
accesses at all?

> ioremap() has been used by many PCI device drivers, and on MIPS it assumes 1:1
> mapping between PCI memory space and CPU physical space.  It have been working
> so far either because PCI device BARs are shuffled around to match their
> physical address (from CPU point of view) or dev structure is modified
> propoerly with special fixups.
> 
> Now when people using ioremap/readb/writeb method to access ISA memory space,
> which lives in the lower range of the "bus memory space", it will collide with
> system ram under 1:1 mapping assumption.

 Hmm, I believe there should be no such problem.  For systems equipped
with the PCI bus we may just assume the low 16MB of PCI memory address
space is reserved for ISA memory addresses (it's hardwired for many
platforms, so there should be no problem with it), i.e. avoid programming
BARs to point to that space and make ioremap() (or __ioremap(), actually)
act accordingly, i.e. assume a 1:1 mapping for addresses above 16MB and
perform an ISA mapping for ones below 16MB. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
