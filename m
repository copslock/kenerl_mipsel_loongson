Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA10685 for <linux-archive@neteng.engr.sgi.com>; Wed, 23 Dec 1998 12:26:47 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA38570
	for linux-list;
	Wed, 23 Dec 1998 12:26:06 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA49132
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 23 Dec 1998 12:26:04 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA06096
	for <linux@cthulhu.engr.sgi.com>; Wed, 23 Dec 1998 12:26:02 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (lightning.swansea.uk.linux.org [194.168.151.1]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id UAA19708; Wed, 23 Dec 1998 20:25:12 GMT
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0zsvjc-0007U1C; Wed, 23 Dec 98 21:22 GMT
Message-Id: <m0zsvjc-0007U1C@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Are we going to port RH 5.2?
To: adelton@informatics.muni.cz (Honza Pazdziora)
Date: Wed, 23 Dec 1998 21:22:23 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <19981223201347.A10620@aisa.fi.muni.cz> from "Honza Pazdziora" at Dec 23, 98 08:13:47 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I just thought: are we going to port RH 5.2 to SGI? If I understood

I've done some of it.

> holidays and do the compilation if it has some sense. I probably
> won't be able to fix serious bugs or develop the installer, but I
> should be able to recompile the rpms.

Most of the stuff I've done so far is straight forward rebuilding. Ive
been producing packages as I get time to kick the indy off and test them
