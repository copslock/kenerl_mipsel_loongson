Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id KAA249335 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 10:59:08 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA26780 for linux-list; Thu, 4 Dec 1997 10:58:17 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA26765; Thu, 4 Dec 1997 10:58:15 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA04130; Thu, 4 Dec 1997 10:56:22 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id SAA29707; Thu, 4 Dec 1997 18:56:19 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xdgUo-0005FsC; Thu, 4 Dec 97 18:59 GMT
Message-Id: <m0xdgUo-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Linux on the O2
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Thu, 4 Dec 1997 18:59:33 +0000 (GMT)
Cc: greg@xtp.engr.sgi.com, chatz@omen.melbourne.sgi.com, ligeh@carpediem.com,
        cwcarlson@home.com, linux@cthulhu.engr.sgi.com
In-Reply-To: <199712041722.JAA26372@fir.engr.sgi.com> from "William J. Earl" at Dec 4, 97 09:22:12 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> linux, would be reasonably general purpose.  In particular, being able
> to allocate large pages (64 KB tiles on O2) at any time, no matter how

I assume you mean physical tiles. 64K tiles on Linux is actually quite tricky
- creating them and allocating them is ok its the fact theres no current
vm way to say move this and make me a tile.  (the kernel allocated objects
arent a problem as the kernel can allocate drawing from tiles itself)

>      In graphics, if linux winds up with an IRIX-compatible kernel
> graphics driver on some SGI boxes, the IRIX Xsgi, libgl.so, and
> libGL.so platform-specific binaries could run on linux.  Note that

This is certainly a very good starting basis but its not a "complete" 
answer. Also of course one day Indy + IRIX always together wont be an
automatic fact - I dont actually believe it is in the EEC right now anyway


Alan
