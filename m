Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA3012370 for <linux-archive@neteng.engr.sgi.com>; Tue, 28 Apr 1998 15:44:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA17702595
	for linux-list;
	Tue, 28 Apr 1998 15:43:12 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA17838643
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 28 Apr 1998 15:43:11 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id PAA15400
	for <linux@cthulhu.engr.sgi.com>; Tue, 28 Apr 1998 15:43:09 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-03.uni-koblenz.de [141.26.249.3])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA28901
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Apr 1998 00:42:42 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id AAA01844;
	Wed, 29 Apr 1998 00:40:44 +0200
Message-ID: <19980429004042.05918@uni-koblenz.de>
Date: Wed, 29 Apr 1998 00:40:42 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Closer...
References: <Pine.LNX.3.95.980428175303.13373I-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980428175303.13373I-100000@lager.engsoc.carleton.ca>; from Alex deVries on Tue, Apr 28, 1998 at 06:00:49PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Apr 28, 1998 at 06:00:49PM -0400, Alex deVries wrote:

> Well, Ralf was kind enough to send me a custom kernel to try and address
> my latest problems.  It looks like I'm not missing any more files (*yay*),
> but it did take some time to re-install everything I'd lost.

Don't exagerate the quality of my services.  It was my latest test kernel
built for myself and since it is lacking certain things exception fixup
routines for csum_partial_copy_from_user() I won't recommend it for
general use.  Heck, malvolent software can crash it easily.  Developers who
want to play with it though can get it from linus:~ralf/vmlinux.gz.  Should
perform quite a bit better.

> Things stayed up for awhile.
> 
> Now, I have another panic, typed *carefully* this time:

And this time all the numbers make sense.

> $0 : 00000000 1000fc00 00001000 ffffffe0
> $4 : 00000020 00000000 1000fc00 0000005e
> $8 : 1000fc00 1000001f 00000000 00000007
> $12: 40000000 8bf39020 3000fc00 fffffffc
> $16: 00000000 00001000 abf3f010 8bf3c800
> $20: 00000001 bfbc0003 1fffffff bfb90000
> $24: 00000000 fffff000
> $28: 88008000 88009d28 8bf58e70 880ecf3c
> epc   : 88021090
> Status: 1000fc02
> Cause : 00000008
> Aiee, killing interrupt handler
> Kernel panic: Attempted to kill the idle task!
> In swapper task - not syncing
> 
> At the time, I was building the amd RPM, for which my /usr/src/redhat is
> on /dev/sdc (unpartitioned).  At the time, the build was compliling
> amd/get_args.c with gcc.
> 
> Ideas?

Not really.  A ten second look at the register dump shows that what happend
is exactly the same as the last time.  Something is putting NULL elements
into the scatter/gather lists which either is a bug in the SCSI code or
a possible case of memory corruption.  Neither is really good.

At least I'm satisfied that your box stopped having disks for breakfast,
lunch, coffee, dinner and a dozen more meals a days :-)

Why are you using an unpartitioned disk?  You can still use fdisk to
build PC style partitions and Linux will deal with it.

  Ralf
