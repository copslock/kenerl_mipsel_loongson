Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id PAA58724 for <linux-archive@neteng.engr.sgi.com>; Wed, 12 Nov 1997 15:37:39 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA11181 for linux-list; Wed, 12 Nov 1997 15:34:43 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA11157 for <linux@engr.sgi.com>; Wed, 12 Nov 1997 15:34:37 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA29023
	for <linux@engr.sgi.com>; Wed, 12 Nov 1997 15:34:35 -0800
	env-from (ralf@hotel.uni-koblenz.de)
From: ralf@hotel.uni-koblenz.de
Received: from hotel.uni-koblenz.de (ralf@pmport-03.uni-koblenz.de [141.26.249.3]) by informatik.uni-koblenz.de (8.8.7/8.6.9) with ESMTP id AAA04969; Thu, 13 Nov 1997 00:34:04 +0100 (MET)
Received: (from ralf@localhost)
	by hotel.uni-koblenz.de (8.8.7/8.8.7) id AAA12363;
	Thu, 13 Nov 1997 00:31:04 +0100
Message-ID: <19971113003104.35826@hotel.uni-koblenz.de>
Date: Thu, 13 Nov 1997 00:31:04 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux@cthulhu.engr.sgi.com
Subject: Re: SGI / Linux
References: <199711122131.NAA21427@oz.engr.sgi.com> <m0xVlI4-0005FtC@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <m0xVlI4-0005FtC@lightning.swansea.linux.org.uk>; from Alan Cox on Wed, Nov 12, 1997 at 10:29:40PM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Nov 12, 1997 at 10:29:40PM +0000, Alan Cox wrote:
> On other points anyone currently working on merging to 2.1.63, and the
> status on the dynamic link bugs and X11 - Any chance of a serverless
> XFree86 build set for the SGI yet - that'll let me build most of the
> remaining RPMs

Miguel has done some work on X.  The problem with X is that the dynamic
linker as currently in the CVS on Linus won't work with X.  There are a
couple more of features in the dynamic linker that want to be fixed; I
have a kind of semifixes for them.

I'm going to merge things upto 2.1.63 when I've fixed some other things.
During the semester holidays I fixed a large number of bugs in the MIPS
code but broke support for another machine, my favorite testing box ...

  Ralf
