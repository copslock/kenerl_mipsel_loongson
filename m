Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA26419 for <linux-archive@neteng.engr.sgi.com>; Thu, 24 Sep 1998 13:05:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA74584
	for linux-list;
	Thu, 24 Sep 1998 13:03:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA82702
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 24 Sep 1998 13:03:35 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA00699
	for <linux@cthulhu.engr.sgi.com>; Thu, 24 Sep 1998 13:03:28 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id VAA06928; Thu, 24 Sep 1998 21:33:14 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0zMCB8-000aQzC; Thu, 24 Sep 98 15:15 BST
Message-Id: <m0zMCB8-000aQzC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: challenge s boots linux
To: jwelling@engin.umich.edu (Jeremy John Welling)
Date: Thu, 24 Sep 1998 15:15:29 +0100 (BST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.SOL.4.02.9809240031070.6032-100000@azure.engin.umich.edu> from "Jeremy John Welling" at Sep 24, 98 00:47:07 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> What is the next architecture sgi/linux will be ported to?  Indigo2 r4kXZ?  
> What is the status of the newport Xserver? What is the best place to get

Im still learning about the internals of the Xserver and building an
"fb" driver layer to glue to the accelerated stuff. I've been dicing up
afb so that it generates newport_something() commands for each area
after having done its clipping. Hopefully they'll approximately match
the real newport 8)
