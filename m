Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id RAA92970 for <linux-archive@neteng.engr.sgi.com>; Mon, 12 Jan 1998 17:57:44 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA23344 for linux-list; Mon, 12 Jan 1998 17:55:01 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA23329 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 17:54:59 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA20066
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 17:54:57 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-03.uni-koblenz.de [141.26.249.3])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA16106
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Jan 1998 02:54:55 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA02580;
	Tue, 13 Jan 1998 02:51:49 +0100
Message-ID: <19980113025148.55412@uni-koblenz.de>
Date: Tue, 13 Jan 1998 02:51:48 +0100
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux@cthulhu.engr.sgi.com
Subject: Re: Red Hat 5.0 RPMS
References: <m0xrk6Q-0005FsC@lightning.swansea.linux.org.uk> <Pine.LNX.3.95.980112191306.25332E-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980112191306.25332E-100000@lager.engsoc.carleton.ca>; from Alex deVries on Mon, Jan 12, 1998 at 07:16:18PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jan 12, 1998 at 07:16:18PM -0500, Alex deVries wrote:

> On Mon, 12 Jan 1998, Alan Cox wrote:
> > Alex - can you check all the ones you are missing against the files
> > on ftp.uk.linux.org dated Dec 22nd or later. Those dated earlier than
> > Jan 7th want rebuilding as they were built with buggy binutils but
> > I've got several of your missing packages and fixes (like elm,mailx)
> > on there
> 
> Alright.  I've merged Alan's binaries in with the distribution on linus,
> giving us 353 of the 454 packages complete.  Anything that's changed is in
> the SRPMs directory.  I also redid all the building for anything
> timestampted before Jan.7.  They're all signed by me, too.

You should probably copy/hardlink the glibc rpms from the 4.9.1
directory.

  Ralf
