Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA78989 for <linux-archive@neteng.engr.sgi.com>; Fri, 8 May 1998 06:36:13 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA18050726
	for linux-list;
	Fri, 8 May 1998 06:34:54 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA21291310
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 8 May 1998 06:34:52 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id GAA06706
	for <linux@cthulhu.engr.sgi.com>; Fri, 8 May 1998 06:34:51 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id JAA24220
	for <linux@cthulhu.engr.sgi.com>; Fri, 8 May 1998 09:34:49 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 8 May 1998 09:34:49 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: damn...
Message-ID: <Pine.LNX.3.95.980508091805.20848I-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



I have a couple of problems with .99, but they're not nearly as bad as
before.  No more hanging, anyway.  

- again, talking to sdc (and only sdc, not sdb).  I had two problems: 
   - when e2fsck'ing a badly broken disk, I got a couple thosand
     panics on the screen.  Sorry, I didn't write the error down.
   - when doing a lot of IO on the disk:
page fault from irq handler: 0000
$0 : 00000000 1000fc00 00001000 ffffffe0
$4 : 00000020 00000000 1000fc00 00000001
$8 : 1000fc00 1000001f 883185e0 88142618
$12: 00000001 1000fc01 80000000 00000001
$16: 00000000 00001000 a83db020 883d9c00
$20: 00000002 bfbc0003 1fffffff bfb90000
$24: 00000002 2aac92d0
$28: 88008000 88009d28 883cae70 880f23ec
epc   : 88020e80
Status: 1000fc02
Cause : 00000008
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing

- user space stuff, in glibc I think, init seg faulted

Sure, 99 isn't perfect, but it's a lot nicer than it was.  I can't tell
you how pleasant it is now that I don't havethese hangs.  And I can
completely get rid of any problems if I just don't use sdc.  Hmmm... this
has me thinking that maybe my disk is toast, which would be disappointing,
since compiling all this stuff is much nicer with 4GB of disk space
instead of 1.

I'll be off to run a half marathon and visiting my Mom in sunny Ottawa,
Canada this weekend, so I won't have a chance to do much more
debugging/nit picking.

- A


-- 
Alex deVries
"romantic engsoc guy who runs marathons" - csilcock@chat.carleton.ca
http://www.engsoc.carleton.ca/~adevries/ .
