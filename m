Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id IAA365600 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Sep 1997 08:50:57 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA05491 for linux-list; Fri, 26 Sep 1997 08:50:37 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA05487; Fri, 26 Sep 1997 08:50:35 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id IAA10923; Fri, 26 Sep 1997 08:50:34 -0700
Date: Fri, 26 Sep 1997 08:50:34 -0700
Message-Id: <199709261550.IAA10923@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@cobaltmicro.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: R3000 SGI machines
In-Reply-To: <199709260639.XAA09959@dull.cobaltmicro.com>
References: <199709260639.XAA09959@dull.cobaltmicro.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
 > Hi all,
 > 
 > I receive an increasing number of emails asking for Linux as replacement
 > operating system for older R3000 SGI machines as well as Mips Inc.
 > machines.  Is there still documentation available for these systems
 > that would make a port possible?

     There is some, which I could track down, on the same basis as the
Indy documentation.  I don't know how complete the files are, however.
There is a family resemblance in much of Indigo system, especially the I/O.
The Personal IRIS and Power Series machines, which were VME-based, are
fairly different (except for graphics), but are relatively similar to the 
MIPS VME systems, such as the M1000 and M2000.  The Power Series are
MP systems, and have some special purpose interprocessor synchronization
hardware.  The documentation for the VME systems will be harder to 
locate.
