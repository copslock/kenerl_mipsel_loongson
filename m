Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id SAA04302; Mon, 14 Jul 1997 18:57:57 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA20023 for linux-list; Mon, 14 Jul 1997 18:57:12 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA19951 for <linux@cthulhu.engr.sgi.com>; Mon, 14 Jul 1997 18:56:58 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA21748
	for <linux@relay.engr.SGI.COM>; Mon, 14 Jul 1997 18:04:04 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id UAA31135;
	Mon, 14 Jul 1997 20:02:12 -0500
Date: Mon, 14 Jul 1997 20:02:12 -0500
Message-Id: <199707150102.UAA31135@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@cthulhu.engr.sgi.com
Subject: Linux/SGI Questions for Monday.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

   Ok, I got my copy of the SGI documentation, and here I come with
lots of questions, so take a deep breath:

* Extra documentation
  
	It seems to me that some information on how the Newport works
	is decribed in a manual called 'Indy Graphics', Indy (TM)
	Technical Report, Ver 1.0, 1993.  

	I would love to get a copy of this document if at all
	possible. 

	The 'Display Control Bus Specification' would also be handy.

	The VC2 documentation suggests the later may be available on:
	nexus:/d/newport/asics

* Colors and the newport.

  ** Using 24-bit mode

	For some reason, I am not getting the colors I want on the
	screen.  

	I have tried to use the RGBA (32 bit) mode instead of loading
	the palette and using the color-indexed colors for drawing
	simple things on the screen without much success.

	Here is what I am doing:
		Set RGMMODE to 1 in the DRAWMODE1 register (this is
		supposed to use the colors loaded in COLORI).

		Set the PLANES to R/W RGBA planes
		Set the DRAWDEPTH to 24 bits.

	It still seems to be using the color pallette that IRIX loaded
	for me.

  ** Slope Red/Green/Blue.

	I could not find any reference to the use of these registers.
	Nor what are they supposed to do in the documentation.  

  ** PUP

	What in the world is a PUP?  It is some kind of plane 
* Clipping and Masking

	Could someone transcribe me the last paragraph from page 26
	of the "Preliminary REX3 sepecification".  The copy I got is
	offseted in this region, and thus did not make into my copy.

* Context switching the graphics context.

	Is there any way to stop the currently executing REX3 command
	so that I can save the graphics context.  

	Or should I just assume that saving the context and letting
	the REX3 finish the command even if we jump and do some other
	stuff that restoring the context will do the right thing?

Ok, I am now going to keep playing with the newport now :-)

Cheers,
Miguel.
