Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA33368 for <linux-archive@neteng.engr.sgi.com>; Tue, 22 Dec 1998 21:45:36 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA88416
	for linux-list;
	Tue, 22 Dec 1998 21:44:46 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from anchor.engr.sgi.com (anchor.engr.sgi.com [150.166.49.42])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA92858;
	Tue, 22 Dec 1998 21:44:44 -0800 (PST)
	mail_from (olson@anchor.engr.sgi.com)
Received: (from olson@localhost) by anchor.engr.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id VAA08158; Tue, 22 Dec 1998 21:44:43 -0800 (PST)
From: olson@anchor.engr.sgi.com (Dave Olson)
Message-Id: <199812230544.VAA08158@anchor.engr.sgi.com>
Subject: Re: Status
In-Reply-To: <Pine.LNX.3.96.981222224859.1946C-100000@lager.engsoc.carleton.ca> from Alex deVries at "Dec 22, 98 10:50:33 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Tue, 22 Dec 1998 21:44:43 -0800 (PST)
Cc: greg@xtp.engr.sgi.com, ariel@cthulhu.engr.sgi.com, fredrov@hotmail.com,
        linux@cthulhu.engr.sgi.com
Organization: Silicon Graphics, Inc.  Mt. View, CA
X-Mailer: ELM [version 2.4ME+ PL35 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries wrote: 
|  On Mon, 21 Dec 1998, Greg Chesson wrote:
|  > I2 means Indigo2.
|  > Extreme means he has a high-end graphics board.
|  > The I2 is like the Indy, but has two built-in SCSI channels rather
|  > than one.  It tends to not have all the multi-media stuff on the motherboard
|  > that you find on the Indy.  I have an I2 because - unlike the Indy -
|  > I can put two XL graphics cards in it and run a two-head display.
|  > The I2 also allows for an Extreme card and an XL (but not 2 Extreme's).
|  > Also, can have more memory than an Indy.
|  
|  The Indigo2 sounds a lot like a Challenge S; is the internal architecture
|  similiar to the Indy/Challenge S as well?

Yes.  Indigo2 came first, then Indy was done as a derivitive of it.
Indy left out EISA, and changed to an integrated chip for the serial
ports and a couple of other things, as a cost reduction measure.
Indy also has only one scsi controller, while indigo2 has two.
Challenge S was then done as a derivitive of Indy, with the graphics
board replaced by a board with the wd95 scsi controllers, and two GIO
slots (only one of which could do DMA).
