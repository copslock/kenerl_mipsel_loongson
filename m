Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id RAA1150698 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Dec 1997 17:06:16 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA06435 for linux-list; Thu, 11 Dec 1997 17:05:25 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA06360 for <linux@cthulhu.engr.sgi.com>; Thu, 11 Dec 1997 17:05:15 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA22691
	for <linux@cthulhu.engr.sgi.com>; Thu, 11 Dec 1997 17:05:11 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id BAA03765; Fri, 12 Dec 1997 01:04:40 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xgJdw-0005FsC; Fri, 12 Dec 97 01:11 GMT
Message-Id: <m0xgJdw-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Mount ext2 filesystem.
To: hakamada@meteor.nsg.sgi.com (Takeshi Hakamada)
Date: Fri, 12 Dec 1997 01:11:51 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux@cthulhu.engr.sgi.com
In-Reply-To: <199712120030.JAA05477@meteor.nsg.sgi.com> from "Takeshi Hakamada" at Dec 12, 97 09:30:15 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Thank you. I've converted rpm to cpio and I could have installed rpm binary.
> But, I can't boot from local disk yet. If I can boot from local disk, I'd
> like to update faq on the www.linux.sgi.com. How do you think about it?

In irix, shutdown, restart hit the maintenance button to get to the arc
menu, hit command line and do I think its

boot /whatever/efs/vmlinux root=/dev/sdb1

(first partition disk 2 as root)
