Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA2446429 for <linux-archive@neteng.engr.sgi.com>; Tue, 31 Mar 1998 06:47:33 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id GAA5386931
	for linux-list;
	Tue, 31 Mar 1998 06:47:04 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA5961123
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 31 Mar 1998 06:47:03 -0800 (PST)
Received: from aec.at (web.aec.at [193.170.192.5]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id GAA07412
	for <linux@cthulhu.engr.sgi.com>; Tue, 31 Mar 1998 06:46:58 -0800 (PST)
	mail_from (oliver@web.aec.at)
Received: from localhost (oliver@localhost) by aec.at (8.8.3/8.7) with SMTP id QAA17630 for <linux@cthulhu.engr.sgi.com>; Tue, 31 Mar 1998 16:46:53 +0200
Date: Tue, 31 Mar 1998 16:46:53 +0200 (MET DST)
From: Oliver Frommel <oliver@aec.at>
To: linux@cthulhu.engr.sgi.com
Subject: Re: compile problem with kernel
In-Reply-To: <19980331163848.49537@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980331164509.17524B-100000@web.aec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> >  as -v -KPIC -o test.o /tmp/cca22420.s
> > GNU assembler version 2.8.1 (i686-pc-linux-gnu), using BFD version linux-2.8.1.0.1
> > as: unrecognized option `-PIC'
> 
> Your crosscompiler is caling the native assembler.  Did you install binutils?
> Did you configure the sources them using the same --prefix option?
>

i installed the binutils-2.8.1 with the following configuration:

./configure --prefix=/tmp/binutils-xcompile-root/usr/local --program-prefix=mips
-linux- --enable-shared --target=mips-linux


-oliver
