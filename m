Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA1971429 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Mar 1998 15:40:33 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id PAA4269027
	for linux-list;
	Thu, 26 Mar 1998 15:39:04 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA4251108
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 26 Mar 1998 15:39:02 -0800 (PST)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id PAA29140
	for <linux@cthulhu.engr.sgi.com>; Thu, 26 Mar 1998 15:38:59 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id XAA07642; Thu, 26 Mar 1998 23:38:29 GMT
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0yIMD7-000aNgC; Thu, 26 Mar 98 23:37 GMT
Message-Id: <m0yIMD7-000aNgC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: MIPS 2.1.89 now in CVS
To: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Date: Thu, 26 Mar 1998 23:37:25 +0000 (GMT)
Cc: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com, willmore@cig.mot.com
In-Reply-To: <19980327000426.03461@alpha.franken.de> from "Thomas Bogendoerfer" at Mar 27, 98 00:04:26 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> PC DMA controller it will be dead slow and a horror to implement (welcome
> to world of 64K segments). If the board has it's own DMA engine, you need
> documentation for it. And without DMA you will need a new driver.

Can anyone working on generic 53c9x support also talk to the Linux mac folks
who are also working on this right now. Incidentally we'll also be wanting
to abuse the mips sonic driver soon too 8)
