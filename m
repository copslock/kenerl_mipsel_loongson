Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA06752; Tue, 8 Apr 1997 17:01:44 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA24404 for linux-list; Tue, 8 Apr 1997 17:01:03 -0700
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA24390 for <linux@cthulhu.engr.sgi.com>; Tue, 8 Apr 1997 17:01:01 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id RAA02282; Tue, 8 Apr 1997 17:00:51 -0700
Received: (from wje@localhost) by fir.esd.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id RAA14784; Tue, 8 Apr 1997 17:00:43 -0700
Date: Tue, 8 Apr 1997 17:00:43 -0700
Message-Id: <199704090000.RAA14784@fir.esd.sgi.com>
From: "William J. Earl" <wje@fir.esd.sgi.com>
To: "Alistair Lambie" <alambie@wellington.sgi.com>
Cc: Mike Shaver <shaver@neon.ingenia.ca>, linux@cthulhu.engr.sgi.com,
        kneedham@ottawa.sgi.com
Subject: Re: It booooooooooots!
In-Reply-To: <9704091148.ZM9065@windy.wellington.sgi.com>
References: <199704082223.SAA03675@neon.ingenia.ca>
	<shaver@neon.ingenia.ca>
	<9704091148.ZM9065@windy.wellington.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alistair Lambie writes:
 > On Apr 9, 10:27am, Mike Shaver wrote:
 > > Subject: It booooooooooots!
 > > Sending BOOTP and RARP requests............
 > >
 > > Doesn't seem to want to find the server again for the NFS root thing,
 > > but that's probably a config problem.
 > >
 > 
 > I used to have that...you probably haven't got a rarp server set up, so it
 > can't find its address.  One of the things David was going to add was that
 > ability to read it out of NVRAM...but that wasn't high on the priority list!
 >  For now, the only way is to have a rarp server.  The other way is to have the
 > root file system on hard disk....but to do that you need to boot linux and copy
 > it across.
 > Kind of the chicken and the egg situation!

     Can you pass the information to the kernel via the command line arguments
or the environment variables?  (argc, argv, and environ are passed in $a0, $a1,
and $a2 by the PROM or sash to the kernel on entry, just as they are passed
to a main program in a regular process; you can look for the "netaddr" environment
variable to find your IP address:

	netaddr=192.111.24.24

Set netaddr at the prom this way:

	setenv -p netaddr 192.111.24.24
