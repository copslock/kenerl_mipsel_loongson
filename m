Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA43356 for <linux-archive@neteng.engr.sgi.com>; Sun, 24 Jan 1999 20:06:48 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA55207
	for linux-list;
	Sun, 24 Jan 1999 20:06:12 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from anchor.engr.sgi.com (anchor.engr.sgi.com [150.166.49.42])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA55139;
	Sun, 24 Jan 1999 20:06:10 -0800 (PST)
	mail_from (olson@anchor.engr.sgi.com)
Received: (from olson@localhost) by anchor.engr.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id UAA07213; Sun, 24 Jan 1999 20:06:09 -0800 (PST)
From: olson@anchor.engr.sgi.com (Dave Olson)
Message-Id: <199901250406.UAA07213@anchor.engr.sgi.com>
Subject: Re: HAL2 support.
In-Reply-To: <Pine.LNX.3.96.990124153515.17852A-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jan 24, 99 04:01:19 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Sun, 24 Jan 1999 20:06:09 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com
Organization: Silicon Graphics, Inc.  Mt. View, CA
X-Mailer: ELM [version 2.4ME+ PL35 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries wrote: 
|  Also, am I right in saying that there's no devices written for HPC3 that
|  use the pbus?  Looks like the first step to writing a HAL driver is to be
|  able to write to the pbus.

The pbus interface itself is a pretty simple interface.

|  What else is actually on the pbus on the Indy?  From this HPC
|  documentation, looks
|  like:
|  - fdc (I thought Indy floppies were SCSI though)

There was talk of doing floppy this way, but it never was actually done.

|  - rtc
|  - prom
|  - scsi (although not the 33c93)

scsi is off the hpc3, but it's only the control path (pio to registers)
that uses the pbus interface.  The datapath is a different bus.

|  - int2 (what's this?)

interrupt control.

|  - hal2
|  - pi1 (what's this?)

parallel port.

Dave Olson, Silicon Graphics
http://reality.sgi.com/olson   olson@sgi.com
