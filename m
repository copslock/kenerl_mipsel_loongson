Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g72AEjRw030321
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 2 Aug 2002 03:14:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g72AEjYC030320
	for linux-mips-outgoing; Fri, 2 Aug 2002 03:14:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f126.dialo.tiscali.de [62.246.17.126])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g72AEcRw030310
	for <linux-mips@oss.sgi.com>; Fri, 2 Aug 2002 03:14:40 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g72AG0H03001;
	Fri, 2 Aug 2002 12:16:00 +0200
Date: Fri, 2 Aug 2002 12:16:00 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [update] [patch] linux: Cache coherency fixes
Message-ID: <20020802121600.A27824@dea.linux-mips.net>
References: <20020801152500.A31808@dea.linux-mips.net> <Pine.GSO.3.96.1020801173504.8256H-100000@delta.ds2.pg.gda.pl> <20020801184929.B22824@dea.linux-mips.net> <20020801170649.GB15334@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020801170649.GB15334@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Thu, Aug 01, 2002 at 07:06:49PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 01, 2002 at 07:06:49PM +0200, Thiemo Seufer wrote:

> [snip]
> > Back in time I prefered CONFIG_NONCOHERENT_IO over CONFIG_COHERENT_IO
> > because the noncoherent case needs additional code and in general I'm
> > trying to reduce the number of the #if !defined conditionals for easier
> > readability.
> > 
> > The R10000 is our standard example why looking at the processor type doesn't
> > work.  It's used in coherent mode in IP27 but in coherent mode but in
> > coherent mode in IP28 or IP32.  Otoh I don't know of any system that
> 
> JFTR: non-coherent mode in IP28 or IP32.

Yep, you're right.  I hope everybody concluded that from my non-coherent
sentence ;-)
