Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id OAA344924; Tue, 2 Sep 1997 14:50:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA12599 for linux-list; Tue, 2 Sep 1997 14:47:01 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA12561 for <linux@cthulhu.engr.sgi.com>; Tue, 2 Sep 1997 14:46:57 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA16783
	for <linux@relay.engr.sgi.com>; Tue, 2 Sep 1997 14:46:53 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id RAA06959 for <linux@relay.engr.sgi.com>; Tue, 2 Sep 1997 17:47:13 -0400
Date: Tue, 2 Sep 1997 17:47:13 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: linux@cthulhu.engr.sgi.com
Subject: Booting off of sdb1...
Message-ID: <Pine.LNX.3.95.970902173244.5212A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


First off, thanks to input from Mike, I got my partition setup properly.
Here's how it's done:

In fx in IRIX, create an optional partition.  This will create one huge
partition at the beginning (sdb1), and a volume header (sdb2), which you
won't use.  It doesn't matter what type of partition you label sdb1, Linux
doesn't recognize either.  All this means is you may have to force the
type recognition when doing a mount.

>From within an nfs-rooted Linux, I mke2fs'd it, and copied all the files
over from my nfsroot (esentially Ralf's root .cpio.gz).

But, here's my problem:  I've take my old kernel that boots with NFS root,
and tried to boot it using:  
vmlinux root=/dev/sdb1

The kernel starts, and it finishes off with:

Partition check:
 sda: sad1 sda2 sda3 sda4
 sdb: sdb1 sdb2 sdb3
VFS: Mounted root (ext2 filesystem) readonly.
: Can't open

And then nothing.

What am I missing?

- Alex


      Alex deVries              Success is realizing 
  System Administrator          attainable dreams.
   The EngSoc Project     
