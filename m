Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id TAA75183 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Sep 1997 19:03:57 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA27289 for linux-list; Wed, 17 Sep 1997 19:03:32 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA27280 for <linux@cthulhu.engr.sgi.com>; Wed, 17 Sep 1997 19:03:30 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id TAA17980; Wed, 17 Sep 1997 19:03:28 -0700
Date: Wed, 17 Sep 1997 19:03:28 -0700
Message-Id: <199709180203.TAA17980@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: linux@fir.engr.sgi.com
Subject: Re: Linux/SGI Xsgi server: /dev/opengl ioctl NG1_SETDISPLAYMODE
In-Reply-To: <199709180134.UAA12189@athena.nuclecu.unam.mx>
References: <199709180134.UAA12189@athena.nuclecu.unam.mx>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza writes:
 > 
 > Hello guys,
 > 
 >    IRIX Xsgi server is now clearing the screen -and crashing since I
 > do not have a mouse driver yet, I am quickly coding the iDev mouse
 > driver now-.
 > 
 >    But while I am doing this, I would like to ask the list about
 > another ioctl that the X server is issuing: the NG1_SETDISPLAYMODE, it
 > is being called like this:
 > 
 > 	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 0, 0xda0080 });
 > 	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 1, 0xda0100 });
 > 	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 2, 0xda0488 });
 > 	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 3, 0xda0490 });
 > 	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 4, 0xda0498 });
 > 	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 5, 0xda04a0 });
 > 	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 6, 0xda0500 });
 > 	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 7, 0xda0800 });
 > 	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 8, 0xda0900 });
 > 	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 9, 0xda0d00 });
 > 	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 0xa, 0xda0e00 });
 > 	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 0xb, 0x4ac });
 > 
 >     Where the structure is { int wid;  unsigned int mode }.
 >
 >     Can someone tell me what the newport driver on the IRIX kernel is
 > doing with these calls?

     After waiting for the rex3 FIFO to drain, and the the xmap9 FIFO
to not be full, it sets the xmap9 mode register for the given "wid":

 	xmap9SetModeReg( rex3, wid, displaymode, ng1_video_timing[bd->boardnum]->cfreq ); 
where

#define xmap9SetModeReg(rex,modereg,data24,cfreq) 			\
	if (cfreq > 119 )						\
	    rex->set.dcbmode =  DCB_XMAP_ALL |  XM9_CRS_MODE_REG_DATA | \
                        DCB_DATAWIDTH_4 | W_DCB_XMAP9_PROTOCOL;	    	\
	else if (cfreq > 59) \
	    rex->set.dcbmode =  DCB_XMAP_ALL |  XM9_CRS_MODE_REG_DATA | \
                        DCB_DATAWIDTH_4 | WSLOW_DCB_XMAP9_PROTOCOL;    	\
	else \
	    rex->set.dcbmode =  DCB_XMAP_ALL |  XM9_CRS_MODE_REG_DATA | \
                        DCB_DATAWIDTH_4 | WAYSLOW_DCB_XMAP9_PROTOCOL;  	\
        rex->set.dcbdata0.byword = ((modereg) << 24) | (data24 & 0xffffff)

 >     There is also another intersesting ioctl done later:
 > NG1_SETGAMMARAMP0, this one takes 256 reds, 256 greens and 256 blues
 > that I assume I have to load, do they go directly to the xmap9 lookup
 > table?

       It sets the address register for the BT445 RAMDAC to 0, and then
then, for each RGB triple, does 

#define Bt445SetRGB( rex3, r, g, b ) \
	rex3->set.dcbdata0.byword = ( (r) << 24 ) | ( (g) << 16 ) | ( (b) << 8 )

Before setting the address and before storing each RGB triple, it does

#define BFIFOWAIT(rex) 	while ((rex)->p1.set.configmode & BFIFO);

to avoid getting a FIFO overrun.  
