Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g77B5HRw032515
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 7 Aug 2002 04:05:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g77B5HHl032514
	for linux-mips-outgoing; Wed, 7 Aug 2002 04:05:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft19-f33.dialo.tiscali.de [62.246.19.33])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g77B59Rw032504
	for <linux-mips@oss.sgi.com>; Wed, 7 Aug 2002 04:05:11 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g77A9cp13920;
	Wed, 7 Aug 2002 12:09:38 +0200
Date: Wed, 7 Aug 2002 12:09:38 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: PCI patch of the day
Message-ID: <20020807120938.A13850@dea.linux-mips.net>
References: <3D50D857.E2DDC84F@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D50D857.E2DDC84F@mips.com>; from carstenl@mips.com on Wed, Aug 07, 2002 at 10:20:39AM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 07, 2002 at 10:20:39AM +0200, Carsten Langgaard wrote:

> It's apparently not that easy to get the PCI code right, the current
> code won't compile, so here is the patch of the day.

Sigh, yes.  The whole flushing thing was done improperly and the patches
to fix that which I was integrating last night were not right either.  The
big question for me is why nobody was complaining or is suddently everybody
only using coherent machines ...

And all the DAC stuff also wants to be implemented.  We've got a bunch of
cruel hacks for the sake of IP27 and want to get rid of those.  The god
news is that now 32-bit and 64-bit pci.h are identical :-)

  Ralf
