Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBKEiuP06232
	for linux-mips-outgoing; Thu, 20 Dec 2001 06:44:56 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBKEiiX06224
	for <linux-mips@oss.sgi.com>; Thu, 20 Dec 2001 06:44:45 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA05593;
	Thu, 20 Dec 2001 14:39:56 +0100 (MET)
Date: Thu, 20 Dec 2001 14:39:55 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jun Sun <jsun@mvista.com>,
   jim@jtan.com, Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: ISA
In-Reply-To: <Pine.GSO.4.21.0112201411310.502-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.3.96.1011220143454.3556C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 20 Dec 2001, Geert Uytterhoeven wrote:

> >  Well, as I stated in another mail (but in another thread, I think) you
> > may try request_mem_region(virt_to_phys(ioremap(...))), especially as you
> > really want to reserve an area in the CPU's physical address space and not
> > in the bus's one.
> 
> So we must update all existing drivers that use ISA memory space anyway.

 Not many of them calls request_mem_region()...  Not that it is good. 

> IMHO still better to add isa_request_mem_region() while we're at it, so we can
> solve this in an arch-specific way. Ia32 can still say
> 
>     #define isa_request_mem_region	request_mem_region

 And then "<bus>_request_mem_region" for every new bus supported??? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
