Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id MAA939388; Fri, 25 Jul 1997 12:19:35 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA01663 for linux-list; Fri, 25 Jul 1997 12:18:44 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA01515; Fri, 25 Jul 1997 12:18:03 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA13798; Fri, 25 Jul 1997 12:17:59 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id OAA11145;
	Fri, 25 Jul 1997 14:16:11 -0500
Date: Fri, 25 Jul 1997 14:16:11 -0500
Message-Id: <199707251916.OAA11145@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: alan@lxorguk.ukuu.org.uk
CC: jwiede@blammo.engr.sgi.com, linux@cthulhu.engr.sgi.com
In-reply-to: <m0wrgCw-0005FlC@lightning.swansea.linux.org.uk>
	(alan@lxorguk.ukuu.org.uk)
Subject: Re: Possible X solutions.
X-Unix: is friendly, it is just selective about who its friends are.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> > Has anyone considered perhaps partnering with either Metrolink
> > or Xi Graphics (makers of Accelerated-X) and having _them_ be
> > the providers of the X server for SGI?
> 
> If there's not going to be a free X server for the SGI then Ariel
> can keep the machine...

No need for that.  I got the time to read all of the documentation on
the newport graphics.  I am da-newport-man now :-).  There is only
*one* thing I have not figured out and which is rather important:

   How can I DMA from the video card to the host memory?

I know I can set the bit that does the DMA, but I have not found how
to setup the DMA transfer to the host memory, so if a SGI graphics
hacker is reading this, I would appreciate a little hint with this. 

We will have a kick-ass X server once I start coding it (I am just
finishing the shared memory input queue driver now which is making me
suffer a bit).  

When I was reading the X11R6 porting guide there were a lot of hooks
that did not make sense.  Then I read the Mark Kilgard's paper on
direct-rendering and got the newport specs, now everything makes
sense.  I am possitively convinced that all the X speed improvements
in the IRIX server are cleanly separated and do not require changes to
the main X sample server from MIT.

So, we can get an X server pretty easily that will match the power in
Xsgi (including direct rendering, I have most of this code written,
just the actual context-switch for the rex3 is missing, will get to
rex3 context switch once I get shmiq finished :-)

> B.  Gives us a venue by which SGI can provide optimized
>     versions of OpenGL for Linux/Intel.  This is what we
>     could bring to the table.

Well, the optimizations in SGI's OpenGL require some hardware support:
starting with the direct graphics kernel support, continuing with the
kernel rendering resource manager and then having hardware
acceleration in their video cards and all kind of graphic tricks to
improve performance.

I strongly  recomend reading Mark Kilgard's papers on how they use
the hardware features of the SGI machines to make graphics scream. 

> C.  Lends additional credibility to the Linux/SGI port.

Commercial applications for Linux/SGI will appear at some point, but
rememeber, the ideal world is made up of machines running free
systems. 

Cheers,
Miguel
