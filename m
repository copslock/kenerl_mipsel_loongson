Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4SE7vt23974
	for linux-mips-outgoing; Mon, 28 May 2001 07:07:57 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4SE6Rd23696;
	Mon, 28 May 2001 07:06:58 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA18070;
	Mon, 28 May 2001 13:09:50 +0200 (MET DST)
Date: Mon, 28 May 2001 13:09:49 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] incorrect asm constraints for ll/sc constructs
In-Reply-To: <20010525134909.A26065@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1010528130715.15200B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 25 May 2001, Daniel Jacobowitz wrote:

> How about the attached, then?  If the p[0x100000] case is of sufficient
> concern, we can work around that too, but this catches all current
> uses.

 Fine for me.  Don't worry of the gcc bug -- such large offests are rare
and I doubt anyone will get hurt.  Hopefully gcc will get fixed meanwhile,
either by me or by someone else.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
