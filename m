Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA141414 for <linux-archive@neteng.engr.sgi.com>; Thu, 22 Jan 1998 16:15:18 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA06072 for linux-list; Thu, 22 Jan 1998 16:12:27 -0800
Received: from hollywood.engr.sgi.com (hollywood.engr.sgi.com [150.166.61.38]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA06065 for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 16:12:26 -0800
Received: (from fisher@localhost) by hollywood.engr.sgi.com (940816.SGI.8.6.9/960327.SGI.AUTOCF) id QAA28870; Thu, 22 Jan 1998 16:12:23 -0800
From: fisher@hollywood.engr.sgi.com (William Fisher)
Message-Id: <199801230012.QAA28870@hollywood.engr.sgi.com>
Subject: Re: wd33c93 errors.
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Thu, 22 Jan 1998 16:12:18 -0800 (PST)
Cc: alan@lxorguk.ukuu.org.uk, linux@hollywood.engr.sgi.com,
        fisher@hollywood.engr.sgi.com (William Fisher)
In-Reply-To: <Pine.LNX.3.95.980122175054.21753I-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Jan 22, 98 06:07:27 pm
Reply-To: fisher@sgi.com
X-Mailer: ELM [version 2.4 PL3]
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> 
> On Thu, 22 Jan 1998, Alan Cox wrote:
> > > repartitioned it from Irix, and mounted it as an EFS partition under Irix
> > > just fine.  That would seem to indicate that everything is alright with
> > Including rewriting it ?
> 
> Ah, I tried that specifically, and had problems too with Irix.  So, the
> disk is toast, and it'll go back to the storage room I found it in (along
> with an AXP).
> 
> > > scsi0: Aborting connected command 17577 - stopping DMA - sending wd33c93
> > > ABORT command - flushing fifo - asr = 25, sr=ff, 16777215 bytes
> > > un-transferred (timeout=-1) - sending wd33c93 DISCONNECT command = asr=00,
> > > sr=18.
> > > And the whole thing is hung, hard.
> > Thats a bug. 
> 
> I've got a WO recordable CDROM also. I can change directories on it just
> fine, but when reading a lot of data on it, it'll give me:
> 
> scsi : aborting command due to timeout : pid 2282, scsi0, channel 0, id 2,
> lun 0 Write (6) 00 0a 99 02 00
> scsi0: Abort - removing command 2282 from input_Q.
> 
> And then a total hang again.. no numlock, no pinging.
> 
> I can't test the recordable CDROM under Irix because it doesn't have a
> WORM driver built in.
> 
	I have been talking with Creative Digital Research, creators of
	the HyCD product used in SGI's Hot Mix CD's. Seems that support
	for recordable CD media has encountered problems BOTH under
	Irix and Solaris. In older products, the PC SCSI devices
	did NOT support disconnect. So the various third party vendors
	ifdef'ed out the disconnect code in our wd SCSI driver and rebuild
	the kernels to get around this "feature".

	I am getting the details but it seems that something is amiss
	with the "standard" PC SCSI devices in this area. There is also
	some fuzzy-ness going on in the device type they are advertizing
	themselves to be. I will have the gory details shortly since we
	would like to understand the problem. We have had a couple of
	customers complain about this problem.

-- Bill
>
> Now, another thing... I have a _functional_ (under both Irix and Linux
> ) CDROM that doesn't get detected under Linux when I have all of this
> other crap on the SCSI bus. It is perfectly usable if it's on the external
> bus by itself, but not with other devices on the bus.
> 
> My conclusion is that my 700MB disk and recordable CDROM are crap, and the
> Linux driver for the wd33c93 can't handle these kinds of problems
> correctly.
> 
> And lastly: having a cute blue case seemed pretty good at first, but it'd
> be heavenly to have room for more than two hard disks inside.
> 
> Tomorrow I'll borrow a functional SCSI disk and try again.
> 
> - Alex "and as if SCSI hell weren't bad enough, I have to get my wisdom
> teeth out" deVries
> 
> 
