Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA81925 for <linux-archive@neteng.engr.sgi.com>; Fri, 15 Jan 1999 14:01:52 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA14282
	for linux-list;
	Fri, 15 Jan 1999 14:00:01 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA70701;
	Fri, 15 Jan 1999 13:59:54 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA00689; Fri, 15 Jan 1999 13:59:52 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from eddie (ralf@eddie.uni-koblenz.de [141.26.4.17])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with SMTP id WAA05655;
	Fri, 15 Jan 1999 22:59:20 +0100 (MET)
Received: by eddie (SMI-8.6/KO-2.0)
	id WAA10128; Fri, 15 Jan 1999 22:59:18 +0100
Message-ID: <19990115225918.25643@uni-koblenz.de>
Date: Fri, 15 Jan 1999 22:59:18 +0100
To: Ariel Faigon <ariel@cthulhu.engr.sgi.com>
Cc: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>,
        adevries@engsoc.carleton.ca, Richard Hartensveld <richard@infopact.nl>
Subject: Re: linus.linux.sgi.com
References: <369F8C88.39CC6B03@infopact.nl> <199901151909.LAA23245@oz.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <199901151909.LAA23245@oz.engr.sgi.com>; from Ariel Faigon on Fri, Jan 15, 1999 at 11:09:53AM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jan 15, 1999 at 11:09:53AM -0800, Ariel Faigon wrote:

> Looks like I need to give a status update on linus.linux.sgi.com.
> 
> First, let me tell you all that I'm really taken aback by this
> situation.  I've seen postings on slashdot.org suggesting that
> SGI has taken this machine down because it is in bed with
> Microsoft etc. etc. and all kinds of negative speculation and
> nonsense.  I was even contacted by the press on this (could
> you believe that :-)  Let me make it very clear:
> 
> 	1) No one at SGI has taken this service down and
> 	   guess what: we are going to bring it back up again.
> 
> 	2) The machine itself is not down. The problem is in the
> 	   routing to the machine and from what I last heard,
> 	   it seems to be a hardware problem.

The tracroute I just did looks like a) SGI's engineering pipe needs a
serious upgrade due to packet loss and b) there is a routing loop somewhere.
So if the router people can't fix it maybe moivng the machine to an address
which actually has a functional setup?

> 	4) The timing when this thing decided to break (close to the
> 	   announcement of the SGI Visual Workstation) is purely
> 	   coincidental.

Seconded.  SGI (and actually the whole industry) is _W_A_Y_ more OSS
friendly than /. rumors say.

Quite frankly, having to answer several private emails aobut this topic I'm
still surprised how much policital damage a stupid messed up route can
cause.

  Ralf
