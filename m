Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA2529038 for <linux-archive@neteng.engr.sgi.com>; Sun, 26 Apr 1998 04:15:47 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA16693238
	for linux-list;
	Sun, 26 Apr 1998 04:14:42 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA15900864
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 26 Apr 1998 04:14:41 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id EAA11671
	for <linux@cthulhu.engr.sgi.com>; Sun, 26 Apr 1998 04:14:39 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-08.uni-koblenz.de [141.26.249.8])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id NAA15214
	for <linux@cthulhu.engr.sgi.com>; Sun, 26 Apr 1998 13:14:37 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id NAA11613;
	Sun, 26 Apr 1998 13:14:23 +0200
Message-ID: <19980426131423.56494@uni-koblenz.de>
Date: Sun, 26 Apr 1998 13:14:23 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: gcc RPM missing crtbegin.o
References: <19980426053938.20282@uni-koblenz.de> <Pine.LNX.3.95.980426002620.16850A-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980426002620.16850A-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sun, Apr 26, 1998 at 12:34:54AM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Apr 26, 1998 at 12:34:54AM -0400, Alex deVries wrote:

> On Sun, 26 Apr 1998 ralf@uni-koblenz.de wrote:

> Yup, I've had this problem twice now, both with .91. I'm pretty sure I can
> reproduce it (but not until I'm at my desk tomorrow, since I need to hit
> the little thumbtack to reboot it.  I still think SGI should have shipped
> the Indys with thumbtacks.)

If you think that was a missfeature, take a look at SNI's RM200C.  It's has
the reset button mounted directly on the motherboard.  Which is why my
machine has never been closed.  And really f*cked idea for something which
had NT as OS option ;-)

Ho humm...  If I remember right the Indy has some watchdog onboard.  Time
to use it.

> > > $0 : 00000000 1000fc00 00001000 ffffffe0
> > > $4 : 00000020 00000000 1000fc00 00000001
> > > $8 : 1000fc00 1000001f 00000000 00000007
> > > $12: 40000000 8bf50020 1000fc00 00000001
> > > $16: 00000000 00001000 abf56020 8bf53800
> > > $20: 00000002 bfbc0003 1fffffff bfb90000
> > > $24: 00000002 0fb6f710 
> > > $28: 00008000 08009d28 8bf57e70 080f3b5c
> >                                   ^^^^^^^^
> > > epc   :88020fc0
> >          ^^^^^^^^
> > tell me where these two addresses are pointing to?  Just send me twenty
> > lines or so around the addresses.  (In general that's the right thing to
> > do when the machine bombs with a register dump.)
> > (Also I'm pretty shure that you misstyped $28 and $29 or something really
> > bad happend.)
> 
> Uh, there was nothing at 080f3b5c or nearby, so I'm pretty sure that that
> was misttyped as 880f3b5c.  Here are both:

Thanks.  Both addresses are pointing to code which is important for the
SCSI driver's correctness.  I'll do some more philosophy about the register
dump later.

  Ralf
