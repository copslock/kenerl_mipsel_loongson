Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA85076 for <linux-archive@neteng.engr.sgi.com>; Mon, 15 Jun 1998 11:12:48 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA78567
	for linux-list;
	Mon, 15 Jun 1998 11:12:05 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA47868;
	Mon, 15 Jun 1998 11:12:01 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id LAA29554; Mon, 15 Jun 1998 11:11:58 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA22959;
	Mon, 15 Jun 1998 14:11:56 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 15 Jun 1998 14:11:56 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Bob Mende Pie <mende@piecomputer.engr.sgi.com>
cc: linux@cthulhu.engr.sgi.com, dmk@cthulhu.engr.sgi.com
Subject: Re: linus.linux.sgi.com
In-Reply-To: <199806151802.LAA48935@piecomputer.engr.sgi.com>
Message-ID: <Pine.LNX.3.95.980615141030.17455B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Bob/David:

Thanks for looking into this; this is much appreciated since I expect
there'll be quite a bit more traffic to the machine in the next little
bit.

It sounds to me like we are getting to the point of having a sane enough
system to actually run Linux for linus.linux.sgi.com.  Has anyone
considered this?

- Alex

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .


On Mon, 15 Jun 1998, Bob Mende Pie wrote:

> Date: Mon, 15 Jun 1998 11:02:40 -0700 (PDT)
> From: Bob Mende Pie <mende@piecomputer.engr.sgi.com>
> To: adevries@engsoc.carleton.ca
> Cc: linux@cthulhu.engr.sgi.com, dmk@engr.sgi.com
> Subject: Re: linus.linux.sgi.com
> 
> > Erg.  Linus.linux.sgi.com is dead.  Can someone at SGI take a look at
> > this?
> > 
> > - A
> 
> linus.linux.sgi.com is back up.   Here is the story of what is happening.
> 
> As some of you may know linus is a 150Mhz R4400 indy with a pair of dual
> 1.2g disks setup as a pair of software mirrored plexs.   These disks are in
> a external enclosure that can not fit in a rack, and due to other
> happenings in the area that linus sits in this has become an issue.   
> 
> Thus last thursday Dave Katinsky (The SA who runs the lab) aquireed a vault
> with 4 2g diff scsi disks, and a 180Mhz R5000 challenge/S.  We swapped the
> two internal disks into the new system and brought it up with the original
> disks still on it.   It was running just fine.  Sometime after 1900 last
> night, the system died with a hardware ECC error in the cache.   We swapped
> the cpu from the old system (which was sitting there just in case a
> disaster happened) into the new box.   It is back up again.   If anyone
> notices problems with the system, please contact mende@engr.sgi.com and
> dmk@engr.sgi.com.   
> 
> As for our plans for the disks.  I want to make a mirrored plex of 2x2x2g 
> drives, but one of the 4 disks in this system is not working correctly.   I
> am trying to find a way to ensure that /src is mirrored or start a process
> to get it backed up (which cant be automated, and thus, IMHO, is not a good
> idea).   We may be able to get a small rack of disks use instead of the one
> with the bad disk or may get a replacment disk.   
> 
> More when I know it.
> 
>                     /Bob...                    mailto:mende@sgi.com
>               http://reality.sgi.com/mende            KF6EID
> 
