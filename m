Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4AINU109917
	for linux-mips-outgoing; Thu, 10 May 2001 11:23:30 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4AINQF09912;
	Thu, 10 May 2001 11:23:26 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4AIBQ016225;
	Thu, 10 May 2001 11:11:26 -0700
Message-ID: <3AFAD9E8.EC4D6D80@mvista.com>
Date: Thu, 10 May 2001 11:11:53 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: lift the ioport_resource limit ...
References: <Pine.GSO.3.96.1010510111734.10485A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Wed, 9 May 2001, Jun Sun wrote:
> 
> > The PCI IO space essentially extends the ISA bus, which effectively removes
> > the 0xffff limits.
> 
>  Note that while there is usually no problem with using addresses beyond
> 64kB in the PCI I/O space, certain PCI-to-PCI bridges may not pass such
> accesses across.  So it's best to avoid assigning and using them.  That's
> why Linux remaps "high" I/O space resources on Alpha, which get set up for
> some systems by the SRM console (firmware), e.g. in the system I was using
> a few years ago, SRM used to assign addresses around 0x11000 and 0x12000
> for the onboard network and SCSI devices, IIRC.
> 

I would not normally assign IO space above 0xffff either.  But recently I
found multiple PCI buses, especially dual PCI buses, are getting popular, as
examplified by two Gallelio chips and the new NEC Vrc5477 chips.  

Since all drivers share the same mips_io_port_base, - even though the devices
may be on different PCI buses - we need to assign the PCI IO windows
contiguously so that drivers can share the same base address.  In most such
setups, you will get more than 0xffff IO ranges.

Jun
