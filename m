Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id AAA164544 for <linux-archive@neteng.engr.sgi.com>; Thu, 12 Feb 1998 00:58:40 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA02022 for linux-list; Thu, 12 Feb 1998 00:51:00 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA02008 for <linux@cthulhu.engr.sgi.com>; Thu, 12 Feb 1998 00:50:50 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id AAA03808
	for <linux@cthulhu.engr.sgi.com>; Thu, 12 Feb 1998 00:50:48 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id IAA23062; Thu, 12 Feb 1998 08:50:31 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0y2uMG-0005FsC; Thu, 12 Feb 98 08:51 GMT
Message-Id: <m0y2uMG-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: TLB entries > 4kb
To: ralf@uni-koblenz.de
Date: Thu, 12 Feb 1998 08:51:00 +0000 (GMT)
Cc: linux-kernel@vger.rutgers.edu, linux@cthulhu.engr.sgi.com
In-Reply-To: <19980212055648.54198@uni-koblenz.de> from "ralf@uni-koblenz.de" at Feb 12, 98 05:56:48 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Has anybody ever looked into implementing that?  What architectures besides
> MIPS could take advantage of such a feature?

On the intel its a huge win to map PCI frame buffers using 4Mbyte pages, but
the kernel mmap really can't hack the idea right now. A pity cos if you
hack it in and make sure you never unmap it you get 2-3% better X performance
