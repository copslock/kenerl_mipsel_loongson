Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA16647; Tue, 24 Jun 1997 12:05:01 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA20810 for linux-list; Tue, 24 Jun 1997 12:04:35 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA20804; Tue, 24 Jun 1997 12:04:32 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id MAA25297; Tue, 24 Jun 1997 12:04:31 -0700
Date: Tue, 24 Jun 1997 12:04:31 -0700
Message-Id: <199706241904.MAA25297@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Steve Alexander <sca@refugee.engr.sgi.com>
Cc: Miguel de Icaza <miguel@nuclecu.unam.mx>, linux@cthulhu.engr.sgi.com
Subject: Re: Keyboard/Mouse drivers on SGI 
In-Reply-To: <199706240415.VAA09580@refugee.engr.sgi.com>
References: <199706240415.VAA09580@refugee.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Steve Alexander writes:
...
 > My guess is that /dev/input/{keyboard,mouse} are both some sort of standard
 > serial port driver and that the modules I_PUSHed on top are what interpret the
 > low-level keyboard/mouse protocols.
 > 
 > SCO use a similar approach; their driver is called 'ev' if I remember
 > correctly.
 > 
 > So, if my theory is correct, what I'd expect to see is:
 > 
 > 	mfd = open /dev/input/mouse
 > 	I_PUSH mfd "mouse"
 > 	kfd = open /dev/input/keyboard
 > 	I_PUSH kfd "keyboard"
 > 
 > 	sfd = open /dev/shmiq
 > 	I_LINK sfd mfd
 > 	I_LINK sfd kfd
 > 
 > More than that, I don't know.

     There are drivers for the actual devices, such as pckm on Indy,
to operate the actual keyboard controller, and then there are higher
level streams modules, such as pckbd and pcmouse on Indy, which know
about the keyboard and mouse devices (and other devices, such as
tablets).  The IRIX pckeyboard(7) and pcmouse(7) man pages document the
supported keyboards and mice.  As far as I know, the interface to the
streams modules is not well-documented, as it is used directly only
by the X server and the textport driver.  

    For the time being, I recommend that you go with the usual linux
driver for PC keyboard/mouse controller, which the Indy hardware 
emulates.
