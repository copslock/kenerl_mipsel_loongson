Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id SAA1163237 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Dec 1997 18:55:42 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA08034 for linux-list; Thu, 11 Dec 1997 18:54:37 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA08011 for <linux@cthulhu.engr.sgi.com>; Thu, 11 Dec 1997 18:54:34 -0800
Received: from note.orchestra.cse.unsw.EDU.AU (note.orchestra.cse.unsw.EDU.AU [129.94.242.29]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id SAA18322
	for <linux@cthulhu.engr.sgi.com>; Thu, 11 Dec 1997 18:53:53 -0800
	env-from (andrewo@cse.unsw.edu.au)
Received: From dizzy With LocalMail ; Fri, 12 Dec 97 13:53:21 +1100 
From: "Andrew O'Brien" <andrewo@cse.unsw.edu.au>
To: linux@cthulhu.engr.sgi.com
Date: Fri, 12 Dec 1997 02:52:48 +0000 (GMT)
X-Sender: andrewo@dizzy.disy.cse.unsw.EDU.AU
Reply-To: andrewo@cse.unsw.edu.au
Subject: Re: Mount ext2 filesystem.
In-Reply-To: <199712120116.KAA05559@meteor.nsg.sgi.com>
Message-ID: <Pine.SGI.3.95.971212024323.1030A-100000@dizzy.disy.cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, 12 Dec 1997, Takeshi Hakamada wrote:

> 
> > > Thank you. I've converted rpm to cpio and I could have installed rpm binary.
> > > But, I can't boot from local disk yet. If I can boot from local disk, I'd
> > > like to update faq on the www.linux.sgi.com. How do you think about it?
> > 
> > In irix, shutdown, restart hit the maintenance button to get to the arc
> > menu, hit command line and do I think its
> > 
> > boot /whatever/efs/vmlinux root=/dev/sdb1
> > 
> > (first partition disk 2 as root)
> 
> I know this method, my want to boot from local disk is, I've not installed
> all rpm packages on the second disk. I'll do this until tomorrow.
> Do you think anyone wants my installation howto?

Yep !

I'm a student at The University of NSW, Australia and over this summer
(yes it's summer now ;) I'll be undertaking to port Linux to a specialised
board developed here, which uses a R4{6,7}00 chip.

As a warmup exercise, as I've been given access to an Indy and brought in
my home Linux x86 box as a bootserver, I'll try and install SGI/Linux. The
only prob is that I've never used/played with an SGI before and so would
appreciate a slightly more comprehensive howto then the FAQ. 

I've been lurking in the background the last few days and this seems like
an appropriate time to say "Hi".

Any hints or tips anyone could send me would be much appreciated.

Thanks

  ___________________________________________________________________
 /  Andrew O'Brien       andrewo@cse.unsw.edu.au   bbq@mindless.com  \
/  Student, Faculty of CSE       http://www.cse.unsw.edu.au/~andrewo  \
>  UNSW, Australia           President COMPSOC   http://www/~compsoc  <
\  BE (Comp)/BA (Psych)      Student Representative   stu-reps@cse..  /
 \___ "finger -l andrewo@cse.unsw.edu.au" for my current location ___/
