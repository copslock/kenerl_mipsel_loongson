Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA08961; Mon, 23 Jun 1997 21:15:52 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA12404 for linux-list; Mon, 23 Jun 1997 21:15:32 -0700
Received: from refugee.engr.sgi.com (refugee.engr.sgi.com [150.166.61.22]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA12399; Mon, 23 Jun 1997 21:15:29 -0700
Received: from refugee.engr.sgi.com (localhost [127.0.0.1]) by refugee.engr.sgi.com (970321.SGI.8.8.5/970502.SGI.AUTOCF) via ESMTP id VAA09580; Mon, 23 Jun 1997 21:15:29 -0700 (PDT)
Message-Id: <199706240415.VAA09580@refugee.engr.sgi.com>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Keyboard/Mouse drivers on SGI 
In-reply-to: Message from miguel@nuclecu.unam.mx of 23 Jun 1997 20:20:03 CDT
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Jun 1997 21:15:29 -0700
From: Steve Alexander <sca@refugee.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza <miguel@nuclecu.unam.mx> writes:
>   I see that the Xsgi server uses /dev/input/mouse and
>/dev/output/keyboard.  I can see from par's output that it does some
>STREAMS ioctls it I_PUSH'es something (I am not even remotely familiar
>to STREAMS, so I dunno what those I_PUSHes do).

I am not the best person to explain this, but my understanding is that the
keyboard and mouse (or spaceball, etc...) are linked (I_LINKed) under a driver
called 'shmiq,' which is the shared-memory event queue driver.  This driver
takes STREAMS data from the underlying devices and converts it into some sort
of standard event queue.  This allows events to be given to the X server in a
standard format, and I believe that this is done by pinning memory in the
X server and then copying events into this memory; I have no idea what happens
if the server doesn't respond fast enough.

My guess is that /dev/input/{keyboard,mouse} are both some sort of standard
serial port driver and that the modules I_PUSHed on top are what interpret the
low-level keyboard/mouse protocols.

SCO use a similar approach; their driver is called 'ev' if I remember
correctly.

So, if my theory is correct, what I'd expect to see is:

	mfd = open /dev/input/mouse
	I_PUSH mfd "mouse"
	kfd = open /dev/input/keyboard
	I_PUSH kfd "keyboard"

	sfd = open /dev/shmiq
	I_LINK sfd mfd
	I_LINK sfd kfd

More than that, I don't know.

-- Steve
