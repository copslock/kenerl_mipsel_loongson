Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id UAA111449 for <linux-archive@neteng.engr.sgi.com>; Mon, 12 Jan 1998 20:00:42 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA17186 for linux-list; Mon, 12 Jan 1998 19:54:46 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA17163 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 19:54:36 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA18926
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 19:54:33 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id WAA07171
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 22:57:26 -0500
Date: Mon, 12 Jan 1998 22:57:26 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Installation...
Message-ID: <Pine.LNX.3.95.980112222431.1740E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Here's how I want to do it:

1. The user boots a kernel with ramdisk either 
   - with bootp (for those who don't have IRIX installed, or no disk 
     space for the RPMS)
   - by slapping the image on '/' of the Irix fs so ARC can see it.
   - by putting in the RedHat/MIPS CD and booting off of it

2. Upon bootup the kernel extracts the ramdisk image which is an
ultra-stripped down fs just like RH's existing boot disk.

3. The usual RH install asks questions about networks, source location,
packages, etc. The user can install from: NFS, SMB, local fs, or CDROM.

4. All the RPM's are installed.

5. Some boot magic happens to setup sash/arc/whatever so booting Linux
doesn't involve running anything in the text boot window.

We have the following problems:

1. There's no initrd in the kernel for MIPS yet.
2. The size of the offset of the image is limited to 11 bits, or 2048k.
It's easy to have a vmlinux kernel for MIPS that's larger than that, so
either: a) we need to get bzImage compression happening or b) we need to
use other bits in the options field to give a larger range.  IIRC, there
are a couple of unused ones in that set of bytes.
3. Life is _much_ better with modules, especially with EFS or SMB things.
4. Somebody needs to sort out sash magic.  

- A

-- 
      Alex deVries          Run Linux on everything,
  System Administrator      run everything on Linux.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
