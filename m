Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id OAA49340 for <linux-archive@neteng.engr.sgi.com>; Wed, 12 Nov 1997 14:29:18 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA12964 for linux-list; Wed, 12 Nov 1997 14:26:17 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA12877; Wed, 12 Nov 1997 14:26:10 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA07458; Wed, 12 Nov 1997 14:26:08 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-great-packet-bucket-in-the-sky [163.164.160.21] (may be forged)) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id WAA23702; Wed, 12 Nov 1997 22:26:02 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xVlI4-0005FtC; Wed, 12 Nov 97 22:29 GMT
Message-Id: <m0xVlI4-0005FtC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: SGI / Linux
To: ariel@cthulhu.engr.sgi.com
Date: Wed, 12 Nov 1997 22:29:40 +0000 (GMT)
Cc: paulp@netco.com, linux@cthulhu.engr.sgi.com
In-Reply-To: <199711122131.NAA21427@oz.engr.sgi.com> from "Ariel Faigon" at Nov 12, 97 01:31:42 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 	1) Remotely (bootp) all filesystem remote
> 	   (relatively easy, but slow)
> 
> 	2) Create local efs or e2fs filesystems and boot
> 	   from local disk. This is preferred but currently
> 	   requires some bootstrapping complex steps
> 	   (and completing the efs linux support by Mike Shaver)

	3) Alan's semi-mythical and slightly buggy ext2installer tool

	This is the one that should ideally get documented - and debugged 8)

	I'll put some bits up soon, but because the tools have to work
	with file definitions different to the host OS, its a horrible
	horrible hack.

On other points anyone currently working on merging to 2.1.63, and the
status on the dynamic link bugs and X11 - Any chance of a serverless
XFree86 build set for the SGI yet - that'll let me build most of the
remaining RPMs


Alan
