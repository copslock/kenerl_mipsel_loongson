Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g01L3j826780
	for linux-mips-outgoing; Tue, 1 Jan 2002 13:03:45 -0800
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g01L3gg26776
	for <linux-mips@oss.sgi.com>; Tue, 1 Jan 2002 13:03:42 -0800
Received: from alan by the-village.bc.nu with local (Exim 3.22 #1)
	id 16LVHh-0001LU-00; Tue, 01 Jan 2002 20:13:17 +0000
Subject: Re: ISA
To: jsun@mvista.com (Jun Sun)
Date: Tue, 1 Jan 2002 20:13:16 +0000 (GMT)
Cc: jim@jtan.com (Jim Paris), alan@lxorguk.ukuu.org.uk (Alan Cox),
   Geert.Uytterhoeven@sonycom.com (Geert Uytterhoeven),
   macro@ds2.pg.gda.pl (Maciej W. Rozycki),
   linux-mips@oss.sgi.com (Linux/MIPS Development)
In-Reply-To: <20020101112223.A14847@mvista.com> from "Jun Sun" at Jan 01, 2002 11:22:23 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LVHh-0001LU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> >     check_mem_region(virt_to_phys(ioremap(ISA_address)), ...)
> > 
> > which might be the best way for now? 
> 
> I agree with Geert and think isa_xxx_mem_region is a better approach.
> Unfortunately, this requires a change in both dirver and
> arch-specific part.

Its something that can be done progressively however as we fixup stuff.
It'll just "happen" to work on x86 either way.

Alan
