Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id NAA396265 for <linux-archive@neteng.engr.sgi.com>; Wed, 29 Oct 1997 13:05:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA18011 for linux-list; Wed, 29 Oct 1997 13:04:17 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA18003; Wed, 29 Oct 1997 13:04:15 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA00947; Wed, 29 Oct 1997 13:04:12 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-great-packet-bucket-in-the-sky [163.164.160.21] (may be forged)) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id VAA05345; Wed, 29 Oct 1997 21:04:03 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xQcdN-0005G0C; Wed, 29 Oct 97 18:14 GMT
Message-Id: <m0xQcdN-0005G0C@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Step by step of my experience
To: ariel@cthulhu.engr.sgi.com
Date: Wed, 29 Oct 1997 18:14:24 +0000 (GMT)
Cc: mgix@nothingreal.com, linux@cthulhu.engr.sgi.com
In-Reply-To: <199710230010.RAA272545@oz.engr.sgi.com> from "Ariel Faigon" at Oct 22, 97 05:10:33 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Actually, it is Mike Shaver, we talked about this one pretty
> recently, he is pretty busy but when he find some time to fix
> this it would make things much simpler.
> 

Also the EFS code panics if its given an FS that isnt EFS it should just
say "Nope". That confused me for a while

Anyway I've made a fair bit of progress by the time honoured technique of
gluing other peoples code together in a new shape

I now have working SGI ext2fs tools that checkout v Linux ok. Ted has
the patches.

I have a hacked up MacLinux installer which doesnt know tar/du/df/cp
this time but does know how to unpack cpio files (only I broke /dev files
and need to fix that)

With that installer and a bit of tweaking with mknod by hnd to fix
the cpio device file bug I've got Linux/SGI up and running and all the
base redhat bits on 

Im being bitten by a couple of kernel bugs tho

	1.	vmalloc keeps failing on the unix GC (annoying noise)
	2.	SIGCLD isnt getting given to init for some reason
		when scripts terminate (breaks redhat init scripting)
		[ note init isnt ignoring the signal... ]

Oh and does anyone happen to have a working ldconfig binary for 
Linux/SGI ?

Alan
