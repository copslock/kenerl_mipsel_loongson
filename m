Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g55FcFnC017998
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 5 Jun 2002 08:38:15 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g55FcFYn017996
	for linux-mips-outgoing; Wed, 5 Jun 2002 08:38:15 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g55FbsnC017885
	for <linux-mips@oss.sgi.com>; Wed, 5 Jun 2002 08:37:57 -0700
Received: from gladsmuir.algor.co.uk (gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g55Fdid20257;
	Wed, 5 Jun 2002 16:39:45 +0100 (BST)
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15614.12481.424601.806779@gladsmuir.algor.co.uk>
Date: Wed, 5 Jun 2002 16:39:45 +0100
To: Eric Christopher <echristo@redhat.com>
Cc: Dominic Sweetman <dom@algor.co.uk>,
   Johannes Stezenbach <js@convergence.de>, gcc@gcc.gnu.org,
   linux-mips@oss.sgi.com, sde@algor.co.uk
Subject: Re: [Fwd: Current state of MIPS16 support?]
In-Reply-To: <1022870431.3668.19.camel@ghostwheel.cygnus.com>
References: <3CBFEAA9.9070707@algor.co.uk>
	<15566.28397.770794.272735@gladsmuir.algor.co.uk>
	<1022870431.3668.19.camel@ghostwheel.cygnus.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Eric,

> The backend has changed a bit in the time, however, it hasn't
> changed so much that the patches would be that difficult for you to
> bring forward.
>
> I encourage you to reconsider contributing them. 

I fear it's "when time permits" at the moment.  The number of changes
is sufficiently large that it will take concentrated effort for 2-4
weeks, and this is very difficult to find.

> > We're working (with funding from MIPS Technologies) on building a
> > toolchain which:
> > 
> > o Can build Linux kernel, libraries and applications alike;
> > 
> > o Is substantially more efficient than other GCC versions when
> >   producing MIPS application ("MIPS/ABI", PIC) code;
> > 
> > o Will produce ugly-but-correct PIC code for MIPS16 functions, so
> >   MIPS16 can be tested in a standard Linux environment;
> > 
> > o Operates to a known and documented ABI (even the forgotten details,
> >   like gprof...)
> > 
> > (The modesty of those ambitions should be measured against the reality
> > of today's Linux/MIPS...)
> 
> I'm not certain what you are actually fixing here as I've not seen any
> descriptions of problems here...

Hmm.  Linux/MIPS suffers from widespread and diffuse toolchain
problems: I thought that much was pretty clear to all involved.  I
agree it seems a pity that the scheme of work laid out above should be
necessary...

> I'd love to fix any problems that you've had reported in the
> mainline sources so that everyone can get the benefit of the work
> you are doing.

Rather than snow you with a hundred compiler patches, I wonder whether
it might be better to share our regression test changes?  The tests
are likely to be a whole lot more portable than compiler patches.  If
you run them on a recent GCC 3.x compiler, you'll be in a much better
position to know to what extent our 2.96+ work is still relevant.

If this seems a good idea please mailto:sde@algor.co.uk and we'll ftp
the test sources to the place of your choice, or point you at them on
our web server.

> I'm putting in a lot of effort to cleaning up the MIPS port and am
> committed to the architecture. 

It sounds like you're in the role of maintainer of GCC for MIPS
targets.  You may not be free to answer this: but does that mean that
Red Hat have guaranteed you'll have the time to fulfill that
responsibility even during periods when Red Hat don't happen to win
relevant contracts from MIPS vendors?

If so that would be excellent...

> > It's a pity that the different priorities of various funders and
> > developers mean that there is no baseline toolkit for Linux/MIPS, so
> > that such resources as are available are frequently used to re-invent
> > the wheel.
> > 
> > Anyone got any ideas how to make it better?
>
> The problem as I see it is that no one wants/cares to contribute their
> changes back that they make, or at least file bug reports against the
> problems that they have.

During most of the last few years (as I understand it) it has been
difficult to establish a baseline to patch against, or find someone
who had the time to attend to bug reports.

As you'll know it's much harder to test the compiler as used for
'embedded' targets, because the diversity of OS' used makes it
hard to re-use tests.  Something better should be possible now
Linux/MIPS is less flaky.

> Almost 90% of the bug reports I see are against IRIX.

That does suggest you're missing some pretty large chunks of the
community!

> People have to "re-invent the wheel" because the changes never make
> it back into the official sources - everyone has their own one offs.
> If we fix this then the work that all of the disparate groups are
> doing will at least go toward a common goal. 

We believe that a large number of man hours will be required to
identify and merge all major valuable features and then chase out
the bugs, before there can be a release which everyone has reason to
adopt.

We certainly can't afford to put in those hours unless we win
contracts; I suspect Red Hat can't, either.

-- 
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone +44 1223 706200/fax +44 1223 706250/direct +44 1223 706205
http://www.algor.co.uk
