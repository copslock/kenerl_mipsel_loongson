Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1L6ajA10190
	for linux-mips-outgoing; Wed, 20 Feb 2002 22:36:45 -0800
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1L6ad910186;
	Wed, 20 Feb 2002 22:36:39 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id VAA08957;
	Wed, 20 Feb 2002 21:35:57 -0800
Date: Wed, 20 Feb 2002 21:35:57 -0800
From: Jun Sun <jsun@mvista.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: set_io_port_base()?
Message-ID: <20020220213557.A8883@mvista.com>
References: <3C745B0B.84203D3F@mvista.com> <NEBBLJGMNKKEEMNLHGAIKEKFCFAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIKEKFCFAA.mdharm@momenco.com>; from mdharm@momenco.com on Wed, Feb 20, 2002 at 06:48:50PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 20, 2002 at 06:48:50PM -0800, Matthew Dharm wrote:
> But isn't that what all the complicated logic in ioremap() is for?  

Not exactly.

Here is the whole picture:

drivers do inb(delta)/outb(delta)
  -> translated to an virtual address (mips_io_port_base + delta)
     -> mapped into (GT_IO_BASE + delta) physical addr
	-> Bingo! you got the devices.

Here your goal is to make the drivers that do inb()/outb() happy (i.e.,
be able to reuse them without modification)  If you only use drivers
that directly access memory (such as drivers/net/nec_korva.c on 
linux-mips.sf.net), then you don't even have to set mips_io_port_base at all.

The ioremap() comes into place because by default you can not
set a mips_io_port_base value in kseg1 range on ocelot (it is at 0x20000000
in physical addr space).  Therefore you do a ioremap(), blah blah as explained
above.

Someday I should finish the PCI chapter on my porting guide ...

Jun
