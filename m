Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id RAA111376 for <linux-archive@neteng.engr.sgi.com>; Sat, 8 Nov 1997 17:16:37 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA00829 for linux-list; Sat, 8 Nov 1997 17:15:17 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA00821; Sat, 8 Nov 1997 17:15:10 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA29504; Sat, 8 Nov 1997 17:15:09 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (centre.swanlink.ukuu.org.uk [137.44.10.205]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id BAA25182; Sun, 9 Nov 1997 01:14:54 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xUL0I-0005GQC; Sun, 9 Nov 97 00:13 GMT
Message-Id: <m0xUL0I-0005GQC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Fix your bootloader
To: michaelk@netghost.engr.sgi.com (Michael Kaye)
Date: Sun, 9 Nov 1997 00:13:26 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <9711061005.ZM4557@netghost.engr.sgi.com> from "Michael Kaye" at Nov 6, 97 10:05:23 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I am installing linux on an indy for the first time. I was following the
> instructions on http://www.linux.sgi.com/faq.html when I noticed the
> instructions where not complete.  It talks about "Fixing your bootloader".  I
> assume it is talking about NVRAM and the PROM Monitor, but I can not find
> anything in the man pages.  I found bootfile, bootmode and boottune, but no
> bootloader.  Any ideas what to do at this point?

Turn the box on from cold, bang escape repeatedly as it boots until you get
a screen with about 6 icons and a mouse pointer. Click on the command line
one and do

boot /vmlinux options-go-here

Alan
