Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id OAA148752 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Dec 1997 14:48:22 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA02274 for linux-list; Wed, 3 Dec 1997 14:47:26 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA02266; Wed, 3 Dec 1997 14:47:25 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA27317; Wed, 3 Dec 1997 14:46:00 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id WAA05108; Wed, 3 Dec 1997 22:45:56 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xdNb1-0005FsC; Wed, 3 Dec 97 22:48 GMT
Message-Id: <m0xdNb1-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Linux on the O2
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Wed, 3 Dec 1997 22:48:43 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199712032231.OAA24793@fir.engr.sgi.com> from "William J. Earl" at Dec 3, 97 02:31:33 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> One interesting area for development, both in the embedded space, and on
> the SGI workstations, would be in regard to realtime support, which is
> needed for digital media.  By realtime, I mean not fast interrupt response,
> but rather precisely scheduled repetitive events (such as driving the Indy
> audio ports every 1 ms. with at most 0.9 ms delay no matter what else is
> going on).  

This exists although not for the MIPS platform and not directly accessible
from user space. NMT have a RTLinux kernel that allows real time drivers
to hit targets well well under 0.1ms. 
