Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA548519 for <linux-archive@neteng.engr.sgi.com>; Thu, 29 Jan 1998 16:24:58 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA06210 for linux-list; Thu, 29 Jan 1998 16:20:42 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA06078; Thu, 29 Jan 1998 16:20:30 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id QAA02574; Thu, 29 Jan 1998 16:20:12 -0800
Date: Thu, 29 Jan 1998 16:20:12 -0800
Message-Id: <199801300020.QAA02574@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: strange problem with my oli M700
In-Reply-To: <19980129221750.18001@uni-koblenz.de>
References: <19980129212705.29618@alpha.franken.de>
	<19980129221750.18001@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > On Thu, Jan 29, 1998 at 09:27:05PM +0100, Thomas Bogendoerfer wrote:
 > 
 > > I'm trying to read the firmware prom of my Olivetti M700 (Magnum 4000 clone).
 > > When access the address 0x9fc00000 (which is the KSEG0 address of the prom)
 > > the box freezes immidiately. Does anybody know why ? And how could I access
 > > the prom otherwise ?
 > 
 > Did you try uncached accesses via KSEG1?  I wouldn't wonder if the used
 > PROMs can't cope with the bursts generated for filling a cacheline.

     I am pretty certain that is the case for the Magnum.  That is, you
must use 0xbfc00000, not 0x9fc00000.
