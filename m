Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id SAA911247 for <linux-archive@neteng.engr.sgi.com>; Tue, 30 Sep 1997 18:07:11 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA23852 for linux-list; Tue, 30 Sep 1997 18:05:09 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA23785 for <linux@engr.sgi.com>; Tue, 30 Sep 1997 18:05:00 -0700
Received: from dns.cobaltmicro.com ([209.19.61.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA22581
	for <linux@engr.sgi.com>; Tue, 30 Sep 1997 18:03:29 -0700
	env-from (ralf@dns.cobaltmicro.com)
Received: (from ralf@localhost)
	by dns.cobaltmicro.com (8.8.5/8.8.5) id SAA22736;
	Tue, 30 Sep 1997 18:02:51 -0700
From: Ralf Baechle <ralf@cobaltmicro.com>
Message-Id: <199710010102.SAA22736@dns.cobaltmicro.com>
Subject: For stability freaks ...
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Date: Tue, 30 Sep 1997 18:02:51 -3100 (PDT)
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ok, I said I'd touch 2.0.x for MIPS again when hell freezes.  It was
damn cold weather the last days and hell has froozen ...

[root@(none) /]# uname -a
Linux (none) 2.0.30 #389 Tue Sep 30 17:47:39 PDT 1997 mips unknown
[root@(none) /]# cat /proc/cpuinfo
cpu                     : MIPS
cpu model               : Nevada V1.0
system type             : Cray YMP  [just kidding ...]
BogoMIPS                : 131.89
byteorder               : little endian
unaligned accesses      : 0
wait instruction        : yes
microsecond timers      : yes
extra interrupt vector  : yes

  Ralf
