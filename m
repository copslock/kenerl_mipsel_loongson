Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6VBWNRw017668
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 31 Jul 2002 04:32:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6VBWNC9017667
	for linux-mips-outgoing; Wed, 31 Jul 2002 04:32:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6VBWFRw017655;
	Wed, 31 Jul 2002 04:32:16 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA10688;
	Wed, 31 Jul 2002 13:34:17 +0200 (MET DST)
Date: Wed, 31 Jul 2002 13:34:17 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] MIPS64 R4k TLB refill CP0 hazards
In-Reply-To: <20020731004702.A2142@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020731133006.10088A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 31 Jul 2002, Ralf Baechle wrote:

> Nope, on R4000 four cycles are needed between the tlbwr and a eret
> instruction; on the R4600 just two.

 Ugh, I missed this entirely, thanks for pointing it out.  The doc implies
three cycles for the R4000 actually, though. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
