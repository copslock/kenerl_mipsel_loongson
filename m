Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id OAA110790; Fri, 15 Aug 1997 14:49:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA01059 for linux-list; Fri, 15 Aug 1997 14:48:45 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA01048 for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 14:48:42 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA21210
	for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 14:48:40 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id QAA30833;
	Fri, 15 Aug 1997 16:46:07 -0500
Date: Fri, 15 Aug 1997 16:46:07 -0500
Message-Id: <199708152146.QAA30833@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: adevries@engsoc.carleton.ca
CC: ariel@sgi.com, linux@cthulhu.engr.sgi.com
In-reply-to: 
	<Pine.LNX.3.95.970815163117.21813A-100000@lager.engsoc.carleton.ca>
	(message from Alex deVries on Fri, 15 Aug 1997 16:38:14 -0400 (EDT))
Subject: Re: boot linux - wish
X-Mexico: Este es un pais de orates, un pais amateur.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> > Could someone rise to the challenge of writing a utility
> > that will install Linux on an IRIX machine?
> 
> I don't mind rising to that challenge, but one huge obstacle is how do we
> get the utility to partition the Linux drive? 

the fx command is used to partition disks on IRIX.  It took me a while
to work around the user friendlyness of it, but then, I wanted to keep
a part of my disk with XFS (because I just LOVE that file system) and
the rest for my ext2fs.

> I'm guessing the solution is to write a utility that from within Irix
> talks directly to the raw SCSI disk to setup the partitions.  I have NO
> idea how to do this as I doubt the raw disk interface is anything like
> that in Linux. Clues accepted.

The only thing you need to do is access the first sector in the disk.
this one holds the disk label with the current partition definitions.
Oliver at .at was working on getting Linux FDISK up and running, you
can probably talk with him.

> > And give hints like:
> > 	Sorry you don't have the e2fs tools installed on IRIX yet
> > 	should I download them from ftp.linux.sgi.com [y/n]?
> 
> Er, does such a tool in fact exist?

Yes.  get the e2fsprogs suite, it is the only thing you need to
populate a file system.

Miguel.
