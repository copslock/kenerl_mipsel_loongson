Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f65HtCm23420
	for linux-mips-outgoing; Thu, 5 Jul 2001 10:55:12 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f65HtBV23417
	for <linux-mips@oss.sgi.com>; Thu, 5 Jul 2001 10:55:11 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f65HsN006439;
	Thu, 5 Jul 2001 10:54:23 -0700
Message-ID: <3B44A91A.6AA110FC@mvista.com>
Date: Thu, 05 Jul 2001 10:51:22 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Florian Lohoff <flo@rfc822.org>, Ralf Baechle <ralf@uni-koblenz.de>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: linux 2.4.5: sysmips(MIPS_ATOMIC_SET) is broken (yep, again...)
References: <Pine.GSO.3.96.1010705164106.14107A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

 "Maciej W. Rozycki" wrote:
> 
> On Thu, 5 Jul 2001, Florian Lohoff wrote:
> 
> > >  The R3k variant works fine for me.  I was unable to thest the ll/sc one,
> > > but the semantics should be unchanged, i.e. if it worked before, so it
> > > will now.  The patch should go into Linus' tree as well.
> >
> > How is this patch supposed to work in the means of how does it come around
> > the -MAXERRNO stuff in scall32 ?
> 
>  It works as far as sysmips(MIPS_ATOMIC_SET) can.  It does not add
> anything new -- it merely fixes what is obviously broken (falling through
> to MIPS_FIXADE from MIPS_ATOMIC_SET for non-ll/sc CPUs, what is being
> currently done, is not the most brilliant idea, either).  For better
> handling I encourage you to use the _test_and_set patch I've sent here
> recently.  I'm using it exclusively for a few weeks now.
> 
>  I do not intend to maintain sysmips(MIPS_ATOMIC_SET) beyond fixing
> obviously broken stuff.  I'm voting only to keep it until we have a
> replacement.  It should go away in 2.5 for sure -- if you recall the
> recent discussion, the conclusion was it's not really needed if we can
> satisfy glibc differently.
> 

That was the conclusion, but did not make to the CVS tree, probably due to
Ralf's unwillingness to take a overhead for "flawed" CPUs.

In my last patch for Vr41xx, I have a patch for this.  Basically, I will send
a SIGSYS if the return value is a small negative.  This will practically
satify all the need while keep the change minimum.  The small modification to
the semantic is not too bad at all if you consider the original syscall
semantic is already badly broken.


Jun
