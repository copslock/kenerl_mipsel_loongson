Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA06894 for <linux-archive@neteng.engr.sgi.com>; Tue, 12 Jan 1999 16:56:08 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA86169
	for linux-list;
	Tue, 12 Jan 1999 16:55:08 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA97554
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 12 Jan 1999 16:55:06 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA09566
	for <linux@cthulhu.engr.sgi.com>; Tue, 12 Jan 1999 19:53:47 -0500 (EST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id TAA18216;
	Tue, 12 Jan 1999 19:57:49 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Tue, 12 Jan 1999 19:57:49 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: linux <linux@cthulhu.engr.sgi.com>
Subject: Re: same boot vmlinux trouble
In-Reply-To: <19990112175147.C341@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.990112195251.7688B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Tue, 12 Jan 1999 ralf@uni-koblenz.de wrote:
> 
> Alex, could you brew a binary kernel from CVS?  Thanks.


I will as soon as linus.linux.sgi.com is alive again.  Any news on this?

Incidentally, I've been working for the last few days on rewriting
libfdisk. This is used inside the RH installer to mdoify and read
partition tables.  SGI tables are wildly different than anything else of
course, and libfdisk is really only designed for pc/dos partition tables. 

So, I'm rewriting it as nlibfdisk, and has support now for reading pc, sgi
and macintosh partition tables.  It's flexible enough to easily allow
other partitioning formats.

Having this solved will let us have a better installer on the SGI, and
also on Macintosh (both m68k and ppc).

When it's looking a little less stable, I'll ask people here to give it a
shot on their partition tables (marked read only, of course).

- Alex
