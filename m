Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id XAA234061 for <linux-archive@neteng.engr.sgi.com>; Thu, 1 Jan 1998 23:01:02 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA04210 for linux-list; Thu, 1 Jan 1998 23:00:14 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA04205 for <linux@cthulhu.engr.sgi.com>; Thu, 1 Jan 1998 23:00:13 -0800
Received: from note.orchestra.cse.unsw.EDU.AU (note.orchestra.cse.unsw.EDU.AU [129.94.242.29]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id XAA04288
	for <linux@cthulhu.engr.sgi.com>; Thu, 1 Jan 1998 23:00:10 -0800
	env-from (andrewo@cse.unsw.edu.au)
Received: From dizzy With LocalMail ; Fri, 2 Jan 98 17:59:55 +1100 
From: "Andrew O'Brien" <andrewo@cse.unsw.edu.au>
To: Alex deVries <adevries@engsoc.carleton.ca>
Date: Fri, 2 Jan 1998 06:59:54 +0000 (GMT)
X-Sender: andrewo@dizzy.disy.cse.unsw.EDU.AU
Reply-To: andrewo@cse.unsw.edu.au
cc: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: Re: Please help - need a 4600 no L2 cache kernel asap
In-Reply-To: <Pine.LNX.3.95.980102003631.24450B-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.SGI.3.95.980102065738.7894L-100000@dizzy.disy.cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, 2 Jan 1998, Alex deVries wrote:

> 
> On Fri, 2 Jan 1998, Andrew O'Brien wrote:
> > I need to do some benchmarking on a SGI/Linux platform (an INDY) and I
> > haven't been able to set up the cross-compilation environment correctly
> > due to many factors. The benchmarks are needed by mid next week, so this
> > is a kinda urgent call for help :) 
> 
> Is there any reason the binaries on ftp.linux.sgi.com won't work?

Yep - they were compiled assuming that a L2 cache was present - hence when
it tries to flush the cache during init, the system hangs horribly.

I wasn't the only one to be hit by this so I'm sure there is a binary
floating around somewhere :)

cya

  ___________________________________________________________________
 /  Andrew O'Brien       andrewo@cse.unsw.edu.au   bbq@mindless.com  \
/  Student, Faculty of CSE       http://www.cse.unsw.edu.au/~andrewo  \
>  UNSW, Australia           President COMPSOC   http://www/~compsoc  <
\  BE (Comp)/BA (Psych)      Student Representative   stu-reps@cse..  /
 \___ "finger -l andrewo@cse.unsw.edu.au" for my current location ___/
