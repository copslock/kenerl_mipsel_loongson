Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id UAA123544 for <linux-archive@neteng.engr.sgi.com>; Tue, 7 Oct 1997 20:08:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA03025 for linux-list; Tue, 7 Oct 1997 20:08:20 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA03021 for <linux@cthulhu.engr.sgi.com>; Tue, 7 Oct 1997 20:08:17 -0700
Received: from emout05.mail.aol.com (emout05.mx.aol.com [198.81.11.96]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA25828
	for <linux@cthulhu.engr.sgi.com>; Tue, 7 Oct 1997 20:08:16 -0700
	env-from (LetherGlov@aol.com)
From: LetherGlov@aol.com
Received: (from root@localhost)
	  by emout05.mail.aol.com (8.7.6/8.7.3/AOL-2.0.0)
	  id XAA14058 for linux@cthulhu.engr.sgi.com;
	  Tue, 7 Oct 1997 23:08:14 -0400 (EDT)
Date: Tue, 7 Oct 1997 23:08:14 -0400 (EDT)
Message-ID: <971007230709_979759870@emout05.mail.aol.com>
To: linux@cthulhu.engr.sgi.com
Subject: Wrong Dallas Timekeeper
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Well,
        On the advice of a certain unnamed person I opened my Indy. I found
among other things a BIG heatsink and one Dallas model _1386_ timekeeper.
David Miller on the other has in arch/mips/sgi/kernel/indy_timer.c that it's
a Dallas 1286. The difference between the 1286 and the 1386 is the
NVRAM(8k)+(150ns access time) and that magical thing called automatic power
on and off. I would suggest that anyone who wants to know more about the 1386
get the PDF from:

www.dalsemi.com/DocControl/PDFs/1386.pdf

Have Fun,
Robbie
