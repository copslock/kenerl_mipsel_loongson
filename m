Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA22136; Tue, 17 Jun 1997 20:04:41 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA25895 for linux-list; Tue, 17 Jun 1997 20:04:22 -0700
Received: from morgaine.engr.sgi.com (morgaine.engr.sgi.com [130.62.16.64]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA25815 for <linux@cthulhu.engr.sgi.com>; Tue, 17 Jun 1997 20:04:00 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by morgaine.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA16268 for <linux@morgaine.engr.sgi.com>; Tue, 17 Jun 1997 20:01:28 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA25552; Tue, 17 Jun 1997 20:01:26 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA29530; Tue, 17 Jun 1997 20:01:22 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id VAA21277;
	Tue, 17 Jun 1997 21:47:58 -0500
Date: Tue, 17 Jun 1997 21:47:58 -0500
Message-Id: <199706180247.VAA21277@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: jwiede@blammo.engr.sgi.com
CC: linux@morgaine.engr.sgi.com
In-reply-to: <9706171700.ZM11546@blammo.engr.sgi.com>
	(jwiede@blammo.engr.sgi.com)
Subject: Re: Good news: no more begging for HW
X-Windows: Japan's secret weapon.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> While this appears to be an ideal solution on the surface, it has some obvious
> and immediate problems as well.  Namely, the complete lack of the driver
> infrastructure to support the device-dependant layer of the Xsgi server.

I personally would like to provide the same interface to the userland
independently of what X server we end up using (the IRIX X server or
the ported X11R6 server).  

And from the rest of your mail, it seems like the easier approach will
be to run the stock IRIX Xsgi server on Linux. 

I have been doing my homework, and have a list of device drivers that
are used by the X server.  Most of the devices are trivial to code
(keyboard, mouse, input, semaphore drver), some are more interesting (the shmiq will be
an interesting driver, since it seems the only user of this driver is
the X server, and it is nowhere documented in the man pages) and
finally the hard device driver to write is the /dev/opengl driver.

Some of the ioctls that are performed on the opengl should be trivial
to implemnt. 

There is particularly one interesting ioctl: the GFX_ATTACH_BOARD
which appears to take a (struct gfx_attach_board_args *).  This
structure is:

struct gfx_attach_board_args {
        unsigned int board;
        void        *vaddr;     /* this is a user space address */
};

On my machine, the ioctl on /dev/opengl is being called with vaddr set
to 0x02000000.  I wonder what exactly is being done at this address
space?    I know it does not do any mmap on this address (my test
program showed me this).  Probably I need to have allocated this
memory before hand?

Anyways, just after the X server calls this ioctl, it start calling a
bunch of ioctl, for which I could not figure out much:

0x530c, 0x520f, 0x520e, 0x5401, 0x5302, 0x5303,
0x5208, 0x5308, 0x5208, 0x5203, 0x5401, 0x5203

There are no ioctls in /usr/include that would make any sense for
these.  No IO*_ 'S' nor 'T' are documented there.

Put personally, I do not believe codign the /dev/opengl device will be
very hard either.  

Now, back to disassembling /unix opengl_ioctl and try to figure out
those ioctls :-)

Cheers,
Miguel.
