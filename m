Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id RAA548840 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Sep 1997 17:36:54 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA05453 for linux-list; Fri, 26 Sep 1997 17:36:37 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA05449; Fri, 26 Sep 1997 17:36:35 -0700
Received: from dns.cobaltmicro.com ([209.19.61.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA04775; Fri, 26 Sep 1997 17:36:25 -0700
	env-from (ralf@dns.cobaltmicro.com)
Received: (from ralf@localhost)
	by dns.cobaltmicro.com (8.8.5/8.8.5) id RAA02682;
	Fri, 26 Sep 1997 17:36:25 -0700
From: Ralf Baechle <ralf@cobaltmicro.com>
Message-Id: <199709270036.RAA02682@dns.cobaltmicro.com>
Subject: Re: R3000 SGI machines
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Fri, 26 Sep 1997 17:36:25 -0700 (PDT)
Cc: imp@village.org, ralf@cobaltmicro.com, linux@cthulhu.engr.sgi.com,
        ab@ivm.net
In-Reply-To: <199709261558.IAA10949@fir.engr.sgi.com> from "William J. Earl" at Sep 26, 97 08:58:19 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Warner Losh writes:
>  > In message <199709260639.XAA09959@dull.cobaltmicro.com> Ralf Baechle writes:
>  > : I receive an increasing number of emails asking for Linux as replacement
>  > : operating system for older R3000 SGI machines as well as Mips Inc.
>  > : machines.  Is there still documentation available for these systems
>  > : that would make a port possible?
>  > 
>  > I'll have to search my email archive (which would take some doing),
>  > but someone at SGI offered to get me the sources to RISCos, or at
>  > least the device drivers.  They were donated to berkeley, who didn't
>  > integrate them into their 4.4 or 4.4lite release, was the story I was
>  > told.  Might be worth looking into.  Wouldn't help with some of the
>  > older SGI machines, but would help with the MIPS co boxes.
> 
>      The RISCos driver source was supplied with every system, and we
> did donate the source to Berkeley.  Most of the VME controllers were
> common to MIPS and SGI VME systems, so most of the drivers, other than
> graphics, would be covered.

I think I can still get access to RISC/os 5.x system, maybe also old
RISC/os 4.51 tapes.  What files should I try to look for?

Andy, I think you still have Resi in use, don't you?  Any driver sources
included?

  Ralf
