Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id GAA691928 for <linux-archive@neteng.engr.sgi.com>; Sun, 30 Nov 1997 06:58:19 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA17749 for linux-list; Sun, 30 Nov 1997 06:51:39 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA17740 for <linux@cthulhu.engr.sgi.com>; Sun, 30 Nov 1997 06:51:26 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id GAA06352
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Nov 1997 06:51:25 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-great-packet-bucket-in-the-sky [163.164.160.21] (may be forged)) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id OAA04060; Sun, 30 Nov 1997 14:50:59 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xcAil-0005FsC; Sun, 30 Nov 97 14:51 GMT
Message-Id: <m0xcAil-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: A report from the battle field...
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Sun, 30 Nov 1997 14:51:43 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.971129193017.26978E-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Nov 29, 97 07:44:47 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 1. When I try to FTP a lot of files to it, it complains about "eth0: ".  I
> guess it's just going too quick.  The file then becomes corrupt.  The

Yep. Part of that however might be the ftp binary - ncftp I get
the eth0: errors but dont seem to get file corruption.

> 2. Execution errors on various programs:
> - bash: 
> do_page_fault() #2: sending SIGSEGV to bash for illegal readaccess
> from 000000d0 (epc ==0fb676c0, ra == 0fb676a0)
> - pico (part of pine):
> do_page_fault() #2: sending SIGSEGV to pico for illegal readaccess from
> from 000000d0 (epc ==0fb676c0, ra == 0fb676a0)

Link these static possibly. The bash stuff is working fine on my box however
the RPM maybe the one with readline in not the one I used. oops

> - mingetty: 
> unix_gc: deferred due to low memory

Miguel's kernel has this fixed (its a vmalloc thing)

> - when I try and do a control-alt-delete, it says that it's flushing the
> cache, and that's it.

I get a reboot about 1 in 3 times
