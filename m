Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id UAA135978 for <linux-archive@neteng.engr.sgi.com>; Sun, 11 Jan 1998 20:23:29 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA16009 for linux-list; Sun, 11 Jan 1998 20:23:05 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA16005; Sun, 11 Jan 1998 20:23:03 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id UAA18203; Sun, 11 Jan 1998 20:22:58 -0800
Date: Sun, 11 Jan 1998 20:22:58 -0800
Message-Id: <199801120422.UAA18203@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: William Ellis <bellis@cerf.net>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: SGI/Linux on a Challenge S series
In-Reply-To: <Pine.SOL.3.94.980110093122.2895A-100000@maelstrom.cerf.net>
References: <19980110120428.62352@thoma.uni-koblenz.de>
	<Pine.SOL.3.94.980110093122.2895A-100000@maelstrom.cerf.net>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

William Ellis writes:
 > 
 > 
 > I just got hold of a spare Challenge S Series(R5000) I was
 > going to attempt putting SGI/Linux on.  I know the porting is
 > basicaly geared for the Indy's but I was going to muck with it
 > a bunch. Then I just saw this post and was wondering if there 
 > was any quick, good heads-up for these machines.  
 > Thanks, Bill 
 > 
 > >> I tried to compile the latest sources for an Indigo R4k .. with minimal
 > [*snip*]
 > > Did you modify the load address of the kernel?  Indy kernels are by
 > > default linked for address 0x88002000 because the Indy has a 128mb
 > > hole in it's address space there.  I assumes (wje???) that your box
 > > has it's memory mapped from 0x80000000 upwards, so this would only
 > > work if you actually have that more than 128mb ...

        The Challenge S and Indy are identical, except that the Challenge S
does not have a graphics card.
