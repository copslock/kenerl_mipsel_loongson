Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA55610 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Nov 1998 13:42:56 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA99821
	for linux-list;
	Wed, 25 Nov 1998 13:42:08 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA93706;
	Wed, 25 Nov 1998 13:41:14 -0800 (PST)
	mail_from (pjlahaie@elenuial.atlsci.com)
Received: from elenuial.atlsci.com (elenuial.atlsci.com [209.151.14.9]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA03429; Wed, 25 Nov 1998 13:41:11 -0800 (PST)
	mail_from (pjlahaie@elenuial.atlsci.com)
Received: (from pjlahaie@localhost)
	by elenuial.atlsci.com (8.8.7/8.8.7) id QAA03620;
	Wed, 25 Nov 1998 16:38:44 -0500
Date: Wed, 25 Nov 1998 16:38:44 -0500 (EST)
From: <pjlahaie@atlsci.com>
To: Greg Chesson <greg@xtp.engr.sgi.com>
cc: Ariel Faigon <ariel@cthulhu.engr.sgi.com>,
        Olivier Galibert <galibert@pobox.com>, linux@cthulhu.engr.sgi.com
Subject: Re: help offered
In-Reply-To: <9811251324.ZM24100@xtp.engr.sgi.com>
Message-ID: <Pine.LNX.4.04.9811251631410.3207-100000@elenuial.atlsci.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, 25 Nov 1998, Greg Chesson wrote:

> But the memory subsystem is ccNUMA.  That means any channel in the system
> can read/write any memory in the system.  With io buffers that comprise
> multiple pages, and with the pages of the buffer located on several different
> memory controllers, multiple io channels can burst (in parallel) to the
> "array" of pages that comprise the buffer.

    Except some of this has to go through the CrayLink.  The memory you
are "bursting" to is not on the same node.  Therefore, if you have a
dual-threaded application that runs over the data, at most the max
bandwidth is 1.6GB/s (seeing as it's advantagous to spread your code to
two nodes and split the memory between them).  If you application can make
use of all processors on that box, then you get the full bandwidth.  The
most any single processor in that Origin can handle is 800MB/s and if it
needs to get that data, eventually that data is shoveled through the
CrayLink (and hopefully is gets migrated there).  Is there anything flawed
with this reasoning?

> file system buffer cache.  These are direct-io transfers between the channel
> and user-supplied buffers.  It's not clear the Linux permits dma to a mapped
> user page.... I get different opinions from folks.  Nevertheless, large pages

    I don't see why it cannot be done.  The page-cache/file system buffer
cache are supposed to be merged.  If you mmap that data, you should just
get a pte pointing to that area in the page cache.

> So, a 16-processor Origin can operate a 2 GB/s file system and use only
> 40-50% of its internal bandwidth.  Obviously, many many configurations
> of processors, channels, disks and network devices are possible.

    But that bandwidth isn't single node bandwidth.  No single node can do
4GB/s.  All nodes need to use their local memory to achieve max bandwidth.

						- Paul
