Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id FAA92449 for <linux-archive@neteng.engr.sgi.com>; Sun, 4 Oct 1998 05:12:00 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA91542
	for linux-list;
	Sun, 4 Oct 1998 05:11:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA48382
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 4 Oct 1998 05:11:28 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA08476
	for <linux@cthulhu.engr.sgi.com>; Sun, 4 Oct 1998 05:11:15 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (lightning.swansea.uk.linux.org [194.168.151.1]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id NAA14545; Sun, 4 Oct 1998 13:40:57 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0zPntI-000aNTC; Sun, 4 Oct 98 14:08 BST
Message-Id: <m0zPntI-000aNTC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: HAL2
To: grim@zigzegv.ml.org (Ulf Carlsson)
Date: Sun, 4 Oct 1998 14:08:00 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.96.981004140033.2695B-100000@calypso.saturn> from "Ulf Carlsson" at Oct 4, 98 02:06:40 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> If you run Linux on a sparc, it provides access to an interface,
> /dev/audio, similar to the one you find in Solaris (I don't have Solaris,
> but the include file, asm-sparc/audioio.h tells me that it does). 

Yes

> You just told me that you thought my way to do it was an incorrect way og
> doing it, tell me how it should be done instead. 

Supporting the Indy ioctls is fine. However like the sparc, ppc, m68k,
ix86, alpha and arm you need to support the common OSS API. I don't know
if supporting the OSS API is sufficient alone to write libaudio over since
I dont know a ton about the internals of the libaudio stuff on SGI's.

Basically though the OSS API is a common API across all the linux platforms.

Alan
