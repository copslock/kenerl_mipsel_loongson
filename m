Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA05840; Mon, 30 Jun 1997 10:29:43 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA21962 for linux-list; Mon, 30 Jun 1997 10:29:10 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA21923 for <linux@cthulhu.engr.sgi.com>; Mon, 30 Jun 1997 10:29:08 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA00756
	for <linux@cthulhu.engr.sgi.com>; Mon, 30 Jun 1997 10:27:30 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id MAA06962;
	Mon, 30 Jun 1997 12:12:50 -0500
Date: Mon, 30 Jun 1997 12:12:50 -0500
Message-Id: <199706301712.MAA06962@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@cthulhu.engr.sgi.com
Subject: newport misc questions
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

   Since an X server that uses the block-fill command for drawing
patterns is not the fastest thing you could be a witness of, I came up
with a new set of questions for all of you:

  1. How can I use the newport stipple mode registers and the 32-bit
     stipple pattern register to draw thingies in the screen?

  2. If you have any documentation on what the operations for the
     drawmode0 register are, I would appreciate a copy of it
     (actually, I would appreciate the whole doc :-)

  3. How can I load the color pallete on the newport?  I have the
     feeling that the newport supports an 8-bit+pallete mode and a
     24-bit true-color mode, which leds to the next question.

  4. How can I command the newport to draw on the 8 bit plane or to
     draw on the 24-bit plane?  That is, assuming I haven't been
     smoking chemicals and that there really are 8 and 24 bit planes.

Cheers,
Miguel.
