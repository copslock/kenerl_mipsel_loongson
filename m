Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id MAA682338 for <linux-archive@neteng.engr.sgi.com>; Wed, 21 Jan 1998 12:01:10 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA10627 for linux-list; Wed, 21 Jan 1998 11:57:59 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA10574 for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 11:57:50 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA18660
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 11:57:46 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id TAA21927; Wed, 21 Jan 1998 19:57:19 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xv6jV-0005FsC; Wed, 21 Jan 98 20:26 GMT
Message-Id: <m0xv6jV-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: root-be-0.03.tar.gz
To: shaver@netscape.com (Mike Shaver)
Date: Wed, 21 Jan 1998 20:26:44 +0000 (GMT)
Cc: adevries@engsoc.carleton.ca, linux@cthulhu.engr.sgi.com
In-Reply-To: <34C64EB7.1FA95A9C@netscape.com> from "Mike Shaver" at Jan 21, 98 07:38:31 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I _must_ start working on EFS again.  I assume I've missed the 2.2
> freeze, but I could still help a lot of people by getting off my a** and
> finishing it.  My apologies to those who are waiting on it.

You've not missed it providing your code doesnt have to touch the fs
layer as well as fs/efs. Certainly el penguino took the ADFS patch for
2.1.80

Alan
