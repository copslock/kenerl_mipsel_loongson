Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1L2wAs05358
	for linux-mips-outgoing; Wed, 20 Feb 2002 18:58:10 -0800
Received: from dea.linux-mips.net (a1as20-p220.stg.tli.de [195.252.194.220])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1L2w3905355
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 18:58:04 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1L1vtD29867;
	Thu, 21 Feb 2002 02:57:55 +0100
Date: Thu, 21 Feb 2002 02:57:55 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: set_io_port_base()?
Message-ID: <20020221025755.B29466@dea.linux-mips.net>
References: <NEBBLJGMNKKEEMNLHGAIOEKBCFAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIOEKBCFAA.mdharm@momenco.com>; from mdharm@momenco.com on Wed, Feb 20, 2002 at 05:36:05PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 20, 2002 at 05:36:05PM -0800, Matthew Dharm wrote:

> Now, I'm pretty sure this has something to do with the initcall to
> set_io_port_base() and ioremap(), which are in my setup.c (copied from
> linux/arch/mips/gt64120/momenco_ocelot/setup.c and modified).  Without
> that bit of code at the bottom of that function, I don't even get
> this -- it just crashes.  So I know I need this code, but I'm just not
> certain what/how I should be using it...
> 
> My initial guess is that it's used to map some virtual address space
> onto the physical addresses needed to actually generate PCI I/O
> transactions, but that's just a guess.  If that's right, then the code
> I'm using _should_ work... I call ioremap() with the physical base and
> size, and then set_io_port_base() using the result of ioremap().

That is exactly the intended use.

  Ralf
