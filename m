Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id PAA422621 for <linux-archive@neteng.engr.sgi.com>; Mon, 5 Jan 1998 15:51:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA23945 for linux-list; Mon, 5 Jan 1998 15:48:57 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA23932 for <linux@cthulhu.engr.sgi.com>; Mon, 5 Jan 1998 15:48:56 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA18767
	for <linux@cthulhu.engr.sgi.com>; Mon, 5 Jan 1998 15:48:52 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id XAA26338; Mon, 5 Jan 1998 23:47:52 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xpMZT-0005FsC; Tue, 6 Jan 98 00:08 GMT
Message-Id: <m0xpMZT-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: gcc -shared ... -lc ?
To: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Date: Tue, 6 Jan 1998 00:08:38 +0000 (GMT)
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
In-Reply-To: <19980106001619.35362@alpha.franken.de> from "Thomas Bogendoerfer" at Jan 6, 98 00:16:19 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > This is a binutils 2.7 bug.  Upgrading to 2.8.1 solves the problem.
> 
> this is with binutils-2.8.1

Oh good its not me seeing things. Ralf - could there be two sets of your
binutils-2.8.1 one working one not and could you maybe post MD5 hashes
of your binaries you know work ?
