Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA78918 for <linux-archive@neteng.engr.sgi.com>; Wed, 15 Jul 1998 14:13:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA55966
	for linux-list;
	Wed, 15 Jul 1998 14:13:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA78626
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 15 Jul 1998 14:12:58 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA07166
	for <linux@cthulhu.engr.sgi.com>; Wed, 15 Jul 1998 14:12:52 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id RAA08854;
	Wed, 15 Jul 1998 17:07:41 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 15 Jul 1998 17:07:41 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Honza Pazdziora <adelton@informatics.muni.cz>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: The pre-release of Hard Hat Linux for SGI...
In-Reply-To: <199807152017.WAA21881@aisa.fi.muni.cz>
Message-ID: <Pine.LNX.3.95.980715170724.22020G-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


These are very big problems; I will have a look in a couple of hours.

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .



On Wed, 15 Jul 1998, Honza Pazdziora wrote:

> Date: Wed, 15 Jul 1998 22:17:42 +0200 (MET DST)
> From: Honza Pazdziora <adelton@informatics.muni.cz>
> To: Alex deVries <adevries@engsoc.carleton.ca>
> Cc: linux@cthulhu.engr.sgi.com
> Subject: Re: The pre-release of Hard Hat Linux for SGI...
> 
> 
> OK, I finally got the tar.gz here. Let's look:
> 
> I've started installing it with networked WS, development, and some of
> the servers (NFS, news).
> 
> The fdisk seems to work, I was able to change the ID of the partition.
> There is still the funny thing when you are selecting the root
> partition -- the free space is negative (-522MB). Interesting thing is
> that this dialog shows the partitions as Linux native and Linux swap,
> even if the fdisk would show them as EFS and raw.
> 
> I tried to mkfs the root with check for bad blocks, this killed the
> installer with Install exited abnormally. Without the checks it run
> OK.
> 
> The dialog sees the swap partition as Swap001 but then you still have
> to say Continue without swap (I never got stuck in the middle of the
> menus with Alpha 1 -- I always got that Continue option anyway).
> 
> Some of the packages still complain about failing, on console 4 Unable
> to load interpreter. During the install of 230 packages there were
> about 20 messages
> 
> 	ldconfig: Exception at [<88109534>] (8810960c)
> 
> (don't kill me if I retyped the numbers wrong). These numbers were
> exactly the same in all installs I did.
> 
> About 3 packages before end, the install failed with Out of memory,
> Install exited abnormally, messages about signal, etc.
> 
> So I rebooted and tried just with networked WS and development, this
> failed in about 60 % with Install exited abnormally.
> 
> The third attempt I did was only 126 packages of base and networked
> WS, this finished fine.
> 
> The steps afterwards, that failed, were /usr/sbin/timeconfig and
> /usr/sbin/ntsysv. But I'm pretty sure that with RH 5.1 A 1 and some
> wider selection of packages, these run OK. So they might just be in
> some packages I did not select.
> 
> After booting the new kernel, I get Unable to open an initial console.
> 
> I will try tomorrow to boot the old kernel to get the prompt and
> perhaps install and start sshd there to see the results of the new
> kernel.
> 
> > Enjoy, and let me know if you do have the bandwidth do download and use
> > it.
> 
> Alex, if you make any changes or so, please make them available as
> patch or packages, not as a new whole tar.gz -- the network was
> really slow from U.S. to Europe today.
> 
> Thanks and I'm looking forward to more experiments,
> 
> ------------------------------------------------------------------------
>  Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
>                    I can take or leave it if I please
> ------------------------------------------------------------------------
> 
