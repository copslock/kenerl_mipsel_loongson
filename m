Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id FAA42588 for <linux-archive@neteng.engr.sgi.com>; Sat, 26 Sep 1998 05:27:00 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA88303
	for linux-list;
	Sat, 26 Sep 1998 05:26:00 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA10550
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 26 Sep 1998 05:25:59 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA04038
	for <linux@cthulhu.engr.sgi.com>; Sat, 26 Sep 1998 05:25:57 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zMtQB-0027vxC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sat, 26 Sep 1998 14:25:55 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zMtQ2-002Ow7C; Sat, 26 Sep 98 14:25 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id OAA01687;
	Sat, 26 Sep 1998 14:11:54 +0200
Message-ID: <19980926141154.32206@alpha.franken.de>
Date: Sat, 26 Sep 1998 14:11:54 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Richard Hartensveld <richardh@infopact.nl>
Cc: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: problems with cvs
References: <360C3895.1EE98467@infopact.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <360C3895.1EE98467@infopact.nl>; from Richard Hartensveld on Sat, Sep 26, 1998 at 02:43:01AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Sep 26, 1998 at 02:43:01AM +0200, Richard Hartensveld wrote:
> bronx:~# cvs -d :pserver:anonymous@ftp.linux.sgi.com:/cvs/CVSROOT login
> (Logging in to anonymous@ftp.linux.sgi.com)
> CVS password:

try:

cvs -d :pserver:cvs@linus.linux.sgi.com:/cvs login
(password is "cvs")
cvs -d :pserver:cvs@linus.linux.sgi.com:/cvs co linux

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
