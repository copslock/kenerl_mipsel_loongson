Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id PAA536855 for <linux-archive@neteng.engr.sgi.com>; Fri, 24 Oct 1997 15:19:43 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA25292 for linux-list; Fri, 24 Oct 1997 15:18:26 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA25276 for <linux@cthulhu.engr.sgi.com>; Fri, 24 Oct 1997 15:18:24 -0700
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA03978
	for <linux@cthulhu.engr.sgi.com>; Fri, 24 Oct 1997 15:18:15 -0700
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (guru-transit1-336.swansea.cymru.net [163.164.160.20]) by snowcrash.cymru.net (8.8.5-q-beta3/8.7.1) with SMTP id XAA08524 for <linux@cthulhu.engr.sgi.com>; Fri, 24 Oct 1997 23:16:53 +0100
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xOrfv-0005G0C; Fri, 24 Oct 97 22:53 BST
Message-Id: <m0xOrfv-0005G0C@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Look what I found in a big cardboard box
To: linux@cthulhu.engr.sgi.com
Date: Fri, 24 Oct 1997 22:53:47 +0100 (BST)
In-Reply-To: <60222E63C9F4D011915F00A02435011C011A5F@bart.hgeng.com> from "Mike Hill" at Oct 24, 97 01:07:43 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

And there was light (actually there was heavy..)

My SGI arrived today. Anyway after the required prelimiaries (Batallion,
making stupid indycam movies) I had a hack at the ext2fs utils and libs -
fixed them to compile and run properly under the Indy native cc. I can
successfully make and then fsck an ext2 partition.

What Im going to do next is chase the work from the Mac68K installer and
see if I can use that with the ext2fs lib to get the same arrangement working
(that is an application level toolset for installing tars and the like) from
Irix. 

To that goal I'm going to be working on the tool stuff until I've successfully
bootstrapped Linux that way.

Alan
