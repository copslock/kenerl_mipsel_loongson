Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id NAA498641 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Feb 1998 13:50:32 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA24220 for linux-list; Wed, 25 Feb 1998 13:50:01 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA24211 for <linux@cthulhu.engr.sgi.com>; Wed, 25 Feb 1998 13:49:59 -0800
Received: from seaside2.varberg.se (mail.varberg.se [193.13.151.101]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA13684
	for <linux@cthulhu.engr.sgi.com>; Wed, 25 Feb 1998 13:49:58 -0800
	env-from (grimsy@seaside.se)
Received: from calypso.saturn (grimsy@dialup120-4-47.swipnet.se [130.244.120.239]) by seaside2.varberg.se (8.8.5/8.6.9) with SMTP id VAA12720; Wed, 25 Feb 1998 21:55:23 GMT
Date: Wed, 25 Feb 1998 22:51:24 +0100 (CET)
From: Ulf Carlsson <grimsy@varberg.se>
X-Sender: grimsy@calypso.saturn
To: Alex deVries <adevries@engsoc.carleton.ca>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
In-Reply-To: <Pine.LNX.3.95.980225162025.28713B-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.LNX.3.96.980225224349.1894A-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, 25 Feb 1998, Alex deVries wrote:

> > sdb : sector size 0 reperted, assuming 512.
> > SCSI device sdb: hdwr sector= 512 bytes. Sectors= 1  [0 MB] [0.0 GB]
> 
> Hm.  The 0 MB is what's worrisome, since the kernel doesn't know what kind
> of disk you have.  Can you partition and format that disk properly under
> Irix?

Hmm.. I have dropped the harddrive in the floor once :)

Well, I get the same error message from the kernel with sda. (those lines
are identical.. the sda error message is just above the sdb's).

Can't you please tell me how to partition and format a disk in irix? I
have no real experience of irix, got this indy last week. But I
have ofcourse been using linux for a long time :) 

I could use mke2fs from irix, no errer messages at all. That proves at
least that the harddrive atleast is alive and kicking. 

> I'd certainly suggest you use a different kernel.  Uh, I think there's a
> .82 kernel kicking around on ftp.linux.sgi.com.  If not, I'll make sure
> there is.

I think I'll try the linux-magnum thing. Do you know what this is? I can't
find any information about it, but it seems to be the latest version.

Maybe this new version solves all my problems.

-----------------------------------------
-     grimsy - http://grimsy.ml.org     -
-----------------------------------------
