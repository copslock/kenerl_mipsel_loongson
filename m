Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id TAA222759 for <linux-archive@neteng.engr.sgi.com>; Thu, 1 Jan 1998 19:09:33 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA17041 for linux-list; Thu, 1 Jan 1998 19:08:40 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA17026 for <linux@cthulhu.engr.sgi.com>; Thu, 1 Jan 1998 19:08:38 -0800
Received: from note.orchestra.cse.unsw.EDU.AU (note.orchestra.cse.unsw.EDU.AU [129.94.242.29]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id TAA05763
	for <linux@cthulhu.engr.sgi.com>; Thu, 1 Jan 1998 19:08:33 -0800
	env-from (andrewo@cse.unsw.edu.au)
Received: From dizzy With LocalMail ; Fri, 2 Jan 98 14:08:28 +1100 
From: "Andrew O'Brien" <andrewo@cse.unsw.edu.au>
To: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Date: Fri, 2 Jan 1998 03:08:28 +0000 (GMT)
X-Sender: andrewo@dizzy.disy.cse.unsw.EDU.AU
Reply-To: andrewo@cse.unsw.edu.au
Subject: Please help - need a 4600 no L2 cache kernel asap
Message-ID: <Pine.SGI.3.95.980102025811.7894J-100000@dizzy.disy.cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


A Happy New Year to you all !

Anybody there who has a 4600 _without_ a L2 cache or who has a fairly
stable source tree and feels like sparing a few CPU cycles for a kernel
compile, this would be much appreciated if you could send me the binary
kernel.

I need to do some benchmarking on a SGI/Linux platform (an INDY) and I
haven't been able to set up the cross-compilation environment correctly
due to many factors. The benchmarks are needed by mid next week, so this
is a kinda urgent call for help :) 

There is no non-standard bits and pieces - it just need the standard scsi,
ethernet, and serial drivers. Attached is a config file for version 2.1.74
if anybody needs it.

Again, thanks for your help and I hope (and pray ;) to hear from someone
soon.

cya

  ___________________________________________________________________
 /  Andrew O'Brien       andrewo@cse.unsw.edu.au   bbq@mindless.com  \
/  Student, Faculty of CSE       http://www.cse.unsw.edu.au/~andrewo  \
>  UNSW, Australia           President COMPSOC   http://www/~compsoc  <
\  BE (Comp)/BA (Psych)      Student Representative   stu-reps@cse..  /
 \___ "finger -l andrewo@cse.unsw.edu.au" for my current location ___/
