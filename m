Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA2515286 for <linux-archive@neteng.engr.sgi.com>; Sat, 25 Apr 1998 20:41:17 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA16686567
	for linux-list;
	Sat, 25 Apr 1998 20:39:58 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA13929946
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 25 Apr 1998 20:39:55 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id UAA12084
	for <linux@cthulhu.engr.sgi.com>; Sat, 25 Apr 1998 20:39:54 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-01.uni-koblenz.de [141.26.249.1])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id FAA04281
	for <linux@cthulhu.engr.sgi.com>; Sun, 26 Apr 1998 05:39:52 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id FAA11139;
	Sun, 26 Apr 1998 05:39:38 +0200
Message-ID: <19980426053938.20282@uni-koblenz.de>
Date: Sun, 26 Apr 1998 05:39:38 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: gcc RPM missing crtbegin.o
References: <19980426034839.39956@uni-koblenz.de> <Pine.LNX.3.95.980425225255.4684E-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980425225255.4684E-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sat, Apr 25, 1998 at 11:00:38PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Apr 25, 1998 at 11:00:38PM -0400, Alex deVries wrote:

> > I've fixed *shitloads* of bugs since .72, not too mention a dramatic increase
> > in performance.  You're right, filesystems on Indys (not other MIPS boxes)
> > had the problem of a certain ``volatilibility'', but that's gone for me.
> 
> Yup, just bootstrapping from .72 to .91 was a bit troubling.

Ok.

> > If somebody still sees fs corruption on Indys running 2.1.91, please report.
> 
> I do have a problem that just came up.  Here it is, hand typed.  I was
> doing a lot of work on sdc, which is an external 3GB drive that I know
> works well.  It hasn't reported any problems in e2fsck.  There was a lot
> of activity when this happened:

Did you already fsck the filesystems running .91?  The corruption in the
older kernels was happening silently, so the boot fsck may have been skipped
even though the fs was corrupted.

> EXT2-fs error (device 08:11): ext2_find_entry: bad entry in directory
> #41117: rec_len is smaller than minimal - offset = 0, inode=0, rec_len=0,
> name_len = 0
> EXT2-fs error (device 08:11): ext2_find_entry: bad entry in directory
> #41117: rec_len is smaller than minimal - offset = 0, inode=0, rec_len=0,
> name_len = 0
> page fault from irq handler: 0000
> $0 : 00000000 1000fc00 00001000 ffffffe0
> $4 : 00000020 00000000 1000fc00 00000001
> $8 : 1000fc00 1000001f 00000000 00000007
> $12: 40000000 8bf50020 1000fc00 00000001
> $16: 00000000 00001000 abf56020 8bf53800
> $20: 00000002 bfbc0003 1fffffff bfb90000
> $24: 00000002 0fb6f710 
> $28: 00008000 08009d28 8bf57e70 080f3b5c
                                  ^^^^^^^^
> epc   :88020fc0
         ^^^^^^^^

Can you disassemble (mips-linux-objdump -d vmlinux) the kernel image and
tell me where these two addresses are pointing to?  Just send me twenty
lines or so around the addresses.  (In general that's the right thing to
do when the machine bombs with a register dump.)

(Also I'm pretty shure that you misstyped $28 and $29 or something really
bad happend.)

When did the kernel bomb?  During boot or?  What activity was going on
at the time when it happend?

  Ralf
