Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA150470 for <linux-archive@neteng.engr.sgi.com>; Thu, 22 Jan 1998 16:50:36 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA16903 for linux-list; Thu, 22 Jan 1998 16:47:24 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA16891; Thu, 22 Jan 1998 16:47:21 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id QAA25110; Thu, 22 Jan 1998 16:47:16 -0800
Date: Thu, 22 Jan 1998 16:47:16 -0800
Message-Id: <199801230047.QAA25110@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux@cthulhu.engr.sgi.com
Subject: Re: wd33c93 errors.
In-Reply-To: <Pine.LNX.3.95.980122175054.21753I-100000@lager.engsoc.carleton.ca>
References: <m0xvVCP-0005FsC@lightning.swansea.linux.org.uk>
	<Pine.LNX.3.95.980122175054.21753I-100000@lager.engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries writes:
...
 > My conclusion is that my 700MB disk and recordable CDROM are crap, and the
 > Linux driver for the wd33c93 can't handle these kinds of problems
 > correctly.
 > 
 > And lastly: having a cute blue case seemed pretty good at first, but it'd
 > be heavenly to have room for more than two hard disks inside.
 > 
 > Tomorrow I'll borrow a functional SCSI disk and try again.
...

      Beware of cable lengths on the Indy builtin SCSI port.  You are limited
to 3 meters total, and good quality cables are helpful.  Sometimes a low-quality
configuration will work, but often it will not.  The Indy GIO SCSI expansion
card is less picky.
