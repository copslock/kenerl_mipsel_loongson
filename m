Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA03109; Mon, 12 Aug 1996 16:32:58 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA23375 for linux-list; Mon, 12 Aug 1996 23:31:52 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA23367 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Aug 1996 16:31:51 -0700
Received: from ratliff.engr.sgi.com (ratliff.engr.sgi.com [150.166.42.14]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA00094 for <linux@yon.engr.sgi.com>; Mon, 12 Aug 1996 16:30:06 -0700
Received: from localhost by ratliff.engr.sgi.com via SMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id QAA09379; Mon, 12 Aug 1996 16:31:31 -0700
Message-Id: <199608122331.QAA09379@ratliff.engr.sgi.com>
To: nigel@aa5b.engr.sgi.com (Nigel Gamble)
cc: lm@gate1-neteng.engr.sgi.com (Larry McVoy), jes@machine.engr.sgi.com,
        sca@refugee.engr.sgi.com, lm@neteng.engr.sgi.com,
        alambie@wellington.sgi.com, ariel@cthulhu.engr.sgi.com,
        linux@yon.engr.sgi.com
Subject: Re: Linux: the next step 
In-reply-to: Your message of "Mon, 12 Aug 96 15:59:04 PDT."
             <199608122259.PAA28318@aa5b.engr.sgi.com> 
Date: Mon, 12 Aug 96 16:31:30 -0700
From: Bob English <renglish@ratliff.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

In message <199608122259.PAA28318@aa5b.engr.sgi.com> you write:
>That's fine for one class of real-time problems, but it's not going
>to help make the RealAudio player (raplayer) useable on Linux...
>The RealAudio application, together with all the support that it is
>getting from the kernel in audio drivers, networking code etc., needs
>to run at a higher priority than most of the other stuff that might be
>going on...
>
>How will Linux solve this type of problem?

With mirrors.  You run another copy of Linux on a high-priority RT
thread.  Full API, fast preemption, minimal performance and code impact.
You work on linux-slow and run rt apps on linux-fast.  You could even
reboot linux-slow without losing your audio signal :-).

--bob--
