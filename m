Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KDR4EC026792
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 06:27:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KDR4wl026791
	for linux-mips-outgoing; Tue, 20 Aug 2002 06:27:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KDQuEC026781;
	Tue, 20 Aug 2002 06:26:57 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA11971;
	Tue, 20 Aug 2002 15:30:22 +0200 (MET DST)
Date: Tue, 20 Aug 2002 15:30:22 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Ralf Baechle <ralf@oss.sgi.com>, SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: [PATCH] Bring back R4600 V1.7 support
In-Reply-To: <20020820113329.GZ10730@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1020820152046.8700E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 20 Aug 2002, Jan-Benedict Glaw wrote:

> Please accept the patch (from my previous mail). I'm using it now for
> two days, and I've got one mail telling me that it works for its sender.

 Ugh, this should be a separate set of functions selected at the run time. 
It should be fairly trivial to rewrite it this way (best done with
processor-specific functions expanded from common templates for ease of
maintenance), but the size of the resulting interrupt masking window is
unacceptable.  A more finegrained implementation is really desireable,
with an interrupt enable window every page or so, but your proposal should
be fair enough for the sake of usability once rewritten as I suggested.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
