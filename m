Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBEFnYb02573
	for linux-mips-outgoing; Fri, 14 Dec 2001 07:49:34 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBEFmpo02558;
	Fri, 14 Dec 2001 07:48:51 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA24298;
	Fri, 14 Dec 2001 15:47:28 +0100 (MET)
Date: Fri, 14 Dec 2001 15:47:28 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Daniel Jacobowitz <dan@debian.org>, Kip Walker <kwalker@broadcom.com>,
   linux-mips@oss.sgi.com
Subject: Re: .section problems in entry.S
In-Reply-To: <20011213193730.A6724@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1011214154058.16122I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 13 Dec 2001, Ralf Baechle wrote:

> Longer than I'd like to see.  Anybody got a sufficiently hacked version
> of ~ 2.11?

 My 2.11.2 appears rock-solid with one exception -- its as mishandles la
when used in a 32-bit source after a 64-bit ISA has been set (with e.g. 
"set .mips3").  I just haven't bothered myself to fix it and switched to
2.11.92 instead.  I have no idea if it works for ELF64, either.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
