Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA31935 for <linux-archive@neteng.engr.sgi.com>; Sat, 1 May 1999 19:06:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA39469
	for linux-list;
	Sat, 1 May 1999 19:03:07 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA58061
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 1 May 1999 19:03:04 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from vera.dpo.uab.edu (Vera.dpo.uab.edu [138.26.1.12]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id WAA03045
	for <linux@cthulhu.engr.sgi.com>; Sat, 1 May 1999 22:03:03 -0400 (EDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu by vera.dpo.uab.edu (LSMTP for Windows NT v1.1a) with SMTP id <0.005D2BD0@vera.dpo.uab.edu>; Sat, 1 May 1999 21:03:02 -0500
Date: Sat, 1 May 1999 21:03:38 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Alan Hoyt <neuroinc@unidial.com>
cc: Charles Lepple <clepple@foo.tho.org>,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Indigo2 port status?
In-Reply-To: <372B4C6F.6EB74AD8@unidial.com>
Message-ID: <Pine.LNX.3.96.990501205629.3348B-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Sat, 1 May 1999, Alan Hoyt wrote:
> 
> I don't know what's going on with UAB - but I just started working on a
> port to the Indigo2 this April after receiving some hardware specs.
> Needless to say with school and work, progress is a tad bit slow.
> Hopefully, once finals are behind me - I can focus more energy on the
> task.
> 
> Alan Hoyt

Well, here at UAB, I have an Indigo2 booting the kernel, mounting root
over NFS, and crashing.  All this is done with very few changes to the
source.  I am putting together a set of patches currently.  I'll post here
when they are ready.  I don't have submit access to the CVS tree so I
won't be able to put them there.  I would like some people to make sure
the patches don't break the Indy ;)  

Also, what is a good way of getting the boot messages to print via the
prom commands?  Currently I have a hacked up printk to do this, but would
like something cleaner.  Would it be feasible to write a prom console?  It
might make it easier to work on boxes without any sort of graphics support
available yet...

-Andrew
