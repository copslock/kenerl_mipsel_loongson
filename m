Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA91041 for <linux-archive@neteng.engr.sgi.com>; Thu, 10 Dec 1998 08:44:28 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA18512
	for linux-list;
	Thu, 10 Dec 1998 08:44:19 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from anchor.engr.sgi.com (anchor.engr.sgi.com [150.166.49.42])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA76896;
	Thu, 10 Dec 1998 08:44:17 -0800 (PST)
	mail_from (olson@anchor.engr.sgi.com)
Received: (from olson@localhost) by anchor.engr.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id IAA85119; Thu, 10 Dec 1998 08:44:08 -0800 (PST)
From: olson@anchor.engr.sgi.com (Dave Olson)
Message-Id: <199812101644.IAA85119@anchor.engr.sgi.com>
Subject: Re: Linux on an SGI Challenge L
In-Reply-To: <Pine.LNX.3.96.981210112344.26579J-100000@lager.engsoc.carleton.ca> from Alex deVries at "Dec 10, 98 11:24:10 am"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Thu, 10 Dec 1998 08:44:08 -0800 (PST)
Cc: ralf@uni-koblenz.de, andrewb@uab.edu, linux-smp@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com
Organization: Silicon Graphics, Inc.  Mt. View, CA
X-Mailer: ELM [version 2.4ME+ PL35 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries wrote: 
|  
|  What's in a Challenge L exactly, in terms of devices and busses?

same cpu bus, but used differently
hidden gio bus within some cards (not quite the same as indy)
vme
wd95 scsi, not wd93
different ethernet
different serial
different memory/io interface chip, with layered and "interesting"
	buses(plural) to various kinds of i/o
interrupts (of course) are quite different, with some interesting
issues in the implementation.

There may still be some old white papers on www.sgi.com


Dave Olson, Silicon Graphics
http://reality.sgi.com/olson   olson@sgi.com
