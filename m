Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id DAA128561 for <linux-archive@neteng.engr.sgi.com>; Mon, 24 Nov 1997 03:35:45 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA07745 for linux-list; Mon, 24 Nov 1997 03:33:33 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA07740 for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 03:33:31 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id DAA28925
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 03:33:28 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-great-packet-bucket-in-the-sky [163.164.160.21] (may be forged)) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id LAA23091; Mon, 24 Nov 1997 11:33:08 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xZwiw-0005FsC; Mon, 24 Nov 97 11:30 GMT
Message-Id: <m0xZwiw-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Libc in CVS
To: ralf@uni-koblenz.de
Date: Mon, 24 Nov 1997 11:30:41 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux@cthulhu.engr.sgi.com
In-Reply-To: <19971124120549.01585@lappi.waldorf-gmbh.de> from "ralf@uni-koblenz.de" at Nov 24, 97 12:05:49 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > With luck it'll also fix the rpm-2.4.8 core dump bug which seems to be
> > bad linking.
> 
> My rpm has never dumped core but it was complaining about nonexisting
> users while creating the binary rpm file even though the user was
> existing thus failing to build.  That rpm problem is fixed.

Yep thats the bug - I also got some crashes. It was caused by getpw* failing
in peculiar ways. My RPM binary has its own 

> All the source RPM packages on linus are known to build and work for
> little endian targets.  Some of them, for example ncompress, have special
> modifications to support big endian targets.

Im actually trying to build a full RedHat 5.0 by early December so Im picking
up your changes to stuff like bash indirectly via redhat on the whole. I can
then merge anything that escaped and together we can make sure they are in 
RH5.1.

Obviously as of about Dec1 the amount of answers I can get from RedHat will
noise dive for a couple of months

Alan
