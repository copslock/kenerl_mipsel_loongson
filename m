Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDMSVc04330
	for linux-mips-outgoing; Thu, 13 Dec 2001 14:28:31 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBDMSGo04323;
	Thu, 13 Dec 2001 14:28:16 -0800
Received: from drow by nevyn.them.org with local (Exim 3.33 #1 (Debian))
	id 16EdOq-0001p6-00; Thu, 13 Dec 2001 16:28:16 -0500
Date: Thu, 13 Dec 2001 16:28:16 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Kip Walker <kwalker@broadcom.com>, linux-mips@oss.sgi.com
Subject: Re: .section problems in entry.S
Message-ID: <20011213162816.B6983@nevyn.them.org>
References: <20011209221835.A11737@dea.linux-mips.net> <Pine.GSO.3.96.1011210165719.24010A-100000@delta.ds2.pg.gda.pl> <20011213184541.A7171@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011213184541.A7171@dea.linux-mips.net>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 13, 2001 at 06:45:42PM -0200, Ralf Baechle wrote:
> On Mon, Dec 10, 2001 at 05:03:41PM +0100, Maciej W. Rozycki wrote:
> 
> > > Certainly not.  The problem is known and so far I've just hacked around
> > > it more or less elegant.  But it's a trap and so I think we've got good
> > > reasons to force people to upgrade to a newer assembler than the current
> > > minimal version.  The question is which - I don't like frequent tool
> > > upgrades.
> > 
> >  There are no working released binutils for a modern MIPS/Linux system,
> > AFAIK.  However, version 2.11.92 from the CVS seems to work reasonably
> > well now, so chances are the next release will do as well.  Maybe 2.12
> > will be a good candidate then, once it is released and tested a bit. 
> 
> What is the schedule for 2.12?

There isn't one yet; I'm hoping within three months.  I'm going to try
to roll the ball a little this week.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
