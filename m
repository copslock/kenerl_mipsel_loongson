Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DGYHl13277
	for linux-mips-outgoing; Mon, 13 Aug 2001 09:34:17 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DGY8j13274;
	Mon, 13 Aug 2001 09:34:09 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA24957;
	Mon, 13 Aug 2001 18:36:35 +0200 (MET DST)
Date: Mon, 13 Aug 2001 18:36:35 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Harald Koerfgen <hkoerfg@web.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Export mips_machtype
In-Reply-To: <20010813175357.E2228@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010813182811.23241P-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 13 Aug 2001, Ralf Baechle wrote:

> >  The following patch exports mips_machtype to modules.  Please apply.
> 
> Ok - but I'd like to burry the whole mips_machtype mechanism in 2.5.  To
> messy and requires a central authority to allocate machine types.  What
> do you think?

 No idea at the moment.  For DECs things are pretty easy.  The firmware
returns a unique system ID for each different kind of hardware.  It can be
used instead (actually mips_machtype is initialized bazed on what firmware
reports).  The ID is mostly useful for system-specific stuff, e.g. onboard
devices that cannot be identified or probed in another way.

 Note that for PCI-based systems, there is usually no problem -- PCI IDs
can be used instead in most cases.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
