Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1L3DnT05756
	for linux-mips-outgoing; Wed, 20 Feb 2002 19:13:49 -0800
Received: from dea.linux-mips.net (a1as20-p220.stg.tli.de [195.252.194.220])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1L3Dj905753
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 19:13:45 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1L2Dcu31289;
	Thu, 21 Feb 2002 03:13:38 +0100
Date: Thu, 21 Feb 2002 03:13:38 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: set_io_port_base()?
Message-ID: <20020221031338.A31129@dea.linux-mips.net>
References: <20020221025755.B29466@dea.linux-mips.net> <NEBBLJGMNKKEEMNLHGAIEEKDCFAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIEEKDCFAA.mdharm@momenco.com>; from mdharm@momenco.com on Wed, Feb 20, 2002 at 06:05:21PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 20, 2002 at 06:05:21PM -0800, Matthew Dharm wrote:

> If it works as I think it does, then is the code in
> linux/arch/mips/gt64120/momenco_ocelot/setup.c correct?  Specifically,
> it calls ioremap() and then calls set_io_port_base() with a very
> strange value -- it's the value from ioremap()

> modified by the I/O physical address base...
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I was reading too fast and missed that part.

> That doesn't look right to me... or I just don't quite understand how
> this is supposed to work.

That's definately looks fishy.  Another crime people keep comitting is using
the same address space for both I/O memory and the base address of the
port space.

  Ralf
