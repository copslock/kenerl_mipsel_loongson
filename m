Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA2993433 for <linux-archive@neteng.engr.sgi.com>; Tue, 28 Apr 1998 15:02:29 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA17781461
	for linux-list;
	Tue, 28 Apr 1998 15:01:13 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA17830674
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 28 Apr 1998 15:01:11 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id PAA27549
	for <linux@cthulhu.engr.sgi.com>; Tue, 28 Apr 1998 15:00:51 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id SAA27230
	for <linux@cthulhu.engr.sgi.com>; Tue, 28 Apr 1998 18:00:49 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Tue, 28 Apr 1998 18:00:49 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Closer...
Message-ID: <Pine.LNX.3.95.980428175303.13373I-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Well, Ralf was kind enough to send me a custom kernel to try and address
my latest problems.  It looks like I'm not missing any more files (*yay*),
but it did take some time to re-install everything I'd lost.

Things stayed up for awhile.

Now, I have another panic, typed *carefully* this time:

$0 : 00000000 1000fc00 00001000 ffffffe0
$4 : 00000020 00000000 1000fc00 0000005e
$8 : 1000fc00 1000001f 00000000 00000007
$12: 40000000 8bf39020 3000fc00 fffffffc
$16: 00000000 00001000 abf3f010 8bf3c800
$20: 00000001 bfbc0003 1fffffff bfb90000
$24: 00000000 fffff000
$28: 88008000 88009d28 8bf58e70 880ecf3c
epc   : 88021090
Status: 1000fc02
Cause : 00000008
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing

At the time, I was building the amd RPM, for which my /usr/src/redhat is
on /dev/sdc (unpartitioned).  At the time, the build was compliling
amd/get_args.c with gcc.

Ideas?

- A

-- 
Alex deVries
"romantic engsoc guy who runs marathons" - csilcock@chat.carleton.ca
http://www.engsoc.carleton.ca/~adevries/ .
