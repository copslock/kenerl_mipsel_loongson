Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA1968324 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Mar 1998 16:10:17 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id QAA4288357
	for linux-list;
	Thu, 26 Mar 1998 16:09:26 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA4276712
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 26 Mar 1998 16:09:24 -0800 (PST)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id QAA10452
	for <linux@cthulhu.engr.sgi.com>; Thu, 26 Mar 1998 16:09:23 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id AAA08163; Fri, 27 Mar 1998 00:09:10 GMT
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0yIMgk-000aNgC; Fri, 27 Mar 98 00:08 GMT
Message-Id: <m0yIMgk-000aNgC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: MIPS 2.1.89 now in CVS
To: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Date: Fri, 27 Mar 1998 00:08:00 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com,
        willmore@cig.mot.com
In-Reply-To: <19980327004757.19715@alpha.franken.de> from "Thomas Bogendoerfer" at Mar 27, 98 00:47:57 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> the 53c9x mips support is a "port" of the sparc esp driver, which I did
> based on work from the m68k people (fastlane, blizzard, etc.). And I also
> verified that the changed esp still runs on a Sparc (at least on my SS2).

Thats the same path the Mac people are taking

> So I should put fixing it higher on my todo list:-) ? It still has problems
> with real network traffic. I know the reason, but didn't have time to fix
> it, yet.

Not instantly but the later macs use the sonic (the nubus plugin cards are
all NE2000's in disguise)
