Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA67495 for <linux-archive@neteng.engr.sgi.com>; Fri, 8 May 1998 04:43:19 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA22068665
	for linux-list;
	Fri, 8 May 1998 04:42:46 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA21431714
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 8 May 1998 04:42:45 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id EAA08993
	for <linux@cthulhu.engr.sgi.com>; Fri, 8 May 1998 04:42:44 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id HAA21782;
	Fri, 8 May 1998 07:42:26 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 8 May 1998 07:42:26 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Oliver Frommel <oliver@aec.at>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: rs_cons_hook() ?
In-Reply-To: <Pine.LNX.3.96.980508082131.254C-100000@web.aec.at>
Message-ID: <Pine.LNX.3.95.980508073709.20848F-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Fri, 8 May 1998, Oliver Frommel wrote:
> > ... and the final link complains that it can't find rs_cons_hook defined
> > anywhere.  That's because I'm not compiling in
> > drivers/sgi/char/sgiserial.c (which has other linking errors, and is
> > another problem, but you should be able to compile in console support
> > without having to have compiled in SGI serial support).

> you need SGI serial support (sgi/char/sgiserial.c) for the serial console 
> support ..

Except I don't have CONFIG_SERIAL_CONSOLE in my .config ... see below.
I'm pretty sure my recommended change is correct.

I am going to have a look at my sgiserial.c compile problems, too.

- Alex

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
# CONFIG_SERIAL is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_PRINTER is not set
# CONFIG_MOUSE is not set
CONFIG_UMISC=y
# CONFIG_SGI_GRAPHICS is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_APM is not set
# CONFIG_WATCHDOG is not set
# CONFIG_RTC is not set
# CONFIG_VIDEO_DEV is not set
# CONFIG_NVRAM is not set
# CONFIG_JOYSTICK is not set
# CONFIG_MISC_RADIO is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# SGI Character devices
#
# CONFIG_SGI_SERIAL is not set

#
# Kernel hacking
#
CONFIG_CROSSCOMPILE=y
# CONFIG_REMOTE_DEBUG is not set
# CONFIG_PROFILE is not set
