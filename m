Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 May 2006 18:20:54 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42404 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8126579AbWELQUq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 12 May 2006 18:20:46 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4CGKjnR022670;
	Fri, 12 May 2006 17:20:45 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4CGKhYX022669;
	Fri, 12 May 2006 17:20:43 +0100
Date:	Fri, 12 May 2006 17:20:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Karel van Houten <Karel@vhouten.xs4all.nl>,
	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: 2.6 for DECstation, d-i
Message-ID: <20060512162042.GA22611@linux-mips.org>
References: <44635C0D.7040901@vhouten.xs4all.nl> <20060511173350.GM7827@deprecation.cyrius.com> <Pine.LNX.4.64N.0605111853500.20004@blysk.ds.pg.gda.pl> <20060511185446.GB7234@deprecation.cyrius.com> <Pine.LNX.4.64N.0605121142240.14216@blysk.ds.pg.gda.pl> <20060512151201.GJ7863@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060512151201.GJ7863@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 12, 2006 at 05:12:01PM +0200, Martin Michlmayr wrote:

> * Maciej W. Rozycki <macro@linux-mips.org> [2006-05-12 11:57]:
> > > Yeah, but the problem is that ZS is not a config option anymore.  I
> > > hacked up something to see if the driver works but I guess there's a
> > > nicer solution.
> >  Of course there is.  Just enable SERIAL_NONSTANDARD, SERIAL_DEC, 
> > SERIAL_DEC_CONSOLE and ZS.  They are all in drivers/char/Kconfig and it's 
> > not a coincidence the options are the same as in 2.4.
> 
> Hmm, okay, they are in the linux-mips tree, but not in mainline. :/

And they won't go there just like any other drivers/char/ serial driver..

  Ralf
