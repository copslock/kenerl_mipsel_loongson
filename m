Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA22837 for <linux-archive@neteng.engr.sgi.com>; Sun, 2 May 1999 18:36:19 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA94564
	for linux-list;
	Sun, 2 May 1999 18:30:47 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA07096
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 2 May 1999 18:30:45 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from vera.dpo.uab.edu (Vera.dpo.uab.edu [138.26.1.12]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA09321
	for <linux@cthulhu.engr.sgi.com>; Sun, 2 May 1999 21:30:44 -0400 (EDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu by vera.dpo.uab.edu (LSMTP for Windows NT v1.1a) with SMTP id <0.A6E290C0@vera.dpo.uab.edu>; 2 May 1999 20:30:43 -0500
Date: Sun, 2 May 1999 20:31:20 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Ulf Carlsson <ulfc@thepuffingroup.com>
cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Indigo2 patch
In-Reply-To: <19990502205347.A7346@thepuffingroup.com>
Message-ID: <Pine.LNX.3.96.990502202759.15211B-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Sun, 2 May 1999, Ulf Carlsson wrote:
> Yes, there's a better way. A PROM console can be implemented. I have hacked some
> code for this PROM console for this purpose. I can't get it to open the initial
> console though. I'll send it to you, maybe you have time to figure out what's
> wrong...

Great, most of the work has already been done for me. ;)  This is what I
had thought about, I just hadn't tried to figure out where to start yet.
A PROM console would probably be a help on any of the SGIs until some sort
of graphics support is worked out.  

> > -LINKFLAGS	= -static -N
> > +# having -N in LINKFLAGS causes my Indigo2 not to boot
> > +LINKFLAGS	= -static
> 
> This is a problem with the cross linker and not with the kernel itself, it's the
> same for Indy's. The code in the CVS tree should remain as it is.

Any chance on getting the cross linker fixed?

-Andrew
