Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id LAA02303 for <linux-archive@neteng.engr.sgi.com>; Mon, 1 Dec 1997 11:19:31 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA11559 for linux-list; Mon, 1 Dec 1997 11:19:00 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA11517 for <linux@cthulhu.engr.sgi.com>; Mon, 1 Dec 1997 11:18:54 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA09234
	for <linux@cthulhu.engr.sgi.com>; Mon, 1 Dec 1997 11:18:51 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-great-packet-bucket-in-the-sky [163.164.160.21] (may be forged)) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id TAA07480; Mon, 1 Dec 1997 19:17:55 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xcbNU-0005FsC; Mon, 1 Dec 97 19:19 GMT
Message-Id: <m0xcbNU-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Seeq Ethernet
To: ralf@uni-koblenz.de
Date: Mon, 1 Dec 1997 19:19:32 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <19971201190923.06958@uni-koblenz.de> from "ralf@uni-koblenz.de" at Dec 1, 97 07:09:23 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> _the_ current problem for Linux/Indy is the Ethernet driver.  Time to fix
> it.  Can anybody point me to docs for that chip?  I only have one half of
> the required docs, the HPC docs.

Talk to Russel King. He has a solid working SEQ800x driver from the ARM port that
knows most of the SEEQ chip bugs. You may want to merge drivers as well

	http://www.arm.uk.linux.org
