Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id SAA137586 for <linux-archive@neteng.engr.sgi.com>; Sun, 11 Jan 1998 18:52:22 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA07006 for linux-list; Sun, 11 Jan 1998 18:44:45 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA06997 for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jan 1998 18:44:32 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA06135
	for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jan 1998 18:44:28 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id VAA21651
	for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jan 1998 21:47:11 -0500
Date: Sun, 11 Jan 1998 21:47:11 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: BlueBelt Linux for SGI
Message-ID: <Pine.LNX.3.95.980111212314.26800H-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I'm just about finished all I can bear for one weekend. I've made one pass
over every single source RPM from RedHat 5.0 with the intention of
finishing off a decent distribution called BlueBelt 5.0 (IceStorm).

There's 452 binary RPMs that qualify as being suitable for SGI; eg. 
SVGALib doesn't make a lot of sense on an Indy.  Of those, I tried
compiling about 410. I have 285 binaries, 50 noarchs and about 75
failures. A lot of those failures are simply because of the order I built
everything in;  eg. I built gpm-devel late in the game, so things like mc
didn't compile. 

Within an hour, you'll be able to see the whole thing at
http://www.linux.sgi.com/bluebelt/. Uploading the packages is going to
take overnight, although there are a lot of them there already. They'll be
in ftp://ftp.linux.sgi.com/pub/RedHat/RPMS/ .

Please, if you would like to help me sort out the remaining packages,
please consult the list first.  It'll give some indication if that package
has been successfully converted already. Let me know, and I'll sign the
package as I have the others, and I'll update the WWW page accordingly.  I
put a lot of time into organizing all the packages on the WWW, please use
it as a guide to what needs to be done.

It'll be tempting to mail me and say "Alex, you dork, why didn't you just
install gpm-devel before you did all this?".  Well, now I know. Please
don't be too harsh.

- Alex "praying RH 5.1 won't come out anytime really soon" deVries

-- 
      Alex deVries          Run Linux on everything,
  System Administrator      run everything on Linux.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
