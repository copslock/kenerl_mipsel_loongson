Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1L3GAg05838
	for linux-mips-outgoing; Wed, 20 Feb 2002 19:16:10 -0800
Received: from dea.linux-mips.net (a1as20-p220.stg.tli.de [195.252.194.220])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1L3G7905835
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 19:16:07 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1L2G0d31333;
	Thu, 21 Feb 2002 03:16:00 +0100
Date: Thu, 21 Feb 2002 03:16:00 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: set_io_port_base()?
Message-ID: <20020221031600.B31129@dea.linux-mips.net>
References: <20020221025755.B29466@dea.linux-mips.net> <NEBBLJGMNKKEEMNLHGAIIEKDCFAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIIEKDCFAA.mdharm@momenco.com>; from mdharm@momenco.com on Wed, Feb 20, 2002 at 06:08:39PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 20, 2002 at 06:08:39PM -0800, Matthew Dharm wrote:

> Also, does this have to be done only for PCI I/O, or PCI memory also?

This is just so all the inb/inw/outl etc. functions in <asm/io.h> know
how to access ioports.

  Ralf
