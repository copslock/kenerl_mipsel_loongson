Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1L3S9E05964
	for linux-mips-outgoing; Wed, 20 Feb 2002 19:28:09 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1L3S1905961;
	Wed, 20 Feb 2002 19:28:01 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g1L2PFB05290;
	Wed, 20 Feb 2002 18:25:15 -0800
Message-ID: <3C745B0B.84203D3F@mvista.com>
Date: Wed, 20 Feb 2002 18:27:23 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Matthew Dharm <mdharm@momenco.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: set_io_port_base()?
References: <20020221025755.B29466@dea.linux-mips.net> <NEBBLJGMNKKEEMNLHGAIEEKDCFAA.mdharm@momenco.com> <20020221031338.A31129@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Wed, Feb 20, 2002 at 06:05:21PM -0800, Matthew Dharm wrote:
> 
> > If it works as I think it does, then is the code in
> > linux/arch/mips/gt64120/momenco_ocelot/setup.c correct?  Specifically,
> > it calls ioremap() and then calls set_io_port_base() with a very
> > strange value -- it's the value from ioremap()
> 
> > modified by the I/O physical address base...
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> I was reading too fast and missed that part.
> 
> > That doesn't look right to me... or I just don't quite understand how
> > this is supposed to work.
> 
> That's definately looks fishy. 

This is actually right.  This way if you pass an virtual at (mips_io_port_base
+ delta), you will get a physical address (GT_PCI_IO_BASE + delta), the
desired place.

Most boards don't need this funky ioremap() and base addr substraction trick,
but ocelot has the IO address placed beyond normal kseg1 addressing range.

Jun
