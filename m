Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA56090 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Nov 1998 13:27:53 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA93243
	for linux-list;
	Wed, 25 Nov 1998 13:26:38 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from xtp.engr.sgi.com (xtp.engr.sgi.com [150.166.75.34])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id NAA16710;
	Wed, 25 Nov 1998 13:26:35 -0800 (PST)
	mail_from (greg@xtp.engr.sgi.com)
Received: by xtp.engr.sgi.com (950413.SGI.8.6.12/911001.SGI)
	 id NAA24102; Wed, 25 Nov 1998 13:24:04 -0800
From: "Greg Chesson" <greg@xtp.engr.sgi.com>
Message-Id: <9811251324.ZM24100@xtp.engr.sgi.com>
Date: Wed, 25 Nov 1998 13:24:03 -0800
In-Reply-To: <pjlahaie@atlsci.com>
        "Re: help offered" (Nov 25,  3:51pm)
References: <Pine.LNX.4.04.9811251542540.3207-100000@elenuial.atlsci.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: <pjlahaie@atlsci.com>, Ariel Faigon <ariel@cthulhu.engr.sgi.com>
Subject: Re: help offered
Cc: Olivier Galibert <galibert@pobox.com>, linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

max rate on an io channel is 800 MB/s..  The sustainable rates range
from 580 to 720 depending which channel you're looking at in the machine.

But the memory subsystem is ccNUMA.  That means any channel in the system
can read/write any memory in the system.  With io buffers that comprise
multiple pages, and with the pages of the buffer located on several different
memory controllers, multiple io channels can burst (in parallel) to the
"array" of pages that comprise the buffer.

A system in my lab has 24 Fibre Channels.
We build an XFS file system that operates all 24 channels on a read or write.
There's a RAID controller on each FC with an 8+1 LUN.
The file system is arranged so that each controller has a 4MB IO,
each disk gets a 512KB IO, and the IO size of the native file allocation
block is 24*4MB == 96 MB.  It takes about 50ms for a one disk transfer.
During that time all 24 FC burst into memory.  The dma rate is around 90 MB/s.
So, that is 2160 MB/s.  The aggregate memory bandwidth for an 16-cpu Origin
is about 4000 MB/s (sustained).  The actual memory bandwidth is about
20% more, but I derate it when doing this kind of exercise.

In order to avoid page management overhead, we rely on the ability
to specify large (16MB) pages for buffers of this kind.  The OS is quite
happy to manage large pages as well as the default-sized ones (16KB).
Without this capability, the page management overhead would be a major
stumbling block.  Also, striped IO of this kind does not go through the
file system buffer cache.  These are direct-io transfers between the channel
and user-supplied buffers.  It's not clear the Linux permits dma to a mapped
user page.... I get different opinions from folks.  Nevertheless, large pages
and direct IO are necessary tools for operating big io.

The channel bandwidth is 2160 MB/s during an IO as noted above.
However, the channels can't transfer continuously in this configuration
because the disks have to seek occasionally.  So, the amount that you
derate the peak bandwidth to get to sustained file system bandwidth
depends on the block size, number of seeks, average seek distance,
the number of IO requests in the hardware/controller pipeline, plus
some fuzz to account for faster transfer rates on the outside cylinders
compared to inside cylinders plus the number of direction changes
(mix of reads and writes) plus some analysis of extra drive rotations
on writes and the effectiveness of disk and controller track caches.
Whew.  Anyway the 24-channel RAID-3 system will sustain about 1520 MB/s
under arbitrary read/write and seek patterns.  "Good" patterns will trend
toward 2000 MB/s, but it won't fall below 1500.

So, a 16-processor Origin can operate a 2 GB/s file system and use only
40-50% of its internal bandwidth.  Obviously, many many configurations
of processors, channels, disks and network devices are possible.

When configuring a bandwidth-oriented file server, we shoot for
1/3 bandwidth for the disks, 1/3 for the network, and the rest for software.
These are just rules of thumb, but indicate the kind of thought process
that should be applied.

Sorry for the long message, but I detected some basic misunderstandings
of what this hardware and software can do.

g

-- 
Greg Chesson
