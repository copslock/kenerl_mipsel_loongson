Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA63922 for <linux-archive@neteng.engr.sgi.com>; Wed, 20 Jan 1999 09:55:29 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA11580
	for linux-list;
	Wed, 20 Jan 1999 09:54:23 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA11470
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 20 Jan 1999 09:54:21 -0800 (PST)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA07547
	for <linux@cthulhu.engr.sgi.com>; Wed, 20 Jan 1999 09:24:45 -0800 (PST)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id SAA22362;
	Wed, 20 Jan 1999 18:24:18 +0100 (MET)
Received: from aisa.fi.muni.cz (aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id SAA20873;
	Wed, 20 Jan 1999 18:24:17 +0100 (MET)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id SAA03825;
	Wed, 20 Jan 1999 18:24:17 +0100 (MET)
Message-ID: <19990120182416.P26376@aisa.fi.muni.cz>
Date: Wed, 20 Jan 1999 18:24:16 +0100
From: Honza Pazdziora <adelton@informatics.muni.cz>
To: Trevor Jennings <topcat@develop.nmdg.com>,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Installing Linux on Indy
References: <199901191346.IAA22005@develop.nmdg.com>
Mime-Version: 1.0
Content-Type: text/plain
X-Mailer: Mutt 0.93.2i
In-Reply-To: <199901191346.IAA22005@develop.nmdg.com>; from Trevor Jennings on Tue, Jan 19, 1999 at 09:11:05AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
>  Well, I am new to this mailing list and am thinking of installing Linux on
> my trusty old Indy and was wondering if there was in fact any other way of
> installing the hardhat release instead of having another linux box to boot
> from?  I was thinking of downloading the release onto jaz disk and
> installing it from there, is that possible? I believe it is great that there

To boot the kernel, you need a root. You should be able to boot from
a root created from IRIX, I'm however not sure which filesystem you
should pickup. You can create a e2fs filesystem from IRIX but I'm not
aware of any way to mount the filesystem to copy the root there. For
other filesystems, you might need to use cross-compiler to build new
kernel. [Maybe somebody else will see easier ways?]

So essentially, I'd say the answer is no. Note however that the other
computer doesn't need to be Linux box, anything that can do tftp,
bootp and nfs will be just fine. I myself boot from our Solaris
server.

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
 The total number of bytes in all expressions in the GROUP BY clause is
 limited to the size of a data block minus some overhead. --Oracle SQL Ref.
------------------------------------------------------------------------
