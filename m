Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA84381 for <linux-archive@neteng.engr.sgi.com>; Wed, 15 Jul 1998 15:14:22 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA70343
	for linux-list;
	Wed, 15 Jul 1998 15:13:51 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA89425
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 15 Jul 1998 15:13:49 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA04018
	for <linux@cthulhu.engr.sgi.com>; Wed, 15 Jul 1998 15:13:21 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id SAA11153;
	Wed, 15 Jul 1998 18:13:15 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 15 Jul 1998 18:13:15 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Honza Pazdziora <adelton@informatics.muni.cz>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: The pre-release of Hard Hat Linux for SGI...
In-Reply-To: <199807152017.WAA21881@aisa.fi.muni.cz>
Message-ID: <Pine.LNX.3.95.980715180435.22020I-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Wed, 15 Jul 1998, Honza Pazdziora wrote:
> The fdisk seems to work, I was able to change the ID of the partition.
> There is still the funny thing when you are selecting the root
> partition -- the free space is negative (-522MB). Interesting thing is
> that this dialog shows the partitions as Linux native and Linux swap,
> even if the fdisk would show them as EFS and raw.
> I tried to mkfs the root with check for bad blocks, this killed the
> installer with Install exited abnormally. Without the checks it run
> OK.

Okay.  mkfs is messed; we should document that.  I don't intend on fixing
it anytime really soon.

Fine, swap doesn't work either.  I don't mind skipping that for now.

> Some of the packages still complain about failing, on console 4 Unable
> to load interpreter. During the install of 230 packages there were
> about 20 messages
> 	ldconfig: Exception at [<88109534>] (8810960c)

_THAT_ worries me a lot.

If you have an existing install of linux on your SGI, do this:
- install the ldconfig rpm that's in the distribution you have
- run ldconfig

Does that still give the exception?

> About 3 packages before end, the install failed with Out of memory,
> Install exited abnormally, messages about signal, etc.

That's a problem.  How much memory do you have?

> So I rebooted and tried just with networked WS and development, this
> failed in about 60 % with Install exited abnormally.

What package was installing at the time the install broke?

> The third attempt I did was only 126 packages of base and networked
> WS, this finished fine.

Good.

> After booting the new kernel, I get Unable to open an initial console.

Did you pass a root= variable to the kernel when booting?  You should
normally have to do something like:

boot vmlinux root=/dev/sdb1

Does the kernel see the partitions on your disk?

> Alex, if you make any changes or so, please make them available as
> patch or packages, not as a new whole tar.gz -- the network was
> really slow from U.S. to Europe today.

Definitely.

These problems worry me a lot.  Please, if you have had the same or other
experiences, I want to know about them.

- Alex
