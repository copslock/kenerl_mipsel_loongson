Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4AA0rs28914
	for linux-mips-outgoing; Thu, 10 May 2001 03:00:53 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4AA0fF28910;
	Thu, 10 May 2001 03:00:41 -0700
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA12202;
	Thu, 10 May 2001 11:58:51 +0200 (MET DST)
Date: Thu, 10 May 2001 11:58:51 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: lift the ioport_resource limit ...
In-Reply-To: <Pine.GSO.3.96.1010510111734.10485A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.10.10105101156480.19268-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 10 May 2001, Maciej W. Rozycki wrote:
> On Wed, 9 May 2001, Jun Sun wrote:
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

Shouldn't that be reflected in the bridge's bus resources (pci_bus.resource[])?
Then the PCI resource validation/assignment code will (re)assign them when
necessary.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
