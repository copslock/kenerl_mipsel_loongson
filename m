Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA16192; Fri, 2 Aug 1996 16:09:18 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA08028 for linux-list; Fri, 2 Aug 1996 23:07:57 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA08021 for <linux@cthulhu.engr.sgi.com>; Fri, 2 Aug 1996 16:07:55 -0700
Received: from aa5b.engr.sgi.com (aa5b.engr.sgi.com [192.102.117.24]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA13474 for <linux@yon.engr.sgi.com>; Fri, 2 Aug 1996 16:06:18 -0700
Received: from aa5b (localhost [127.0.0.1]) by aa5b.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via SMTP id QAA13029; Fri, 2 Aug 1996 16:07:41 -0700
Message-ID: <32028A3C.2781@engr.sgi.com>
Date: Fri, 02 Aug 1996 16:07:40 -0700
From: Nigel Gamble <nigel@cthulhu.engr.sgi.com>
X-Mailer: Mozilla 2.02S (X11; I; IRIX 6.2 IP22)
MIME-Version: 1.0
To: Alistair Lambie <alambie@wellington.sgi.com>
CC: ariel@cthulhu.engr.sgi.com, linux@yon.engr.sgi.com
Subject: Re: Linux: the next step
References: <199608010048.RAA10293@yon.engr.sgi.com> <9608021537.ZM16832@windy.wellington.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alistair Lambie wrote:
>    To
>    emphasis this point I feel we need to have it run on any new platforms
>    at first shipment, and support the neat features.

Dream on!  Here in ISD (Indigo2 land), we're working flat out just to
get IRIX to run on any new platforms at first shipment, with all
the neat features supported.  I think you'll find the same
is true of all the other product divisions.

> One comment I would make here is that people really need to work out whether
> we are a hardware or software company.  I realise that this is probably
> contentious (sp?), but my feeling is that we are a company who make hardware,
> and the software is really a means to an end...selling more hardware.  If this
> is true, then people need to look at where we are going to get the greatest
> number of hardware sales from....Irix or Linux.  We need both I think to hit
> different markets, and maybe we even need NT (don't want to get into that
> argument!).  Maybe we should be getting agreement from management for funding
> based on sales, and I'll bet we can get a lot more mileage from the funding
> than Irix will :-)

We are neither a hardware company nor a software company.
We are a *systems* company.  We build the best computer systems
on the planet through a combination of hardware and software
working together.  If we replaced IRIX with NT, we would have
to cancel most of our high performance hardware projects, because
NT will not support the new systems.  As for Linux,
when will it support true symmetric multiprocessing with fine-grained
semaphore and mutex locking, and a fully preemptible kernel?
At the San Diego Usenix earlier this year, Linus Torvalds
thought that the probable answer was "not anytime soon".
(By the way, in order to do this correctly, every device driver would
have to be rewritten.)  Linux would need this *at a minimum* before
there is any hope that it would supplant IRIX on the current
generation of hardware, let alone any future new platforms.

-- 
Nigel Gamble       "Are we going to push the edge of the envelope,
Brain?"
Silicon Graphics   "No, Pinky, but we may get to the sticky part."
nigel@sgi.com
(415) 933-3109
