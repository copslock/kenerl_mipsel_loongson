Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA57212 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Nov 1998 14:09:32 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA26967
	for linux-list;
	Wed, 25 Nov 1998 14:08:40 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.61.141])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id OAA20674;
	Wed, 25 Nov 1998 14:08:37 -0800 (PST)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id OAA23040; Wed, 25 Nov 1998 14:08:27 -0800
Date: Wed, 25 Nov 1998 14:08:27 -0800
Message-Id: <199811252208.OAA23040@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: <pjlahaie@atlsci.com>
Cc: Greg Chesson <greg@xtp.engr.sgi.com>,
        Ariel Faigon <ariel@cthulhu.engr.sgi.com>,
        Olivier Galibert <galibert@pobox.com>, linux@cthulhu.engr.sgi.com
Subject: Re: help offered
In-Reply-To: <Pine.LNX.4.04.9811251631410.3207-100000@elenuial.atlsci.com>
References: <9811251324.ZM24100@xtp.engr.sgi.com>
	<Pine.LNX.4.04.9811251631410.3207-100000@elenuial.atlsci.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

pjlahaie@atlsci.com writes:
 > On Wed, 25 Nov 1998, Greg Chesson wrote:
 > 
 > > But the memory subsystem is ccNUMA.  That means any channel in the system
 > > can read/write any memory in the system.  With io buffers that comprise
 > > multiple pages, and with the pages of the buffer located on several different
 > > memory controllers, multiple io channels can burst (in parallel) to the
 > > "array" of pages that comprise the buffer.
 > 
 >     Except some of this has to go through the CrayLink.  The memory you
 > are "bursting" to is not on the same node.  Therefore, if you have a
 > dual-threaded application that runs over the data, at most the max
 > bandwidth is 1.6GB/s (seeing as it's advantagous to spread your code to
 > two nodes and split the memory between them).  If you application can make
 > use of all processors on that box, then you get the full bandwidth.  The
 > most any single processor in that Origin can handle is 800MB/s and if it
 > needs to get that data, eventually that data is shoveled through the
 > CrayLink (and hopefully is gets migrated there).  Is there anything flawed
 > with this reasoning?

      There is not a single CrayLink.  Each router port is a CrayLink.
There are many CrayLinks if you have many nodes, so the aggregate bandwidth
scales.  If you want to do some real processing on all of the data, you
will need more processors that would be required to simply read it into
some processor cache anyway, so the node bandwidth is unlikely to be the
limiting factor.  When you add processors, you get more aggregate bandwidth.

...
 > > So, a 16-processor Origin can operate a 2 GB/s file system and use only
 > > 40-50% of its internal bandwidth.  Obviously, many many configurations
 > > of processors, channels, disks and network devices are possible.
 > 
 >     But that bandwidth isn't single node bandwidth.  No single node can do
 > 4GB/s.  All nodes need to use their local memory to achieve max bandwidth.

       Yes.  The point of the operating system is to spread the load of
processing, I/O, and networking over the complete system, not create
bottlenecks at a particular node card. 
