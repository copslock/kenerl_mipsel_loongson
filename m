Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBKEENT05184
	for linux-mips-outgoing; Thu, 20 Dec 2001 06:14:23 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBKEE3X05177
	for <linux-mips@oss.sgi.com>; Thu, 20 Dec 2001 06:14:08 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA04317;
	Thu, 20 Dec 2001 14:09:05 +0100 (MET)
Date: Thu, 20 Dec 2001 14:09:03 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jun Sun <jsun@mvista.com>,
   jim@jtan.com, Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: ISA
In-Reply-To: <Pine.GSO.4.21.0112191456410.28777-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.3.96.1011220135315.3556A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 19 Dec 2001, Geert Uytterhoeven wrote:

> OK, so I can check for < 16 MB in ioremap(), and readb() and friends will
> handle it fine. You're not supposed to call ioremap() for real RAM anyway, so
> there's no ambiguity.
> 
> But what about request_mem_region() and friends? How can I distinguish between
> ISA memory and the first 16 MB of RAM (or ROM, or whatever my board has there)?

 Well, as I stated in another mail (but in another thread, I think) you
may try request_mem_region(virt_to_phys(ioremap(...))), especially as you
really want to reserve an area in the CPU's physical address space and not
in the bus's one.

> Or am I not supposed to let those things show up in /proc/iomem?

 I think the appearance is not the point here.  The point is to prevent a
driver from accessing an already occupied area. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
