Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA95237 for <linux-archive@neteng.engr.sgi.com>; Tue, 26 Jan 1999 10:33:35 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA10439
	for linux-list;
	Tue, 26 Jan 1999 10:32:40 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from anchor.engr.sgi.com (anchor.engr.sgi.com [150.166.49.42])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA08638;
	Tue, 26 Jan 1999 10:32:38 -0800 (PST)
	mail_from (olson@anchor.engr.sgi.com)
Received: (from olson@localhost) by anchor.engr.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id KAA17419; Tue, 26 Jan 1999 10:32:38 -0800 (PST)
From: olson@anchor.engr.sgi.com (Dave Olson)
Message-Id: <199901261832.KAA17419@anchor.engr.sgi.com>
Subject: Re: Parallel port support.
In-Reply-To: <Pine.LNX.3.96.990126121421.12068L-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jan 26, 99 12:16:18 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Tue, 26 Jan 1999 10:32:38 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com
Organization: Silicon Graphics, Inc.  Mt. View, CA
X-Mailer: ELM [version 2.4ME+ PL35 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries wrote: 
|  So the only things that actually hang off the pbus in the indy are:
|  - some of the SCSI control registers for the wd33c93

Yes, the "control" interface to the wd93.

|  - HAL2

Yep.

And as earlier discussed:
	RTC, prom, interrupt controller, serial ports.

Now, I do have an old spec that describes the parallel port
as a seperate chip, but I am nearly certain we folded it into
hpc3.  I may have to retract that though.  None of the specs
I have in my office are the final versions, and I don't have
an indigo2 lying around to look at the final chip layout.  If
you find a chip marked PI1, then I am remembering wrong, and we
did the parallel port as a seperate chip.

|  Where does ISDN fit in?

I don't remember, and I don't have the Indy specs handy, and I can't
find the online docs right now.  I think it went on the pbus, but
that's a vague memory.

|  What other machines have the HPC3, and what kind of devices do they have
|  on them?

Only the Indigo2 series (r4k, r8k, r10k) and Indy.


Dave Olson, Silicon Graphics
http://reality.sgi.com/olson   olson@sgi.com
