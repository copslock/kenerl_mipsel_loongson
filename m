Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id SAA520830; Mon, 18 Aug 1997 18:38:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA16546 for linux-list; Mon, 18 Aug 1997 18:37:40 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA16530 for <linux@cthulhu.engr.sgi.com>; Mon, 18 Aug 1997 18:37:37 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA13012
	for <linux@cthulhu.engr.sgi.com>; Mon, 18 Aug 1997 18:37:36 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id VAA19778 for <linux@cthulhu.engr.sgi.com>; Mon, 18 Aug 1997 21:37:06 -0400
Date: Mon, 18 Aug 1997 21:37:06 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: linux@cthulhu.engr.sgi.com
Subject: Current problems.
In-Reply-To: <199708152146.QAA30833@athena.nuclecu.unam.mx>
Message-ID: <Pine.LNX.3.95.970818211731.16649D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I'm using the kernel that was precompiled, and mentioned on the list
earlier.

Things I notice about the kernel:
- it crashes occasionally on bootup, saying 'spinning' at the end
- on CAD, it just says "Disabling R4600 SCACHE", and does nothing
- when I'm doing a lot of NFS IO, it says the NFS server has timedout.  I
really doubt it, considering the available speed of my NFS server.

Disk problems I'm having:
- occasionally, my mounts will just disappear.  One moment I'll have /proc
mounted, the next it'll be gone.  It's very difficult to copy filesystems
like this.
- /proc/mounts claims that my NFS-root mounted / is rw, but I always get
permission errors when trying to write to it.
- I'm apparantly not intelligent enough to use fx to partition my sdb
correctly.  I put it in expert mode, but I simply cannot delete partition
10, the volume.  What should the partition table look like from fx's view
point?  In Linux, I get:
 sdb:Dev 08:10 SGI disklabel: bad magic 000000000
 unknown partition table

Ideas?

Thank god for the hidden reset button.

- Alex

      Alex deVries              Success is realizing 
  System Administrator          attainable dreams.
   The EngSoc Project     
