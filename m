Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id QAA1348645 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Sep 1997 16:13:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA18619 for linux-list; Fri, 5 Sep 1997 16:11:40 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA18590 for <linux@cthulhu.engr.sgi.com>; Fri, 5 Sep 1997 16:11:38 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id QAA20317; Fri, 5 Sep 1997 16:11:28 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA18437; Fri, 5 Sep 1997 16:11:28 -0700
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA14896; Fri, 5 Sep 1997 16:11:24 -0700
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (centre.swanlink.ukuu.org.uk [137.44.10.205]) by snowcrash.cymru.net (8.8.5-q-beta3/8.7.1) with SMTP id AAA08941; Sat, 6 Sep 1997 00:10:23 +0100
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0x77Rs-0005FjC; Sat, 6 Sep 97 00:05 BST
Message-Id: <m0x77Rs-0005FjC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: [Q: Linux/SGI] IRIX executable memory map.
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Sat, 6 Sep 1997 00:05:56 +0100 (BST)
Cc: miguel@nuclecu.unam.mx, linux@fir.engr.sgi.com
In-Reply-To: <199709052251.PAA20078@fir.engr.sgi.com> from "William J. Earl" at Sep 5, 97 03:51:00 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>      Simply automatically create the page in the page fault handler
> when it is first referenced.  Treat as if it were an mmap() of /dev/zero
> for 1 page.

Better to map it first. page fault is a far more critical path to stick
conditionals into. Even better if possible is to stick it into the userspace
dynamic loader for irix binaries. That however means not using the irix one
or having a "preloader" before it

Alan
