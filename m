Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g64DbPRw007037
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 06:37:25 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g64DbPZO007036
	for linux-mips-outgoing; Thu, 4 Jul 2002 06:37:25 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (dialinpool.tiscali.de [62.246.28.100] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g64DbIRw007027
	for <linux-mips@oss.sgi.com>; Thu, 4 Jul 2002 06:37:20 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g64Df6j28229;
	Thu, 4 Jul 2002 15:41:06 +0200
Date: Thu, 4 Jul 2002 15:41:06 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>,
   linux-mips@oss.sgi.com
Subject: Re: [PATCH] CVS HEAD mips64 assembler options
Message-ID: <20020704154106.A28207@dea.linux-mips.net>
References: <20020704133251.A27007@dea.linux-mips.net> <Pine.GSO.3.96.1020704151822.11369G-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020704151822.11369G-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Jul 04, 2002 at 03:23:28PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-3.1 required=5.0 tests=IN_REP_TO,MAY_BE_FORGED version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 04, 2002 at 03:23:28PM +0200, Maciej W. Rozycki wrote:

> > > 	There's been some rework on the Makefile for the mips64 target,
> > > however the line for the assembler options was forgotten, causing
> > > assembly source code to be wronly compiled, and crashing the linker
> > > afterwards. This patch fixes it, and also removes a few warnings about
> > > structures declared in parameter list.
> > 
> > I know those warnings and I simply take them as the proof that our
> > header are too spaghettiish, so I'm not taking the easy way out ...
> 
>  But the Makefile part is right -- I am responsible for the breakage, but
> since I use non-crippled tools, I haven't got a chance to verify this bit. 
> I am checking in the fix, with minor spacing updates (and adjusting 2.4
> for consistency). 

Yep, just didn't yet get to sort it.

  Ralf
