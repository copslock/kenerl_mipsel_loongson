Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA11976 for <linux-archive@neteng.engr.sgi.com>; Sun, 12 Jul 1998 21:42:08 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA76886
	for linux-list;
	Sun, 12 Jul 1998 21:41:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id VAA38099;
	Sun, 12 Jul 1998 21:41:27 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id VAA22125; Sun, 12 Jul 1998 21:41:21 -0700
Date: Sun, 12 Jul 1998 21:41:21 -0700
Message-Id: <199807130441.VAA22125@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: volume header fs...
In-Reply-To: <Pine.LNX.3.95.980711182315.8181A-100000@lager.engsoc.carleton.ca>
References: <Pine.LNX.3.95.980711182315.8181A-100000@lager.engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries writes:
 > 
 > What is on a volume header file system?  Is it EFS or something else?
 > 
 > I was thinking about writing such a driver so we could easily put Linux
 > kernels there. 

     It is a very simple flat file system, hardly deserving the name.
The directory is a list of name and (single) extent descriptors.  I don't
have the format ready to hand, but I can look it up if it isn't obvious
from dumping the first few blocks of the volume header (the first few
blocks of the disk).

  
