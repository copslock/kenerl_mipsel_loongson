Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1L35Tf05602
	for linux-mips-outgoing; Wed, 20 Feb 2002 19:05:29 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1L35L905599;
	Wed, 20 Feb 2002 19:05:21 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g1L25LR26900;
	Wed, 20 Feb 2002 18:05:21 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: RE: set_io_port_base()?
Date: Wed, 20 Feb 2002 18:05:21 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIEEKDCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <20020221025755.B29466@dea.linux-mips.net>
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

If it works as I think it does, then is the code in
linux/arch/mips/gt64120/momenco_ocelot/setup.c correct?  Specifically,
it calls ioremap() and then calls set_io_port_base() with a very
strange value -- it's the value from ioremap() modified by the I/O
physical address base...

That doesn't look right to me... or I just don't quite understand how
this is supposed to work.

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: Ralf Baechle [mailto:ralf@oss.sgi.com]
> Sent: Wednesday, February 20, 2002 5:58 PM
> To: Matthew Dharm
> Cc: Linux-MIPS
> Subject: Re: set_io_port_base()?
>
>
> On Wed, Feb 20, 2002 at 05:36:05PM -0800, Matthew Dharm wrote:
>
> > Now, I'm pretty sure this has something to do with the initcall to
> > set_io_port_base() and ioremap(), which are in my setup.c
> (copied from
> > linux/arch/mips/gt64120/momenco_ocelot/setup.c and
> modified).  Without
> > that bit of code at the bottom of that function, I don't even get
> > this -- it just crashes.  So I know I need this code, but
> I'm just not
> > certain what/how I should be using it...
> >
> > My initial guess is that it's used to map some virtual
> address space
> > onto the physical addresses needed to actually generate PCI I/O
> > transactions, but that's just a guess.  If that's right,
> then the code
> > I'm using _should_ work... I call ioremap() with the
> physical base and
> > size, and then set_io_port_base() using the result of ioremap().
>
> That is exactly the intended use.
>
>   Ralf
>
