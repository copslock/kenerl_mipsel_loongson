Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id JAA456264 for <linux-archive@neteng.engr.sgi.com>; Sun, 18 Jan 1998 09:46:04 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA17273 for linux-list; Sun, 18 Jan 1998 09:44:05 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA17248; Sun, 18 Jan 1998 09:44:00 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA00511; Sun, 18 Jan 1998 09:43:58 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id RAA13315; Sun, 18 Jan 1998 17:43:38 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xtzBj-0005FsC; Sun, 18 Jan 98 18:11 GMT
Message-Id: <m0xtzBj-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: My NEC VR4000's
To: drachen@netexpress.net (David Hinkle)
Date: Sun, 18 Jan 1998 18:11:15 +0000 (GMT)
Cc: kbob@jogger-egg.engr.sgi.com, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <34C23ACA.83E2E39C@netexpress.net> from "David Hinkle" at Jan 18, 98 11:24:27 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> password....  Bye the way... Is there an easier way to clear the root
> password?    And does anybody know what filesystem IRIX uses?

If its running Irix < 6.4 then read bugtraq archives for about 100,000 ways
to break root on your machine  8)

The best general scheme on a remote box is to stuff the disk into a machine
and without mounting it replace any disk block starting root:........:dfgkd
with your own password string. 
