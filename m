Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id CAA67736 for <linux-archive@neteng.engr.sgi.com>; Fri, 19 Dec 1997 02:58:04 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id CAA02592 for linux-list; Fri, 19 Dec 1997 02:56:50 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA02584 for <linux@cthulhu.engr.sgi.com>; Fri, 19 Dec 1997 02:56:45 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id CAA01127
	for <linux@cthulhu.engr.sgi.com>; Fri, 19 Dec 1997 02:56:43 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id KAA32315; Fri, 19 Dec 1997 10:55:10 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xj0G8-0005FsC; Fri, 19 Dec 97 11:06 GMT
Message-Id: <m0xj0G8-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Merge back
To: ralf@uni-koblenz.de
Date: Fri, 19 Dec 1997 11:06:23 +0000 (GMT)
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        linux-mips@vger.rutgers.edu
In-Reply-To: <19971219081856.16849@uni-koblenz.de> from "ralf@uni-koblenz.de" at Dec 19, 97 08:18:56 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Linus finally accepted my kernel patches and included them into 2.1.73
> that way at least the bulky parts are now synchronsized with him.  I'll
> work on gradually fully integrating the rest of the MIPS stuff.
> I think we should go for Jazz, RM200 and Indy support in 2.2.

Cool. I've got a new monitor, binutils and glib, but before anyone else
ends up back in Irix mending their disk - the ld.so rpm in the big
endian dir is little endian...
