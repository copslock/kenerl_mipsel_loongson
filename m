Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6MIgIRw001840
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 11:42:19 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6MIgIoG001839
	for linux-mips-outgoing; Mon, 22 Jul 2002 11:42:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft19-f32.dialo.tiscali.de [62.246.19.32])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6MIgCRw001830
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 11:42:13 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6MIguv22773;
	Mon, 22 Jul 2002 20:42:56 +0200
Date: Mon, 22 Jul 2002 20:42:56 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>, linux-mips@oss.sgi.com
Subject: Re: DECStation: Support for PMAZ-AA TC SCSI card?
Message-ID: <20020722204256.A22770@dea.linux-mips.net>
References: <20020722154405.A29300@dea.linux-mips.net> <Pine.GSO.3.96.1020722192254.2373M-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020722192254.2373M-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jul 22, 2002 at 07:32:04PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 22, 2002 at 07:32:04PM +0200, Maciej W. Rozycki wrote:

> > We had some discussion with the IA64 guys at SGI on how to handle this
> > kind of I/O ordering issues.  We never came to a final conclusion but
> > the proposal was the introduction of separate memory barriers macros for
> > I/O stuff.  Anyway, I think for the moment we should go with your proposal.
> 
>  Well, nothing stops code from evolving -- if there is a need for a more
> finegrained choice of macros, we may fulfill it, don't we?

Frequently a 80% solution is the worst possible because the remaining
unsolved 20% are not enough inclination to get things fixed.  However in
this particular case I agree with you.

  Ralf
