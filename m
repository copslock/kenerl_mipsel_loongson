Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA17508; Tue, 8 Apr 1997 15:03:06 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA10529 for linux-list; Tue, 8 Apr 1997 15:00:52 -0700
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA10443 for <linux@cthulhu.engr.sgi.com>; Tue, 8 Apr 1997 15:00:45 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id PAA18336; Tue, 8 Apr 1997 15:00:37 -0700
Received: (from wje@localhost) by fir.esd.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA14464; Tue, 8 Apr 1997 15:00:12 -0700
Date: Tue, 8 Apr 1997 15:00:12 -0700
Message-Id: <199704082200.PAA14464@fir.esd.sgi.com>
From: "William J. Earl" <wje@fir.esd.sgi.com>
To: Mike Shaver <shaver@neon.ingenia.ca>
Cc: linux@cthulhu.engr.sgi.com, davem@caip.rutgers.edu (David S. Miller)
Subject: Re: serial consoles, sash and other wonders
In-Reply-To: <199704082131.RAA03090@neon.ingenia.ca>
References: <199704081948.MAA14047@fir.esd.sgi.com>
	<199704082131.RAA03090@neon.ingenia.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike Shaver writes:
 > Thus spake William J. Earl:
...
 > >     If you don't have the installation CD's, I recommend that you back
 > > up the disk, perhaps to a second disk (complete with volume header and
 > > root partitions), so you can recover from any potential failure.  The
 > > "cp" command in the prom can be used to copy disk to disk to recover.
 > 
 > That I will do.
 > Will that work with differently-sized drives?

     Yes, but the drive to which you copy the data will have to be bigger,
but it will then not appear to be any larger than the original drive.
That is, the partition table in the volume header will claim that the
second drive is really the same size as the original drive.  This is of
course ok if you only want the extra drive as a backup.

...
 > I'm having some trouble with the serial console, though.
 > I did an `nvram console d' and that took, but I fear that I've got to
 > set something else, since my serial cable is connected to port 2.  The
 > getty I'm running on ttyd2 works fine, FWIW.

      Yes, you really need two serial lines, one for the console (port 1,
ttyd1) and one for the debug port (port 2, ttyd2).  At least, that is the
way I control my test system from my host system.  Here, we usually use
an Annex Ethernet-based serial concentrator for serial ports, and connect
via telnet (or the Annex rtelnetd) to the serial ports, which are then
wired to the test machines.  

 > When I reboot, I get nothing on the serial console until the getty
 > login: prompt.
 >
 > (I can't think off the top of my head as to why I'm using that port,
 > but I think it had something to do with the available cabling.  I'm
 > not physically with the machine until 1400 EST tomorrow, but Josh
 > should feel free to step forward and explain it. =) )

       The PROM talks only to port 1, so you are seeing what I would
expect.
