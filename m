Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA92805 for <linux-archive@neteng.engr.sgi.com>; Mon, 18 Jan 1999 11:59:52 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA05175
	for linux-list;
	Mon, 18 Jan 1999 11:59:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA78400
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 18 Jan 1999 11:59:00 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00401
	for <linux@cthulhu.engr.sgi.com>; Mon, 18 Jan 1999 14:58:58 -0500 (EST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA01406;
	Mon, 18 Jan 1999 14:59:01 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 18 Jan 1999 14:59:01 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Matthias Kleinschmidt <mkleinschmidt@gmx.de>
cc: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: Re: compiling kernel
In-Reply-To: <19990118143114.A988@fmc-container.mach.uni-karlsruhe.de>
Message-ID: <Pine.LNX.3.96.990118145622.30635J-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Mon, 18 Jan 1999, Matthias Kleinschmidt wrote:
> It compiles fine but it will not boot. I get the following message:
> >> boot vmlinux                                                                                                                       
> 115360+19600+3136+334528+42744d+4248+6368 entry: 0x89fa8840                                                                           
>                                                                                                                                       
> Exception: <vector=UTLB Miss>                                                                                                         

This is usually because you didn't remove the "-N" in arch/mips/Makefile
or similiar. It's in the FAQ, but I keep forgetting that myself.

My problem is when I build the kernel, I get nothing at all.  I get the
first line, something like:

115360+19600+3136+334528+42744d+4248+6368 entry: 0x89fa8840                                                                           

then a blank line, then a total hang, mouse and keybaord included.

- Alex
