Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA03174; Tue, 24 Jun 1997 09:51:42 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA07046 for linux-list; Tue, 24 Jun 1997 09:51:04 -0700
Received: from piecomputer.engr.sgi.com (piecomputer.engr.sgi.com [150.166.75.28]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA07034; Tue, 24 Jun 1997 09:51:02 -0700
Received: (from mende@localhost) by piecomputer.engr.sgi.com (970321.SGI.8.8.5/970502.SGI.AUTOCF) id JAA01365; Tue, 24 Jun 1997 09:48:06 -0700 (PDT)
Date: Tue, 24 Jun 1997 09:48:06 -0700 (PDT)
Message-Id: <199706241648.JAA01365@piecomputer.engr.sgi.com>
From: Bob Mende Pie <mende@piecomputer.engr.sgi.com>
To: adevries@engsoc.carleton.ca
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <Pine.LNX.3.95.970624123035.406E-100000@lager.engsoc.carleton.ca>
	(message from Alex deVries on Tue, 24 Jun 1997 12:38:39 -0400 (EDT))
Subject: Re: Some simple hardware questions...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 1. Do Indy's come equipped with floppy drives?  What are they?  Is it
> possible to boot from them?

There is an option on indy's that allow for a SCSI iomega floptical (21MB)
drive.  These drives are treated as a removable SCSI disk.  You should be
able to boot from them but I have never tried.
 
> 2. I know O2's have PCI busses with a custom controller.  Do Indy's have
> this too? What is the name of this controller? It would seem reasonably
> easy to slap a PCI VGA card in there and port XFree86 to run on it.

The indy does not have PCI.   They use a gio bus.
 
> 3. Do Indy's ship with CDROMs?

As an option there is an external CDROM.   I believe that (nowadays) you
have to really try to get a system without a cdrom.
 
 
                              /Bob...                    mailto:mende@sgi.com
                        http://reality.sgi.com/mende/          KF6EID
