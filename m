Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA05556 for <linux-archive@neteng.engr.sgi.com>; Thu, 24 Sep 1998 09:30:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA05477
	for linux-list;
	Thu, 24 Sep 1998 09:30:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA98789
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 24 Sep 1998 09:30:09 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA00341
	for <linux@cthulhu.engr.sgi.com>; Thu, 24 Sep 1998 09:30:01 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id MAA26426;
	Thu, 24 Sep 1998 12:33:53 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 24 Sep 1998 12:33:53 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Jeremy John Welling <jwelling@engin.umich.edu>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: challenge s boots linux
In-Reply-To: <Pine.SOL.4.02.9809240031070.6032-100000@azure.engin.umich.edu>
Message-ID: <Pine.LNX.3.96.980924123140.20033F-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 24 Sep 1998, Jeremy John Welling wrote:
> What is the next architecture sgi/linux will be ported to?  Indigo2 r4kXZ?  
> What is the status of the newport Xserver? What is the best place to get
> specific hardware info?  Has anyone started on the Indy XZ graphics?  

This is an interesting question, and I for one would much rather see
things like the graphics for Newport and audio working on the INdy before
we start off on other things like the Indigo2.

But, i've been thinking for awhile that an Indigo2 port would be the next
box to target... i suppose there's no harm in looking at both machines
concurrently.

Getting docs on the Indigo2 would be quite important for a successful
port, though.  That would require SGI's help, and I can see them being a
lot more open to it if we got the Indy completely supported first.

- Alex
