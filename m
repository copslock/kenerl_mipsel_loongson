Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15AXno16988
	for linux-mips-outgoing; Tue, 5 Feb 2002 02:33:49 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15AXhA16974;
	Tue, 5 Feb 2002 02:33:43 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA10108;
	Tue, 5 Feb 2002 11:33:24 +0100 (MET)
Date: Tue, 5 Feb 2002 11:33:23 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Jason Gunthorpe <jgg@debian.org>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: An mb() rework
In-Reply-To: <20020204180258.A6124@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020205112430.9674B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 4 Feb 2002, Ralf Baechle wrote:

> Bugs due to surprise memory reordering are entirely unfun to debug, so be
> paranoid.  They're out there to get you ...

 The rule of thumb is to use barriers whenever a *device* requires them
and depend on the platform to define them appropriately.  They will expand
to nothing if unneeded, so there is no trade-off.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
