Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA04815; Wed, 18 Jun 1997 13:03:42 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA25014 for linux-list; Wed, 18 Jun 1997 13:02:56 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA24853 for <linux@relay.engr.SGI.COM>; Wed, 18 Jun 1997 13:02:10 -0700
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.155.100]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA03330
	for <linux@relay.engr.SGI.COM>; Wed, 18 Jun 1997 13:02:08 -0700
	env-from (davem@caipfs.rutgers.edu)
Received: from jenolan.caipgeneral (jenolan.rutgers.edu [128.6.111.5])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with SMTP id PAA10206;
	Wed, 18 Jun 1997 15:58:17 -0400 (EDT)
Received: by jenolan.caipgeneral (SMI-8.6/SMI-SVR4)
	id PAA06751; Wed, 18 Jun 1997 15:56:11 -0400
Date: Wed, 18 Jun 1997 15:56:11 -0400
Message-Id: <199706181956.PAA06751@jenolan.caipgeneral>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: chen@betty.esd.sgi.com
CC: chen@darwin.esd.sgi.com, jc@darwin.esd.sgi.com, kck@darwin.esd.sgi.com,
        linux@cthulhu.engr.sgi.com
In-reply-to: <9706181241.ZM5754@betty.esd.sgi.com> (chen@betty.esd.sgi.com)
Subject: Re: Getting X on Linux/SGI
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: "John Chen" <chen@betty.esd.sgi.com>
   Date: Wed, 18 Jun 1997 12:41:23 -0700

   I think you also need following stuff for Indy system with Newport graphic:

   1) Newport graphics spec.

I have this.

   2) A basic graphic driver that map RE chip to Xsgi's address
      space, so X can program RE registers

15 minutes of coding...

   3) This graphic driver also needs to set up graphic backend display
      id table and display mode registers (if X support only one visual,
      this step is simple), to program Cmap for cursor color
      and to program cursor registers for glyph and location.
      All of these work can also be done in X if driver map backend to X.

I can do this since I have #1, in fact I might be setting up the
backend display for one visual already in the text console driver I
wrote.  The way to manipulate the cursor and cmap is pretty much
documented in my text console driver as well, but I think some of the
actual cursor code is just pound define'd out but it is/was there.
(worse case you have to sift through the CVS history for the driver
and check out a version right before I snipped the code out if I in
fact did remove it at some point)

As for the input queue stuff, this has already been implemented on the
Sparc port because we were using SunOS Xsun binaries long ago, the
stock X11R6 sources use this mechanism anyways in the Sun frame buffer
support code, and their interface is very similar to IRIX's I think
(they call it VUID events).
