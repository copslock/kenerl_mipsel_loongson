Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA78833; Fri, 15 Aug 1997 11:53:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA08645 for linux-list; Fri, 15 Aug 1997 11:53:03 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA08635; Fri, 15 Aug 1997 11:53:01 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA17588; Fri, 15 Aug 1997 11:52:53 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id NAA29883;
	Fri, 15 Aug 1997 13:50:15 -0500
Date: Fri, 15 Aug 1997 13:50:15 -0500
Message-Id: <199708151850.NAA29883@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: jeremyw@motown.detroit.sgi.com
CC: linux@cthulhu.engr.sgi.com, linux-progress@cthulhu.engr.sgi.com
In-reply-to: <Pine.SGI.3.94.970815111008.12486A-100000@motown.detroit.sgi.com>
	(message from Jeremy Welling on Fri, 15 Aug 1997 11:26:18 -0400 (EDT))
Subject: Re: Booting Linux from second disk
X-Unix: is friendly, it is just selective about who its friends are.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> We have tried booting miniroot, running command monitor then running sash
> and we have tried:
> 
> boot /vmlinux root=/dev/sdb1 which just fails
> 
> and 
> 
> boot /vmlinux root=/dev/sdb7 which boots IRIX

Ok, it is not that simple.  

The problem is that the Linux kernel does not have a module for
accessing EFS, so you have to do this in two steps:

	1. Un cpio the root-*.cpio.gz on a machine on the network
	   and tell Linux to use that as its root file system:

		boot /vmlinux nfsroot=132.248.29.5:/tftpboot/the-root-dir

	   Replace 132.248.29.5 for the IP address of your NFS server
	   and /tftpboot/the-root-dir for the exported directory in
	   your NFS server that holds that stuff.

	2. Prepare to get rid of EFS on your disk.

	   Run the mke2fs command on the proper device to create
	   the Linux ext2 file system.

	3. Un-cpio the file again, this time on your root disk.

	4. umount the disk, and reset the machine.

Miguel.
