Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6VKUhRw012291
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 31 Jul 2002 13:30:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6VKUhY7012290
	for linux-mips-outgoing; Wed, 31 Jul 2002 13:30:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f104.dialo.tiscali.de [62.246.17.104])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6VKUaRw012281
	for <linux-mips@oss.sgi.com>; Wed, 31 Jul 2002 13:30:38 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6VKVwZ06476;
	Wed, 31 Jul 2002 22:31:58 +0200
Date: Wed, 31 Jul 2002 22:31:58 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] MIPS64 R4k TLB refill CP0 hazards
Message-ID: <20020731223158.A6394@dea.linux-mips.net>
References: <20020731004702.A2142@dea.linux-mips.net> <Pine.GSO.3.96.1020731133006.10088A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020731133006.10088A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jul 31, 2002 at 01:34:17PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 31, 2002 at 01:34:17PM +0200, Maciej W. Rozycki wrote:

> > Nope, on R4000 four cycles are needed between the tlbwr and a eret
> > instruction; on the R4600 just two.
> 
>  Ugh, I missed this entirely, thanks for pointing it out.  The doc implies
> three cycles for the R4000 actually, though. 

I doublechecked the docs for the R4700 as well - just one cycle needed
between a tlbw and eret.

  Ralf
