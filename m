Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id WAA06852 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Sep 1997 22:02:13 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA19243 for linux-list; Thu, 11 Sep 1997 20:58:03 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA19216 for <linux@cthulhu.engr.sgi.com>; Thu, 11 Sep 1997 20:57:57 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id UAA11254 for <linux@fir.engr.sgi.com>; Thu, 11 Sep 1997 20:57:51 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA19191 for <linux@fir.engr.sgi.com>; Thu, 11 Sep 1997 20:57:46 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA09685
	for <linux@fir.engr.sgi.com>; Thu, 11 Sep 1997 20:57:44 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id WAA03611;
	Thu, 11 Sep 1997 22:48:59 -0500
Date: Thu, 11 Sep 1997 22:48:59 -0500
Message-Id: <199709120348.WAA03611@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@fir.engr.sgi.com
Subject: Linux/SGI /dev/opengl magic ioctl 
X-Windows: You'd better sit down.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

   Ok, 2 questions 2 for tonight :-).

   Ok, I am getting close, just out of curiosity, what does the ioctl
cmd=1 do on the /dev/opengl device?  

   If the ioctl does not return 3, the X server complains.  Right now
I have this nice piece of code in the graphics driver:

	switch (cmd){
		...

	case 1:
		return 3;
		...
	}
   
    which is not exactly what I would like to have, so any comments
are appreciated.

    Second question: what does the GFX_LABEL ioctl do on the
/dev/opengl device?  I am missing this one in my implementation.

    I am around 100 system calls far from getting a nice display on
Linux/SGI X. 

Cheers,
Miguel.
