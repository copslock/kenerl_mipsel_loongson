Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id NAA124781 for <linux-archive@neteng.engr.sgi.com>; Thu, 22 Jan 1998 13:53:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA22044 for linux-list; Thu, 22 Jan 1998 13:50:13 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA22014 for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 13:50:11 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA18760
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 13:50:08 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id QAA07936
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 16:50:16 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 22 Jan 1998 16:50:16 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: wd33c93 errors.
Message-ID: <Pine.LNX.3.95.980122162527.21753E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I'm not sure, but I think there might be something wrong with the wd33c93
driver.

I have acquired through creative means a 700MB SCSI disk from work. I
repartitioned it from Irix, and mounted it as an EFS partition under Irix
just fine.  That would seem to indicate that everything is alright with
the hardware itself.

So, I go into Linux andd try to mke2fs it.  It seems to work for a bit,
then dies with something like:

SCSI disk error : host 0 channel 0 id 6 lun 0 return code 2800000
Current error sd08:21: sense key Hardware Error
Additional sense indicates Address mark not found for id field
scsidisk I/O error: dev 08:21, sector 10
scsi0: MEDIUM ERROR on channel 0, id 6, lun 0, CDB: Request Sense 00 00 00
10 00
Current error sd08:21: sense key Medium Error
Additional sense indicates Recorded entity not found
scsidisk I/O error: dev 08:21, sector 108
scsi : aborting command due to timeout : pid 17577, scsi0, id 6, lun 0
Write (6) 12 bb a2 f4 00
scsi0: Aborting connected command 17577 - stopping DMA - sending wd33c93
ABORT command - flushing fifo - asr = 25, sr=ff, 16777215 bytes
un-transferred (timeout=-1) - sending wd33c93 DISCONNECT command = asr=00,
sr=18.

And the whole thing is hung, hard.

I'd be willing to accept that my drive is unhealthy, but I'm a bit
surprised as it seems to work just fine under Irix.

Ideas?

- A

-- 
      Alex deVries          Run Linux on everything,
  System Administrator      run everything on Linux.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
