Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA07123; Thu, 13 Mar 1997 16:21:52 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA20473 for linux-list; Fri, 14 Mar 1997 00:21:27 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA20465 for <linux@cthulhu.engr.sgi.com>; Thu, 13 Mar 1997 16:21:24 -0800
Received: (from ariel@localhost) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA20671; Thu, 13 Mar 1997 16:18:06 -0800
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199703140018.QAA20671@yon.engr.sgi.com>
Subject: Re: Hello world!
To: linux@yon.engr.sgi.com, davem@caip.rutgers.edu (David)
Date: Thu, 13 Mar 1997 16:18:06 -0800 (PST)
In-Reply-To: <9703141124.ZM7712@windy.wellington.sgi.com> from "Alistair Lambie" at Mar 14, 97 11:24:41 am
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:On Mar 14, 10:32am, Mike Shaver wrote:
:> Subject: Hello world!
:> Looks like I'm getting an Indy when I get back to Ottawa next week, so
:> I'd like to hear from others (hello?) as to what kind of work we're
:> looking at in the short term.
:>

The goals are:
	0) Complete the merge with mainstream Linux
	   (David left at 2.0.11 or so) which I assume
	   Ralf has already done or doing.

	1) Get the Indy to boot linux from a _local_ disk
	   Ralf and Miguel were looking into SILO here.

	2) Get gcc to work native of Linux/Indy

As Alistair said, David already got the WD SCSI driver to work
and he was booting to multiuser and even running GNU emacs
on his Linux Indy.  But this was done using:

	1) Cross builds (gcc-cross was running on IRIX 6.2
	   and producing Linux ELF-32 binaries).

	2) Booting was never local. It was always using the
	   ARC prom bootp command.

	3) The target Linux/Indy filesystems were NFS mounted.

Basically we need to mkfs.ext2(8) on the local Indy (as IRIX
supports XFS and EFS both of which are proprietary, Sigh)
It would be best to have a seprate disk (rather than a
partition which may disappear in case of human error)
Get SILO to work, get the latest gcc to work native
and we can start working on userland.

Asking David some questions might be a good idea too.
I'm not sure he is currently on the list, I'll ask
him if he's interested to join.

:>
:> I understand that we're looking to get a source repository out on the
:> 'net, which would be a good start.  What are people planning to start
:> with first?  (I suppose talking to disks is a priority... =) )
:>

Larry and I are working on setting up linux.sgi.com outside the
SGI firewall. My intention is to set up tcpwrappers so that only
the developers (Ralf, Miguel, Mike) and SGI people could login
and give you complete control of the machine. At which point
you can install ssh or whatever and start sharing sources.

The "official" initial post-David merged source tree should
come from Ralf.

-- 
Peace, Ariel
