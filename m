Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14CX9X10429
	for linux-mips-outgoing; Mon, 4 Feb 2002 04:33:09 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14CWxA10273;
	Mon, 4 Feb 2002 04:33:00 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA09990;
	Mon, 4 Feb 2002 12:32:41 +0100 (MET)
Date: Mon, 4 Feb 2002 12:32:40 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
In-Reply-To: <20020203193717.B6317@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020204101743.5750B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 3 Feb 2002, Ralf Baechle wrote:

> >  Hmm, the assumption might be justifiable for the i386 only?  Shouldn't
> > i8259.c be fixed instead? 
> 
> These are the ISA interrupts; many drivers make assumptions about the
> interrupts numbers, so we can't really change the numbers anyway.  For
> any non-ISA interrupt it's number can be choosen freely.

 I don't think such assumptions are sane even for the i386 -- an I/O APIC
system is free to route ISA interrupts to whichever I/O APIC inputs are
available, not necessarily the low 16.  The Intel MP Spec explicitly
allows such a setup -- ISA interrupts are only tied in default
configurations, which are rarely used (probably not at all these days). 

 Anyway, only the drivers that read an IRQ number from jumpers or Flash
memory need to be checked, and these are a minority (3Com Ethernet cards
and possibly very few others).  These that do probing (with probe_irq) or
simply take the number from an option will work automatically. 

 While I agree for 2.4 it might be not the best idea to do such changes,
for 2.5 it's worth considering, isn't it?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
