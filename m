Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id IAA949451 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Dec 1997 08:50:22 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA05569 for linux-list; Wed, 10 Dec 1997 08:47:34 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA05510 for <linux@cthulhu.engr.sgi.com>; Wed, 10 Dec 1997 08:47:31 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id IAA24721
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Dec 1997 08:47:27 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id LAA03531;
	Wed, 10 Dec 1997 11:43:03 -0500
Date: Wed, 10 Dec 1997 11:43:03 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Takeshi Hakamada <hakamada@meteor.nsg.sgi.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Mount ext2 filesystem.
In-Reply-To: <199712101335.WAA09888@meteor.nsg.sgi.com>
Message-ID: <Pine.LNX.3.95.971210113052.1903B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Wed, 10 Dec 1997, Takeshi Hakamada wrote:
> I'm working on my R5000 Indy can mount second disk as root filesystem.
> I've created ext2 filesystem from my i486-based Linux box and I connected
> it to my Indy as the second drive. Then I booted vmlinux-indy-2.1.67
> (made by Ralf) from the first disk on my Indy, mounted nfs-root filesystem
> which is made by Ralf I know.
> I can mount both the first disk(efs) and the second one(ext2).
> 
> However, when I try to invoke rpm which is made by Alan(libc/ld workaround
> version), I get efs read error as follows:
> efs: read error in indirect extents
> attempt to access beyond end of device
> 08:01 rw=0, want=1207011792, limit=1965937

That looks like a problem with the EFS driver that Mike put in.  I'm not
quite sure wher the problem is, but I get all sort of problems with EFS
myself.  I'm busy with other things.

Actually, I just tried it, and with Ralf's latest kernel I got:
EFS: magic 0X1 doesn't match 0X72959 or 0X7295A!
EFS: failed checking Superblock
Unable to handle paging request at virtual address 00000000, epc ==
88057ab0, ra == 8808bbe8

... and then a complete hang.

> Do you think something wrong with my IRIX efs partition? When I mount
> IRIX root partition, I can invoke some IRIX command(like ls, cp).

I would trust Irix a lot more to handle EFS partitions than the current
Linux kernels.  

> Anyway, why root-be-0.00.cpio.gz doesn't contain rpm binary?
> I think rpm binary should be in root-be-0.00.cpio.gz.

root-be-0.00.cpio.gz doesnt' contain RPM because it's version 0.00, and at
that point nobody had any RPM's to use.  It will, though.  I'll work on
root-be-0.01.tar.gz when I get a working libc (nudge, nudge...)

- Alex
