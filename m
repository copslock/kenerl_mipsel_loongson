Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id OAA125255 for <linux-archive@neteng.engr.sgi.com>; Thu, 22 Jan 1998 14:09:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA26323 for linux-list; Thu, 22 Jan 1998 14:04:47 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA26314 for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 14:04:45 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA24761
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 14:04:44 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id WAA11762; Thu, 22 Jan 1998 22:04:13 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xvVCP-0005FsC; Thu, 22 Jan 98 22:34 GMT
Message-Id: <m0xvVCP-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: wd33c93 errors.
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Thu, 22 Jan 1998 22:34:13 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.980122162527.21753E-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Jan 22, 98 04:50:16 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> repartitioned it from Irix, and mounted it as an EFS partition under Irix
> just fine.  That would seem to indicate that everything is alright with

Including rewriting it ?

> SCSI disk error : host 0 channel 0 id 6 lun 0 return code 2800000
> Current error sd08:21: sense key Hardware Error
> Additional sense indicates Address mark not found for id field
> scsidisk I/O error: dev 08:21, sector 10
> scsi0: MEDIUM ERROR on channel 0, id 6, lun 0, CDB: Request Sense 00 00 00
> 10 00

Thats the SCSI verbage for bad block

> Current error sd08:21: sense key Medium Error
> Additional sense indicates Recorded entity not found

no address mark generally

> scsidisk I/O error: dev 08:21, sector 108
> scsi : aborting command due to timeout : pid 17577, scsi0, id 6, lun 0
> Write (6) 12 bb a2 f4 00
> scsi0: Aborting connected command 17577 - stopping DMA - sending wd33c93
> ABORT command - flushing fifo - asr = 25, sr=ff, 16777215 bytes
> un-transferred (timeout=-1) - sending wd33c93 DISCONNECT command = asr=00,
> sr=18.
> 
> And the whole thing is hung, hard.

Thats a bug. 

> surprised as it seems to work just fine under Irix.

See if you can rewrite every sector of it under Irix ..
