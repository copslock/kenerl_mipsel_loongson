Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id MAA140136; Sat, 9 Aug 1997 12:01:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA02994 for linux-list; Sat, 9 Aug 1997 12:01:21 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA02970; Sat, 9 Aug 1997 12:01:16 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA03571; Sat, 9 Aug 1997 12:01:15 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id OAA14144;
	Sat, 9 Aug 1997 14:00:08 -0500
Date: Sat, 9 Aug 1997 14:00:08 -0500
Message-Id: <199708091900.OAA14144@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: jwiede@blammo.engr.sgi.com
CC: linux@cthulhu.engr.sgi.com, ralf@mailhost.uni-koblenz.de
In-reply-to: <9708081540.ZM26801@blammo.engr.sgi.com>
	(jwiede@blammo.engr.sgi.com)
Subject: Re: Linux GGI and Linux/SGI
X-Mexico: Este es un pais de orates, un pais amateur.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> I'm not so attached to the notion of GGI as much as for gfx
> having an in-kernel-space presence in Linux (Linux/SGI is
> going to need this, as I suspect is any Linux that attempts
> hardware acceleration of OpenGL or other similar APIs).

What does 'gfx' mean in this context?

Linux/SGI currently supports direct rendering (modulo the fact that I
have not written the code to context switch the card state, which
should be trivial to do).

With direct rendering you do not need any graphics acceleration code
in the kernel, you just need to implement the smart tricks the SGI
graphics people came up with and implement some small kernel support
for making the direct rendering applications and the X server work
together. 

Check the www.linux.sgi.com page for a pointer to Mark's paper on this
matter, but the idea is that we let any application that needs to talk
directly to the hardware to map the video card registers into his
address space.  We already have the code that implements the lazy
context switches for the video card [1] and bits of the resource
manager.

The code we will have on Linux/SGI is far better for the SGI case than
what the GGI people have now and as a side beneffit it will let us run
stock Irix Xsgi server.

[1] the mmu code, not the actual switch, I will do that next, as I
mentioned before, 
