Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id PAA138241 for <linux-archive@neteng.engr.sgi.com>; Thu, 22 Jan 1998 15:10:52 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA15877 for linux-list; Thu, 22 Jan 1998 15:07:43 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA15865 for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 15:07:41 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA21360
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 15:07:30 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id SAA11813;
	Thu, 22 Jan 1998 18:07:27 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 22 Jan 1998 18:07:27 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: wd33c93 errors.
In-Reply-To: <m0xvVCP-0005FsC@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.95.980122175054.21753I-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 22 Jan 1998, Alan Cox wrote:
> > repartitioned it from Irix, and mounted it as an EFS partition under Irix
> > just fine.  That would seem to indicate that everything is alright with
> Including rewriting it ?

Ah, I tried that specifically, and had problems too with Irix.  So, the
disk is toast, and it'll go back to the storage room I found it in (along
with an AXP).

> > scsi0: Aborting connected command 17577 - stopping DMA - sending wd33c93
> > ABORT command - flushing fifo - asr = 25, sr=ff, 16777215 bytes
> > un-transferred (timeout=-1) - sending wd33c93 DISCONNECT command = asr=00,
> > sr=18.
> > And the whole thing is hung, hard.
> Thats a bug. 

I've got a WO recordable CDROM also. I can change directories on it just
fine, but when reading a lot of data on it, it'll give me:

scsi : aborting command due to timeout : pid 2282, scsi0, channel 0, id 2,
lun 0 Write (6) 00 0a 99 02 00
scsi0: Abort - removing command 2282 from input_Q.

And then a total hang again.. no numlock, no pinging.

I can't test the recordable CDROM under Irix because it doesn't have a
WORM driver built in.

Now, another thing... I have a _functional_ (under both Irix and Linux
) CDROM that doesn't get detected under Linux when I have all of this
other crap on the SCSI bus. It is perfectly usable if it's on the external
bus by itself, but not with other devices on the bus.

My conclusion is that my 700MB disk and recordable CDROM are crap, and the
Linux driver for the wd33c93 can't handle these kinds of problems
correctly.

And lastly: having a cute blue case seemed pretty good at first, but it'd
be heavenly to have room for more than two hard disks inside.

Tomorrow I'll borrow a functional SCSI disk and try again.

- Alex "and as if SCSI hell weren't bad enough, I have to get my wisdom
teeth out" deVries
