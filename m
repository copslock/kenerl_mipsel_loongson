Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id TAA417287; Wed, 23 Jul 1997 19:05:43 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA13190 for linux-list; Wed, 23 Jul 1997 19:04:05 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA13170 for <linux@cthulhu.engr.sgi.com>; Wed, 23 Jul 1997 19:04:01 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA26831
	for <linux@cthulhu.engr.sgi.com>; Wed, 23 Jul 1997 19:04:00 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id WAA00423 for <linux@cthulhu.engr.sgi.com>; Wed, 23 Jul 1997 22:03:44 -0400
Date: Wed, 23 Jul 1997 22:03:44 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: linux@cthulhu.engr.sgi.com
Subject: Yay!  It boots!  It boots!
In-Reply-To: <199707230249.EAA22451@informatik.uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.970723213813.14151B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Good news from the east coast of the US!

To begin with, I was happy to see two very large boxes getting dropped off
at my cubicle around 2pm this afternoon from SGI.  Had I not been in the
middle of fighting a million other fires this afternoon (multiple
billings, crashed hard disks, etc) I would have opened it sooner.

I know that Ariel has gone through a lot to get the volunteers hardware,
and it says a lot about his hard work and determination that I have an
Indy on my desk right now. SGI Linux would be very difficult to get
running without the input of him and SGI. This _is_ going to work well. 

A few beers are owed to David Kascht for setting up my system properly,
and for getting the machine out the door in Mountainview.  His efforts are
greatly appreciated.

But, at 7:30pm I started unpacking, and by 8:15 I had Irix functional. 
Setting up bootp, tftpd, nfs, etc was easy (note to self:  remember to
restart inetd, remember to restart inetd...), and the whole thing booted
as of about 9:15. The cleaners are still looking at me funny from my loud
cheers.

I'm using Mike's vmlinux version 2.1.43 (11MB!), and the
root-be-0.0.cpio.gz (thanks, Ralf!) root file system.

I'm now sorting out why I can't write to the fs, I think it's because I
had forgotten to modify it's /etc/mtab or such.  No problem, I expect.

So, all I need is fdisk, and we're really rocking...

I've been documenting more specifically, and I will be creating the HOWTO
installation parts tomorrow night.

The plan for my machine (Red) is to host it here at work (as
alex3.med.iacnet.com) behind a firewall until SGI Linux is a bit further
ahead, or until I get an ISDN line (which I will for certain, once I
move).  Red is an Indy with 2 1GB drives, 64MB and ISDN. 

Again, huge thanks to SGI.  I promise to contribute in order to make it
worth their while.

- Alex
