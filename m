Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id UAA912164 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Sep 1997 20:41:46 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA12015 for linux-list; Wed, 3 Sep 1997 20:41:17 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA12010 for <linux@cthulhu.engr.sgi.com>; Wed, 3 Sep 1997 20:41:15 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA19593
	for <linux@cthulhu.engr.sgi.com>; Wed, 3 Sep 1997 20:41:13 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id WAA27779;
	Wed, 3 Sep 1997 22:34:20 -0500
Date: Wed, 3 Sep 1997 22:34:20 -0500
Message-Id: <199709040334.WAA27779@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@cthulhu.engr.sgi.com
Subject: Need help with with irix_elfmap.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


    I am trying to run the IRIX Xsgi server on top of Linux/SGI, and I
am running into some very strange problems.  If i let the program run
loose, the code crashes miserably inside a function called
_XSERVTransOpenCOTServer, just after the functions unlinks the file
/usr/tmp/.Xshmtrans%d, and just before making the sysmp system call
(this one I supposed is used as part of the usinit () libc routine).

    This is listing of the system calls done on IRIX for the X server
around this point:

mkdir("/tmp/.X11-unix", 0777)           = -1 EEXIST (File exists)
unlink("/tmp/.X11-unix/X0")             = 0
bind(5, {sun_family=AF_UNIX, sun_path="/tmp/.X11-unix/X0"}, 19) = 0
listen(5, 5)                            = 0
umask(022)                              = 0
unlink("/usr/tmp/.Xshmtrans0")          = 0
sysmp(0x420, 0x1, 0xe, 0x3d, 0)         = 1

    On Linux, this code is executed:

mkdir("/tmp/.X11-unix", 0777)		= -1 EEXIST (File exists)
unlink("/tmp/.X11-unix/X0")             = 0
bind(5, {sun_family=AF_UNIX, sun_path="/tmp/.X11-unix/X0"}, 19) = 0
listen(5, 5)                            = 0
umask(022)                              = 0
unlink("/usr/tmp/.Xshmtrans0")          = 0
segfault

   Segmentation fault address = somewhere inside libc, return address
suggests the usinit() libc routine was called (I guess this from an
IRIX 6.4 machine where stock FSF-gdb happens to understand the
symbolic information on the libc)

    Now, this *may* suggest that the problem is on the libc usinit()
routine and that I ought to be figuring what happens inside of it, but
if I run the program under gdb [1], and if I take extra care to single
step around the region that calls usinit() the program won't crash at
that point, it will just happen to crash at some point later at random
places (ie, stepi over the code, then let it continue).

    So, does this ring any bell to anyone?  I have the impression that
the elfmap() routine in the IRIX kernel may be poking some values in
the user address space and probably flushing the caches.  Which is
strange, since the Linux implementation uses do_mmap and that should
take care of flushing any thing that should be flushed.

Miguel.

[1] I have a couple of patches to the gdb.tar.gz file that we got from
the original DaveM-pack that I really need to commit.


    

   
