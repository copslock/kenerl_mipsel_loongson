Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id FAA532830 for <linux-archive@neteng.engr.sgi.com>; Fri, 28 Nov 1997 05:40:42 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA07319 for linux-list; Fri, 28 Nov 1997 05:35:56 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA07314 for <linux@cthulhu.engr.sgi.com>; Fri, 28 Nov 1997 05:35:54 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id FAA18234
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Nov 1997 05:35:53 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-great-packet-bucket-in-the-sky [163.164.160.21] (may be forged)) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id NAA14743; Fri, 28 Nov 1997 13:35:24 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xbQZf-0005FsC; Fri, 28 Nov 97 13:35 GMT
Message-Id: <m0xbQZf-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Bintuils
To: ralf@uni-koblenz.de
Date: Fri, 28 Nov 1997 13:35:14 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <19971128004706.49234@uni-koblenz.de> from "ralf@uni-koblenz.de" at Nov 28, 97 00:47:06 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf:
	Has anyone attempted to build the binutils fixed RPM with the old
buggy binutils. Im trying this right now and Im getting

1.	build the srpm
	all the tools die with segv on load

2.	build the srpm static
	tools seem to work

3.	link the stuff again with the static srpm but dynamic
	dies

All the binaries crash at the same reference (000000d0 from a fixed address
so I guess its a dynamic linker error).

Im now off to rebuild it from scratch with the static new linker to see what
occurs

Alan
