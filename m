Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA55889 for <linux-archive@neteng.engr.sgi.com>; Tue, 13 Apr 1999 11:20:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA01279
	for linux-list;
	Tue, 13 Apr 1999 11:17:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA20612
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 13 Apr 1999 11:17:54 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA07715
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Apr 1999 11:17:53 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (lightning.swansea.uk.linux.org [194.168.151.1]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id TAA04958; Tue, 13 Apr 1999 19:17:42 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m10X8aD-0007TvC; Tue, 13 Apr 99 20:10 BST
Message-Id: <m10X8aD-0007TvC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Resources in X11 port
To: adisaacs@mtu.edu (Andrew Isaacson)
Date: Tue, 13 Apr 1999 20:10:52 +0100 (BST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <19990413125254.A20170@mtu.edu> from "Andrew Isaacson" at Apr 13, 99 12:52:54 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> If you (the porters) are willing to wait until June to have publicly
> distributable code, you should develop for the 4.0 branch rather than
> the 3.3 branch.  There are a lot of useful new features in the new
> code base, and the new design is quite a bit easier to code for than
> the old.

Actually I wonder if it will be. Not having seen the code because of the silly
XFree about beta releases its hard to be sure. The X folks I talked to all
pointed me at the 8514 driver - which is very similar in many ways to the
SGI cards - both are designed for X11, both have no direct frame buffer
access and they have fairly similar concepts.

I would urge btw that anyone working on an XFree SGI driver releases it under
a license like the NPL so that the XFree people can't hide it in a locked away
beta release in future.

Alan
