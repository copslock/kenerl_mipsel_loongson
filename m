Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA2303363 for <linux-archive@neteng.engr.sgi.com>; Sun, 29 Mar 1998 23:44:20 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id XAA5347025
	for linux-list;
	Sun, 29 Mar 1998 23:43:50 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA5448303
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 29 Mar 1998 23:43:48 -0800 (PST)
Received: from aec.at (web.aec.at [193.170.192.5]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id XAA01385
	for <linux@cthulhu.engr.sgi.com>; Sun, 29 Mar 1998 23:43:45 -0800 (PST)
	mail_from (oliver@web.aec.at)
Received: from localhost (oliver@localhost) by aec.at (8.8.3/8.7) with SMTP id JAA20841 for <linux@cthulhu.engr.sgi.com>; Mon, 30 Mar 1998 09:42:59 +0200
Date: Mon, 30 Mar 1998 09:42:56 +0200 (MET DST)
From: Oliver Frommel <oliver@aec.at>
To: linux@cthulhu.engr.sgi.com
Subject: compile problem with kernel
Message-ID: <Pine.LNX.3.96.980330093827.20663A-100000@web.aec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

hello,

i got the kernel (linux-980326) from linux.sgi.com and had the following
problems crosscompiling it from intel-linux (which appeared on list once, but
without any answer/solution as far as i remember):

mips-linux-gcc -D__KERNEL__ -I/mnt/dsk1/devel/mips/linux-980326/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -pipe -c entry.S -o entry.o
entry.S: Assembler messages:
entry.S:147: Error: .previous without corresponding .section; ignored
entry.S:147: Error: .previous without corresponding .section; ignored
entry.S:148: Error: .previous without corresponding .section; ignored
entry.S:148: Error: .previous without corresponding .section; ignored
entry.S:154: Error: .previous without corresponding .section; ignored
entry.S:154: Error: .previous without corresponding .section; ignored
entry.S:156: Error: .previous without corresponding .section; ignored
entry.S:156: Error: .previous without corresponding .section; ignored
entry.S:157: Error: .previous without corresponding .section; ignored
entry.S:157: Error: .previous without corresponding .section; ignored
entry.S:158: Error: .previous without corresponding .section; ignored
entry.S:158: Error: .previous without corresponding .section; ignored
make[1]: *** [entry.o] Error 1
make[1]: Leaving directory `/mnt/dsk1/devel/mips/linux-980326/arch/mips/kernel'
make: *** [linuxsubdirs] Error 2


i'd appreciate an explanation what's happening here very much ..

thanks
-oliver
