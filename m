Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id EAA470594; Sun, 17 Aug 1997 04:24:35 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA02742 for linux-list; Sun, 17 Aug 1997 04:24:00 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA02727 for <linux@cthulhu.engr.sgi.com>; Sun, 17 Aug 1997 04:23:56 -0700
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id EAA17894
	for <linux@cthulhu.engr.sgi.com>; Sun, 17 Aug 1997 04:23:38 -0700
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (centre.swanlink.ukuu.org.uk [137.44.10.205]) by snowcrash.cymru.net (8.8.5-q-beta3/8.7.1) with SMTP id MAA17995; Sun, 17 Aug 1997 12:20:48 +0100
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0x04WI-0005FiC; Sun, 17 Aug 97 13:33 BST
Message-Id: <m0x04WI-0005FiC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: boot linux - wish
To: ralf@mailhost.uni-koblenz.de (Ralf Baechle)
Date: Sun, 17 Aug 1997 13:33:22 +0100 (BST)
Cc: vincent@waw.com, miguel@nuclecu.unam.mx, linux@cthulhu.engr.sgi.com
In-Reply-To: <199708162207.AAA01148@informatik.uni-koblenz.de> from "Ralf Baechle" at Aug 17, 97 00:07:45 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> As far as the complexity of writing an XFS-like fs is concerned - SGI has
> invested a significant fraction of the R&D of XFS into the realtime stuff.
> So ignoring that part for the beginning makes the task of writing a XFS
> like filesystem much easier.

An XFS reader doesn't look too difficult, we can even take the btree
code from the Mac HFS driver. It should be possible to put the writing
algorithm back together by working back from the actual allocation patterns
for blocks the system makes
