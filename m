Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BHrbW15206
	for linux-mips-outgoing; Mon, 11 Feb 2002 09:53:37 -0800
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BHrY915197
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 09:53:34 -0800
Received: from js by hell with local (Exim 3.33 #1 (Debian))
	id 16aJhl-0000rU-00; Mon, 11 Feb 2002 17:53:25 +0100
Date: Mon, 11 Feb 2002 17:53:25 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Florian Lohoff <flo@rfc822.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: gcc include strangeness
Message-ID: <20020211165325.GB3261@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Florian Lohoff <flo@rfc822.org>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
References: <20020209150155.GA853@paradigm.rfc822.org> <Pine.GSO.3.96.1020211134516.18917A-100000@delta.ds2.pg.gda.pl> <20020211135302.GB30314@paradigm.rfc822.org> <20020211142708.GA2577@convergence.de> <20020211153732.GA31248@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020211153732.GA31248@paradigm.rfc822.org>
User-Agent: Mutt/1.3.27i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 11, 2002 at 04:37:32PM +0100, Florian Lohoff wrote:
> On Mon, Feb 11, 2002 at 03:27:08PM +0100, Johannes Stezenbach wrote:
> > 
> > The glibc-2.2.5/FAQ says:
> >   1.20.   Which tools should I use for MIPS?
> > 
> >   {AJ} You should use the current development version of gcc 3.0 or newer from
> >   CVS.  gcc 2.95.x does not work correctly on mips-linux.
> > 
> 
> Its not about gcc development but rather keeping a distribution in
> sync. All Debian archs try to use the same compiler which is currently
> 2.95.4 which we are happy with right now - Except some minor issues
> breaking 2-3 Packages ...

So does this mean that Debian's gcc 2.95.4 works on MIPS?
Does it include patches which are not in CVS (gcc-2_95-branch)?


Regards,
Johannes
