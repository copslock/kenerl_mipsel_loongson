Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6UMjtRw006349
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 30 Jul 2002 15:45:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6UMjtLc006348
	for linux-mips-outgoing; Tue, 30 Jul 2002 15:45:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f207.dialo.tiscali.de [62.246.16.207])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6UMjlRw006339
	for <linux-mips@oss.sgi.com>; Tue, 30 Jul 2002 15:45:49 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6UMl2N02372;
	Wed, 31 Jul 2002 00:47:02 +0200
Date: Wed, 31 Jul 2002 00:47:02 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] MIPS64 R4k TLB refill CP0 hazards
Message-ID: <20020731004702.A2142@dea.linux-mips.net>
References: <3D4681DE.7BE793C9@mips.com> <Pine.GSO.3.96.1020730141305.16647B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020730141305.16647B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jul 30, 2002 at 02:44:32PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 30, 2002 at 02:44:32PM +0200, Maciej W. Rozycki wrote:

>  Since the handler is critical for performance, it would be desireable to
> have separate versions tuned for particular CPUs.  The branch for the
> R4400 seems appropriate as it works unlike the documented code: the
> R4000/R4400 manual as available from the MIPS site states a single
> intervening instruction is needed before the last move to EntryLo and a
> "tlbwr" or "tlbwi" (see Table F-1 and F-2).  So I conclude the branch is
> really a workaround for a kind of erratum or a specification change. 

Nope, on R4000 four cycles are needed between the tlbwr and a eret
instruction; on the R4600 just two.

  Ralf
