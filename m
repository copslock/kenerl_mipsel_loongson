Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id AAA375198 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Sep 1997 00:36:34 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA27175 for linux-list; Thu, 11 Sep 1997 00:35:49 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA27168 for <linux@cthulhu.engr.sgi.com>; Thu, 11 Sep 1997 00:35:46 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id AAA27401; Thu, 11 Sep 1997 00:35:44 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA27156; Thu, 11 Sep 1997 00:35:37 -0700
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id AAA10706; Thu, 11 Sep 1997 00:35:34 -0700
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (centre.swanlink.ukuu.org.uk [137.44.10.205]) by snowcrash.cymru.net (8.8.5-q-beta3/8.7.1) with SMTP id IAA27653; Thu, 11 Sep 1997 08:27:46 +0100
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0x93di-0005FjC; Thu, 11 Sep 97 08:26 BST
Message-Id: <m0x93di-0005FjC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Linux/SGI: MAP_AUTOGROW, F_ALLOCSP
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Thu, 11 Sep 1997 08:26:10 +0100 (BST)
Cc: miguel@nuclecu.unam.mx, linux@fir.engr.sgi.com
In-Reply-To: <199709110216.TAA26791@fir.engr.sgi.com> from "William J. Earl" at Sep 10, 97 07:16:48 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>      This seems reasonable enough.  This code supports the "shm" shared
> memory transport of Xsgi; other process mmap() the file to communicate
> with the server.  It is something of a hack (being not particularly secure).

So you use mmap() based XShm rather than the SYS5 ipc based shm Linux currently
uses. Makes some sense. As to secure well last time I looked nobody had yet
fixed the auth bug so X and security aren't related anyway
