Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA2583152 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Apr 1998 15:18:45 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id PAA7022809
	for linux-list;
	Thu, 2 Apr 1998 15:16:17 -0800 (PST)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id PAA6667378;
	Thu, 2 Apr 1998 15:16:14 -0800 (PST)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA01989; Thu, 2 Apr 1998 15:16:13 -0800
Date: Thu, 2 Apr 1998 15:16:13 -0800
Message-Id: <199804022316.PAA01989@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: Dong Liu <dliu@npiww.com>, linux@cthulhu.engr.sgi.com
Subject: Re: serial console
In-Reply-To: <19980402233532.10932@uni-koblenz.de>
References: <199804021731.TAA00404@calypso.saturn>
	<199804021855.NAA08562@pluto.npiww.com>
	<19980402204738.29605@uni-koblenz.de>
	<199804022006.PAA10227@pluto.npiww.com>
	<19980402233532.10932@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > On Thu, Apr 02, 1998 at 03:06:21PM -0500, Dong Liu wrote:
 > 
 > > Ok, I got a serial cable , connect it, type "nvram console d", now I
 > > can boot irix from a serial terminal, but for linux, the message
 > > didn't come out, maybe all the serial parameters are not set right.
 > 
 > Linux doesn't accept the value ``dd'' for the console variable.  If you
 > try, Linux should complain about the setting and enter the interactive
 > firmware mode again.  Could you try setting console to either d1 or d2
 > according to the serial line you're using?

     For reduced user confusion, accepting "console=d" as an alias
for "console=d1" might reduce user confusion.
