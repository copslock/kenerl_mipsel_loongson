Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id UAA594958; Thu, 24 Jul 1997 20:20:00 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA10041 for linux-list; Thu, 24 Jul 1997 20:16:48 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA09861 for <linux@cthulhu.engr.sgi.com>; Thu, 24 Jul 1997 20:15:47 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA05430
	for <linux@cthulhu.engr.sgi.com>; Thu, 24 Jul 1997 20:15:44 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id XAA28096 for <linux@cthulhu.engr.sgi.com>; Thu, 24 Jul 1997 23:15:26 -0400
Date: Thu, 24 Jul 1997 23:15:26 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: An update...
In-Reply-To: <199707241742.KAA26102@oz.engr.sgi.com>
Message-ID: <Pine.LNX.3.95.970724230351.22084H-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Okay, I spent some time on my Indy today, and ran into some things:

- somehow, booting with:
boot -f boopt()bootserver:vmlinux nfsaddrs:my.ip.add.ress:bo.ot.ip.addr
doesn't work.  It gives me the error ": can't open".  Odd.

But:
boot -f boopt()bootserver:vmlinux
does work.

- My root partition isn't being mounted read/write.  I can't figure it
out.  /proc/mounts does indicate that it's rw, and I'm sure the NFS export
is setup correctly.

- I have two disks on the system, sda has Irix on it, and sdb is empty.  I
didn't have fdisk compiled (alhtough I tried), but mke2fs /dev/sdb worked.
It mounted, but... I got a tonne of ext2 errors when rebooting and
remounting.  Irix tells me the disk is good.

- While doing a lot of NFS stuff, I got a the following panic:

Got a bus error IRQ, shouldn't happen yet
...
Cause: 00004000
Spinning

and then the whole thing locks.  I'm using Mike Shaver's 2.1.43.  Should
anyone have a brand new 2.1.47, I'd love to try it.

(actually, I should probably sort out how to cross compile my own
kernels... I'd be doing a good thing to package the cross compile
utilities that Ralf's made into an RPM... never mind the .src.rpm for now)

- Is there anyway to get rid of that jazzy sound startup thing?  Sure, it
puts all the Mac's in my office to shame, but after about the twentieth
time it's a little bothering...

- Binaries I'm looking for:  fdisk, ps, network tools... 

Anyway, things are looking better and better...

- Alex

      Alex deVries              Success is realizing 
  System Administrator          attainable dreams.
   The EngSoc Project     
