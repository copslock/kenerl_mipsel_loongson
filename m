Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA2520114 for <linux-archive@neteng.engr.sgi.com>; Sat, 25 Apr 1998 20:02:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA16466508
	for linux-list;
	Sat, 25 Apr 1998 20:00:51 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA16573571
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 25 Apr 1998 20:00:49 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id UAA06557
	for <linux@cthulhu.engr.sgi.com>; Sat, 25 Apr 1998 20:00:48 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id XAA15440;
	Sat, 25 Apr 1998 23:00:38 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sat, 25 Apr 1998 23:00:38 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: gcc RPM missing crtbegin.o
In-Reply-To: <19980426034839.39956@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980425225255.4684E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Sun, 26 Apr 1998 ralf@uni-koblenz.de wrote:
> It's spelled ``bug''.  This has been reported before and I'm shure I've
> uploaded the apropriate fixes in form of new patch sets, source and binary
> rpms.
> 

Okay, I had missed the announcement.

> Easy, isn't it?

Always. :)

> I've fixed *shitloads* of bugs since .72, not too mention a dramatic increase
> in performance.  You're right, filesystems on Indys (not other MIPS boxes)
> had the problem of a certain ``volatilibility'', but that's gone for me.

Yup, just bootstrapping from .72 to .91 was a bit troubling.

> If somebody still sees fs corruption on Indys running 2.1.91, please report.

I do have a problem that just came up.  Here it is, hand typed.  I was
doing a lot of work on sdc, which is an external 3GB drive that I know
works well.  It hasn't reported any problems in e2fsck.  There was a lot
of activity when this happened:

EXT2-fs error (device 08:11): ext2_find_entry: bad entry in directory
#41117: rec_len is smaller than minimal - offset = 0, inode=0, rec_len=0,
name_len = 0
EXT2-fs error (device 08:11): ext2_find_entry: bad entry in directory
#41117: rec_len is smaller than minimal - offset = 0, inode=0, rec_len=0,
name_len = 0
page fault from irq handler: 0000
$0 : 00000000 1000fc00 00001000 ffffffe0
$4 : 00000020 00000000 1000fc00 00000001
$8 : 1000fc00 1000001f 00000000 00000007
$12: 40000000 8bf50020 1000fc00 00000001
$16: 00000000 00001000 abf56020 8bf53800
$20: 00000002 bfbc0003 1fffffff bfb90000
$24: 00000002 0fb6f710 
$28: 00008000 08009d28 8bf57e70 080f3b5c
epc   :88020fc0
Status: 1000fc02
Cause: 00000008
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing

this is with my own compiled version of .91.

> Strace is working.  See the CVS.

Alright. 

- A
