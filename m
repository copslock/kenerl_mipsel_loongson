Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDMS7P04298
	for linux-mips-outgoing; Thu, 13 Dec 2001 14:28:07 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBDMS4o04295
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 14:28:04 -0800
Received: from drow by nevyn.them.org with local (Exim 3.33 #1 (Debian))
	id 16EdOS-0001os-00; Thu, 13 Dec 2001 16:27:52 -0500
Date: Thu, 13 Dec 2001 16:27:52 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: .section problems in entry.S
Message-ID: <20011213162752.A6983@nevyn.them.org>
References: <20011209221835.A11737@dea.linux-mips.net> <Pine.GSO.3.96.1011210165719.24010A-100000@delta.ds2.pg.gda.pl> <20011213184541.A7171@dea.linux-mips.net> <20011213221254.G487@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011213221254.G487@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 13, 2001 at 10:12:54PM +0100, Thiemo Seufer wrote:
> Ralf Baechle wrote:
> [snip]
> > >  There are no working released binutils for a modern MIPS/Linux system,
> > > AFAIK.  However, version 2.11.92 from the CVS seems to work reasonably
> > > well now, so chances are the next release will do as well.  Maybe 2.12
> > > will be a good candidate then, once it is released and tested a bit. 
> > 
> > What is the schedule for 2.12?
> 
> AFAIK it is to be done in parallel to the GCC schedule:
>   2001-12-15  Functionality freeze.
>   2002-02-15  Branch for gcc 3.1 and binutils 2.12.
>   2002-04-15  Release.

Where did you get this information from?

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
