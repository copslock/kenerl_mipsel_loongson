Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id GAA08087 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 06:46:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA23456 for linux-list; Wed, 14 Jan 1998 06:42:47 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA23450 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 06:42:42 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id GAA29979
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 06:42:40 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id OAA17833; Wed, 14 Jan 1998 14:42:01 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xsUPg-0005FsC; Wed, 14 Jan 98 15:07 GMT
Message-Id: <m0xsUPg-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: The world's worst RPM
To: ralf@uni-koblenz.de
Date: Wed, 14 Jan 1998 15:07:27 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, oliver@aec.at, adevries@engsoc.carleton.ca,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <19980114152935.14483@uni-koblenz.de> from "ralf@uni-koblenz.de" at Jan 14, 98 03:29:35 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Have you taken care of the fact that ncompress makes assumptions about
> the byteorder of the machine it's running on?  For MIPS it's broken, but
> I don't remember if it was on big or little endian ...

Its passed in the spec file. I've even port mipsel in as well for you ;)
