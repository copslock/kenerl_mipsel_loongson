Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA19543; Tue, 17 Jun 1997 11:18:45 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA20180 for linux-list; Tue, 17 Jun 1997 11:18:29 -0700
Received: from morgaine.engr.sgi.com (morgaine.engr.sgi.com [130.62.16.64]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA20130 for <linux@cthulhu.engr.sgi.com>; Tue, 17 Jun 1997 11:18:07 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by morgaine.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA14934 for <linux@morgaine.engr.sgi.com>; Tue, 17 Jun 1997 11:15:46 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA19503 for <linux@morgaine.engr.sgi.com>; Tue, 17 Jun 1997 11:15:44 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA07394
	for <linux@morgaine.engr.sgi.com>; Tue, 17 Jun 1997 11:15:29 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id NAA15810;
	Tue, 17 Jun 1997 13:00:39 -0500
Date: Tue, 17 Jun 1997 13:00:39 -0500
Message-Id: <199706171800.NAA15810@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: offer@sgi.com
CC: linux@morgaine.engr.sgi.com
In-reply-to: <9706171053.ZM9344@sgi.com> (offer@sgi.com)
Subject: Re: Good news: no more begging for HW
X-Windows: Garbage at your fingertips.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> * 2. What kind of acceleration features are available on the SGI
> *    machines?  The X11R6 server has hooks for different set of
> *    features, so for example, bitblit can be easily hacked into the X
> *    server.
> *
> *    But I imagine the SGI has more acceleration features that I can
> *    dream of.
> 
> The problem is that (I think) we have so many graphics cards that its done
> differently in every one (some cards are simple frame buffers (8/24bit), then
> there are some with multiple GE, oh and we also have extra visuals for overlay
> and pop-ups.

What does "multiple GE" stand for?  

Supporting a wide variety of devices in X11R6 should be quite easy.
This X server also can support multiple visuals on a display, so this
should be easy to hack on as well.

> *    I looked yesterday at a program called glxinfo, which led me to
> *    believe that applications may have some of the GL code linked in
> *    trough the libraries and the other part resides on the X server.
> 
> Both :-) We don't do things the way easy here.

So OpenGL applications can run without an X server, or they have code
to bypass the X server if they need to?

> The is a GLX extension in the X server which allows GL to run in an X window.
> 
> There is also I think a DSO that holds the hardware specific GL calls.

Sorry, but what does DSO stand for?

> To me the quickest (and the best) way of getting an X server would be if we
> could simply port the existing Irix X server to Linux/SGI. My suggestion would
> be, now that we have backing for hardware to get official backing for software.
> I don't think we should neccesarrily release the source code for the ddx part
> of the X server to the public, but we should at least be able to get backing to
> release .o files so the user could re-link the X server if they needed to (Sun
> have done this before).

Ok.  This sound good enough.  

Miguel.
