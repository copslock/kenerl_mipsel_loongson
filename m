Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id XAA89760 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Sep 1997 23:03:46 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA00068 for linux-list; Wed, 17 Sep 1997 23:03:19 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA00064 for <linux@cthulhu.engr.sgi.com>; Wed, 17 Sep 1997 23:03:18 -0700
Received: from b1mcast13.esd.sgi.com (gate-b1mcast13.esd.sgi.com [150.166.111.8]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id XAA18446; Wed, 17 Sep 1997 23:03:15 -0700
Received: by b1mcast13.esd.sgi.com (940816.SGI.8.6.9/950213.SGI.AUTOCF)
	 id XAA09581; Wed, 17 Sep 1997 23:03:15 -0700
Date: Wed, 17 Sep 1997 23:03:15 -0700
From: rtray@b1mcast13.esd.sgi.com (Robert Tray)
Message-Id: <199709180603.XAA09581@b1mcast13.esd.sgi.com>
To: wje@fir.engr.sgi.com, Miguel de Icaza <miguel@nuclecu.unam.mx>
Subject: Re: Linux/SGI Xsgi server: /dev/opengl ioctl NG1_SETDISPLAYMODE
Cc: linux@fir.engr.sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


>    From: "William J. Earl" <wje@fir.engr.sgi.com>
>    
>    Miguel de Icaza writes:
>     > 
>     >    But while I am doing this, I would like to ask the list about
>     > another ioctl that the X server is issuing: the NG1_SETDISPLAYMODE, it
>     > is being called like this:
>     > 
>     > 	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 0, 0xda0080 });
...
>     > 	ioctl (/dev/opengl, NG1_SETDISPLAYMODE, { 0xb, 0x4ac });
>     > 
>     >     Where the structure is { int wid;  unsigned int mode }.
>     >
>     >     Can someone tell me what the newport driver on the IRIX kernel is
>     > doing with these calls?
>    
>         After waiting for the rex3 FIFO to drain, and the the xmap9 FIFO
>    to not be full, it sets the xmap9 mode register for the given "wid":
>    
>     	xmap9SetModeReg( rex3, wid, displaymode, ng1_video_timing[bd->boardnum]->cfreq ); 
>    where

The XMAP9 controls how the frame buffer pixels are interpreted and displayed
to the monitor.  That is the frame buffer may be 24 bits deep but a certain
window may only be rendering 8 bits of PseudoColor (Color Index) while another
window is rendering two buffers of TrueColor (RGB) split 12+12.  It's also
used to control which of the multiple colormaps is used to index the Pseudo-
Color pixels.  The X server is typically just running 8 bit PseudoColor while
most GL programs run 12+12 RGB Double Buffer.

The X server presets a certain number of Window IDs (wid) to be certain standard
display modes ( eg. 1==Single buffer color index, 2==double buffer color index,
3==single buffer RGB, etc...).  The other half of this setup involves a telling
the backend hardware (VC2) which pixels use which Window ID (actually it's more
frequently called Display ID (DID) in the last few years).  The X server talks
directly to VC2 to load a DID table which describes which XMAP9 DID/WID index
every single pixel is using.  (I hope that poorly worded sentence made sense.)

The good news is that if you don't care about running GL programs in a separate
display mode then you only have to set one DID entry in the XMAP and tell VC2
that the whole screen uses the same index into XMAP.




>     >     There is also another intersesting ioctl done later:
>     > NG1_SETGAMMARAMP0, this one takes 256 reds, 256 greens and 256 blues
>     > that I assume I have to load, do they go directly to the xmap9 lookup
>     > table?
>    
>           It sets the address register for the BT445 RAMDAC to 0, and then
>    then, for each RGB triple, does 
>    
>    #define Bt445SetRGB( rex3, r, g, b ) \
>    	rex3->set.dcbdata0.byword = ( (r) << 24 ) | ( (g) << 16 ) | ( (b) << 8 )
>    
>    Before setting the address and before storing each RGB triple, it does
>    
>    #define BFIFOWAIT(rex) 	while ((rex)->p1.set.configmode & BFIFO);
>    
>    to avoid getting a FIFO overrun.  

The BrookTree 445 RAMDAC is that last chip the pixels go through on their way
out to the monitor.  It contains the gamma ramp to adjust the pixels for the
monitors non-linearity.

For Newport graphics there are two FIFOs.  One FIFO paces access to the
REX3 chip.  All the "back end" chips are accessed via an 8 bit Display Control
Bus (DCB) which is accessed throught hte REX3 dcbdata & dcbmode.  You can
do 64 bit writes to dcbdata but they get sent 8 bits at a time across the DCB.
So you need a second FIFO (BFIFO) to pace access to the back end chips.
Anyway that's the explanation for the BFIFOWAIT.




>    Another question regarding the Newport:
>    
>    >      After waiting for the rex3 FIFO to drain, and the the xmap9 FIFO
>    > to not be full, it sets the xmap9 mode register for the given "wid":
>    > 
>    > 	  xmap9SetModeReg( rex3, wid, displaymode, ng1_video_timing[bd->boardnum]->cfreq ); 
>    
>    If the newport registers are available to the userland application,
>    why the X server does not directly call those routines instead of
>    relying on the kernel to perform them?  Is it a convention that
>    applications should only touch the rex3 registers and not attempt to
>    program any of the other chips on the dcb?

The less that user code touches the DCB the better.  But truthfully the
biggest reason that the X server calls the kernel to set the XMAP regs
is historical.  In previous architectures those types of registers couldn't
be set by the X server and required and ioctl.  So one piece of code tends
to look like the piece that it was copied from...  However those registers
are only preset at initialization and not touched again by the server.  They
are touched frequently after that by the kernel at the request of GL and
to do swapbuffers.  So as far as the X server is concerned performance is
not a problem for those registers and it's best to avoid touching the DCB
when you can.

>    It would make sense since the graphics context switching would not
>    involve the kernel peeking at the chips on the dcb what their context
>    is and then the pain of restoring this.  

Yeah, we actually strongly suspected that graphics context switches while
the X server was accessing the DCB was causing the graphics to hang.  We
narrowed down the times that the X server accesses the DCB and that helped.

Robert Tray
