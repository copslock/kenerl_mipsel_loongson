Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g64DJARw006807
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 06:19:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g64DJANP006806
	for linux-mips-outgoing; Thu, 4 Jul 2002 06:19:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g64DIuRw006795;
	Thu, 4 Jul 2002 06:18:57 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA18393;
	Thu, 4 Jul 2002 15:23:29 +0200 (MET DST)
Date: Thu, 4 Jul 2002 15:23:28 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>,
   linux-mips@oss.sgi.com
Subject: Re: [PATCH] CVS HEAD mips64 assembler options
In-Reply-To: <20020704133251.A27007@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020704151822.11369G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 4 Jul 2002, Ralf Baechle wrote:

> > 	There's been some rework on the Makefile for the mips64 target,
> > however the line for the assembler options was forgotten, causing
> > assembly source code to be wronly compiled, and crashing the linker
> > afterwards. This patch fixes it, and also removes a few warnings about
> > structures declared in parameter list.
> 
> I know those warnings and I simply take them as the proof that our
> header are too spaghettiish, so I'm not taking the easy way out ...

 But the Makefile part is right -- I am responsible for the breakage, but
since I use non-crippled tools, I haven't got a chance to verify this bit. 
I am checking in the fix, with minor spacing updates (and adjusting 2.4
for consistency). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
