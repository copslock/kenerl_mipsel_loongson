Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA56417; Fri, 15 Aug 1997 11:29:01 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA00544 for linux-list; Fri, 15 Aug 1997 11:28:28 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA00523; Fri, 15 Aug 1997 11:28:25 -0700
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA08079; Fri, 15 Aug 1997 11:28:18 -0700
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (centre.swanlink.ukuu.org.uk [137.44.10.205]) by snowcrash.cymru.net (8.8.5-q-beta3/8.7.1) with SMTP id TAA21322; Fri, 15 Aug 1997 19:23:26 +0100
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0wzS9I-0005FjC; Fri, 15 Aug 97 20:35 BST
Message-Id: <m0wzS9I-0005FjC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Local disk boot HOWTO
To: ralf@mailhost.uni-koblenz.de (Ralf Baechle)
Date: Fri, 15 Aug 1997 20:35:04 +0100 (BST)
Cc: greg@xtp.engr.sgi.com, eak@detroit.sgi.com, shaver@neon.ingenia.ca,
        ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-Reply-To: <199708151717.TAA19277@informatik.uni-koblenz.de> from "Ralf Baechle" at Aug 15, 97 07:17:56 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> My suggestion is to attack the ext2fs disk to a Linux/i386 machine,
> build the root filesystem etc. on it, then back on the Indy use it
> for booting.  Linux is so smart that it handles the MSDOG partitions
> on the disk created that way correctly and I store my kernel on the
> IRIX / anyway.

Another approach is to create a linux fs the right size for your root
on another ext2fs supporting host (ie linux,os/2, win95,macos ;))
and gzip the actual file system, then people can bootstrap it quite
easily under irix by just gunzipping to the _right_ ;) raw device

Alan
