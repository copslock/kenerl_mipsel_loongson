Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJ3AcF28584
	for linux-mips-outgoing; Tue, 18 Dec 2001 19:10:38 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJ3AZo28572
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 19:10:35 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fBJ29lB09183;
	Tue, 18 Dec 2001 18:09:47 -0800
Message-ID: <3C1FF6F0.B8834B75@mvista.com>
Date: Tue, 18 Dec 2001 18:09:52 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: jim@jtan.com, linux-mips@oss.sgi.com
Subject: Re: ISA
References: <Pine.GSO.3.96.1011219023325.16267B-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:

>  Hmm, I believe there should be no such problem.  For systems equipped
> with the PCI bus we may just assume the low 16MB of PCI memory address
> space is reserved for ISA memory addresses (it's hardwired for many
> platforms, so there should be no problem with it), i.e. avoid programming
> BARs to point to that space and make ioremap() (or __ioremap(), actually)
> act accordingly, i.e. assume a 1:1 mapping for addresses above 16MB and
> perform an ISA mapping for ones below 16MB.

I see.  I missed that part where you have a pivoting point at 16MB.

That sounds like a working solution to me.

Overall, I still feel using isa_xxx() macros in the driver seems like a
cleaner solution.  That essentially treats ISA memory space as a separate
space.  The ioremap/readb/writeb approach tries to lump ISA memory and PCI
memory space together but in fact we still have treat them differently (based
on whether the address is greater than 16MB, which is a little hackish.)

Jun
