Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id TAA539845 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Feb 1998 19:42:16 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA25535 for linux-list; Wed, 25 Feb 1998 19:41:33 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA25524 for <linux@cthulhu.engr.sgi.com>; Wed, 25 Feb 1998 19:41:31 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA24377
	for <linux@cthulhu.engr.sgi.com>; Wed, 25 Feb 1998 19:41:30 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id WAA19268;
	Wed, 25 Feb 1998 22:41:34 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 25 Feb 1998 22:41:34 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Ulf Carlsson <grimsy@varberg.se>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
In-Reply-To: <Pine.LNX.3.96.980225224349.1894A-100000@calypso.saturn>
Message-ID: <Pine.LNX.3.95.980225223801.13530B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Wed, 25 Feb 1998, Ulf Carlsson wrote:
> On Wed, 25 Feb 1998, Alex deVries wrote:
> > > sdb : sector size 0 reperted, assuming 512.
> > > SCSI device sdb: hdwr sector= 512 bytes. Sectors= 1  [0 MB] [0.0 GB]
> > Hm.  The 0 MB is what's worrisome, since the kernel doesn't know what kind
> > of disk you have.  Can you partition and format that disk properly under
> > Irix?
> 
> Hmm.. I have dropped the harddrive in the floor once :)

Who hasn't? :)

> Well, I get the same error message from the kernel with sda. (those lines
> are identical.. the sda error message is just above the sdb's).

Yup.  It sounds like it's a SCSI driver problem.  Are you getting the
error message now with .72?

> Can't you please tell me how to partition and format a disk in irix? I
> have no real experience of irix, got this indy last week. But I
> have ofcourse been using linux for a long time :) 

You need to use fx, or that cutesy graphical tool that's on the menus.

NB: the latest release on ftp.linux.sgi.com is 2.1.72, not 2.1.82 as I'd
mentioned earlier.  Too many numbers...

- Alex
