Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA67248 for <linux-archive@neteng.engr.sgi.com>; Tue, 26 Jan 1999 09:15:27 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA25262
	for linux-list;
	Tue, 26 Jan 1999 09:14:55 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA45856;
	Tue, 26 Jan 1999 09:14:52 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA01633; Tue, 26 Jan 1999 09:14:50 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id MAA24450;
	Tue, 26 Jan 1999 12:16:19 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Tue, 26 Jan 1999 12:16:18 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Dave Olson <olson@anchor.engr.sgi.com>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Parallel port support.
In-Reply-To: <199901261709.JAA16711@anchor.engr.sgi.com>
Message-ID: <Pine.LNX.3.96.990126121421.12068L-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Tue, 26 Jan 1999, Dave Olson wrote:
> Alex deVries wrote: 
> |  I've never seen any documentation of the parallel port that hangs off of
> |  the pbus; does anyone know:
> |  - what kind of chip it is
> Just another part of the hpc3 asic.

Oh, it's *included* in the HPC3?  I'd missed that in the docs.

> |  - how it hangs off of the pbus?
> It doesn't.  That's just the address space where the control registers are.

Ah, I see.

So the only things that actually hang off the pbus in the indy are:
- some of the SCSI control registers for the wd33c93
- HAL2

Where does ISDN fit in?

What other machines have the HPC3, and what kind of devices do they have
on them?

- Alex
