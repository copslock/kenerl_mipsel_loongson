Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id PAA114406 for <linux-archive@neteng.engr.sgi.com>; Thu, 9 Oct 1997 15:57:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA29653 for linux-list; Thu, 9 Oct 1997 15:57:25 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA29643 for <linux@cthulhu.engr.sgi.com>; Thu, 9 Oct 1997 15:57:24 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA06752
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Oct 1997 15:57:19 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id SAA21831 for <linux@cthulhu.engr.sgi.com>; Thu, 9 Oct 1997 18:57:29 -0400
Date: Thu, 9 Oct 1997 18:57:29 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: linux@cthulhu.engr.sgi.com
Subject: Arch specific initramdisk?
Message-ID: <Pine.LNX.3.95.971009185152.20315W-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I'm trying to do kernel modifications so that initrd is supported, which
will make installations easier.

I was a bit surprised that these weren't architecture neutral to begin
with.  Why is this dependant on the arch? The code I've found for other
archs is in arch/*/kernel/setup.c.

How safe is it for me to replicate the code from, say, the sparc port?  Is
there anything I should be aware of?

- Alex

      Alex deVries              Success is realizing 
  System Administrator          attainable dreams.
   The EngSoc Project     
