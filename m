Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA78743 for <linux-archive@neteng.engr.sgi.com>; Mon, 15 Jun 1998 11:03:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA51722
	for linux-list;
	Mon, 15 Jun 1998 11:02:44 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from piecomputer.engr.sgi.com (piecomputer.engr.sgi.com [150.166.105.8])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA26306;
	Mon, 15 Jun 1998 11:02:42 -0700 (PDT)
	mail_from (mende@piecomputer.engr.sgi.com)
Received: (from mende@localhost) by piecomputer.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id LAA48935; Mon, 15 Jun 1998 11:02:40 -0700 (PDT)
Date: Mon, 15 Jun 1998 11:02:40 -0700 (PDT)
Message-Id: <199806151802.LAA48935@piecomputer.engr.sgi.com>
From: Bob Mende Pie <mende@piecomputer.engr.sgi.com>
To: adevries@engsoc.carleton.ca
CC: linux@cthulhu.engr.sgi.com, dmk@cthulhu.engr.sgi.com
In-reply-to: 
	<Pine.LNX.3.95.980614163450.10085B-100000@lager.engsoc.carleton.ca>
	(message from Alex deVries on Sun, 14 Jun 1998 16:35:27 -0400 (EDT))
Subject: Re: linus.linux.sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Erg.  Linus.linux.sgi.com is dead.  Can someone at SGI take a look at
> this?
> 
> - A

linus.linux.sgi.com is back up.   Here is the story of what is happening.

As some of you may know linus is a 150Mhz R4400 indy with a pair of dual
1.2g disks setup as a pair of software mirrored plexs.   These disks are in
a external enclosure that can not fit in a rack, and due to other
happenings in the area that linus sits in this has become an issue.   

Thus last thursday Dave Katinsky (The SA who runs the lab) aquireed a vault
with 4 2g diff scsi disks, and a 180Mhz R5000 challenge/S.  We swapped the
two internal disks into the new system and brought it up with the original
disks still on it.   It was running just fine.  Sometime after 1900 last
night, the system died with a hardware ECC error in the cache.   We swapped
the cpu from the old system (which was sitting there just in case a
disaster happened) into the new box.   It is back up again.   If anyone
notices problems with the system, please contact mende@engr.sgi.com and
dmk@engr.sgi.com.   

As for our plans for the disks.  I want to make a mirrored plex of 2x2x2g 
drives, but one of the 4 disks in this system is not working correctly.   I
am trying to find a way to ensure that /src is mirrored or start a process
to get it backed up (which cant be automated, and thus, IMHO, is not a good
idea).   We may be able to get a small rack of disks use instead of the one
with the bad disk or may get a replacment disk.   

More when I know it.

                    /Bob...                    mailto:mende@sgi.com
              http://reality.sgi.com/mende            KF6EID
