Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA63739 for <linux-archive@neteng.engr.sgi.com>; Fri, 8 May 1998 04:01:07 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA21846606
	for linux-list;
	Fri, 8 May 1998 03:58:38 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA22113885
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 8 May 1998 03:58:37 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id DAA00311
	for <linux@cthulhu.engr.sgi.com>; Fri, 8 May 1998 03:58:35 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id GAA21159
	for <linux@cthulhu.engr.sgi.com>; Fri, 8 May 1998 06:58:34 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 8 May 1998 06:58:34 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: My .99 oops...
Message-ID: <Pine.LNX.3.95.980508065104.20848B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Alright.  I rebooted with my home grown version of .99, and here's what I
got on bootup:

...
Checking for 'wait' instruction...  available
POSIX conformance testing by UNIFIX
Starting kswapd v 1.5
Floppy drive(s): fd0 is 1.44M
Unable to handle kernel paging request at virtual address 00000000, epc ==
00000000, ra == 880d0cb8
Oops: 0000
$0 : 00000000 88120018 00000000 00000040
$4 : 00000002 00000006 01000004 8811d080
$8 : 00000020 881064f0 00000000 00000000
$12: 00000008 000001c2 883c56d4 883dea4c
$16: 00000001 8817206c 8817204c 00000004
$20: ffffffff 9fc56394 00000000 9fc56394
$24: 00000001 0000000f
$28: 883dc000 883dde10 9fc4be88 880d0cb8
epc   : 000000000
Status: 1000fc03
Cause : 00000008

My guess is it's that I enabled the floppy drive (as it came as the
default).  I'll remove that, recompile and reboot.

- A


-- 
Alex deVries
"romantic engsoc guy who runs marathons" - csilcock@chat.carleton.ca
http://www.engsoc.carleton.ca/~adevries/ .
