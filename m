Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id EAA134697; Sat, 16 Aug 1997 04:00:59 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA18659 for linux-list; Sat, 16 Aug 1997 04:00:29 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA18654 for <linux@cthulhu.engr.sgi.com>; Sat, 16 Aug 1997 04:00:26 -0700
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id EAA16500
	for <linux@cthulhu.engr.sgi.com>; Sat, 16 Aug 1997 04:00:25 -0700
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (centre.swanlink.ukuu.org.uk [137.44.10.205]) by snowcrash.cymru.net (8.8.5-q-beta3/8.7.1) with SMTP id LAA02528; Sat, 16 Aug 1997 11:56:12 +0100
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0wzheO-0005FiC; Sat, 16 Aug 97 13:08 BST
Message-Id: <m0wzheO-0005FiC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: boot linux - wish
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Sat, 16 Aug 1997 13:08:12 +0100 (BST)
Cc: miguel@nuclecu.unam.mx, ariel@sgi.com, linux@cthulhu.engr.sgi.com
In-Reply-To: <199708160105.VAA26202@neon.ingenia.ca> from "Mike Shaver" at Aug 15, 97 09:05:34 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> If I stick all the RH stuff in an initrd and then they do FTP install,
> then they should be able to use it via boot /vmlinux or boot -f
> bootp()..., no?

2.1.4x blows up with an initrd - hopefully fixed in 2.1.50/soon but that
means the SGI one will corrupt and explode atm
