Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4ABGYd30699
	for linux-mips-outgoing; Thu, 10 May 2001 04:16:34 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4ABFgF30672;
	Thu, 10 May 2001 04:15:43 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA18334;
	Thu, 10 May 2001 13:08:32 +0200 (MET DST)
Date: Thu, 10 May 2001 13:08:31 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: lift the ioport_resource limit ...
In-Reply-To: <Pine.GSO.4.10.10105101156480.19268-100000@escobaria.sonytel.be>
Message-ID: <Pine.GSO.3.96.1010510123838.10485B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 10 May 2001, Geert Uytterhoeven wrote:

> Shouldn't that be reflected in the bridge's bus resources (pci_bus.resource[])?

 No idea -- if you write so then you are probably right.  I was told of
the problem at about 2.1.85 and I haven't investigated it further.  Our
PCI handling code wasn't so brillant as it is now, I guess. 

> Then the PCI resource validation/assignment code will (re)assign them when
> necessary.

 Excellent.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
