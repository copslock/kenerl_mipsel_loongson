Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA23036; Mon, 23 Jun 1997 18:33:50 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA22211 for linux-list; Mon, 23 Jun 1997 18:33:33 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA22206 for <linux@cthulhu.engr.sgi.com>; Mon, 23 Jun 1997 18:33:31 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA02193
	for <linux@relay.engr.SGI.COM>; Mon, 23 Jun 1997 18:33:18 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id UAA11492;
	Mon, 23 Jun 1997 20:20:03 -0500
Date: Mon, 23 Jun 1997 20:20:03 -0500
Message-Id: <199706240120.UAA11492@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@cthulhu.engr.sgi.com
Subject: Keyboard/Mouse drivers on SGI
X-Quote: If at first you don't succeed, redefine success.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

   More questions.

   I see that the Xsgi server uses /dev/input/mouse and
/dev/output/keyboard.  I can see from par's output that it does some
STREAMS ioctls it I_PUSH'es something (I am not even remotely familiar
to STREAMS, so I dunno what those I_PUSHes do).


    Can someone tell me if the X server does something interesting
with those ioctls (as the man page for the keyboard/mouse did not
mention anything interesting in this regard), or if it just reads from
those devices in raw mode and decodes the information itself?

   On the SPARC, the server puts the keyboard and the mouse in a
special mode (VUID mode) which makes the read(2) system call return
records instead of returning a stream of bytes (ie, the client and the
kernel agree to send information in structure-sized chunks).

   So, on the SPARC, those VUID records have all of the decoded
information ready for X server to use, no further decoding takes place
on the X server, the stuff is just put on the X servers's input queues
by just copying fields.  For example, in the mouse case, those VUID
registers come with the dx/dy information as well as the buttons
status all in a nicely packed record.
  
   Now, even if we have our own X server, I would like to make our X
server and Xsgi use the same drivers and mechanisms for input (just to
be able one day to run a stock Xsgi server on Linux, for those
machines where a free X11R6 derivative will not work).  I mean, I do
not really care where the input decoding takes place in the server or
in the kernel, I can go ahead and use a quickly hacked Sun-like VUID
to do this in the meantime.

Cheers,
Miguel.

   
