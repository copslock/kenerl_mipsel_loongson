Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id NAA214278 for <linux-archive@neteng.engr.sgi.com>; Thu, 12 Feb 1998 13:59:04 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA21215 for linux-list; Thu, 12 Feb 1998 13:57:06 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA21201 for <linux@cthulhu.engr.sgi.com>; Thu, 12 Feb 1998 13:57:05 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA29211
	for <linux@cthulhu.engr.sgi.com>; Thu, 12 Feb 1998 13:57:03 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id VAA06027; Thu, 12 Feb 1998 21:56:20 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0y36d2-0005FsC; Thu, 12 Feb 98 21:57 GMT
Message-Id: <m0y36d2-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: TLB entries > 4kb
To: Dave@imladris.demon.co.uk (David Woodhouse)
Date: Thu, 12 Feb 1998 21:57:07 +0000 (GMT)
Cc: mingo@chiara.csoma.elte.hu, alan@lxorguk.ukuu.org.uk, ralf@uni-koblenz.de,
        linux-kernel@vger.rutgers.edu, linux@cthulhu.engr.sgi.com
In-Reply-To: <E0y36YO-00042j-00@imladris.demon.co.uk> from "David Woodhouse" at Feb 12, 98 09:52:19 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> >  The way its done is ok normally. I guess you need to make X over
> > Linux/RT call the rtlinux kernel to handle it. Note X _has_ to do
> > those global cli/sti's to meet hardware needs
> 
> GGI (well, KGI) should be able to fix both of these, shouldn't it?

Not for Linux/RT - the kernel cant do real cli/sti pairs. The stuff
would have to become an RTLinux graphics setup call set
