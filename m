Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id SAA66087 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Sep 1997 18:45:19 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA23365 for linux-list; Wed, 17 Sep 1997 18:44:51 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA23361 for <linux@cthulhu.engr.sgi.com>; Wed, 17 Sep 1997 18:44:50 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id SAA17842 for <linux@fir.engr.sgi.com>; Wed, 17 Sep 1997 18:44:49 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA23351 for <linux@fir.engr.sgi.com>; Wed, 17 Sep 1997 18:44:48 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA03143
	for <linux@fir.engr.sgi.com>; Wed, 17 Sep 1997 18:44:47 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id UAA12189;
	Wed, 17 Sep 1997 20:34:42 -0500
Date: Wed, 17 Sep 1997 20:34:42 -0500
Message-Id: <199709180134.UAA12189@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@fir.engr.sgi.com
Subject: Linux/SGI Xsgi server: /dev/opengl ioctl NG1_SETDISPLAYMODE
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

   IRIX Xsgi server is now clearing the screen -and crashing since I
do not have a mouse driver yet, I am quickly coding the iDev mouse
driver now-.

   But while I am doing this, I would like to ask the list about
another ioctl that the X server is issuing: the NG1_SETDISPLAYMODE, it
is being called like this:

	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 0, 0xda0080 });
	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 1, 0xda0100 });
	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 2, 0xda0488 });
	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 3, 0xda0490 });
	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 4, 0xda0498 });
	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 5, 0xda04a0 });
	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 6, 0xda0500 });
	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 7, 0xda0800 });
	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 8, 0xda0900 });
	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 9, 0xda0d00 });
	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 0xa, 0xda0e00 });
	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 0xb, 0x4ac });

    Where the structure is { int wid;  unsigned int mode }.

    Can someone tell me what the newport driver on the IRIX kernel is
doing with these calls?

    There is also another intersesting ioctl done later:
NG1_SETGAMMARAMP0, this one takes 256 reds, 256 greens and 256 blues
that I assume I have to load, do they go directly to the xmap9 lookup
table?

Thanks in advance,
Miguel.
