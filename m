Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id KAA69143 for <linux-archive@neteng.engr.sgi.com>; Sat, 10 Jan 1998 10:04:58 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA04596 for linux-list; Sat, 10 Jan 1998 10:04:37 -0800
Received: from daddyo.engr.sgi.com (daddyo.engr.sgi.com [150.166.49.110]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA04592; Sat, 10 Jan 1998 10:04:36 -0800
Received: (from marker@localhost) by daddyo.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) id KAA62540; Sat, 10 Jan 1998 10:04:33 -0800 (PST)
From: marker@daddyo.engr.sgi.com (Charles Marker)
Message-Id: <199801101804.KAA62540@daddyo.engr.sgi.com>
Subject: Re: SGI/Linux on a Challenge S series
To: bellis@cerf.net (William Ellis)
Date: Sat, 10 Jan 1998 10:04:32 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com, marker@daddyo.engr.sgi.com (Charles Marker)
In-Reply-To: <Pine.SOL.3.94.980110093122.2895A-100000@maelstrom.cerf.net> from "William Ellis" at Jan 10, 98 09:38:20 am
X-Mailer: ELM [version 2.4 PL23]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> 
> 
> I just got hold of a spare Challenge S Series(R5000) I was
> going to attempt putting SGI/Linux on.  I know the porting is
> basicaly geared for the Indy's but I was going to muck with it
> a bunch. Then I just saw this post and was wondering if there 
> was any quick, good heads-up for these machines.  
> Thanks, Bill 

A Challenge S is just an Indy with the graphics, ISDN and some of the
digital media removed.  As long as the kernel is probing for those
devices and handling their non existance correctly, this should work
reasonably well.

					Charles

> >> I tried to compile the latest sources for an Indigo R4k .. with minimal
> [*snip*]
> > Did you modify the load address of the kernel?  Indy kernels are by
> > default linked for address 0x88002000 because the Indy has a 128mb
> > hole in it's address space there.  I assumes (wje???) that your box
> > has it's memory mapped from 0x80000000 upwards, so this would only
> > work if you actually have that more than 128mb ...
> >   Ralf
> 
