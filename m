Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id JAA30428 for <linux-archive@neteng.engr.sgi.com>; Fri, 12 Sep 1997 09:51:57 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA28003 for linux-list; Fri, 12 Sep 1997 09:50:51 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA27995 for <linux@cthulhu.engr.sgi.com>; Fri, 12 Sep 1997 09:50:50 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA23407; Fri, 12 Sep 1997 09:50:45 -0700
Date: Fri, 12 Sep 1997 09:50:45 -0700
Message-Id: <199709121650.JAA23407@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: linux@fir.engr.sgi.com
Subject: Re: Linux/SGI /dev/opengl magic ioctl 
In-Reply-To: <199709120348.WAA03611@athena.nuclecu.unam.mx>
References: <199709120348.WAA03611@athena.nuclecu.unam.mx>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza writes:
 > 
 > Hello guys,
 > 
 >    Ok, 2 questions 2 for tonight :-).
 > 
 >    Ok, I am getting close, just out of curiosity, what does the ioctl
 > cmd=1 do on the /dev/opengl device?  
 > 
 >    If the ioctl does not return 3, the X server complains.  Right now
 > I have this nice piece of code in the graphics driver:
 > 
 > 	switch (cmd){
 > 		...
 > 
 > 	case 1:
 > 		return 3;
 > 		...
 > 	}
 >    
 >     which is not exactly what I would like to have, so any comments
 > are appreciated.

      It turns out that is pretty much what the graphics driver is doing
in IRIX:

	        case GFX_SYNC :
		{
			*rvalp = GFX_SYNC_VALUE;
			goto out;
		}

For GL (not OpenGL), if the process is an sproc (a process sharing and
address space and file descriptors with a parent or siblings), the driver
acquires a semaphore before doing an ioctl and releases it afterwards.
For OpenGL, this ioctl does not really do anything at all.  

 >     Second question: what does the GFX_LABEL ioctl do on the
 > /dev/opengl device?  I am missing this one in my implementation.

It copies GFX_INFO_LABEL_SIZE (16) bytes from the argument (a char *) to
the label field of the gfx_info struct for the graphics device.  The label
field is the choice of the current owner of the device, so it is not really
significant.  The /usr/gfx/gfxinfo command can print the gfx_info structure
for the local device.
