Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id NAA13707 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 13:54:13 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA26857 for linux-list; Wed, 14 Jan 1998 13:52:01 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA26847 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 13:51:59 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA14667
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 13:51:55 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id VAA25949; Wed, 14 Jan 1998 21:51:52 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xsb7r-0005FsC; Wed, 14 Jan 98 22:17 GMT
Message-Id: <m0xsb7r-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: The world's worst RPM
To: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Date: Wed, 14 Jan 1998 22:17:31 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <19980114215847.36294@alpha.franken.de> from "Thomas Bogendoerfer" at Jan 14, 98 09:58:47 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> hmm, to do this with only one src.rpm, we need a little support from
> rpm. At the moment mips is defined for mipsel and mipseb. I would suggest,
> that for .spec execution mips is defined for bot mipsel and mipseb, because 
> there are changes, which work for both and we only need to seperate changes 
> like that needed by ncompress.  Comments ? Does anybody how to do this ?

Just ask Erik Troan nicely 
