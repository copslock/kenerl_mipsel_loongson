Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id IAA364624 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Sep 1997 08:58:31 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA06492 for linux-list; Fri, 26 Sep 1997 08:58:21 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA06485; Fri, 26 Sep 1997 08:58:19 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id IAA10949; Fri, 26 Sep 1997 08:58:19 -0700
Date: Fri, 26 Sep 1997 08:58:19 -0700
Message-Id: <199709261558.IAA10949@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Warner Losh <imp@village.org>
Cc: Ralf Baechle <ralf@cobaltmicro.com>, linux@cthulhu.engr.sgi.com
Subject: Re: R3000 SGI machines 
In-Reply-To: <199709261510.JAA22806@harmony.village.org>
References: <199709260639.XAA09959@dull.cobaltmicro.com>
	<199709261510.JAA22806@harmony.village.org>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Warner Losh writes:
 > In message <199709260639.XAA09959@dull.cobaltmicro.com> Ralf Baechle writes:
 > : I receive an increasing number of emails asking for Linux as replacement
 > : operating system for older R3000 SGI machines as well as Mips Inc.
 > : machines.  Is there still documentation available for these systems
 > : that would make a port possible?
 > 
 > I'll have to search my email archive (which would take some doing),
 > but someone at SGI offered to get me the sources to RISCos, or at
 > least the device drivers.  They were donated to berkeley, who didn't
 > integrate them into their 4.4 or 4.4lite release, was the story I was
 > told.  Might be worth looking into.  Wouldn't help with some of the
 > older SGI machines, but would help with the MIPS co boxes.

     The RISCos driver source was supplied with every system, and we
did donate the source to Berkeley.  Most of the VME controllers were
common to MIPS and SGI VME systems, so most of the drivers, other than
graphics, would be covered.
