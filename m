Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6CIZNRw011098
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 11:35:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6CIZNHG011097
	for linux-mips-outgoing; Fri, 12 Jul 2002 11:35:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6CIZGRw011088;
	Fri, 12 Jul 2002 11:35:16 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA11412;
	Fri, 12 Jul 2002 20:40:18 +0200 (MET DST)
Date: Fri, 12 Jul 2002 20:40:17 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dominic Sweetman <dom@algor.co.uk>
cc: Ralf Baechle <ralf@oss.sgi.com>, "Gleb O. Raiko" <raiko@niisi.msk.ru>,
   Carsten Langgaard <carstenl@mips.com>,
   Jon Burgess <Jon_Burgess@eur.3com.com>, linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
In-Reply-To: <15662.3715.334923.669657@gladsmuir.algor.co.uk>
Message-ID: <Pine.GSO.3.96.1020712202609.7646F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 12 Jul 2002, Dominic Sweetman wrote:

> PS: my standard appeal.  When you say you 'flush' a cache do you mean
> invalidate, write-back, or both?  If (as I suspect) not all of you
> mean the same thing, should you not instead speak of 'invalidate' and
> 'writeback'... sloppy language surely leads to sloppy programming?

 For me, a "flush" is both (i.e., as Gleb noticed, that's what functions
with the word in names do).  For a lone write back or invalidation, I
would use these terms respectively.

 Well, for the R3k the term is unambiguous anyway...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
