Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA12730 for <linux-archive@neteng.engr.sgi.com>; Wed, 29 Jul 1998 11:21:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA34431
	for linux-list;
	Wed, 29 Jul 1998 11:20:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id LAA74425;
	Wed, 29 Jul 1998 11:20:22 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA21260; Wed, 29 Jul 1998 11:19:48 -0700
Date: Wed, 29 Jul 1998 11:19:48 -0700
Message-Id: <199807291819.LAA21260@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: "William J. Earl" <wje@fir.engr.sgi.com>, 4819 <rmk@shell.mdc.net>,
        linux@cthulhu.engr.sgi.com
Subject: Re: sound, power button, volume buttons
In-Reply-To: <19980729185007.K771@uni-koblenz.de>
References: <Pine.BSI.3.96.980729001735.24028A-100000@shell.mdc.net>
	<19980729090902.D1989@uni-koblenz.de>
	<199807291540.IAA20337@fir.engr.sgi.com>
	<19980729185007.K771@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > On Wed, Jul 29, 1998 at 08:40:10AM -0700, William J. Earl wrote:
 > 
 > >      I can generally answer specific questions.  Also, I can arrange to send
 > > a copy of the documentation to people who want to actively work on the
 > > project.  (The informal limited distribution agreement was the basis on which
 > > the management agreed to let us release the documentation.)  
 > > 
 > >      People have asked about documentation for other products.  In general,
 > > I don't know where to find documentation for any of the SGI R3000-based systems.
 > 
 > Do you think a ``Call for dusty Paper'' CfdP (TM) on the Usenet in groups
 > like comp.sys.mips or comp.sys.sgi.* might make sense?  I bet there are
 > still people out there, maybe former SGI employees in the meantime which
 > have helpful data around.

     I doubt it would.  The behavior of the machines are documented in
the IRIX source (for IRIX 5.3 and earlier; support for R3000 systems
was dropped after that), but we cannot in general release that due to
our license agreements with the providers of some of that source.
With management approval, we might be able to release certain parts which
show the hardware interfaces and which only have an SGI copyright.  I 
will see what is possible.

 > > I do have incomplete documentation for some of the MIPS systems.
 > 
 > I'm currently doing some brain surgery on some OEM machine which identifies
 > itself as RS3230 and is running RISC/os 4.50 :-)

      I don't have much on that one, other than the RISC/os source,
although I did work on the RS3230.  The Magnum and Millenium 4000
systems are ARCS machines, with many PC-compatible parts, and I have
more information about them, but I gather that linux already runs on
them.

...
 > As I already wrote to Richard Masoner - it's not uncommon that people
 > write GPL software while being under NDA.  The company reviews the code
 > when it is finished and gives it's ok to publish it but the documentation
 > (whatever it consists of - paper, code, electronic files, drawings ...)
 > will stay undisclosed.  In many cases this is a way to keep both sides
 > happy.

     I will offer that option to the management; that might make it
easier to make the documentation (especially the relevant
SGI-copyright-only IRIX source) available.

 > Since you mentioned the various graphic subsystems above - do you think
 > the implementation of a ARC firmware text only based console might be
 > sensible?  I've got several requests for Linux from people who have a
 > XZ graphic which we don't support yet - and there is quite a number of
 > graphic options for SGI's out there so this might be somewhat helpful.

       Yes, I think one could use the same firmware interface as the
PROM.  I believe that it is even possible to do X that way, with limited
performance.  I am not familiar with the details of the PROM firmware interface,
but I will check it out when I have a bit more time. 
