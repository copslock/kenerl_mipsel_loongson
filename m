Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA655282 for <linux-archive@neteng.engr.sgi.com>; Sat, 16 May 1998 20:58:01 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA80694
	for linux-list;
	Sat, 16 May 1998 20:56:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA79874
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 16 May 1998 20:56:54 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id UAA05936
	for <linux@cthulhu.engr.sgi.com>; Sat, 16 May 1998 20:56:53 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id XAA06553
	for <linux@cthulhu.engr.sgi.com>; Sat, 16 May 1998 23:56:47 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sat, 16 May 1998 23:56:47 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Initrd stuff...
Message-ID: <Pine.LNX.3.95.980516232738.31143E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Okay, I'm hacking the kernel to allow for initial ramdisks.

The approach I'm taking (after discussion with Ralf) is to use
prom_open/read/close() to read an ramdisk file, instead of taking the
ramdisk off of the tail portion of the boot image.

So, I'm doing work in linux/arch/mips/sgi/prom/ .  I'm trying to do a:

prom_open(filename,rdonly,&fd);

But, I always get back PROM_ENODEV .  I assume that means that the device
I'm trying to locate doesn't work.

I've tried all sorts of things, apparantly none are correct.  I thought
that "scsi(0)disk(1)rdisk(0)partition(8)/initrd" was my best chance, but
it comes back with PROM_ENODEV also.

Anyone know what the correct syntax is?

- Alex
