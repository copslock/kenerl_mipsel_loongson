Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA10547; Tue, 17 Jun 1997 10:28:46 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA07617 for linux-list; Tue, 17 Jun 1997 10:28:28 -0700
Received: from morgaine.engr.sgi.com (morgaine.engr.sgi.com [130.62.16.64]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA07519 for <linux@cthulhu.engr.sgi.com>; Tue, 17 Jun 1997 10:28:06 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by morgaine.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA14811 for <linux@morgaine.engr.sgi.com>; Tue, 17 Jun 1997 10:25:44 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA06764 for <linux@morgaine.engr.sgi.com>; Tue, 17 Jun 1997 10:25:44 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA25503
	for <linux@morgaine.engr.sgi.com>; Tue, 17 Jun 1997 10:25:36 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id MAA15321;
	Tue, 17 Jun 1997 12:10:12 -0500
Date: Tue, 17 Jun 1997 12:10:12 -0500
Message-Id: <199706171710.MAA15321@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: offer@sgi.com
CC: linux@morgaine.engr.sgi.com
In-reply-to: <9706170923.ZM15068@sgi.com> (offer@sgi.com)
Subject: Re: Good news: no more begging for HW
X-Windows: The Cutting Edge of Obsolescence.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> If someone takes the server, I'll try and get the clients libraries done
> (assuming that I can get remote access to a box).

I was interested in working on the X server for the SGI.  I already
did that for the Linux/SPARC, and I had a couple of questions to make,
so this seems like a good time to ask them (please note that I haven't
actually traced my SGI X server to see what it does).

1. On the SPARC, the X server mmap()s the frame buffer into its
   address space and uses a couple of ioctls to talk with the kernel
   (to ask the kernel to change the palette and the hardware cursor,
   on later versions, with got rid of that, and we just poked at the
   frame buffer control registers from the X server).

   How does this work on the SGI?  Is the video card just a thing that
   can be mapped into the X server address space?  

   If this is the case, getting the X11R6 server to work will just take
   a couple of days of coding.
   

2. What kind of acceleration features are available on the SGI
   machines?  The X11R6 server has hooks for different set of
   features, so for example, bitblit can be easily hacked into the X
   server. 

   But I imagine the SGI has more acceleration features that I can
   dream of.


3. How does OpenGL work on the SGIs?  Is the OpenGL engine embedded in
   the X server, or it is something that is present on the video card?
   
   I looked yesterday at a program called glxinfo, which led me to
   believe that applications may have some of the GL code linked in
   trough the libraries and the other part resides on the X server.

   So, in this case, what are the specs for what needs to be on the X
   server to be able to run OpenGL applications.


4. Would it be possible for a free software company to redistribute
   the SGI's X server?  In that case, we could concentrate on getting
   the IRIX emulation as good as possible and just use the SGI X
   server and let Red Hat/Debian/GNU ship the cd with that binary.


Cheers,
Miguel.
