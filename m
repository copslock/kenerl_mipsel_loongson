Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA98440 for <linux-archive@neteng.engr.sgi.com>; Fri, 25 Dec 1998 20:08:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA76094
	for linux-list;
	Fri, 25 Dec 1998 20:07:50 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA69090
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 25 Dec 1998 20:07:48 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA05955
	for <linux@cthulhu.engr.sgi.com>; Fri, 25 Dec 1998 20:07:47 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id XAA24684;
	Fri, 25 Dec 1998 23:08:01 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 25 Dec 1998 23:08:01 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: kernel build problem.
In-Reply-To: <19981225181440.C4641@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.981225230016.10100A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Fri, 25 Dec 1998 ralf@uni-koblenz.de wrote:
>   This problem is caused by a still unfixed bug in Binutils newer than
>   version 2.7.  As a workaround, remove the -N flags from LDFLAGS in
>   arch/mips/Makefile and relink the kernel.
> [...]

I should know that, seeing as how I've complained about it about 10,000
times. Sorry.

However, that last sentence should read:

As a workaround, change the following line in arch/mips/Makefile from:

LINKFLAGS       = -static -N

to:

LINKFLAGS       = -static

- Alex
