Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id NAA37663 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Oct 1997 13:15:47 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA27733 for linux-list; Thu, 16 Oct 1997 13:15:09 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA27696 for <linux@cthulhu.engr.sgi.com>; Thu, 16 Oct 1997 13:15:07 -0700
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA28896
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Oct 1997 13:15:05 -0700
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (centre.swanlink.ukuu.org.uk [137.44.10.205]) by snowcrash.cymru.net (8.8.5-q-beta3/8.7.1) with SMTP id VAA26939; Thu, 16 Oct 1997 21:10:20 +0100
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xLvHY-0005G4C; Thu, 16 Oct 97 20:08 BST
Message-Id: <m0xLvHY-0005G4C@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: More Linux/SGI status
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Thu, 16 Oct 1997 20:08:28 +0100 (BST)
Cc: eak@detroit.sgi.com, linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
In-Reply-To: <Pine.LNX.3.95.971016113322.32057A-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Oct 16, 97 11:39:29 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Stick your kernel in /, and boot it.  That kernel would have to have the
> EFS file system enabled so that you could mount a local disk with a Linux
> image as /.  Then, partition your other disk, and install RPM's to your
> heart's content.

NFSroot is another possible way...

Alan
