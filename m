Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA04067; Tue, 24 Jun 1997 10:04:21 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA11140 for linux-list; Tue, 24 Jun 1997 10:03:34 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA11087; Tue, 24 Jun 1997 10:03:26 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id KAA24742; Tue, 24 Jun 1997 10:03:24 -0700
Date: Tue, 24 Jun 1997 10:03:24 -0700
Message-Id: <199706241703.KAA24742@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Some simple hardware questions...
In-Reply-To: <Pine.LNX.3.95.970624123035.406E-100000@lager.engsoc.carleton.ca>
References: <199706201842.UAA31057@kernel.panic.julia.de>
	<Pine.LNX.3.95.970624123035.406E-100000@lager.engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries writes:
 > 
 > I have some ultra simple hardware questions that I couldn't find answers
 > to.  Excuse the noviceness of it all, I haven't touched SGI hardware in
 > quite some time.
 > 
 > 1. Do Indy's come equipped with floppy drives?  What are they?  Is it
 > possible to boot from them?

     An Indy does not come with a floppy drive standard, but it does support
both a floppy and a floptical drive.  Both are SCSI drives, and you should 
be able to boot from them, since the boot software does not distinguish
among drive types.

 > 2. I know O2's have PCI busses with a custom controller.  Do Indy's have
 > this too? What is the name of this controller? It would seem reasonably
 > easy to slap a PCI VGA card in there and port XFree86 to run on it.

     No, the Indy has the SGI-specific GIO bus.

 > 3. Do Indy's ship with CDROMs?

     An Indy does not come with a CDROM by default, but most SCSI CDROM
drives should work.  (There is a supported SGI CDROM drive.)
