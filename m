Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id VAA28713 for <linux-archive@neteng.engr.sgi.com>; Wed, 21 Jan 1998 21:27:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA02283 for linux-list; Wed, 21 Jan 1998 21:22:01 -0800
Received: from tantrik.engr.sgi.com (tantrik.engr.sgi.com [192.26.72.25]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA02279; Wed, 21 Jan 1998 21:21:59 -0800
Received: from localhost (shm@localhost) by tantrik.engr.sgi.com (971110.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id VAA04363; Wed, 21 Jan 1998 21:21:59 -0800 (PST)
Date: Wed, 21 Jan 1998 21:21:58 -0800 (PST)
From: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
To: ralf@uni-koblenz.de
cc: Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: Re: lame question ...
In-Reply-To: <19980122061334.36263@uni-koblenz.de>
Message-ID: <Pine.SGI.3.94.980121211922.4495A-100000@tantrik.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Thu, 22 Jan 1998 ralf@uni-koblenz.de wrote:

->On Wed, Jan 21, 1998 at 07:15:56PM -0800, Shrijeet Mukherjee wrote:
->
->> but in the indy low-level startup code, there seems to be 2 major
->> functions .. 
->> 
->> 1> init the MC .. I believe that is the Memory Controller ..
->> 2> init the HPC .. anyone out there know what that is  .. so that I can
->> put in the right functionality in the correspoding file for the indigo ??
->
->The main functionality is as DMA controller.  I think there is also some
->IRQ stuff in it, don't have the docs at hand.


it appears now, that the HPC is the DMA controller for the SCSI interfaces
.. but HPC-1 which is on the Indigo is missing a lot of the functions of
the HPC-3 which the IP22 boards shipped with .. and is the only
implemented HPC currently ..

the main worry I have is what is the functionality that the upper layers
need and is there a layer that I can look at that needs to have complete
functionality so that upper layers can function normally ..?? if you know
what I mean ..

--
--------------------------------------------------------------------------
Shrijeet Mukherjee,    			Member of Technical Staff (MTS)
					Advanced Graphics Division 
                     			Silicon Graphics Computer Systems

http://reality.sgi.com/shm_engr     	phone: 650-933-5312
email: shm@engr.sgi.com, shm@sgi.com, shm@cs.uoregon.edu
--------------------------------------------------------------------------
Life is a comedy to those that think, a tragedy to those that feel.
