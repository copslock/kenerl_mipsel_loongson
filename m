Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA57466 for <linux-archive@neteng.engr.sgi.com>; Sun, 2 Aug 1998 02:53:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA44046
	for linux-list;
	Sun, 2 Aug 1998 02:53:06 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA05161
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 2 Aug 1998 02:53:02 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA09671
	for <linux@cthulhu.engr.sgi.com>; Sun, 2 Aug 1998 02:52:57 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id LAA09550;
	Sun, 2 Aug 1998 11:52:55 +0200 (MEST)
Received: by thoma (SMI-8.6/KO-2.0)
	id LAA03862; Sun, 2 Aug 1998 11:52:53 +0200
Message-ID: <19980802115253.04102@uni-koblenz.de>
Date: Sun, 2 Aug 1998 11:52:53 +0200
From: ralf@uni-koblenz.de
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux@cthulhu.engr.sgi.com
Subject: Re: FYI newport abscon
References: <19980802022907.05519@alpha.franken.de> <Pine.LNX.3.95.980802003721.4859A-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.LNX.3.95.980802003721.4859A-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sun, Aug 02, 1998 at 12:39:37AM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Aug 02, 1998 at 12:39:37AM -0400, Alex deVries wrote:

> On Sun, 2 Aug 1998, Thomas Bogendoerfer wrote:
> > yesterday I managed to bring up my Indy with the new console code riped
> > out from 2.1.109. Today I've implemented new scrolling stuff for newport
> > abscon, which will give us a really fast console. 
> 
> This is very, very cool, and much needed to go on with 2.1.x kernel
> development.  
> 
> > My simple test program, 
> > which does 1000 printf("\n") in a loop, gives me about 62000 lines/second
> > on a 160x64 sized console. I also tried that program on my Dual P-233
> > with a Matrox Millenium and got about 260000 lines/s on a 80x25 sized
> > console (which is less than 1/5 the size of the Indy console).
> > 
> 
> Well, this is very cool.  What kind of use is this?  aalib... man, that'll
> be neat.  To hell with X when you have aalib.

Is there MesaGL support for aalib ;-)

Actually aalib is already performing pretty nicely on the old console.
However the ``linux'' driver doesn't work right due to some console bug;
one has to use the slang driver.  So aa is more a test of the correctness
than the performance.

  Ralf
