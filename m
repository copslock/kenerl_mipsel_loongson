Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA02779 for <linux-archive@neteng.engr.sgi.com>; Sun, 18 Oct 1998 17:15:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA46269
	for linux-list;
	Sun, 18 Oct 1998 17:15:25 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id RAA09687;
	Sun, 18 Oct 1998 17:15:24 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id RAA15185; Sun, 18 Oct 1998 17:15:09 -0700
Date: Sun, 18 Oct 1998 17:15:09 -0700
Message-Id: <199810190015.RAA15185@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jeremy John Welling <jwelling@engin.umich.edu>,
        linux@cthulhu.engr.sgi.com
Subject: Re: XZ
In-Reply-To: <19981018015624.H4768@uni-koblenz.de>
References: <19981016214659.A2754@zigzegv.ml.org>
	<Pine.SOL.4.02.9810162113360.7062-100000@azure.engin.umich.edu>
	<19981017111725.D1121@alpha.franken.de>
	<19981018015624.H4768@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > On Sat, Oct 17, 1998 at 11:17:25AM +0200, Thomas Bogendoerfer wrote:
 > 
 > > If XZ isn't another name for newport, then no.
 > 
 > XL is the official name for the Newport.

    XZ is one of the variants of the Elan/Extreme series of cards,
which have one or more geometry engines on the card.  The geometry
engines need microcode downloaded for full functionality, and the
interfaces are not externally documented, so it is hard to build
linux support without access to the IRIX source for reference.
