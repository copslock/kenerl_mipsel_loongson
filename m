Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g71IlNRw010018
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 1 Aug 2002 11:47:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g71IlNkr010017
	for linux-mips-outgoing; Thu, 1 Aug 2002 11:47:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g71IlARw010008;
	Thu, 1 Aug 2002 11:47:11 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA12348;
	Thu, 1 Aug 2002 20:49:18 +0200 (MET DST)
Date: Thu, 1 Aug 2002 20:49:18 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [update] [patch] linux: Cache coherency fixes
In-Reply-To: <20020801195820.F22824@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020801204118.8256W-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 1 Aug 2002, Ralf Baechle wrote:

> techpubs.sgi.com should have a somewhat older manual (must have!) and
> www.necel.com as well.  The geniouses at NEC stripped the description of
> the cache instruction from their manual so it you really want both manuals.

 Thanks for the reference.

> >  Hmm, what's wrong with "#ifndef"?  Not much less readable than "#ifdef",
> > IMO. 
> 
> Just a small detail.  Nest conditions several times and the spaghetti
> starts :-)

 Well, that should be avoided whether the condition is positive or
negative.  Comments after "#else", "#elif" and "#end" might help a bit if
a discipline is kept. 

> > Basically:
> > 
> > 1. Does the CPU support coherency?
> > 
> > 2. If so, does the system?
> > 
> > I'm going to express it this way in the config script.
> 
> Have fun expressing if a R4000 variant supports coherency :-)  You can't
> if you don't want to introduce even more R4000 types or subtypes.

 Who said I don't want to? ;-)  Not a big deal at this stage.

> None such MIPS system known where this is a sensible mode of operation -
> and I've hacked quite a number of platforms.  Anyway, if there were such
> systems they'd either have to be considered as coherent or as non-coherent.

 Thanks for the clarification.

> Our current model doesn't permit any finer grained configuration and unless
> such a system actually exists I don't think we should introduce one.

 Sure, but a one point we'll have an option to select the model at the run
time anyway.  At least this is one of goals I'd like to see fulfilled in
the future. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
