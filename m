Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4AMTbJ17225
	for linux-mips-outgoing; Thu, 10 May 2001 15:29:37 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4AMTYF17222
	for <linux-mips@oss.sgi.com>; Thu, 10 May 2001 15:29:35 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f4AKKIj06232;
	Thu, 10 May 2001 17:20:18 -0300
Date: Thu, 10 May 2001 17:20:18 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: lift the ioport_resource limit ...
Message-ID: <20010510172018.A6188@bacchus.dhis.org>
References: <Pine.GSO.3.96.1010510111734.10485A-100000@delta.ds2.pg.gda.pl> <3AFAD9E8.EC4D6D80@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AFAD9E8.EC4D6D80@mvista.com>; from jsun@mvista.com on Thu, May 10, 2001 at 11:11:53AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, May 10, 2001 at 11:11:53AM -0700, Jun Sun wrote:

> I would not normally assign IO space above 0xffff either.  But recently I
> found multiple PCI buses, especially dual PCI buses, are getting popular, as
> examplified by two Gallelio chips and the new NEC Vrc5477 chips.  
> 
> Since all drivers share the same mips_io_port_base, - even though the devices
> may be on different PCI buses - we need to assign the PCI IO windows
> contiguously so that drivers can share the same base address.  In most such
> setups, you will get more than 0xffff IO ranges.

After some discussion with some of the Linux PCI guys I think we should try
to avoid extend the per-bus I/O address space beyond 64k ports.  This is not
a very strong ``should avoid'', though.  The primary concern is a number of
broken peripheral chips which apparently are floating around out there in
good numbers.

Another reason to not extend the PCI-bus address range to 4g ports is the
size of the available physical address space in the main processor's
address space itself.  Limited by the 32-bit address space we can only
address a limited number via in/out anyway, so we better shouldn't fake
what we ain't got (cited freely after Seymoure Cray), so 4g ports is silly
anyway.

  Ralf
