Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id MAA28105; Thu, 7 Aug 1997 12:42:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA10899 for linux-list; Thu, 7 Aug 1997 12:42:14 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA10888 for <linux@cthulhu.engr.sgi.com>; Thu, 7 Aug 1997 12:42:11 -0700
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA17997
	for <linux@cthulhu.engr.sgi.com>; Thu, 7 Aug 1997 12:42:06 -0700
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (centre.swanlink.ukuu.org.uk [137.44.10.205]) by snowcrash.cymru.net (8.8.5-q-beta3/8.7.1) with SMTP id UAA12600; Thu, 7 Aug 1997 20:36:36 +0100
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0wwZPV-0005FjC; Thu, 7 Aug 97 21:43 BST
Message-Id: <m0wwZPV-0005FjC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Challenge S
To: eak@detroit.sgi.com
Date: Thu, 7 Aug 1997 21:43:53 +0100 (BST)
Cc: chadm@sgi.com, linux@cthulhu.engr.sgi.com
In-Reply-To: <33E9D5B0.18B77AE6@cygnus.detroit.sgi.com> from "Eric Kimminau" at Aug 7, 97 10:03:28 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I think it would be a great application but Linux is sorely missing a
> very important piece - lockd for NFS.

Two things

1.	Linux 2.1.x does have a lock daemon
2.	Most people and tools avoid NFS locking like the plague because
	its faster to use polls based on the atomic NFS properties you
	do have and some short sleeps. 

Oh yes and 3. - NFS locking really doesn't seem to have much in the 
security area..

Alan
