Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA86749 for <linux-archive@neteng.engr.sgi.com>; Mon, 25 Jan 1999 11:36:47 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA05480
	for linux-list;
	Mon, 25 Jan 1999 11:36:03 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA26881
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 25 Jan 1999 11:36:01 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA08318
	for <linux@cthulhu.engr.sgi.com>; Mon, 25 Jan 1999 14:35:58 -0500 (EST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA05491;
	Mon, 25 Jan 1999 14:37:13 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 25 Jan 1999 14:37:13 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Chad Carlin <chad@sgi.com>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Precompiled 2.1.131 binaries.
In-Reply-To: <Pine.SGI.3.94.990124164811.4484A-100000@roctane.dallas.sgi.com>
Message-ID: <Pine.LNX.3.96.990125143208.21345N-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



Alright.  There might be other problems.

> Questions:
> 1) Is anyone else using an R4400?

I'd like to know that too.  I know it works on my R4600SC.  Any other
successes?

> 2) Does "VFS: Mounted root (ext2 filesystem) readonly" mean that I guessed 
>   the correct disk partition to use?

Probably... could you see what it reports for teh SCSI probe?

It should look something like:
DS1286 Real Time Clock Driver v1.0
streamable misc devices registered (keyb:150, gfx:148)
loop: registered device at major 7
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Jan 22 1999 at 16:43:04
scsi0 : SGI WD93
scsi : 1 host.
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: SEAGATE
ST31200N 
 Rev: 8640
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: SEAGATE
ST31230N 
 Rev: 0532
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 2, lun 0
scsi : detected 2 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 2077833 [1014 MB] [1.0
GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 2070235 [1010 MB] [1.0
GB]


Could you see what it reports for partitioning?  Mine says:
Partition check:
 sda: sda1 sda2 sda3 sda4
 sdb: sdb1 sdb2 sdb3

> 3) What does init= mean in "Kernel panic: No init found.  Try passing 
>   init= option to kernel"?

It says this because it can't find /sbin/init, because it can't find the
root filesystem.

> 4) This seems to suggest that the tty0 and tty1 have been discovered OK:
> 	SGI Zilog8530 serial driver version 1.00
> 	tty00 at 0xbfbd9838 (irq = 21) is a Zilog8530
> 	tty01 at 0xbfbd9830 (irq = 21) is a Zilog8530
>  Why then would I get this error message?
> 	Warning: unable to open an initial console
> 5) Could someone point me to where I can browse the source for this indy kernel?

Two reasons: there's no fielsystem that has /dev/console for you, and I
never built in serial console support.  I will, thuogh.

Could you look into the lack of disk problems first?  This is on an Indy,
right?


- Alex
