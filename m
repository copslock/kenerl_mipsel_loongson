Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA01324; Mon, 12 Aug 1996 16:00:30 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA16841 for linux-list; Mon, 12 Aug 1996 22:59:25 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA16829 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Aug 1996 15:59:23 -0700
Received: from aa5b.engr.sgi.com (aa5b.engr.sgi.com [192.102.117.24]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA29987 for <linux@yon.engr.sgi.com>; Mon, 12 Aug 1996 15:57:39 -0700
Received: (from nigel@localhost) by aa5b.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA28318; Mon, 12 Aug 1996 15:59:04 -0700
From: nigel@aa5b.engr.sgi.com (Nigel Gamble)
Message-Id: <199608122259.PAA28318@aa5b.engr.sgi.com>
Subject: Re: Linux: the next step
To: lm@gate1-neteng.engr.sgi.com (Larry McVoy)
Date: Mon, 12 Aug 1996 15:59:04 -0700 (PDT)
Cc: jes@machine.engr.sgi.com, sca@refugee.engr.sgi.com, lm@neteng.engr.sgi.com,
        nigel@cthulhu.engr.sgi.com, alambie@wellington.sgi.com,
        ariel@cthulhu.engr.sgi.com, linux@yon.engr.sgi.com
In-Reply-To: <199608122149.OAA15461@neteng.engr.sgi.com> from "Larry McVoy" at Aug 12, 96 02:49:45 pm
X-Mailer: ELM [version 2.4 PL23]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> : Now wait a minute here.  Read the paper before commenting.
> : They create a "real-time" thread under Linux.  That does not
> : mean that it does anything, that the OS has real time support,
> : etc.  There was nothing particularly new about what it did.
> 
> Here's what they did:  they took over control of interrupt disable/enable
> and dispatch.  They run Linux as a thread and allow you to have 0 or more
> real time threads.   If all you are doing is running Linux, it looked
> to me like there was minimal impact to the performance of the system.
> 
> Real time threads run on the bare hardware, they have little
> integration with the OS, other than a pipe like communications device.
> The programming paradigm is you run two processes, one real time that
> gathers events and stuffs them in the "pipe", and one normal that reads
> events out of the pipe and does time _un_critical processing.

That's fine for one class of real-time problems, but it's not going
to help make the RealAudio player (raplayer) useable on Linux.
RealAudio only has to produce AM radio quality audio from a
28.8kbps input stream, yet I only have to move my mouse into
a new window to get audio drop-out.  The RealAudio application,
together with all the support that it is getting from the kernel
in audio drivers, networking code etc., needs to run at a higher
priority than most of the other stuff that might be going on.
This is also a "real time problem", although a different one
from the "get the O/S out of my way" hard real time crowd.

How will Linux solve this type of problem?

> They can guarentee real time response of 10Khz, with less than 15 usec
> variation.  That was with Linux running a 
> 
> 	tar f - /usr | (cd /newusr; tar xf -)
> 
> a web browser, X, etc, etc.  Good luck doing that on IRIX up.  Maybe MP.

We can already do this on MP with User Level Interrupts.

As for UP, stay tuned :-)  (Since this mailing list goes outside
of SGI, I'm not going to say any more.)

-- 
Nigel Gamble       "Are we going to push the edge of the envelope, Brain?"
Silicon Graphics   "No, Pinky, but we may get to the sticky part."
nigel@sgi.com
(415) 933-3109
