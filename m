Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA78371 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Mar 1999 15:50:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA02003
	for linux-list;
	Fri, 26 Mar 1999 15:49:36 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id PAA52501;
	Fri, 26 Mar 1999 15:49:33 -0800 (PST)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA26663; Fri, 26 Mar 1999 15:49:32 -0800
Date: Fri, 26 Mar 1999 15:49:32 -0800
Message-Id: <199903262349.PAA26663@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Help needed to solve SCSI problem
In-Reply-To: <19990327002321.A3539@alpha.franken.de>
References: <19990327002321.A3539@alpha.franken.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thomas Bogendoerfer writes:
 > I'm now total stuck with the remaining SCSI problem, and need some help.
 > 
 > I have a really broken cdrom drive. With this cdrom I'm able produce a
 > scsi timeout, which will cause a hang of the complete machine. I've
 > traced the problem a little bit further, and detected, that I get
 > interrupts on interrupt vector 0 (it's named VECTOR_GIO0 in the Irix
 > header files). I always see 17 irq 0 then the machine hangs completly.
 > 
 > Please, could someone tell what this interrupt means, so I can either
 > solve it by servicing the interrupt the right way or avoid it by doing 
 > something else ?

      I believe that is the two bits:

#define EXTIO_HPC3_BUSERR		0x0010
#define EXTIO_SG_STAT_0			0x0001

HPC3_BUSERR means that the HPC3 got a bus error reading from memory.
The driver is probably broken and giving bad commands to the HPC3.
You should be able to find the error address in the GIO_ERR_ADDR register:

#define	GIO_ERR_ADDR	0x1fa000f4	/* GIO error address (w, ro) */

(0xbfa000f4 as a K1SEG address).
