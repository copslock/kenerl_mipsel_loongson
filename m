Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA12750; Fri, 14 Mar 1997 00:53:19 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA04390 for linux-list; Fri, 14 Mar 1997 08:52:33 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA04385 for <linux@cthulhu.engr.sgi.com>; Fri, 14 Mar 1997 00:52:32 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA21948; Fri, 14 Mar 1997 00:48:51 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA04316; Fri, 14 Mar 1997 00:52:05 -0800
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.37.100]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id AAA13341; Fri, 14 Mar 1997 00:52:00 -0800
Received: from jenolan.caipgeneral (jenolan.rutgers.edu [128.6.111.5])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with SMTP id DAA29450;
	Fri, 14 Mar 1997 03:45:24 -0500 (EST)
Received: by jenolan.caipgeneral (SMI-8.6/SMI-SVR4)
	id DAA22966; Fri, 14 Mar 1997 03:45:15 -0500
Date: Fri, 14 Mar 1997 03:45:15 -0500
Message-Id: <199703140845.DAA22966@jenolan.caipgeneral>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: ariel@cthulhu.engr.sgi.com
CC: linux@yon.engr.sgi.com
In-reply-to: <199703140018.QAA20671@yon.engr.sgi.com> (ariel@yon.engr.sgi.com)
Subject: Re: Hello world!
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: ariel@yon.engr.sgi.com (Ariel Faigon)
   Date: Thu, 13 Mar 1997 16:18:06 -0800 (PST)

	   3) The target Linux/Indy filesystems were NFS mounted.

   Basically we need to mkfs.ext2(8) on the local Indy (as IRIX
   supports XFS and EFS both of which are proprietary, Sigh)
   It would be best to have a seprate disk (rather than a
   partition which may disappear in case of human error)
   Get SILO to work, get the latest gcc to work native
   and we can start working on userland.

In all actuality I did have real Linux ext2 filesystems on my test
box, only the kernel was network obtained.  In fact the stock ext2
filesystem utilities can be compiled on non-Linux platforms out of the
box, they use GNU autoconf.  In fact this is what I did to get going
initially.

I still had to use IRIX fdisk to label the disk, but then from IRIX I
just ran the mke2fs program to make the ext2 filesystem.  Then I'd
boot Linux quickly using nfsroot, mount the ext2 filesystem I had just
created, and I constructed a partition by copying files over from the
nfs partition in this way.  It was a pain, but it worked and I was
more interested in seeing results than doing it right at the time. ;-)
Also the rapid pace at which I was making changes to libc which caused
all of the binaries on the partition to be unusable (because of a
change of symbols in the dynamic linker etc.) actually warranted this
scheme.

A boot loader is really needed though.  There are essentially two or
three approaches most ports take to this task:

1) If the machine provides a "BIOS" or ROM interface that the loader
   can use to access the raw disk to do I/O operations, the boot
   loader only needs to be very minimal.  It uses the ext2 filesystem
   library, teaches the library at init time to use functions which it
   provides to do I/O.  It will do so via the ROM interfaces.  Also,
   some knowledge of the disk labeling scheme is necessary as well.
   This is the scheme used by the Sparc port's boot loader, it is the
   easiest way to approach this problem and it does not lack any
   features.

2) The Alpha port sticks essentially a miniature kernel into the boot
   loader.  Although I dislike this scheme, I have been told that they
   do need to do things this way.  Pretty much the boot loader has
   full device drivers in it.

I'd suggest scheme 1, I am nearly positive the SGI proms provide all
the facilities necessary to do what I have described.  And if I
remember correctly the boot loader that Ralf is using on his SRM
machines does in fact do all of this.  It would be beneficial to go
and look at the available boot loaders already coded, I have a
sneaking suspician that someone willing to stare at all of the code in
those boot loaders can get the thing working on an INDY in say 5 or 6
days time with no prior knowledge.

   Asking David some questions might be a good idea too.
   I'm not sure he is currently on the list, I'll ask
   him if he's interested to join.

If I am not on there now, please add me.  I'll listen in.

   Larry and I are working on setting up linux.sgi.com outside the
   SGI firewall. My intention is to set up tcpwrappers so that only
   the developers (Ralf, Miguel, Mike) and SGI people could login
   and give you complete control of the machine. At which point
   you can install ssh or whatever and start sharing sources.

   The "official" initial post-David merged source tree should
   come from Ralf.

Right.

---------------------------------------------////
Yow! 11.26 MB/s remote host TCP bandwidth & ////
199 usec remote TCP latency over 100Mb/s   ////
ethernet.  Beat that!                     ////
-----------------------------------------////__________  o
David S. Miller, davem@caip.rutgers.edu /_____________/ / // /_/ ><
