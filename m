Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA23997 for <linux-archive@neteng.engr.sgi.com>; Mon, 13 Jul 1998 03:36:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA65952
	for linux-list;
	Mon, 13 Jul 1998 03:36:02 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA37150
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 13 Jul 1998 03:36:00 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA01121
	for <linux@cthulhu.engr.sgi.com>; Mon, 13 Jul 1998 03:35:55 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id MAA26879
	for <linux@cthulhu.engr.sgi.com>; Mon, 13 Jul 1998 12:35:46 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id MAA10044
	for <linux@cthulhu.engr.sgi.com>; Mon, 13 Jul 1998 12:35:45 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id MAA25444
	for linux@cthulhu.engr.sgi.com; Mon, 13 Jul 1998 12:35:43 +0200 (MET DST)
Message-Id: <199807131035.MAA25444@aisa.fi.muni.cz>
Subject: 2.1.99 with RH 5.1 A 2 slowing down
To: linux@cthulhu.engr.sgi.com
Date: Mon, 13 Jul 1998 12:35:42 +0200 (MET DST)
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello,

I'm using RH 5.1 installation with Alpha 1 kernel and installator and
devel/Alpha 2 RPMs (where available). The system is running fine, but
seems to slow down during the time.

My, maybe naive, observation is that the buffers value from the free
listing is very high: on 32 MB system, the buffers value is about 13
to 15 MB, cached about 4 MB and there are like 500 kB freee memory.
The system doesn't swap, however when I try to run a process, it's
very slow starting it and running it. I'm for example am not able to
finish make dep on the kernel tree -- the activity just does to zero
after 5 minutes or so.

I've found out that I can force it to free the buffers (while still
having some free memory to actually start the perl) with something
like
	perl -e '$/ = undef; $_ = <>; $a = $_ x 3' /vmlinux

that creates a process allocating about 8 MB, but I have to do this
rather often (in while true ; done loop). I understand that my
description is rather fuzzy, so the main point is that the system is
slowing down, doesn't swap but has very low free memory, even if there
is a lot of memory used by buffers. I can of course send any
additional info/listings, if you tell me which.

Do you know what I might be doing wrong? Thanks,

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
