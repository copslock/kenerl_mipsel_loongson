Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6MDhXRw023737
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 06:43:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6MDhX2x023736
	for linux-mips-outgoing; Mon, 22 Jul 2002 06:43:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft18-f216.dialo.tiscali.de [62.246.18.216])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6MDhPRw023726
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 06:43:27 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6MDi5I29405;
	Mon, 22 Jul 2002 15:44:05 +0200
Date: Mon, 22 Jul 2002 15:44:05 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>, linux-mips@oss.sgi.com
Subject: Re: DECStation: Support for PMAZ-AA TC SCSI card?
Message-ID: <20020722154405.A29300@dea.linux-mips.net>
References: <200207191708.TAA04858@sparta.research.kpn.com> <Pine.GSO.3.96.1020722132706.2373A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020722132706.2373A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jul 22, 2002 at 02:21:13PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 22, 2002 at 02:21:13PM +0200, Maciej W. Rozycki wrote:

>  I hope so.  I'm begging Ralf for about half a year, sigh...  The subject
> was beaten to death at the list and the feedback looked positive to me
> (after a few doubts were resolved), but Ralf seems to be unhappy with the
> changes due to some ia64 interactions (I'm still not sure which ones,
> though).  Ralf, could you please elaborate? 
> 
>  Otherwise, your case convinces me I should not care about purity or
> cross-platform consistency of code in this area, anymore.  I've been
> observing problems with interrupts due to the lack of iomem access
> synchronization already, but unlike for your PMAZ-A problem, their result
> was more of annoyance than instability.  Since stability is a priority,
> although reluctantly, I will rework the changes to apply to the DECstation
> code only, to keep others happy.  The interface won't change, apart from
> resolving namespace clashes.

We had some discussion with the IA64 guys at SGI on how to handle this
kind of I/O ordering issues.  We never came to a final conclusion but
the proposal was the introduction of separate memory barriers macros for
I/O stuff.  Anyway, I think for the moment we should go with your proposal.

  Ralf
