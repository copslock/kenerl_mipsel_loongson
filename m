Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g67JFSRw032648
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 7 Jul 2002 12:15:28 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g67JFSn2032647
	for linux-mips-outgoing; Sun, 7 Jul 2002 12:15:28 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (free197-x30.dialo.tiscali.de [62.246.30.197] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g67JFLRw032638
	for <linux-mips@oss.sgi.com>; Sun, 7 Jul 2002 12:15:23 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g67JJU632345;
	Sun, 7 Jul 2002 21:19:30 +0200
Date: Sun, 7 Jul 2002 21:19:30 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Muthukumar Ratty <muthu5@sbcglobal.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: MIPS Atlas board
Message-ID: <20020707211930.A26692@dea.linux-mips.net>
References: <20020703235506.A21798@dea.linux-mips.net> <Pine.LNX.4.33.0207071055220.25811-100000@Muruga.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0207071055220.25811-100000@Muruga.localdomain>; from muthu5@sbcglobal.net on Sun, Jul 07, 2002 at 11:09:00AM -0700
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-3.1 required=5.0 tests=IN_REP_TO,MAY_BE_FORGED version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Jul 07, 2002 at 11:09:00AM -0700, Muthukumar Ratty wrote:

> > Anybody actually still using the MIPS Atlas board?  If so, what kernel
> > versions?  I've not had any feedback about the Atlas in many moons, so
> > I'm considering to drop support for it for 2.5.  Comment?
> 
> Oh no, I am using Atlas board with 2.4 kernel and I know few others also
> using it (guess they dont care anymore :( .  If its not a time killer
> could you please add it to 2.5 also.

Ok.  Consider my posting simply a poll, nothing more.

> BTW I was running network performance tools and the max I could read from
> Atlas board is ~0.3M. Is this a problem with the hardware?

Hard to say without any kind of closer analysis.  The number certainly
seems to be too low.  What network benchmark did you run, what processor
and clock rate does your Atlas have?

  Ralf
