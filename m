Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA19672; Fri, 2 Aug 1996 16:55:30 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA15732 for linux-list; Fri, 2 Aug 1996 23:54:10 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA15725 for <linux@cthulhu.engr.sgi.com>; Fri, 2 Aug 1996 16:54:09 -0700
Received: from neteng.engr.sgi.com (gate5-neteng.engr.sgi.com [150.166.61.33]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA13519 for <linux@yon.engr.sgi.com>; Fri, 2 Aug 1996 16:52:32 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA19624; Fri, 2 Aug 1996 16:54:06 -0700
Date: Fri, 2 Aug 1996 16:54:06 -0700
Message-Id: <199608022354.QAA19624@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: nigel@cthulhu.engr.sgi.com
CC: alambie@wellington.sgi.com, ariel@cthulhu.engr.sgi.com,
        linux@yon.engr.sgi.com
In-reply-to: <32028A3C.2781@engr.sgi.com> (message from Nigel Gamble on Fri,
	02 Aug 1996 16:07:40 -0700)
Subject: Re: Linux: the next step
Reply-to: dm@sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   Date: Fri, 02 Aug 1996 16:07:40 -0700
   From: Nigel Gamble <nigel@cthulhu>

   Dream on!  Here in ISD (Indigo2 land), we're working flat out just
   to get IRIX to run on any new platforms at first shipment, with all
   the neat features supported.  I think you'll find the same is true
   of all the other product divisions.

I am one person, I am getting close to bootstrapping a complete Linux
system on the INDY in the course of 3 months.  The only way I could be
dreaming is due to the fact that I have been hacking for 30 hours
straight with no sleep at all and this isn't even flat out for me
actually.

   We are neither a hardware company nor a software company.  We are a
   *systems* company.

Although this may be true, what ever sells your hardware could foot
the purpose correct?  The margin comes from the hardware, and as you
say the software is there to make that hardware capable of doing
something.  If Linux could do this, and sell SGI hardware, SGI is
doing the same thing it is today in my estimation.

   As for Linux, when will it support true symmetric multiprocessing
   with fine-grained semaphore and mutex locking, and a fully
   preemptible kernel?  At the San Diego Usenix earlier this year,
   Linus Torvalds thought that the probable answer was "not anytime
   soon".

Linus, myself, and some other key developers have come to the
conclusion that the current way of doing SMP is no more than an
intellectual curiosity and nothing more.

What he had in the back of his mind when he made that statement at
Usenix was really, "Linux is not going to scale it's SMP in that way."
But being the person that he is, he decided not to put it that way
until he had a cast in stone proof of concept that another way was
indeed possible.

With Linux, thankfully, we have the luxury of really thinking about
how to correctly go about something like a scalable SMP kernel
architecture without a deadline hovering over our heads.

However, I will be frank, and say that no we do not have this SMP of
all SMP figured out yet.  But I do believe that we will come up with
something not short of impressive and cutting edge.

If I had to guess at how we'd go about it, generally?  I would venture
one of the following or a combination thereof perhaps:

1) Scale to 4 cpus and nothing more, cluster past that, run seperate
   kernels on each processor group of 4, which live in their own
   little world and do not have shared resources with the other
   cluster kernels.  With the exception that clusters can pass
   processes between each other when load on one get much too high
   than the others.  (I'm a bit sketchy on any of the real specifics
   on how we would pull this one off entirely)

2) Away with the locks completely, if you are going to do SMP then
   don't add a brick wall to the equation as a means to an end.
   Through numerous conversations with Linus I have deteremined that
   he and I agree that locks all over the place is not the way to go
   and neither is pre-emption.  We believe that the purpose of locks
   can be replaced entirely with carefully designed data structures
   that are atomic via the way they are accessed.

Again these are just off the top of my head, unfortunately I haven't
had the opportunity to get into the zone and put all of my senses into
getting these ideas out of perpetual beta.  I was hoping that if I
got the initial INDY port out of the way and functional very quickly
I'd finally have a chance to think about these things and come up with
something concrete I could actually implement and start playing with.
This is along the lines of what I wanted my big contribution back to
SGI to be for allowing me to have this internship, however it was
obviously necessary to get a proof of concept Linux implementation out
the door on a machine before I could start doing things like that.

My real point is, yes we cannot scale very well on the type of
machines you mention, we do not have fine grained SMP and kernel
preemtion.  The current view I propose is that this method of doing
SMP is one of many oysters that could have been opened to satisfy the
needs of the task at hand.  However I feel that the oyster with
the real pearl of an SMP implementation in it has yet to have been
found.

Putting Linux down because it cannot do what Solaris2.5, SVR4.2MP, and
IRIX can do "today" on very high end hardware I would consider to be
an oxy-moron.  All of it's code has been written by contributors in
their spare time and out of their own good hearts on the low end
hardware they could only get their hands on.  And even with those
constraints, we have things which the other freely available operating
systems simply do not have an probably will not for a very long time.

But now all of this is slowly but surely going to change, as more and
more people like myself get the opportunity to express their hacking
talents on high end hardware (the systems where the capabilities you
mention even matter) via contributions such as my internship and
hardware loans to the various developers, this gap will get smaller
and smaller especially if the current pace of Linux keeps up.  This is
one thing I can assure you of.

Maybe the real issue is, now that I think about, we haven't put our
efforts into crossing that bridge, because we have not gotten to it
yet.  When we do get there, it'll show time baby.

dm@engr.sgi.com

'Ooohh.. "FreeBSD is faster over loopback, when compared to
Linux over the wire". Film at 11.' -Linus
