Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id CAA83601 for <linux-archive@neteng.engr.sgi.com>; Thu, 22 Jan 1998 02:03:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA02236 for linux-list; Thu, 22 Jan 1998 01:59:59 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA02225 for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 01:59:56 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id BAA13082
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 01:59:55 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id JAA30518; Thu, 22 Jan 1998 09:59:32 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xvJsq-0005FsC; Thu, 22 Jan 98 10:29 GMT
Message-Id: <m0xvJsq-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: root-be-0.03.tar.gz
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Thu, 22 Jan 1998 10:29:15 +0000 (GMT)
Cc: shaver@netscape.com, linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.980122005800.20627E-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Jan 22, 98 01:04:19 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Here's a question:  is it possible to boot off of the local disk without
> the image being on an EFS partition? Will I ever be able to have my
> machine have no EFS partition? How will ARC find the image?

Using the Linux initrd stuff. To get the ARC loader to load it all you
end up doing

char __initdata initrd_block[]={
#include "bootdisk.hex.h"
};

8)
