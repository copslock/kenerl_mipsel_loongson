Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f65F9Ap19128
	for linux-mips-outgoing; Thu, 5 Jul 2001 08:09:10 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f65F91V19124
	for <linux-mips@oss.sgi.com>; Thu, 5 Jul 2001 08:09:06 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA16850;
	Thu, 5 Jul 2001 17:08:36 +0200 (MET DST)
Date: Thu, 5 Jul 2001 17:08:36 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: linux 2.4.5: sysmips(MIPS_ATOMIC_SET) is broken (yep, again...)
In-Reply-To: <20010705162705.B6963@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010705164106.14107A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 5 Jul 2001, Florian Lohoff wrote:

> >  The R3k variant works fine for me.  I was unable to thest the ll/sc one,
> > but the semantics should be unchanged, i.e. if it worked before, so it
> > will now.  The patch should go into Linus' tree as well. 
> 
> How is this patch supposed to work in the means of how does it come around
> the -MAXERRNO stuff in scall32 ?

 It works as far as sysmips(MIPS_ATOMIC_SET) can.  It does not add
anything new -- it merely fixes what is obviously broken (falling through
to MIPS_FIXADE from MIPS_ATOMIC_SET for non-ll/sc CPUs, what is being
currently done, is not the most brilliant idea, either).  For better
handling I encourage you to use the _test_and_set patch I've sent here
recently.  I'm using it exclusively for a few weeks now. 

 I do not intend to maintain sysmips(MIPS_ATOMIC_SET) beyond fixing
obviously broken stuff.  I'm voting only to keep it until we have a
replacement.  It should go away in 2.5 for sure -- if you recall the
recent discussion, the conclusion was it's not really needed if we can
satisfy glibc differently. 

 I'd like to see Linus' 2.4.x working on R3k, OTOH.  It would be very
unfortunate if the official 2.4.x didn't work on R3k, just like 2.2.x (and
patches for 2.2.x were available at that time!). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
