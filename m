Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id RAA89837 for <linux-archive@neteng.engr.sgi.com>; Mon, 12 Jan 1998 17:43:59 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA18802 for linux-list; Mon, 12 Jan 1998 17:40:22 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA18770 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 17:40:12 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA16230
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 17:40:09 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-03.uni-koblenz.de [141.26.249.3])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA15789
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Jan 1998 02:40:07 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA02356;
	Tue, 13 Jan 1998 02:37:00 +0100
Message-ID: <19980113023659.28414@uni-koblenz.de>
Date: Tue, 13 Jan 1998 02:36:59 +0100
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: "K." <conradp@cse.unsw.edu.au>, linux@cthulhu.engr.sgi.com
Subject: Re: crtbegin.o, crtend.o
References: <19980112095804.26411@uni-koblenz.de> <Pine.LNX.3.95.980112121719.6175A-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980112121719.6175A-100000@lager.engsoc.carleton.ca>; from Alex deVries on Mon, Jan 12, 1998 at 12:18:47PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jan 12, 1998 at 12:18:47PM -0500, Alex deVries wrote:

> On Mon, 12 Jan 1998 ralf@uni-koblenz.de wrote:
> > Upgrade your system with all the rpm packages.  root-0.01 was my first
> > collection of Indy executables and basically_every_ ELF file has bugs in
> > it ...
> 
> On that note, I should probably get around to creating root-0.02 which has
> all the 'new' binaries in it...  are there any more files than the ones in
> root-0.01 I should add?

Actually I'm thinking about the opposite.  root-0.02.tar.gz was a quite
fat tarball, I think it was about 20mb.  I received some complaints about
it.  If you're going to build a new root-0.2 filesystem, then it should
be stripped down to an absolute minimum that is necessary to allow the
installation of further rpms, partitioning, mounting and more.  Having
gcc in the tarball is overkill and makes maintenance a pain.

  Ralf
