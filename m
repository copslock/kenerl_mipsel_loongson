Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA56316 for <linux-archive@neteng.engr.sgi.com>; Tue, 1 Dec 1998 12:32:14 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA24359
	for linux-list;
	Tue, 1 Dec 1998 12:31:08 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA80787
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 1 Dec 1998 12:31:03 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA02560
	for <linux@cthulhu.engr.sgi.com>; Tue, 1 Dec 1998 12:30:58 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (lightning.swansea.uk.linux.org [194.168.151.1]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id UAA12137; Tue, 1 Dec 1998 20:30:48 GMT
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0zkxLk-0007U3C; Tue, 1 Dec 98 21:28 GMT
Message-Id: <m0zkxLk-0007U3C@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: GNU/Hurd
To: torbjorn.gannholm@fra.se (Torbjörn Gannholm)
Date: Tue, 1 Dec 1998 21:28:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux@cthulhu.engr.sgi.com
In-Reply-To: <365E60FE.F12615EC@fra.se> from "Torbjörn Gannholm" at Nov 27, 98 09:21:19 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> But still, why wouldn't some implementation of HURD (or mach) be able to be
> preemptible?

I believe its been done for MACH so that MACH tasks are hard real time. FOr
hard real time on Linux Rtlinux sits under the kernel and runs as a very
compact realtime microkernel
