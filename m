Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id AAA749251 for <linux-archive@neteng.engr.sgi.com>; Tue, 9 Dec 1997 00:14:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA20032 for linux-list; Tue, 9 Dec 1997 00:13:43 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA20009 for <linux@cthulhu.engr.sgi.com>; Tue, 9 Dec 1997 00:13:39 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id AAA17580
	for <linux@cthulhu.engr.sgi.com>; Tue, 9 Dec 1997 00:13:36 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-15.uni-koblenz.de [141.26.249.15])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id JAA18027
	for <linux@cthulhu.engr.sgi.com>; Tue, 9 Dec 1997 09:13:09 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id IAA00855;
	Tue, 9 Dec 1997 08:42:26 +0100
Message-ID: <19971209084226.22079@uni-koblenz.de>
Date: Tue, 9 Dec 1997 08:42:26 +0100
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Uploads ...
References: <19971208150602.52582@brian.uni-koblenz.de> <Pine.LNX.3.95.971209005539.22886D-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.971209005539.22886D-100000@lager.engsoc.carleton.ca>; from Alex deVries on Tue, Dec 09, 1997 at 01:03:18AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Dec 09, 1997 at 01:03:18AM -0500, Alex deVries wrote:

> > are online.  I had to modify a couple of the source RPMs.  The most
> > common bug was trying to link with libbsd.a from Linux-libc which of
> > course is missing on our glibc-only system.
> 
> What is the replacement for libbsd.a, for future reference?

You don't need to link with a special library, just #define _BSD_SOURCE,
for example with the option -D_BSD_SOURCE.

  Ralf
