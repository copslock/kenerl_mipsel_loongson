Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA64845 for <linux-archive@neteng.engr.sgi.com>; Tue, 26 Jan 1999 09:09:27 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA74809
	for linux-list;
	Tue, 26 Jan 1999 09:09:12 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from anchor.engr.sgi.com (anchor.engr.sgi.com [150.166.49.42])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA62859;
	Tue, 26 Jan 1999 09:09:10 -0800 (PST)
	mail_from (olson@anchor.engr.sgi.com)
Received: (from olson@localhost) by anchor.engr.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id JAA16711; Tue, 26 Jan 1999 09:09:10 -0800 (PST)
From: olson@anchor.engr.sgi.com (Dave Olson)
Message-Id: <199901261709.JAA16711@anchor.engr.sgi.com>
Subject: Re: Parallel port support.
In-Reply-To: <Pine.LNX.3.96.990126120139.12068J-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jan 26, 99 12:03:08 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Tue, 26 Jan 1999 09:09:10 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com
Organization: Silicon Graphics, Inc.  Mt. View, CA
X-Mailer: ELM [version 2.4ME+ PL35 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries wrote: 
|  
|  I've never seen any documentation of the parallel port that hangs off of
|  the pbus; does anyone know:
|  - what kind of chip it is

Just another part of the hpc3 asic.

|  - how it hangs off of the pbus?

It doesn't.  That's just the address space where the control registers are.

Dave Olson, Silicon Graphics
http://reality.sgi.com/olson   olson@sgi.com
