Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id VAA06678 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Sep 1997 21:59:40 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA27340 for linux-list; Thu, 11 Sep 1997 21:59:03 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA27335 for <linux@cthulhu.engr.sgi.com>; Thu, 11 Sep 1997 21:59:01 -0700
Received: from b1mcast13.esd.sgi.com (gate-b1mcast13.esd.sgi.com [150.166.111.8]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id VAA11371 for <linux@fir.engr.sgi.com>; Thu, 11 Sep 1997 21:59:00 -0700
Received: by b1mcast13.esd.sgi.com (940816.SGI.8.6.9/950213.SGI.AUTOCF)
	 id VAA05184; Thu, 11 Sep 1997 21:59:00 -0700
Date: Thu, 11 Sep 1997 21:59:00 -0700
From: rtray@b1mcast13.esd.sgi.com (Robert Tray)
Message-Id: <199709120459.VAA05184@b1mcast13.esd.sgi.com>
To: linux@fir.engr.sgi.com, Miguel de Icaza <miguel@nuclecu.unam.mx>
Subject: Re:  Linux/SGI /dev/opengl magic ioctl
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>    From: Miguel de Icaza <miguel@nuclecu.unam.mx>
>    
>    
>    Hello guys,
>    
>       Ok, 2 questions 2 for tonight :-).
>    
>       Ok, I am getting close, just out of curiosity, what does the ioctl
>    cmd=1 do on the /dev/opengl device?  
>    
>       If the ioctl does not return 3, the X server complains.  Right now
>    I have this nice piece of code in the graphics driver:
>    
>    	switch (cmd){
>    		...
>    
>    	case 1:
>    		return 3;
>    		...
>    	}

This is basically a version check.  1 == GFX_SYNC which is supposed
to return a number which the kernel gfx driver and the Xserver agree
is the current version.  (The version you have is 3)

>        Second question: what does the GFX_LABEL ioctl do on the
>    /dev/opengl device?  I am missing this one in my implementation.
>    

The X server sends down the ":display.screen_number".  I don't see
the kernel doing anything with it.

Robert Tray
