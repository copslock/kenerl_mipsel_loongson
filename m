Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1L3mx206217
	for linux-mips-outgoing; Wed, 20 Feb 2002 19:48:59 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1L3mo906213;
	Wed, 20 Feb 2002 19:48:51 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g1L2moR27080;
	Wed, 20 Feb 2002 18:48:50 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: <jsun@mvista.com>, "Ralf Baechle" <ralf@oss.sgi.com>
Cc: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: RE: set_io_port_base()?
Date: Wed, 20 Feb 2002 18:48:50 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIKEKFCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <3C745B0B.84203D3F@mvista.com>
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

But isn't that what all the complicated logic in ioremap() is for?  It
looks like it checks to see if it can directly address the I/O space
via kseg1 and if not, set up a translation for it...

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: jsun@mvista.com [mailto:jsun@mvista.com]
> Sent: Wednesday, February 20, 2002 6:27 PM
> To: Ralf Baechle
> Cc: Matthew Dharm; Linux-MIPS
> Subject: Re: set_io_port_base()?
>
>
> Ralf Baechle wrote:
> >
> > On Wed, Feb 20, 2002 at 06:05:21PM -0800, Matthew Dharm wrote:
> >
> > > If it works as I think it does, then is the code in
> > > linux/arch/mips/gt64120/momenco_ocelot/setup.c correct?
>  Specifically,
> > > it calls ioremap() and then calls set_io_port_base() with a very
> > > strange value -- it's the value from ioremap()
> >
> > > modified by the I/O physical address base...
> >   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > I was reading too fast and missed that part.
> >
> > > That doesn't look right to me... or I just don't quite
> understand how
> > > this is supposed to work.
> >
> > That's definately looks fishy.
>
> This is actually right.  This way if you pass an virtual at
> (mips_io_port_base
> + delta), you will get a physical address (GT_PCI_IO_BASE +
> delta), the
> desired place.
>
> Most boards don't need this funky ioremap() and base addr
> substraction trick,
> but ocelot has the IO address placed beyond normal kseg1
> addressing range.
>
> Jun
>
