Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA83475 for <linux-archive@neteng.engr.sgi.com>; Thu, 21 Jan 1999 09:51:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA40642
	for linux-list;
	Thu, 21 Jan 1999 09:50:43 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA37108
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 21 Jan 1999 09:50:41 -0800 (PST)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA04008
	for <linux@cthulhu.engr.sgi.com>; Thu, 21 Jan 1999 09:50:37 -0800 (PST)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id SAA28793;
	Thu, 21 Jan 1999 18:50:34 +0100 (MET)
Received: from aisa.fi.muni.cz (aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id SAA14886;
	Thu, 21 Jan 1999 18:50:33 +0100 (MET)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id SAA21822;
	Thu, 21 Jan 1999 18:50:32 +0100 (MET)
Message-ID: <19990121185032.Z13229@aisa.fi.muni.cz>
Date: Thu, 21 Jan 1999 18:50:32 +0100
From: Honza Pazdziora <adelton@informatics.muni.cz>
To: Richard Hartensveld <richard@infopact.nl>,
        Honza Pazdziora <adelton@informatics.muni.cz>
Cc: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: mezzanine board
References: <36A749AA.6E28B33E@infopact.nl> <19990121164440.V13229@aisa.fi.muni.cz> <36A75138.3C924284@infopact.nl>
Mime-Version: 1.0
Content-Type: text/plain
X-Mailer: Mutt 0.93.2i
In-Reply-To: <36A75138.3C924284@infopact.nl>; from Richard Hartensveld on Thu, Jan 21, 1999 at 08:09:29AM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Richard, thanks you.

> Sure, just hook-up a terminal to the serial port, link /dev/console to
> /dev/ttyS1 on your nfs-root, and don't forget to change
> setup-1.9.1-2.noarch.rpm to add some securetty's so that

I've added this to the http://www.linux.sgi.com/manhattan/ page.
A note about Challenge S has also been added to other pages.

> Well, no hinv since i'm not running irix on the machine anymore (i boot  it
> over the network), but here's the dmesg from within linux.This is a
> self-compiled kernel, using the cvs tree from linus.linux, but the kernel
> included with the hardhat package installs just as good.
> If you wish, i can send you the rebuild setup...noarch.rpm to put on the
> webpage for other people who wish to try linux on a S.

To others on the list: shall we make a new page with setups? Otherwise
I'd just link Richard's setup from /manhattan/.

Yours,

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
 The total number of bytes in all expressions in the GROUP BY clause is
 limited to the size of a data block minus some overhead. --Oracle SQL Ref.
------------------------------------------------------------------------
