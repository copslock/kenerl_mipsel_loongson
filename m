Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6C0RIRw027122
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 17:27:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6C0RI1D027121
	for linux-mips-outgoing; Thu, 11 Jul 2002 17:27:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft18-f102.dialo.tiscali.de [62.246.18.102])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6C0RBRw027112
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 17:27:13 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6C0Osc16584;
	Fri, 12 Jul 2002 02:24:54 +0200
Date: Fri, 12 Jul 2002 02:24:54 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Gleb O. Raiko" <raiko@niisi.msk.ru>, Carsten Langgaard <carstenl@mips.com>,
   Jon Burgess <Jon_Burgess@eur.3com.com>, linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
Message-ID: <20020712022454.A16457@dea.linux-mips.net>
References: <20020711131247.A11700@dea.linux-mips.net> <Pine.GSO.3.96.1020711185642.7876I-100000@delta.ds2.pg.gda.pl> <15662.3715.334923.669657@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15662.3715.334923.669657@gladsmuir.algor.co.uk>; from dom@algor.co.uk on Fri, Jul 12, 2002 at 12:02:27AM +0100
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 12, 2002 at 12:02:27AM +0100, Dominic Sweetman wrote:

> PS: my standard appeal.  When you say you 'flush' a cache do you mean
> invalidate, write-back, or both?  If (as I suspect) not all of you
> mean the same thing, should you not instead speak of 'invalidate' and
> 'writeback'... sloppy language surely leads to sloppy programming?

I already had discussions with 68k people about this problem of
terminology.  It seems there is no unambigous terms for the whole
``cachology'' in the industry.

  Ralf
