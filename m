Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA01457; Tue, 13 Aug 1996 04:46:11 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA02414 for linux-list; Tue, 13 Aug 1996 11:46:02 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA02407 for <linux@cthulhu.engr.sgi.com>; Tue, 13 Aug 1996 04:45:59 -0700
Received: from neteng.engr.sgi.com (gate5-neteng.engr.sgi.com [150.166.61.33]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA00933 for <linux@yon.engr.sgi.com>; Tue, 13 Aug 1996 04:44:15 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA01442; Tue, 13 Aug 1996 04:45:56 -0700
Date: Tue, 13 Aug 1996 04:45:56 -0700
Message-Id: <199608131145.EAA01442@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: nigel@aa5b.engr.sgi.com
CC: lm@neteng.engr.sgi.com, jes@machine.engr.sgi.com, sca@refugee.engr.sgi.com,
        lm@neteng.engr.sgi.com, nigel@cthulhu.engr.sgi.com,
        alambie@wellington.sgi.com, ariel@cthulhu.engr.sgi.com,
        linux@yon.engr.sgi.com
In-reply-to: <199608122259.PAA28318@aa5b.engr.sgi.com> (nigel@aa5b)
Subject: Re: Linux: the next step
Reply-to: dm@sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: nigel@aa5b (Nigel Gamble)
   Date: Mon, 12 Aug 1996 15:59:04 -0700 (PDT)

   > They can guarentee real time response of 10Khz, with less than 15 usec
   > variation.  That was with Linux running a 
   > 
   > 	tar f - /usr | (cd /newusr; tar xf -)
   > 
   > a web browser, X, etc, etc.  Good luck doing that on IRIX up.  Maybe MP.

   We can already do this on MP with User Level Interrupts.

I cannot wait to recompile all of my applications so that they can
take advantage of ULI...

The whole idea behind whatever approach linux will take to anything
(using clone() for threads under Linux is a good example) is that you
will not need to teach all of your "dumb" old programs (even ps!)
about these special processes and or things a process can do.

dm@engr.sgi.com

'Ooohh.. "FreeBSD is faster over loopback, when compared to
Linux over the wire". Film at 11.' -Linus
