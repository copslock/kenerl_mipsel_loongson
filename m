Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id KAA248276 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 10:55:56 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA25017 for linux-list; Thu, 4 Dec 1997 10:54:26 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA24992; Thu, 4 Dec 1997 10:54:22 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA03075; Thu, 4 Dec 1997 10:52:57 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id SAA29672; Thu, 4 Dec 1997 18:52:53 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xdgRS-0005FsC; Thu, 4 Dec 97 18:56 GMT
Message-Id: <m0xdgRS-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: A question about architecture and byte order with RPMs
To: greg@xtp.engr.sgi.com (Greg Chesson)
Date: Thu, 4 Dec 1997 18:56:05 +0000 (GMT)
Cc: adevries@engsoc.carleton.ca, ralf@uni-koblenz.de,
        linux@cthulhu.engr.sgi.com, rpm-list@redhat.com
In-Reply-To: <9712040917.ZM8768@xtp.engr.sgi.com> from "Greg Chesson" at Dec 4, 97 09:17:39 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> be added to type declarations.  The modifier would indicate whether the
> data object is stored in big-endian or little-endian format.
> The compiler would generate byte swizzles or not, depending on whether
> the native execution mode agrees with the indicated storage class.
> 
> Perhaps the GCC world, being somewhat more enlightened, could do something
> in this area (or perhaps already is thinking about it?).

Yeuch ;). Can't you get your guys to put that in the MMU so you can have
a little endian or big endian page ? I can see how you'd make lcc generate
such output but not offhand gcc
