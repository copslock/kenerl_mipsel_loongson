Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id MAA27799; Thu, 7 Aug 1997 12:24:54 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA04682 for linux-list; Thu, 7 Aug 1997 12:23:45 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA04674 for <linux@cthulhu.engr.sgi.com>; Thu, 7 Aug 1997 12:23:42 -0700
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA12698
	for <linux@cthulhu.engr.sgi.com>; Thu, 7 Aug 1997 12:23:10 -0700
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (centre.swanlink.ukuu.org.uk [137.44.10.205]) by snowcrash.cymru.net (8.8.5-q-beta3/8.7.1) with SMTP id UAA12433; Thu, 7 Aug 1997 20:20:46 +0100
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0wwZA8-0005FiC; Thu, 7 Aug 97 21:28 BST
Message-Id: <m0wwZA8-0005FiC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Pending fixes
To: miguel@nuclecu.unam.mx (Miguel de Icaza)
Date: Thu, 7 Aug 1997 21:27:59 +0100 (BST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199708071730.MAA21512@athena.nuclecu.unam.mx> from "Miguel de Icaza" at Aug 7, 97 12:30:46 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 	- NFS is crashing after heavy usage.  This is not the same 
> 	  problem that the 2.1 tree has on the intel.  Every time it
> 	  crashes on me it fails around the end of do_bottom_half.

How big are your kernel stacks ?
