Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA91859 for <linux-archive@neteng.engr.sgi.com>; Sun, 4 Oct 1998 04:53:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA54169
	for linux-list;
	Sun, 4 Oct 1998 04:52:32 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA10144
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 4 Oct 1998 04:52:30 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA05154
	for <linux@cthulhu.engr.sgi.com>; Sun, 4 Oct 1998 04:52:29 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (lightning.swansea.uk.linux.org [194.168.151.1]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id NAA14305; Sun, 4 Oct 1998 13:22:01 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0zPnb2-000aNTC; Sun, 4 Oct 98 13:49 BST
Message-Id: <m0zPnb2-000aNTC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: HAL2
To: grim@zigzegv.ml.org (Ulf Carlsson)
Date: Sun, 4 Oct 1998 13:49:07 +0100 (BST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.96.981004125525.2569A-100000@calypso.saturn> from "Ulf Carlsson" at Oct 4, 98 01:23:12 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> level applications. The implementation of my HAL2 driver will exist in
> kernel space, and a user level library will provide higher level interface
> to the applications (the same interface as libaudio.a in IRIX). Do we know
> what the interface between libaudio.a and the Irix kernel looks like or am
> I free to do what I want?
> 
> The code I've written so far is based upon this idea.
> 
> Is this the Right Thing to do it?

Not IMHO, well not unless it also supports the sound ioctls that every
other Linux platform does as well. 
