Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA59385 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Jun 1998 08:47:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA71175
	for linux-list;
	Tue, 16 Jun 1998 08:47:14 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA56971
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 Jun 1998 08:47:12 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id IAA07023
	for <linux@cthulhu.engr.sgi.com>; Tue, 16 Jun 1998 08:47:01 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id RAA14782;
	Tue, 16 Jun 1998 17:46:13 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id RAA03918;
	Tue, 16 Jun 1998 17:46:11 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id RAA28259;
	Tue, 16 Jun 1998 17:46:07 +0200 (MET DST)
Message-Id: <199806161546.RAA28259@aisa.fi.muni.cz>
Subject: Re: RedHat 5.1 (Manhattan) ALPHA 1 for SGI/Indys
In-Reply-To: <Pine.LNX.3.95.980614004054.27426A-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jun 14, 98 00:44:23 am"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Tue, 16 Jun 1998 17:46:06 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> 6. Last, but not least
> 
> Let us know if it worked!

Great! It worked. I mean: it worked!

I've installed it from our mirror at ftp.fi.muni.cz to an old 300 MB
disk. After some fiddling with the ftp server to support tftp
correctly and after one crash with some message about signal 11
(caused by the disk, I believe) it's now installed and running.

Some comments out of my head:

The /usr/sbin/timeconfig failed in the menu -- it doesn't seem to be
present in the installfs -- shall I find and compile it?

I've set up root password in the menu but it wasn't there after
reboot -- not even /etc/passwd -- I had to boot init=/bin/bash.

I had to install gcc from RH 5.0.

Mkswap failed with segmantation fault -- shall I send the register
output? I will try to compile my own, but the machine is slow without
swap, and I need to compile ssh first to get reasonable remote access.
Once this is done, we might be able to provide ssh*.mips.rpm, if you
are interested.

It might be nice to put the notice about this 5.1 on the web, so that
people are directed to the new stuff -- even this, plain text announce
and instructions would be nice.

As I have the system on a disk, it's much happier and it starts to
look really reasonably. I will boot my machine to Linux and run the
compilations of ssh and linux-utils (for mkswap) overnight. If there
is anything I can compile/test/do to help you, please let me know.

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
