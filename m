Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA2435998 for <linux-archive@neteng.engr.sgi.com>; Mon, 30 Mar 1998 23:33:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id XAA5815278
	for linux-list;
	Mon, 30 Mar 1998 23:32:49 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA5828489
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 30 Mar 1998 23:32:42 -0800 (PST)
Received: from aec.at (web.aec.at [193.170.192.5]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id XAA07712
	for <linux@cthulhu.engr.sgi.com>; Mon, 30 Mar 1998 23:32:40 -0800 (PST)
	mail_from (oliver@web.aec.at)
Received: from localhost (oliver@localhost) by aec.at (8.8.3/8.7) with SMTP id JAA09288; Tue, 31 Mar 1998 09:32:33 +0200
Date: Tue, 31 Mar 1998 09:32:33 +0200 (MET DST)
From: Oliver Frommel <oliver@aec.at>
To: ralf@uni-koblenz.de
cc: Ulf Carlsson <grimsy@zigzegv.ml.org>, linux@cthulhu.engr.sgi.com
Subject: Re: compile problem with kernel
In-Reply-To: <19980331091452.41730@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980331092404.8445B-100000@web.aec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I am currently trying to rebuild recent binutils and gcc with host=x86 and
target=mips-linux. So far I've built binutils-2.8.1 with the patch from sgi.com
applied but I have some problems building gcc. I have two questions regarding 
the setup of the crosscompilation environment:

1. is gas supposed to be part of the binutils package, of the gcc package or
 is it a package on its own? I've built gas from the binutils dist and put it
 into the binutils.rpm now while I found it in gcc-xcompile...2.7.2-3.rpm
 on sgi.com ..

2. which compiler source & patches am i supposed to use? I've tried the original
 gcc-2.7.2 with patches 2.7.2-6 and 2.7.2-7 from sgi.com applied, but I am not
 sure if those are meant to be used with a native mips-linux host & target.
 Anyway I am getting this error when I try to compile gcc now:

./xgcc -B./ -DCROSS_COMPILE -DIN_GCC    -I./include -I. -I. -I./config  \
  -DCRT_BEGIN -finhibit-size-directive -fno-inline-functions \
   -c ./crtstuff.c
as: unrecognized option `-PIC'
make: *** [stamp-crt] Error 1

(btw.: I am using a non-optimizing version of gcc on the crosscompiler host due
 to a problem with the Cyrix processor ..)


thanks
-oliver
