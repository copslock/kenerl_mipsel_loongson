Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA10051; Tue, 23 Apr 1996 10:06:24 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id KAA14640; Tue, 23 Apr 1996 10:06:19 -0700
Received: from yon.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id KAA14628; Tue, 23 Apr 1996 10:06:17 -0700
Received: from patton.engr.sgi.com by yon.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	for <linux@yon.engr.sgi.com> id KAA29620; Tue, 23 Apr 1996 10:06:13 -0700
Received: by patton.engr.sgi.com (950413.SGI.8.6.12/911001.SGI)
	 id KAA21770; Tue, 23 Apr 1996 10:06:11 -0700
From: "Jim Barton" <jmb@patton.engr.sgi.com>
Message-Id: <9604231006.ZM21768@patton.engr.sgi.com>
Date: Tue, 23 Apr 1996 10:06:11 -0700
In-Reply-To: Ariel Faigon: message of Apr 22, 19:16
References: <199604230216.TAA28613@yon.engr.sgi.com>
X-Mailer: Z-Mail-SGI (3.2S.2 10apr95 MediaMail)
To: ariel@cthulhu.engr.sgi.com, linux@yon.engr.sgi.com
Subject: Re: David Miller is on the list
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

The purpose for basing the port on R3000 is *not* to support obsolete
workstations and servers; our time and effort need to be directed to the
future, not the past. If the guys in OZ want to port it, fine.

Basing on an R3000 is important because of it's exploding use as an
embedded processor; it's showing up in your laser printers, phone
switches, robots, airplanes, satellite receivers, and so on. One thing
Larry and I are interested in is seeing if Linux is really suitable
as an embedded OS to support these (and more) applications.

What you typically find is an r3k core surrounded by various application-
specific peripherals, e.g, MPEG decoders, sound chips, DMA controllers,
serial controllers. The OS is usually in ROM, and the device manufacturer
adds special drivers to the mix. Real-time constraints come into play;
in particular, it would be interesting to consider what additions to Linux
make it work well for real-time applications. Posix 1003.4 is pretty
heavy-weight, but perhaps we can have a light-weight implementation.

In the workstation/server world, the R4000 is the processor to aim at.
It is significantly different than the r3k in TLB layout, but little
else in 32-bit mode, so the same code should basically work both places.
I believe different binaries should be built for the r4k and r3k - certain
pieces of MIPS II ISA can accelerate performance, and the compilers take
advantage of that.

Given that the workstation/server world is moving to 64 bit, I believe we
need a 64-bit version of Linux as well. The design of the MIPS III ISA
is actually pretty clean for keeping the same source between 32-bit and
64-bit kernels, as long as you are careful about your types.

The r4k is also interesting because it is at the heart of the Nintendo
Ultra-64 game, and the R4300i processor it uses is starting to show up
in various Japanese computer products. The volumes of this device are
projected in the 10s of millions of units, so it is significant. Linux
in your Ultra-64 box? Hmmmm. Might actually be interesting ...

So, we need to be able to build three versions from the same source.
I think the R10K can be ignored for now, and it *only* runs in 64-bit
kernel mode. 64-bit user mode can also be ignored for now - there are
few applications for 64-bit programs except in the high-end scientific
markets. The R8K is obsolete.

-- jmb
