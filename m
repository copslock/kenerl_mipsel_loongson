Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA695886 for <linux-archive@neteng.engr.sgi.com>; Wed, 8 Apr 1998 12:16:58 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id MAA9305558
	for linux-list;
	Wed, 8 Apr 1998 12:15:22 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA9401696
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 8 Apr 1998 12:15:20 -0700 (PDT)
Received: from aec.at (web.aec.at [193.170.192.5]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id MAA24947
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Apr 1998 12:14:39 -0700 (PDT)
	mail_from (oliver@web.aec.at)
Received: from localhost (oliver@localhost) by aec.at (8.8.3/8.7) with SMTP id VAA07489 for <linux@cthulhu.engr.sgi.com>; Wed, 8 Apr 1998 21:14:37 +0200
Date: Wed, 8 Apr 1998 21:14:37 +0200 (MET DST)
From: Oliver Frommel <oliver@aec.at>
To: linux@cthulhu.engr.sgi.com
Subject: crosstools rpms
Message-ID: <Pine.LNX.3.96.980408210954.7403A-100000@web.aec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

hi,

i've put up binutils and gcc for crosscompiling (host=x86, target=mips-linux)
up for ftp:

ftp://zero.aec.at/pub/sgi-linux/RPMS/binutils-x-mips-2.8.1-1.i386.rpm
ftp://zero.aec.at/pub/sgi-linux/RPMS/gcc-x-mips-2.7.2.2-1.i386.rpm

the tools are capable of compiling 2.1.90 and require glibc.
if there's any interest i can make the SRPMs, RPMs for libc5 and/or
an IRIX package available too eventually ..

bye
-oliver
