Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id BAA308984 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Dec 1997 01:50:58 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA23157 for linux-list; Wed, 17 Dec 1997 01:48:52 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA23147 for <linux@engr.sgi.com>; Wed, 17 Dec 1997 01:48:48 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id BAA18573
	for <linux@engr.sgi.com>; Wed, 17 Dec 1997 01:48:46 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-07.uni-koblenz.de [141.26.249.7])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id KAA26682
	for <linux@engr.sgi.com>; Wed, 17 Dec 1997 10:48:10 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id KAA18166;
	Wed, 17 Dec 1997 10:43:35 +0100
Message-ID: <19971217104334.61898@uni-koblenz.de>
Date: Wed, 17 Dec 1997 10:43:34 +0100
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu, tcharron@interlog.com
Subject: RC5-64 client for Linux/MIPS
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Recently, on a MIPS box a couple of ms away ...

[root@tbird rc5]# ./rc564 -benchmark

RC5-64 v2.6401 client - a project of distributed.net
Copyright distributed.net 1997
Visit http://www.distributed.net/ for more information. 'rc564 HELP' for usage

Benchmarking with 10000000 tests:
.....10%.....20%.....30%.....40%.....50%.....60%.....70%.....80%.....90%....
Complete in 88.86 seconds. [112532.37 keys/sec]
[root@tbird rc5]# uname -a
Linux rm200.mips-man.org 2.1.56 #204 Wed Nov 26 23:21:24 PST 1997 mips unknown
[root@tbird rc5]# cat /proc/cpuinfo 
cpu                     : MIPS
cpu model               : R4600 V2.0
system type             : SNI RM200 PCI
BogoMIPS                : 133.12
byteorder               : little endian
unaligned accesses      : 48
wait instruction        : yes
microsecond timers      : yes
extra interrupt vector  : no
hardware watchpoint     : no
[root@tbird rc5]# 

How about joining the RC5-64 effort as "Team MIPS"?  I'll build binary
packages and will make them available via the usual ftp sites (ftp.fnet.fr,
ftp.linux.sgi.com) as well as via www.distributed.net.

I didn't take myself the time for comparing the benchmarks with other
machine but I think the numbers leave whishes about higher performance
open.

Btw, the RC5 client for MIPS was delayed alot by the recently reported
libg++ showstopper bug.  I haven't fixed the problem yet for real but
once again it smells like a dynamic linker bug.  I was able to work
around by a static (yuck) executable.

Ok, and now it's up to you people to burn your cycles.

  Ralf  (... gimme all your CPU ...)
