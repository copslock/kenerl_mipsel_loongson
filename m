Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA72870 for <linux-archive@neteng.engr.sgi.com>; Wed, 15 Jul 1998 13:18:06 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA88257
	for linux-list;
	Wed, 15 Jul 1998 13:17:52 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA17845
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 15 Jul 1998 13:17:51 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA12721
	for <linux@cthulhu.engr.sgi.com>; Wed, 15 Jul 1998 13:17:49 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id WAA23120;
	Wed, 15 Jul 1998 22:17:44 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id WAA16811;
	Wed, 15 Jul 1998 22:17:43 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id WAA21881;
	Wed, 15 Jul 1998 22:17:43 +0200 (MET DST)
Message-Id: <199807152017.WAA21881@aisa.fi.muni.cz>
Subject: Re: The pre-release of Hard Hat Linux for SGI...
In-Reply-To: <Pine.LNX.3.95.980714192038.7212G-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jul 14, 98 07:38:32 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Wed, 15 Jul 1998 22:17:42 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


OK, I finally got the tar.gz here. Let's look:

I've started installing it with networked WS, development, and some of
the servers (NFS, news).

The fdisk seems to work, I was able to change the ID of the partition.
There is still the funny thing when you are selecting the root
partition -- the free space is negative (-522MB). Interesting thing is
that this dialog shows the partitions as Linux native and Linux swap,
even if the fdisk would show them as EFS and raw.

I tried to mkfs the root with check for bad blocks, this killed the
installer with Install exited abnormally. Without the checks it run
OK.

The dialog sees the swap partition as Swap001 but then you still have
to say Continue without swap (I never got stuck in the middle of the
menus with Alpha 1 -- I always got that Continue option anyway).

Some of the packages still complain about failing, on console 4 Unable
to load interpreter. During the install of 230 packages there were
about 20 messages

	ldconfig: Exception at [<88109534>] (8810960c)

(don't kill me if I retyped the numbers wrong). These numbers were
exactly the same in all installs I did.

About 3 packages before end, the install failed with Out of memory,
Install exited abnormally, messages about signal, etc.

So I rebooted and tried just with networked WS and development, this
failed in about 60 % with Install exited abnormally.

The third attempt I did was only 126 packages of base and networked
WS, this finished fine.

The steps afterwards, that failed, were /usr/sbin/timeconfig and
/usr/sbin/ntsysv. But I'm pretty sure that with RH 5.1 A 1 and some
wider selection of packages, these run OK. So they might just be in
some packages I did not select.

After booting the new kernel, I get Unable to open an initial console.

I will try tomorrow to boot the old kernel to get the prompt and
perhaps install and start sshd there to see the results of the new
kernel.

> Enjoy, and let me know if you do have the bandwidth do download and use
> it.

Alex, if you make any changes or so, please make them available as
patch or packages, not as a new whole tar.gz -- the network was
really slow from U.S. to Europe today.

Thanks and I'm looking forward to more experiments,

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
