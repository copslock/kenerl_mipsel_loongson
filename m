Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA69195 for <linux-archive@neteng.engr.sgi.com>; Thu, 28 Jan 1999 00:51:57 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA32237
	for linux-list;
	Thu, 28 Jan 1999 00:51:20 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA30423
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 28 Jan 1999 00:51:18 -0800 (PST)
	mail_from (tomilepp@ousrvr2.oulu.fi)
Received: from ousrvr2.oulu.fi (ousrvr2.oulu.fi [130.231.240.7]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA00752
	for <linux@cthulhu.engr.sgi.com>; Thu, 28 Jan 1999 00:51:17 -0800 (PST)
	mail_from (tomilepp@ousrvr2.oulu.fi)
Received: (from tomilepp@localhost)
	by ousrvr2.oulu.fi (8.8.5/8.8.5) id KAA25682
	for linux@cthulhu.engr.sgi.com; Thu, 28 Jan 1999 10:51:16 +0200 (EET)
From: Tomi Leppikangas <tomilepp@ousrvr2.oulu.fi>
Message-Id: <199901280851.KAA25682@ousrvr2.oulu.fi>
Subject: Re: Problems modularizing newport graphics.
To: linux@cthulhu.engr.sgi.com
Date: Thu, 28 Jan 1999 10:51:15 +0200 (EET)
In-Reply-To: <Pine.LNX.3.96.990128025217.25641P-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jan 28, 99 03:04:52 am"
Reply-To: Tomi.Leppikangas@oulu.fi
X-Mailer: ELM [version 2.4ME+ PL15 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Alright.  I know this sounds a bit weird, but I'm trying to modularize
> graphics.o.  Why? So we can debug newport graphics properly.
> 
> Just so people know where things are at; the drawbars in the XFree tree in
> CVS doesn't do a thing; there's an issue with the ioctl handling in
> drivers/sgi/char/graphics.c .

Hey this sounds good, i thougt that nothing is hapening for X. Is there
anyone else doing something for getting x-server running on sgi-linux?
Is there any other info available than whats on ftp.linux.sgi.com?


-- 
##        Tomi.Leppikangas@oulu.fi         ##
##  http://www.student.oulu.fi/~tomilepp/  ##
