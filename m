Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id VAA194566 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Dec 1997 21:39:00 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA11940 for linux-list; Wed, 3 Dec 1997 21:33:36 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA11924 for <linux@cthulhu.engr.sgi.com>; Wed, 3 Dec 1997 21:33:26 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id VAA10883
	for <linux@cthulhu.engr.sgi.com>; Wed, 3 Dec 1997 21:33:23 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id AAA16713
	for <linux@cthulhu.engr.sgi.com>; Thu, 4 Dec 1997 00:31:05 -0500
Date: Thu, 4 Dec 1997 00:31:05 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: A question about architecture and byte order with RPMs
Message-ID: <Pine.LNX.3.95.971204003012.3395M-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Below is a message I sent off to the RPM development mailing list. The
folks at RedHat said it was reasonable, but I just wanted to be sure that
I got it right. Many of you understand MIPS architectures better than I,
and we don't want to be making a mistake.

Is the creation of a mipsel type reasonable?

- Alex

---------- Forwarded message ----------
Date: Tue, 2 Dec 1997 11:34:54 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: RPM-List <rpm-list@redhat.com>
Subject: A question about architecture and byte order.


I *think* there might be an issue with MIPS architecture RPMs, but I want
to make sure I get things right.

There are two branches of machines that have MIPS processors.  The first
is little endian, and it contains things like Acer Pica and Mips Magnum.
The second is big endian, and has things like my SGI Indy[1]. I'm unclear
if there are some architectures that will run both.

Now, the issue is that there aren't distinct architecture definitions for
mips (big endian) and mipsel (little endian). They aren't binary
compatible, so it does seem to me that there should be an entry like:

arch_canon:	mipsel:	mipsel	11

in rpmrc. 

Am I wrong on this?

- Alex

[1] *almost* running srpms of RedHat 5.


      Alex deVries          Rent this space for a $5 donation 
  System Administrator      to EngSoc per day.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
