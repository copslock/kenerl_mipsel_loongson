Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1L4UnB08120
	for linux-mips-outgoing; Wed, 20 Feb 2002 20:30:49 -0800
Received: from dea.linux-mips.net (a1as20-p220.stg.tli.de [195.252.194.220])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1L4Uj908116
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 20:30:46 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1L3UY227199;
	Thu, 21 Feb 2002 04:30:34 +0100
Date: Thu, 21 Feb 2002 04:30:33 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: Matthew Dharm <mdharm@momenco.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: set_io_port_base()?
Message-ID: <20020221043033.A1430@dea.linux-mips.net>
References: <20020221025755.B29466@dea.linux-mips.net> <NEBBLJGMNKKEEMNLHGAIEEKDCFAA.mdharm@momenco.com> <20020221031338.A31129@dea.linux-mips.net> <3C745B0B.84203D3F@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C745B0B.84203D3F@mvista.com>; from jsun@mvista.com on Wed, Feb 20, 2002 at 06:27:23PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 20, 2002 at 06:27:23PM -0800, Jun Sun wrote:

> This is actually right.  This way if you pass an virtual at
> (mips_io_port_base + delta), you will get a physical address
> (GT_PCI_IO_BASE + delta), the desired place.
> 
> Most boards don't need this funky ioremap() and base addr substraction trick,
> but ocelot has the IO address placed beyond normal kseg1 addressing range.

If you ever think about the value of the the address you're making
something wrong ...

  Ralf
