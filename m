Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDMbro04603
	for linux-mips-outgoing; Thu, 13 Dec 2001 14:37:53 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBDMbmo04600
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 14:37:48 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBDLbUP06934;
	Thu, 13 Dec 2001 19:37:30 -0200
Date: Thu, 13 Dec 2001 19:37:30 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Kip Walker <kwalker@broadcom.com>, linux-mips@oss.sgi.com
Subject: Re: .section problems in entry.S
Message-ID: <20011213193730.A6724@dea.linux-mips.net>
References: <20011209221835.A11737@dea.linux-mips.net> <Pine.GSO.3.96.1011210165719.24010A-100000@delta.ds2.pg.gda.pl> <20011213184541.A7171@dea.linux-mips.net> <20011213162816.B6983@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011213162816.B6983@nevyn.them.org>; from dan@debian.org on Thu, Dec 13, 2001 at 04:28:16PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 13, 2001 at 04:28:16PM -0500, Daniel Jacobowitz wrote:
> Date: Thu, 13 Dec 2001 16:28:16 -0500
> From: Daniel Jacobowitz <dan@debian.org>
> To: Ralf Baechle <ralf@oss.sgi.com>
> Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
>         Kip Walker <kwalker@broadcom.com>, linux-mips@oss.sgi.com
> Subject: Re: .section problems in entry.S
> 
> On Thu, Dec 13, 2001 at 06:45:42PM -0200, Ralf Baechle wrote:
> > On Mon, Dec 10, 2001 at 05:03:41PM +0100, Maciej W. Rozycki wrote:
> > 
> > > > Certainly not.  The problem is known and so far I've just hacked around
> > > > it more or less elegant.  But it's a trap and so I think we've got good
> > > > reasons to force people to upgrade to a newer assembler than the current
> > > > minimal version.  The question is which - I don't like frequent tool
> > > > upgrades.
> > > 
> > >  There are no working released binutils for a modern MIPS/Linux system,
> > > AFAIK.  However, version 2.11.92 from the CVS seems to work reasonably
> > > well now, so chances are the next release will do as well.  Maybe 2.12
> > > will be a good candidate then, once it is released and tested a bit. 
> > 
> > What is the schedule for 2.12?
> 
> There isn't one yet; I'm hoping within three months.  I'm going to try
> to roll the ball a little this week.

Longer than I'd like to see.  Anybody got a sufficiently hacked version
of ~ 2.11?

  Ralf
