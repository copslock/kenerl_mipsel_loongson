Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g55HtEnC013000
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 5 Jun 2002 10:55:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g55HtE87012999
	for linux-mips-outgoing; Wed, 5 Jun 2002 10:55:14 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nevyn.them.org (01-026.118.popsite.net [66.19.120.26])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g55Ht7nC012994
	for <linux-mips@oss.sgi.com>; Wed, 5 Jun 2002 10:55:08 -0700
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17FeyE-00016J-00; Wed, 05 Jun 2002 13:53:18 -0400
Date: Wed, 5 Jun 2002 13:53:18 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: Eric Christopher <echristo@redhat.com>,
   Johannes Stezenbach <js@convergence.de>, gcc@gcc.gnu.org,
   linux-mips@oss.sgi.com, sde@algor.co.uk
Subject: Re: [Fwd: Current state of MIPS16 support?]
Message-ID: <20020605175318.GA4030@nevyn.them.org>
Mail-Followup-To: Dominic Sweetman <dom@algor.co.uk>,
	Eric Christopher <echristo@redhat.com>,
	Johannes Stezenbach <js@convergence.de>, gcc@gcc.gnu.org,
	linux-mips@oss.sgi.com, sde@algor.co.uk
References: <3CBFEAA9.9070707@algor.co.uk> <15566.28397.770794.272735@gladsmuir.algor.co.uk> <1022870431.3668.19.camel@ghostwheel.cygnus.com> <15614.12481.424601.806779@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15614.12481.424601.806779@gladsmuir.algor.co.uk>
User-Agent: Mutt/1.5.1i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 05, 2002 at 04:39:45PM +0100, Dominic Sweetman wrote:
> > I'm not certain what you are actually fixing here as I've not seen any
> > descriptions of problems here...
> 
> Hmm.  Linux/MIPS suffers from widespread and diffuse toolchain
> problems: I thought that much was pretty clear to all involved.  I
> agree it seems a pity that the scheme of work laid out above should be
> necessary...

...

> > Almost 90% of the bug reports I see are against IRIX.
> 
> That does suggest you're missing some pretty large chunks of the
> community!

No, that's not what it suggests at all.  It suggests to me that the
dubious state of Linux/MIPS toolchains is due to one of two things:
  - A pre-existing acceptance of this rather than any real problems
  - A reluctance to file bug reports

We've been using GCC for MIPS for several years now and seen relatively
few significant problems, so I suspect the former.  There's definitely
some of the latter as well, since we've hit more roadblocks on MIPS
than on, say, x86 or PowerPC; it's not our worst problem architecture,
though.  And we've been able to fix them all relatively easily.

I'm sure GCC would benefit from access to your regression tests, though :)

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
