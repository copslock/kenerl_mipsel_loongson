Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACJLoq04121
	for linux-mips-outgoing; Mon, 12 Nov 2001 11:21:50 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACJLl004118
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 11:21:47 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fACJMqB14694;
	Mon, 12 Nov 2001 11:22:52 -0800
Message-ID: <3BF0213A.CE13CAA1@mvista.com>
Date: Mon, 12 Nov 2001 11:21:30 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
References: <Pine.GSO.3.96.1011112195657.24771N-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Mon, 12 Nov 2001, Jun Sun wrote:
> 
> > >  OK, then you need an RTC chipset-specific driver and not a CPU
> > > architecture-specific one.
> >
> > You *can* write a chip specific driver in addition to this generic one if you
> > want.  Presumably the chip-specific one provides more operations than just
> > read/write date.
> 
>  Then why make this driver MIPS-specific?
> 

I suppose one of my previous replies should answer this.  Let me know if it
does not.

Jun
