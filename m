Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA44380 for <linux-archive@neteng.engr.sgi.com>; Tue, 24 Nov 1998 12:34:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA34757
	for linux-list;
	Tue, 24 Nov 1998 12:33:49 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA02995;
	Tue, 24 Nov 1998 12:33:46 -0800 (PST)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id MAA31902; Tue, 24 Nov 1998 12:33:45 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199811242033.MAA31902@oz.engr.sgi.com>
Subject: Re: help offered
To: torbjorn.gannholm@fra.se (Torbjörn Gannholm)
Date: Tue, 24 Nov 1998 12:33:45 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <365AA647.62A5565D@fra.se> from "Torbjörn Gannholm" at Nov 24, 98 01:27:53 pm
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:First my apologies for asking questions you all know the answer to:
:What kind of SGI-machines does Linux currently work on?
:
Only Indys.


:In what areas does IRIX6.5 have a significant edge over Linux
:performancewise?
:
	- Scalability: up to 256 CPUs
	- Guaranteed Real Time response (kernel is preemptible
	  i.e. you can have multiple system calls executing in server
	  space simultaneously.
	- A real journalling filesystem (XFS). Reboot doesn't
	  require a lenghty 'fsck'.  Even if you have a terabyte
	  filesystem the filesystem check takes one second or so.
	- Bandwidth (I/O networking) e.g. 4 GB/sec write to
	  RAID disks.

Linux has a clear edge is latency (as opposed to bandwidth)
short system call paths, simplicity and a general speed advantage
almost accros the board on machines with a single CPU, small disks,
small files etc.

Note that Linux doesn't even support big files (more than 4 GB)
on x86, while IRIX supports many terabyte files.


:We really want to put Linux on _everything_ we've got, from PI's to
:O2000 (we might also keep a PowerSeries380 for fun), as well as on suns
:and pcs. It would make everything a lot simpler to administrate, plus if
:we're not happy we can try to hack something.
:
Me too. This is not easy to do.  It is a big work.

:If necessary for performance, we can keep IRIX on the numbercrunchers,
:and, if that's not a performance problem, use gcc/egcs and glibc. Same
:questions for these contra Irix Development Kit as above.
:
:I have my employer's blessing to put time into porting and/or
:development of Linux/gcc/glibc for SGI-machines if someone just points
:me in the right direction.
:I have solid programming experience, I have dabbled a bit in sysadmin
:and am a quick learner (I have at times written useful code in unknown
:languages from examples), but haven't been this deep in before.
:
If you could make 'glibc' run on IRIX and send me the details
of what you did (and patches to the maintainers) that would be
a great great thing.  It will make most freeware programs more
portable between IRIX and Linux.

-- 
Peace, Ariel
