Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id BAA122876 for <linux-archive@neteng.engr.sgi.com>; Mon, 24 Nov 1997 01:54:39 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA19084 for linux-list; Mon, 24 Nov 1997 01:49:29 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA19040 for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 01:49:14 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id BAA12958
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 01:49:13 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-great-packet-bucket-in-the-sky [163.164.160.21] (may be forged)) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id JAA20082; Mon, 24 Nov 1997 09:48:59 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xZv6B-0005FtC; Mon, 24 Nov 97 09:46 GMT
Message-Id: <m0xZv6B-0005FtC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Libc in CVS
To: ralf@uni-koblenz.de
Date: Mon, 24 Nov 1997 09:46:35 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <19971124054108.44804@lappi.waldorf-gmbh.de> from "ralf@uni-koblenz.de" at Nov 24, 97 05:41:08 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Given that this opens the way to useable native X libraries, which makes
> building a large number of other RPM packages possible, these patches
> are quite a breakthough.

With luck it'll also fix the rpm-2.4.8 core dump bug which seems to be
bad linking. I'll turn the RPM factory back on
