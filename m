Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0FE7at19543
	for linux-mips-outgoing; Tue, 15 Jan 2002 06:07:36 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0FE7RP19540;
	Tue, 15 Jan 2002 06:07:27 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA27438;
	Tue, 15 Jan 2002 14:07:16 +0100 (MET)
Date: Tue, 15 Jan 2002 14:07:16 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: "Kevin D. Kissell" <kevink@mips.com>, Dominic Sweetman <dom@algor.co.uk>,
   Matthew Dharm <mdharm@momenco.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS64 status?
In-Reply-To: <20020114152355.E29242@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020115135626.24748C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 14 Jan 2002, Ralf Baechle wrote:

> > The official MIPS64[tm] architecture spec from MIPS 
> > Technologies also provides a bit (Status.PX) which enables
> > the 64-bit data path without affecting address generation
> > and translation, which removes this quirk.  Only the very
> > most recent 64-bit cores and CPUs implement it, however.
> 
> And Linux doesn't use PX at all.

 Especially as there is no real need for the bit for the standard MIPS64
TLB organization.  The functionality of the PX bit can be replaced by the
UX bit together with an appropriate mapping of segments to the 31-bit
address space.  Of course the kernel needs to handle the XTLB exception
for UX as opposed to the TLB one for PX, but for programs it doesn't
matter.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
