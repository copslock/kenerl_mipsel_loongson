Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id OAA413482 for <linux-archive@neteng.engr.sgi.com>; Wed, 29 Oct 1997 14:47:47 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA19138 for linux-list; Wed, 29 Oct 1997 14:46:47 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA19128; Wed, 29 Oct 1997 14:46:43 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA23620; Wed, 29 Oct 1997 14:46:31 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-great-packet-bucket-in-the-sky [163.164.160.21] (may be forged)) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id WAA06898; Wed, 29 Oct 1997 22:46:06 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xQgoS-0005FrC; Wed, 29 Oct 97 22:42 GMT
Message-Id: <m0xQgoS-0005FrC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Step by step of my experience
To: miguel@nuclecu.unam.mx (Miguel de Icaza)
Date: Wed, 29 Oct 1997 22:42:08 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, ariel@cthulhu.engr.sgi.com, mgix@nothingreal.com,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <199710292150.PAA15807@athena.nuclecu.unam.mx> from "Miguel de Icaza" at Oct 29, 97 03:50:29 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> The latest SysV init works around this problem.  Or at least fixes all
> the problems for me.

Ok I'll upgrade that when I build it as an rpm.

2.1.55 was fairly stable although rebuilding 3 rpms one of which is the
howto's one (spends most of its time copying and compressing 200Mb of data)
did finally get me a disk read from beyond the end of the disk.

A pile of rpms are on ftp.uk.linux.org:/pub/linux/incoming/SGI. I'll start
playing collect the RedHat 4.9.1 rpms with other folks I guess now.

Alan
