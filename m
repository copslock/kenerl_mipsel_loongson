Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id NAA489558 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Feb 1998 13:32:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA16860 for linux-list; Wed, 25 Feb 1998 13:31:31 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA16849 for <linux@cthulhu.engr.sgi.com>; Wed, 25 Feb 1998 13:31:29 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA07241
	for <linux@cthulhu.engr.sgi.com>; Wed, 25 Feb 1998 13:31:23 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id QAA02754;
	Wed, 25 Feb 1998 16:31:18 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 25 Feb 1998 16:31:18 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Ulf Carlsson <grimsy@varberg.se>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
In-Reply-To: <Pine.LNX.3.96.980225215717.970B-100000@calypso.saturn>
Message-ID: <Pine.LNX.3.95.980225162025.28713B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Wed, 25 Feb 1998, Ulf Carlsson wrote:
> 
> Hello, sorry that I'm asking.. don't know if this is a support mailing
> list.
> I have been trying to install linux on my indy today. First I tried to use
> the ext2 partition, /dev/sdb1, with no success. THe kernel says:
> 
> sdb : sector size 0 reperted, assuming 512.
> SCSI device sdb: hdwr sector= 512 bytes. Sectors= 1  [0 MB] [0.0 GB]

Hm.  The 0 MB is what's worrisome, since the kernel doesn't know what kind
of disk you have.  Can you partition and format that disk properly under
Irix?

I'd certainly suggest you use a different kernel.  Uh, I think there's a
.82 kernel kicking around on ftp.linux.sgi.com.  If not, I'll make sure
there is.

- Alex
