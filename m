Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA19986; Fri, 2 Aug 1996 17:14:14 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA18041 for linux-list; Sat, 3 Aug 1996 00:12:54 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA18029 for <linux@cthulhu.engr.sgi.com>; Fri, 2 Aug 1996 17:12:52 -0700
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [155.11.228.1]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA13570 for <linux@yon.engr.sgi.com>; Fri, 2 Aug 1996 17:11:13 -0700
Received: by soyuz.wellington.sgi.com (951211.SGI.8.6.12.PATCH1042/940406.SGI)
	 id MAA02013; Sat, 3 Aug 1996 12:12:32 +1200
From: alambie@wellington.sgi.com (Alistair Lambie)
Message-Id: <199608030012.MAA02013@soyuz.wellington.sgi.com>
Subject: Re: Linux: the next step
To: nigel@cthulhu.engr.sgi.com (Nigel Gamble)
Date: Sat, 3 Aug 1996 12:12:32 +1200 (NZT)
Cc: alambie@wellington.sgi.com, ariel@cthulhu.engr.sgi.com,
        linux@yon.engr.sgi.com
In-Reply-To: <32028A3C.2781@engr.sgi.com> from "Nigel Gamble" at Aug 2, 96 04:07:40 pm
X-Mailer: ELM [version 2.4 PL23]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> Alistair Lambie wrote:
> >    To
> >    emphasis this point I feel we need to have it run on any new platforms
> >    at first shipment, and support the neat features.
> 
> Dream on!  Here in ISD (Indigo2 land), we're working flat out just to
> get IRIX to run on any new platforms at first shipment, with all
> the neat features supported.  I think you'll find the same
> is true of all the other product divisions.
> 
Yeah, I know!!  This may be a dream, but I think it is to some degree achievable.
The thing with IRIX is that EVERYTHING has to be integrated and commercial 
quality on first ship.  What we really need to do in Linux is expose the 
interfaces to things.  If we give enough info to people it will generally 
happen.  I don't know what is involved to do this...maybe a skeleton driver
or something.  It doesn't really matter whether it is optimised, or even bug
free, just as long as it gives those with the ability to write code like this
enough info to work with.  As for applications and things to use this stuff,
thats up to the Linux community to do!

> > One comment I would make here is that people really need to work out whether
> > we are a hardware or software company.  I realise that this is probably
> > contentious (sp?), but my feeling is that we are a company who make hardware,
> > and the software is really a means to an end...selling more hardware.  If this
> > is true, then people need to look at where we are going to get the greatest
> > number of hardware sales from....Irix or Linux.  We need both I think to hit
> > different markets, and maybe we even need NT (don't want to get into that
> > argument!).  Maybe we should be getting agreement from management for funding
> > based on sales, and I'll bet we can get a lot more mileage from the funding
> > than Irix will :-)
> 
> We are neither a hardware company nor a software company.
> We are a *systems* company.  We build the best computer systems
> on the planet through a combination of hardware and software
> working together.  If we replaced IRIX with NT, we would have
> to cancel most of our high performance hardware projects, because
> NT will not support the new systems.  As for Linux,
> when will it support true symmetric multiprocessing with fine-grained
> semaphore and mutex locking, and a fully preemptible kernel?
> At the San Diego Usenix earlier this year, Linus Torvalds
> thought that the probable answer was "not anytime soon".
> (By the way, in order to do this correctly, every device driver would
> have to be rewritten.)  Linux would need this *at a minimum* before
> there is any hope that it would supplant IRIX on the current
> generation of hardware, let alone any future new platforms.
> 
Yup, you're right, we are a systems company.  I don't expect that Linux will 
replace IRIX even in the distant future.  IRIX isn't going to stand still, but
nor is Linux.  One of the things I have noticed about Linux is that when 
someone shows the way, things happen fairly quickly.  Probably Linus's comment
about the symmetric multiprocessing was based on available resource, rather
than a lack of desire to do it.  Maybe this is an opportunity for SGI to 
provide some input into the Linux community...if we were to do some starter
work on this (on one of our boxes of course!!) I'm sure that others would 
pretty soon catch on.  The big thing with Linux is that we don't have to do all
the work....a bit of work on an initial framework and a push in the right 
direction is often all that will be necessary.  Let's take the ISDN port on 
the Indy....if we somehow show people how to use this, I'm sure it won't be
long before someone outside of SGI gets it up and going!  Same with audio.

Let's not think in terms of supplanting IRIX, let's look at growing the number
of boxes we ship.  That's got ot be good for us!!

Cheers, Alistair
