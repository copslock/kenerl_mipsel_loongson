Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id WAA490608 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Dec 1997 22:44:41 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA09482 for linux-list; Fri, 5 Dec 1997 22:38:11 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA09458 for <linux@cthulhu.engr.sgi.com>; Fri, 5 Dec 1997 22:38:05 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA19366
	for <linux@cthulhu.engr.sgi.com>; Fri, 5 Dec 1997 22:38:03 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-19.uni-koblenz.de [141.26.249.19])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id HAA22754
	for <linux@cthulhu.engr.sgi.com>; Sat, 6 Dec 1997 07:38:01 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id HAA09913;
	Sat, 6 Dec 1997 07:29:56 +0100
Message-ID: <19971206072955.54783@uni-koblenz.de>
Date: Sat, 6 Dec 1997 07:29:55 +0100
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: RPM-List <rpm-list@redhat.com>, SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: A question about architecture and byte order.
References: <Pine.LNX.3.95.971202130437.18862D-100000@lacrosse.redhat.com> <Pine.LNX.3.95.971205184148.13449G-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <Pine.LNX.3.95.971205184148.13449G-100000@lager.engsoc.carleton.ca>; from Alex deVries on Fri, Dec 05, 1997 at 07:15:18PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Dec 05, 1997 at 07:15:18PM -0500, Alex deVries wrote:

> On Tue, 2 Dec 1997, Erik Troan wrote:
> Because this isn't reported in uname, there'll have to be some additions
> made to ./configure to test the default byte order, and set the arch to
> mips or mipsel accordingly. 

The copy of config.guess in the rpm sources is very old.  The FSF's copy
recognices mips{el}-*-linux correctly since a year or so ...

> Now, as for mipsbi, the architecture that would be able to run both mips
> and mipsel... I think the only way to test this is to attempt to run
> binaries of both byteorders.  I don't quite know how to do this without
> including precompiled binaries of both byteorders.  Maybe something like
> including a precompiled stream of bytes.  It'll be ugly, though.  Please
> let me know if you know of a non-OS specific way of doing this.

For now mipsbi is a pretty theoretical construct.  To my knowledge the
only biendian implementation of an operating system on MIPS has been
Risc/OS 6 which has never been released to the public.  So no code
necessary at all :-)  If I ever implement it for Linux then I'll make
the bi-endian option somehow detectable.

The other issue I was thinking about is that we currently have rpms
of both byteorder using the same filename and archtecture identifier
inside the file.  Maybe changing the architecture for the bigendian
packages also to mipseb would reduce the danger of people cutting
them into their fingers by installing the wrong package?

  Ralf
