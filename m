Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id QAA350382 for <linux-archive@neteng.engr.sgi.com>; Thu, 13 Nov 1997 16:01:08 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA08450 for linux-list; Thu, 13 Nov 1997 15:59:15 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA08366; Thu, 13 Nov 1997 15:59:06 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA24482; Thu, 13 Nov 1997 15:59:04 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-great-packet-bucket-in-the-sky [163.164.160.21] (may be forged)) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id XAA20632; Thu, 13 Nov 1997 23:58:30 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xW9Dg-0005FsC; Fri, 14 Nov 97 00:02 GMT
Message-Id: <m0xW9Dg-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: SGI / Linux
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Fri, 14 Nov 1997 00:02:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, ariel@cthulhu.engr.sgi.com, paulp@netco.com,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.971113173913.4779I-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Nov 13, 97 05:41:40 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Uh, how would this fit in with RPM?  Would it be possible to run the Irix
> version of RPM to pre-load the packages on an ext2 disk?

The cpio code Im using is actually from Erik's RPM 2.4.8. Conceptually
there is no problem installing RPM's with it. However there are good reasons
why not to - notably the libe2fs code doesnt not have the fragmentation
evasion stuff the real ext2 does.

No I see the install as a variant of that program so something like


fdisk /dev/whatever
mke2fs /dev/dsk/whatever
mklinuxswap /dev/dsk/swapdisk
installer
load some basic cpio's

boot linux - add the rpms.

Alan
