Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA81231 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Mar 1999 16:45:29 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA77535
	for linux-list;
	Fri, 26 Mar 1999 16:44:27 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA56260
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 26 Mar 1999 16:44:25 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA07461
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Mar 1999 16:44:24 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10QhFZ-0027UKC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sat, 27 Mar 1999 01:46:57 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10QhBl-002OssC; Sat, 27 Mar 99 01:43 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id BAA04196;
	Sat, 27 Mar 1999 01:39:18 +0100
Message-ID: <19990327013918.A4184@alpha.franken.de>
Date: Sat, 27 Mar 1999 01:39:18 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Help needed to solve SCSI problem
References: <19990327002321.A3539@alpha.franken.de> <199903262349.PAA26663@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199903262349.PAA26663@fir.engr.sgi.com>; from William J. Earl on Fri, Mar 26, 1999 at 03:49:32PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Mar 26, 1999 at 03:49:32PM -0800, William J. Earl wrote:
> #define EXTIO_HPC3_BUSERR		0x0010
> #define EXTIO_SG_STAT_0			0x0001

ahh, another register I didn't know.

> HPC3_BUSERR means that the HPC3 got a bus error reading from memory.
> The driver is probably broken and giving bad commands to the HPC3.
> You should be able to find the error address in the GIO_ERR_ADDR register:

I've checked the MC registers cstat, gstat, the HPC3 registers intstat, 
instat.bug, bus error and the extio register. All of them are zero. Any 
other idea ?

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
