Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA78442 for <linux-archive@neteng.engr.sgi.com>; Mon, 12 Jan 1998 16:16:39 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA18748 for linux-list; Mon, 12 Jan 1998 16:13:33 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA18724 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 16:13:32 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA22726
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 16:13:30 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id TAA30620;
	Mon, 12 Jan 1998 19:16:18 -0500
Date: Mon, 12 Jan 1998 19:16:18 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Red Hat 5.0 RPMS
In-Reply-To: <m0xrk6Q-0005FsC@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.95.980112191306.25332E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Mon, 12 Jan 1998, Alan Cox wrote:
> Alex - can you check all the ones you are missing against the files
> on ftp.uk.linux.org dated Dec 22nd or later. Those dated earlier than
> Jan 7th want rebuilding as they were built with buggy binutils but
> I've got several of your missing packages and fixes (like elm,mailx)
> on there

Alright.  I've merged Alan's binaries in with the distribution on linus,
giving us 353 of the 454 packages complete.  Anything that's changed is in
the SRPMs directory.  I also redid all the building for anything
timestampted before Jan.7.  They're all signed by me, too.

- Alex
