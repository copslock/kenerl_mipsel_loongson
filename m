Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4A9qup28571
	for linux-mips-outgoing; Thu, 10 May 2001 02:52:56 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4A9ndF28426;
	Thu, 10 May 2001 02:50:04 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA14125;
	Thu, 10 May 2001 11:43:36 +0200 (MET DST)
Date: Thu, 10 May 2001 11:43:36 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: lift the ioport_resource limit ...
In-Reply-To: <3AF9B173.5E13AD2@mvista.com>
Message-ID: <Pine.GSO.3.96.1010510111734.10485A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 9 May 2001, Jun Sun wrote:

> The PCI IO space essentially extends the ISA bus, which effectively removes
> the 0xffff limits.

 Note that while there is usually no problem with using addresses beyond
64kB in the PCI I/O space, certain PCI-to-PCI bridges may not pass such
accesses across.  So it's best to avoid assigning and using them.  That's
why Linux remaps "high" I/O space resources on Alpha, which get set up for
some systems by the SRM console (firmware), e.g. in the system I was using
a few years ago, SRM used to assign addresses around 0x11000 and 0x12000
for the onboard network and SCSI devices, IIRC. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
