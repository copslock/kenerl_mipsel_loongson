Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id GAA130832 for <linux-archive@neteng.engr.sgi.com>; Mon, 24 Nov 1997 06:17:20 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA17070 for linux-list; Mon, 24 Nov 1997 06:14:05 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA17051 for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 06:14:02 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id GAA24597
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 06:14:00 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-great-packet-bucket-in-the-sky [163.164.160.21] (may be forged)) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id OAA26414; Mon, 24 Nov 1997 14:11:36 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xZzCL-0005FsC; Mon, 24 Nov 97 14:09 GMT
Message-Id: <m0xZzCL-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Libc in CVS
To: ralf@lappi.waldorf-gmbh.de
Date: Mon, 24 Nov 1997 14:09:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
In-Reply-To: <19971124141804.17724@lappi.waldorf-gmbh.de> from "ralf@lappi.waldorf-gmbh.de" at Nov 24, 97 02:18:04 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> For rpm the trick is easy, just don't use a static linked binary.
> Unfortunately the Redhat guys seem to think static binaries are a good
> idea and install a static rpm by default.  Which it is not, not even
> without a buggy dynamic linker.

Static rpm 2.4.8 +fixes works
Dynamic 2.4.8 crashes on startup every time

> Ok.  I stopped communicating with the Redhat guys shortly before I left the
> US.  Essentially they received a part of the patches that I don't classify
> as ugly hacks or work in progress.

No problem

> Some more packages like the binutils, gcc or libc are based on different
> versions and we should try to base our work on the same versions as Redhat
> does.

Right now Ive got chunks of bastardised 4.8 (eg with -O not -O2 to avoid
gcc blowing up on zsh) but hopefully I can knock those out over time
