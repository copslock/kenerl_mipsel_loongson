Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA25232 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Jun 1998 09:48:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA28500
	for linux-list;
	Mon, 22 Jun 1998 09:47:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA76583
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Jun 1998 09:47:18 -0700 (PDT)
	mail_from (miguel@roxanne.nuclecu.unam.mx)
Received: from roxanne.nuclecu.unam.mx (erandi.nuclecu.unam.mx [132.248.29.4]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id JAA03020
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 Jun 1998 09:47:15 -0700 (PDT)
	mail_from (miguel@roxanne.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by roxanne.nuclecu.unam.mx (8.8.7/8.8.7) id JAA00316;
	Fri, 19 Jun 1998 09:02:31 -0500
Date: Fri, 19 Jun 1998 09:02:31 -0500
Message-Id: <199806191402.JAA00316@roxanne.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: ralf@uni-koblenz.de
CC: adevries@engsoc.carleton.ca, linux@cthulhu.engr.sgi.com
In-reply-to: <19980618041807.C517@uni-koblenz.de> (ralf@uni-koblenz.de)
Subject: Re: Stuff that needs to be done.
X-Mexico: Este es un pais de orates, un pais amateur.
References: <Pine.LNX.3.95.980617141204.8736C-100000@lager.engsoc.carleton.ca> <19980618041807.C517@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> > kaffe
> >      Architecture unsupported.
> 
> This is nontrivial, as Miguel explained to me this'd require writing
> a JIT.

No.  A simplistic port of Kaffe to Linux/MIPS should not take more
than a couple of minutes.  Just the time to define what you can use to
do simplistic poking of some registers inside a signal handler.

There is not JIT for MIPS in Kaffe yet, so you only get the
interpreter at this point.

Miguel.
