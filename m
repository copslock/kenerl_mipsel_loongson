Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA05128; Tue, 13 Aug 1996 08:37:04 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA21898 for linux-list; Tue, 13 Aug 1996 15:36:38 GMT
Received: from aa5b.engr.sgi.com (aa5b.engr.sgi.com [192.102.117.24]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA21887 for <linux@cthulhu.engr.sgi.com>; Tue, 13 Aug 1996 08:36:36 -0700
Received: (from nigel@localhost) by aa5b.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA29651; Tue, 13 Aug 1996 08:36:36 -0700
From: nigel@aa5b.engr.sgi.com (Nigel Gamble)
Message-Id: <199608131536.IAA29651@aa5b.engr.sgi.com>
Subject: Re: Linux: the next step
To: dm@sgi.com
Date: Tue, 13 Aug 1996 08:36:35 -0700 (PDT)
Cc: linux@aa5b.engr.sgi.com
In-Reply-To: <199608131145.EAA01442@neteng.engr.sgi.com> from "David S. Miller" at Aug 13, 96 04:45:56 am
X-Mailer: ELM [version 2.4 PL23]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>    From: nigel@aa5b (Nigel Gamble)
>    Date: Mon, 12 Aug 1996 15:59:04 -0700 (PDT)
> 
>    > They can guarentee real time response of 10Khz, with less than 15 usec
>    > variation.  That was with Linux running a 
>    > 
>    > 	tar f - /usr | (cd /newusr; tar xf -)
>    > 
>    > a web browser, X, etc, etc.  Good luck doing that on IRIX up.  Maybe MP.
> 
>    We can already do this on MP with User Level Interrupts.
> 
> I cannot wait to recompile all of my applications so that they can
> take advantage of ULI...

I think you missed my point.  The real time approach that Larry
described will only suit the hard real time programmers who
want only to get the O/S out of the way and program the bare
metal.  The real time application code will have to be custom
written and will get no support from Linux itself - you can't
call Linux system calls from one of these real time threads.
Forget POSIX real time APIs!

IRIX's ULI mechanism already provides a similar facility for
people who are willing to trade O/S support for performance,
(since you can't execute IRIX system calls from a ULI, either).

> The whole idea behind whatever approach linux will take to anything
> (using clone() for threads under Linux is a good example) is that you
> will not need to teach all of your "dumb" old programs (even ps!)
> about these special processes and or things a process can do.

The next release of IRIX will have real time support for user
applications, even on a UP, with guarantees sufficient for
digital media (audio and video).  You won't need to recompile
your application to take advantage of this environment.
We already know what we need to do to achieve this, and have
already implemented most of it.  Our approach is based on a
fully preemptible kernel, interrupts that have a thread context
that can block, and making sure that interrupts are never disabled
for more than 100us.

I'm still waiting to hear "whatever approach linux will take"
to solve this problem.

-- 
Nigel Gamble       "Are we going to push the edge of the envelope, Brain?"
Silicon Graphics   "No, Pinky, but we may get to the sticky part."
nigel@sgi.com
(415) 933-3109
